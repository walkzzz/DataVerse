///|
/// # trait implementations for src/learncore/dl

pub impl @traits.Named for Autoencoder_rtMatrix with name(_self) { "Autoencoder_rtMatrix" }
pub extend Autoencoder_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Autoencoder_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Autoencoder_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Autoencoder_rtMatrix with display(self) { "Autoencoder_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Autoencoder_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Autoencoder_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Autoencoder_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Autoencoder_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Autoencoder_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Autoencoder_rtPoint with name(_self) { "Autoencoder_rtPoint" }
pub extend Autoencoder_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Autoencoder_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Autoencoder_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Autoencoder_rtPoint with display(self) { "Autoencoder_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Autoencoder_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Autoencoder_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Autoencoder_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Autoencoder_rtPoint with count(_self) { 2 }
pub extend Autoencoder_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Autoencoder_rtSeries with name(_self) { "Autoencoder_rtSeries" }
pub extend Autoencoder_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Autoencoder_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Autoencoder_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Autoencoder_rtSeries with display(self) { "Autoencoder_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Autoencoder_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Autoencoder_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Autoencoder_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Autoencoder_rtSeries with count(self) { self.vals.length() }
pub extend Autoencoder_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Autoencoder_rtVector with name(_self) { "Autoencoder_rtVector" }
pub extend Autoencoder_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Autoencoder_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Autoencoder_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Autoencoder_rtVector with display(self) { "Autoencoder_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Autoencoder_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Autoencoder_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Autoencoder_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Autoencoder_rtVector with count(self) { self.comps.length() }
pub extend Autoencoder_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Cnn_rtMatrix with name(_self) { "Cnn_rtMatrix" }
pub extend Cnn_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Cnn_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Cnn_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cnn_rtMatrix with display(self) { "Cnn_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Cnn_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cnn_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Cnn_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cnn_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Cnn_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Cnn_rtPoint with name(_self) { "Cnn_rtPoint" }
pub extend Cnn_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Cnn_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Cnn_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cnn_rtPoint with display(self) { "Cnn_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Cnn_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cnn_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Cnn_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cnn_rtPoint with count(_self) { 2 }
pub extend Cnn_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Cnn_rtSeries with name(_self) { "Cnn_rtSeries" }
pub extend Cnn_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Cnn_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Cnn_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cnn_rtSeries with display(self) { "Cnn_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Cnn_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cnn_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Cnn_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cnn_rtSeries with count(self) { self.vals.length() }
pub extend Cnn_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Cnn_rtVector with name(_self) { "Cnn_rtVector" }
pub extend Cnn_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Cnn_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Cnn_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Cnn_rtVector with display(self) { "Cnn_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Cnn_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Cnn_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Cnn_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Cnn_rtVector with count(self) { self.comps.length() }
pub extend Cnn_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Diffusion_rtMatrix with name(_self) { "Diffusion_rtMatrix" }
pub extend Diffusion_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Diffusion_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Diffusion_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Diffusion_rtMatrix with display(self) { "Diffusion_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Diffusion_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Diffusion_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Diffusion_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diffusion_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Diffusion_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Diffusion_rtPoint with name(_self) { "Diffusion_rtPoint" }
pub extend Diffusion_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Diffusion_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Diffusion_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Diffusion_rtPoint with display(self) { "Diffusion_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Diffusion_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Diffusion_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Diffusion_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diffusion_rtPoint with count(_self) { 2 }
pub extend Diffusion_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Diffusion_rtSeries with name(_self) { "Diffusion_rtSeries" }
pub extend Diffusion_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Diffusion_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Diffusion_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Diffusion_rtSeries with display(self) { "Diffusion_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Diffusion_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Diffusion_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Diffusion_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diffusion_rtSeries with count(self) { self.vals.length() }
pub extend Diffusion_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Diffusion_rtVector with name(_self) { "Diffusion_rtVector" }
pub extend Diffusion_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Diffusion_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Diffusion_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Diffusion_rtVector with display(self) { "Diffusion_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Diffusion_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Diffusion_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Diffusion_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Diffusion_rtVector with count(self) { self.comps.length() }
pub extend Diffusion_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Gan_rtMatrix with name(_self) { "Gan_rtMatrix" }
pub extend Gan_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Gan_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Gan_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gan_rtMatrix with display(self) { "Gan_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Gan_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gan_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Gan_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gan_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Gan_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Gan_rtPoint with name(_self) { "Gan_rtPoint" }
pub extend Gan_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Gan_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Gan_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gan_rtPoint with display(self) { "Gan_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Gan_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gan_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Gan_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gan_rtPoint with count(_self) { 2 }
pub extend Gan_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Gan_rtSeries with name(_self) { "Gan_rtSeries" }
pub extend Gan_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Gan_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Gan_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gan_rtSeries with display(self) { "Gan_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Gan_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gan_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Gan_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gan_rtSeries with count(self) { self.vals.length() }
pub extend Gan_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Gan_rtVector with name(_self) { "Gan_rtVector" }
pub extend Gan_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Gan_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Gan_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gan_rtVector with display(self) { "Gan_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Gan_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gan_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Gan_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gan_rtVector with count(self) { self.comps.length() }
pub extend Gan_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Gru_rtMatrix with name(_self) { "Gru_rtMatrix" }
pub extend Gru_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Gru_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Gru_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gru_rtMatrix with display(self) { "Gru_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Gru_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gru_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Gru_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gru_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Gru_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Gru_rtPoint with name(_self) { "Gru_rtPoint" }
pub extend Gru_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Gru_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Gru_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gru_rtPoint with display(self) { "Gru_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Gru_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gru_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Gru_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gru_rtPoint with count(_self) { 2 }
pub extend Gru_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Gru_rtSeries with name(_self) { "Gru_rtSeries" }
pub extend Gru_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Gru_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Gru_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gru_rtSeries with display(self) { "Gru_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Gru_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gru_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Gru_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gru_rtSeries with count(self) { self.vals.length() }
pub extend Gru_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Gru_rtVector with name(_self) { "Gru_rtVector" }
pub extend Gru_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Gru_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Gru_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Gru_rtVector with display(self) { "Gru_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Gru_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Gru_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Gru_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Gru_rtVector with count(self) { self.comps.length() }
pub extend Gru_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Lstm_rtMatrix with name(_self) { "Lstm_rtMatrix" }
pub extend Lstm_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Lstm_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Lstm_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Lstm_rtMatrix with display(self) { "Lstm_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Lstm_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Lstm_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Lstm_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Lstm_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Lstm_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Lstm_rtPoint with name(_self) { "Lstm_rtPoint" }
pub extend Lstm_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Lstm_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Lstm_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Lstm_rtPoint with display(self) { "Lstm_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Lstm_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Lstm_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Lstm_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Lstm_rtPoint with count(_self) { 2 }
pub extend Lstm_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Lstm_rtSeries with name(_self) { "Lstm_rtSeries" }
pub extend Lstm_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Lstm_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Lstm_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Lstm_rtSeries with display(self) { "Lstm_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Lstm_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Lstm_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Lstm_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Lstm_rtSeries with count(self) { self.vals.length() }
pub extend Lstm_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Lstm_rtVector with name(_self) { "Lstm_rtVector" }
pub extend Lstm_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Lstm_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Lstm_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Lstm_rtVector with display(self) { "Lstm_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Lstm_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Lstm_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Lstm_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Lstm_rtVector with count(self) { self.comps.length() }
pub extend Lstm_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Mlp_rtMatrix with name(_self) { "Mlp_rtMatrix" }
pub extend Mlp_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Mlp_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Mlp_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Mlp_rtMatrix with display(self) { "Mlp_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Mlp_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Mlp_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Mlp_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Mlp_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Mlp_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Mlp_rtPoint with name(_self) { "Mlp_rtPoint" }
pub extend Mlp_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Mlp_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Mlp_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Mlp_rtPoint with display(self) { "Mlp_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Mlp_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Mlp_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Mlp_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Mlp_rtPoint with count(_self) { 2 }
pub extend Mlp_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Mlp_rtSeries with name(_self) { "Mlp_rtSeries" }
pub extend Mlp_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Mlp_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Mlp_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Mlp_rtSeries with display(self) { "Mlp_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Mlp_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Mlp_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Mlp_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Mlp_rtSeries with count(self) { self.vals.length() }
pub extend Mlp_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Mlp_rtVector with name(_self) { "Mlp_rtVector" }
pub extend Mlp_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Mlp_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Mlp_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Mlp_rtVector with display(self) { "Mlp_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Mlp_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Mlp_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Mlp_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Mlp_rtVector with count(self) { self.comps.length() }
pub extend Mlp_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Rnn_rtMatrix with name(_self) { "Rnn_rtMatrix" }
pub extend Rnn_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Rnn_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Rnn_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rnn_rtMatrix with display(self) { "Rnn_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Rnn_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rnn_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Rnn_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rnn_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Rnn_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Rnn_rtPoint with name(_self) { "Rnn_rtPoint" }
pub extend Rnn_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Rnn_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Rnn_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rnn_rtPoint with display(self) { "Rnn_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Rnn_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rnn_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Rnn_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rnn_rtPoint with count(_self) { 2 }
pub extend Rnn_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Rnn_rtSeries with name(_self) { "Rnn_rtSeries" }
pub extend Rnn_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Rnn_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Rnn_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rnn_rtSeries with display(self) { "Rnn_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Rnn_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rnn_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Rnn_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rnn_rtSeries with count(self) { self.vals.length() }
pub extend Rnn_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Rnn_rtVector with name(_self) { "Rnn_rtVector" }
pub extend Rnn_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Rnn_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Rnn_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Rnn_rtVector with display(self) { "Rnn_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Rnn_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Rnn_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Rnn_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Rnn_rtVector with count(self) { self.comps.length() }
pub extend Rnn_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Transformer_rtMatrix with name(_self) { "Transformer_rtMatrix" }
pub extend Transformer_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Transformer_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Transformer_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Transformer_rtMatrix with display(self) { "Transformer_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Transformer_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Transformer_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Transformer_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Transformer_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Transformer_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Transformer_rtPoint with name(_self) { "Transformer_rtPoint" }
pub extend Transformer_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Transformer_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Transformer_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Transformer_rtPoint with display(self) { "Transformer_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Transformer_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Transformer_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Transformer_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Transformer_rtPoint with count(_self) { 2 }
pub extend Transformer_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Transformer_rtSeries with name(_self) { "Transformer_rtSeries" }
pub extend Transformer_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Transformer_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Transformer_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Transformer_rtSeries with display(self) { "Transformer_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Transformer_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Transformer_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Transformer_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Transformer_rtSeries with count(self) { self.vals.length() }
pub extend Transformer_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Transformer_rtVector with name(_self) { "Transformer_rtVector" }
pub extend Transformer_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Transformer_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Transformer_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Transformer_rtVector with display(self) { "Transformer_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Transformer_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Transformer_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Transformer_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Transformer_rtVector with count(self) { self.comps.length() }
pub extend Transformer_rtVector with @traits.Countable::{count}
///|
pub impl @traits.Named for Vae_rtMatrix with name(_self) { "Vae_rtMatrix" }
pub extend Vae_rtMatrix with @traits.Named::{name}
///|
pub impl @traits.Describable for Vae_rtMatrix with describe(self) { "rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() }
pub extend Vae_rtMatrix with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Vae_rtMatrix with display(self) { "Vae_rtMatrix[rows=" + self.rows.to_string() + ", cols=" + self.cols.to_string() + "]" }
pub extend Vae_rtMatrix with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Vae_rtMatrix with clone(self) { { data: self.data, rows: self.rows, cols: self.cols, } }
pub extend Vae_rtMatrix with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Vae_rtMatrix with count(self) { (self.rows * self.cols) }
pub extend Vae_rtMatrix with @traits.Countable::{count}
///|
pub impl @traits.Named for Vae_rtPoint with name(_self) { "Vae_rtPoint" }
pub extend Vae_rtPoint with @traits.Named::{name}
///|
pub impl @traits.Describable for Vae_rtPoint with describe(self) { "x=" + self.x.to_string() + ", y=" + self.y.to_string() }
pub extend Vae_rtPoint with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Vae_rtPoint with display(self) { "Vae_rtPoint(x=" + self.x.to_string() + ", y=" + self.y.to_string() + ")" }
pub extend Vae_rtPoint with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Vae_rtPoint with clone(self) { { x: self.x, y: self.y, label: self.label, } }
pub extend Vae_rtPoint with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Vae_rtPoint with count(_self) { 2 }
pub extend Vae_rtPoint with @traits.Countable::{count}
///|
pub impl @traits.Named for Vae_rtSeries with name(_self) { "Vae_rtSeries" }
pub extend Vae_rtSeries with @traits.Named::{name}
///|
pub impl @traits.Describable for Vae_rtSeries with describe(self) { "len=" + self.vals.length().to_string() }
pub extend Vae_rtSeries with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Vae_rtSeries with display(self) { "Vae_rtSeries[len=" + self.vals.length().to_string() + "]" }
pub extend Vae_rtSeries with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Vae_rtSeries with clone(self) { { vals: self.vals, name: self.name, } }
pub extend Vae_rtSeries with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Vae_rtSeries with count(self) { self.vals.length() }
pub extend Vae_rtSeries with @traits.Countable::{count}
///|
pub impl @traits.Named for Vae_rtVector with name(_self) { "Vae_rtVector" }
pub extend Vae_rtVector with @traits.Named::{name}
///|
pub impl @traits.Describable for Vae_rtVector with describe(self) { "dim=" + self.dim.to_string() }
pub extend Vae_rtVector with @traits.Describable::{describe}
///|
pub impl @traits.Displayable for Vae_rtVector with display(self) { "Vae_rtVector[dim=" + self.dim.to_string() + "]" }
pub extend Vae_rtVector with @traits.Displayable::{display}
///|
pub impl @traits.Cloneable for Vae_rtVector with clone(self) { { comps: self.comps, dim: self.dim, } }
pub extend Vae_rtVector with @traits.Cloneable::{clone}
///|
pub impl @traits.Countable for Vae_rtVector with count(self) { self.comps.length() }
pub extend Vae_rtVector with @traits.Countable::{count}




///|
/// # Checkable + Resettable implementations

///|

pub impl @traits.Checkable for Autoencoder_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Autoencoder_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Autoencoder_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Autoencoder_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Autoencoder_rtPoint with check(_self) { true }
pub extend Autoencoder_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Autoencoder_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Autoencoder_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Autoencoder_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Autoencoder_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Autoencoder_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Autoencoder_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Autoencoder_rtVector with check(self) { self.dim > 0 }
pub extend Autoencoder_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Autoencoder_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Autoencoder_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cnn_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Cnn_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cnn_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Cnn_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cnn_rtPoint with check(_self) { true }
pub extend Cnn_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cnn_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Cnn_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cnn_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Cnn_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cnn_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Cnn_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Cnn_rtVector with check(self) { self.dim > 0 }
pub extend Cnn_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Cnn_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Cnn_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diffusion_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Diffusion_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diffusion_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Diffusion_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diffusion_rtPoint with check(_self) { true }
pub extend Diffusion_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diffusion_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Diffusion_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diffusion_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Diffusion_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diffusion_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Diffusion_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Diffusion_rtVector with check(self) { self.dim > 0 }
pub extend Diffusion_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Diffusion_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Diffusion_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gan_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Gan_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gan_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Gan_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gan_rtPoint with check(_self) { true }
pub extend Gan_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gan_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Gan_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gan_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Gan_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gan_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Gan_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gan_rtVector with check(self) { self.dim > 0 }
pub extend Gan_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gan_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Gan_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gru_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Gru_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gru_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Gru_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gru_rtPoint with check(_self) { true }
pub extend Gru_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gru_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Gru_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gru_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Gru_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gru_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Gru_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Gru_rtVector with check(self) { self.dim > 0 }
pub extend Gru_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Gru_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Gru_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Lstm_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Lstm_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Lstm_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Lstm_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Lstm_rtPoint with check(_self) { true }
pub extend Lstm_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Lstm_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Lstm_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Lstm_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Lstm_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Lstm_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Lstm_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Lstm_rtVector with check(self) { self.dim > 0 }
pub extend Lstm_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Lstm_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Lstm_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Mlp_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Mlp_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Mlp_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Mlp_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Mlp_rtPoint with check(_self) { true }
pub extend Mlp_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Mlp_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Mlp_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Mlp_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Mlp_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Mlp_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Mlp_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Mlp_rtVector with check(self) { self.dim > 0 }
pub extend Mlp_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Mlp_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Mlp_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rnn_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Rnn_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rnn_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Rnn_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rnn_rtPoint with check(_self) { true }
pub extend Rnn_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rnn_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Rnn_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rnn_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Rnn_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rnn_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Rnn_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Rnn_rtVector with check(self) { self.dim > 0 }
pub extend Rnn_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Rnn_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Rnn_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Transformer_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Transformer_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Transformer_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Transformer_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Transformer_rtPoint with check(_self) { true }
pub extend Transformer_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Transformer_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Transformer_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Transformer_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Transformer_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Transformer_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Transformer_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Transformer_rtVector with check(self) { self.dim > 0 }
pub extend Transformer_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Transformer_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Transformer_rtVector with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Vae_rtMatrix with check(self) { self.rows > 0 && self.cols > 0 }
pub extend Vae_rtMatrix with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Vae_rtMatrix with reset(_self) { { data: [], rows: 0, cols: 0, } }
pub extend Vae_rtMatrix with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Vae_rtPoint with check(_self) { true }
pub extend Vae_rtPoint with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Vae_rtPoint with reset(_self) { { x: 0.0, y: 0.0, label: 0, } }
pub extend Vae_rtPoint with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Vae_rtSeries with check(self) { self.vals.length() > 0 }
pub extend Vae_rtSeries with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Vae_rtSeries with reset(_self) { { vals: [], name: "", } }
pub extend Vae_rtSeries with @traits.Resettable::{reset}

///|

pub impl @traits.Checkable for Vae_rtVector with check(self) { self.dim > 0 }
pub extend Vae_rtVector with @traits.Checkable::{check}

///|

pub impl @traits.Resettable for Vae_rtVector with reset(_self) { { comps: [], dim: 0, } }
pub extend Vae_rtVector with @traits.Resettable::{reset}
