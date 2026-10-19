///|
/// # io/format 数据格式 / Format
///
/// 数据格式转换：行列转换、Schema 推断、类型转换。
/// S10.6 新建。
///
/// # Data format conversion

/// 数据类型 / Data type.
pub(all) enum DataType {
  StringType
  IntType
  FloatType
  BoolType
  NullType
} derive(Eq, Debug)

/// 列定义 / Column definition.
pub struct ColumnDef {
  name : String
  data_type : DataType
  nullable : Bool
}

/// 行数据 / Row data.
pub struct Row {
  values : Array[String]
}

/// 表数据 / Table data.
pub struct Table {
  columns : Array[ColumnDef]
  rows : Array[Row]
}

/// 构造列定义 / Create column definition.
pub fn make_column(name : String, data_type : DataType, nullable : Bool) -> ColumnDef {
  { name: name, data_type: data_type, nullable: nullable }
}

/// 构造行 / Create row.
pub fn make_row(values : Array[String]) -> Row {
  { values: values }
}

/// 构造表 / Create table.
pub fn make_table(columns : Array[ColumnDef], rows : Array[Row]) -> Table {
  { columns: columns, rows: rows }
}

///===
/// Schema 推断 / Schema inference

/// 推断数据类型 / Infer data type from string.
pub fn infer_type(s : String) -> DataType {
  if s == "" || s == "null" || s == "NULL" || s == "None" {
    NullType
  } else if s == "true" || s == "false" || s == "True" || s == "False" {
    BoolType
  } else if is_int_string(s) {
    IntType
  } else if is_float_string(s) {
    FloatType
  } else {
    StringType
  }
}

fn is_int_string(s : String) -> Bool {
  if s.length() == 0 {
    return false
  }
  let mut start = 0
  if s[0].to_int() == 45 || s[0].to_int() == 43 {
    start = 1
  }
  if start >= s.length() {
    return false
  }
  for i in start..<s.length() {
    let code = s[i].to_int()
    if code < 48 || code > 57 {
      return false
    }
  }
  true
}

fn is_float_string(s : String) -> Bool {
  if s.length() == 0 {
    return false
  }
  let mut has_dot = false
  let mut has_digit = false
  let mut start = 0
  if s[0].to_int() == 45 || s[0].to_int() == 43 {
    start = 1
  }
  for i in start..<s.length() {
    let code = s[i].to_int()
    if code == 46 {
      if has_dot { return false }
      has_dot = true
    } else if code >= 48 && code <= 57 {
      has_digit = true
    } else {
      return false
    }
  }
  has_dot && has_digit
}

/// 推断列类型 / Infer column type from values.
pub fn infer_column_type(values : Array[String]) -> DataType {
  if values.length() == 0 {
    return NullType
  }
  let mut has_null = false
  let mut has_string = false
  let mut has_float = false
  let mut has_int = false
  let mut has_bool = false
  for i in 0..<values.length() {
    let t = infer_type(values[i])
    match t {
      NullType => has_null = true
      StringType => has_string = true
      FloatType => has_float = true
      IntType => has_int = true
      BoolType => has_bool = true
    }
  }
  if has_string {
    StringType
  } else if has_float {
    FloatType
  } else if has_int && has_bool {
    StringType
  } else if has_int {
    IntType
  } else if has_bool {
    BoolType
  } else {
    NullType
  }
}

///===
/// 行列转换 / Row-column transpose

/// 转置表 / Transpose table (rows to columns).
pub fn transpose_table(table : Table) -> Table {
  if table.rows.length() == 0 {
    return make_table([], [])
  }
  let num_cols = table.rows[0].values.length()
  let new_columns : Array[ColumnDef] = []
  for i in 0..<table.rows.length() {
    new_columns.push(make_column("row" + i.to_string(), StringType, true))
  }
  let new_rows : Array[Row] = []
  for col_idx in 0..<num_cols {
    let values : Array[String] = []
    for row_idx in 0..<table.rows.length() {
      if col_idx < table.rows[row_idx].values.length() {
        values.push(table.rows[row_idx].values[col_idx])
      } else {
        values.push("")
      }
    }
    new_rows.push(make_row(values))
  }
  make_table(new_columns, new_rows)
}

///===
/// 类型名称 / Type name

pub fn type_name(dt : DataType) -> String {
  match dt {
    StringType => "string"
    IntType => "int"
    FloatType => "float"
    BoolType => "bool"
    NullType => "null"
  }
}

///===
/// 表统计 / Table statistics

pub fn row_count(table : Table) -> Int {
  table.rows.length()
}

pub fn column_count(table : Table) -> Int {
  table.columns.length()
}

/// 获取列索引 / Get column index by name.
pub fn column_index(table : Table, name : String) -> Int? {
  for i in 0..<table.columns.length() {
    if table.columns[i].name == name {
      return Some(i)
    }
  }
  None
}

/// 获取列值 / Get column values.
pub fn column_values(table : Table, col_idx : Int) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<table.rows.length() {
    if col_idx < table.rows[i].values.length() {
      result.push(table.rows[i].values[col_idx])
    } else {
      result.push("")
    }
  }
  result
}

///===
/// ID

pub fn format_id() -> String {
  "io/format"
}