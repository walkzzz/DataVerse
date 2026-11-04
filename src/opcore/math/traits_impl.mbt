///|
/// # trait implementations for src/opcore/math

pub impl @traits.Named for Approx_theoryMatrix with name(_self) { "Approx_theoryMatrix" }
pub extend Approx_theoryMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Approx_theoryMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Approx_theoryMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Approx_theoryMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Approx_theoryMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Approx_theoryMatrix with count(self) { (self.rows * self.cols) }
pub extend Approx_theoryMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Approx_theoryPoint with name(_self) { "Approx_theoryPoint" }
pub extend Approx_theoryPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Approx_theoryPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Approx_theoryPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Approx_theoryPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Approx_theoryPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Approx_theoryPoint with count(_self) { 2 }
pub extend Approx_theoryPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Approx_theorySeries with name(_self) { "Approx_theorySeries" }
pub extend Approx_theorySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Approx_theorySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Approx_theorySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Approx_theorySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Approx_theorySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Approx_theorySeries with count(self) { self.vals.length() }
pub extend Approx_theorySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Approx_theoryVector with name(_self) { "Approx_theoryVector" }
pub extend Approx_theoryVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Approx_theoryVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Approx_theoryVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Approx_theoryVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Approx_theoryVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Approx_theoryVector with count(self) { self.comps.length() }
pub extend Approx_theoryVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Coding_theoryMatrix with name(_self) { "Coding_theoryMatrix" }
pub extend Coding_theoryMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Coding_theoryMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Coding_theoryMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Coding_theoryMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Coding_theoryMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Coding_theoryMatrix with count(self) { (self.rows * self.cols) }
pub extend Coding_theoryMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Coding_theoryPoint with name(_self) { "Coding_theoryPoint" }
pub extend Coding_theoryPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Coding_theoryPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Coding_theoryPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Coding_theoryPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Coding_theoryPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Coding_theoryPoint with count(_self) { 2 }
pub extend Coding_theoryPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Coding_theorySeries with name(_self) { "Coding_theorySeries" }
pub extend Coding_theorySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Coding_theorySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Coding_theorySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Coding_theorySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Coding_theorySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Coding_theorySeries with count(self) { self.vals.length() }
pub extend Coding_theorySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Coding_theoryVector with name(_self) { "Coding_theoryVector" }
pub extend Coding_theoryVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Coding_theoryVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Coding_theoryVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Coding_theoryVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Coding_theoryVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Coding_theoryVector with count(self) { self.comps.length() }
pub extend Coding_theoryVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Diff_eqMatrix with name(_self) { "Diff_eqMatrix" }
pub extend Diff_eqMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Diff_eqMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Diff_eqMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Diff_eqMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Diff_eqMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diff_eqMatrix with count(self) { (self.rows * self.cols) }
pub extend Diff_eqMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Diff_eqPoint with name(_self) { "Diff_eqPoint" }
pub extend Diff_eqPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Diff_eqPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Diff_eqPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Diff_eqPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Diff_eqPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diff_eqPoint with count(_self) { 2 }
pub extend Diff_eqPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Diff_eqSeries with name(_self) { "Diff_eqSeries" }
pub extend Diff_eqSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Diff_eqSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Diff_eqSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Diff_eqSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Diff_eqSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diff_eqSeries with count(self) { self.vals.length() }
pub extend Diff_eqSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Diff_eqVector with name(_self) { "Diff_eqVector" }
pub extend Diff_eqVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Diff_eqVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Diff_eqVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Diff_eqVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Diff_eqVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diff_eqVector with count(self) { self.comps.length() }
pub extend Diff_eqVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Game_theoryMatrix with name(_self) { "Game_theoryMatrix" }
pub extend Game_theoryMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Game_theoryMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Game_theoryMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Game_theoryMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Game_theoryMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Game_theoryMatrix with count(self) { (self.rows * self.cols) }
pub extend Game_theoryMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Game_theoryPoint with name(_self) { "Game_theoryPoint" }
pub extend Game_theoryPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Game_theoryPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Game_theoryPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Game_theoryPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Game_theoryPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Game_theoryPoint with count(_self) { 2 }
pub extend Game_theoryPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Game_theorySeries with name(_self) { "Game_theorySeries" }
pub extend Game_theorySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Game_theorySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Game_theorySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Game_theorySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Game_theorySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Game_theorySeries with count(self) { self.vals.length() }
pub extend Game_theorySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Game_theoryVector with name(_self) { "Game_theoryVector" }
pub extend Game_theoryVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Game_theoryVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Game_theoryVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Game_theoryVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Game_theoryVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Game_theoryVector with count(self) { self.comps.length() }
pub extend Game_theoryVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Info_theoryMatrix with name(_self) { "Info_theoryMatrix" }
pub extend Info_theoryMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Info_theoryMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Info_theoryMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Info_theoryMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Info_theoryMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Info_theoryMatrix with count(self) { (self.rows * self.cols) }
pub extend Info_theoryMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Info_theoryPoint with name(_self) { "Info_theoryPoint" }
pub extend Info_theoryPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Info_theoryPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Info_theoryPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Info_theoryPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Info_theoryPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Info_theoryPoint with count(_self) { 2 }
pub extend Info_theoryPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Info_theorySeries with name(_self) { "Info_theorySeries" }
pub extend Info_theorySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Info_theorySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Info_theorySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Info_theorySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Info_theorySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Info_theorySeries with count(self) { self.vals.length() }
pub extend Info_theorySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Info_theoryVector with name(_self) { "Info_theoryVector" }
pub extend Info_theoryVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Info_theoryVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Info_theoryVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Info_theoryVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Info_theoryVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Info_theoryVector with count(self) { self.comps.length() }
pub extend Info_theoryVector with @traits.Countable::{count}
///|
pub impl @traits.Named for IntegralMatrix with name(_self) { "IntegralMatrix" }
pub extend IntegralMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for IntegralMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend IntegralMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for IntegralMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend IntegralMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for IntegralMatrix with count(self) { (self.rows * self.cols) }
pub extend IntegralMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for IntegralPoint with name(_self) { "IntegralPoint" }
pub extend IntegralPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for IntegralPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend IntegralPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for IntegralPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend IntegralPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for IntegralPoint with count(_self) { 2 }
pub extend IntegralPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for IntegralSeries with name(_self) { "IntegralSeries" }
pub extend IntegralSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for IntegralSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend IntegralSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for IntegralSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend IntegralSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for IntegralSeries with count(self) { self.vals.length() }
pub extend IntegralSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for IntegralVector with name(_self) { "IntegralVector" }
pub extend IntegralVector with @traits.Named::{name}
///|
pub impl @traits.Describable for IntegralVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend IntegralVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for IntegralVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend IntegralVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for IntegralVector with count(self) { self.comps.length() }
pub extend IntegralVector with @traits.Countable::{count}
///|
pub impl @traits.Named for LinalgMatrix with name(_self) { "LinalgMatrix" }
pub extend LinalgMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for LinalgMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend LinalgMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LinalgMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend LinalgMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LinalgMatrix with count(self) { (self.rows * self.cols) }
pub extend LinalgMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for LinalgPoint with name(_self) { "LinalgPoint" }
pub extend LinalgPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for LinalgPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend LinalgPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LinalgPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend LinalgPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LinalgPoint with count(_self) { 2 }
pub extend LinalgPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for LinalgSeries with name(_self) { "LinalgSeries" }
pub extend LinalgSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for LinalgSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend LinalgSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LinalgSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend LinalgSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LinalgSeries with count(self) { self.vals.length() }
pub extend LinalgSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for LinalgVector with name(_self) { "LinalgVector" }
pub extend LinalgVector with @traits.Named::{name}
///|
pub impl @traits.Describable for LinalgVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend LinalgVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for LinalgVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend LinalgVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for LinalgVector with count(self) { self.comps.length() }
pub extend LinalgVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Num_analysisMatrix with name(_self) { "Num_analysisMatrix" }
pub extend Num_analysisMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Num_analysisMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Num_analysisMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Num_analysisMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Num_analysisMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Num_analysisMatrix with count(self) { (self.rows * self.cols) }
pub extend Num_analysisMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Num_analysisPoint with name(_self) { "Num_analysisPoint" }
pub extend Num_analysisPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Num_analysisPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Num_analysisPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Num_analysisPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Num_analysisPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Num_analysisPoint with count(_self) { 2 }
pub extend Num_analysisPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Num_analysisSeries with name(_self) { "Num_analysisSeries" }
pub extend Num_analysisSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Num_analysisSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Num_analysisSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Num_analysisSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Num_analysisSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Num_analysisSeries with count(self) { self.vals.length() }
pub extend Num_analysisSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Num_analysisVector with name(_self) { "Num_analysisVector" }
pub extend Num_analysisVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Num_analysisVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Num_analysisVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Num_analysisVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Num_analysisVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Num_analysisVector with count(self) { self.comps.length() }
pub extend Num_analysisVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Orthogonal_polyMatrix with name(_self) { "Orthogonal_polyMatrix" }
pub extend Orthogonal_polyMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Orthogonal_polyMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Orthogonal_polyMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Orthogonal_polyMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Orthogonal_polyMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Orthogonal_polyMatrix with count(self) { (self.rows * self.cols) }
pub extend Orthogonal_polyMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Orthogonal_polyPoint with name(_self) { "Orthogonal_polyPoint" }
pub extend Orthogonal_polyPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Orthogonal_polyPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Orthogonal_polyPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Orthogonal_polyPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Orthogonal_polyPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Orthogonal_polyPoint with count(_self) { 2 }
pub extend Orthogonal_polyPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Orthogonal_polySeries with name(_self) { "Orthogonal_polySeries" }
pub extend Orthogonal_polySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Orthogonal_polySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Orthogonal_polySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Orthogonal_polySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Orthogonal_polySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Orthogonal_polySeries with count(self) { self.vals.length() }
pub extend Orthogonal_polySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Orthogonal_polyVector with name(_self) { "Orthogonal_polyVector" }
pub extend Orthogonal_polyVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Orthogonal_polyVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Orthogonal_polyVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Orthogonal_polyVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Orthogonal_polyVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Orthogonal_polyVector with count(self) { self.comps.length() }
pub extend Orthogonal_polyVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Param_modelMatrix with name(_self) { "Param_modelMatrix" }
pub extend Param_modelMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Param_modelMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Param_modelMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Param_modelMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Param_modelMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Param_modelMatrix with count(self) { (self.rows * self.cols) }
pub extend Param_modelMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Param_modelPoint with name(_self) { "Param_modelPoint" }
pub extend Param_modelPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Param_modelPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Param_modelPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Param_modelPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Param_modelPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Param_modelPoint with count(_self) { 2 }
pub extend Param_modelPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Param_modelSeries with name(_self) { "Param_modelSeries" }
pub extend Param_modelSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Param_modelSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Param_modelSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Param_modelSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Param_modelSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Param_modelSeries with count(self) { self.vals.length() }
pub extend Param_modelSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Param_modelVector with name(_self) { "Param_modelVector" }
pub extend Param_modelVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Param_modelVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Param_modelVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Param_modelVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Param_modelVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Param_modelVector with count(self) { self.comps.length() }
pub extend Param_modelVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Special_funcMatrix with name(_self) { "Special_funcMatrix" }
pub extend Special_funcMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Special_funcMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Special_funcMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Special_funcMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Special_funcMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Special_funcMatrix with count(self) { (self.rows * self.cols) }
pub extend Special_funcMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Special_funcPoint with name(_self) { "Special_funcPoint" }
pub extend Special_funcPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Special_funcPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Special_funcPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Special_funcPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Special_funcPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Special_funcPoint with count(_self) { 2 }
pub extend Special_funcPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Special_funcSeries with name(_self) { "Special_funcSeries" }
pub extend Special_funcSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Special_funcSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Special_funcSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Special_funcSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Special_funcSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Special_funcSeries with count(self) { self.vals.length() }
pub extend Special_funcSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Special_funcVector with name(_self) { "Special_funcVector" }
pub extend Special_funcVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Special_funcVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Special_funcVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Special_funcVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Special_funcVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Special_funcVector with count(self) { self.comps.length() }
pub extend Special_funcVector with @traits.Countable::{count}




