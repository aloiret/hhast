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
  DelimitedComment,
  EndOfFile,
  EndOfLine,
  File,
  MarkupSection,
  NodeList,
  Script,
};
use namespace Facebook\TypeAssert;
use namespace HH\Lib\{C, Str, Vec};

final class LicenseHeaderLinter extends AutoFixingASTLinter {
  const type TNode = Script;

  public static ?string $forcedHeader = null;

  const type TContext = Script;

  <<__Override>>
  public function getLintErrorForNode(
    Script $_context,
    Script $script,
  ): ?ASTLintError {
    $decls = $script->getDeclarations()->getChildren();
    $first = C\first($decls);
    if ($first is MarkupSection) {
      // <?hh or <?php ; not present in .hack files
      $first = $decls[1] ?? null;
    }
    if ($first === null) {
      return null;
    }
    if ($first instanceof EndOfFile) {
      return null;
    }
    $leading = $first->getFirstToken()?->getLeading();
    if ($leading instanceof NodeList) {
      $leading = $leading->getChildren()[0];
    }

    if ($leading instanceof DelimitedComment) {
      if (
        $leading->getText() ===
          self::getLicenseHeaderForPath(\dirname($this->getFile()->getPath()))
      ) {
        return null;
      }
    }
    return new ASTLintError(
      $this,
      'Incorrect or missing license header',
      $script,
      () ==> $this->getFixedNode($script),
    );
  }

  <<__Override>>
  public function getPrettyTextForNode(Script $node): string {
    return $node->getDeclarations()->getChildren()
      |> Vec\take($$, 2)
      |> NodeList::createNonEmptyListOrMissing($$)
      |> $$->getCode();
  }

  <<__Override>>
  protected function getTitleForFix(ASTLintError $e): string {
    if (Str\contains_ci($e->getBlameCode(), 'copyright')) {
      return 'Replace license header';
    }
    return 'Add license header';
  }

  public function getFixedNode(Script $node): Script {
    $first = $node->getDeclarations()->getChildren()[1]->getFirstTokenx();
    $leading = $first->getLeading();
    if ($leading instanceof NodeList) {
      $leading = $leading->getChildren();
    } else if ($leading === null) {
      $leading = vec[];
    } else {
      $leading = vec[$leading];
    }

    $key = C\find_key(
      $leading,
      $item ==> ($item instanceof DelimitedComment) &&
        Str\contains_ci($item->getText(), 'copyright'),
    );

    if ($key !== null) {
      $existing = $leading[$key];
      $next = $leading[$key + 1] ?? null;
      $next_next = $leading[$key + 2] ?? null;

      $new = vec[new DelimitedComment(
        TypeAssert\not_null(
          self::getLicenseHeaderForPath(\dirname($this->getFile()->getPath())),
        ),
      )];
      if (!($next instanceof EndOfLine && $next_next instanceof EndOfLine)) {
        $new[] = new EndOfLine("\n");
      }

      return $node->replace(
        $existing,
        NodeList::createNonEmptyListOrMissing($new),
      );
    }


    $leading = Vec\concat(
      vec[
        new DelimitedComment(
          TypeAssert\not_null(
            self::getLicenseHeaderForPath(
              \dirname($this->getFile()->getPath()),
            ),
          ),
        ),
        new EndOfLine("\n"),
        new EndOfLine("\n"),
      ],
      $leading,
    );
    return $node->replace(
      $first,
      $first->withLeading(NodeList::createNonEmptyListOrMissing($leading)),
    );
  }

  <<__Override>>
  public static function shouldLintFile(File $file): bool {
    return self::getLicenseHeaderForPath($file->getPath()) !== null;
  }

  public static function __setExpectedHeaderForTesting(string $header): void {
    self::$forcedHeader = $header;
  }

  <<__Memoize>>
  private static function getLicenseHeaderForPath(string $path): ?string {
    if (self::$forcedHeader !== null) {
      return Str\trim(self::$forcedHeader);
    }
    if (\file_exists($path.'/.LICENSE_HEADER.hh.txt')) {
      $header = \file_get_contents($path.'/.LICENSE_HEADER.hh.txt');
      return ($header === '' || $header === "\n") ? null : Str\trim($header);
    }

    $path = \dirname(\realpath($path));
    if (
      Str\starts_with($path, \realpath(\Facebook\AutoloadMap\Generated\root()))
    ) {
      return self::getLicenseHeaderForPath($path);
    }
    return null;
  }
}
