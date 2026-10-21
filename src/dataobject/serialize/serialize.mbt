///|
/// # dataobject/serialize 数据序列化 / Data Serialization
///
/// 数据序列化算子。S10.1 新建。
/// JSON / CSV / Binary 序列化 + 数据验证 + 类型转换。
///
/// # Data serialization operators

/// 序列化格式 / Serialization format.
pub(all) enum SerializeFormat {
  JSON
  CSV
  TSV
  Binary
  XML
  YAML
}

/// 序列化结果 / Serialization result.
pub struct SerializeResult {
  format : SerializeFormat
  data : String
  size : Int
  success : Bool
  error_msg : String
}

/// 格式名称 / Format name.
pub fn format_name(fmt : SerializeFormat) -> String {
  match fmt {
    JSON => "json"
    CSV => "csv"
    TSV => "tsv"
    Binary => "binary"
    XML => "xml"
    YAML => "yaml"
  }
}

/// 构造序列化结果 / Create serialize result.
pub fn make_serialize_result(
  format : SerializeFormat,
  data : String,
  success : Bool,
  error_msg : String,
) -> SerializeResult {
  { format: format, data: data, size: data.length(), success: success, error_msg: error_msg }
}

///===
/// JSON 序列化

/// JSON 转义 / Escape JSON string.
pub fn json_escape(s : String) -> String {
  let bs = String::from_array([Int::unsafe_to_char(92)])
  let bs2 = String::from_array([Int::unsafe_to_char(92), Int::unsafe_to_char(92)])
  let q = "\""
  let eq = String::from_array([Int::unsafe_to_char(92), '"'])
  let n = "\n"
  let en = String::from_array([Int::unsafe_to_char(92), 'n'])
  let r = "\r"
  let er = String::from_array([Int::unsafe_to_char(92), 'r'])
  let t = "\t"
  let et = String::from_array([Int::unsafe_to_char(92), 't'])
  s.replace(old=bs, new=bs2)
   .replace(old=q, new=eq)
   .replace(old=n, new=en)
   .replace(old=r, new=er)
   .replace(old=t, new=et)
}

/// JSON 字符串值 / JSON string value.
pub fn json_string_value(key : String, value : String) -> String {
  "\"" + json_escape(key) + "\": \"" + json_escape(value) + "\""
}

/// JSON 数值 / JSON number value.
pub fn json_number_value(key : String, value : Double) -> String {
  "\"" + json_escape(key) + "\": " + value.to_string()
}

/// JSON 布尔值 / JSON boolean value.
pub fn json_bool_value(key : String, value : Bool) -> String {
  "\"" + json_escape(key) + "\": " + (if value { "true" } else { "false" })
}

/// JSON 数组 / JSON array.
pub fn json_array(values : Array[String]) -> String {
  let mut result = "["
  for i in 0..<values.length() {
    if i > 0 {
      result = result + ", "
    }
    result = result + values[i]
  }
  result + "]"
}

/// JSON 对象 / JSON object.
pub fn json_object(pairs : Array[String]) -> String {
  let mut result = "{"
  for i in 0..<pairs.length() {
    if i > 0 {
      result = result + ", "
    }
    result = result + pairs[i]
  }
  result + "}"
}

///===
/// CSV 序列化

/// CSV 转义 / Escape CSV field.
pub fn csv_escape(field : String, delimiter : String) -> String {
  let needs_quote = field.contains(delimiter) || field.contains("\n") || field.contains("\"")
  if needs_quote {
    "\"" + field.replace(old="\"", new="\"\"") + "\""
  } else {
    field
  }
}

/// CSV 行 / CSV row.
pub fn csv_row(fields : Array[String], delimiter : String) -> String {
  let mut result = ""
  for i in 0..<fields.length() {
    if i > 0 {
      result = result + delimiter
    }
    result = result + csv_escape(fields[i], delimiter)
  }
  result
}

/// CSV 表格 / CSV table.
pub fn csv_table(rows : Array[Array[String]], delimiter : String) -> String {
  let mut result = ""
  for i in 0..<rows.length() {
    if i > 0 {
      result = result + "\n"
    }
    result = result + csv_row(rows[i], delimiter)
  }
  result
}

///===
/// 数据验证

/// 验证结果 / Validation result.
pub struct ValidationResult {
  valid : Bool
  errors : Array[String]
  warnings : Array[String]
}

/// 构造验证结果 / Create validation result.
pub fn make_validation_result(
  valid : Bool,
  errors : Array[String],
  warnings : Array[String],
) -> ValidationResult {
  { valid: valid, errors: errors, warnings: warnings }
}

/// 验证非空 / Validate non-empty.
pub fn validate_non_empty(value : String, field_name : String) -> ValidationResult {
  if value.length() == 0 {
    { valid: false, errors: [field_name + " is empty"], warnings: [] }
  } else {
    { valid: true, errors: [], warnings: [] }
  }
}

/// 验证长度范围 / Validate length range.
pub fn validate_length(
  value : String,
  min_len : Int,
  max_len : Int,
  field_name : String,
) -> ValidationResult {
  let len = value.length()
  if len < min_len {
    { valid: false, errors: [field_name + " too short (min " + min_len.to_string() + ")"], warnings: [] }
  } else if len > max_len {
    { valid: false, errors: [field_name + " too long (max " + max_len.to_string() + ")"], warnings: [] }
  } else {
    { valid: true, errors: [], warnings: [] }
  }
}

