///|
/// # trait implementations for src/opcore/image

pub impl @traits.Named for Color_correctMatrix with name(_self) { "Color_correctMatrix" }
pub extend Color_correctMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_correctMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Color_correctMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_correctMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Color_correctMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_correctMatrix with count(self) { (self.rows * self.cols) }
pub extend Color_correctMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_correctPoint with name(_self) { "Color_correctPoint" }
pub extend Color_correctPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_correctPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Color_correctPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_correctPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Color_correctPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_correctPoint with count(_self) { 2 }
pub extend Color_correctPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_correctSeries with name(_self) { "Color_correctSeries" }
pub extend Color_correctSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_correctSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Color_correctSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_correctSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Color_correctSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_correctSeries with count(self) { self.vals.length() }
pub extend Color_correctSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_correctVector with name(_self) { "Color_correctVector" }
pub extend Color_correctVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_correctVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Color_correctVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_correctVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Color_correctVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_correctVector with count(self) { self.comps.length() }
pub extend Color_correctVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_spaceMatrix with name(_self) { "Color_spaceMatrix" }
pub extend Color_spaceMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_spaceMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Color_spaceMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_spaceMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Color_spaceMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_spaceMatrix with count(self) { (self.rows * self.cols) }
pub extend Color_spaceMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_spacePoint with name(_self) { "Color_spacePoint" }
pub extend Color_spacePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_spacePoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Color_spacePoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_spacePoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Color_spacePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_spacePoint with count(_self) { 2 }
pub extend Color_spacePoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_spaceSeries with name(_self) { "Color_spaceSeries" }
pub extend Color_spaceSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_spaceSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Color_spaceSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_spaceSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Color_spaceSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_spaceSeries with count(self) { self.vals.length() }
pub extend Color_spaceSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Color_spaceVector with name(_self) { "Color_spaceVector" }
pub extend Color_spaceVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Color_spaceVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Color_spaceVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Color_spaceVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Color_spaceVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Color_spaceVector with count(self) { self.comps.length() }
pub extend Color_spaceVector with @traits.Countable::{count}
///|
pub impl @traits.Named for DeblurMatrix with name(_self) { "DeblurMatrix" }
pub extend DeblurMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for DeblurMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend DeblurMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DeblurMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend DeblurMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DeblurMatrix with count(self) { (self.rows * self.cols) }
pub extend DeblurMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for DeblurPoint with name(_self) { "DeblurPoint" }
pub extend DeblurPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for DeblurPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend DeblurPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DeblurPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend DeblurPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DeblurPoint with count(_self) { 2 }
pub extend DeblurPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for DeblurSeries with name(_self) { "DeblurSeries" }
pub extend DeblurSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for DeblurSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend DeblurSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DeblurSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend DeblurSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DeblurSeries with count(self) { self.vals.length() }
pub extend DeblurSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for DeblurVector with name(_self) { "DeblurVector" }
pub extend DeblurVector with @traits.Named::{name}
///|
pub impl @traits.Describable for DeblurVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend DeblurVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DeblurVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend DeblurVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DeblurVector with count(self) { self.comps.length() }
pub extend DeblurVector with @traits.Countable::{count}
///|
pub impl @traits.Named for DemosaicMatrix with name(_self) { "DemosaicMatrix" }
pub extend DemosaicMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for DemosaicMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend DemosaicMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DemosaicMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend DemosaicMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DemosaicMatrix with count(self) { (self.rows * self.cols) }
pub extend DemosaicMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for DemosaicPoint with name(_self) { "DemosaicPoint" }
pub extend DemosaicPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for DemosaicPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend DemosaicPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DemosaicPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend DemosaicPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DemosaicPoint with count(_self) { 2 }
pub extend DemosaicPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for DemosaicSeries with name(_self) { "DemosaicSeries" }
pub extend DemosaicSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for DemosaicSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend DemosaicSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DemosaicSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend DemosaicSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DemosaicSeries with count(self) { self.vals.length() }
pub extend DemosaicSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for DemosaicVector with name(_self) { "DemosaicVector" }
pub extend DemosaicVector with @traits.Named::{name}
///|
pub impl @traits.Describable for DemosaicVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend DemosaicVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for DemosaicVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend DemosaicVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for DemosaicVector with count(self) { self.comps.length() }
pub extend DemosaicVector with @traits.Countable::{count}
///|
pub impl @traits.Named for HdrMatrix with name(_self) { "HdrMatrix" }
pub extend HdrMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for HdrMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend HdrMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for HdrMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend HdrMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HdrMatrix with count(self) { (self.rows * self.cols) }
pub extend HdrMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for HdrPoint with name(_self) { "HdrPoint" }
pub extend HdrPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for HdrPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend HdrPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for HdrPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend HdrPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HdrPoint with count(_self) { 2 }
pub extend HdrPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for HdrSeries with name(_self) { "HdrSeries" }
pub extend HdrSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for HdrSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend HdrSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for HdrSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend HdrSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HdrSeries with count(self) { self.vals.length() }
pub extend HdrSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for HdrVector with name(_self) { "HdrVector" }
pub extend HdrVector with @traits.Named::{name}
///|
pub impl @traits.Describable for HdrVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend HdrVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for HdrVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend HdrVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for HdrVector with count(self) { self.comps.length() }
pub extend HdrVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_registrationMatrix with name(_self) { "Image_registrationMatrix" }
pub extend Image_registrationMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_registrationMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Image_registrationMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_registrationMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Image_registrationMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_registrationMatrix with count(self) { (self.rows * self.cols) }
pub extend Image_registrationMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_registrationPoint with name(_self) { "Image_registrationPoint" }
pub extend Image_registrationPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_registrationPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Image_registrationPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_registrationPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Image_registrationPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_registrationPoint with count(_self) { 2 }
pub extend Image_registrationPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_registrationSeries with name(_self) { "Image_registrationSeries" }
pub extend Image_registrationSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_registrationSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Image_registrationSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_registrationSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Image_registrationSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_registrationSeries with count(self) { self.vals.length() }
pub extend Image_registrationSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_registrationVector with name(_self) { "Image_registrationVector" }
pub extend Image_registrationVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_registrationVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Image_registrationVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_registrationVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Image_registrationVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_registrationVector with count(self) { self.comps.length() }
pub extend Image_registrationVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_restorationMatrix with name(_self) { "Image_restorationMatrix" }
pub extend Image_restorationMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_restorationMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Image_restorationMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_restorationMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Image_restorationMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_restorationMatrix with count(self) { (self.rows * self.cols) }
pub extend Image_restorationMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_restorationPoint with name(_self) { "Image_restorationPoint" }
pub extend Image_restorationPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_restorationPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Image_restorationPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_restorationPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Image_restorationPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_restorationPoint with count(_self) { 2 }
pub extend Image_restorationPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_restorationSeries with name(_self) { "Image_restorationSeries" }
pub extend Image_restorationSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_restorationSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Image_restorationSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_restorationSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Image_restorationSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_restorationSeries with count(self) { self.vals.length() }
pub extend Image_restorationSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_restorationVector with name(_self) { "Image_restorationVector" }
pub extend Image_restorationVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_restorationVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Image_restorationVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_restorationVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Image_restorationVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_restorationVector with count(self) { self.comps.length() }
pub extend Image_restorationVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_stitchMatrix with name(_self) { "Image_stitchMatrix" }
pub extend Image_stitchMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_stitchMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Image_stitchMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_stitchMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Image_stitchMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_stitchMatrix with count(self) { (self.rows * self.cols) }
pub extend Image_stitchMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_stitchPoint with name(_self) { "Image_stitchPoint" }
pub extend Image_stitchPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_stitchPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Image_stitchPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_stitchPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Image_stitchPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_stitchPoint with count(_self) { 2 }
pub extend Image_stitchPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_stitchSeries with name(_self) { "Image_stitchSeries" }
pub extend Image_stitchSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_stitchSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Image_stitchSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_stitchSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Image_stitchSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_stitchSeries with count(self) { self.vals.length() }
pub extend Image_stitchSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Image_stitchVector with name(_self) { "Image_stitchVector" }
pub extend Image_stitchVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Image_stitchVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Image_stitchVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Image_stitchVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Image_stitchVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Image_stitchVector with count(self) { self.comps.length() }
pub extend Image_stitchVector with @traits.Countable::{count}
///|
pub impl @traits.Named for InpaintMatrix with name(_self) { "InpaintMatrix" }
pub extend InpaintMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for InpaintMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend InpaintMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for InpaintMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend InpaintMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for InpaintMatrix with count(self) { (self.rows * self.cols) }
pub extend InpaintMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for InpaintPoint with name(_self) { "InpaintPoint" }
pub extend InpaintPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for InpaintPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend InpaintPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for InpaintPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend InpaintPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for InpaintPoint with count(_self) { 2 }
pub extend InpaintPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for InpaintSeries with name(_self) { "InpaintSeries" }
pub extend InpaintSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for InpaintSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend InpaintSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for InpaintSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend InpaintSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for InpaintSeries with count(self) { self.vals.length() }
pub extend InpaintSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for InpaintVector with name(_self) { "InpaintVector" }
pub extend InpaintVector with @traits.Named::{name}
///|
pub impl @traits.Describable for InpaintVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend InpaintVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for InpaintVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend InpaintVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for InpaintVector with count(self) { self.comps.length() }
pub extend InpaintVector with @traits.Countable::{count}
///|
pub impl @traits.Named for PanoramaMatrix with name(_self) { "PanoramaMatrix" }
pub extend PanoramaMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for PanoramaMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend PanoramaMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for PanoramaMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend PanoramaMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PanoramaMatrix with count(self) { (self.rows * self.cols) }
pub extend PanoramaMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for PanoramaPoint with name(_self) { "PanoramaPoint" }
pub extend PanoramaPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for PanoramaPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend PanoramaPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for PanoramaPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend PanoramaPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PanoramaPoint with count(_self) { 2 }
pub extend PanoramaPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for PanoramaSeries with name(_self) { "PanoramaSeries" }
pub extend PanoramaSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for PanoramaSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend PanoramaSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for PanoramaSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend PanoramaSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PanoramaSeries with count(self) { self.vals.length() }
pub extend PanoramaSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for PanoramaVector with name(_self) { "PanoramaVector" }
pub extend PanoramaVector with @traits.Named::{name}
///|
pub impl @traits.Describable for PanoramaVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend PanoramaVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for PanoramaVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend PanoramaVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for PanoramaVector with count(self) { self.comps.length() }
pub extend PanoramaVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Super_resMatrix with name(_self) { "Super_resMatrix" }
pub extend Super_resMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Super_resMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Super_resMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Super_resMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Super_resMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Super_resMatrix with count(self) { (self.rows * self.cols) }
pub extend Super_resMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Super_resPoint with name(_self) { "Super_resPoint" }
pub extend Super_resPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Super_resPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Super_resPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Super_resPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Super_resPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Super_resPoint with count(_self) { 2 }
pub extend Super_resPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Super_resSeries with name(_self) { "Super_resSeries" }
pub extend Super_resSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Super_resSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Super_resSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Super_resSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Super_resSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Super_resSeries with count(self) { self.vals.length() }
pub extend Super_resSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Super_resVector with name(_self) { "Super_resVector" }
pub extend Super_resVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Super_resVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Super_resVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Super_resVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Super_resVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Super_resVector with count(self) { self.comps.length() }
pub extend Super_resVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Tone_mapMatrix with name(_self) { "Tone_mapMatrix" }
pub extend Tone_mapMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Tone_mapMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend Tone_mapMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tone_mapMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Tone_mapMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tone_mapMatrix with count(self) { (self.rows * self.cols) }
pub extend Tone_mapMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Tone_mapPoint with name(_self) { "Tone_mapPoint" }
pub extend Tone_mapPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Tone_mapPoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend Tone_mapPoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tone_mapPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Tone_mapPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tone_mapPoint with count(_self) { 2 }
pub extend Tone_mapPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Tone_mapSeries with name(_self) { "Tone_mapSeries" }
pub extend Tone_mapSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Tone_mapSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Tone_mapSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tone_mapSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Tone_mapSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tone_mapSeries with count(self) { self.vals.length() }
pub extend Tone_mapSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Tone_mapVector with name(_self) { "Tone_mapVector" }
pub extend Tone_mapVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Tone_mapVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend Tone_mapVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for Tone_mapVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Tone_mapVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Tone_mapVector with count(self) { self.comps.length() }
pub extend Tone_mapVector with @traits.Countable::{count}
///|
pub impl @traits.Named for White_balanceMatrix with name(_self) { "White_balanceMatrix" }
pub extend White_balanceMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for White_balanceMatrix with describe(self) { @traits.matrix_describe(self.rows, self.cols) }
pub extend White_balanceMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for White_balanceMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend White_balanceMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for White_balanceMatrix with count(self) { (self.rows * self.cols) }
pub extend White_balanceMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for White_balancePoint with name(_self) { "White_balancePoint" }
pub extend White_balancePoint with @traits.Named::{name}
///|
pub impl @traits.Describable for White_balancePoint with describe(self) { @traits.point_describe(self.x, self.y) }
pub extend White_balancePoint with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for White_balancePoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend White_balancePoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for White_balancePoint with count(_self) { 2 }
pub extend White_balancePoint with @traits.Countable::{count}
///|
pub impl @traits.Named for White_balanceSeries with name(_self) { "White_balanceSeries" }
pub extend White_balanceSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for White_balanceSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend White_balanceSeries with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for White_balanceSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend White_balanceSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for White_balanceSeries with count(self) { self.vals.length() }
pub extend White_balanceSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for White_balanceVector with name(_self) { "White_balanceVector" }
pub extend White_balanceVector with @traits.Named::{name}
///|
pub impl @traits.Describable for White_balanceVector with describe(self) { @traits.vector_describe(self.dim) }
pub extend White_balanceVector with @traits.Describable::{describe}
///|
pub impl @traits.Cloneable for White_balanceVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend White_balanceVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for White_balanceVector with count(self) { self.comps.length() }
pub extend White_balanceVector with @traits.Countable::{count}




