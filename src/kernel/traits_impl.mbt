///|
/// # kernel trait 实现 / Kernel trait implementations
///
/// 为 ExecMode / Consistency 实现 core/traits 中的 trait。

// ============================================================================
// ExecMode — Named, Describable, Displayable, Cloneable
// ============================================================================

///|
pub impl @traits.Named for ExecMode with name(self) {
  mode_name(self)
}

pub extend ExecMode with @traits.Named::{name}

///|
pub impl @traits.Describable for ExecMode with describe(self) {
  "Execution mode: " + mode_name(self)
}

pub extend ExecMode with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for ExecMode with display(self) {
  mode_name(self) + " (Execution mode: " + mode_name(self) + ")"
}

pub extend ExecMode with @traits.Displayable::{display}

///|
pub impl @traits.Cloneable for ExecMode with clone(self) {
  self
}

pub extend ExecMode with @traits.Cloneable::{clone}

// ============================================================================
// Consistency — Named, Describable, Displayable
// ============================================================================

///|
pub impl @traits.Named for Consistency with name(self) {
  match self {
    ByteExact => "ByteExact"
    SeededBound(_, _) => "SeededBound"
    WindowEquiv => "WindowEquiv"
    CacheHitEquiv => "CacheHitEquiv"
  }
}

pub extend Consistency with @traits.Named::{name}

///|
pub impl @traits.Describable for Consistency with describe(self) {
  match self {
    ByteExact => "Byte-level exact equivalence"
    SeededBound(seed, bound) => "Seeded bound: seed=" + seed.to_string() + ", bound=" + bound.to_string()
    WindowEquiv => "Window-level equivalence"
    CacheHitEquiv => "Cache-hit equivalence"
  }
}

pub extend Consistency with @traits.Describable::{describe}

///|
pub impl @traits.Displayable for Consistency with display(self) {
  let n = match self {
    ByteExact => "ByteExact"
    SeededBound(_, _) => "SeededBound"
    WindowEquiv => "WindowEquiv"
    CacheHitEquiv => "CacheHitEquiv"
  }
  let d = match self {
    ByteExact => "Byte-level exact equivalence"
    SeededBound(seed, bound) => "Seeded bound: seed=" + seed.to_string() + ", bound=" + bound.to_string()
    WindowEquiv => "Window-level equivalence"
    CacheHitEquiv => "Cache-hit equivalence"
  }
  n + ": " + d
}

pub extend Consistency with @traits.Displayable::{display}