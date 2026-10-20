///===
/// extcore/image_filter_bilateral

pub(all) struct ImagefilterbilateralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_bilateral_make_point(x : Double, y : Double) -> ImagefilterbilateralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_bilateral_make_point3(x : Double, y : Double, z : Double) -> ImagefilterbilateralPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefilterbilateralPoint::x(self : ImagefilterbilateralPoint) -> Double { self.x }

pub fn ImagefilterbilateralPoint::y(self : ImagefilterbilateralPoint) -> Double { self.y }

pub fn ImagefilterbilateralPoint::z(self : ImagefilterbilateralPoint) -> Double { self.z }

pub fn ImagefilterbilateralPoint::label(self : ImagefilterbilateralPoint) -> Int { self.label }

pub fn ImagefilterbilateralPoint::dist(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefilterbilateralPoint::add(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefilterbilateralPoint::sub(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefilterbilateralPoint::scale(self : ImagefilterbilateralPoint, s : Double) -> ImagefilterbilateralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefilterbilateralPoint::dot(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefilterbilateralPoint::cross(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefilterbilateralPoint::norm(self : ImagefilterbilateralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefilterbilateralPoint::normalize(self : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterbilateralPoint::negate(self : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefilterbilateralPoint::mid(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefilterbilateralPoint::lerp(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint, t : Double) -> ImagefilterbilateralPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefilterbilateralPoint::to_string(self : ImagefilterbilateralPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefilterbilateralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_bilateral_make_series(vals : Array[Double], name : String) -> ImagefilterbilateralSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefilterbilateralSeries::len(self : ImagefilterbilateralSeries) -> Int { self.vals.length() }

pub fn ImagefilterbilateralSeries::sum(self : ImagefilterbilateralSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefilterbilateralSeries::mean(self : ImagefilterbilateralSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefilterbilateralSeries::min(self : ImagefilterbilateralSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefilterbilateralSeries::max(self : ImagefilterbilateralSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefilterbilateralSeries::range(self : ImagefilterbilateralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefilterbilateralSeries::variance(self : ImagefilterbilateralSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefilterbilateralSeries::std(self : ImagefilterbilateralSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefilterbilateralSeries::median(self : ImagefilterbilateralSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefilterbilateralSeries::scale(self : ImagefilterbilateralSeries, f : Double) -> ImagefilterbilateralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefilterbilateralSeries::add(self : ImagefilterbilateralSeries, other : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefilterbilateralSeries::sub(self : ImagefilterbilateralSeries, other : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefilterbilateralSeries::normalize(self : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefilterbilateralSeries::cumsum(self : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefilterbilateralSeries::to_string(self : ImagefilterbilateralSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterbilateralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_bilateral_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterbilateralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_bilateral_matrix_identity(n : Int) -> ImagefilterbilateralMatrix {
  let m = image_filter_bilateral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefilterbilateralMatrix::get(self : ImagefilterbilateralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefilterbilateralMatrix::transpose(self : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  let result = image_filter_bilateral_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefilterbilateralMatrix::add(self : ImagefilterbilateralMatrix, other : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_bilateral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefilterbilateralMatrix::scale(self : ImagefilterbilateralMatrix, s : Double) -> ImagefilterbilateralMatrix {
  let result = image_filter_bilateral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefilterbilateralMatrix::multiply(self : ImagefilterbilateralMatrix, other : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  if self.cols != other.rows { return image_filter_bilateral_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_bilateral_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefilterbilateralMatrix::trace(self : ImagefilterbilateralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefilterbilateralMatrix::det(self : ImagefilterbilateralMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefilterbilateralMatrix::norm(self : ImagefilterbilateralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefilterbilateralMatrix::to_string(self : ImagefilterbilateralMatrix) -> String {
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

pub(all) struct ImagefilterbilateralVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_bilateral_make_vector(comps : Array[Double]) -> ImagefilterbilateralVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_bilateral_vector_zero(dim : Int) -> ImagefilterbilateralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefilterbilateralVector::add(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterbilateralVector::sub(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterbilateralVector::scale(self : ImagefilterbilateralVector, s : Double) -> ImagefilterbilateralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefilterbilateralVector::dot(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefilterbilateralVector::norm(self : ImagefilterbilateralVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefilterbilateralVector::normalize(self : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterbilateralVector::dist(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefilterbilateralVector::to_string(self : ImagefilterbilateralVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_bilateral_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_bilateral_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_bilateral_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_bilateral_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_bilateral_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_bilateral_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_bilateral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_bilateral_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_bilateral_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_bilateral_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_bilateral_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_bilateral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_bilateral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_bilateral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_bilateral_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_bilateral_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_bilateral_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_bilateral_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_bilateral_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_bilateral_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_bilateral_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_bilateral_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_bilateral_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_bilateral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_bilateral_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_bilateral_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_bilateral_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_bilateral_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_bilateral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefilterbilateralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_frame_make(size : Int) -> ImagefilterbilateralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_frame_len(s : ImagefilterbilateralFrame) -> Int { s.size }

pub fn image_filter_bilateral_frame_get(s : ImagefilterbilateralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_frame_set(s : ImagefilterbilateralFrame, i : Int, v : Double) -> ImagefilterbilateralFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_sum(s : ImagefilterbilateralFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_frame_mean(s : ImagefilterbilateralFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_frame_scale(s : ImagefilterbilateralFrame, f : Double) -> ImagefilterbilateralFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_add(a : ImagefilterbilateralFrame, b : ImagefilterbilateralFrame) -> ImagefilterbilateralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_frame_copy(s : ImagefilterbilateralFrame) -> ImagefilterbilateralFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_fill(s : ImagefilterbilateralFrame, v : Double) -> ImagefilterbilateralFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_min(s : ImagefilterbilateralFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_frame_max(s : ImagefilterbilateralFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_frame_to_string(s : ImagefilterbilateralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_table_make(size : Int) -> ImagefilterbilateralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_table_len(s : ImagefilterbilateralTable) -> Int { s.size }

pub fn image_filter_bilateral_table_get(s : ImagefilterbilateralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_table_set(s : ImagefilterbilateralTable, i : Int, v : Double) -> ImagefilterbilateralTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_sum(s : ImagefilterbilateralTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_table_mean(s : ImagefilterbilateralTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_table_scale(s : ImagefilterbilateralTable, f : Double) -> ImagefilterbilateralTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_add(a : ImagefilterbilateralTable, b : ImagefilterbilateralTable) -> ImagefilterbilateralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_table_copy(s : ImagefilterbilateralTable) -> ImagefilterbilateralTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_fill(s : ImagefilterbilateralTable, v : Double) -> ImagefilterbilateralTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_min(s : ImagefilterbilateralTable) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_table_max(s : ImagefilterbilateralTable) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_table_to_string(s : ImagefilterbilateralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_graphn_make(size : Int) -> ImagefilterbilateralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_graphn_len(s : ImagefilterbilateralGraphN) -> Int { s.size }

pub fn image_filter_bilateral_graphn_get(s : ImagefilterbilateralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_graphn_set(s : ImagefilterbilateralGraphN, i : Int, v : Double) -> ImagefilterbilateralGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_sum(s : ImagefilterbilateralGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_graphn_mean(s : ImagefilterbilateralGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_graphn_scale(s : ImagefilterbilateralGraphN, f : Double) -> ImagefilterbilateralGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_add(a : ImagefilterbilateralGraphN, b : ImagefilterbilateralGraphN) -> ImagefilterbilateralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_graphn_copy(s : ImagefilterbilateralGraphN) -> ImagefilterbilateralGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_fill(s : ImagefilterbilateralGraphN, v : Double) -> ImagefilterbilateralGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_min(s : ImagefilterbilateralGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_graphn_max(s : ImagefilterbilateralGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_graphn_to_string(s : ImagefilterbilateralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_node_make(size : Int) -> ImagefilterbilateralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_node_len(s : ImagefilterbilateralNode) -> Int { s.size }

pub fn image_filter_bilateral_node_get(s : ImagefilterbilateralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_node_set(s : ImagefilterbilateralNode, i : Int, v : Double) -> ImagefilterbilateralNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_sum(s : ImagefilterbilateralNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_node_mean(s : ImagefilterbilateralNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_node_scale(s : ImagefilterbilateralNode, f : Double) -> ImagefilterbilateralNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_add(a : ImagefilterbilateralNode, b : ImagefilterbilateralNode) -> ImagefilterbilateralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_node_copy(s : ImagefilterbilateralNode) -> ImagefilterbilateralNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_fill(s : ImagefilterbilateralNode, v : Double) -> ImagefilterbilateralNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_min(s : ImagefilterbilateralNode) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_node_max(s : ImagefilterbilateralNode) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_node_to_string(s : ImagefilterbilateralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_edge_make(size : Int) -> ImagefilterbilateralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_edge_len(s : ImagefilterbilateralEdge) -> Int { s.size }

pub fn image_filter_bilateral_edge_get(s : ImagefilterbilateralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_edge_set(s : ImagefilterbilateralEdge, i : Int, v : Double) -> ImagefilterbilateralEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_sum(s : ImagefilterbilateralEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_edge_mean(s : ImagefilterbilateralEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_edge_scale(s : ImagefilterbilateralEdge, f : Double) -> ImagefilterbilateralEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_add(a : ImagefilterbilateralEdge, b : ImagefilterbilateralEdge) -> ImagefilterbilateralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_edge_copy(s : ImagefilterbilateralEdge) -> ImagefilterbilateralEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_fill(s : ImagefilterbilateralEdge, v : Double) -> ImagefilterbilateralEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_min(s : ImagefilterbilateralEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_edge_max(s : ImagefilterbilateralEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_edge_to_string(s : ImagefilterbilateralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_path_make(size : Int) -> ImagefilterbilateralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_path_len(s : ImagefilterbilateralPath) -> Int { s.size }

pub fn image_filter_bilateral_path_get(s : ImagefilterbilateralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_path_set(s : ImagefilterbilateralPath, i : Int, v : Double) -> ImagefilterbilateralPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_sum(s : ImagefilterbilateralPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_path_mean(s : ImagefilterbilateralPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_path_scale(s : ImagefilterbilateralPath, f : Double) -> ImagefilterbilateralPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_add(a : ImagefilterbilateralPath, b : ImagefilterbilateralPath) -> ImagefilterbilateralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_path_copy(s : ImagefilterbilateralPath) -> ImagefilterbilateralPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_fill(s : ImagefilterbilateralPath, v : Double) -> ImagefilterbilateralPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_min(s : ImagefilterbilateralPath) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_path_max(s : ImagefilterbilateralPath) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_path_to_string(s : ImagefilterbilateralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_cluster_make(size : Int) -> ImagefilterbilateralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_cluster_len(s : ImagefilterbilateralCluster) -> Int { s.size }

pub fn image_filter_bilateral_cluster_get(s : ImagefilterbilateralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_cluster_set(s : ImagefilterbilateralCluster, i : Int, v : Double) -> ImagefilterbilateralCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_sum(s : ImagefilterbilateralCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_cluster_mean(s : ImagefilterbilateralCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_cluster_scale(s : ImagefilterbilateralCluster, f : Double) -> ImagefilterbilateralCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_add(a : ImagefilterbilateralCluster, b : ImagefilterbilateralCluster) -> ImagefilterbilateralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_cluster_copy(s : ImagefilterbilateralCluster) -> ImagefilterbilateralCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_fill(s : ImagefilterbilateralCluster, v : Double) -> ImagefilterbilateralCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_min(s : ImagefilterbilateralCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_cluster_max(s : ImagefilterbilateralCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_cluster_to_string(s : ImagefilterbilateralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_model_make(size : Int) -> ImagefilterbilateralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_model_len(s : ImagefilterbilateralModel) -> Int { s.size }

pub fn image_filter_bilateral_model_get(s : ImagefilterbilateralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_model_set(s : ImagefilterbilateralModel, i : Int, v : Double) -> ImagefilterbilateralModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_sum(s : ImagefilterbilateralModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_model_mean(s : ImagefilterbilateralModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_model_scale(s : ImagefilterbilateralModel, f : Double) -> ImagefilterbilateralModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_add(a : ImagefilterbilateralModel, b : ImagefilterbilateralModel) -> ImagefilterbilateralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_model_copy(s : ImagefilterbilateralModel) -> ImagefilterbilateralModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_fill(s : ImagefilterbilateralModel, v : Double) -> ImagefilterbilateralModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_min(s : ImagefilterbilateralModel) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_model_max(s : ImagefilterbilateralModel) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_model_to_string(s : ImagefilterbilateralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_layer_make(size : Int) -> ImagefilterbilateralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_layer_len(s : ImagefilterbilateralLayer) -> Int { s.size }

pub fn image_filter_bilateral_layer_get(s : ImagefilterbilateralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_layer_set(s : ImagefilterbilateralLayer, i : Int, v : Double) -> ImagefilterbilateralLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_sum(s : ImagefilterbilateralLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_layer_mean(s : ImagefilterbilateralLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_layer_scale(s : ImagefilterbilateralLayer, f : Double) -> ImagefilterbilateralLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_add(a : ImagefilterbilateralLayer, b : ImagefilterbilateralLayer) -> ImagefilterbilateralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_layer_copy(s : ImagefilterbilateralLayer) -> ImagefilterbilateralLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_fill(s : ImagefilterbilateralLayer, v : Double) -> ImagefilterbilateralLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_min(s : ImagefilterbilateralLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_layer_max(s : ImagefilterbilateralLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_layer_to_string(s : ImagefilterbilateralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_buffer_make(size : Int) -> ImagefilterbilateralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_buffer_len(s : ImagefilterbilateralBuffer) -> Int { s.size }

pub fn image_filter_bilateral_buffer_get(s : ImagefilterbilateralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_buffer_set(s : ImagefilterbilateralBuffer, i : Int, v : Double) -> ImagefilterbilateralBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_sum(s : ImagefilterbilateralBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_buffer_mean(s : ImagefilterbilateralBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_buffer_scale(s : ImagefilterbilateralBuffer, f : Double) -> ImagefilterbilateralBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_add(a : ImagefilterbilateralBuffer, b : ImagefilterbilateralBuffer) -> ImagefilterbilateralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_buffer_copy(s : ImagefilterbilateralBuffer) -> ImagefilterbilateralBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_fill(s : ImagefilterbilateralBuffer, v : Double) -> ImagefilterbilateralBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_min(s : ImagefilterbilateralBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_buffer_max(s : ImagefilterbilateralBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_buffer_to_string(s : ImagefilterbilateralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_cursor_make(size : Int) -> ImagefilterbilateralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_cursor_len(s : ImagefilterbilateralCursor) -> Int { s.size }

pub fn image_filter_bilateral_cursor_get(s : ImagefilterbilateralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_cursor_set(s : ImagefilterbilateralCursor, i : Int, v : Double) -> ImagefilterbilateralCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_sum(s : ImagefilterbilateralCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_cursor_mean(s : ImagefilterbilateralCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_cursor_scale(s : ImagefilterbilateralCursor, f : Double) -> ImagefilterbilateralCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_add(a : ImagefilterbilateralCursor, b : ImagefilterbilateralCursor) -> ImagefilterbilateralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_cursor_copy(s : ImagefilterbilateralCursor) -> ImagefilterbilateralCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_fill(s : ImagefilterbilateralCursor, v : Double) -> ImagefilterbilateralCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_min(s : ImagefilterbilateralCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_cursor_max(s : ImagefilterbilateralCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_cursor_to_string(s : ImagefilterbilateralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_view_make(size : Int) -> ImagefilterbilateralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_view_len(s : ImagefilterbilateralView) -> Int { s.size }

pub fn image_filter_bilateral_view_get(s : ImagefilterbilateralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_view_set(s : ImagefilterbilateralView, i : Int, v : Double) -> ImagefilterbilateralView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_sum(s : ImagefilterbilateralView) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_view_mean(s : ImagefilterbilateralView) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_view_scale(s : ImagefilterbilateralView, f : Double) -> ImagefilterbilateralView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_add(a : ImagefilterbilateralView, b : ImagefilterbilateralView) -> ImagefilterbilateralView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_view_copy(s : ImagefilterbilateralView) -> ImagefilterbilateralView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_fill(s : ImagefilterbilateralView, v : Double) -> ImagefilterbilateralView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_min(s : ImagefilterbilateralView) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_view_max(s : ImagefilterbilateralView) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_view_to_string(s : ImagefilterbilateralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_range_make(size : Int) -> ImagefilterbilateralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_range_len(s : ImagefilterbilateralRange) -> Int { s.size }

pub fn image_filter_bilateral_range_get(s : ImagefilterbilateralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_range_set(s : ImagefilterbilateralRange, i : Int, v : Double) -> ImagefilterbilateralRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_sum(s : ImagefilterbilateralRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_range_mean(s : ImagefilterbilateralRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_range_scale(s : ImagefilterbilateralRange, f : Double) -> ImagefilterbilateralRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_add(a : ImagefilterbilateralRange, b : ImagefilterbilateralRange) -> ImagefilterbilateralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_range_copy(s : ImagefilterbilateralRange) -> ImagefilterbilateralRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_fill(s : ImagefilterbilateralRange, v : Double) -> ImagefilterbilateralRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_min(s : ImagefilterbilateralRange) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_range_max(s : ImagefilterbilateralRange) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_range_to_string(s : ImagefilterbilateralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_slice_make(size : Int) -> ImagefilterbilateralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_slice_len(s : ImagefilterbilateralSlice) -> Int { s.size }

pub fn image_filter_bilateral_slice_get(s : ImagefilterbilateralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_slice_set(s : ImagefilterbilateralSlice, i : Int, v : Double) -> ImagefilterbilateralSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_sum(s : ImagefilterbilateralSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_slice_mean(s : ImagefilterbilateralSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_slice_scale(s : ImagefilterbilateralSlice, f : Double) -> ImagefilterbilateralSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_add(a : ImagefilterbilateralSlice, b : ImagefilterbilateralSlice) -> ImagefilterbilateralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_slice_copy(s : ImagefilterbilateralSlice) -> ImagefilterbilateralSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_fill(s : ImagefilterbilateralSlice, v : Double) -> ImagefilterbilateralSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_min(s : ImagefilterbilateralSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_slice_max(s : ImagefilterbilateralSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_slice_to_string(s : ImagefilterbilateralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

