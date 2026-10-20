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

pub fn geo_dist_euclidean_frame_len(s : GeodisteuclideanFrame) -> Int { s.size }

pub fn geo_dist_euclidean_frame_get(s : GeodisteuclideanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_frame_set(s : GeodisteuclideanFrame, i : Int, v : Double) -> GeodisteuclideanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_sum(s : GeodisteuclideanFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_frame_mean(s : GeodisteuclideanFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_frame_scale(s : GeodisteuclideanFrame, f : Double) -> GeodisteuclideanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_add(a : GeodisteuclideanFrame, b : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_frame_copy(s : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_fill(s : GeodisteuclideanFrame, v : Double) -> GeodisteuclideanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_min(s : GeodisteuclideanFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_frame_max(s : GeodisteuclideanFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_frame_to_string(s : GeodisteuclideanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_table_make(size : Int) -> GeodisteuclideanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_table_len(s : GeodisteuclideanTable) -> Int { s.size }

pub fn geo_dist_euclidean_table_get(s : GeodisteuclideanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_table_set(s : GeodisteuclideanTable, i : Int, v : Double) -> GeodisteuclideanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_sum(s : GeodisteuclideanTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_table_mean(s : GeodisteuclideanTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_table_scale(s : GeodisteuclideanTable, f : Double) -> GeodisteuclideanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_add(a : GeodisteuclideanTable, b : GeodisteuclideanTable) -> GeodisteuclideanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_table_copy(s : GeodisteuclideanTable) -> GeodisteuclideanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_fill(s : GeodisteuclideanTable, v : Double) -> GeodisteuclideanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_min(s : GeodisteuclideanTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_table_max(s : GeodisteuclideanTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_table_to_string(s : GeodisteuclideanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_graphn_make(size : Int) -> GeodisteuclideanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_graphn_len(s : GeodisteuclideanGraphN) -> Int { s.size }

pub fn geo_dist_euclidean_graphn_get(s : GeodisteuclideanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_graphn_set(s : GeodisteuclideanGraphN, i : Int, v : Double) -> GeodisteuclideanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_sum(s : GeodisteuclideanGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_graphn_mean(s : GeodisteuclideanGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_graphn_scale(s : GeodisteuclideanGraphN, f : Double) -> GeodisteuclideanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_add(a : GeodisteuclideanGraphN, b : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_graphn_copy(s : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_fill(s : GeodisteuclideanGraphN, v : Double) -> GeodisteuclideanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_min(s : GeodisteuclideanGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_graphn_max(s : GeodisteuclideanGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_graphn_to_string(s : GeodisteuclideanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_node_make(size : Int) -> GeodisteuclideanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_node_len(s : GeodisteuclideanNode) -> Int { s.size }

pub fn geo_dist_euclidean_node_get(s : GeodisteuclideanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_node_set(s : GeodisteuclideanNode, i : Int, v : Double) -> GeodisteuclideanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_sum(s : GeodisteuclideanNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_node_mean(s : GeodisteuclideanNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_node_scale(s : GeodisteuclideanNode, f : Double) -> GeodisteuclideanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_add(a : GeodisteuclideanNode, b : GeodisteuclideanNode) -> GeodisteuclideanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_node_copy(s : GeodisteuclideanNode) -> GeodisteuclideanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_fill(s : GeodisteuclideanNode, v : Double) -> GeodisteuclideanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_min(s : GeodisteuclideanNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_node_max(s : GeodisteuclideanNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_node_to_string(s : GeodisteuclideanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_edge_make(size : Int) -> GeodisteuclideanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_edge_len(s : GeodisteuclideanEdge) -> Int { s.size }

pub fn geo_dist_euclidean_edge_get(s : GeodisteuclideanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_edge_set(s : GeodisteuclideanEdge, i : Int, v : Double) -> GeodisteuclideanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_sum(s : GeodisteuclideanEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_edge_mean(s : GeodisteuclideanEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_edge_scale(s : GeodisteuclideanEdge, f : Double) -> GeodisteuclideanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_add(a : GeodisteuclideanEdge, b : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_edge_copy(s : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_fill(s : GeodisteuclideanEdge, v : Double) -> GeodisteuclideanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_min(s : GeodisteuclideanEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_edge_max(s : GeodisteuclideanEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_edge_to_string(s : GeodisteuclideanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_path_make(size : Int) -> GeodisteuclideanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_path_len(s : GeodisteuclideanPath) -> Int { s.size }

pub fn geo_dist_euclidean_path_get(s : GeodisteuclideanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_path_set(s : GeodisteuclideanPath, i : Int, v : Double) -> GeodisteuclideanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_sum(s : GeodisteuclideanPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_path_mean(s : GeodisteuclideanPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_path_scale(s : GeodisteuclideanPath, f : Double) -> GeodisteuclideanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_add(a : GeodisteuclideanPath, b : GeodisteuclideanPath) -> GeodisteuclideanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_path_copy(s : GeodisteuclideanPath) -> GeodisteuclideanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_fill(s : GeodisteuclideanPath, v : Double) -> GeodisteuclideanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_min(s : GeodisteuclideanPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_path_max(s : GeodisteuclideanPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_path_to_string(s : GeodisteuclideanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cluster_make(size : Int) -> GeodisteuclideanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_cluster_len(s : GeodisteuclideanCluster) -> Int { s.size }

pub fn geo_dist_euclidean_cluster_get(s : GeodisteuclideanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_cluster_set(s : GeodisteuclideanCluster, i : Int, v : Double) -> GeodisteuclideanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_sum(s : GeodisteuclideanCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_cluster_mean(s : GeodisteuclideanCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_cluster_scale(s : GeodisteuclideanCluster, f : Double) -> GeodisteuclideanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_add(a : GeodisteuclideanCluster, b : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_cluster_copy(s : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_fill(s : GeodisteuclideanCluster, v : Double) -> GeodisteuclideanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_min(s : GeodisteuclideanCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_cluster_max(s : GeodisteuclideanCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_cluster_to_string(s : GeodisteuclideanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_model_make(size : Int) -> GeodisteuclideanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_model_len(s : GeodisteuclideanModel) -> Int { s.size }

pub fn geo_dist_euclidean_model_get(s : GeodisteuclideanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_model_set(s : GeodisteuclideanModel, i : Int, v : Double) -> GeodisteuclideanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_sum(s : GeodisteuclideanModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_model_mean(s : GeodisteuclideanModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_model_scale(s : GeodisteuclideanModel, f : Double) -> GeodisteuclideanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_add(a : GeodisteuclideanModel, b : GeodisteuclideanModel) -> GeodisteuclideanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_model_copy(s : GeodisteuclideanModel) -> GeodisteuclideanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_fill(s : GeodisteuclideanModel, v : Double) -> GeodisteuclideanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_min(s : GeodisteuclideanModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_model_max(s : GeodisteuclideanModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_model_to_string(s : GeodisteuclideanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_layer_make(size : Int) -> GeodisteuclideanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_layer_len(s : GeodisteuclideanLayer) -> Int { s.size }

pub fn geo_dist_euclidean_layer_get(s : GeodisteuclideanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_layer_set(s : GeodisteuclideanLayer, i : Int, v : Double) -> GeodisteuclideanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_sum(s : GeodisteuclideanLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_layer_mean(s : GeodisteuclideanLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_layer_scale(s : GeodisteuclideanLayer, f : Double) -> GeodisteuclideanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_add(a : GeodisteuclideanLayer, b : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_layer_copy(s : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_fill(s : GeodisteuclideanLayer, v : Double) -> GeodisteuclideanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_min(s : GeodisteuclideanLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_layer_max(s : GeodisteuclideanLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_layer_to_string(s : GeodisteuclideanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_buffer_make(size : Int) -> GeodisteuclideanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_buffer_len(s : GeodisteuclideanBuffer) -> Int { s.size }

pub fn geo_dist_euclidean_buffer_get(s : GeodisteuclideanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_buffer_set(s : GeodisteuclideanBuffer, i : Int, v : Double) -> GeodisteuclideanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_sum(s : GeodisteuclideanBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_buffer_mean(s : GeodisteuclideanBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_buffer_scale(s : GeodisteuclideanBuffer, f : Double) -> GeodisteuclideanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_add(a : GeodisteuclideanBuffer, b : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_buffer_copy(s : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_fill(s : GeodisteuclideanBuffer, v : Double) -> GeodisteuclideanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_min(s : GeodisteuclideanBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_buffer_max(s : GeodisteuclideanBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_buffer_to_string(s : GeodisteuclideanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cursor_make(size : Int) -> GeodisteuclideanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_cursor_len(s : GeodisteuclideanCursor) -> Int { s.size }

pub fn geo_dist_euclidean_cursor_get(s : GeodisteuclideanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_cursor_set(s : GeodisteuclideanCursor, i : Int, v : Double) -> GeodisteuclideanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_sum(s : GeodisteuclideanCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_cursor_mean(s : GeodisteuclideanCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_cursor_scale(s : GeodisteuclideanCursor, f : Double) -> GeodisteuclideanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_add(a : GeodisteuclideanCursor, b : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_cursor_copy(s : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_fill(s : GeodisteuclideanCursor, v : Double) -> GeodisteuclideanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_min(s : GeodisteuclideanCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_cursor_max(s : GeodisteuclideanCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_cursor_to_string(s : GeodisteuclideanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_view_make(size : Int) -> GeodisteuclideanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_view_len(s : GeodisteuclideanView) -> Int { s.size }

pub fn geo_dist_euclidean_view_get(s : GeodisteuclideanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_view_set(s : GeodisteuclideanView, i : Int, v : Double) -> GeodisteuclideanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_sum(s : GeodisteuclideanView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_view_mean(s : GeodisteuclideanView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_view_scale(s : GeodisteuclideanView, f : Double) -> GeodisteuclideanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_add(a : GeodisteuclideanView, b : GeodisteuclideanView) -> GeodisteuclideanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_view_copy(s : GeodisteuclideanView) -> GeodisteuclideanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_fill(s : GeodisteuclideanView, v : Double) -> GeodisteuclideanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_min(s : GeodisteuclideanView) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_view_max(s : GeodisteuclideanView) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_view_to_string(s : GeodisteuclideanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_range_make(size : Int) -> GeodisteuclideanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_range_len(s : GeodisteuclideanRange) -> Int { s.size }

pub fn geo_dist_euclidean_range_get(s : GeodisteuclideanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_range_set(s : GeodisteuclideanRange, i : Int, v : Double) -> GeodisteuclideanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_sum(s : GeodisteuclideanRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_range_mean(s : GeodisteuclideanRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_range_scale(s : GeodisteuclideanRange, f : Double) -> GeodisteuclideanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_add(a : GeodisteuclideanRange, b : GeodisteuclideanRange) -> GeodisteuclideanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_range_copy(s : GeodisteuclideanRange) -> GeodisteuclideanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_fill(s : GeodisteuclideanRange, v : Double) -> GeodisteuclideanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_min(s : GeodisteuclideanRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_range_max(s : GeodisteuclideanRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_range_to_string(s : GeodisteuclideanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_slice_make(size : Int) -> GeodisteuclideanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_slice_len(s : GeodisteuclideanSlice) -> Int { s.size }

pub fn geo_dist_euclidean_slice_get(s : GeodisteuclideanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_slice_set(s : GeodisteuclideanSlice, i : Int, v : Double) -> GeodisteuclideanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_sum(s : GeodisteuclideanSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_slice_mean(s : GeodisteuclideanSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_slice_scale(s : GeodisteuclideanSlice, f : Double) -> GeodisteuclideanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_add(a : GeodisteuclideanSlice, b : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_slice_copy(s : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_fill(s : GeodisteuclideanSlice, v : Double) -> GeodisteuclideanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_min(s : GeodisteuclideanSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_slice_max(s : GeodisteuclideanSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_slice_to_string(s : GeodisteuclideanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

