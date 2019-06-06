/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST\Linters;

use type Facebook\HHAST\{
  AttributeSpecification,
  ClassToken,
  ClassishDeclaration,
  GenericTypeSpecifier,
  ListItem,
  MethodishDeclaration,
  NameToken,
  PrivateToken,
  Script,
};
use function Facebook\HHAST\resolve_type;
use namespace Facebook\HHAST;
use namespace HH\Lib\{C, Str, Vec};

final class MustUseOverrideAttributeLinter extends AutoFixingASTLinter {
  const type TNode = MethodishDeclaration;

  <<__Override>>
  public function getTitleForFix(LintError $_): string {
    return 'Add __Override attribute';
  }

  const type TContext = ClassishDeclaration;

  <<__Override>>
  public function getLintErrorForNode(
    ClassishDeclaration $class,
    MethodishDeclaration $node,
  ): ?ASTLintError {
    if ($this->canIgnoreMethod($class, $node)) {
      return null;
    }

    $root = $this->getAST();
    $super = self::findSuper($root, $class);
    try {
      $method = $node->getFunctionDeclHeader()->getName()->getCode()
        |> Str\trim($$);

      $reflection_method = new \ReflectionMethod($super, $method);

      return new ASTLintError(
        $this,
        Str\format(
          '%s::%s() overrides %s::%s() without <<__Override>>',
          $class->getNamex()->getCode()
            |> Str\trim($$)
            |> resolve_type($$, $root, $node),
          $method,
          $reflection_method->getDeclaringClass()->getName(),
          $method,
        ),
        $node,
        () ==> $this->getFixedNode($node),
      );
    } catch (\ReflectionException $e) {
      $method = $node->getFunctionDeclHeader()->getName()->getCode()
        |> Str\trim($$);
      return null;
    }
  }

  private static function findSuper(
    Script $root,
    ClassishDeclaration $class,
  ): string {
    $super = C\onlyx($class->getExtendsListx()->getChildren());
    if ($super instanceof ListItem) {
      $super = $super->getItemUNTYPED();
    }
    if ($super instanceof GenericTypeSpecifier) {
      $super = $super->getClassType();
    }
    return $super->getCode()
      |> Str\trim($$)
      |> resolve_type($$, $root, $class);
  }

  private function canIgnoreMethod(
    ClassishDeclaration $class,
    MethodishDeclaration $method,
  ): bool {
    if (!$class->hasExtendsKeyword()) {
      return true;
    }

    $name = $method->getFunctionDeclHeader()->getName();
    if ($name instanceof HHAST\ConstructToken) {
      return true;
    }

    if ($name instanceof HHAST\DestructToken) {
      return true;
    }

    $private = $method->getFunctionDeclHeader()
      ->getModifiersx()
      ->getDescendantsOfType(PrivateToken::class)
      |> C\first($$);
    if ($private !== null) {
      return true;
    }

    if (!$class->getKeyword() instanceof ClassToken) {
      return true;
    }

    $attrs = $method->getAttribute();
    if ($attrs === null) {
      return false;
    }
    $attrs = $attrs->getAttributes()->getChildrenOfItems()
      |> Vec\map($$, $attr ==> ($attr->getType() ?as NameToken)?->getText());
    return C\contains($attrs, '__Override');
  }

  <<__Override>>
  public function getPrettyTextForNode(MethodishDeclaration $node): string {
    $body = $node->getFunctionBody();
    if ($body === null) {
      return $node->getCode();
    }

    return $node->withFunctionBody(
      $body
        ->withStatements(HHAST\Missing())
        ->withRightBrace(HHAST\Missing())
        ->withLeftBrace($body->getLeftBracex()->withTrailing(HHAST\Missing())),
    )
      ->getCode();
  }

  public function getFixedNode(
    MethodishDeclaration $node,
  ): MethodishDeclaration {
    $attrs = $node->getAttribute();
    if ($attrs === null) {
      $first_token = $node->getFirstTokenx();
      return $node->withAttribute(
        new AttributeSpecification(
          new HHAST\LessThanLessThanToken(
            $first_token->getLeading(),
            HHAST\Missing(),
          ),
          new HHAST\ConstructorCall(
            new HHAST\NameToken(HHAST\Missing(), HHAST\Missing(), '__Override'),
            HHAST\Missing(),
            HHAST\Missing(),
            HHAST\Missing(),
          ),
          new HHAST\GreaterThanGreaterThanToken(
            HHAST\Missing(),
            Str\contains(
              C\lastx($first_token->getLeading()->getChildren())->getCode(),
              "\n",
            )
              ? HHAST\Missing()
              : new HHAST\WhiteSpace("\n"),
          ),
        ),
      )
        ->replace(
          $first_token,
          $first_token->withLeading(
            C\lastx($first_token->getLeading()->getChildren()),
          ),
        );
    }

    $list = $attrs->getAttributes()->toVec();
    $last_idx = C\count($list) - 1;
    $last = $list[$last_idx];
    if (!$last->hasSeparator()) {
      $list[$last_idx] = $last->withSeparator(
        new HHAST\CommaToken(HHAST\Missing(), new HHAST\WhiteSpace(' ')),
      );
    }
    $list[] = new HHAST\NameToken(
      HHAST\Missing(),
      HHAST\Missing(),
      '__Override',
    );

    return $node->withAttribute(
      $attrs->withAttributes(new HHAST\NodeList($list)),
    );
  }
}