/// 验证数值范围 / Validate numeric range.
pub fn validate_range(
  value : Double,
  min_val : Double,
  max_val : Double,
  field_name : String,
) -> ValidationResult {
  if value < min_val {
    { valid: false, errors: [field_name + " below minimum " + min_val.to_string()], warnings: [] }
  } else if value > max_val {
    { valid: false, errors: [field_name + " above maximum " + max_val.to_string()], warnings: [] }
  } else {
    { valid: true, errors: [], warnings: [] }
  }
}

/// 验证正则模式 / Validate pattern (simplified, contains check).
pub fn validate_pattern(
  value : String,
  pattern : String,
  field_name : String,
) -> ValidationResult {
  if value.contains(pattern) {
    { valid: true, errors: [], warnings: [] }
  } else {
    { valid: false, errors: [field_name + " does not match pattern"], warnings: [] }
  }
}

///===
/// 类型转换

/// 字符串转整数 / String to int (safe).
pub fn to_int_safe(s : String) -> Int? {
  let mut result = 0
  let mut sign = 1
  let mut start = 0
  if s.length() == 0 {
    return None
  }
  if s[0] == '-' {
    sign = -1
    start = 1
  } else if s[0] == '+' {
    start = 1
  }
  for i in start..<s.length() {
    let ch = s[i]
    if ch < '0' || ch > '9' {
      return None
    }
    result = result * 10 + (ch.to_int() - '0'.to_int())
  }
  Some(sign * result)
}

/// 字符串转浮点 / String to double (safe, simplified).
pub fn to_double_safe(s : String) -> Double? {
  let mut result = 0.0
  let mut sign = 1.0
  let mut start = 0
  let mut has_dot = false
  let mut decimal_place = 0.1
  if s.length() == 0 {
    return None
  }
  if s[0] == '-' {
    sign = -1.0
    start = 1
  } else if s[0] == '+' {
    start = 1
  }
  for i in start..<s.length() {
    let ch = s[i]
    if ch == '.' {
      if has_dot {
        return None
      }
      has_dot = true
    } else if ch >= '0' && ch <= '9' {
      let digit = (ch.to_int() - '0'.to_int()).to_double()
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

/// 整数转字符串 / Int to string with padding.
pub fn int_to_padded(value : Int, width : Int) -> String {
  let s = value.to_string()
  if s.length() >= width {
    return s
  }
  let padding = "0".repeat(width - s.length())
  padding + s
}

/// 布尔转字符串 / Bool to string.
pub fn bool_to_string(value : Bool) -> String {
  if value { "true" } else { "false" }
}

/// 字符串转布尔 / String to bool.
pub fn string_to_bool(s : String) -> Bool? {
  if s == "true" || s == "True" || s == "TRUE" || s == "1" {
    Some(true)
  } else if s == "false" || s == "False" || s == "FALSE" || s == "0" {
    Some(false)
  } else {
    None
  }
}

///===
/// 编码/解码

/// Base64 编码（简化）/ Base64 encode (simplified).
pub fn base64_encode(data : String) -> String {
  let result : Array[Char] = []
  let bytes = data.to_array()
  let mut i = 0
  while i < bytes.length() {
    let b1 = bytes[i].to_int()
    let b2 = if i + 1 < bytes.length() { bytes[i + 1].to_int() } else { -1 }
    let b3 = if i + 2 < bytes.length() { bytes[i + 2].to_int() } else { -1 }
    let enc1 = b1 >> 2
    let enc2 = ((b1 & 0x03) << 4) | (if b2 >= 0 { b2 >> 4 } else { 0 })
    let enc3 = if b2 >= 0 { ((b2 & 0x0f) << 2) | (if b3 >= 0 { b3 >> 6 } else { 0 }) } else { 64 }
    let enc4 = if b3 >= 0 { b3 & 0x3f } else { 64 }
    result.push(b64_digit_char(enc1))
    result.push(b64_digit_char(enc2))
    if enc3 < 64 {
      result.push(b64_digit_char(enc3))
    } else {
      result.push('=')
    }
    if enc4 < 64 {
      result.push(b64_digit_char(enc4))
    } else {
      result.push('=')
    }
    i = i + 3
  }
  String::from_array(result)
}

fn b64_digit_char(d : Int) -> Char {
  if d < 26 {
    Int::unsafe_to_char(d + 65)
  } else if d < 52 {
    Int::unsafe_to_char(d + 71)
  } else if d < 62 {
    Int::unsafe_to_char(d - 4)
  } else if d == 62 {
    '+'
  } else {
    '/'
  }
}

/// 十六进制编码 / Hex encode.
pub fn hex_encode(data : String) -> String {
  let result : Array[Char] = []
  for i in 0..<data.length() {
    let ch = data[i]
    let code = ch.to_int()
    result.push(hex_digit_char((code >> 4) & 0x0f))
    result.push(hex_digit_char(code & 0x0f))
  }
  String::from_array(result)
}

fn hex_digit_char(d : Int) -> Char {
  if d < 10 {
    Int::unsafe_to_char(d + 48)
  } else {
    Int::unsafe_to_char(d + 87)
  }
}

///===
/// ID

pub fn serialize_id() -> String {
  "dataobject/serialize"
}