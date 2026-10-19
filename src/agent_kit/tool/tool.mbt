///|
/// # agent_kit/tool 工具调用 / Tool Calling
///
/// 函数调用、参数解析、结果格式化。
/// S11.5 新建。
///
/// # Tool calling operators

/// 参数类型 / Parameter type.
pub(all) enum ParamType {
  StringType
  NumberType
  BoolType
  ArrayType
  ObjectType
}

/// 工具参数定义 / Tool parameter definition.
pub struct ToolParam {
  name : String
  param_type : ParamType
  description : String
  required : Bool
  default_value : String
}

/// 工具定义 / Tool definition.
pub struct ToolDef {
  name : String
  description : String
  parameters : Array[ToolParam]
}

/// 工具调用 / Tool call.
pub struct ToolCall {
  tool_name : String
  arguments : Array[(String, String)]
  id : String
}

/// 工具结果 / Tool result.
pub struct ToolResult {
  call_id : String
  success : Bool
  output : String
  error : String
  execution_time : Double
}

/// 构造工具参数 / Create tool parameter.
pub fn make_param(
  name : String,
  param_type : ParamType,
  description : String,
  required : Bool,
  default_value : String,
) -> ToolParam {
  { name: name, param_type: param_type, description: description, required: required, default_value: default_value }
}

/// 构造工具定义 / Create tool definition.
pub fn make_tool_def(name : String, description : String, parameters : Array[ToolParam]) -> ToolDef {
  { name: name, description: description, parameters: parameters }
}

/// 构造工具调用 / Create tool call.
pub fn make_tool_call(tool_name : String, arguments : Array[(String, String)], id : String) -> ToolCall {
  { tool_name: tool_name, arguments: arguments, id: id }
}

/// 构造工具结果 / Create tool result.
pub fn make_tool_result(
  call_id : String,
  success : Bool,
  output : String,
  error : String,
  execution_time : Double,
) -> ToolResult {
  { call_id: call_id, success: success, output: output, error: error, execution_time: execution_time }
}

///===
/// 参数验证 / Parameter validation

/// 验证参数 / Validate arguments against tool definition.
pub fn validate_arguments(tool : ToolDef, args : Array[(String, String)]) -> Bool {
  for i in 0..<tool.parameters.length() {
    if tool.parameters[i].required {
      let mut found = false
      for j in 0..<args.length() {
        if args[j].0 == tool.parameters[i].name {
          found = true
        }
      }
      if not(found) {
        return false
      }
    }
  }
  true
}

/// 获取参数值 / Get argument value.
pub fn get_argument(args : Array[(String, String)], name : String) -> String? {
  for i in 0..<args.length() {
    if args[i].0 == name {
      return Some(args[i].1)
    }
  }
  None
}

/// 获取必选参数 / Get required argument.
pub fn get_required_argument(args : Array[(String, String)], name : String) -> String {
  match get_argument(args, name) {
    Some(v) => v
    None => ""
  }
}

///===
/// 参数类型转换 / Parameter type conversion

/// 转换为整数 / Convert to int.
pub fn to_int_arg(value : String) -> Int? {
  let mut result = 0
  let mut sign = 1
  let mut start = 0
  if value.length() == 0 {
    return None
  }
  if value[0].to_int() == 45 {
    sign = -1
    start = 1
  }
  for i in start..<value.length() {
    let code = value[i].to_int()
    if code < 48 || code > 57 {
      return None
    }
    result = result * 10 + (code - 48)
  }
  Some(sign * result)
}

/// 转换为浮点 / Convert to double.
pub fn to_double_arg(value : String) -> Double? {
  let mut result = 0.0
  let mut sign = 1.0
  let mut start = 0
  let mut has_dot = false
  let mut decimal_place = 0.1
  if value.length() == 0 {
    return None
  }
  if value[0].to_int() == 45 {
    sign = -1.0
    start = 1
  }
  for i in start..<value.length() {
    let code = value[i].to_int()
    if code == 46 {
      if has_dot { return None }
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

/// 转换为布尔 / Convert to bool.
pub fn to_bool_arg(value : String) -> Bool? {
  if value == "true" || value == "1" {
    Some(true)
  } else if value == "false" || value == "0" {
    Some(false)
  } else {
    None
  }
}

///===
/// 结果格式化 / Result formatting

/// 成功结果 / Create success result.
pub fn success_result(call_id : String, output : String, execution_time : Double) -> ToolResult {
  make_tool_result(call_id, true, output, "", execution_time)
}

/// 错误结果 / Create error result.
pub fn error_result(call_id : String, error : String, execution_time : Double) -> ToolResult {
  make_tool_result(call_id, false, "", error, execution_time)
}

/// 结果转 JSON / Convert result to JSON-like string.
pub fn result_to_json(result : ToolResult) -> String {
  let status = if result.success { "true" } else { "false" }
  "{\"call_id\": \"" + result.call_id + "\", \"success\": " + status + ", \"output\": \"" + result.output + "\", \"error\": \"" + result.error + "\"}"
}

///===
/// 参数类型名称 / Parameter type name

pub fn param_type_name(pt : ParamType) -> String {
  match pt {
    StringType => "string"
    NumberType => "number"
    BoolType => "boolean"
    ArrayType => "array"
    ObjectType => "object"
  }
}

///===
/// ID

pub fn tool_id() -> String {
  "agent_kit/tool"
}