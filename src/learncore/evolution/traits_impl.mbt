///|
/// # trait implementations for src/learncore/evolution

pub impl @traits.Named for Aco_colonyMatrix with name(_self) { "Aco_colonyMatrix" }
pub extend Aco_colonyMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Aco_colonyMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Aco_colonyMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Aco_colonyMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Aco_colonyMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Aco_colonyMatrix with count(self) { (self.rows * self.cols) }
pub extend Aco_colonyMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Aco_colonyPoint with name(_self) { "Aco_colonyPoint" }
pub extend Aco_colonyPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Aco_colonyPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Aco_colonyPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Aco_colonyPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Aco_colonyPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Aco_colonyPoint with count(_self) { 2 }
pub extend Aco_colonyPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Aco_colonySeries with name(_self) { "Aco_colonySeries" }
pub extend Aco_colonySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Aco_colonySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Aco_colonySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Aco_colonySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Aco_colonySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Aco_colonySeries with count(self) { self.vals.length() }
pub extend Aco_colonySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Aco_colonyVector with name(_self) { "Aco_colonyVector" }
pub extend Aco_colonyVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Aco_colonyVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Aco_colonyVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Aco_colonyVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Aco_colonyVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Aco_colonyVector with count(self) { self.comps.length() }
pub extend Aco_colonyVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Bat_algMatrix with name(_self) { "Bat_algMatrix" }
pub extend Bat_algMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Bat_algMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Bat_algMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bat_algMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Bat_algMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bat_algMatrix with count(self) { (self.rows * self.cols) }
pub extend Bat_algMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Bat_algPoint with name(_self) { "Bat_algPoint" }
pub extend Bat_algPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Bat_algPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Bat_algPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bat_algPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Bat_algPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bat_algPoint with count(_self) { 2 }
pub extend Bat_algPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Bat_algSeries with name(_self) { "Bat_algSeries" }
pub extend Bat_algSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Bat_algSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Bat_algSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bat_algSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Bat_algSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bat_algSeries with count(self) { self.vals.length() }
pub extend Bat_algSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Bat_algVector with name(_self) { "Bat_algVector" }
pub extend Bat_algVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Bat_algVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Bat_algVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bat_algVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Bat_algVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bat_algVector with count(self) { self.comps.length() }
pub extend Bat_algVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Bee_algMatrix with name(_self) { "Bee_algMatrix" }
pub extend Bee_algMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Bee_algMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Bee_algMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bee_algMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Bee_algMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bee_algMatrix with count(self) { (self.rows * self.cols) }
pub extend Bee_algMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Bee_algPoint with name(_self) { "Bee_algPoint" }
pub extend Bee_algPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Bee_algPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Bee_algPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bee_algPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Bee_algPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bee_algPoint with count(_self) { 2 }
pub extend Bee_algPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Bee_algSeries with name(_self) { "Bee_algSeries" }
pub extend Bee_algSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Bee_algSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Bee_algSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bee_algSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Bee_algSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bee_algSeries with count(self) { self.vals.length() }
pub extend Bee_algSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Bee_algVector with name(_self) { "Bee_algVector" }
pub extend Bee_algVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Bee_algVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Bee_algVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Bee_algVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Bee_algVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Bee_algVector with count(self) { self.comps.length() }
pub extend Bee_algVector with @traits.Countable::{count}
///|
pub impl @traits.Named for CuckooMatrix with name(_self) { "CuckooMatrix" }
pub extend CuckooMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for CuckooMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend CuckooMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CuckooMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend CuckooMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CuckooMatrix with count(self) { (self.rows * self.cols) }
pub extend CuckooMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for CuckooPoint with name(_self) { "CuckooPoint" }
pub extend CuckooPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for CuckooPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend CuckooPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CuckooPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend CuckooPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CuckooPoint with count(_self) { 2 }
pub extend CuckooPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for CuckooSeries with name(_self) { "CuckooSeries" }
pub extend CuckooSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for CuckooSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend CuckooSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CuckooSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend CuckooSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CuckooSeries with count(self) { self.vals.length() }
pub extend CuckooSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for CuckooVector with name(_self) { "CuckooVector" }
pub extend CuckooVector with @traits.Named::{name}
///|
pub impl @traits.Describable for CuckooVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend CuckooVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for CuckooVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend CuckooVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for CuckooVector with count(self) { self.comps.length() }
pub extend CuckooVector with @traits.Countable::{count}
///|
pub impl @traits.Named for De_eaMatrix with name(_self) { "De_eaMatrix" }
pub extend De_eaMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for De_eaMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend De_eaMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for De_eaMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend De_eaMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for De_eaMatrix with count(self) { (self.rows * self.cols) }
pub extend De_eaMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for De_eaPoint with name(_self) { "De_eaPoint" }
pub extend De_eaPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for De_eaPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend De_eaPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for De_eaPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend De_eaPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for De_eaPoint with count(_self) { 2 }
pub extend De_eaPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for De_eaSeries with name(_self) { "De_eaSeries" }
pub extend De_eaSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for De_eaSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend De_eaSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for De_eaSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend De_eaSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for De_eaSeries with count(self) { self.vals.length() }
pub extend De_eaSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for De_eaVector with name(_self) { "De_eaVector" }
pub extend De_eaVector with @traits.Named::{name}
///|
pub impl @traits.Describable for De_eaVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend De_eaVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for De_eaVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend De_eaVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for De_eaVector with count(self) { self.comps.length() }
pub extend De_eaVector with @traits.Countable::{count}
///|
pub impl @traits.Named for FireflyMatrix with name(_self) { "FireflyMatrix" }
pub extend FireflyMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for FireflyMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend FireflyMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for FireflyMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend FireflyMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for FireflyMatrix with count(self) { (self.rows * self.cols) }
pub extend FireflyMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for FireflyPoint with name(_self) { "FireflyPoint" }
pub extend FireflyPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for FireflyPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend FireflyPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for FireflyPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend FireflyPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for FireflyPoint with count(_self) { 2 }
pub extend FireflyPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for FireflySeries with name(_self) { "FireflySeries" }
pub extend FireflySeries with @traits.Named::{name}
///|
pub impl @traits.Describable for FireflySeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend FireflySeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for FireflySeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend FireflySeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for FireflySeries with count(self) { self.vals.length() }
pub extend FireflySeries with @traits.Countable::{count}
///|
pub impl @traits.Named for FireflyVector with name(_self) { "FireflyVector" }
pub extend FireflyVector with @traits.Named::{name}
///|
pub impl @traits.Describable for FireflyVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend FireflyVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for FireflyVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend FireflyVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for FireflyVector with count(self) { self.comps.length() }
pub extend FireflyVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Flower_pollMatrix with name(_self) { "Flower_pollMatrix" }
pub extend Flower_pollMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Flower_pollMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Flower_pollMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Flower_pollMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Flower_pollMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Flower_pollMatrix with count(self) { (self.rows * self.cols) }
pub extend Flower_pollMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Flower_pollPoint with name(_self) { "Flower_pollPoint" }
pub extend Flower_pollPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Flower_pollPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Flower_pollPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Flower_pollPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Flower_pollPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Flower_pollPoint with count(_self) { 2 }
pub extend Flower_pollPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Flower_pollSeries with name(_self) { "Flower_pollSeries" }
pub extend Flower_pollSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Flower_pollSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Flower_pollSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Flower_pollSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Flower_pollSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Flower_pollSeries with count(self) { self.vals.length() }
pub extend Flower_pollSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Flower_pollVector with name(_self) { "Flower_pollVector" }
pub extend Flower_pollVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Flower_pollVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Flower_pollVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Flower_pollVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Flower_pollVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Flower_pollVector with count(self) { self.comps.length() }
pub extend Flower_pollVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_algMatrix with name(_self) { "Genetic_algMatrix" }
pub extend Genetic_algMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_algMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Genetic_algMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_algMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Genetic_algMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_algMatrix with count(self) { (self.rows * self.cols) }
pub extend Genetic_algMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_algPoint with name(_self) { "Genetic_algPoint" }
pub extend Genetic_algPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_algPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Genetic_algPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_algPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Genetic_algPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_algPoint with count(_self) { 2 }
pub extend Genetic_algPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_algSeries with name(_self) { "Genetic_algSeries" }
pub extend Genetic_algSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_algSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Genetic_algSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_algSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Genetic_algSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_algSeries with count(self) { self.vals.length() }
pub extend Genetic_algSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_algVector with name(_self) { "Genetic_algVector" }
pub extend Genetic_algVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_algVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Genetic_algVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_algVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Genetic_algVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_algVector with count(self) { self.comps.length() }
pub extend Genetic_algVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_progMatrix with name(_self) { "Genetic_progMatrix" }
pub extend Genetic_progMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_progMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Genetic_progMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_progMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Genetic_progMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_progMatrix with count(self) { (self.rows * self.cols) }
pub extend Genetic_progMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_progPoint with name(_self) { "Genetic_progPoint" }
pub extend Genetic_progPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_progPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Genetic_progPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_progPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Genetic_progPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_progPoint with count(_self) { 2 }
pub extend Genetic_progPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_progSeries with name(_self) { "Genetic_progSeries" }
pub extend Genetic_progSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_progSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Genetic_progSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_progSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Genetic_progSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_progSeries with count(self) { self.vals.length() }
pub extend Genetic_progSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Genetic_progVector with name(_self) { "Genetic_progVector" }
pub extend Genetic_progVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Genetic_progVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Genetic_progVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Genetic_progVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Genetic_progVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Genetic_progVector with count(self) { self.comps.length() }
pub extend Genetic_progVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Harmony_searchMatrix with name(_self) { "Harmony_searchMatrix" }
pub extend Harmony_searchMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Harmony_searchMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Harmony_searchMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Harmony_searchMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Harmony_searchMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Harmony_searchMatrix with count(self) { (self.rows * self.cols) }
pub extend Harmony_searchMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Harmony_searchPoint with name(_self) { "Harmony_searchPoint" }
pub extend Harmony_searchPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Harmony_searchPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Harmony_searchPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Harmony_searchPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Harmony_searchPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Harmony_searchPoint with count(_self) { 2 }
pub extend Harmony_searchPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Harmony_searchSeries with name(_self) { "Harmony_searchSeries" }
pub extend Harmony_searchSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Harmony_searchSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Harmony_searchSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Harmony_searchSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Harmony_searchSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Harmony_searchSeries with count(self) { self.vals.length() }
pub extend Harmony_searchSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Harmony_searchVector with name(_self) { "Harmony_searchVector" }
pub extend Harmony_searchVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Harmony_searchVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Harmony_searchVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Harmony_searchVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Harmony_searchVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Harmony_searchVector with count(self) { self.comps.length() }
pub extend Harmony_searchVector with @traits.Countable::{count}
///|
pub impl @traits.Named for MemeticMatrix with name(_self) { "MemeticMatrix" }
pub extend MemeticMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for MemeticMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend MemeticMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for MemeticMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend MemeticMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for MemeticMatrix with count(self) { (self.rows * self.cols) }
pub extend MemeticMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for MemeticPoint with name(_self) { "MemeticPoint" }
pub extend MemeticPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for MemeticPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend MemeticPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for MemeticPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend MemeticPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for MemeticPoint with count(_self) { 2 }
pub extend MemeticPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for MemeticSeries with name(_self) { "MemeticSeries" }
pub extend MemeticSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for MemeticSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend MemeticSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for MemeticSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend MemeticSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for MemeticSeries with count(self) { self.vals.length() }
pub extend MemeticSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for MemeticVector with name(_self) { "MemeticVector" }
pub extend MemeticVector with @traits.Named::{name}
///|
pub impl @traits.Describable for MemeticVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend MemeticVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for MemeticVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend MemeticVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for MemeticVector with count(self) { self.comps.length() }
pub extend MemeticVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Moea_dMatrix with name(_self) { "Moea_dMatrix" }
pub extend Moea_dMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Moea_dMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Moea_dMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Moea_dMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Moea_dMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Moea_dMatrix with count(self) { (self.rows * self.cols) }
pub extend Moea_dMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Moea_dPoint with name(_self) { "Moea_dPoint" }
pub extend Moea_dPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Moea_dPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Moea_dPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Moea_dPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Moea_dPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Moea_dPoint with count(_self) { 2 }
pub extend Moea_dPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Moea_dSeries with name(_self) { "Moea_dSeries" }
pub extend Moea_dSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Moea_dSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Moea_dSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Moea_dSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Moea_dSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Moea_dSeries with count(self) { self.vals.length() }
pub extend Moea_dSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Moea_dVector with name(_self) { "Moea_dVector" }
pub extend Moea_dVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Moea_dVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Moea_dVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Moea_dVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Moea_dVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Moea_dVector with count(self) { self.comps.length() }
pub extend Moea_dVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Nsga2Matrix with name(_self) { "Nsga2Matrix" }
pub extend Nsga2Matrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Nsga2Matrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Nsga2Matrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Nsga2Matrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Nsga2Matrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Nsga2Matrix with count(self) { (self.rows * self.cols) }
pub extend Nsga2Matrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Nsga2Point with name(_self) { "Nsga2Point" }
pub extend Nsga2Point with @traits.Named::{name}
///|
pub impl @traits.Describable for Nsga2Point with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Nsga2Point with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Nsga2Point with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Nsga2Point with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Nsga2Point with count(_self) { 2 }
pub extend Nsga2Point with @traits.Countable::{count}
///|
pub impl @traits.Named for Nsga2Series with name(_self) { "Nsga2Series" }
pub extend Nsga2Series with @traits.Named::{name}
///|
pub impl @traits.Describable for Nsga2Series with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Nsga2Series with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Nsga2Series with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Nsga2Series with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Nsga2Series with count(self) { self.vals.length() }
pub extend Nsga2Series with @traits.Countable::{count}
///|
pub impl @traits.Named for Nsga2Vector with name(_self) { "Nsga2Vector" }
pub extend Nsga2Vector with @traits.Named::{name}
///|
pub impl @traits.Describable for Nsga2Vector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Nsga2Vector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Nsga2Vector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Nsga2Vector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Nsga2Vector with count(self) { self.comps.length() }
pub extend Nsga2Vector with @traits.Countable::{count}
///|
pub impl @traits.Named for Pso_swarmMatrix with name(_self) { "Pso_swarmMatrix" }
pub extend Pso_swarmMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Pso_swarmMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Pso_swarmMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Pso_swarmMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Pso_swarmMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pso_swarmMatrix with count(self) { (self.rows * self.cols) }
pub extend Pso_swarmMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Pso_swarmPoint with name(_self) { "Pso_swarmPoint" }
pub extend Pso_swarmPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Pso_swarmPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Pso_swarmPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Pso_swarmPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Pso_swarmPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pso_swarmPoint with count(_self) { 2 }
pub extend Pso_swarmPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Pso_swarmSeries with name(_self) { "Pso_swarmSeries" }
pub extend Pso_swarmSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Pso_swarmSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Pso_swarmSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Pso_swarmSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Pso_swarmSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pso_swarmSeries with count(self) { self.vals.length() }
pub extend Pso_swarmSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Pso_swarmVector with name(_self) { "Pso_swarmVector" }
pub extend Pso_swarmVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Pso_swarmVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Pso_swarmVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Pso_swarmVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Pso_swarmVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Pso_swarmVector with count(self) { self.comps.length() }
pub extend Pso_swarmVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Sim_annealMatrix with name(_self) { "Sim_annealMatrix" }
pub extend Sim_annealMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Sim_annealMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Sim_annealMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Sim_annealMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Sim_annealMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Sim_annealMatrix with count(self) { (self.rows * self.cols) }
pub extend Sim_annealMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Sim_annealPoint with name(_self) { "Sim_annealPoint" }
pub extend Sim_annealPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Sim_annealPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Sim_annealPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Sim_annealPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Sim_annealPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Sim_annealPoint with count(_self) { 2 }
pub extend Sim_annealPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Sim_annealSeries with name(_self) { "Sim_annealSeries" }
pub extend Sim_annealSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Sim_annealSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Sim_annealSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Sim_annealSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Sim_annealSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Sim_annealSeries with count(self) { self.vals.length() }
pub extend Sim_annealSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Sim_annealVector with name(_self) { "Sim_annealVector" }
pub extend Sim_annealVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Sim_annealVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Sim_annealVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Sim_annealVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Sim_annealVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Sim_annealVector with count(self) { self.comps.length() }
pub extend Sim_annealVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Spea2Matrix with name(_self) { "Spea2Matrix" }
pub extend Spea2Matrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Spea2Matrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Spea2Matrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Spea2Matrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Spea2Matrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spea2Matrix with count(self) { (self.rows * self.cols) }
pub extend Spea2Matrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Spea2Point with name(_self) { "Spea2Point" }
pub extend Spea2Point with @traits.Named::{name}
///|
pub impl @traits.Describable for Spea2Point with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Spea2Point with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Spea2Point with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Spea2Point with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spea2Point with count(_self) { 2 }
pub extend Spea2Point with @traits.Countable::{count}
///|
pub impl @traits.Named for Spea2Series with name(_self) { "Spea2Series" }
pub extend Spea2Series with @traits.Named::{name}
///|
pub impl @traits.Describable for Spea2Series with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Spea2Series with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Spea2Series with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Spea2Series with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spea2Series with count(self) { self.vals.length() }
pub extend Spea2Series with @traits.Countable::{count}
///|
pub impl @traits.Named for Spea2Vector with name(_self) { "Spea2Vector" }
pub extend Spea2Vector with @traits.Named::{name}
///|
pub impl @traits.Describable for Spea2Vector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Spea2Vector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Spea2Vector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Spea2Vector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Spea2Vector with count(self) { self.comps.length() }
pub extend Spea2Vector with @traits.Countable::{count}
///|
pub impl @traits.Named for Tabu_searchMatrix with name(_self) { "Tabu_searchMatrix" }
pub extend Tabu_searchMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Tabu_searchMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Tabu_searchMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tabu_searchMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Tabu_searchMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tabu_searchMatrix with count(self) { (self.rows * self.cols) }
pub extend Tabu_searchMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Tabu_searchPoint with name(_self) { "Tabu_searchPoint" }
pub extend Tabu_searchPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Tabu_searchPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Tabu_searchPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tabu_searchPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Tabu_searchPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tabu_searchPoint with count(_self) { 2 }
pub extend Tabu_searchPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Tabu_searchSeries with name(_self) { "Tabu_searchSeries" }
pub extend Tabu_searchSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Tabu_searchSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Tabu_searchSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tabu_searchSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Tabu_searchSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tabu_searchSeries with count(self) { self.vals.length() }
pub extend Tabu_searchSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Tabu_searchVector with name(_self) { "Tabu_searchVector" }
pub extend Tabu_searchVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Tabu_searchVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Tabu_searchVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tabu_searchVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Tabu_searchVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tabu_searchVector with count(self) { self.comps.length() }
pub extend Tabu_searchVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Wolf_packMatrix with name(_self) { "Wolf_packMatrix" }
pub extend Wolf_packMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Wolf_packMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Wolf_packMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Wolf_packMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Wolf_packMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wolf_packMatrix with count(self) { (self.rows * self.cols) }
pub extend Wolf_packMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Wolf_packPoint with name(_self) { "Wolf_packPoint" }
pub extend Wolf_packPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Wolf_packPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Wolf_packPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Wolf_packPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Wolf_packPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wolf_packPoint with count(_self) { 2 }
pub extend Wolf_packPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Wolf_packSeries with name(_self) { "Wolf_packSeries" }
pub extend Wolf_packSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Wolf_packSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Wolf_packSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Wolf_packSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Wolf_packSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wolf_packSeries with count(self) { self.vals.length() }
pub extend Wolf_packSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Wolf_packVector with name(_self) { "Wolf_packVector" }
pub extend Wolf_packVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Wolf_packVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Wolf_packVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Wolf_packVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Wolf_packVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Wolf_packVector with count(self) { self.comps.length() }
pub extend Wolf_packVector with @traits.Countable::{count}




