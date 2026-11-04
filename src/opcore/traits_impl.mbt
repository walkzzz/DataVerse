///|
/// # opcore trait 实现 / Operator trait implementations
///
/// 为 Operator / OperatorResult / OperatorCategory 实现 core/traits 中的 trait。

// ============================================================================
// OperatorCategory — Named, Describable, Displayable
// ============================================================================

///|
pub impl @traits.Named for OperatorCategory with name(self) {
  category_name(self)
}

pub extend OperatorCategory with @traits.Named::{name}

///|
pub impl @traits.Describable for OperatorCategory with describe(self) {
  "Operator category: " + category_name(self)
}

pub extend OperatorCategory with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for OperatorCategory with display(self) {
  category_name(self) + " (Operator category: " + category_name(self) + ")"
}

pub extend OperatorCategory with @traits.Displayable::{display}

// ============================================================================
// Operator — Named, Describable, Displayable, Checkable, Verifiable, Runnable, Cloneable
// ============================================================================

///|
pub impl @traits.Named for Operator with name(self) {
  self.name
}

pub extend Operator with @traits.Named::{name}

///|
pub impl @traits.Describable for Operator with describe(self) {
  "operator=" + self.name + ",category=" + category_name(self.category) + ",reversible=" + self.reversible.to_string()
}

pub extend Operator with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for Operator with display(self) {
  self.name + ": operator=" + self.name + ",category=" + category_name(self.category)
}

pub extend Operator with @traits.Displayable::{display}

///|
pub impl @traits.Checkable for Operator with check(self) {
  self.name.length() > 0
}

pub extend Operator with @traits.Checkable::{check}

///|
pub impl @traits.Verifiable for Operator with verify(self) {
  self.name.length() > 0
}

pub extend Operator with @traits.Verifiable::{verify}

///|
pub impl @traits.Runnable for Operator with run(self) {
  "executing operator: " + self.name + " [" + category_name(self.category) + "]"
}

pub extend Operator with @traits.Runnable::{run}

///|
pub impl @traits.Cloneable for Operator with clone(self) {
  {
    name: self.name,
    category: self.category,
    modality: self.modality,
    determinism: self.determinism,
    reversible: self.reversible,
  }
}

pub extend Operator with @traits.Cloneable::{clone}

// ============================================================================
// OperatorResult — Named, Describable, Displayable, Summarizable, Countable
// ============================================================================

///|
pub impl @traits.Named for OperatorResult with name(_self) {
  "OperatorResult"
}

pub extend OperatorResult with @traits.Named::{name}

///|
pub impl @traits.Describable for OperatorResult with describe(self) {
  "output=DataObject,metrics_count=" + self.metrics.length().to_string()
}

pub extend OperatorResult with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for OperatorResult with display(self) {
  "OperatorResult: output=DataObject,metrics_count=" + self.metrics.length().to_string()
}

pub extend OperatorResult with @traits.Displayable::{display}

///|
pub impl @traits.Summarizable for OperatorResult with summary(self) {
  let mut result = "OperatorResult{metrics=["
  let mut first = true
  for item in self.metrics {
    if first {
      first = false
    } else {
      result = result + ", "
    }
    result = result + item.0 + "=" + item.1.to_string()
  }
  result = result + "]}"
  result
}

pub extend OperatorResult with @traits.Summarizable::{summary}

///|
pub impl @traits.Countable for OperatorResult with count(self) {
  self.metrics.length()
}

pub extend OperatorResult with @traits.Countable::{count}