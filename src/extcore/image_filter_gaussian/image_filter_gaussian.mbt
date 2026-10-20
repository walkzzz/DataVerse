///===
/// extcore/image_filter_gaussian

pub(all) struct ImagefiltergaussianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_gaussian_make_point(x : Double, y : Double) -> ImagefiltergaussianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_gaussian_make_point3(x : Double, y : Double, z : Double) -> ImagefiltergaussianPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltergaussianPoint::x(self : ImagefiltergaussianPoint) -> Double { self.x }

pub fn ImagefiltergaussianPoint::y(self : ImagefiltergaussianPoint) -> Double { self.y }

pub fn ImagefiltergaussianPoint::z(self : ImagefiltergaussianPoint) -> Double { self.z }

pub fn ImagefiltergaussianPoint::label(self : ImagefiltergaussianPoint) -> Int { self.label }

pub fn ImagefiltergaussianPoint::dist(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltergaussianPoint::add(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltergaussianPoint::sub(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltergaussianPoint::scale(self : ImagefiltergaussianPoint, s : Double) -> ImagefiltergaussianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltergaussianPoint::dot(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltergaussianPoint::cross(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltergaussianPoint::norm(self : ImagefiltergaussianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltergaussianPoint::normalize(self : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltergaussianPoint::negate(self : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltergaussianPoint::mid(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltergaussianPoint::lerp(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint, t : Double) -> ImagefiltergaussianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltergaussianPoint::to_string(self : ImagefiltergaussianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltergaussianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_gaussian_make_series(vals : Array[Double], name : String) -> ImagefiltergaussianSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltergaussianSeries::len(self : ImagefiltergaussianSeries) -> Int { self.vals.length() }

pub fn ImagefiltergaussianSeries::sum(self : ImagefiltergaussianSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltergaussianSeries::mean(self : ImagefiltergaussianSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltergaussianSeries::min(self : ImagefiltergaussianSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltergaussianSeries::max(self : ImagefiltergaussianSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltergaussianSeries::range(self : ImagefiltergaussianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltergaussianSeries::variance(self : ImagefiltergaussianSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltergaussianSeries::std(self : ImagefiltergaussianSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltergaussianSeries::median(self : ImagefiltergaussianSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltergaussianSeries::scale(self : ImagefiltergaussianSeries, f : Double) -> ImagefiltergaussianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltergaussianSeries::add(self : ImagefiltergaussianSeries, other : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltergaussianSeries::sub(self : ImagefiltergaussianSeries, other : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltergaussianSeries::normalize(self : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltergaussianSeries::cumsum(self : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltergaussianSeries::to_string(self : ImagefiltergaussianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltergaussianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_gaussian_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltergaussianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_gaussian_matrix_identity(n : Int) -> ImagefiltergaussianMatrix {
  let m = image_filter_gaussian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltergaussianMatrix::get(self : ImagefiltergaussianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltergaussianMatrix::transpose(self : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  let result = image_filter_gaussian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltergaussianMatrix::add(self : ImagefiltergaussianMatrix, other : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltergaussianMatrix::scale(self : ImagefiltergaussianMatrix, s : Double) -> ImagefiltergaussianMatrix {
  let result = image_filter_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltergaussianMatrix::multiply(self : ImagefiltergaussianMatrix, other : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  if self.cols != other.rows { return image_filter_gaussian_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_gaussian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefiltergaussianMatrix::trace(self : ImagefiltergaussianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltergaussianMatrix::det(self : ImagefiltergaussianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltergaussianMatrix::norm(self : ImagefiltergaussianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltergaussianMatrix::to_string(self : ImagefiltergaussianMatrix) -> String {
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

pub(all) struct ImagefiltergaussianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_gaussian_make_vector(comps : Array[Double]) -> ImagefiltergaussianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_gaussian_vector_zero(dim : Int) -> ImagefiltergaussianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltergaussianVector::add(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltergaussianVector::sub(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltergaussianVector::scale(self : ImagefiltergaussianVector, s : Double) -> ImagefiltergaussianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltergaussianVector::dot(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltergaussianVector::norm(self : ImagefiltergaussianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltergaussianVector::normalize(self : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltergaussianVector::dist(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltergaussianVector::to_string(self : ImagefiltergaussianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_gaussian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_gaussian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_gaussian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_gaussian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_gaussian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_gaussian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_gaussian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_gaussian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_gaussian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_gaussian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_gaussian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_gaussian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_gaussian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_gaussian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_gaussian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_gaussian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_gaussian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_gaussian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_gaussian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_gaussian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_gaussian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_gaussian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_gaussian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_gaussian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_gaussian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_gaussian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_gaussian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_gaussian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_gaussian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltergaussianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_frame_make(size : Int) -> ImagefiltergaussianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_frame_len(s : ImagefiltergaussianFrame) -> Int { s.size }

pub fn image_filter_gaussian_frame_get(s : ImagefiltergaussianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_frame_set(s : ImagefiltergaussianFrame, i : Int, v : Double) -> ImagefiltergaussianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_frame_sum(s : ImagefiltergaussianFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_frame_mean(s : ImagefiltergaussianFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_frame_scale(s : ImagefiltergaussianFrame, f : Double) -> ImagefiltergaussianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_frame_add(a : ImagefiltergaussianFrame, b : ImagefiltergaussianFrame) -> ImagefiltergaussianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_frame_copy(s : ImagefiltergaussianFrame) -> ImagefiltergaussianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_frame_fill(s : ImagefiltergaussianFrame, v : Double) -> ImagefiltergaussianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_frame_min(s : ImagefiltergaussianFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_frame_max(s : ImagefiltergaussianFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_frame_to_string(s : ImagefiltergaussianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_table_make(size : Int) -> ImagefiltergaussianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_table_len(s : ImagefiltergaussianTable) -> Int { s.size }

pub fn image_filter_gaussian_table_get(s : ImagefiltergaussianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_table_set(s : ImagefiltergaussianTable, i : Int, v : Double) -> ImagefiltergaussianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_table_sum(s : ImagefiltergaussianTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_table_mean(s : ImagefiltergaussianTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_table_scale(s : ImagefiltergaussianTable, f : Double) -> ImagefiltergaussianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_table_add(a : ImagefiltergaussianTable, b : ImagefiltergaussianTable) -> ImagefiltergaussianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_table_copy(s : ImagefiltergaussianTable) -> ImagefiltergaussianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_table_fill(s : ImagefiltergaussianTable, v : Double) -> ImagefiltergaussianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_table_min(s : ImagefiltergaussianTable) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_table_max(s : ImagefiltergaussianTable) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_table_to_string(s : ImagefiltergaussianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_graphn_make(size : Int) -> ImagefiltergaussianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_graphn_len(s : ImagefiltergaussianGraphN) -> Int { s.size }

pub fn image_filter_gaussian_graphn_get(s : ImagefiltergaussianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_graphn_set(s : ImagefiltergaussianGraphN, i : Int, v : Double) -> ImagefiltergaussianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_graphn_sum(s : ImagefiltergaussianGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_graphn_mean(s : ImagefiltergaussianGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_graphn_scale(s : ImagefiltergaussianGraphN, f : Double) -> ImagefiltergaussianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_graphn_add(a : ImagefiltergaussianGraphN, b : ImagefiltergaussianGraphN) -> ImagefiltergaussianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_graphn_copy(s : ImagefiltergaussianGraphN) -> ImagefiltergaussianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_graphn_fill(s : ImagefiltergaussianGraphN, v : Double) -> ImagefiltergaussianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_graphn_min(s : ImagefiltergaussianGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_graphn_max(s : ImagefiltergaussianGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_graphn_to_string(s : ImagefiltergaussianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_node_make(size : Int) -> ImagefiltergaussianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_node_len(s : ImagefiltergaussianNode) -> Int { s.size }

pub fn image_filter_gaussian_node_get(s : ImagefiltergaussianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_node_set(s : ImagefiltergaussianNode, i : Int, v : Double) -> ImagefiltergaussianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_node_sum(s : ImagefiltergaussianNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_node_mean(s : ImagefiltergaussianNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_node_scale(s : ImagefiltergaussianNode, f : Double) -> ImagefiltergaussianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_node_add(a : ImagefiltergaussianNode, b : ImagefiltergaussianNode) -> ImagefiltergaussianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_node_copy(s : ImagefiltergaussianNode) -> ImagefiltergaussianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_node_fill(s : ImagefiltergaussianNode, v : Double) -> ImagefiltergaussianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_node_min(s : ImagefiltergaussianNode) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_node_max(s : ImagefiltergaussianNode) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_node_to_string(s : ImagefiltergaussianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_edge_make(size : Int) -> ImagefiltergaussianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_edge_len(s : ImagefiltergaussianEdge) -> Int { s.size }

pub fn image_filter_gaussian_edge_get(s : ImagefiltergaussianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_edge_set(s : ImagefiltergaussianEdge, i : Int, v : Double) -> ImagefiltergaussianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_edge_sum(s : ImagefiltergaussianEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_edge_mean(s : ImagefiltergaussianEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_edge_scale(s : ImagefiltergaussianEdge, f : Double) -> ImagefiltergaussianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_edge_add(a : ImagefiltergaussianEdge, b : ImagefiltergaussianEdge) -> ImagefiltergaussianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_edge_copy(s : ImagefiltergaussianEdge) -> ImagefiltergaussianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_edge_fill(s : ImagefiltergaussianEdge, v : Double) -> ImagefiltergaussianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_edge_min(s : ImagefiltergaussianEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_edge_max(s : ImagefiltergaussianEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_edge_to_string(s : ImagefiltergaussianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_path_make(size : Int) -> ImagefiltergaussianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_path_len(s : ImagefiltergaussianPath) -> Int { s.size }

pub fn image_filter_gaussian_path_get(s : ImagefiltergaussianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_path_set(s : ImagefiltergaussianPath, i : Int, v : Double) -> ImagefiltergaussianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_path_sum(s : ImagefiltergaussianPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_path_mean(s : ImagefiltergaussianPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_path_scale(s : ImagefiltergaussianPath, f : Double) -> ImagefiltergaussianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_path_add(a : ImagefiltergaussianPath, b : ImagefiltergaussianPath) -> ImagefiltergaussianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_path_copy(s : ImagefiltergaussianPath) -> ImagefiltergaussianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_path_fill(s : ImagefiltergaussianPath, v : Double) -> ImagefiltergaussianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_path_min(s : ImagefiltergaussianPath) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_path_max(s : ImagefiltergaussianPath) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_path_to_string(s : ImagefiltergaussianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_cluster_make(size : Int) -> ImagefiltergaussianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_cluster_len(s : ImagefiltergaussianCluster) -> Int { s.size }

pub fn image_filter_gaussian_cluster_get(s : ImagefiltergaussianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_cluster_set(s : ImagefiltergaussianCluster, i : Int, v : Double) -> ImagefiltergaussianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cluster_sum(s : ImagefiltergaussianCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_cluster_mean(s : ImagefiltergaussianCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_cluster_scale(s : ImagefiltergaussianCluster, f : Double) -> ImagefiltergaussianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cluster_add(a : ImagefiltergaussianCluster, b : ImagefiltergaussianCluster) -> ImagefiltergaussianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_cluster_copy(s : ImagefiltergaussianCluster) -> ImagefiltergaussianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cluster_fill(s : ImagefiltergaussianCluster, v : Double) -> ImagefiltergaussianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cluster_min(s : ImagefiltergaussianCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_cluster_max(s : ImagefiltergaussianCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_cluster_to_string(s : ImagefiltergaussianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_model_make(size : Int) -> ImagefiltergaussianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_model_len(s : ImagefiltergaussianModel) -> Int { s.size }

pub fn image_filter_gaussian_model_get(s : ImagefiltergaussianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_model_set(s : ImagefiltergaussianModel, i : Int, v : Double) -> ImagefiltergaussianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_model_sum(s : ImagefiltergaussianModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_model_mean(s : ImagefiltergaussianModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_model_scale(s : ImagefiltergaussianModel, f : Double) -> ImagefiltergaussianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_model_add(a : ImagefiltergaussianModel, b : ImagefiltergaussianModel) -> ImagefiltergaussianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_model_copy(s : ImagefiltergaussianModel) -> ImagefiltergaussianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_model_fill(s : ImagefiltergaussianModel, v : Double) -> ImagefiltergaussianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_model_min(s : ImagefiltergaussianModel) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_model_max(s : ImagefiltergaussianModel) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_model_to_string(s : ImagefiltergaussianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_layer_make(size : Int) -> ImagefiltergaussianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_layer_len(s : ImagefiltergaussianLayer) -> Int { s.size }

pub fn image_filter_gaussian_layer_get(s : ImagefiltergaussianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_layer_set(s : ImagefiltergaussianLayer, i : Int, v : Double) -> ImagefiltergaussianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_layer_sum(s : ImagefiltergaussianLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_layer_mean(s : ImagefiltergaussianLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_layer_scale(s : ImagefiltergaussianLayer, f : Double) -> ImagefiltergaussianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_layer_add(a : ImagefiltergaussianLayer, b : ImagefiltergaussianLayer) -> ImagefiltergaussianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_layer_copy(s : ImagefiltergaussianLayer) -> ImagefiltergaussianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_layer_fill(s : ImagefiltergaussianLayer, v : Double) -> ImagefiltergaussianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_layer_min(s : ImagefiltergaussianLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_layer_max(s : ImagefiltergaussianLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_layer_to_string(s : ImagefiltergaussianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_buffer_make(size : Int) -> ImagefiltergaussianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_buffer_len(s : ImagefiltergaussianBuffer) -> Int { s.size }

pub fn image_filter_gaussian_buffer_get(s : ImagefiltergaussianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_buffer_set(s : ImagefiltergaussianBuffer, i : Int, v : Double) -> ImagefiltergaussianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_buffer_sum(s : ImagefiltergaussianBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_buffer_mean(s : ImagefiltergaussianBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_buffer_scale(s : ImagefiltergaussianBuffer, f : Double) -> ImagefiltergaussianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_buffer_add(a : ImagefiltergaussianBuffer, b : ImagefiltergaussianBuffer) -> ImagefiltergaussianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_buffer_copy(s : ImagefiltergaussianBuffer) -> ImagefiltergaussianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_buffer_fill(s : ImagefiltergaussianBuffer, v : Double) -> ImagefiltergaussianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_buffer_min(s : ImagefiltergaussianBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_buffer_max(s : ImagefiltergaussianBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_buffer_to_string(s : ImagefiltergaussianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_cursor_make(size : Int) -> ImagefiltergaussianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_cursor_len(s : ImagefiltergaussianCursor) -> Int { s.size }

pub fn image_filter_gaussian_cursor_get(s : ImagefiltergaussianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_cursor_set(s : ImagefiltergaussianCursor, i : Int, v : Double) -> ImagefiltergaussianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cursor_sum(s : ImagefiltergaussianCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_cursor_mean(s : ImagefiltergaussianCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_cursor_scale(s : ImagefiltergaussianCursor, f : Double) -> ImagefiltergaussianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cursor_add(a : ImagefiltergaussianCursor, b : ImagefiltergaussianCursor) -> ImagefiltergaussianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_cursor_copy(s : ImagefiltergaussianCursor) -> ImagefiltergaussianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cursor_fill(s : ImagefiltergaussianCursor, v : Double) -> ImagefiltergaussianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_cursor_min(s : ImagefiltergaussianCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_cursor_max(s : ImagefiltergaussianCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_cursor_to_string(s : ImagefiltergaussianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_view_make(size : Int) -> ImagefiltergaussianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_view_len(s : ImagefiltergaussianView) -> Int { s.size }

pub fn image_filter_gaussian_view_get(s : ImagefiltergaussianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_view_set(s : ImagefiltergaussianView, i : Int, v : Double) -> ImagefiltergaussianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_view_sum(s : ImagefiltergaussianView) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_view_mean(s : ImagefiltergaussianView) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_view_scale(s : ImagefiltergaussianView, f : Double) -> ImagefiltergaussianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_view_add(a : ImagefiltergaussianView, b : ImagefiltergaussianView) -> ImagefiltergaussianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_view_copy(s : ImagefiltergaussianView) -> ImagefiltergaussianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_view_fill(s : ImagefiltergaussianView, v : Double) -> ImagefiltergaussianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_view_min(s : ImagefiltergaussianView) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_view_max(s : ImagefiltergaussianView) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_view_to_string(s : ImagefiltergaussianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_range_make(size : Int) -> ImagefiltergaussianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_range_len(s : ImagefiltergaussianRange) -> Int { s.size }

pub fn image_filter_gaussian_range_get(s : ImagefiltergaussianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_range_set(s : ImagefiltergaussianRange, i : Int, v : Double) -> ImagefiltergaussianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_range_sum(s : ImagefiltergaussianRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_range_mean(s : ImagefiltergaussianRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_range_scale(s : ImagefiltergaussianRange, f : Double) -> ImagefiltergaussianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_range_add(a : ImagefiltergaussianRange, b : ImagefiltergaussianRange) -> ImagefiltergaussianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_range_copy(s : ImagefiltergaussianRange) -> ImagefiltergaussianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_range_fill(s : ImagefiltergaussianRange, v : Double) -> ImagefiltergaussianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_range_min(s : ImagefiltergaussianRange) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_range_max(s : ImagefiltergaussianRange) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_range_to_string(s : ImagefiltergaussianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_slice_make(size : Int) -> ImagefiltergaussianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_slice_len(s : ImagefiltergaussianSlice) -> Int { s.size }

pub fn image_filter_gaussian_slice_get(s : ImagefiltergaussianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_slice_set(s : ImagefiltergaussianSlice, i : Int, v : Double) -> ImagefiltergaussianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_slice_sum(s : ImagefiltergaussianSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_slice_mean(s : ImagefiltergaussianSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_slice_scale(s : ImagefiltergaussianSlice, f : Double) -> ImagefiltergaussianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_slice_add(a : ImagefiltergaussianSlice, b : ImagefiltergaussianSlice) -> ImagefiltergaussianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gaussian_slice_copy(s : ImagefiltergaussianSlice) -> ImagefiltergaussianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_slice_fill(s : ImagefiltergaussianSlice, v : Double) -> ImagefiltergaussianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gaussian_slice_min(s : ImagefiltergaussianSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_slice_max(s : ImagefiltergaussianSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_slice_to_string(s : ImagefiltergaussianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

