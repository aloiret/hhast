<?hh
/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<9ef42abf3cbf580a881052988ad00f21>>
 */
namespace Facebook\HHAST;
use type Facebook\TypeAssert\TypeAssert;

final class XHPOpen extends EditableSyntax {

  private EditableSyntax $_left_angle;
  private EditableSyntax $_name;
  private EditableSyntax $_attributes;
  private EditableSyntax $_right_angle;

  public function __construct(
    EditableSyntax $left_angle,
    EditableSyntax $name,
    EditableSyntax $attributes,
    EditableSyntax $right_angle,
  ) {
    parent::__construct('xhp_open');
    $this->_left_angle = $left_angle;
    $this->_name = $name;
    $this->_attributes = $attributes;
    $this->_right_angle = $right_angle;
  }

  public static function from_json(
    array<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $left_angle = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_open_left_angle'],
      $position,
      $source,
    );
    $position += $left_angle->width();
    $name = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_open_name'],
      $position,
      $source,
    );
    $position += $name->width();
    $attributes = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_open_attributes'],
      $position,
      $source,
    );
    $position += $attributes->width();
    $right_angle = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_open_right_angle'],
      $position,
      $source,
    );
    $position += $right_angle->width();
    return new self($left_angle, $name, $attributes, $right_angle);
  }

  public function children(): KeyedTraversable<string, EditableSyntax> {
    yield 'left_angle' => $this->_left_angle;
    yield 'name' => $this->_name;
    yield 'attributes' => $this->_attributes;
    yield 'right_angle' => $this->_right_angle;
  }

  public function rewrite(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): EditableSyntax {
    $parents = $parents === null ? vec[] : vec($parents);
    $child_parents = $parents;
    $child_parents[] = $this;
    $left_angle = $this->_left_angle->rewrite($rewriter, $child_parents);
    $name = $this->_name->rewrite($rewriter, $child_parents);
    $attributes = $this->_attributes->rewrite($rewriter, $child_parents);
    $right_angle = $this->_right_angle->rewrite($rewriter, $child_parents);
    if (
      $left_angle === $this->_left_angle &&
      $name === $this->_name &&
      $attributes === $this->_attributes &&
      $right_angle === $this->_right_angle
    ) {
      $node = $this;
    } else {
      $node = new self($left_angle, $name, $attributes, $right_angle);
    }
    return $rewriter($node, $parents);
  }

  public function left_angle(): LessThanToken {
    return $this->left_anglex();
  }

  public function left_anglex(): LessThanToken {
    return TypeAssert::isInstanceOf(LessThanToken::class, $this->_left_angle);
  }

  public function raw_left_angle(): EditableSyntax {
    return $this->_left_angle;
  }

  public function with_left_angle(EditableSyntax $value): this {
    return
      new self($value, $this->_name, $this->_attributes, $this->_right_angle);
  }

  public function name(): XHPElementNameToken {
    return $this->namex();
  }

  public function namex(): XHPElementNameToken {
    return TypeAssert::isInstanceOf(XHPElementNameToken::class, $this->_name);
  }

  public function raw_name(): EditableSyntax {
    return $this->_name;
  }

  public function with_name(EditableSyntax $value): this {
    return new self(
      $this->_left_angle,
      $value,
      $this->_attributes,
      $this->_right_angle,
    );
  }

  public function attributes(): ?EditableList {
    return $this->_attributes->is_missing()
      ? null
      : TypeAssert::isInstanceOf(EditableList::class, $this->_attributes);
  }

  public function attributesx(): EditableList {
    return TypeAssert::isInstanceOf(EditableList::class, $this->_attributes);
  }

  public function raw_attributes(): EditableSyntax {
    return $this->_attributes;
  }

  public function with_attributes(EditableSyntax $value): this {
    return
      new self($this->_left_angle, $this->_name, $value, $this->_right_angle);
  }

  public function right_angle(): EditableSyntax {
    return $this->right_anglex();
  }

  public function right_anglex(): EditableSyntax {
    return TypeAssert::isInstanceOf(EditableSyntax::class, $this->_right_angle);
  }

  public function raw_right_angle(): EditableSyntax {
    return $this->_right_angle;
  }

  public function with_right_angle(EditableSyntax $value): this {
    return
      new self($this->_left_angle, $this->_name, $this->_attributes, $value);
  }
}
