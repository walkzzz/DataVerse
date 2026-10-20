///===
/// extcore/geo_dist_euclidean

pub(all) struct GeodisteuclideanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_euclidean_make_point(x : Double, y : Double) -> GeodisteuclideanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_euclidean_make_point3(x : Double, y : Double, z : Double) -> GeodisteuclideanPoint {
  { x, y, z, label: 0 }
}

pub fn GeodisteuclideanPoint::x(self : GeodisteuclideanPoint) -> Double { self.x }

pub fn GeodisteuclideanPoint::y(self : GeodisteuclideanPoint) -> Double { self.y }

pub fn GeodisteuclideanPoint::z(self : GeodisteuclideanPoint) -> Double { self.z }

pub fn GeodisteuclideanPoint::label(self : GeodisteuclideanPoint) -> Int { self.label }

pub fn GeodisteuclideanPoint::dist(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodisteuclideanPoint::add(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodisteuclideanPoint::sub(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodisteuclideanPoint::scale(self : GeodisteuclideanPoint, s : Double) -> GeodisteuclideanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodisteuclideanPoint::dot(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodisteuclideanPoint::cross(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodisteuclideanPoint::norm(self : GeodisteuclideanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodisteuclideanPoint::normalize(self : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodisteuclideanPoint::negate(self : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodisteuclideanPoint::mid(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodisteuclideanPoint::lerp(self : GeodisteuclideanPoint, other : GeodisteuclideanPoint, t : Double) -> GeodisteuclideanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodisteuclideanPoint::to_string(self : GeodisteuclideanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodisteuclideanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_euclidean_make_series(vals : Array[Double], name : String) -> GeodisteuclideanSeries {
  { vals, name, meta: 0 }
}

pub fn GeodisteuclideanSeries::len(self : GeodisteuclideanSeries) -> Int { self.vals.length() }

pub fn GeodisteuclideanSeries::sum(self : GeodisteuclideanSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodisteuclideanSeries::mean(self : GeodisteuclideanSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodisteuclideanSeries::min(self : GeodisteuclideanSeries) -> Double { @_common.min(self.vals) }

pub fn GeodisteuclideanSeries::max(self : GeodisteuclideanSeries) -> Double { @_common.max(self.vals) }

pub fn GeodisteuclideanSeries::range(self : GeodisteuclideanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodisteuclideanSeries::variance(self : GeodisteuclideanSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodisteuclideanSeries::std(self : GeodisteuclideanSeries) -> Double { @_common.std(self.vals) }

pub fn GeodisteuclideanSeries::median(self : GeodisteuclideanSeries) -> Double { @_common.median(self.vals) }

pub fn GeodisteuclideanSeries::scale(self : GeodisteuclideanSeries, f : Double) -> GeodisteuclideanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodisteuclideanSeries::add(self : GeodisteuclideanSeries, other : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodisteuclideanSeries::sub(self : GeodisteuclideanSeries, other : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodisteuclideanSeries::normalize(self : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodisteuclideanSeries::cumsum(self : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodisteuclideanSeries::to_string(self : GeodisteuclideanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodisteuclideanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_euclidean_make_matrix(rows : Int, cols : Int, val : Double) -> GeodisteuclideanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_euclidean_matrix_identity(n : Int) -> GeodisteuclideanMatrix {
  let m = geo_dist_euclidean_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodisteuclideanMatrix::get(self : GeodisteuclideanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodisteuclideanMatrix::transpose(self : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  let result = geo_dist_euclidean_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodisteuclideanMatrix::add(self : GeodisteuclideanMatrix, other : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_euclidean_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodisteuclideanMatrix::scale(self : GeodisteuclideanMatrix, s : Double) -> GeodisteuclideanMatrix {
  let result = geo_dist_euclidean_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodisteuclideanMatrix::multiply(self : GeodisteuclideanMatrix, other : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  if self.cols != other.rows { return geo_dist_euclidean_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_euclidean_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodisteuclideanMatrix::trace(self : GeodisteuclideanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodisteuclideanMatrix::det(self : GeodisteuclideanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodisteuclideanMatrix::norm(self : GeodisteuclideanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodisteuclideanMatrix::to_string(self : GeodisteuclideanMatrix) -> String {
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

pub(all) struct GeodisteuclideanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_euclidean_make_vector(comps : Array[Double]) -> GeodisteuclideanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_euclidean_vector_zero(dim : Int) -> GeodisteuclideanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodisteuclideanVector::add(self : GeodisteuclideanVector, other : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodisteuclideanVector::sub(self : GeodisteuclideanVector, other : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodisteuclideanVector::scale(self : GeodisteuclideanVector, s : Double) -> GeodisteuclideanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodisteuclideanVector::dot(self : GeodisteuclideanVector, other : GeodisteuclideanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodisteuclideanVector::norm(self : GeodisteuclideanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodisteuclideanVector::normalize(self : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodisteuclideanVector::dist(self : GeodisteuclideanVector, other : GeodisteuclideanVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodisteuclideanVector::to_string(self : GeodisteuclideanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_euclidean_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_euclidean_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_euclidean_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_euclidean_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_euclidean_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_euclidean_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_euclidean_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_euclidean_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_euclidean_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_euclidean_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_euclidean_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_euclidean_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_euclidean_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_euclidean_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_euclidean_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_euclidean_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_euclidean_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_euclidean_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_euclidean_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_euclidean_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_euclidean_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_euclidean_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_euclidean_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_euclidean_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_euclidean_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_euclidean_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_euclidean_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_euclidean_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_euclidean_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodisteuclideanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_frame_make(size : Int) -> GeodisteuclideanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanFrame::len(self : GeodisteuclideanFrame) -> Int { self.size }

pub fn GeodisteuclideanFrame::get(self : GeodisteuclideanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanFrame::set(self : GeodisteuclideanFrame, i : Int, v : Double) -> GeodisteuclideanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanFrame::sum(self : GeodisteuclideanFrame) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanFrame::mean(self : GeodisteuclideanFrame) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanFrame::scale(self : GeodisteuclideanFrame, f : Double) -> GeodisteuclideanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanFrame::add(self : GeodisteuclideanFrame, other : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanFrame::copy(self : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanFrame::fill(self : GeodisteuclideanFrame, v : Double) -> GeodisteuclideanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanFrame::min(self : GeodisteuclideanFrame) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanFrame::max(self : GeodisteuclideanFrame) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanFrame::to_string(self : GeodisteuclideanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_table_make(size : Int) -> GeodisteuclideanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanTable::len(self : GeodisteuclideanTable) -> Int { self.size }

pub fn GeodisteuclideanTable::get(self : GeodisteuclideanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanTable::set(self : GeodisteuclideanTable, i : Int, v : Double) -> GeodisteuclideanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanTable::sum(self : GeodisteuclideanTable) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanTable::mean(self : GeodisteuclideanTable) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanTable::scale(self : GeodisteuclideanTable, f : Double) -> GeodisteuclideanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanTable::add(self : GeodisteuclideanTable, other : GeodisteuclideanTable) -> GeodisteuclideanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanTable::copy(self : GeodisteuclideanTable) -> GeodisteuclideanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanTable::fill(self : GeodisteuclideanTable, v : Double) -> GeodisteuclideanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanTable::min(self : GeodisteuclideanTable) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanTable::max(self : GeodisteuclideanTable) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanTable::to_string(self : GeodisteuclideanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_graphn_make(size : Int) -> GeodisteuclideanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanGraphN::len(self : GeodisteuclideanGraphN) -> Int { self.size }

pub fn GeodisteuclideanGraphN::get(self : GeodisteuclideanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanGraphN::set(self : GeodisteuclideanGraphN, i : Int, v : Double) -> GeodisteuclideanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanGraphN::sum(self : GeodisteuclideanGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanGraphN::mean(self : GeodisteuclideanGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanGraphN::scale(self : GeodisteuclideanGraphN, f : Double) -> GeodisteuclideanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanGraphN::add(self : GeodisteuclideanGraphN, other : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanGraphN::copy(self : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanGraphN::fill(self : GeodisteuclideanGraphN, v : Double) -> GeodisteuclideanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanGraphN::min(self : GeodisteuclideanGraphN) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanGraphN::max(self : GeodisteuclideanGraphN) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanGraphN::to_string(self : GeodisteuclideanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_node_make(size : Int) -> GeodisteuclideanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanNode::len(self : GeodisteuclideanNode) -> Int { self.size }

pub fn GeodisteuclideanNode::get(self : GeodisteuclideanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanNode::set(self : GeodisteuclideanNode, i : Int, v : Double) -> GeodisteuclideanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanNode::sum(self : GeodisteuclideanNode) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanNode::mean(self : GeodisteuclideanNode) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanNode::scale(self : GeodisteuclideanNode, f : Double) -> GeodisteuclideanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanNode::add(self : GeodisteuclideanNode, other : GeodisteuclideanNode) -> GeodisteuclideanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanNode::copy(self : GeodisteuclideanNode) -> GeodisteuclideanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanNode::fill(self : GeodisteuclideanNode, v : Double) -> GeodisteuclideanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanNode::min(self : GeodisteuclideanNode) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanNode::max(self : GeodisteuclideanNode) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanNode::to_string(self : GeodisteuclideanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_edge_make(size : Int) -> GeodisteuclideanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanEdge::len(self : GeodisteuclideanEdge) -> Int { self.size }

pub fn GeodisteuclideanEdge::get(self : GeodisteuclideanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanEdge::set(self : GeodisteuclideanEdge, i : Int, v : Double) -> GeodisteuclideanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanEdge::sum(self : GeodisteuclideanEdge) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanEdge::mean(self : GeodisteuclideanEdge) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanEdge::scale(self : GeodisteuclideanEdge, f : Double) -> GeodisteuclideanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanEdge::add(self : GeodisteuclideanEdge, other : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanEdge::copy(self : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanEdge::fill(self : GeodisteuclideanEdge, v : Double) -> GeodisteuclideanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanEdge::min(self : GeodisteuclideanEdge) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanEdge::max(self : GeodisteuclideanEdge) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanEdge::to_string(self : GeodisteuclideanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_path_make(size : Int) -> GeodisteuclideanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanPath::len(self : GeodisteuclideanPath) -> Int { self.size }

pub fn GeodisteuclideanPath::get(self : GeodisteuclideanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanPath::set(self : GeodisteuclideanPath, i : Int, v : Double) -> GeodisteuclideanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanPath::sum(self : GeodisteuclideanPath) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanPath::mean(self : GeodisteuclideanPath) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanPath::scale(self : GeodisteuclideanPath, f : Double) -> GeodisteuclideanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanPath::add(self : GeodisteuclideanPath, other : GeodisteuclideanPath) -> GeodisteuclideanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanPath::copy(self : GeodisteuclideanPath) -> GeodisteuclideanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanPath::fill(self : GeodisteuclideanPath, v : Double) -> GeodisteuclideanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanPath::min(self : GeodisteuclideanPath) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanPath::max(self : GeodisteuclideanPath) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanPath::to_string(self : GeodisteuclideanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cluster_make(size : Int) -> GeodisteuclideanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanCluster::len(self : GeodisteuclideanCluster) -> Int { self.size }

pub fn GeodisteuclideanCluster::get(self : GeodisteuclideanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanCluster::set(self : GeodisteuclideanCluster, i : Int, v : Double) -> GeodisteuclideanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCluster::sum(self : GeodisteuclideanCluster) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanCluster::mean(self : GeodisteuclideanCluster) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanCluster::scale(self : GeodisteuclideanCluster, f : Double) -> GeodisteuclideanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCluster::add(self : GeodisteuclideanCluster, other : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanCluster::copy(self : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCluster::fill(self : GeodisteuclideanCluster, v : Double) -> GeodisteuclideanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCluster::min(self : GeodisteuclideanCluster) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanCluster::max(self : GeodisteuclideanCluster) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanCluster::to_string(self : GeodisteuclideanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_model_make(size : Int) -> GeodisteuclideanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanModel::len(self : GeodisteuclideanModel) -> Int { self.size }

pub fn GeodisteuclideanModel::get(self : GeodisteuclideanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanModel::set(self : GeodisteuclideanModel, i : Int, v : Double) -> GeodisteuclideanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanModel::sum(self : GeodisteuclideanModel) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanModel::mean(self : GeodisteuclideanModel) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanModel::scale(self : GeodisteuclideanModel, f : Double) -> GeodisteuclideanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanModel::add(self : GeodisteuclideanModel, other : GeodisteuclideanModel) -> GeodisteuclideanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanModel::copy(self : GeodisteuclideanModel) -> GeodisteuclideanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanModel::fill(self : GeodisteuclideanModel, v : Double) -> GeodisteuclideanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanModel::min(self : GeodisteuclideanModel) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanModel::max(self : GeodisteuclideanModel) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanModel::to_string(self : GeodisteuclideanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_layer_make(size : Int) -> GeodisteuclideanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanLayer::len(self : GeodisteuclideanLayer) -> Int { self.size }

pub fn GeodisteuclideanLayer::get(self : GeodisteuclideanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanLayer::set(self : GeodisteuclideanLayer, i : Int, v : Double) -> GeodisteuclideanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanLayer::sum(self : GeodisteuclideanLayer) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanLayer::mean(self : GeodisteuclideanLayer) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanLayer::scale(self : GeodisteuclideanLayer, f : Double) -> GeodisteuclideanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanLayer::add(self : GeodisteuclideanLayer, other : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanLayer::copy(self : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanLayer::fill(self : GeodisteuclideanLayer, v : Double) -> GeodisteuclideanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanLayer::min(self : GeodisteuclideanLayer) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanLayer::max(self : GeodisteuclideanLayer) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanLayer::to_string(self : GeodisteuclideanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_buffer_make(size : Int) -> GeodisteuclideanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanBuffer::len(self : GeodisteuclideanBuffer) -> Int { self.size }

pub fn GeodisteuclideanBuffer::get(self : GeodisteuclideanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanBuffer::set(self : GeodisteuclideanBuffer, i : Int, v : Double) -> GeodisteuclideanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanBuffer::sum(self : GeodisteuclideanBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanBuffer::mean(self : GeodisteuclideanBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanBuffer::scale(self : GeodisteuclideanBuffer, f : Double) -> GeodisteuclideanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanBuffer::add(self : GeodisteuclideanBuffer, other : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanBuffer::copy(self : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanBuffer::fill(self : GeodisteuclideanBuffer, v : Double) -> GeodisteuclideanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanBuffer::min(self : GeodisteuclideanBuffer) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanBuffer::max(self : GeodisteuclideanBuffer) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanBuffer::to_string(self : GeodisteuclideanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cursor_make(size : Int) -> GeodisteuclideanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanCursor::len(self : GeodisteuclideanCursor) -> Int { self.size }

pub fn GeodisteuclideanCursor::get(self : GeodisteuclideanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanCursor::set(self : GeodisteuclideanCursor, i : Int, v : Double) -> GeodisteuclideanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCursor::sum(self : GeodisteuclideanCursor) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanCursor::mean(self : GeodisteuclideanCursor) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanCursor::scale(self : GeodisteuclideanCursor, f : Double) -> GeodisteuclideanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCursor::add(self : GeodisteuclideanCursor, other : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanCursor::copy(self : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCursor::fill(self : GeodisteuclideanCursor, v : Double) -> GeodisteuclideanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanCursor::min(self : GeodisteuclideanCursor) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanCursor::max(self : GeodisteuclideanCursor) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanCursor::to_string(self : GeodisteuclideanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_view_make(size : Int) -> GeodisteuclideanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanView::len(self : GeodisteuclideanView) -> Int { self.size }

pub fn GeodisteuclideanView::get(self : GeodisteuclideanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanView::set(self : GeodisteuclideanView, i : Int, v : Double) -> GeodisteuclideanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanView::sum(self : GeodisteuclideanView) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanView::mean(self : GeodisteuclideanView) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanView::scale(self : GeodisteuclideanView, f : Double) -> GeodisteuclideanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanView::add(self : GeodisteuclideanView, other : GeodisteuclideanView) -> GeodisteuclideanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanView::copy(self : GeodisteuclideanView) -> GeodisteuclideanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanView::fill(self : GeodisteuclideanView, v : Double) -> GeodisteuclideanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanView::min(self : GeodisteuclideanView) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanView::max(self : GeodisteuclideanView) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanView::to_string(self : GeodisteuclideanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_range_make(size : Int) -> GeodisteuclideanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanRange::len(self : GeodisteuclideanRange) -> Int { self.size }

pub fn GeodisteuclideanRange::get(self : GeodisteuclideanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanRange::set(self : GeodisteuclideanRange, i : Int, v : Double) -> GeodisteuclideanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanRange::sum(self : GeodisteuclideanRange) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanRange::mean(self : GeodisteuclideanRange) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanRange::scale(self : GeodisteuclideanRange, f : Double) -> GeodisteuclideanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanRange::add(self : GeodisteuclideanRange, other : GeodisteuclideanRange) -> GeodisteuclideanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanRange::copy(self : GeodisteuclideanRange) -> GeodisteuclideanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanRange::fill(self : GeodisteuclideanRange, v : Double) -> GeodisteuclideanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanRange::min(self : GeodisteuclideanRange) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanRange::max(self : GeodisteuclideanRange) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanRange::to_string(self : GeodisteuclideanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_slice_make(size : Int) -> GeodisteuclideanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodisteuclideanSlice::len(self : GeodisteuclideanSlice) -> Int { self.size }

pub fn GeodisteuclideanSlice::get(self : GeodisteuclideanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodisteuclideanSlice::set(self : GeodisteuclideanSlice, i : Int, v : Double) -> GeodisteuclideanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanSlice::sum(self : GeodisteuclideanSlice) -> Double { @_common.sum(self.data) }

pub fn GeodisteuclideanSlice::mean(self : GeodisteuclideanSlice) -> Double { @_common.mean(self.data) }

pub fn GeodisteuclideanSlice::scale(self : GeodisteuclideanSlice, f : Double) -> GeodisteuclideanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanSlice::add(self : GeodisteuclideanSlice, other : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodisteuclideanSlice::copy(self : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanSlice::fill(self : GeodisteuclideanSlice, v : Double) -> GeodisteuclideanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodisteuclideanSlice::min(self : GeodisteuclideanSlice) -> Double { @_common.min(self.data) }

pub fn GeodisteuclideanSlice::max(self : GeodisteuclideanSlice) -> Double { @_common.max(self.data) }

pub fn GeodisteuclideanSlice::to_string(self : GeodisteuclideanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

