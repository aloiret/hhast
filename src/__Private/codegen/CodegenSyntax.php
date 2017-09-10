<?hh // strict
/**
 * Copyright (c) 2017, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the "hack" directory of this source tree. An additional
 * grant of patent rights can be found in the PATENTS file in the same
 * directory.
 *
 */

namespace Facebook\HHAST\__Private;

use type Facebook\HackCodegen\{
  CodegenClass,
  CodegenConstructor,
  CodegenMethod,
  HackBuilderValues
};

use namespace HH\Lib\{C, Str, Vec};

final class CodegenSyntax extends CodegenBase {
  public function generate(): void {
    $cg = $this->getCodegenFactory();

    $file = $cg->codegenFile($this->getOutputDirectory().'/Syntax.php');
    $file->setNamespace('Facebook\\HHAST');

    $blacklist = self::getHandWrittenSyntaxKinds();

    foreach ($this->getSchema()['AST'] as $syntax) {
      if (C\contains_key($blacklist, $syntax['kind_name'])) {
        continue;
      }
      $file->addClass($this->generateClass($syntax));
    }

    $file->save();
  }

  private function generateClass(Schema\TAST $syntax): CodegenClass {
    $cg = $this->getCodegenFactory();

    $class = $cg
      ->codegenClass($syntax['kind_name'])
      ->setIsFinal()
      ->setExtends('EditableSyntax')
      ->setConstructor($this->generateConstructor($syntax))
      ->addMethod($this->generateFromJSONMethod($syntax))
      ->addMethod($this->generateChildrenMethod($syntax))
      ->addMethod($this->generateRewriteMethod($syntax));

    foreach ($syntax['fields'] as $field) {
      $field = (string) $field['field_name'];
      $this->getTypeSpecForField($syntax, $field);
      $class
        ->addVar($cg
          ->codegenMemberVar('_'.$field)
          ->setType('EditableSyntax'))
        ->addMethod(
          $cg
            ->codegenMethod($field)
            ->setReturnType('EditableSyntax')
            ->setBodyf('return $this->_%s;', $field)
        )
        ->addMethod(
          $cg
            ->codegenMethod('with_'.$field)
            ->setReturnType('this')
            ->addParameter('EditableSyntax $value')
            ->setBody(
              $cg
                ->codegenHackBuilder()
                ->add('return new ')
                ->addMultilineCall(
                  'self',
                  Vec\map(
                    $syntax['fields'],
                    $inner ==> $inner['field_name'] == $field
                      ? '$value'
                      : '$this->_'.$inner['field_name'],
                  ),
                )
                ->getCode(),
            ),
        );
    }

    return $class;
  }

  private function generateConstructor(
    Schema\TAST $syntax,
  ): CodegenConstructor {
    $cg = $this->getCodegenFactory();

    $c = $cg->codegenConstructor();

    $body = $cg
      ->codegenHackBuilder()
      ->addLinef(
        'parent::__construct(%s);',
        var_export($syntax['type_name'], true),
      );

    foreach ($syntax['fields'] as $field) {
      $c->addParameterf('EditableSyntax $%s', $field['field_name']);
      $body->addLinef(
        '$this->_%s = $%s;',
        $field['field_name'],
        $field['field_name'],
      );
    }
    $c->setBody($body->getCode());

    return $c;
  }

  private function generateFromJSONMethod(Schema\TAST $syntax): CodegenMethod {
    $cg = $this->getCodegenFactory();

    $body = $cg->codegenHackBuilder();
    foreach ($syntax['fields'] as $field) {
      $body
        ->addf('$%s = ', $field['field_name'])
        ->addMultilineCall(
          'EditableSyntax::from_json',
          vec[
            sprintf(
              '/* UNSAFE_EXPR */ $json[\'%s_%s\']',
              $syntax['prefix'],
              $field['field_name'],
            ),
            '$position',
            '$source',
          ],
        )
        ->addLinef('$position += $%s->width();', $field['field_name']);
    }

    return $cg
      ->codegenMethod('from_json')
      ->setIsStatic()
      ->addParameter('array<string, mixed> $json')
      ->addParameter('int $position')
      ->addParameter('string $source')
      ->setReturnType('this')
      ->setBody(
        $body
          ->addMultilineCall(
            'return new self',
            Vec\map($syntax['fields'], $field ==> '$'.$field['field_name']),
          )
          ->getCode(),
      );
  }

