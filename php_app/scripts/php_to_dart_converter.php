<?php

require 'vendor/autoload.php';

use PhpParser\Error;
use PhpParser\Node;
use PhpParser\NodeDumper;
use PhpParser\ParserFactory;
use PhpParser\PrettyPrinter;
use PhpParser\NodeFinder;

class PhpToDartConverter
{
    private $parser;

    public function __construct()
    {
        $this->parser = (new ParserFactory)->createForNewestSupportedVersion();
    }

    public function convert($phpCode)
    {
        try {
            $stmts = $this->parser->parse($phpCode);
            return $this->convertStatements($stmts);
        } catch (Error $e) {
            return "/* Parse Error: {$e->getMessage()} */";
        }
    }


    private function convertStatements($stmts, $indent = 2)
    {
        $dart = "";
        foreach ($stmts as $stmt) {
            $dart .= $this->convertStatement($stmt, $indent);
        }
        return $dart;
    }

    private function convertStatement(Node $node, $indent = 2)
    {
        $indentStr = str_repeat(' ', $indent);
        
        if ($node instanceof Node\Stmt\Return_) {
            $expr = $this->convertExpression($node->expr);
            if (str_starts_with($expr, "'") && str_ends_with($expr, "'")) {
                return "$indentStr  return $expr;\n";
            }
            return "$indentStr  return ($expr).toString();\n";
        }
        
        if ($node instanceof Node\Stmt\If_) {
            return $this->convertIf($node, $indent);
        }
        
        if ($node instanceof Node\Stmt\Expression) {
            return $indentStr . $this->convertExpression($node->expr) . ";\n";
        }
        
        if ($node instanceof Node\Stmt\Static_) {
            $vars = [];
            foreach ($node->vars as $var) {
                $name = $var->var->name;
                $default = $this->convertExpression($var->default);
                $vars[] = "var $name = $default";
            }
            return $indentStr . implode(", ", $vars) . ";\n";
        }

        if ($node instanceof Node\Stmt\Switch_) {
            $cond = $this->convertExpression($node->cond);
            $dart = "$indentStr  switch ($cond) {\n";
            foreach ($node->cases as $case) {
                if ($case->cond) {
                    $caseCond = $this->convertExpression($case->cond);
                    $dart .= "$indentStr    case $caseCond:\n";
                } else {
                    $dart .= "$indentStr    default:\n";
                }
                $dart .= $this->convertStatements($case->stmts, $indent + 4);
            }
            $dart .= "$indentStr  }\n";
            return $dart;
        }
        
        if ($node instanceof Node\Stmt\Break_) {
            return "$indentStr  break;\n";
        }
        
        return '';
    }
    
    private function convertIf(Node\Stmt\If_ $node, $indent)
    {
        $indentStr = str_repeat(' ', $indent);
        $cond = $this->convertExpression($node->cond);
        $dart = "$indentStr  if ($cond) {\n";
        $dart .= $this->convertStatements($node->stmts, $indent + 2);
        $dart .= "$indentStr  }\n";
        
        foreach ($node->elseifs as $elseif) {
            $cond = $this->convertExpression($elseif->cond);
            $dart .= "$indentStr  else if ($cond) {\n";
            $dart .= $this->convertStatements($elseif->stmts, $indent + 2);
            $dart .= "$indentStr  }\n";
        }
        
        if ($node->else) {
            $dart .= "$indentStr  else {\n";
            $dart .= $this->convertStatements($node->else->stmts, $indent + 2);
            $dart .= "$indentStr  }\n";
        }
        
        return $dart;
    }
    
