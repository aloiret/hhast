/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<bc6ce66b7e63933943575f0077ac6ecd>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;

<<__ConsistentConstruct>>
final class ArrayIntrinsicExpression extends EditableNode {

  private EditableNode $_keyword;
  private EditableNode $_left_paren;
  private EditableNode $_members;
  private EditableNode $_right_paren;

  public function __construct(
    EditableNode $keyword,
    EditableNode $left_paren,
    EditableNode $members,
    EditableNode $right_paren,
    ?__Private\SourceRef $source_ref = null,
  ) {
    $this->_keyword = $keyword;
    $this->_left_paren = $left_paren;
    $this->_members = $members;
    $this->_right_paren = $right_paren;
    parent::__construct('array_intrinsic_expression', $source_ref);
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $initial_offset,
    string $source,
  ): this {
    $offset = $initial_offset;
    $keyword = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['array_intrinsic_keyword'],
      $file,
      $offset,
      $source,
    );
    $offset += $keyword->getWidth();
    $left_paren = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['array_intrinsic_left_paren'],
      $file,
      $offset,
      $source,
    );
    $offset += $left_paren->getWidth();
    $members = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['array_intrinsic_members'],
      $file,
      $offset,
      $source,
    );
    $offset += $members->getWidth();
    $right_paren = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['array_intrinsic_right_paren'],
      $file,
      $offset,
      $source,
    );
    $offset += $right_paren->getWidth();
    $source_ref = shape(
      'file' => $file,
      'source' => $source,
      'offset' => $initial_offset,
      'width' => $offset - $initial_offset,
    );
    return new static(
      $keyword,
      $left_paren,
      $members,
      $right_paren,
      $source_ref,
    );
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return dict[
      'keyword' => $this->_keyword,
      'left_paren' => $this->_left_paren,
      'members' => $this->_members,
      'right_paren' => $this->_right_paren,
    ];
  }

  <<__Override>>
  public function rewriteChildren(
    self::TRewriter $rewriter,
    vec<EditableNode> $parents = vec[],
  ): this {
    $parents[] = $this;
    $keyword = $rewriter($this->_keyword, $parents);
    $left_paren = $rewriter($this->_left_paren, $parents);
    $members = $rewriter($this->_members, $parents);
    $right_paren = $rewriter($this->_right_paren, $parents);
    if (
      $keyword === $this->_keyword &&
      $left_paren === $this->_left_paren &&
      $members === $this->_members &&
      $right_paren === $this->_right_paren
    ) {
      return $this;
    }
    return new static($keyword, $left_paren, $members, $right_paren);
  }

  public function getKeywordUNTYPED(): EditableNode {
    return $this->_keyword;
  }

  public function withKeyword(EditableNode $value): this {
    if ($value === $this->_keyword) {
      return $this;
    }
    return new static(
      $value,
      $this->_left_paren,
      $this->_members,
      $this->_right_paren,
    );
  }

  public function hasKeyword(): bool {
    return !$this->_keyword->isMissing();
  }

  /**
   * @return ArrayToken
   */
  public function getKeyword(): ArrayToken {
    return TypeAssert\instance_of(ArrayToken::class, $this->_keyword);
  }

  /**
   * @return ArrayToken
   */
  public function getKeywordx(): ArrayToken {
    return $this->getKeyword();
  }

  public function getLeftParenUNTYPED(): EditableNode {
    return $this->_left_paren;
  }

  public function withLeftParen(EditableNode $value): this {
    if ($value === $this->_left_paren) {
      return $this;
    }
    return new static(
      $this->_keyword,
      $value,
      $this->_members,
      $this->_right_paren,
    );
  }

  public function hasLeftParen(): bool {
    return !$this->_left_paren->isMissing();
  }

  /**
   * @return null | LeftParenToken
   */
  public function getLeftParen(): ?LeftParenToken {
    if ($this->_left_paren->isMissing()) {
      return null;
    }
    return TypeAssert\instance_of(LeftParenToken::class, $this->_left_paren);
  }

  /**
   * @return LeftParenToken
   */
  public function getLeftParenx(): LeftParenToken {
    return TypeAssert\instance_of(LeftParenToken::class, $this->_left_paren);
  }

  public function getMembersUNTYPED(): EditableNode {
    return $this->_members;
  }

  public function withMembers(EditableNode $value): this {
    if ($value === $this->_members) {
      return $this;
    }
    return new static(
      $this->_keyword,
      $this->_left_paren,
      $value,
      $this->_right_paren,
    );
  }

  public function hasMembers(): bool {
    return !$this->_members->isMissing();
  }

  /**
   * @return EditableList<AnonymousFunction> | EditableList<EditableNode> |
   * EditableList<ArrayCreationExpression> |
   * EditableList<ArrayIntrinsicExpression> |
   * EditableList<AwaitableCreationExpression> | EditableList<BinaryExpression>
   * | EditableList<CastExpression> | EditableList<CollectionLiteralExpression>
   * | EditableList<ElementInitializer> | EditableList<FunctionCallExpression>
   * | EditableList<LiteralExpression> |
   * EditableList<MemberSelectionExpression> |
   * EditableList<ObjectCreationExpression> |
   * EditableList<PrefixUnaryExpression> | EditableList<QualifiedName> |
   * EditableList<ScopeResolutionExpression> |
   * EditableList<SubscriptExpression> | EditableList<NameToken> |
   * EditableList<TupleExpression> | EditableList<VariableExpression> |
   * EditableList<VectorIntrinsicExpression> | EditableList<XHPExpression> |
   * null
   */
  public function getMembers(): ?EditableList<EditableNode> {
    if ($this->_members->isMissing()) {
      return null;
    }
    return TypeAssert\instance_of(EditableList::class, $this->_members);
  }

  /**
   * @return EditableList<AnonymousFunction> | EditableList<EditableNode> |
   * EditableList<ArrayCreationExpression> |
   * EditableList<ArrayIntrinsicExpression> |
   * EditableList<AwaitableCreationExpression> | EditableList<BinaryExpression>
   * | EditableList<CastExpression> | EditableList<CollectionLiteralExpression>
   * | EditableList<ElementInitializer> | EditableList<FunctionCallExpression>
   * | EditableList<LiteralExpression> |
   * EditableList<MemberSelectionExpression> |
   * EditableList<ObjectCreationExpression> |
   * EditableList<PrefixUnaryExpression> | EditableList<QualifiedName> |
   * EditableList<ScopeResolutionExpression> |
   * EditableList<SubscriptExpression> | EditableList<NameToken> |
   * EditableList<TupleExpression> | EditableList<VariableExpression> |
   * EditableList<VectorIntrinsicExpression> | EditableList<XHPExpression>
   */
  public function getMembersx(): EditableList<EditableNode> {
    return TypeAssert\instance_of(EditableList::class, $this->_members);
  }

  public function getRightParenUNTYPED(): EditableNode {
    return $this->_right_paren;
  }

  public function withRightParen(EditableNode $value): this {
    if ($value === $this->_right_paren) {
      return $this;
    }
    return new static(
      $this->_keyword,
      $this->_left_paren,
      $this->_members,
      $value,
    );
  }

  public function hasRightParen(): bool {
    return !$this->_right_paren->isMissing();
  }

  /**
   * @return null | RightParenToken
   */
  public function getRightParen(): ?RightParenToken {
    if ($this->_right_paren->isMissing()) {
      return null;
    }
    return TypeAssert\instance_of(RightParenToken::class, $this->_right_paren);
  }

  /**
   * @return RightParenToken
   */
  public function getRightParenx(): RightParenToken {
    return TypeAssert\instance_of(RightParenToken::class, $this->_right_paren);
  }
}
