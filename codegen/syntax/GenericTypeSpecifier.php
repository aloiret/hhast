<?hh
/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<70920be38807bc2f7ba56722ec647a26>>
 */
namespace Facebook\HHAST;
use type Facebook\TypeAssert\TypeAssert;

final class GenericTypeSpecifier extends EditableSyntax {

  private EditableSyntax $_class_type;
  private EditableSyntax $_argument_list;

  public function __construct(
    EditableSyntax $class_type,
    EditableSyntax $argument_list,
  ) {
    parent::__construct('generic_type_specifier');
    $this->_class_type = $class_type;
    $this->_argument_list = $argument_list;
  }

  public static function from_json(
    array<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $class_type = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['generic_class_type'],
      $position,
      $source,
    );
    $position += $class_type->width();
    $argument_list = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['generic_argument_list'],
      $position,
      $source,
    );
    $position += $argument_list->width();
    return new self($class_type, $argument_list);
  }

  public function children(): KeyedTraversable<string, EditableSyntax> {
    yield 'class_type' => $this->_class_type;
    yield 'argument_list' => $this->_argument_list;
  }

  public function rewrite(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): EditableSyntax {
    $parents = $parents === null ? vec[] : vec($parents);
    $child_parents = $parents;
    $child_parents[] = $this;
    $class_type = $this->_class_type->rewrite($rewriter, $child_parents);
    $argument_list = $this->_argument_list->rewrite($rewriter, $child_parents);
    if (
      $class_type === $this->_class_type &&
      $argument_list === $this->_argument_list
    ) {
      $node = $this;
    } else {
      $node = new self($class_type, $argument_list);
    }
    return $rewriter($node, $parents);
  }

  public function class_type(): EditableSyntax {
    return $this->class_typex();
  }

  public function class_typex(): EditableSyntax {
    return TypeAssert::isInstanceOf(EditableSyntax::class, $this->_class_type);
  }

  public function raw_class_type(): EditableSyntax {
    return $this->_class_type;
  }

  public function with_class_type(EditableSyntax $value): this {
    return new self($value, $this->_argument_list);
  }

  public function argument_list(): TypeArguments {
    return $this->argument_listx();
  }

  public function argument_listx(): TypeArguments {
    return
      TypeAssert::isInstanceOf(TypeArguments::class, $this->_argument_list);
  }

  public function raw_argument_list(): EditableSyntax {
    return $this->_argument_list;
  }

  public function with_argument_list(EditableSyntax $value): this {
    return new self($this->_class_type, $value);
  }
}
