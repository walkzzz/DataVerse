///===
/// extcore/geo_proj_azimuthal

pub(all) struct GeoprojazimuthalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_azimuthal_make_point(x : Double, y : Double) -> GeoprojazimuthalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_azimuthal_make_point3(x : Double, y : Double, z : Double) -> GeoprojazimuthalPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojazimuthalPoint::x(self : GeoprojazimuthalPoint) -> Double { self.x }

pub fn GeoprojazimuthalPoint::y(self : GeoprojazimuthalPoint) -> Double { self.y }

pub fn GeoprojazimuthalPoint::z(self : GeoprojazimuthalPoint) -> Double { self.z }

pub fn GeoprojazimuthalPoint::label(self : GeoprojazimuthalPoint) -> Int { self.label }

pub fn GeoprojazimuthalPoint::dist(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojazimuthalPoint::add(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojazimuthalPoint::sub(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojazimuthalPoint::scale(self : GeoprojazimuthalPoint, s : Double) -> GeoprojazimuthalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojazimuthalPoint::dot(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojazimuthalPoint::cross(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojazimuthalPoint::norm(self : GeoprojazimuthalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojazimuthalPoint::normalize(self : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojazimuthalPoint::negate(self : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojazimuthalPoint::mid(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojazimuthalPoint::lerp(self : GeoprojazimuthalPoint, other : GeoprojazimuthalPoint, t : Double) -> GeoprojazimuthalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojazimuthalPoint::to_string(self : GeoprojazimuthalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojazimuthalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_azimuthal_make_series(vals : Array[Double], name : String) -> GeoprojazimuthalSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojazimuthalSeries::len(self : GeoprojazimuthalSeries) -> Int { self.vals.length() }

pub fn GeoprojazimuthalSeries::sum(self : GeoprojazimuthalSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojazimuthalSeries::mean(self : GeoprojazimuthalSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojazimuthalSeries::min(self : GeoprojazimuthalSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojazimuthalSeries::max(self : GeoprojazimuthalSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojazimuthalSeries::range(self : GeoprojazimuthalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojazimuthalSeries::variance(self : GeoprojazimuthalSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojazimuthalSeries::std(self : GeoprojazimuthalSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojazimuthalSeries::median(self : GeoprojazimuthalSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojazimuthalSeries::scale(self : GeoprojazimuthalSeries, f : Double) -> GeoprojazimuthalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojazimuthalSeries::add(self : GeoprojazimuthalSeries, other : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojazimuthalSeries::sub(self : GeoprojazimuthalSeries, other : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojazimuthalSeries::normalize(self : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojazimuthalSeries::cumsum(self : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojazimuthalSeries::to_string(self : GeoprojazimuthalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojazimuthalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_azimuthal_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojazimuthalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_azimuthal_matrix_identity(n : Int) -> GeoprojazimuthalMatrix {
  let m = geo_proj_azimuthal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojazimuthalMatrix::get(self : GeoprojazimuthalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojazimuthalMatrix::transpose(self : GeoprojazimuthalMatrix) -> GeoprojazimuthalMatrix {
  let result = geo_proj_azimuthal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojazimuthalMatrix::add(self : GeoprojazimuthalMatrix, other : GeoprojazimuthalMatrix) -> GeoprojazimuthalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_azimuthal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojazimuthalMatrix::scale(self : GeoprojazimuthalMatrix, s : Double) -> GeoprojazimuthalMatrix {
  let result = geo_proj_azimuthal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojazimuthalMatrix::multiply(self : GeoprojazimuthalMatrix, other : GeoprojazimuthalMatrix) -> GeoprojazimuthalMatrix {
  if self.cols != other.rows { return geo_proj_azimuthal_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_azimuthal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojazimuthalMatrix::trace(self : GeoprojazimuthalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojazimuthalMatrix::det(self : GeoprojazimuthalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojazimuthalMatrix::norm(self : GeoprojazimuthalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojazimuthalMatrix::to_string(self : GeoprojazimuthalMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeoprojazimuthalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_azimuthal_make_vector(comps : Array[Double]) -> GeoprojazimuthalVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_azimuthal_vector_zero(dim : Int) -> GeoprojazimuthalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojazimuthalVector::add(self : GeoprojazimuthalVector, other : GeoprojazimuthalVector) -> GeoprojazimuthalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojazimuthalVector::sub(self : GeoprojazimuthalVector, other : GeoprojazimuthalVector) -> GeoprojazimuthalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojazimuthalVector::scale(self : GeoprojazimuthalVector, s : Double) -> GeoprojazimuthalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojazimuthalVector::dot(self : GeoprojazimuthalVector, other : GeoprojazimuthalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojazimuthalVector::norm(self : GeoprojazimuthalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojazimuthalVector::normalize(self : GeoprojazimuthalVector) -> GeoprojazimuthalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojazimuthalVector::dist(self : GeoprojazimuthalVector, other : GeoprojazimuthalVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojazimuthalVector::to_string(self : GeoprojazimuthalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_azimuthal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_azimuthal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_azimuthal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_azimuthal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_azimuthal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_azimuthal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_azimuthal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_azimuthal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_azimuthal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_azimuthal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_azimuthal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_azimuthal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_azimuthal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_azimuthal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_azimuthal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_azimuthal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_azimuthal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_azimuthal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_azimuthal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_azimuthal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_azimuthal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_azimuthal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_azimuthal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_azimuthal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_azimuthal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_azimuthal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_azimuthal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_azimuthal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_azimuthal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojazimuthalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_frame_make(size : Int) -> GeoprojazimuthalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalFrame::len(self : GeoprojazimuthalFrame) -> Int { self.size }

pub fn GeoprojazimuthalFrame::get(self : GeoprojazimuthalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalFrame::set(self : GeoprojazimuthalFrame, i : Int, v : Double) -> GeoprojazimuthalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalFrame::sum(self : GeoprojazimuthalFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalFrame::mean(self : GeoprojazimuthalFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalFrame::scale(self : GeoprojazimuthalFrame, f : Double) -> GeoprojazimuthalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalFrame::add(self : GeoprojazimuthalFrame, other : GeoprojazimuthalFrame) -> GeoprojazimuthalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalFrame::copy(self : GeoprojazimuthalFrame) -> GeoprojazimuthalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalFrame::fill(self : GeoprojazimuthalFrame, v : Double) -> GeoprojazimuthalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalFrame::min(self : GeoprojazimuthalFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalFrame::max(self : GeoprojazimuthalFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalFrame::to_string(self : GeoprojazimuthalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_table_make(size : Int) -> GeoprojazimuthalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalTable::len(self : GeoprojazimuthalTable) -> Int { self.size }

pub fn GeoprojazimuthalTable::get(self : GeoprojazimuthalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalTable::set(self : GeoprojazimuthalTable, i : Int, v : Double) -> GeoprojazimuthalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalTable::sum(self : GeoprojazimuthalTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalTable::mean(self : GeoprojazimuthalTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalTable::scale(self : GeoprojazimuthalTable, f : Double) -> GeoprojazimuthalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalTable::add(self : GeoprojazimuthalTable, other : GeoprojazimuthalTable) -> GeoprojazimuthalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalTable::copy(self : GeoprojazimuthalTable) -> GeoprojazimuthalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalTable::fill(self : GeoprojazimuthalTable, v : Double) -> GeoprojazimuthalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalTable::min(self : GeoprojazimuthalTable) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalTable::max(self : GeoprojazimuthalTable) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalTable::to_string(self : GeoprojazimuthalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_graphn_make(size : Int) -> GeoprojazimuthalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalGraphN::len(self : GeoprojazimuthalGraphN) -> Int { self.size }

pub fn GeoprojazimuthalGraphN::get(self : GeoprojazimuthalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalGraphN::set(self : GeoprojazimuthalGraphN, i : Int, v : Double) -> GeoprojazimuthalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalGraphN::sum(self : GeoprojazimuthalGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalGraphN::mean(self : GeoprojazimuthalGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalGraphN::scale(self : GeoprojazimuthalGraphN, f : Double) -> GeoprojazimuthalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalGraphN::add(self : GeoprojazimuthalGraphN, other : GeoprojazimuthalGraphN) -> GeoprojazimuthalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalGraphN::copy(self : GeoprojazimuthalGraphN) -> GeoprojazimuthalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalGraphN::fill(self : GeoprojazimuthalGraphN, v : Double) -> GeoprojazimuthalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalGraphN::min(self : GeoprojazimuthalGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalGraphN::max(self : GeoprojazimuthalGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalGraphN::to_string(self : GeoprojazimuthalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_node_make(size : Int) -> GeoprojazimuthalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalNode::len(self : GeoprojazimuthalNode) -> Int { self.size }

pub fn GeoprojazimuthalNode::get(self : GeoprojazimuthalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalNode::set(self : GeoprojazimuthalNode, i : Int, v : Double) -> GeoprojazimuthalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalNode::sum(self : GeoprojazimuthalNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalNode::mean(self : GeoprojazimuthalNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalNode::scale(self : GeoprojazimuthalNode, f : Double) -> GeoprojazimuthalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalNode::add(self : GeoprojazimuthalNode, other : GeoprojazimuthalNode) -> GeoprojazimuthalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalNode::copy(self : GeoprojazimuthalNode) -> GeoprojazimuthalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalNode::fill(self : GeoprojazimuthalNode, v : Double) -> GeoprojazimuthalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalNode::min(self : GeoprojazimuthalNode) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalNode::max(self : GeoprojazimuthalNode) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalNode::to_string(self : GeoprojazimuthalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_edge_make(size : Int) -> GeoprojazimuthalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalEdge::len(self : GeoprojazimuthalEdge) -> Int { self.size }

pub fn GeoprojazimuthalEdge::get(self : GeoprojazimuthalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalEdge::set(self : GeoprojazimuthalEdge, i : Int, v : Double) -> GeoprojazimuthalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalEdge::sum(self : GeoprojazimuthalEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalEdge::mean(self : GeoprojazimuthalEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalEdge::scale(self : GeoprojazimuthalEdge, f : Double) -> GeoprojazimuthalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalEdge::add(self : GeoprojazimuthalEdge, other : GeoprojazimuthalEdge) -> GeoprojazimuthalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalEdge::copy(self : GeoprojazimuthalEdge) -> GeoprojazimuthalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalEdge::fill(self : GeoprojazimuthalEdge, v : Double) -> GeoprojazimuthalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalEdge::min(self : GeoprojazimuthalEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalEdge::max(self : GeoprojazimuthalEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalEdge::to_string(self : GeoprojazimuthalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_path_make(size : Int) -> GeoprojazimuthalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalPath::len(self : GeoprojazimuthalPath) -> Int { self.size }

pub fn GeoprojazimuthalPath::get(self : GeoprojazimuthalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalPath::set(self : GeoprojazimuthalPath, i : Int, v : Double) -> GeoprojazimuthalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalPath::sum(self : GeoprojazimuthalPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalPath::mean(self : GeoprojazimuthalPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalPath::scale(self : GeoprojazimuthalPath, f : Double) -> GeoprojazimuthalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalPath::add(self : GeoprojazimuthalPath, other : GeoprojazimuthalPath) -> GeoprojazimuthalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalPath::copy(self : GeoprojazimuthalPath) -> GeoprojazimuthalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalPath::fill(self : GeoprojazimuthalPath, v : Double) -> GeoprojazimuthalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalPath::min(self : GeoprojazimuthalPath) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalPath::max(self : GeoprojazimuthalPath) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalPath::to_string(self : GeoprojazimuthalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_cluster_make(size : Int) -> GeoprojazimuthalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalCluster::len(self : GeoprojazimuthalCluster) -> Int { self.size }

pub fn GeoprojazimuthalCluster::get(self : GeoprojazimuthalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalCluster::set(self : GeoprojazimuthalCluster, i : Int, v : Double) -> GeoprojazimuthalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCluster::sum(self : GeoprojazimuthalCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalCluster::mean(self : GeoprojazimuthalCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalCluster::scale(self : GeoprojazimuthalCluster, f : Double) -> GeoprojazimuthalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCluster::add(self : GeoprojazimuthalCluster, other : GeoprojazimuthalCluster) -> GeoprojazimuthalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalCluster::copy(self : GeoprojazimuthalCluster) -> GeoprojazimuthalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCluster::fill(self : GeoprojazimuthalCluster, v : Double) -> GeoprojazimuthalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCluster::min(self : GeoprojazimuthalCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalCluster::max(self : GeoprojazimuthalCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalCluster::to_string(self : GeoprojazimuthalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_model_make(size : Int) -> GeoprojazimuthalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalModel::len(self : GeoprojazimuthalModel) -> Int { self.size }

pub fn GeoprojazimuthalModel::get(self : GeoprojazimuthalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalModel::set(self : GeoprojazimuthalModel, i : Int, v : Double) -> GeoprojazimuthalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalModel::sum(self : GeoprojazimuthalModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalModel::mean(self : GeoprojazimuthalModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalModel::scale(self : GeoprojazimuthalModel, f : Double) -> GeoprojazimuthalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalModel::add(self : GeoprojazimuthalModel, other : GeoprojazimuthalModel) -> GeoprojazimuthalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalModel::copy(self : GeoprojazimuthalModel) -> GeoprojazimuthalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalModel::fill(self : GeoprojazimuthalModel, v : Double) -> GeoprojazimuthalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalModel::min(self : GeoprojazimuthalModel) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalModel::max(self : GeoprojazimuthalModel) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalModel::to_string(self : GeoprojazimuthalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_layer_make(size : Int) -> GeoprojazimuthalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalLayer::len(self : GeoprojazimuthalLayer) -> Int { self.size }

pub fn GeoprojazimuthalLayer::get(self : GeoprojazimuthalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalLayer::set(self : GeoprojazimuthalLayer, i : Int, v : Double) -> GeoprojazimuthalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalLayer::sum(self : GeoprojazimuthalLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalLayer::mean(self : GeoprojazimuthalLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalLayer::scale(self : GeoprojazimuthalLayer, f : Double) -> GeoprojazimuthalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalLayer::add(self : GeoprojazimuthalLayer, other : GeoprojazimuthalLayer) -> GeoprojazimuthalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalLayer::copy(self : GeoprojazimuthalLayer) -> GeoprojazimuthalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalLayer::fill(self : GeoprojazimuthalLayer, v : Double) -> GeoprojazimuthalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalLayer::min(self : GeoprojazimuthalLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalLayer::max(self : GeoprojazimuthalLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalLayer::to_string(self : GeoprojazimuthalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_buffer_make(size : Int) -> GeoprojazimuthalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalBuffer::len(self : GeoprojazimuthalBuffer) -> Int { self.size }

pub fn GeoprojazimuthalBuffer::get(self : GeoprojazimuthalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalBuffer::set(self : GeoprojazimuthalBuffer, i : Int, v : Double) -> GeoprojazimuthalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalBuffer::sum(self : GeoprojazimuthalBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalBuffer::mean(self : GeoprojazimuthalBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalBuffer::scale(self : GeoprojazimuthalBuffer, f : Double) -> GeoprojazimuthalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalBuffer::add(self : GeoprojazimuthalBuffer, other : GeoprojazimuthalBuffer) -> GeoprojazimuthalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalBuffer::copy(self : GeoprojazimuthalBuffer) -> GeoprojazimuthalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalBuffer::fill(self : GeoprojazimuthalBuffer, v : Double) -> GeoprojazimuthalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalBuffer::min(self : GeoprojazimuthalBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalBuffer::max(self : GeoprojazimuthalBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalBuffer::to_string(self : GeoprojazimuthalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_cursor_make(size : Int) -> GeoprojazimuthalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalCursor::len(self : GeoprojazimuthalCursor) -> Int { self.size }

pub fn GeoprojazimuthalCursor::get(self : GeoprojazimuthalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalCursor::set(self : GeoprojazimuthalCursor, i : Int, v : Double) -> GeoprojazimuthalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCursor::sum(self : GeoprojazimuthalCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalCursor::mean(self : GeoprojazimuthalCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalCursor::scale(self : GeoprojazimuthalCursor, f : Double) -> GeoprojazimuthalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCursor::add(self : GeoprojazimuthalCursor, other : GeoprojazimuthalCursor) -> GeoprojazimuthalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalCursor::copy(self : GeoprojazimuthalCursor) -> GeoprojazimuthalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCursor::fill(self : GeoprojazimuthalCursor, v : Double) -> GeoprojazimuthalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalCursor::min(self : GeoprojazimuthalCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalCursor::max(self : GeoprojazimuthalCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalCursor::to_string(self : GeoprojazimuthalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_view_make(size : Int) -> GeoprojazimuthalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalView::len(self : GeoprojazimuthalView) -> Int { self.size }

pub fn GeoprojazimuthalView::get(self : GeoprojazimuthalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalView::set(self : GeoprojazimuthalView, i : Int, v : Double) -> GeoprojazimuthalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalView::sum(self : GeoprojazimuthalView) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalView::mean(self : GeoprojazimuthalView) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalView::scale(self : GeoprojazimuthalView, f : Double) -> GeoprojazimuthalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalView::add(self : GeoprojazimuthalView, other : GeoprojazimuthalView) -> GeoprojazimuthalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalView::copy(self : GeoprojazimuthalView) -> GeoprojazimuthalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalView::fill(self : GeoprojazimuthalView, v : Double) -> GeoprojazimuthalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalView::min(self : GeoprojazimuthalView) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalView::max(self : GeoprojazimuthalView) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalView::to_string(self : GeoprojazimuthalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_range_make(size : Int) -> GeoprojazimuthalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalRange::len(self : GeoprojazimuthalRange) -> Int { self.size }

pub fn GeoprojazimuthalRange::get(self : GeoprojazimuthalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalRange::set(self : GeoprojazimuthalRange, i : Int, v : Double) -> GeoprojazimuthalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalRange::sum(self : GeoprojazimuthalRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalRange::mean(self : GeoprojazimuthalRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalRange::scale(self : GeoprojazimuthalRange, f : Double) -> GeoprojazimuthalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalRange::add(self : GeoprojazimuthalRange, other : GeoprojazimuthalRange) -> GeoprojazimuthalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalRange::copy(self : GeoprojazimuthalRange) -> GeoprojazimuthalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalRange::fill(self : GeoprojazimuthalRange, v : Double) -> GeoprojazimuthalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalRange::min(self : GeoprojazimuthalRange) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalRange::max(self : GeoprojazimuthalRange) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalRange::to_string(self : GeoprojazimuthalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_slice_make(size : Int) -> GeoprojazimuthalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojazimuthalSlice::len(self : GeoprojazimuthalSlice) -> Int { self.size }

pub fn GeoprojazimuthalSlice::get(self : GeoprojazimuthalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojazimuthalSlice::set(self : GeoprojazimuthalSlice, i : Int, v : Double) -> GeoprojazimuthalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalSlice::sum(self : GeoprojazimuthalSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojazimuthalSlice::mean(self : GeoprojazimuthalSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojazimuthalSlice::scale(self : GeoprojazimuthalSlice, f : Double) -> GeoprojazimuthalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalSlice::add(self : GeoprojazimuthalSlice, other : GeoprojazimuthalSlice) -> GeoprojazimuthalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojazimuthalSlice::copy(self : GeoprojazimuthalSlice) -> GeoprojazimuthalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalSlice::fill(self : GeoprojazimuthalSlice, v : Double) -> GeoprojazimuthalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojazimuthalSlice::min(self : GeoprojazimuthalSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojazimuthalSlice::max(self : GeoprojazimuthalSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojazimuthalSlice::to_string(self : GeoprojazimuthalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

