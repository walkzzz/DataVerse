///|
/// # dataobject trait 实现 / DataObject trait implementations
///
/// 为 DataObject / Lineage / QualityCard / Modality 实现 core/traits 中的 trait。

// ============================================================================
// Modality — Named, Describable, Displayable
// ============================================================================

///|
pub impl @traits.Named for Modality with name(self) {
  match self {
    Text => "text"
    Image => "image"
    Audio => "audio"
    Video => "video"
    Table => "table"
    Code => "code"
    Multi => "multi"
  }
}

pub extend Modality with @traits.Named::{name}

///|
pub impl @traits.Describable for Modality with describe(self) {
  match self {
    Text => "Text modality"
    Image => "Image modality"
    Audio => "Audio modality"
    Video => "Video modality"
    Table => "Table modality"
    Code => "Code modality"
    Multi => "Multi modality"
  }
}

pub extend Modality with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for Modality with display(self) {
  let n = match self {
    Text => "text"
    Image => "image"
    Audio => "audio"
    Video => "video"
    Table => "table"
    Code => "code"
    Multi => "multi"
  }
  let d = match self {
    Text => "Text modality"
    Image => "Image modality"
    Audio => "Audio modality"
    Video => "Video modality"
    Table => "Table modality"
    Code => "Code modality"
    Multi => "Multi modality"
  }
  n + " (" + d + ")"
}

pub extend Modality with @traits.Displayable::{display}

// ============================================================================
// DataObject — Named, Describable, Displayable, Checkable, Cloneable, Serializable, Countable
// ============================================================================

///|
pub impl @traits.Named for DataObject with name(_self) {
  "DataObject"
}

pub extend DataObject with @traits.Named::{name}

///|
pub impl @traits.Describable for DataObject with describe(self) {
  let modality_name = match self.modality {
    Text => "text"
    Image => "image"
    Audio => "audio"
    Video => "video"
    Table => "table"
    Code => "code"
    Multi => "multi"
  }
  "content_len=" + self.content.length().to_string() + ", modality=" + modality_name
}

pub extend DataObject with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for DataObject with display(self) {
  let modality_name = match self.modality {
    Text => "text"
    Image => "image"
    Audio => "audio"
    Video => "video"
    Table => "table"
    Code => "code"
    Multi => "multi"
  }
  "DataObject[" + modality_name + "]: content_len=" + self.content.length().to_string()
}

pub extend DataObject with @traits.Displayable::{display}

///|
pub impl @traits.Checkable for DataObject with check(self) {
  self.content.length() > 0
}

pub extend DataObject with @traits.Checkable::{check}

///|
pub impl @traits.Cloneable for DataObject with clone(self) {
  {
    content: self.content,
    modality: self.modality,
    schema: self.schema,
    metadata: self.metadata,
    lineage: self.lineage,
  }
}

pub extend DataObject with @traits.Cloneable::{clone}

///|
pub impl @traits.Serializable for DataObject with serialize(self) {
  let modality_name = match self.modality {
    Text => "text"
    Image => "image"
    Audio => "audio"
    Video => "video"
    Table => "table"
    Code => "code"
    Multi => "multi"
  }
  let mut result = "DataObject{modality=" + modality_name
  result = result + ",content_len=" + self.content.length().to_string()
  result = result + ",metadata_count=" + self.metadata.length().to_string()
  result = result + "}"
  result
}

pub extend DataObject with @traits.Serializable::{serialize}

///|
pub impl @traits.Countable for DataObject with count(self) {
  self.content.length()
}

pub extend DataObject with @traits.Countable::{count}

// ============================================================================
// Lineage — Named, Describable, Displayable, Serializable
// ============================================================================

///|
pub impl @traits.Named for Lineage with name(_self) {
  "Lineage"
}

pub extend Lineage with @traits.Named::{name}

///|
pub impl @traits.Describable for Lineage with describe(self) {
  "graph=" + self.operator_graph + ",params=" + self.params
}

pub extend Lineage with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for Lineage with display(self) {
  "Lineage: graph=" + self.operator_graph + ",params=" + self.params
}

pub extend Lineage with @traits.Displayable::{display}

///|
pub impl @traits.Serializable for Lineage with serialize(self) {
  self.operator_graph + "|" + self.input_fingerprint + "|" + self.output_fingerprint + "|" + self.params + "|" + self.environment
}

pub extend Lineage with @traits.Serializable::{serialize}

// ============================================================================
// QualityCard — Named, Describable, Displayable, Checkable, Summarizable
// ============================================================================

///|
pub impl @traits.Named for QualityCard with name(_self) {
  "QualityCard"
}

pub extend QualityCard with @traits.Named::{name}

///|
pub impl @traits.Describable for QualityCard with describe(self) {
  "metrics=" + self.metrics.length().to_string() + ",verdict=" + self.verdict.to_string()
}

pub extend QualityCard with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for QualityCard with display(self) {
  "QualityCard: metrics=" + self.metrics.length().to_string() + ",verdict=" + self.verdict.to_string()
}

pub extend QualityCard with @traits.Displayable::{display}

///|
pub impl @traits.Checkable for QualityCard with check(self) {
  self.verdict
}

pub extend QualityCard with @traits.Checkable::{check}

///|
pub impl @traits.Summarizable for QualityCard with summary(self) {
  let mut result = "QualityCard{verdict=" + self.verdict.to_string()
  for item in self.metrics {
    result = result + ", " + item.0 + "=" + item.1.to_string()
  }
  result = result + "}"
  result
}

pub extend QualityCard with @traits.Summarizable::{summary}