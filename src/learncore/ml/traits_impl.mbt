///|
pub impl @traits.Named for SamplePoint with name(_self) { "SamplePoint" }
pub extend SamplePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for SamplePoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend SamplePoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for SamplePoint with clone(self) { { x: self.x, y: self.y, value: self.value, } }
pub extend SamplePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SamplePoint with count(_self) { 2 }
pub extend SamplePoint with @traits.Countable::{count}
///|

pub impl @traits.Checkable for SamplePoint with check(_self) { true }
pub extend SamplePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SamplePoint with reset(_self) { { x: 0.0, y: 0.0, value: 0.0, } }
pub extend SamplePoint with @traits.Resettable::{reset}
