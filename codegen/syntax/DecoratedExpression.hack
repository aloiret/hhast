/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<a3a4ac69d19ed2dbeea5e816b835cbcb>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;

<<__ConsistentConstruct>>
final class DecoratedExpression extends EditableNode {

  private EditableNode $_decorator;
  private EditableNode $_expression;

  public function __construct(
    EditableNode $decorator,
    EditableNode $expression,
    ?__Private\SourceRef $source_ref = null,
  ) {
    $this->_decorator = $decorator;
    $this->_expression = $expression;
    parent::__construct('decorated_expression', $source_ref);
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $initial_offset,
    string $source,
  ): this {
    $offset = $initial_offset;
    $decorator = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['decorated_expression_decorator'],
      $file,
      $offset,
      $source,
    );
    $offset += $decorator->getWidth();
    $expression = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['decorated_expression_expression'],
      $file,
      $offset,
      $source,
    );
    $offset += $expression->getWidth();
    $source_ref = shape(
      'file' => $file,
      'source' => $source,
      'offset' => $initial_offset,
      'width' => $offset - $initial_offset,
    );
    return new static($decorator, $expression, $source_ref);
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return dict[
      'decorator' => $this->_decorator,
      'expression' => $this->_expression,
    ];
  }

  <<__Override>>
  public function rewriteChildren(
    self::TRewriter $rewriter,
    vec<EditableNode> $parents = vec[],
  ): this {
    $parents[] = $this;
    $decorator = $rewriter($this->_decorator, $parents);
    $expression = $rewriter($this->_expression, $parents);
    if (
      $decorator === $this->_decorator && $expression === $this->_expression
    ) {
      return $this;
    }
    return new static($decorator, $expression);
  }

  public function getDecoratorUNTYPED(): EditableNode {
    return $this->_decorator;
  }

  public function withDecorator(EditableNode $value): this {
    if ($value === $this->_decorator) {
      return $this;
    }
    return new static($value, $this->_expression);
  }

  public function hasDecorator(): bool {
    return !$this->_decorator->isMissing();
  }

  /**
   * @return AmpersandToken | DotDotDotToken | InoutToken
   */
  public function getDecorator(): EditableToken {
    return TypeAssert\instance_of(EditableToken::class, $this->_decorator);
  }

  /**
   * @return AmpersandToken | DotDotDotToken | InoutToken
   */
  public function getDecoratorx(): EditableToken {
    return $this->getDecorator();
  }

  public function getExpressionUNTYPED(): EditableNode {
    return $this->_expression;
  }

  public function withExpression(EditableNode $value): this {
    if ($value === $this->_expression) {
      return $this;
    }
    return new static($this->_decorator, $value);
  }

  public function hasExpression(): bool {
    return !$this->_expression->isMissing();
  }

  /**
   * @return ArrayCreationExpression | ArrayIntrinsicExpression |
   * BinaryExpression | DecoratedExpression | FunctionCallExpression |
   * MemberSelectionExpression | null | ScopeResolutionExpression |
   * SubscriptExpression | NameToken | VariableToken | VariableExpression
   */
  public function getExpression(): ?EditableNode {
    if ($this->_expression->isMissing()) {
      return null;
    }
    return TypeAssert\instance_of(EditableNode::class, $this->_expression);
  }

  /**
   * @return ArrayCreationExpression | ArrayIntrinsicExpression |
   * BinaryExpression | DecoratedExpression | FunctionCallExpression |
   * MemberSelectionExpression | ScopeResolutionExpression |
   * SubscriptExpression | NameToken | VariableToken | VariableExpression
   */
  public function getExpressionx(): EditableNode {
    return TypeAssert\instance_of(EditableNode::class, $this->_expression);
  }
}