///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for Aco_colonyMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Aco_colonyMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Aco_colonyMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Aco_colonyMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Aco_colonyPoint with check(_self) { true }
pub extend Aco_colonyPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Aco_colonyPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Aco_colonyPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Aco_colonySeries with check(self) { self.vals.length() > 0 }
pub extend Aco_colonySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Aco_colonySeries with reset(_self) { { vals: [], name: "", } }
pub extend Aco_colonySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Aco_colonyVector with check(self) { self.dim > 0 }
pub extend Aco_colonyVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Aco_colonyVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Aco_colonyVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bat_algMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Bat_algMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bat_algMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Bat_algMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bat_algPoint with check(_self) { true }
pub extend Bat_algPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bat_algPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Bat_algPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bat_algSeries with check(self) { self.vals.length() > 0 }
pub extend Bat_algSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bat_algSeries with reset(_self) { { vals: [], name: "", } }
pub extend Bat_algSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bat_algVector with check(self) { self.dim > 0 }
pub extend Bat_algVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bat_algVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Bat_algVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bee_algMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Bee_algMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bee_algMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Bee_algMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bee_algPoint with check(_self) { true }
pub extend Bee_algPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bee_algPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Bee_algPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bee_algSeries with check(self) { self.vals.length() > 0 }
pub extend Bee_algSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bee_algSeries with reset(_self) { { vals: [], name: "", } }
pub extend Bee_algSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Bee_algVector with check(self) { self.dim > 0 }
pub extend Bee_algVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Bee_algVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Bee_algVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CuckooMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend CuckooMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CuckooMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend CuckooMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CuckooPoint with check(_self) { true }
pub extend CuckooPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CuckooPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend CuckooPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CuckooSeries with check(self) { self.vals.length() > 0 }
pub extend CuckooSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CuckooSeries with reset(_self) { { vals: [], name: "", } }
pub extend CuckooSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for CuckooVector with check(self) { self.dim > 0 }
pub extend CuckooVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for CuckooVector with reset(_self) { { comps: [], dim: 0, } }
pub extend CuckooVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for De_eaMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend De_eaMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for De_eaMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend De_eaMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for De_eaPoint with check(_self) { true }
pub extend De_eaPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for De_eaPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend De_eaPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for De_eaSeries with check(self) { self.vals.length() > 0 }
pub extend De_eaSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for De_eaSeries with reset(_self) { { vals: [], name: "", } }
pub extend De_eaSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for De_eaVector with check(self) { self.dim > 0 }
pub extend De_eaVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for De_eaVector with reset(_self) { { comps: [], dim: 0, } }
pub extend De_eaVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for FireflyMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend FireflyMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for FireflyMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend FireflyMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for FireflyPoint with check(_self) { true }
pub extend FireflyPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for FireflyPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend FireflyPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for FireflySeries with check(self) { self.vals.length() > 0 }
pub extend FireflySeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for FireflySeries with reset(_self) { { vals: [], name: "", } }
pub extend FireflySeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for FireflyVector with check(self) { self.dim > 0 }
pub extend FireflyVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for FireflyVector with reset(_self) { { comps: [], dim: 0, } }
pub extend FireflyVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Flower_pollMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Flower_pollMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Flower_pollMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Flower_pollMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Flower_pollPoint with check(_self) { true }
pub extend Flower_pollPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Flower_pollPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Flower_pollPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Flower_pollSeries with check(self) { self.vals.length() > 0 }
pub extend Flower_pollSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Flower_pollSeries with reset(_self) { { vals: [], name: "", } }
pub extend Flower_pollSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Flower_pollVector with check(self) { self.dim > 0 }
pub extend Flower_pollVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Flower_pollVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Flower_pollVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_algMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Genetic_algMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_algMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Genetic_algMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_algPoint with check(_self) { true }
pub extend Genetic_algPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_algPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Genetic_algPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_algSeries with check(self) { self.vals.length() > 0 }
pub extend Genetic_algSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_algSeries with reset(_self) { { vals: [], name: "", } }
pub extend Genetic_algSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_algVector with check(self) { self.dim > 0 }
pub extend Genetic_algVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_algVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Genetic_algVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_progMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Genetic_progMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_progMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Genetic_progMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_progPoint with check(_self) { true }
pub extend Genetic_progPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_progPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Genetic_progPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_progSeries with check(self) { self.vals.length() > 0 }
pub extend Genetic_progSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_progSeries with reset(_self) { { vals: [], name: "", } }
pub extend Genetic_progSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Genetic_progVector with check(self) { self.dim > 0 }
pub extend Genetic_progVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Genetic_progVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Genetic_progVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Harmony_searchMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Harmony_searchMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Harmony_searchMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Harmony_searchMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Harmony_searchPoint with check(_self) { true }
pub extend Harmony_searchPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Harmony_searchPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Harmony_searchPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Harmony_searchSeries with check(self) { self.vals.length() > 0 }
pub extend Harmony_searchSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Harmony_searchSeries with reset(_self) { { vals: [], name: "", } }
pub extend Harmony_searchSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Harmony_searchVector with check(self) { self.dim > 0 }
pub extend Harmony_searchVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Harmony_searchVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Harmony_searchVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for MemeticMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend MemeticMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for MemeticMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend MemeticMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for MemeticPoint with check(_self) { true }
pub extend MemeticPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for MemeticPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend MemeticPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for MemeticSeries with check(self) { self.vals.length() > 0 }
pub extend MemeticSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for MemeticSeries with reset(_self) { { vals: [], name: "", } }
pub extend MemeticSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for MemeticVector with check(self) { self.dim > 0 }
pub extend MemeticVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for MemeticVector with reset(_self) { { comps: [], dim: 0, } }
pub extend MemeticVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Moea_dMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Moea_dMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Moea_dMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Moea_dMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Moea_dPoint with check(_self) { true }
pub extend Moea_dPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Moea_dPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Moea_dPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Moea_dSeries with check(self) { self.vals.length() > 0 }
pub extend Moea_dSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Moea_dSeries with reset(_self) { { vals: [], name: "", } }
pub extend Moea_dSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Moea_dVector with check(self) { self.dim > 0 }
pub extend Moea_dVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Moea_dVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Moea_dVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Nsga2Matrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Nsga2Matrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Nsga2Matrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Nsga2Matrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Nsga2Point with check(_self) { true }
pub extend Nsga2Point with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Nsga2Point with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Nsga2Point with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Nsga2Series with check(self) { self.vals.length() > 0 }
pub extend Nsga2Series with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Nsga2Series with reset(_self) { { vals: [], name: "", } }
pub extend Nsga2Series with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Nsga2Vector with check(self) { self.dim > 0 }
pub extend Nsga2Vector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Nsga2Vector with reset(_self) { { comps: [], dim: 0, } }
pub extend Nsga2Vector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pso_swarmMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Pso_swarmMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pso_swarmMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Pso_swarmMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pso_swarmPoint with check(_self) { true }
pub extend Pso_swarmPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pso_swarmPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Pso_swarmPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pso_swarmSeries with check(self) { self.vals.length() > 0 }
pub extend Pso_swarmSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pso_swarmSeries with reset(_self) { { vals: [], name: "", } }
pub extend Pso_swarmSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Pso_swarmVector with check(self) { self.dim > 0 }
pub extend Pso_swarmVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Pso_swarmVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Pso_swarmVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Sim_annealMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Sim_annealMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Sim_annealMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Sim_annealMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Sim_annealPoint with check(_self) { true }
pub extend Sim_annealPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Sim_annealPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Sim_annealPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Sim_annealSeries with check(self) { self.vals.length() > 0 }
pub extend Sim_annealSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Sim_annealSeries with reset(_self) { { vals: [], name: "", } }
pub extend Sim_annealSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Sim_annealVector with check(self) { self.dim > 0 }
pub extend Sim_annealVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Sim_annealVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Sim_annealVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spea2Matrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Spea2Matrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spea2Matrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Spea2Matrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spea2Point with check(_self) { true }
pub extend Spea2Point with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spea2Point with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Spea2Point with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spea2Series with check(self) { self.vals.length() > 0 }
pub extend Spea2Series with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spea2Series with reset(_self) { { vals: [], name: "", } }
pub extend Spea2Series with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Spea2Vector with check(self) { self.dim > 0 }
pub extend Spea2Vector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Spea2Vector with reset(_self) { { comps: [], dim: 0, } }
pub extend Spea2Vector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tabu_searchMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Tabu_searchMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tabu_searchMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Tabu_searchMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tabu_searchPoint with check(_self) { true }
pub extend Tabu_searchPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tabu_searchPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Tabu_searchPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tabu_searchSeries with check(self) { self.vals.length() > 0 }
pub extend Tabu_searchSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tabu_searchSeries with reset(_self) { { vals: [], name: "", } }
pub extend Tabu_searchSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tabu_searchVector with check(self) { self.dim > 0 }
pub extend Tabu_searchVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tabu_searchVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Tabu_searchVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wolf_packMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Wolf_packMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wolf_packMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Wolf_packMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wolf_packPoint with check(_self) { true }
pub extend Wolf_packPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wolf_packPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Wolf_packPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wolf_packSeries with check(self) { self.vals.length() > 0 }
pub extend Wolf_packSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wolf_packSeries with reset(_self) { { vals: [], name: "", } }
pub extend Wolf_packSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Wolf_packVector with check(self) { self.dim > 0 }
pub extend Wolf_packVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Wolf_packVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Wolf_packVector with @traits.Resettable::{reset}