  private function generateChildrenMethod(Schema\TAST $syntax): CodegenMethod {
    $cg = $this->getCodegenFactory();

    return $cg
      ->codegenMethod('children')
      ->setReturnType('KeyedTraversable<string, EditableSyntax>')
      ->setBody(
        $cg
          ->codegenHackBuilder()
          ->addLines(
            Vec\map(
              $syntax['fields'],
              $field ==> sprintf(
                'yield %s => $this->_%s;',
                var_export($field['field_name'], true),
                $field['field_name'],
              ),
            ),
          )
          ->getCode(),
      );
  }

  private function generateRewriteMethod(Schema\TAST $syntax): CodegenMethod {
    $cg = $this->getCodegenFactory();

    $fields = Vec\map($syntax['fields'], $field ==> $field['field_name']);

    return $cg
      ->codegenMethod('rewrite')
      ->setReturnType('EditableSyntax')
      ->addParameter('self::TRewriter $rewriter')
      ->addParameter('?Traversable<EditableSyntax> $parents = null')
      ->setBody(
        $cg
          ->codegenHackBuilder()
          ->addLine('$parents = $parents === null ? vec[] : vec($parents);')
          ->addLine('$child_parents = $parents;')
          ->addLine('$child_parents[] = $this;')
          ->addLines(
            Vec\map(
              $fields,
              $field ==> sprintf(
                '$%s = $this->_%s->rewrite($rewriter, $child_parents);',
                $field,
                $field,
              ),
            ),
          )
          ->addLine('if (')
          ->indent()
          ->addLines(
            Vec\map(
              $fields,
              $field ==> sprintf('$%s === $this->%s() &&', $field, $field),
            )
            |> (
              $lines ==> {
                $idx = C\last_keyx($lines);
                $lines[$idx] = Str\strip_suffix($lines[$idx], ' &&');
                return $lines;
              }
            )($$),
          )
          ->unindent()
          ->addLine(') {')
          ->indent()
          ->addLine('$node = $this;')
          ->unindent()
          ->addLine('} else {')
          ->indent()
          ->add('$node = ')
          ->addMultilineCall(
            'new self',
            Vec\map($fields, $field ==> '$'.$field),
          )
          ->unindent()
          ->addLine('}')
          ->addLine('return $rewriter($node, $parents);')
          ->getCode(),
      );
  }

  private function getTypeSpecForField(
    Schema\TAST $syntax,
    string $field,
  ): shape('class' => string, 'nullable' => bool) {
    $key = sprintf(
      '%s.%s_%s',
      $syntax['description'],
      $syntax['prefix'],
      $field,
    );
    $specs = INFERRED_RELATIONSHIPS;
    if (!C\contains_key($specs, $key)) {
      return shape(
        'class' => 'EditableToken',
        'nullable' => false,
      );
    }

    $children = $specs[$key];
    $nullable = C\contains_key($children, 'missing');
    if ($nullable) {
      $children = Vec\filter($children, $child ==> $child !== 'missing');
    }
    if (C\count($children) !== 1) {
      return shape(
        'class' => 'EditableToken',
        'nullable' => false,
      );
    }

    return shape(
      'class' => $this->getSyntaxClassForChild(C\firstx($children)),
      'nullable' => $nullable,
    );
  }

  private function getSyntaxClassForChild(
    string $child,
  ): string {
    if ($child === 'token') {
      return 'EditableToken';
    }
    if ($child === 'list') {
      return 'EditableList';
    }

    if (Str\starts_with($child, 'token')) {
      return $this->getTokenClassForChild($child);
    }

    $ast = C\find(
      $this->getSchema()['AST'],
      $syntax ==> $syntax['description'] === $child,
    );
    invariant(
      $ast !== null,
      'Could not look up syntax "%s"',
      $child,
    );
    return $ast['kind_name'];
  }

  private function getTokenClassForChild(
    string $child,
  ): string {
    $child = Str\strip_prefix($child, 'token:');

    $tokens = $this->getSchema()['tokens'];
    $token = C\find(
      $tokens,
      $token ==> $token['token_text'] === $child,
    );
    if ($token !== null) {
      return $token['token_kind'].'Token';
    }
    
    $token = C\find(
      $tokens,
      $token ==> self::underscored($token['token_kind']) === $child,
    );

    invariant(
      $token !== null,
      'Failed to find token for "%s"',
      $child,
    );

    return $token['token_kind'].'Token';
  }
}
