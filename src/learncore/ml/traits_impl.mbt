///|
/// # trait implementations for src/learncore/ml

pub impl @traits.Named for ElmMatrix with name(_self) { "ElmMatrix" }
pub extend ElmMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for ElmMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend ElmMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for ElmMatrix with display(self) { "ElmMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend ElmMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for ElmMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend ElmMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for ElmMatrix with count(self) { (self.rows * self.cols) }
pub extend ElmMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for ElmPoint with name(_self) { "ElmPoint" }
pub extend ElmPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for ElmPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend ElmPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for ElmPoint with display(self) { "ElmPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend ElmPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for ElmPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend ElmPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for ElmPoint with count(_self) { 2 }
pub extend ElmPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for ElmSeries with name(_self) { "ElmSeries" }
pub extend ElmSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for ElmSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend ElmSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for ElmSeries with display(self) { "ElmSeries[len=" + self.vals.length().to_string() + "]" }
pub extend ElmSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for ElmSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend ElmSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for ElmSeries with count(self) { self.vals.length() }
pub extend ElmSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for ElmVector with name(_self) { "ElmVector" }
pub extend ElmVector with @traits.Named::{name}
///|
pub impl @traits.Describable for ElmVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend ElmVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for ElmVector with display(self) { "ElmVector[dim=" + self.dim.to_string() + "]" }
pub extend ElmVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for ElmVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend ElmVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for ElmVector with count(self) { self.comps.length() }
pub extend ElmVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Gaussian_procMatrix with name(_self) { "Gaussian_procMatrix" }
pub extend Gaussian_procMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Gaussian_procMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Gaussian_procMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gaussian_procMatrix with display(self) { "Gaussian_procMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Gaussian_procMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gaussian_procMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Gaussian_procMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gaussian_procMatrix with count(self) { (self.rows * self.cols) }
pub extend Gaussian_procMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Gaussian_procPoint with name(_self) { "Gaussian_procPoint" }
pub extend Gaussian_procPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Gaussian_procPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Gaussian_procPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gaussian_procPoint with display(self) { "Gaussian_procPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Gaussian_procPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gaussian_procPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Gaussian_procPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gaussian_procPoint with count(_self) { 2 }
pub extend Gaussian_procPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Gaussian_procSeries with name(_self) { "Gaussian_procSeries" }
pub extend Gaussian_procSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Gaussian_procSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Gaussian_procSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gaussian_procSeries with display(self) { "Gaussian_procSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Gaussian_procSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gaussian_procSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Gaussian_procSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gaussian_procSeries with count(self) { self.vals.length() }
pub extend Gaussian_procSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Gaussian_procVector with name(_self) { "Gaussian_procVector" }
pub extend Gaussian_procVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Gaussian_procVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Gaussian_procVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gaussian_procVector with display(self) { "Gaussian_procVector[dim=" + self.dim.to_string() + "]" }
pub extend Gaussian_procVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gaussian_procVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Gaussian_procVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gaussian_procVector with count(self) { self.comps.length() }
pub extend Gaussian_procVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Iso_forestMatrix with name(_self) { "Iso_forestMatrix" }
pub extend Iso_forestMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Iso_forestMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Iso_forestMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Iso_forestMatrix with display(self) { "Iso_forestMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Iso_forestMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Iso_forestMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Iso_forestMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Iso_forestMatrix with count(self) { (self.rows * self.cols) }
pub extend Iso_forestMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Iso_forestPoint with name(_self) { "Iso_forestPoint" }
pub extend Iso_forestPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Iso_forestPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Iso_forestPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Iso_forestPoint with display(self) { "Iso_forestPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Iso_forestPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Iso_forestPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Iso_forestPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Iso_forestPoint with count(_self) { 2 }
pub extend Iso_forestPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Iso_forestSeries with name(_self) { "Iso_forestSeries" }
pub extend Iso_forestSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Iso_forestSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Iso_forestSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Iso_forestSeries with display(self) { "Iso_forestSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Iso_forestSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Iso_forestSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Iso_forestSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Iso_forestSeries with count(self) { self.vals.length() }
pub extend Iso_forestSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Iso_forestVector with name(_self) { "Iso_forestVector" }
pub extend Iso_forestVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Iso_forestVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Iso_forestVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Iso_forestVector with display(self) { "Iso_forestVector[dim=" + self.dim.to_string() + "]" }
pub extend Iso_forestVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Iso_forestVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Iso_forestVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Iso_forestVector with count(self) { self.comps.length() }
pub extend Iso_forestVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Kernel_ridgeMatrix with name(_self) { "Kernel_ridgeMatrix" }
pub extend Kernel_ridgeMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Kernel_ridgeMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Kernel_ridgeMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Kernel_ridgeMatrix with display(self) { "Kernel_ridgeMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Kernel_ridgeMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Kernel_ridgeMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Kernel_ridgeMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Kernel_ridgeMatrix with count(self) { (self.rows * self.cols) }
pub extend Kernel_ridgeMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Kernel_ridgePoint with name(_self) { "Kernel_ridgePoint" }
pub extend Kernel_ridgePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Kernel_ridgePoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Kernel_ridgePoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Kernel_ridgePoint with display(self) { "Kernel_ridgePoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Kernel_ridgePoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Kernel_ridgePoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Kernel_ridgePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Kernel_ridgePoint with count(_self) { 2 }
pub extend Kernel_ridgePoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Kernel_ridgeSeries with name(_self) { "Kernel_ridgeSeries" }
pub extend Kernel_ridgeSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Kernel_ridgeSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Kernel_ridgeSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Kernel_ridgeSeries with display(self) { "Kernel_ridgeSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Kernel_ridgeSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Kernel_ridgeSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Kernel_ridgeSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Kernel_ridgeSeries with count(self) { self.vals.length() }
pub extend Kernel_ridgeSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Kernel_ridgeVector with name(_self) { "Kernel_ridgeVector" }
pub extend Kernel_ridgeVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Kernel_ridgeVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Kernel_ridgeVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Kernel_ridgeVector with display(self) { "Kernel_ridgeVector[dim=" + self.dim.to_string() + "]" }
pub extend Kernel_ridgeVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Kernel_ridgeVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Kernel_ridgeVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Kernel_ridgeVector with count(self) { self.comps.length() }
pub extend Kernel_ridgeVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Knn_regMatrix with name(_self) { "Knn_regMatrix" }
pub extend Knn_regMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Knn_regMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Knn_regMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Knn_regMatrix with display(self) { "Knn_regMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Knn_regMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Knn_regMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Knn_regMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Knn_regMatrix with count(self) { (self.rows * self.cols) }
pub extend Knn_regMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Knn_regPoint with name(_self) { "Knn_regPoint" }
pub extend Knn_regPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Knn_regPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Knn_regPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Knn_regPoint with display(self) { "Knn_regPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Knn_regPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Knn_regPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Knn_regPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Knn_regPoint with count(_self) { 2 }
pub extend Knn_regPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Knn_regSeries with name(_self) { "Knn_regSeries" }
pub extend Knn_regSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Knn_regSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Knn_regSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Knn_regSeries with display(self) { "Knn_regSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Knn_regSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Knn_regSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Knn_regSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Knn_regSeries with count(self) { self.vals.length() }
pub extend Knn_regSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Knn_regVector with name(_self) { "Knn_regVector" }
pub extend Knn_regVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Knn_regVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Knn_regVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Knn_regVector with display(self) { "Knn_regVector[dim=" + self.dim.to_string() + "]" }
pub extend Knn_regVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Knn_regVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Knn_regVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Knn_regVector with count(self) { self.comps.length() }
pub extend Knn_regVector with @traits.Countable::{count}
///|
pub impl @traits.Named for LvqMatrix with name(_self) { "LvqMatrix" }
pub extend LvqMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for LvqMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend LvqMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for LvqMatrix with display(self) { "LvqMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend LvqMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for LvqMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend LvqMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LvqMatrix with count(self) { (self.rows * self.cols) }
pub extend LvqMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for LvqPoint with name(_self) { "LvqPoint" }
pub extend LvqPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for LvqPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend LvqPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for LvqPoint with display(self) { "LvqPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend LvqPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for LvqPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend LvqPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LvqPoint with count(_self) { 2 }
pub extend LvqPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for LvqSeries with name(_self) { "LvqSeries" }
pub extend LvqSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for LvqSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend LvqSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for LvqSeries with display(self) { "LvqSeries[len=" + self.vals.length().to_string() + "]" }
pub extend LvqSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for LvqSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend LvqSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LvqSeries with count(self) { self.vals.length() }
pub extend LvqSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for LvqVector with name(_self) { "LvqVector" }
pub extend LvqVector with @traits.Named::{name}
///|
pub impl @traits.Describable for LvqVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend LvqVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for LvqVector with display(self) { "LvqVector[dim=" + self.dim.to_string() + "]" }
pub extend LvqVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for LvqVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend LvqVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LvqVector with count(self) { self.comps.length() }
pub extend LvqVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Neural_gasMatrix with name(_self) { "Neural_gasMatrix" }
pub extend Neural_gasMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Neural_gasMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Neural_gasMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Neural_gasMatrix with display(self) { "Neural_gasMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Neural_gasMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Neural_gasMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Neural_gasMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Neural_gasMatrix with count(self) { (self.rows * self.cols) }
pub extend Neural_gasMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Neural_gasPoint with name(_self) { "Neural_gasPoint" }
pub extend Neural_gasPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Neural_gasPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Neural_gasPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Neural_gasPoint with display(self) { "Neural_gasPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Neural_gasPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Neural_gasPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Neural_gasPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Neural_gasPoint with count(_self) { 2 }
pub extend Neural_gasPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Neural_gasSeries with name(_self) { "Neural_gasSeries" }
pub extend Neural_gasSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Neural_gasSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Neural_gasSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Neural_gasSeries with display(self) { "Neural_gasSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Neural_gasSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Neural_gasSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Neural_gasSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Neural_gasSeries with count(self) { self.vals.length() }
pub extend Neural_gasSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Neural_gasVector with name(_self) { "Neural_gasVector" }
pub extend Neural_gasVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Neural_gasVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Neural_gasVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Neural_gasVector with display(self) { "Neural_gasVector[dim=" + self.dim.to_string() + "]" }
pub extend Neural_gasVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Neural_gasVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Neural_gasVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Neural_gasVector with count(self) { self.comps.length() }
pub extend Neural_gasVector with @traits.Countable::{count}
///|
pub impl @traits.Named for OcsvmMatrix with name(_self) { "OcsvmMatrix" }
pub extend OcsvmMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for OcsvmMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend OcsvmMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for OcsvmMatrix with display(self) { "OcsvmMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend OcsvmMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for OcsvmMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend OcsvmMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for OcsvmMatrix with count(self) { (self.rows * self.cols) }
pub extend OcsvmMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for OcsvmPoint with name(_self) { "OcsvmPoint" }
pub extend OcsvmPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for OcsvmPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend OcsvmPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for OcsvmPoint with display(self) { "OcsvmPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend OcsvmPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for OcsvmPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend OcsvmPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for OcsvmPoint with count(_self) { 2 }
pub extend OcsvmPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for OcsvmSeries with name(_self) { "OcsvmSeries" }
pub extend OcsvmSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for OcsvmSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend OcsvmSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for OcsvmSeries with display(self) { "OcsvmSeries[len=" + self.vals.length().to_string() + "]" }
pub extend OcsvmSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for OcsvmSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend OcsvmSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for OcsvmSeries with count(self) { self.vals.length() }
pub extend OcsvmSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for OcsvmVector with name(_self) { "OcsvmVector" }
pub extend OcsvmVector with @traits.Named::{name}
///|
pub impl @traits.Describable for OcsvmVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend OcsvmVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for OcsvmVector with display(self) { "OcsvmVector[dim=" + self.dim.to_string() + "]" }
pub extend OcsvmVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for OcsvmVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend OcsvmVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for OcsvmVector with count(self) { self.comps.length() }
pub extend OcsvmVector with @traits.Countable::{count}
///|
pub impl @traits.Named for PrototypeMatrix with name(_self) { "PrototypeMatrix" }
pub extend PrototypeMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for PrototypeMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend PrototypeMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for PrototypeMatrix with display(self) { "PrototypeMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend PrototypeMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for PrototypeMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend PrototypeMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PrototypeMatrix with count(self) { (self.rows * self.cols) }
pub extend PrototypeMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for PrototypePoint with name(_self) { "PrototypePoint" }
pub extend PrototypePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for PrototypePoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend PrototypePoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for PrototypePoint with display(self) { "PrototypePoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend PrototypePoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for PrototypePoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend PrototypePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PrototypePoint with count(_self) { 2 }
pub extend PrototypePoint with @traits.Countable::{count}
///|
pub impl @traits.Named for PrototypeSeries with name(_self) { "PrototypeSeries" }
pub extend PrototypeSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for PrototypeSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend PrototypeSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for PrototypeSeries with display(self) { "PrototypeSeries[len=" + self.vals.length().to_string() + "]" }
pub extend PrototypeSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for PrototypeSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend PrototypeSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PrototypeSeries with count(self) { self.vals.length() }
pub extend PrototypeSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for PrototypeVector with name(_self) { "PrototypeVector" }
pub extend PrototypeVector with @traits.Named::{name}
///|
pub impl @traits.Describable for PrototypeVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend PrototypeVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for PrototypeVector with display(self) { "PrototypeVector[dim=" + self.dim.to_string() + "]" }
pub extend PrototypeVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for PrototypeVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend PrototypeVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PrototypeVector with count(self) { self.comps.length() }
pub extend PrototypeVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Rbf_netMatrix with name(_self) { "Rbf_netMatrix" }
pub extend Rbf_netMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Rbf_netMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Rbf_netMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rbf_netMatrix with display(self) { "Rbf_netMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Rbf_netMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rbf_netMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Rbf_netMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rbf_netMatrix with count(self) { (self.rows * self.cols) }
pub extend Rbf_netMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Rbf_netPoint with name(_self) { "Rbf_netPoint" }
pub extend Rbf_netPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Rbf_netPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Rbf_netPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rbf_netPoint with display(self) { "Rbf_netPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Rbf_netPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rbf_netPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Rbf_netPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rbf_netPoint with count(_self) { 2 }
pub extend Rbf_netPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Rbf_netSeries with name(_self) { "Rbf_netSeries" }
pub extend Rbf_netSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Rbf_netSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Rbf_netSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rbf_netSeries with display(self) { "Rbf_netSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Rbf_netSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rbf_netSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Rbf_netSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rbf_netSeries with count(self) { self.vals.length() }
pub extend Rbf_netSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Rbf_netVector with name(_self) { "Rbf_netVector" }
pub extend Rbf_netVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Rbf_netVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Rbf_netVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rbf_netVector with display(self) { "Rbf_netVector[dim=" + self.dim.to_string() + "]" }
pub extend Rbf_netVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rbf_netVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Rbf_netVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rbf_netVector with count(self) { self.comps.length() }
pub extend Rbf_netVector with @traits.Countable::{count}
///|
pub impl @traits.Named for SamplePoint with name(_self) { "SamplePoint" }
pub extend SamplePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for SamplePoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend SamplePoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SamplePoint with display(self) { "SamplePoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend SamplePoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SamplePoint with clone(self) { { x: self.x, y: self.y, value: self.value, } }
pub extend SamplePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SamplePoint with count(_self) { 2 }
pub extend SamplePoint with @traits.Countable::{count}
///|
pub impl @traits.Named for SomMatrix with name(_self) { "SomMatrix" }
pub extend SomMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for SomMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend SomMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SomMatrix with display(self) { "SomMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend SomMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SomMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend SomMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SomMatrix with count(self) { (self.rows * self.cols) }
pub extend SomMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for SomPoint with name(_self) { "SomPoint" }
pub extend SomPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for SomPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend SomPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SomPoint with display(self) { "SomPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend SomPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SomPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend SomPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SomPoint with count(_self) { 2 }
pub extend SomPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for SomSeries with name(_self) { "SomSeries" }
pub extend SomSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for SomSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend SomSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SomSeries with display(self) { "SomSeries[len=" + self.vals.length().to_string() + "]" }
pub extend SomSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SomSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend SomSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SomSeries with count(self) { self.vals.length() }
pub extend SomSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for SomVector with name(_self) { "SomVector" }
pub extend SomVector with @traits.Named::{name}
///|
pub impl @traits.Describable for SomVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend SomVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SomVector with display(self) { "SomVector[dim=" + self.dim.to_string() + "]" }
pub extend SomVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SomVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend SomVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SomVector with count(self) { self.comps.length() }
pub extend SomVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Stacking_rtMatrix with name(_self) { "Stacking_rtMatrix" }
pub extend Stacking_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Stacking_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Stacking_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stacking_rtMatrix with display(self) { "Stacking_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Stacking_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stacking_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Stacking_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stacking_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Stacking_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Stacking_rtPoint with name(_self) { "Stacking_rtPoint" }
pub extend Stacking_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Stacking_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Stacking_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stacking_rtPoint with display(self) { "Stacking_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Stacking_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stacking_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Stacking_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stacking_rtPoint with count(_self) { 2 }
pub extend Stacking_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Stacking_rtSeries with name(_self) { "Stacking_rtSeries" }
pub extend Stacking_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Stacking_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Stacking_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stacking_rtSeries with display(self) { "Stacking_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Stacking_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stacking_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Stacking_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stacking_rtSeries with count(self) { self.vals.length() }
pub extend Stacking_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Stacking_rtVector with name(_self) { "Stacking_rtVector" }
pub extend Stacking_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Stacking_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Stacking_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Stacking_rtVector with display(self) { "Stacking_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Stacking_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Stacking_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Stacking_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Stacking_rtVector with count(self) { self.comps.length() }
pub extend Stacking_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for SvddMatrix with name(_self) { "SvddMatrix" }
pub extend SvddMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for SvddMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend SvddMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SvddMatrix with display(self) { "SvddMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend SvddMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SvddMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend SvddMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SvddMatrix with count(self) { (self.rows * self.cols) }
pub extend SvddMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for SvddPoint with name(_self) { "SvddPoint" }
pub extend SvddPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for SvddPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend SvddPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SvddPoint with display(self) { "SvddPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend SvddPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SvddPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend SvddPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SvddPoint with count(_self) { 2 }
pub extend SvddPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for SvddSeries with name(_self) { "SvddSeries" }
pub extend SvddSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for SvddSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend SvddSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SvddSeries with display(self) { "SvddSeries[len=" + self.vals.length().to_string() + "]" }
pub extend SvddSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SvddSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend SvddSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SvddSeries with count(self) { self.vals.length() }
pub extend SvddSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for SvddVector with name(_self) { "SvddVector" }
pub extend SvddVector with @traits.Named::{name}
///|
pub impl @traits.Describable for SvddVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend SvddVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for SvddVector with display(self) { "SvddVector[dim=" + self.dim.to_string() + "]" }
pub extend SvddVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for SvddVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend SvddVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for SvddVector with count(self) { self.comps.length() }
pub extend SvddVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Voting_rtMatrix with name(_self) { "Voting_rtMatrix" }
pub extend Voting_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Voting_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Voting_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voting_rtMatrix with display(self) { "Voting_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Voting_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voting_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Voting_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voting_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Voting_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Voting_rtPoint with name(_self) { "Voting_rtPoint" }
pub extend Voting_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Voting_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Voting_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voting_rtPoint with display(self) { "Voting_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Voting_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voting_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Voting_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voting_rtPoint with count(_self) { 2 }
pub extend Voting_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Voting_rtSeries with name(_self) { "Voting_rtSeries" }
pub extend Voting_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Voting_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Voting_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voting_rtSeries with display(self) { "Voting_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Voting_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voting_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Voting_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voting_rtSeries with count(self) { self.vals.length() }
pub extend Voting_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Voting_rtVector with name(_self) { "Voting_rtVector" }
pub extend Voting_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Voting_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Voting_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Voting_rtVector with display(self) { "Voting_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Voting_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Voting_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Voting_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Voting_rtVector with count(self) { self.comps.length() }
pub extend Voting_rtVector with @traits.Countable::{count}




///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for ElmMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend ElmMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for ElmMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend ElmMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for ElmPoint with check(_self) { true }
pub extend ElmPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for ElmPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend ElmPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for ElmSeries with check(self) { self.vals.length() > 0 }
pub extend ElmSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for ElmSeries with reset(_self) { { vals: [], name: "", } }
pub extend ElmSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for ElmVector with check(self) { self.dim > 0 }
pub extend ElmVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for ElmVector with reset(_self) { { comps: [], dim: 0, } }
pub extend ElmVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gaussian_procMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Gaussian_procMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gaussian_procMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Gaussian_procMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gaussian_procPoint with check(_self) { true }
pub extend Gaussian_procPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gaussian_procPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Gaussian_procPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gaussian_procSeries with check(self) { self.vals.length() > 0 }
pub extend Gaussian_procSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gaussian_procSeries with reset(_self) { { vals: [], name: "", } }
pub extend Gaussian_procSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gaussian_procVector with check(self) { self.dim > 0 }
pub extend Gaussian_procVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gaussian_procVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Gaussian_procVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Iso_forestMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Iso_forestMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Iso_forestMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Iso_forestMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Iso_forestPoint with check(_self) { true }
pub extend Iso_forestPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Iso_forestPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Iso_forestPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Iso_forestSeries with check(self) { self.vals.length() > 0 }
pub extend Iso_forestSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Iso_forestSeries with reset(_self) { { vals: [], name: "", } }
pub extend Iso_forestSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Iso_forestVector with check(self) { self.dim > 0 }
pub extend Iso_forestVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Iso_forestVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Iso_forestVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Kernel_ridgeMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Kernel_ridgeMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Kernel_ridgeMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Kernel_ridgeMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Kernel_ridgePoint with check(_self) { true }
pub extend Kernel_ridgePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Kernel_ridgePoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Kernel_ridgePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Kernel_ridgeSeries with check(self) { self.vals.length() > 0 }
pub extend Kernel_ridgeSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Kernel_ridgeSeries with reset(_self) { { vals: [], name: "", } }
pub extend Kernel_ridgeSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Kernel_ridgeVector with check(self) { self.dim > 0 }
pub extend Kernel_ridgeVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Kernel_ridgeVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Kernel_ridgeVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Knn_regMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Knn_regMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Knn_regMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Knn_regMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Knn_regPoint with check(_self) { true }
pub extend Knn_regPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Knn_regPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Knn_regPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Knn_regSeries with check(self) { self.vals.length() > 0 }
pub extend Knn_regSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Knn_regSeries with reset(_self) { { vals: [], name: "", } }
pub extend Knn_regSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Knn_regVector with check(self) { self.dim > 0 }
pub extend Knn_regVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Knn_regVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Knn_regVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LvqMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend LvqMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LvqMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend LvqMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LvqPoint with check(_self) { true }
pub extend LvqPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LvqPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend LvqPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LvqSeries with check(self) { self.vals.length() > 0 }
pub extend LvqSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LvqSeries with reset(_self) { { vals: [], name: "", } }
pub extend LvqSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LvqVector with check(self) { self.dim > 0 }
pub extend LvqVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LvqVector with reset(_self) { { comps: [], dim: 0, } }
pub extend LvqVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Neural_gasMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Neural_gasMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Neural_gasMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Neural_gasMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Neural_gasPoint with check(_self) { true }
pub extend Neural_gasPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Neural_gasPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Neural_gasPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Neural_gasSeries with check(self) { self.vals.length() > 0 }
pub extend Neural_gasSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Neural_gasSeries with reset(_self) { { vals: [], name: "", } }
pub extend Neural_gasSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Neural_gasVector with check(self) { self.dim > 0 }
pub extend Neural_gasVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Neural_gasVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Neural_gasVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for OcsvmMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend OcsvmMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for OcsvmMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend OcsvmMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for OcsvmPoint with check(_self) { true }
pub extend OcsvmPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for OcsvmPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend OcsvmPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for OcsvmSeries with check(self) { self.vals.length() > 0 }
pub extend OcsvmSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for OcsvmSeries with reset(_self) { { vals: [], name: "", } }
pub extend OcsvmSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for OcsvmVector with check(self) { self.dim > 0 }
pub extend OcsvmVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for OcsvmVector with reset(_self) { { comps: [], dim: 0, } }
pub extend OcsvmVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PrototypeMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend PrototypeMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PrototypeMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend PrototypeMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PrototypePoint with check(_self) { true }
pub extend PrototypePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PrototypePoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend PrototypePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PrototypeSeries with check(self) { self.vals.length() > 0 }
pub extend PrototypeSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PrototypeSeries with reset(_self) { { vals: [], name: "", } }
pub extend PrototypeSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PrototypeVector with check(self) { self.dim > 0 }
pub extend PrototypeVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PrototypeVector with reset(_self) { { comps: [], dim: 0, } }
pub extend PrototypeVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rbf_netMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Rbf_netMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rbf_netMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Rbf_netMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rbf_netPoint with check(_self) { true }
pub extend Rbf_netPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rbf_netPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Rbf_netPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rbf_netSeries with check(self) { self.vals.length() > 0 }
pub extend Rbf_netSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rbf_netSeries with reset(_self) { { vals: [], name: "", } }
pub extend Rbf_netSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rbf_netVector with check(self) { self.dim > 0 }
pub extend Rbf_netVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rbf_netVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Rbf_netVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SamplePoint with check(_self) { true }
pub extend SamplePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SamplePoint with reset(_self) { { x: 0.0, y: 0.0, value: 0.0, } }
pub extend SamplePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SomMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend SomMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SomMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend SomMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SomPoint with check(_self) { true }
pub extend SomPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SomPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend SomPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SomSeries with check(self) { self.vals.length() > 0 }
pub extend SomSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SomSeries with reset(_self) { { vals: [], name: "", } }
pub extend SomSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SomVector with check(self) { self.dim > 0 }
pub extend SomVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SomVector with reset(_self) { { comps: [], dim: 0, } }
pub extend SomVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stacking_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Stacking_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stacking_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Stacking_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stacking_rtPoint with check(_self) { true }
pub extend Stacking_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stacking_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Stacking_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stacking_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Stacking_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stacking_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Stacking_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Stacking_rtVector with check(self) { self.dim > 0 }
pub extend Stacking_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Stacking_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Stacking_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SvddMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend SvddMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SvddMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend SvddMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SvddPoint with check(_self) { true }
pub extend SvddPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SvddPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend SvddPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SvddSeries with check(self) { self.vals.length() > 0 }
pub extend SvddSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SvddSeries with reset(_self) { { vals: [], name: "", } }
pub extend SvddSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for SvddVector with check(self) { self.dim > 0 }
pub extend SvddVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for SvddVector with reset(_self) { { comps: [], dim: 0, } }
pub extend SvddVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voting_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Voting_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voting_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Voting_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voting_rtPoint with check(_self) { true }
pub extend Voting_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voting_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Voting_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voting_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Voting_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voting_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Voting_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Voting_rtVector with check(self) { self.dim > 0 }
pub extend Voting_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Voting_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Voting_rtVector with @traits.Resettable::{reset}