    public function convertExpression($node)
    {
        if (!$node) return '';
        
        // echo "Converting Expression: " . get_class($node) . "\n";
        
        // If it's an arrow function, we need to convert it to a Dart function body
        if ($node instanceof Node\Expr\ArrowFunction) {
             $expr = $this->convertExpression($node->expr);
             return "return $expr;";
        }
        
        if ($node instanceof Node\Expr\Assign) {
            $var = $this->convertExpression($node->var);
            $expr = $this->convertExpression($node->expr);
            return "$var = $expr";
        }
        
        if ($node instanceof Node\Expr\AssignOp\Concat) {
            $var = $this->convertExpression($node->var);
            $expr = $this->convertExpression($node->expr);
            return "$var += $expr";
        }

        if ($node instanceof Node\Expr\Array_) {
            $items = [];
            $isMap = false;
            foreach ($node->items as $item) {
                if ($item->key) {
                    $isMap = true;
                    $key = $this->convertExpression($item->key);
                    $value = $this->convertExpression($item->value);
                    $items[] = "$key: $value";
                } else {
                    $items[] = $this->convertExpression($item->value);
                }
            }
            
            if ($isMap) {
                return "{" . implode(", ", $items) . "}";
            }
            return "[" . implode(", ", $items) . "]";
        }
        
        if ($node instanceof Node\Scalar\Encapsed) {
            $parts = [];
            foreach ($node->parts as $part) {
                if ($part instanceof Node\Scalar\EncapsedStringPart) {
                    $val = addslashes($part->value);
                    $val = str_replace('$', '\$', $val);
                    $parts[] = $val;
                } else {
                    $expr = $this->convertExpression($part);
                    $parts[] = "\${$expr}";
                }
            }
            return "'" . implode("", $parts) . "'";
        }

        if ($node instanceof Node\Expr\BinaryOp\Smaller) {
            return $this->convertExpression($node->left) . ' < ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Identical) {
            return $this->convertExpression($node->left) . ' == ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof \PhpParser\Node\Expr\BinaryOp\NotIdentical) {
            return $this->convertExpression($node->left) . ' != ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Equal) {
            return $this->convertExpression($node->left) . ' == ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\BooleanOr) {
            return $this->convertExpression($node->left) . ' || ' . $this->convertExpression($node->right);
        }

        if ($node instanceof Node\Expr\BinaryOp\BooleanAnd) {
            return $this->convertExpression($node->left) . ' && ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Coalesce) {
            return $this->convertExpression($node->left) . ' ?? ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Mod) {
            return $this->convertExpression($node->left) . ' % ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Div) {
            return $this->convertExpression($node->left) . ' / ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Mul) {
            return $this->convertExpression($node->left) . ' * ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Concat) {
            $left = $this->convertExpression($node->left);
            $right = $this->convertExpression($node->right);
            
            // Helper to format for interpolation
            $format = function($expr) {
                if (str_starts_with($expr, "'") && str_ends_with($expr, "'")) {
                    return substr($expr, 1, -1);
                }
                // Use explicit concatenation to ensure ${} is generated correctly
                return '$' . '{' . $expr . '}';
            };
            
            $leftStr = $format($left);
            $rightStr = $format($right);
            
            return "'$leftStr$rightStr'";
        }

        if ($node instanceof Node\Expr\BinaryOp\Plus) {
            return $this->convertExpression($node->left) . ' + ' . $this->convertExpression($node->right);
        }

        if ($node instanceof Node\Expr\BinaryOp\Minus) {
            return $this->convertExpression($node->left) . ' - ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\GreaterOrEqual) {
            return $this->convertExpression($node->left) . ' >= ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\SmallerOrEqual) {
            return $this->convertExpression($node->left) . ' <= ' . $this->convertExpression($node->right);
        }
        
        if ($node instanceof Node\Expr\BinaryOp\Greater) {
            return $this->convertExpression($node->left) . ' > ' . $this->convertExpression($node->right);
        }

        if ($node instanceof Node\Expr\UnaryMinus) {
            return '-' . $this->convertExpression($node->expr);
        }
        
        if ($node instanceof Node\Expr\UnaryPlus) {
            return $this->convertExpression($node->expr);
        }
        
        if ($node instanceof Node\Expr\Cast\Int_) {
            $expr = $this->convertExpression($node->expr);
            if (strpos($expr, ' / ') !== false) {
                return str_replace(' / ', ' ~/ ', $expr);
            }
            return "($expr).toInt()";
        }
        
        if ($node instanceof Node\Expr\Ternary) {
            $cond = $this->convertExpression($node->cond);
            $if = $this->convertExpression($node->if ?: $node->cond);
            $else = $this->convertExpression($node->else);
            return "($cond ? $if : $else)";
        }
        
        if ($node instanceof Node\Expr\Match_) {
            return $this->convertMatch($node);
        }
        
        if ($node instanceof Node\Expr\FuncCall) {
            $name = $node->name instanceof Node\Name ? $node->name->toString() : '';
            if (str_ends_with($name, 'in_array')) {
                $needle = $this->convertExpression($node->args[0]->value);
                $haystack = $this->convertExpression($node->args[1]->value);
                return "($haystack).contains($needle)";
            }
            if ($name === 'preg_match') {
                $pattern = $this->convertExpression($node->args[0]->value);
                $subject = $this->convertExpression($node->args[1]->value);
                $pattern = $this->stripQuotes($pattern);
                return "RegExp(r'$pattern').hasMatch($subject)";
            }
        }

        if ($node instanceof Node\Expr\Variable) {
            return $node->name;
        }
        
        if ($node instanceof Node\Scalar\LNumber || $node instanceof Node\Scalar\DNumber) {
            return (string)$node->value;
        }
        
        if ($node instanceof Node\Scalar\String_) {
            $val = addslashes($node->value);
            $val = str_replace('$', '\$', $val);
            return "'" . $val . "'";
        }
        
        if ($node instanceof Node\Expr\ArrayDimFetch) {
            $var = $this->convertExpression($node->var);
            $dim = $this->convertExpression($node->dim);
            return "{$var}[$dim]";
        }
        
        return '';
    }
    
