///|
/// # learncore trait 实现 / Learncore trait implementations
///
/// 为 Hyperparams / ModelSpace 实现 core/traits 中的 trait。

// ============================================================================
// ModelSpace — Named, Describable, Displayable
// ============================================================================

///|
pub impl @traits.Named for ModelSpace with name(self) {
  model_space_name(self)
}

pub extend ModelSpace with @traits.Named::{name}

///|
pub impl @traits.Describable for ModelSpace with describe(self) {
  "Model space: " + model_space_name(self)
}

pub extend ModelSpace with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for ModelSpace with display(self) {
  model_space_name(self) + " (Model space: " + model_space_name(self) + ")"
}

pub extend ModelSpace with @traits.Displayable::{display}

// ============================================================================
// Hyperparams — Named, Describable, Displayable, Countable, Cloneable, Serializable
// ============================================================================

///|
pub impl @traits.Named for Hyperparams with name(self) {
  self.name
}

pub extend Hyperparams with @traits.Named::{name}

///|
pub impl @traits.Describable for Hyperparams with describe(self) {
  "hyperparams=" + self.name + ",values_count=" + self.values.length().to_string()
}

pub extend Hyperparams with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for Hyperparams with display(self) {
  self.name + ": hyperparams,values_count=" + self.values.length().to_string()
}

pub extend Hyperparams with @traits.Displayable::{display}

///|
pub impl @traits.Countable for Hyperparams with count(self) {
  self.values.length()
}

pub extend Hyperparams with @traits.Countable::{count}

///|
pub impl @traits.Cloneable for Hyperparams with clone(self) {
  { name: self.name, values: self.values, }
}

pub extend Hyperparams with @traits.Cloneable::{clone}

///|
pub impl @traits.Serializable for Hyperparams with serialize(self) {
  let mut result = "Hyperparams{name=" + self.name + ",values=["
  let mut first = true
  for v in self.values {
    if first {
      first = false
    } else {
      result = result + ","
    }
    result = result + v
  }
  result = result + "]}"
  result
}

pub extend Hyperparams with @traits.Serializable::{serialize}