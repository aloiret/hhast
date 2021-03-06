/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<c4e7e7f1bf30cb21fcbe3016ca3ee3e1>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;

<<__ConsistentConstruct>>
final class PipeVariableExpression extends EditableNode {

  private EditableNode $_expression;

  public function __construct(
    EditableNode $expression,
    ?__Private\SourceRef $source_ref = null,
  ) {
    $this->_expression = $expression;
    parent::__construct('pipe_variable_expression', $source_ref);
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $initial_offset,
    string $source,
  ): this {
    $offset = $initial_offset;
    $expression = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['pipe_variable_expression'],
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
    return new static($expression, $source_ref);
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return dict[
      'expression' => $this->_expression,
    ];
  }

  <<__Override>>
  public function rewriteChildren(
    self::TRewriter $rewriter,
    vec<EditableNode> $parents = vec[],
  ): this {
    $parents[] = $this;
    $expression = $rewriter($this->_expression, $parents);
    if ($expression === $this->_expression) {
      return $this;
    }
    return new static($expression);
  }

  public function getExpressionUNTYPED(): EditableNode {
    return $this->_expression;
  }

  public function withExpression(EditableNode $value): this {
    if ($value === $this->_expression) {
      return $this;
    }
    return new static($value);
  }

  public function hasExpression(): bool {
    return !$this->_expression->isMissing();
  }

  /**
   * @return unknown
   */
  public function getExpression(): EditableNode {
    return TypeAssert\instance_of(EditableNode::class, $this->_expression);
  }

  /**
   * @return unknown
   */
  public function getExpressionx(): EditableNode {
    return $this->getExpression();
  }
}
