///|
/// # datair/ir_transform IR 转换 / IR Transform
///
/// IR 变换 pass：常量折叠、死代码消除、表达式简化。
/// S10.3 新建。
///
/// # IR transform passes

///|
/// 变换类型 / Transform type.
pub(all) enum TransformKind {
  ConstantFolding
  DeadCodeElimination
  ExpressionSimplification
  InlineExpansion
  LoopUnrolling
}

///|
/// 变换结果 / Transform result.
pub struct TransformResult {
  kind : TransformKind
  input_nodes : Int32
  output_nodes : Int32
  changed : Bool
  passes : Int32
}

///|
/// IR 节点类型 / IR node type.
pub(all) enum IRNodeKind {
  Constant
  Variable
  BinaryOp
  UnaryOp
  FunctionCall
  Branch
  Loop
  Return
}

///|
/// IR 节点 / IR node.
pub struct IRNode {
  kind : IRNodeKind
  value : String
  children : Array[Int32]
  is_dead : Bool
}

///|
/// 构造 IR 节点 / Create IR node.
pub fn make_node(
  kind : IRNodeKind,
  value : String,
  children : Array[Int32],
) -> IRNode {
  { kind, value, children, is_dead: false, }
}

///|
/// 构造变换结果 / Create transform result.
pub fn make_transform_result(
  kind : TransformKind,
  input_nodes : Int32,
  output_nodes : Int32,
  changed : Bool,
  passes : Int32,
) -> TransformResult {
  { kind, input_nodes, output_nodes, changed, passes, }
}

///===
/// 常量折叠 / Constant folding

///|
/// 尝试折叠二元运算 / Try folding binary operation.
pub fn fold_binary_op(op : String, left : Double, right : Double) -> Double? {
  if op == "+" {
    Some(left + right)
  } else if op == "-" {
    Some(left - right)
  } else if op == "*" {
    Some(left * right)
  } else if op == "/" {
    if right == 0.0 {
      None
    } else {
      Some(left / right)
    }
  } else {
    None
  }
}

///|
/// 尝试折叠一元运算 / Try folding unary operation.
pub fn fold_unary_op(op : String, operand : Double) -> Double? {
  if op == "-" {
    Some(-operand)
  } else if op == "abs" {
    if operand < 0.0 {
      Some(-operand)
    } else {
      Some(operand)
    }
  } else {
    None
  }
}

///|
/// 解析常量 / Parse constant value.
pub fn parse_constant(s : String) -> Double? {
  let mut result = 0.0
  let mut sign = 1.0
  let mut start = 0
  let mut has_dot = false
  let mut decimal_place = 0.1
  if s.length() == 0 {
    return None
  }
  if s[0].to_int() == 45 {
    sign = -1.0
    start = 1
  }
  for i in start..<s.length() {
    let code = s[i].to_int()
    if code == 46 {
      if has_dot {
        return None
      }
      has_dot = true
    } else if code >= 48 && code <= 57 {
      let digit = (code - 48).to_double()
      if has_dot {
        result = result + digit * decimal_place
        decimal_place = decimal_place * 0.1
      } else {
        result = result * 10.0 + digit
      }
    } else {
      return None
    }
  }
  Some(sign * result)
}

///===
/// 死代码消除 / Dead code elimination

///|
/// 标记死节点 / Mark node as dead.
pub fn mark_dead(nodes : Array[IRNode], index : Int32) -> Array[IRNode] {
  let result = nodes.copy()
  if index >= 0 && index < result.length() {
    result[index] = { ..result[index], is_dead: true, }
  }
  result
}

///|
/// 消除死节点 / Eliminate dead nodes.
pub fn eliminate_dead(nodes : Array[IRNode]) -> Array[IRNode] {
  let result : Array[IRNode] = []
  for i in 0..<nodes.length() {
    if !nodes[i].is_dead {
      result.push(nodes[i])
    }
  }
  result
}

///|
/// 统计活节点 / Count live nodes.
pub fn count_live_nodes(nodes : Array[IRNode]) -> Int32 {
  let mut count = 0
  for i in 0..<nodes.length() {
    if !nodes[i].is_dead {
      count = count + 1
    }
  }
  count
}

///===
/// 表达式简化 / Expression simplification

///|
/// 简化加法 / Simplify addition.
pub fn simplify_add(left : String, right : String) -> String {
  let l = parse_constant(left)
  let r = parse_constant(right)
  match (l, r) {
    (Some(lv), Some(rv)) => (lv + rv).to_string()
    (Some(0.0), _) => right
    (_, Some(0.0)) => left
    _ => left + " + " + right
  }
}

///|
/// 简化乘法 / Simplify multiplication.
pub fn simplify_mul(left : String, right : String) -> String {
  let l = parse_constant(left)
  let r = parse_constant(right)
  match (l, r) {
    (Some(lv), Some(rv)) => (lv * rv).to_string()
    (Some(0.0), _) => "0"
    (_, Some(0.0)) => "0"
    (Some(1.0), _) => right
    (_, Some(1.0)) => left
    _ => left + " * " + right
  }
}

///===
/// 变换 pass 执行 / Run transform passes

///|
/// 运行常量折叠 pass / Run constant folding pass.
pub fn run_constant_folding(nodes : Array[IRNode]) -> TransformResult {
  let input_count = nodes.length()
  let mut changed = false
  let mut output_count = input_count
  for i in 0..<nodes.length() {
    if is_binary_op(nodes[i].kind) {
      let parts = nodes[i].value.split(" ").to_array()
      if parts.length() == 3 {
        let left = parts[0].to_owned()
        let op = parts[1].to_owned()
        let right = parts[2].to_owned()
        let lv = parse_constant(left)
        let rv = parse_constant(right)
        match (lv, rv) {
          (Some(l), Some(r)) => {
            let folded = fold_binary_op(op, l, r)
            match folded {
              Some(v) => {
                changed = true
                output_count = output_count
              }
              None => ()
            }
          }
          _ => ()
        }
      }
    }
  }
  make_transform_result(ConstantFolding, input_count, output_count, changed, 1)
}

///|
/// 运行死代码消除 pass / Run dead code elimination pass.
pub fn run_dead_code_elimination(nodes : Array[IRNode]) -> TransformResult {
  let input_count = nodes.length()
  let live_count = count_live_nodes(nodes)
  let changed = input_count != live_count
  make_transform_result(
    DeadCodeElimination,
    input_count,
    live_count,
    changed,
    1,
  )
}

///|
///===
/// 变换名称 / Transform name
fn is_binary_op(kind : IRNodeKind) -> Bool {
  match kind {
    BinaryOp => true
    _ => false
  }
}

///|
pub fn transform_name(kind : TransformKind) -> String {
  match kind {
    ConstantFolding => "constant_folding"
    DeadCodeElimination => "dead_code_elimination"
    ExpressionSimplification => "expression_simplification"
    InlineExpansion => "inline_expansion"
    LoopUnrolling => "loop_unrolling"
  }
}

///|
///===
/// ID
pub fn ir_transform_id() -> String {
  "datair/ir_transform"
}
