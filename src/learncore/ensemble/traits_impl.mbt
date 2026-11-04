///|
/// # trait implementations for src/learncore/ensemble

pub impl @traits.Named for AdaboostMatrix with name(_self) { "AdaboostMatrix" }
pub extend AdaboostMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for AdaboostMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend AdaboostMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for AdaboostMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend AdaboostMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AdaboostMatrix with count(self) { (self.rows * self.cols) }
pub extend AdaboostMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for AdaboostPoint with name(_self) { "AdaboostPoint" }
pub extend AdaboostPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for AdaboostPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend AdaboostPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for AdaboostPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend AdaboostPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AdaboostPoint with count(_self) { 2 }
pub extend AdaboostPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for AdaboostSeries with name(_self) { "AdaboostSeries" }
pub extend AdaboostSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for AdaboostSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend AdaboostSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for AdaboostSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend AdaboostSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AdaboostSeries with count(self) { self.vals.length() }
pub extend AdaboostSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for AdaboostVector with name(_self) { "AdaboostVector" }
pub extend AdaboostVector with @traits.Named::{name}
///|
pub impl @traits.Describable for AdaboostVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend AdaboostVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for AdaboostVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend AdaboostVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for AdaboostVector with count(self) { self.comps.length() }
pub extend AdaboostVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Bagging_rtMatrix with name(_self) { "Bagging_rtMatrix" }
pub extend Bagging_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Bagging_rtMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Bagging_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bagging_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Bagging_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bagging_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Bagging_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Bagging_rtPoint with name(_self) { "Bagging_rtPoint" }
pub extend Bagging_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Bagging_rtPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Bagging_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bagging_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Bagging_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bagging_rtPoint with count(_self) { 2 }
pub extend Bagging_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Bagging_rtSeries with name(_self) { "Bagging_rtSeries" }
pub extend Bagging_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Bagging_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Bagging_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bagging_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Bagging_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bagging_rtSeries with count(self) { self.vals.length() }
pub extend Bagging_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Bagging_rtVector with name(_self) { "Bagging_rtVector" }
pub extend Bagging_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Bagging_rtVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Bagging_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bagging_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Bagging_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bagging_rtVector with count(self) { self.comps.length() }
pub extend Bagging_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Boosting_rtMatrix with name(_self) { "Boosting_rtMatrix" }
pub extend Boosting_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Boosting_rtMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Boosting_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Boosting_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Boosting_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Boosting_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Boosting_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Boosting_rtPoint with name(_self) { "Boosting_rtPoint" }
pub extend Boosting_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Boosting_rtPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Boosting_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Boosting_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Boosting_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Boosting_rtPoint with count(_self) { 2 }
pub extend Boosting_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Boosting_rtSeries with name(_self) { "Boosting_rtSeries" }
pub extend Boosting_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Boosting_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Boosting_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Boosting_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Boosting_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Boosting_rtSeries with count(self) { self.vals.length() }
pub extend Boosting_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Boosting_rtVector with name(_self) { "Boosting_rtVector" }
pub extend Boosting_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Boosting_rtVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Boosting_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Boosting_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Boosting_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Boosting_rtVector with count(self) { self.comps.length() }
pub extend Boosting_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for CatboostMatrix with name(_self) { "CatboostMatrix" }
pub extend CatboostMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for CatboostMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend CatboostMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CatboostMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend CatboostMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CatboostMatrix with count(self) { (self.rows * self.cols) }
pub extend CatboostMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for CatboostPoint with name(_self) { "CatboostPoint" }
pub extend CatboostPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for CatboostPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend CatboostPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CatboostPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend CatboostPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CatboostPoint with count(_self) { 2 }
pub extend CatboostPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for CatboostSeries with name(_self) { "CatboostSeries" }
pub extend CatboostSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for CatboostSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend CatboostSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CatboostSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend CatboostSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CatboostSeries with count(self) { self.vals.length() }
pub extend CatboostSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for CatboostVector with name(_self) { "CatboostVector" }
pub extend CatboostVector with @traits.Named::{name}
///|
pub impl @traits.Describable for CatboostVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend CatboostVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CatboostVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend CatboostVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CatboostVector with count(self) { self.comps.length() }
pub extend CatboostVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Grad_boostMatrix with name(_self) { "Grad_boostMatrix" }
pub extend Grad_boostMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Grad_boostMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Grad_boostMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Grad_boostMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Grad_boostMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Grad_boostMatrix with count(self) { (self.rows * self.cols) }
pub extend Grad_boostMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Grad_boostPoint with name(_self) { "Grad_boostPoint" }
pub extend Grad_boostPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Grad_boostPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Grad_boostPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Grad_boostPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Grad_boostPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Grad_boostPoint with count(_self) { 2 }
pub extend Grad_boostPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Grad_boostSeries with name(_self) { "Grad_boostSeries" }
pub extend Grad_boostSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Grad_boostSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Grad_boostSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Grad_boostSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Grad_boostSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Grad_boostSeries with count(self) { self.vals.length() }
pub extend Grad_boostSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Grad_boostVector with name(_self) { "Grad_boostVector" }
pub extend Grad_boostVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Grad_boostVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Grad_boostVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Grad_boostVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Grad_boostVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Grad_boostVector with count(self) { self.comps.length() }
pub extend Grad_boostVector with @traits.Countable::{count}
///|
pub impl @traits.Named for LightgbmMatrix with name(_self) { "LightgbmMatrix" }
pub extend LightgbmMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for LightgbmMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend LightgbmMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LightgbmMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend LightgbmMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LightgbmMatrix with count(self) { (self.rows * self.cols) }
pub extend LightgbmMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for LightgbmPoint with name(_self) { "LightgbmPoint" }
pub extend LightgbmPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for LightgbmPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend LightgbmPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LightgbmPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend LightgbmPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LightgbmPoint with count(_self) { 2 }
pub extend LightgbmPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for LightgbmSeries with name(_self) { "LightgbmSeries" }
pub extend LightgbmSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for LightgbmSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend LightgbmSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LightgbmSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend LightgbmSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LightgbmSeries with count(self) { self.vals.length() }
pub extend LightgbmSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for LightgbmVector with name(_self) { "LightgbmVector" }
pub extend LightgbmVector with @traits.Named::{name}
///|
pub impl @traits.Describable for LightgbmVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend LightgbmVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LightgbmVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend LightgbmVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LightgbmVector with count(self) { self.comps.length() }
pub extend LightgbmVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Logit_boostMatrix with name(_self) { "Logit_boostMatrix" }
pub extend Logit_boostMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Logit_boostMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Logit_boostMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Logit_boostMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Logit_boostMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Logit_boostMatrix with count(self) { (self.rows * self.cols) }
pub extend Logit_boostMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Logit_boostPoint with name(_self) { "Logit_boostPoint" }
pub extend Logit_boostPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Logit_boostPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Logit_boostPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Logit_boostPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Logit_boostPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Logit_boostPoint with count(_self) { 2 }
pub extend Logit_boostPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Logit_boostSeries with name(_self) { "Logit_boostSeries" }
pub extend Logit_boostSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Logit_boostSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Logit_boostSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Logit_boostSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Logit_boostSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Logit_boostSeries with count(self) { self.vals.length() }
pub extend Logit_boostSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Logit_boostVector with name(_self) { "Logit_boostVector" }
pub extend Logit_boostVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Logit_boostVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Logit_boostVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Logit_boostVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Logit_boostVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Logit_boostVector with count(self) { self.comps.length() }
pub extend Logit_boostVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Tpr_forestMatrix with name(_self) { "Tpr_forestMatrix" }
pub extend Tpr_forestMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Tpr_forestMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Tpr_forestMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tpr_forestMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Tpr_forestMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tpr_forestMatrix with count(self) { (self.rows * self.cols) }
pub extend Tpr_forestMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Tpr_forestPoint with name(_self) { "Tpr_forestPoint" }
pub extend Tpr_forestPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Tpr_forestPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Tpr_forestPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tpr_forestPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Tpr_forestPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tpr_forestPoint with count(_self) { 2 }
pub extend Tpr_forestPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Tpr_forestSeries with name(_self) { "Tpr_forestSeries" }
pub extend Tpr_forestSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Tpr_forestSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Tpr_forestSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tpr_forestSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Tpr_forestSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tpr_forestSeries with count(self) { self.vals.length() }
pub extend Tpr_forestSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Tpr_forestVector with name(_self) { "Tpr_forestVector" }
pub extend Tpr_forestVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Tpr_forestVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Tpr_forestVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tpr_forestVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Tpr_forestVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tpr_forestVector with count(self) { self.comps.length() }
pub extend Tpr_forestVector with @traits.Countable::{count}
///|
pub impl @traits.Named for XgboostMatrix with name(_self) { "XgboostMatrix" }
pub extend XgboostMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for XgboostMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend XgboostMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for XgboostMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend XgboostMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for XgboostMatrix with count(self) { (self.rows * self.cols) }
pub extend XgboostMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for XgboostPoint with name(_self) { "XgboostPoint" }
pub extend XgboostPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for XgboostPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend XgboostPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for XgboostPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend XgboostPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for XgboostPoint with count(_self) { 2 }
pub extend XgboostPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for XgboostSeries with name(_self) { "XgboostSeries" }
pub extend XgboostSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for XgboostSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend XgboostSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for XgboostSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend XgboostSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for XgboostSeries with count(self) { self.vals.length() }
pub extend XgboostSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for XgboostVector with name(_self) { "XgboostVector" }
pub extend XgboostVector with @traits.Named::{name}
///|
pub impl @traits.Describable for XgboostVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend XgboostVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for XgboostVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend XgboostVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for XgboostVector with count(self) { self.comps.length() }
pub extend XgboostVector with @traits.Countable::{count}




