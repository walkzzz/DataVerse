///|
/// # opcore/ingest 摄入与解析算子 / Ingest & Parse Operators
///
/// 多格式解析：PDF/HTML/Office/Markdown/代码/邮件/表格/音视频。架构 §4.3.2 ①。
/// S1.1 填充：text_formatter（对标 DJ text_formatter）。
///
/// # Ingest operators
///
/// Multi-format parsing. See architecture §4.3.2 ①.

///|
/// 文本格式化：把纯文本构造为 DataObject / Text formatter: build DataObject from raw text.
///
/// 对标 DJ `text_formatter`。模态默认 Text，schema 为空。
pub fn ingest_text_formatter(content : String) -> @dataobject.DataObject {
  @dataobject.make_dataobject(content, @dataobject.Text, @schema.empty())
}

///|
/// JSON 格式化：把字符串作为 JSON 内容摄入 / JSON formatter.
///
/// 对标 DJ `json_formatter`。模态 Text，schema 为空。
pub fn ingest_json_formatter(content : String) -> @dataobject.DataObject {
  @dataobject.make_dataobject(content, @dataobject.Text, @schema.empty())
}

///|
/// CSV 格式化：把字符串作为 CSV 内容摄入 / CSV formatter.
///
/// 对标 DJ `csv_formatter`。模态 Table，schema 为空。
pub fn ingest_csv_formatter(content : String) -> @dataobject.DataObject {
  @dataobject.make_dataobject(content, @dataobject.Table, @schema.empty())
}

///|
pub fn ingest_ingest_id() -> String {
  "opcore/ingest"
}