///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for Approx_theoryMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Approx_theoryMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Approx_theoryMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Approx_theoryMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Approx_theoryPoint with check(_self) { true }
pub extend Approx_theoryPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Approx_theoryPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Approx_theoryPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Approx_theorySeries with check(self) { self.vals.length() > 0 }
pub extend Approx_theorySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Approx_theorySeries with reset(_self) { { vals: [], name: "", } }
pub extend Approx_theorySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Approx_theoryVector with check(self) { self.dim > 0 }
pub extend Approx_theoryVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Approx_theoryVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Approx_theoryVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Coding_theoryMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Coding_theoryMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Coding_theoryMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Coding_theoryMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Coding_theoryPoint with check(_self) { true }
pub extend Coding_theoryPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Coding_theoryPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Coding_theoryPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Coding_theorySeries with check(self) { self.vals.length() > 0 }
pub extend Coding_theorySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Coding_theorySeries with reset(_self) { { vals: [], name: "", } }
pub extend Coding_theorySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Coding_theoryVector with check(self) { self.dim > 0 }
pub extend Coding_theoryVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Coding_theoryVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Coding_theoryVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diff_eqMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Diff_eqMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diff_eqMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Diff_eqMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diff_eqPoint with check(_self) { true }
pub extend Diff_eqPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diff_eqPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Diff_eqPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diff_eqSeries with check(self) { self.vals.length() > 0 }
pub extend Diff_eqSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diff_eqSeries with reset(_self) { { vals: [], name: "", } }
pub extend Diff_eqSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diff_eqVector with check(self) { self.dim > 0 }
pub extend Diff_eqVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diff_eqVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Diff_eqVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Game_theoryMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Game_theoryMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Game_theoryMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Game_theoryMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Game_theoryPoint with check(_self) { true }
pub extend Game_theoryPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Game_theoryPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Game_theoryPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Game_theorySeries with check(self) { self.vals.length() > 0 }
pub extend Game_theorySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Game_theorySeries with reset(_self) { { vals: [], name: "", } }
pub extend Game_theorySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Game_theoryVector with check(self) { self.dim > 0 }
pub extend Game_theoryVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Game_theoryVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Game_theoryVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Info_theoryMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Info_theoryMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Info_theoryMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Info_theoryMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Info_theoryPoint with check(_self) { true }
pub extend Info_theoryPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Info_theoryPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Info_theoryPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Info_theorySeries with check(self) { self.vals.length() > 0 }
pub extend Info_theorySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Info_theorySeries with reset(_self) { { vals: [], name: "", } }
pub extend Info_theorySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Info_theoryVector with check(self) { self.dim > 0 }
pub extend Info_theoryVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Info_theoryVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Info_theoryVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for IntegralMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend IntegralMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for IntegralMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend IntegralMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for IntegralPoint with check(_self) { true }
pub extend IntegralPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for IntegralPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend IntegralPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for IntegralSeries with check(self) { self.vals.length() > 0 }
pub extend IntegralSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for IntegralSeries with reset(_self) { { vals: [], name: "", } }
pub extend IntegralSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for IntegralVector with check(self) { self.dim > 0 }
pub extend IntegralVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for IntegralVector with reset(_self) { { comps: [], dim: 0, } }
pub extend IntegralVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LinalgMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend LinalgMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LinalgMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend LinalgMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LinalgPoint with check(_self) { true }
pub extend LinalgPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LinalgPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend LinalgPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LinalgSeries with check(self) { self.vals.length() > 0 }
pub extend LinalgSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LinalgSeries with reset(_self) { { vals: [], name: "", } }
pub extend LinalgSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for LinalgVector with check(self) { self.dim > 0 }
pub extend LinalgVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for LinalgVector with reset(_self) { { comps: [], dim: 0, } }
pub extend LinalgVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Num_analysisMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Num_analysisMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Num_analysisMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Num_analysisMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Num_analysisPoint with check(_self) { true }
pub extend Num_analysisPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Num_analysisPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Num_analysisPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Num_analysisSeries with check(self) { self.vals.length() > 0 }
pub extend Num_analysisSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Num_analysisSeries with reset(_self) { { vals: [], name: "", } }
pub extend Num_analysisSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Num_analysisVector with check(self) { self.dim > 0 }
pub extend Num_analysisVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Num_analysisVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Num_analysisVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Orthogonal_polyMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Orthogonal_polyMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Orthogonal_polyMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Orthogonal_polyMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Orthogonal_polyPoint with check(_self) { true }
pub extend Orthogonal_polyPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Orthogonal_polyPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Orthogonal_polyPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Orthogonal_polySeries with check(self) { self.vals.length() > 0 }
pub extend Orthogonal_polySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Orthogonal_polySeries with reset(_self) { { vals: [], name: "", } }
pub extend Orthogonal_polySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Orthogonal_polyVector with check(self) { self.dim > 0 }
pub extend Orthogonal_polyVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Orthogonal_polyVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Orthogonal_polyVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Param_modelMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Param_modelMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Param_modelMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Param_modelMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Param_modelPoint with check(_self) { true }
pub extend Param_modelPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Param_modelPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Param_modelPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Param_modelSeries with check(self) { self.vals.length() > 0 }
pub extend Param_modelSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Param_modelSeries with reset(_self) { { vals: [], name: "", } }
pub extend Param_modelSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Param_modelVector with check(self) { self.dim > 0 }
pub extend Param_modelVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Param_modelVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Param_modelVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Special_funcMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Special_funcMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Special_funcMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Special_funcMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Special_funcPoint with check(_self) { true }
pub extend Special_funcPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Special_funcPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Special_funcPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Special_funcSeries with check(self) { self.vals.length() > 0 }
pub extend Special_funcSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Special_funcSeries with reset(_self) { { vals: [], name: "", } }
pub extend Special_funcSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Special_funcVector with check(self) { self.dim > 0 }
pub extend Special_funcVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Special_funcVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Special_funcVector with @traits.Resettable::{reset}