///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for Color_correctMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Color_correctMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_correctMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Color_correctMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_correctPoint with check(_self) { true }
pub extend Color_correctPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_correctPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Color_correctPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_correctSeries with check(self) { self.vals.length() > 0 }
pub extend Color_correctSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_correctSeries with reset(_self) { { vals: [], name: "", } }
pub extend Color_correctSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_correctVector with check(self) { self.dim > 0 }
pub extend Color_correctVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_correctVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Color_correctVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_spaceMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Color_spaceMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_spaceMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Color_spaceMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_spacePoint with check(_self) { true }
pub extend Color_spacePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_spacePoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Color_spacePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_spaceSeries with check(self) { self.vals.length() > 0 }
pub extend Color_spaceSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_spaceSeries with reset(_self) { { vals: [], name: "", } }
pub extend Color_spaceSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Color_spaceVector with check(self) { self.dim > 0 }
pub extend Color_spaceVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Color_spaceVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Color_spaceVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DeblurMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend DeblurMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DeblurMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend DeblurMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DeblurPoint with check(_self) { true }
pub extend DeblurPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DeblurPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend DeblurPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DeblurSeries with check(self) { self.vals.length() > 0 }
pub extend DeblurSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DeblurSeries with reset(_self) { { vals: [], name: "", } }
pub extend DeblurSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DeblurVector with check(self) { self.dim > 0 }
pub extend DeblurVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DeblurVector with reset(_self) { { comps: [], dim: 0, } }
pub extend DeblurVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DemosaicMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend DemosaicMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DemosaicMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend DemosaicMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DemosaicPoint with check(_self) { true }
pub extend DemosaicPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DemosaicPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend DemosaicPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DemosaicSeries with check(self) { self.vals.length() > 0 }
pub extend DemosaicSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DemosaicSeries with reset(_self) { { vals: [], name: "", } }
pub extend DemosaicSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for DemosaicVector with check(self) { self.dim > 0 }
pub extend DemosaicVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for DemosaicVector with reset(_self) { { comps: [], dim: 0, } }
pub extend DemosaicVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HdrMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend HdrMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HdrMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend HdrMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HdrPoint with check(_self) { true }
pub extend HdrPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HdrPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend HdrPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HdrSeries with check(self) { self.vals.length() > 0 }
pub extend HdrSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HdrSeries with reset(_self) { { vals: [], name: "", } }
pub extend HdrSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for HdrVector with check(self) { self.dim > 0 }
pub extend HdrVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for HdrVector with reset(_self) { { comps: [], dim: 0, } }
pub extend HdrVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_registrationMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Image_registrationMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_registrationMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Image_registrationMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_registrationPoint with check(_self) { true }
pub extend Image_registrationPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_registrationPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Image_registrationPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_registrationSeries with check(self) { self.vals.length() > 0 }
pub extend Image_registrationSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_registrationSeries with reset(_self) { { vals: [], name: "", } }
pub extend Image_registrationSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_registrationVector with check(self) { self.dim > 0 }
pub extend Image_registrationVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_registrationVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Image_registrationVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_restorationMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Image_restorationMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_restorationMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Image_restorationMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_restorationPoint with check(_self) { true }
pub extend Image_restorationPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_restorationPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Image_restorationPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_restorationSeries with check(self) { self.vals.length() > 0 }
pub extend Image_restorationSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_restorationSeries with reset(_self) { { vals: [], name: "", } }
pub extend Image_restorationSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_restorationVector with check(self) { self.dim > 0 }
pub extend Image_restorationVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_restorationVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Image_restorationVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_stitchMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Image_stitchMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_stitchMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Image_stitchMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_stitchPoint with check(_self) { true }
pub extend Image_stitchPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_stitchPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Image_stitchPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_stitchSeries with check(self) { self.vals.length() > 0 }
pub extend Image_stitchSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_stitchSeries with reset(_self) { { vals: [], name: "", } }
pub extend Image_stitchSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Image_stitchVector with check(self) { self.dim > 0 }
pub extend Image_stitchVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Image_stitchVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Image_stitchVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for InpaintMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend InpaintMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for InpaintMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend InpaintMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for InpaintPoint with check(_self) { true }
pub extend InpaintPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for InpaintPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend InpaintPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for InpaintSeries with check(self) { self.vals.length() > 0 }
pub extend InpaintSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for InpaintSeries with reset(_self) { { vals: [], name: "", } }
pub extend InpaintSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for InpaintVector with check(self) { self.dim > 0 }
pub extend InpaintVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for InpaintVector with reset(_self) { { comps: [], dim: 0, } }
pub extend InpaintVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PanoramaMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend PanoramaMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PanoramaMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend PanoramaMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PanoramaPoint with check(_self) { true }
pub extend PanoramaPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PanoramaPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend PanoramaPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PanoramaSeries with check(self) { self.vals.length() > 0 }
pub extend PanoramaSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PanoramaSeries with reset(_self) { { vals: [], name: "", } }
pub extend PanoramaSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for PanoramaVector with check(self) { self.dim > 0 }
pub extend PanoramaVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for PanoramaVector with reset(_self) { { comps: [], dim: 0, } }
pub extend PanoramaVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Super_resMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Super_resMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Super_resMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Super_resMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Super_resPoint with check(_self) { true }
pub extend Super_resPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Super_resPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Super_resPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Super_resSeries with check(self) { self.vals.length() > 0 }
pub extend Super_resSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Super_resSeries with reset(_self) { { vals: [], name: "", } }
pub extend Super_resSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Super_resVector with check(self) { self.dim > 0 }
pub extend Super_resVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Super_resVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Super_resVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tone_mapMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Tone_mapMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tone_mapMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Tone_mapMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tone_mapPoint with check(_self) { true }
pub extend Tone_mapPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tone_mapPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Tone_mapPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tone_mapSeries with check(self) { self.vals.length() > 0 }
pub extend Tone_mapSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tone_mapSeries with reset(_self) { { vals: [], name: "", } }
pub extend Tone_mapSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Tone_mapVector with check(self) { self.dim > 0 }
pub extend Tone_mapVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Tone_mapVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Tone_mapVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for White_balanceMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend White_balanceMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for White_balanceMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend White_balanceMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for White_balancePoint with check(_self) { true }
pub extend White_balancePoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for White_balancePoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend White_balancePoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for White_balanceSeries with check(self) { self.vals.length() > 0 }
pub extend White_balanceSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for White_balanceSeries with reset(_self) { { vals: [], name: "", } }
pub extend White_balanceSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for White_balanceVector with check(self) { self.dim > 0 }
pub extend White_balanceVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for White_balanceVector with reset(_self) { { comps: [], dim: 0, } }
pub extend White_balanceVector with @traits.Resettable::{reset}