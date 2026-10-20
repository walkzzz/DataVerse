///===
/// extcore/image_transform_perspective

pub(all) struct ImagetransformperspectivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_perspective_make_point(x : Double, y : Double) -> ImagetransformperspectivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_perspective_make_point3(x : Double, y : Double, z : Double) -> ImagetransformperspectivePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformperspectivePoint::x(self : ImagetransformperspectivePoint) -> Double { self.x }

pub fn ImagetransformperspectivePoint::y(self : ImagetransformperspectivePoint) -> Double { self.y }

pub fn ImagetransformperspectivePoint::z(self : ImagetransformperspectivePoint) -> Double { self.z }

pub fn ImagetransformperspectivePoint::label(self : ImagetransformperspectivePoint) -> Int { self.label }

pub fn ImagetransformperspectivePoint::dist(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformperspectivePoint::add(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformperspectivePoint::sub(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformperspectivePoint::scale(self : ImagetransformperspectivePoint, s : Double) -> ImagetransformperspectivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformperspectivePoint::dot(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformperspectivePoint::cross(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformperspectivePoint::norm(self : ImagetransformperspectivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformperspectivePoint::normalize(self : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformperspectivePoint::negate(self : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformperspectivePoint::mid(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformperspectivePoint::lerp(self : ImagetransformperspectivePoint, other : ImagetransformperspectivePoint, t : Double) -> ImagetransformperspectivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformperspectivePoint::to_string(self : ImagetransformperspectivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_perspective_make_series(vals : Array[Double], name : String) -> ImagetransformperspectiveSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformperspectiveSeries::len(self : ImagetransformperspectiveSeries) -> Int { self.vals.length() }

pub fn ImagetransformperspectiveSeries::sum(self : ImagetransformperspectiveSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformperspectiveSeries::mean(self : ImagetransformperspectiveSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformperspectiveSeries::min(self : ImagetransformperspectiveSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformperspectiveSeries::max(self : ImagetransformperspectiveSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformperspectiveSeries::range(self : ImagetransformperspectiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformperspectiveSeries::variance(self : ImagetransformperspectiveSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformperspectiveSeries::std(self : ImagetransformperspectiveSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformperspectiveSeries::median(self : ImagetransformperspectiveSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformperspectiveSeries::scale(self : ImagetransformperspectiveSeries, f : Double) -> ImagetransformperspectiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::add(self : ImagetransformperspectiveSeries, other : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::sub(self : ImagetransformperspectiveSeries, other : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::normalize(self : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformperspectiveSeries::cumsum(self : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformperspectiveSeries::to_string(self : ImagetransformperspectiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformperspectiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_perspective_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformperspectiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_perspective_matrix_identity(n : Int) -> ImagetransformperspectiveMatrix {
  let m = image_transform_perspective_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformperspectiveMatrix::get(self : ImagetransformperspectiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformperspectiveMatrix::transpose(self : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  let result = image_transform_perspective_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformperspectiveMatrix::add(self : ImagetransformperspectiveMatrix, other : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_perspective_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformperspectiveMatrix::scale(self : ImagetransformperspectiveMatrix, s : Double) -> ImagetransformperspectiveMatrix {
  let result = image_transform_perspective_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformperspectiveMatrix::multiply(self : ImagetransformperspectiveMatrix, other : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  if self.cols != other.rows { return image_transform_perspective_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_perspective_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformperspectiveMatrix::trace(self : ImagetransformperspectiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformperspectiveMatrix::det(self : ImagetransformperspectiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformperspectiveMatrix::norm(self : ImagetransformperspectiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformperspectiveMatrix::to_string(self : ImagetransformperspectiveMatrix) -> String {
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

pub(all) struct ImagetransformperspectiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_perspective_make_vector(comps : Array[Double]) -> ImagetransformperspectiveVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_perspective_vector_zero(dim : Int) -> ImagetransformperspectiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformperspectiveVector::add(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformperspectiveVector::sub(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformperspectiveVector::scale(self : ImagetransformperspectiveVector, s : Double) -> ImagetransformperspectiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformperspectiveVector::dot(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformperspectiveVector::norm(self : ImagetransformperspectiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformperspectiveVector::normalize(self : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformperspectiveVector::dist(self : ImagetransformperspectiveVector, other : ImagetransformperspectiveVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformperspectiveVector::to_string(self : ImagetransformperspectiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_perspective_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_perspective_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_perspective_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_perspective_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_perspective_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_perspective_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_perspective_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_perspective_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_perspective_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_perspective_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_perspective_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_perspective_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_perspective_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_perspective_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_perspective_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_perspective_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_perspective_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_perspective_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_perspective_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_perspective_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_perspective_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_perspective_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_perspective_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_perspective_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_perspective_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_perspective_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_perspective_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_perspective_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_perspective_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformperspectiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_frame_make(size : Int) -> ImagetransformperspectiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_frame_len(s : ImagetransformperspectiveFrame) -> Int { s.size }

pub fn image_transform_perspective_frame_get(s : ImagetransformperspectiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_frame_set(s : ImagetransformperspectiveFrame, i : Int, v : Double) -> ImagetransformperspectiveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_frame_sum(s : ImagetransformperspectiveFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_frame_mean(s : ImagetransformperspectiveFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_frame_scale(s : ImagetransformperspectiveFrame, f : Double) -> ImagetransformperspectiveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_frame_add(a : ImagetransformperspectiveFrame, b : ImagetransformperspectiveFrame) -> ImagetransformperspectiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_frame_copy(s : ImagetransformperspectiveFrame) -> ImagetransformperspectiveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_frame_fill(s : ImagetransformperspectiveFrame, v : Double) -> ImagetransformperspectiveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_frame_min(s : ImagetransformperspectiveFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_frame_max(s : ImagetransformperspectiveFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_frame_to_string(s : ImagetransformperspectiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_table_make(size : Int) -> ImagetransformperspectiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_table_len(s : ImagetransformperspectiveTable) -> Int { s.size }

pub fn image_transform_perspective_table_get(s : ImagetransformperspectiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_table_set(s : ImagetransformperspectiveTable, i : Int, v : Double) -> ImagetransformperspectiveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_table_sum(s : ImagetransformperspectiveTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_table_mean(s : ImagetransformperspectiveTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_table_scale(s : ImagetransformperspectiveTable, f : Double) -> ImagetransformperspectiveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_table_add(a : ImagetransformperspectiveTable, b : ImagetransformperspectiveTable) -> ImagetransformperspectiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_table_copy(s : ImagetransformperspectiveTable) -> ImagetransformperspectiveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_table_fill(s : ImagetransformperspectiveTable, v : Double) -> ImagetransformperspectiveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_table_min(s : ImagetransformperspectiveTable) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_table_max(s : ImagetransformperspectiveTable) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_table_to_string(s : ImagetransformperspectiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_graphn_make(size : Int) -> ImagetransformperspectiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_graphn_len(s : ImagetransformperspectiveGraphN) -> Int { s.size }

pub fn image_transform_perspective_graphn_get(s : ImagetransformperspectiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_graphn_set(s : ImagetransformperspectiveGraphN, i : Int, v : Double) -> ImagetransformperspectiveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_graphn_sum(s : ImagetransformperspectiveGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_graphn_mean(s : ImagetransformperspectiveGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_graphn_scale(s : ImagetransformperspectiveGraphN, f : Double) -> ImagetransformperspectiveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_graphn_add(a : ImagetransformperspectiveGraphN, b : ImagetransformperspectiveGraphN) -> ImagetransformperspectiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_graphn_copy(s : ImagetransformperspectiveGraphN) -> ImagetransformperspectiveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_graphn_fill(s : ImagetransformperspectiveGraphN, v : Double) -> ImagetransformperspectiveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_graphn_min(s : ImagetransformperspectiveGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_graphn_max(s : ImagetransformperspectiveGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_graphn_to_string(s : ImagetransformperspectiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_node_make(size : Int) -> ImagetransformperspectiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_node_len(s : ImagetransformperspectiveNode) -> Int { s.size }

pub fn image_transform_perspective_node_get(s : ImagetransformperspectiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_node_set(s : ImagetransformperspectiveNode, i : Int, v : Double) -> ImagetransformperspectiveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_node_sum(s : ImagetransformperspectiveNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_node_mean(s : ImagetransformperspectiveNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_node_scale(s : ImagetransformperspectiveNode, f : Double) -> ImagetransformperspectiveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_node_add(a : ImagetransformperspectiveNode, b : ImagetransformperspectiveNode) -> ImagetransformperspectiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_node_copy(s : ImagetransformperspectiveNode) -> ImagetransformperspectiveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_node_fill(s : ImagetransformperspectiveNode, v : Double) -> ImagetransformperspectiveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_node_min(s : ImagetransformperspectiveNode) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_node_max(s : ImagetransformperspectiveNode) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_node_to_string(s : ImagetransformperspectiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_edge_make(size : Int) -> ImagetransformperspectiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_edge_len(s : ImagetransformperspectiveEdge) -> Int { s.size }

pub fn image_transform_perspective_edge_get(s : ImagetransformperspectiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_edge_set(s : ImagetransformperspectiveEdge, i : Int, v : Double) -> ImagetransformperspectiveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_edge_sum(s : ImagetransformperspectiveEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_edge_mean(s : ImagetransformperspectiveEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_edge_scale(s : ImagetransformperspectiveEdge, f : Double) -> ImagetransformperspectiveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_edge_add(a : ImagetransformperspectiveEdge, b : ImagetransformperspectiveEdge) -> ImagetransformperspectiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_edge_copy(s : ImagetransformperspectiveEdge) -> ImagetransformperspectiveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_edge_fill(s : ImagetransformperspectiveEdge, v : Double) -> ImagetransformperspectiveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_edge_min(s : ImagetransformperspectiveEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_edge_max(s : ImagetransformperspectiveEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_edge_to_string(s : ImagetransformperspectiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_path_make(size : Int) -> ImagetransformperspectivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_path_len(s : ImagetransformperspectivePath) -> Int { s.size }

pub fn image_transform_perspective_path_get(s : ImagetransformperspectivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_path_set(s : ImagetransformperspectivePath, i : Int, v : Double) -> ImagetransformperspectivePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_path_sum(s : ImagetransformperspectivePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_path_mean(s : ImagetransformperspectivePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_path_scale(s : ImagetransformperspectivePath, f : Double) -> ImagetransformperspectivePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_path_add(a : ImagetransformperspectivePath, b : ImagetransformperspectivePath) -> ImagetransformperspectivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_path_copy(s : ImagetransformperspectivePath) -> ImagetransformperspectivePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_path_fill(s : ImagetransformperspectivePath, v : Double) -> ImagetransformperspectivePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_path_min(s : ImagetransformperspectivePath) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_path_max(s : ImagetransformperspectivePath) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_path_to_string(s : ImagetransformperspectivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_cluster_make(size : Int) -> ImagetransformperspectiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_cluster_len(s : ImagetransformperspectiveCluster) -> Int { s.size }

pub fn image_transform_perspective_cluster_get(s : ImagetransformperspectiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_cluster_set(s : ImagetransformperspectiveCluster, i : Int, v : Double) -> ImagetransformperspectiveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cluster_sum(s : ImagetransformperspectiveCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_cluster_mean(s : ImagetransformperspectiveCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_cluster_scale(s : ImagetransformperspectiveCluster, f : Double) -> ImagetransformperspectiveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cluster_add(a : ImagetransformperspectiveCluster, b : ImagetransformperspectiveCluster) -> ImagetransformperspectiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_cluster_copy(s : ImagetransformperspectiveCluster) -> ImagetransformperspectiveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cluster_fill(s : ImagetransformperspectiveCluster, v : Double) -> ImagetransformperspectiveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cluster_min(s : ImagetransformperspectiveCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_cluster_max(s : ImagetransformperspectiveCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_cluster_to_string(s : ImagetransformperspectiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_model_make(size : Int) -> ImagetransformperspectiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_model_len(s : ImagetransformperspectiveModel) -> Int { s.size }

pub fn image_transform_perspective_model_get(s : ImagetransformperspectiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_model_set(s : ImagetransformperspectiveModel, i : Int, v : Double) -> ImagetransformperspectiveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_model_sum(s : ImagetransformperspectiveModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_model_mean(s : ImagetransformperspectiveModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_model_scale(s : ImagetransformperspectiveModel, f : Double) -> ImagetransformperspectiveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_model_add(a : ImagetransformperspectiveModel, b : ImagetransformperspectiveModel) -> ImagetransformperspectiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_model_copy(s : ImagetransformperspectiveModel) -> ImagetransformperspectiveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_model_fill(s : ImagetransformperspectiveModel, v : Double) -> ImagetransformperspectiveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_model_min(s : ImagetransformperspectiveModel) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_model_max(s : ImagetransformperspectiveModel) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_model_to_string(s : ImagetransformperspectiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_layer_make(size : Int) -> ImagetransformperspectiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_layer_len(s : ImagetransformperspectiveLayer) -> Int { s.size }

pub fn image_transform_perspective_layer_get(s : ImagetransformperspectiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_layer_set(s : ImagetransformperspectiveLayer, i : Int, v : Double) -> ImagetransformperspectiveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_layer_sum(s : ImagetransformperspectiveLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_layer_mean(s : ImagetransformperspectiveLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_layer_scale(s : ImagetransformperspectiveLayer, f : Double) -> ImagetransformperspectiveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_layer_add(a : ImagetransformperspectiveLayer, b : ImagetransformperspectiveLayer) -> ImagetransformperspectiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_layer_copy(s : ImagetransformperspectiveLayer) -> ImagetransformperspectiveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_layer_fill(s : ImagetransformperspectiveLayer, v : Double) -> ImagetransformperspectiveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_layer_min(s : ImagetransformperspectiveLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_layer_max(s : ImagetransformperspectiveLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_layer_to_string(s : ImagetransformperspectiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_buffer_make(size : Int) -> ImagetransformperspectiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_buffer_len(s : ImagetransformperspectiveBuffer) -> Int { s.size }

pub fn image_transform_perspective_buffer_get(s : ImagetransformperspectiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_buffer_set(s : ImagetransformperspectiveBuffer, i : Int, v : Double) -> ImagetransformperspectiveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_buffer_sum(s : ImagetransformperspectiveBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_buffer_mean(s : ImagetransformperspectiveBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_buffer_scale(s : ImagetransformperspectiveBuffer, f : Double) -> ImagetransformperspectiveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_buffer_add(a : ImagetransformperspectiveBuffer, b : ImagetransformperspectiveBuffer) -> ImagetransformperspectiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_buffer_copy(s : ImagetransformperspectiveBuffer) -> ImagetransformperspectiveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_buffer_fill(s : ImagetransformperspectiveBuffer, v : Double) -> ImagetransformperspectiveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_buffer_min(s : ImagetransformperspectiveBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_buffer_max(s : ImagetransformperspectiveBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_buffer_to_string(s : ImagetransformperspectiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_cursor_make(size : Int) -> ImagetransformperspectiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_cursor_len(s : ImagetransformperspectiveCursor) -> Int { s.size }

pub fn image_transform_perspective_cursor_get(s : ImagetransformperspectiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_cursor_set(s : ImagetransformperspectiveCursor, i : Int, v : Double) -> ImagetransformperspectiveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cursor_sum(s : ImagetransformperspectiveCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_cursor_mean(s : ImagetransformperspectiveCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_cursor_scale(s : ImagetransformperspectiveCursor, f : Double) -> ImagetransformperspectiveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cursor_add(a : ImagetransformperspectiveCursor, b : ImagetransformperspectiveCursor) -> ImagetransformperspectiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_cursor_copy(s : ImagetransformperspectiveCursor) -> ImagetransformperspectiveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cursor_fill(s : ImagetransformperspectiveCursor, v : Double) -> ImagetransformperspectiveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_cursor_min(s : ImagetransformperspectiveCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_cursor_max(s : ImagetransformperspectiveCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_cursor_to_string(s : ImagetransformperspectiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_view_make(size : Int) -> ImagetransformperspectiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_view_len(s : ImagetransformperspectiveView) -> Int { s.size }

pub fn image_transform_perspective_view_get(s : ImagetransformperspectiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_view_set(s : ImagetransformperspectiveView, i : Int, v : Double) -> ImagetransformperspectiveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_view_sum(s : ImagetransformperspectiveView) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_view_mean(s : ImagetransformperspectiveView) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_view_scale(s : ImagetransformperspectiveView, f : Double) -> ImagetransformperspectiveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_view_add(a : ImagetransformperspectiveView, b : ImagetransformperspectiveView) -> ImagetransformperspectiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_view_copy(s : ImagetransformperspectiveView) -> ImagetransformperspectiveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_view_fill(s : ImagetransformperspectiveView, v : Double) -> ImagetransformperspectiveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_view_min(s : ImagetransformperspectiveView) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_view_max(s : ImagetransformperspectiveView) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_view_to_string(s : ImagetransformperspectiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_range_make(size : Int) -> ImagetransformperspectiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_range_len(s : ImagetransformperspectiveRange) -> Int { s.size }

pub fn image_transform_perspective_range_get(s : ImagetransformperspectiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_range_set(s : ImagetransformperspectiveRange, i : Int, v : Double) -> ImagetransformperspectiveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_range_sum(s : ImagetransformperspectiveRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_range_mean(s : ImagetransformperspectiveRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_range_scale(s : ImagetransformperspectiveRange, f : Double) -> ImagetransformperspectiveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_range_add(a : ImagetransformperspectiveRange, b : ImagetransformperspectiveRange) -> ImagetransformperspectiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_range_copy(s : ImagetransformperspectiveRange) -> ImagetransformperspectiveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_range_fill(s : ImagetransformperspectiveRange, v : Double) -> ImagetransformperspectiveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_range_min(s : ImagetransformperspectiveRange) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_range_max(s : ImagetransformperspectiveRange) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_range_to_string(s : ImagetransformperspectiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_slice_make(size : Int) -> ImagetransformperspectiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_slice_len(s : ImagetransformperspectiveSlice) -> Int { s.size }

pub fn image_transform_perspective_slice_get(s : ImagetransformperspectiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_slice_set(s : ImagetransformperspectiveSlice, i : Int, v : Double) -> ImagetransformperspectiveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_slice_sum(s : ImagetransformperspectiveSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_perspective_slice_mean(s : ImagetransformperspectiveSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_perspective_slice_scale(s : ImagetransformperspectiveSlice, f : Double) -> ImagetransformperspectiveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_slice_add(a : ImagetransformperspectiveSlice, b : ImagetransformperspectiveSlice) -> ImagetransformperspectiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_perspective_slice_copy(s : ImagetransformperspectiveSlice) -> ImagetransformperspectiveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_slice_fill(s : ImagetransformperspectiveSlice, v : Double) -> ImagetransformperspectiveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_perspective_slice_min(s : ImagetransformperspectiveSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_perspective_slice_max(s : ImagetransformperspectiveSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_perspective_slice_to_string(s : ImagetransformperspectiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

