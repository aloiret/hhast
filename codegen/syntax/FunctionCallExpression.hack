/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<f42796be7caef3b20f963a084870c84b>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;

<<__ConsistentConstruct>>
final class FunctionCallExpression extends EditableNode {

  private EditableNode $_receiver;
  private EditableNode $_type_args;
  private EditableNode $_left_paren;
  private EditableNode $_argument_list;
  private EditableNode $_right_paren;

  public function __construct(
    EditableNode $receiver,
    EditableNode $type_args,
    EditableNode $left_paren,
    EditableNode $argument_list,
    EditableNode $right_paren,
    ?__Private\SourceRef $source_ref = null,
  ) {
    $this->_receiver = $receiver;
    $this->_type_args = $type_args;
    $this->_left_paren = $left_paren;
    $this->_argument_list = $argument_list;
    $this->_right_paren = $right_paren;
    parent::__construct('function_call_expression', $source_ref);
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $initial_offset,
    string $source,
  ): this {
    $offset = $initial_offset;
    $receiver = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['function_call_receiver'],
      $file,
      $offset,
      $source,
    );
    $offset += $receiver->getWidth();
    $type_args = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['function_call_type_args'],
      $file,
      $offset,
      $source,
    );
    $offset += $type_args->getWidth();
    $left_paren = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['function_call_left_paren'],
      $file,
      $offset,
      $source,
    );
    $offset += $left_paren->getWidth();
    $argument_list = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['function_call_argument_list'],
      $file,
      $offset,
      $source,
    );
    $offset += $argument_list->getWidth();
    $right_paren = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['function_call_right_paren'],
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
      $receiver,
      $type_args,
      $left_paren,
      $argument_list,
      $right_paren,
      $source_ref,
    );
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return dict[
      'receiver' => $this->_receiver,
      'type_args' => $this->_type_args,
      'left_paren' => $this->_left_paren,
      'argument_list' => $this->_argument_list,
      'right_paren' => $this->_right_paren,
    ];
  }

  <<__Override>>
  public function rewriteChildren(
    self::TRewriter $rewriter,
    vec<EditableNode> $parents = vec[],
  ): this {
    $parents[] = $this;
    $receiver = $rewriter($this->_receiver, $parents);
    $type_args = $rewriter($this->_type_args, $parents);
    $left_paren = $rewriter($this->_left_paren, $parents);
    $argument_list = $rewriter($this->_argument_list, $parents);
    $right_paren = $rewriter($this->_right_paren, $parents);
    if (
      $receiver === $this->_receiver &&
      $type_args === $this->_type_args &&
      $left_paren === $this->_left_paren &&
      $argument_list === $this->_argument_list &&
      $right_paren === $this->_right_paren
    ) {
      return $this;
    }
    return new static(
      $receiver,
      $type_args,
      $left_paren,
      $argument_list,
      $right_paren,
    );
  }

  public function getReceiverUNTYPED(): EditableNode {
    return $this->_receiver;
  }

  public function withReceiver(EditableNode $value): this {
    if ($value === $this->_receiver) {
      return $this;
    }
    return new static(
      $value,
      $this->_type_args,
      $this->_left_paren,
      $this->_argument_list,
      $this->_right_paren,
    );
  }

  public function hasReceiver(): bool {
    return !$this->_receiver->isMissing();
  }

  /**
   * @return ArrayCreationExpression | FunctionCallExpression |
   * LiteralExpression | MemberSelectionExpression | ParenthesizedExpression |
   * QualifiedName | SafeMemberSelectionExpression | ScopeResolutionExpression
   * | SubscriptExpression | ErrorTokenToken | NameToken | VariableExpression
   */
  public function getReceiver(): EditableNode {
    return TypeAssert\instance_of(EditableNode::class, $this->_receiver);
  }

  /**
   * @return ArrayCreationExpression | FunctionCallExpression |
   * LiteralExpression | MemberSelectionExpression | ParenthesizedExpression |
   * QualifiedName | SafeMemberSelectionExpression | ScopeResolutionExpression
   * | SubscriptExpression | ErrorTokenToken | NameToken | VariableExpression
   */
  public function getReceiverx(): EditableNode {
    return $this->getReceiver();
  }

  public function getTypeArgsUNTYPED(): EditableNode {
    return $this->_type_args;
  }

  public function withTypeArgs(EditableNode $value): this {
    if ($value === $this->_type_args) {
      return $this;
    }
    return new static(
      $this->_receiver,
      $value,
      $this->_left_paren,
      $this->_argument_list,
      $this->_right_paren,
    );
  }

  public function hasTypeArgs(): bool {
    return !$this->_type_args->isMissing();
  }

  /**
   * @return null | TypeArguments
   */
  public function getTypeArgs(): ?TypeArguments {
    if ($this->_type_args->isMissing()) {
      return null;
    }
    return TypeAssert\instance_of(TypeArguments::class, $this->_type_args);
  }

  /**
   * @return TypeArguments
   */
  public function getTypeArgsx(): TypeArguments {
    return TypeAssert\instance_of(TypeArguments::class, $this->_type_args);
  }

  public function getLeftParenUNTYPED(): EditableNode {
    return $this->_left_paren;
  }

  public function withLeftParen(EditableNode $value): this {
    if ($value === $this->_left_paren) {
      return $this;
    }
    return new static(
      $this->_receiver,
      $this->_type_args,
      $value,
      $this->_argument_list,
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

  public function getArgumentListUNTYPED(): EditableNode {
    return $this->_argument_list;
  }

  public function withArgumentList(EditableNode $value): this {
    if ($value === $this->_argument_list) {
      return $this;
    }
    return new static(
      $this->_receiver,
      $this->_type_args,
      $this->_left_paren,
      $value,
      $this->_right_paren,
    );
  }

  public function hasArgumentList(): bool {
    return !$this->_argument_list->isMissing();
  }

  /**
   * @return EditableList<AnonymousFunction> | EditableList<EditableNode> |
   * EditableList<ArrayCreationExpression> |
   * EditableList<ArrayIntrinsicExpression> | EditableList<AsExpression> |
   * EditableList<AwaitableCreationExpression> | EditableList<BinaryExpression>
   * | EditableList<CastExpression> | EditableList<CollectionLiteralExpression>
   * | EditableList<ConditionalExpression> |
   * EditableList<DarrayIntrinsicExpression> |
   * EditableList<DecoratedExpression> |
   * EditableList<DictionaryIntrinsicExpression> |
   * EditableList<EmptyExpression> | EditableList<EvalExpression> |
   * EditableList<FunctionCallExpression> | EditableList<InstanceofExpression>
   * | EditableList<IsExpression> | EditableList<IssetExpression> |
   * EditableList<KeysetIntrinsicExpression> | EditableList<LambdaExpression> |
   * EditableList<LiteralExpression> | EditableList<?LiteralExpression> |
   * EditableList<MemberSelectionExpression> | EditableList<?EditableNode> |
   * EditableList<ObjectCreationExpression> |
   * EditableList<ParenthesizedExpression> |
   * EditableList<PipeVariableExpression> |
   * EditableList<PostfixUnaryExpression> | EditableList<PrefixUnaryExpression>
   * | EditableList<QualifiedName> |
   * EditableList<SafeMemberSelectionExpression> |
   * EditableList<ScopeResolutionExpression> | EditableList<ShapeExpression> |
   * EditableList<SubscriptExpression> | EditableList<AsToken> |
   * EditableList<ErrorTokenToken> | EditableList<NameToken> |
   * EditableList<TupleExpression> | EditableList<VariableExpression> |
   * EditableList<VarrayIntrinsicExpression> |
   * EditableList<VectorIntrinsicExpression> | EditableList<XHPExpression> |
   * null
   */
  public function getArgumentList(): ?EditableList<?EditableNode> {
    if ($this->_argument_list->isMissing()) {
      return null;
    }
    return TypeAssert\instance_of(EditableList::class, $this->_argument_list);
  }

  /**
   * @return EditableList<AnonymousFunction> | EditableList<EditableNode> |
   * EditableList<ArrayCreationExpression> |
   * EditableList<ArrayIntrinsicExpression> | EditableList<AsExpression> |
   * EditableList<AwaitableCreationExpression> | EditableList<BinaryExpression>
   * | EditableList<CastExpression> | EditableList<CollectionLiteralExpression>
   * | EditableList<ConditionalExpression> |
   * EditableList<DarrayIntrinsicExpression> |
   * EditableList<DecoratedExpression> |
   * EditableList<DictionaryIntrinsicExpression> |
   * EditableList<EmptyExpression> | EditableList<EvalExpression> |
   * EditableList<FunctionCallExpression> | EditableList<InstanceofExpression>
   * | EditableList<IsExpression> | EditableList<IssetExpression> |
   * EditableList<KeysetIntrinsicExpression> | EditableList<LambdaExpression> |
   * EditableList<LiteralExpression> | EditableList<?LiteralExpression> |
   * EditableList<MemberSelectionExpression> | EditableList<?EditableNode> |
   * EditableList<ObjectCreationExpression> |
   * EditableList<ParenthesizedExpression> |
   * EditableList<PipeVariableExpression> |
   * EditableList<PostfixUnaryExpression> | EditableList<PrefixUnaryExpression>
   * | EditableList<QualifiedName> |
   * EditableList<SafeMemberSelectionExpression> |
   * EditableList<ScopeResolutionExpression> | EditableList<ShapeExpression> |
   * EditableList<SubscriptExpression> | EditableList<AsToken> |
   * EditableList<ErrorTokenToken> | EditableList<NameToken> |
   * EditableList<TupleExpression> | EditableList<VariableExpression> |
   * EditableList<VarrayIntrinsicExpression> |
   * EditableList<VectorIntrinsicExpression> | EditableList<XHPExpression>
   */
  public function getArgumentListx(): EditableList<?EditableNode> {
    return TypeAssert\instance_of(EditableList::class, $this->_argument_list);
  }

  public function getRightParenUNTYPED(): EditableNode {
    return $this->_right_paren;
  }

  public function withRightParen(EditableNode $value): this {
    if ($value === $this->_right_paren) {
      return $this;
    }
    return new static(
      $this->_receiver,
      $this->_type_args,
      $this->_left_paren,
      $this->_argument_list,
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