    public function convertFunction($phpCode)
    {
        // Wrap in function to parse if it's just a closure body or closure
        if (!str_contains($phpCode, 'function') && !str_contains($phpCode, 'fn')) {
            $phpCode = "<?php return function() { $phpCode; };";
        } else {
             $phpCode = '<?php ' . $phpCode . ';';
        }
        
        // echo "Parsing PHP Code: $phpCode\n";
        // echo "Hex PHP Code: " . bin2hex($phpCode) . "\n";
        
        try {
            $stmts = $this->parser->parse($phpCode);
        } catch (Error $e) {
            return '/* Parse Error: ' . $e->getMessage() . ' Code: ' . bin2hex($phpCode) . ' */';
        }
            
            // Find the return statement or the function
            // Find the return statement or the function
            foreach ($stmts as $stmt) {
                $funcNode = null;
                if ($stmt instanceof Node\Stmt\Return_) {
                    if ($stmt->expr instanceof Node\Expr\Closure || $stmt->expr instanceof Node\Expr\ArrowFunction) {
                        $funcNode = $stmt->expr;
                    }
                } elseif ($stmt instanceof Node\Stmt\Expression) {
                    if ($stmt->expr instanceof Node\Expr\Closure || $stmt->expr instanceof Node\Expr\ArrowFunction) {
                        $funcNode = $stmt->expr;
                    }
                }

                if ($funcNode) {
                    // Find variables that need declaration (hoisting)
                    $finder = new NodeFinder();
                    $assignments = $finder->findInstanceOf($funcNode, Node\Expr\Assign::class);
                    $vars = [];
                    foreach ($assignments as $assign) {
                        if ($assign->var instanceof Node\Expr\Variable && is_string($assign->var->name)) {
                            $vars[$assign->var->name] = true;
                        }
                    }
                    
                    // Remove parameters from declarations
                    foreach ($funcNode->params as $param) {
                        if ($param->var instanceof Node\Expr\Variable && is_string($param->var->name)) {
                            unset($vars[$param->var->name]);
                        }
                    }
                    
                    $declarations = "";
                    if (!empty($vars)) {
                        foreach (array_keys($vars) as $varName) {
                            $declarations .= "  var $varName;\n";
                        }
                    }

                    if ($funcNode instanceof Node\Expr\Closure) {
                        // Check last statement for implicit return
                        $lastStmtIdx = count($funcNode->stmts) - 1;
                        if ($lastStmtIdx >= 0) {
                            $lastStmt = $funcNode->stmts[$lastStmtIdx];
                            if ($lastStmt instanceof Node\Stmt\Expression) {
                                $funcNode->stmts[$lastStmtIdx] = new Node\Stmt\Return_($lastStmt->expr);
                            }
                        }
                        return $declarations . $this->convertStatements($funcNode->stmts);
                    }
                    if ($funcNode instanceof Node\Expr\ArrowFunction) {
                        $expr = $this->convertExpression($funcNode->expr);
                        return $declarations . "  return ($expr).toString();\n";
                    }
                }
            }
            
            return "/* Could not find closure in code */";
    }

    // ... (convertStatements, convertStatement, convertIf, convertExpression) ...

    private function convertMatch(Node\Expr\Match_ $node)
    {
        $cond = $this->convertExpression($node->cond);
        $dart = "";
        
        $defaultArm = null;
        $otherArms = [];
        
        foreach ($node->arms as $arm) {
            if ($arm->conds === null) {
                $defaultArm = $arm;
            } else {
                $otherArms[] = $arm;
            }
        }
        
        $count = count($otherArms);
        foreach ($otherArms as $arm) {
            $body = $this->convertExpression($arm->body);
            $conditions = [];
            foreach ($arm->conds as $condExpr) {
                $val = $this->convertExpression($condExpr);
                $conditions[] = "$cond == $val";
            }
            $condition = implode(' || ', $conditions);
            $dart .= "($condition ? $body : ";
        }
        
        if ($defaultArm) {
            $dart .= $this->convertExpression($defaultArm->body);
        } else {
            $dart .= "''";
        }
        
        $dart .= str_repeat(')', $count);
        
        return $dart;
    }

    private function stripQuotes($str) {
        if ((str_starts_with($str, "'") && str_ends_with($str, "'")) || 
            (str_starts_with($str, '"') && str_ends_with($str, '"'))) {
            return substr($str, 1, -1);
        }
        return "\${" . $str . "}";
    }
}