///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for AdaboostMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend AdaboostMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AdaboostMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend AdaboostMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for AdaboostPoint with check(_self) { true }
pub extend AdaboostPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AdaboostPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend AdaboostPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for AdaboostSeries with check(self) { self.vals.length() > 0 }
pub extend AdaboostSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AdaboostSeries with reset(_self) { { vals: [], name: "", } }
pub extend AdaboostSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for AdaboostVector with check(self) { self.dim > 0 }
pub extend AdaboostVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for AdaboostVector with reset(_self) { { comps: [], dim: 0, } }
pub extend AdaboostVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bagging_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Bagging_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bagging_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Bagging_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bagging_rtPoint with check(_self) { true }
pub extend Bagging_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bagging_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Bagging_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bagging_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Bagging_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bagging_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Bagging_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bagging_rtVector with check(self) { self.dim > 0 }
pub extend Bagging_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bagging_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Bagging_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Boosting_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Boosting_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Boosting_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Boosting_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Boosting_rtPoint with check(_self) { true }
pub extend Boosting_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Boosting_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Boosting_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Boosting_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Boosting_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Boosting_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Boosting_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Boosting_rtVector with check(self) { self.dim > 0 }
pub extend Boosting_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Boosting_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Boosting_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CatboostMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend CatboostMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CatboostMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend CatboostMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CatboostPoint with check(_self) { true }
pub extend CatboostPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CatboostPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend CatboostPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CatboostSeries with check(self) { self.vals.length() > 0 }
pub extend CatboostSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CatboostSeries with reset(_self) { { vals: [], name: "", } }
pub extend CatboostSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CatboostVector with check(self) { self.dim > 0 }
pub extend CatboostVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CatboostVector with reset(_self) { { comps: [], dim: 0, } }
pub extend CatboostVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Grad_boostMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Grad_boostMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Grad_boostMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Grad_boostMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Grad_boostPoint with check(_self) { true }
pub extend Grad_boostPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Grad_boostPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Grad_boostPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Grad_boostSeries with check(self) { self.vals.length() > 0 }
pub extend Grad_boostSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Grad_boostSeries with reset(_self) { { vals: [], name: "", } }
pub extend Grad_boostSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Grad_boostVector with check(self) { self.dim > 0 }
pub extend Grad_boostVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Grad_boostVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Grad_boostVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LightgbmMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend LightgbmMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LightgbmMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend LightgbmMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LightgbmPoint with check(_self) { true }
pub extend LightgbmPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LightgbmPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend LightgbmPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LightgbmSeries with check(self) { self.vals.length() > 0 }
pub extend LightgbmSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LightgbmSeries with reset(_self) { { vals: [], name: "", } }
pub extend LightgbmSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LightgbmVector with check(self) { self.dim > 0 }
pub extend LightgbmVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LightgbmVector with reset(_self) { { comps: [], dim: 0, } }
pub extend LightgbmVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Logit_boostMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Logit_boostMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Logit_boostMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Logit_boostMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Logit_boostPoint with check(_self) { true }
pub extend Logit_boostPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Logit_boostPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Logit_boostPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Logit_boostSeries with check(self) { self.vals.length() > 0 }
pub extend Logit_boostSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Logit_boostSeries with reset(_self) { { vals: [], name: "", } }
pub extend Logit_boostSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Logit_boostVector with check(self) { self.dim > 0 }
pub extend Logit_boostVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Logit_boostVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Logit_boostVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tpr_forestMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Tpr_forestMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tpr_forestMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Tpr_forestMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tpr_forestPoint with check(_self) { true }
pub extend Tpr_forestPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tpr_forestPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Tpr_forestPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tpr_forestSeries with check(self) { self.vals.length() > 0 }
pub extend Tpr_forestSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tpr_forestSeries with reset(_self) { { vals: [], name: "", } }
pub extend Tpr_forestSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tpr_forestVector with check(self) { self.dim > 0 }
pub extend Tpr_forestVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tpr_forestVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Tpr_forestVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for XgboostMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend XgboostMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for XgboostMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend XgboostMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for XgboostPoint with check(_self) { true }
pub extend XgboostPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for XgboostPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend XgboostPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for XgboostSeries with check(self) { self.vals.length() > 0 }
pub extend XgboostSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for XgboostSeries with reset(_self) { { vals: [], name: "", } }
pub extend XgboostSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for XgboostVector with check(self) { self.dim > 0 }
pub extend XgboostVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for XgboostVector with reset(_self) { { comps: [], dim: 0, } }
pub extend XgboostVector with @traits.Resettable::{reset}