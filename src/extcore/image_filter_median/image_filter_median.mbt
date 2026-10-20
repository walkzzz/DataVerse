///===
/// extcore/image_filter_median

pub(all) struct ImagefiltermedianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_median_make_point(x : Double, y : Double) -> ImagefiltermedianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_median_make_point3(x : Double, y : Double, z : Double) -> ImagefiltermedianPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltermedianPoint::x(self : ImagefiltermedianPoint) -> Double { self.x }

pub fn ImagefiltermedianPoint::y(self : ImagefiltermedianPoint) -> Double { self.y }

pub fn ImagefiltermedianPoint::z(self : ImagefiltermedianPoint) -> Double { self.z }

pub fn ImagefiltermedianPoint::label(self : ImagefiltermedianPoint) -> Int { self.label }

pub fn ImagefiltermedianPoint::dist(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltermedianPoint::add(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltermedianPoint::sub(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltermedianPoint::scale(self : ImagefiltermedianPoint, s : Double) -> ImagefiltermedianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltermedianPoint::dot(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltermedianPoint::cross(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltermedianPoint::norm(self : ImagefiltermedianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltermedianPoint::normalize(self : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltermedianPoint::negate(self : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltermedianPoint::mid(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltermedianPoint::lerp(self : ImagefiltermedianPoint, other : ImagefiltermedianPoint, t : Double) -> ImagefiltermedianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltermedianPoint::to_string(self : ImagefiltermedianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltermedianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_median_make_series(vals : Array[Double], name : String) -> ImagefiltermedianSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltermedianSeries::len(self : ImagefiltermedianSeries) -> Int { self.vals.length() }

pub fn ImagefiltermedianSeries::sum(self : ImagefiltermedianSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltermedianSeries::mean(self : ImagefiltermedianSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltermedianSeries::min(self : ImagefiltermedianSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltermedianSeries::max(self : ImagefiltermedianSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltermedianSeries::range(self : ImagefiltermedianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltermedianSeries::variance(self : ImagefiltermedianSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltermedianSeries::std(self : ImagefiltermedianSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltermedianSeries::median(self : ImagefiltermedianSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltermedianSeries::scale(self : ImagefiltermedianSeries, f : Double) -> ImagefiltermedianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltermedianSeries::add(self : ImagefiltermedianSeries, other : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltermedianSeries::sub(self : ImagefiltermedianSeries, other : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltermedianSeries::normalize(self : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltermedianSeries::cumsum(self : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltermedianSeries::to_string(self : ImagefiltermedianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltermedianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_median_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltermedianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_median_matrix_identity(n : Int) -> ImagefiltermedianMatrix {
  let m = image_filter_median_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltermedianMatrix::get(self : ImagefiltermedianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltermedianMatrix::transpose(self : ImagefiltermedianMatrix) -> ImagefiltermedianMatrix {
  let result = image_filter_median_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltermedianMatrix::add(self : ImagefiltermedianMatrix, other : ImagefiltermedianMatrix) -> ImagefiltermedianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltermedianMatrix::scale(self : ImagefiltermedianMatrix, s : Double) -> ImagefiltermedianMatrix {
  let result = image_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltermedianMatrix::multiply(self : ImagefiltermedianMatrix, other : ImagefiltermedianMatrix) -> ImagefiltermedianMatrix {
  if self.cols != other.rows { return image_filter_median_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_median_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefiltermedianMatrix::trace(self : ImagefiltermedianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltermedianMatrix::det(self : ImagefiltermedianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltermedianMatrix::norm(self : ImagefiltermedianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltermedianMatrix::to_string(self : ImagefiltermedianMatrix) -> String {
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

pub(all) struct ImagefiltermedianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_median_make_vector(comps : Array[Double]) -> ImagefiltermedianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_median_vector_zero(dim : Int) -> ImagefiltermedianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltermedianVector::add(self : ImagefiltermedianVector, other : ImagefiltermedianVector) -> ImagefiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltermedianVector::sub(self : ImagefiltermedianVector, other : ImagefiltermedianVector) -> ImagefiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltermedianVector::scale(self : ImagefiltermedianVector, s : Double) -> ImagefiltermedianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltermedianVector::dot(self : ImagefiltermedianVector, other : ImagefiltermedianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltermedianVector::norm(self : ImagefiltermedianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltermedianVector::normalize(self : ImagefiltermedianVector) -> ImagefiltermedianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltermedianVector::dist(self : ImagefiltermedianVector, other : ImagefiltermedianVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltermedianVector::to_string(self : ImagefiltermedianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_median_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_median_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_median_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_median_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_median_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_median_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_median_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_median_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_median_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_median_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_median_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_median_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_median_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_median_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_median_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_median_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_median_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_median_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_median_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_median_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_median_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_median_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_median_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_median_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_median_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_median_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_median_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_median_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_median_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltermedianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_frame_make(size : Int) -> ImagefiltermedianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_frame_len(s : ImagefiltermedianFrame) -> Int { s.size }

pub fn image_filter_median_frame_get(s : ImagefiltermedianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_frame_set(s : ImagefiltermedianFrame, i : Int, v : Double) -> ImagefiltermedianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_frame_sum(s : ImagefiltermedianFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_frame_mean(s : ImagefiltermedianFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_frame_scale(s : ImagefiltermedianFrame, f : Double) -> ImagefiltermedianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_frame_add(a : ImagefiltermedianFrame, b : ImagefiltermedianFrame) -> ImagefiltermedianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_frame_copy(s : ImagefiltermedianFrame) -> ImagefiltermedianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_frame_fill(s : ImagefiltermedianFrame, v : Double) -> ImagefiltermedianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_frame_min(s : ImagefiltermedianFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_median_frame_max(s : ImagefiltermedianFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_median_frame_to_string(s : ImagefiltermedianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_table_make(size : Int) -> ImagefiltermedianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_table_len(s : ImagefiltermedianTable) -> Int { s.size }

pub fn image_filter_median_table_get(s : ImagefiltermedianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_table_set(s : ImagefiltermedianTable, i : Int, v : Double) -> ImagefiltermedianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_table_sum(s : ImagefiltermedianTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_table_mean(s : ImagefiltermedianTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_table_scale(s : ImagefiltermedianTable, f : Double) -> ImagefiltermedianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_table_add(a : ImagefiltermedianTable, b : ImagefiltermedianTable) -> ImagefiltermedianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_table_copy(s : ImagefiltermedianTable) -> ImagefiltermedianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_table_fill(s : ImagefiltermedianTable, v : Double) -> ImagefiltermedianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_table_min(s : ImagefiltermedianTable) -> Double { @_common.min(s.data) }

pub fn image_filter_median_table_max(s : ImagefiltermedianTable) -> Double { @_common.max(s.data) }

pub fn image_filter_median_table_to_string(s : ImagefiltermedianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_graphn_make(size : Int) -> ImagefiltermedianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_graphn_len(s : ImagefiltermedianGraphN) -> Int { s.size }

pub fn image_filter_median_graphn_get(s : ImagefiltermedianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_graphn_set(s : ImagefiltermedianGraphN, i : Int, v : Double) -> ImagefiltermedianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_graphn_sum(s : ImagefiltermedianGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_graphn_mean(s : ImagefiltermedianGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_graphn_scale(s : ImagefiltermedianGraphN, f : Double) -> ImagefiltermedianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_graphn_add(a : ImagefiltermedianGraphN, b : ImagefiltermedianGraphN) -> ImagefiltermedianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_graphn_copy(s : ImagefiltermedianGraphN) -> ImagefiltermedianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_graphn_fill(s : ImagefiltermedianGraphN, v : Double) -> ImagefiltermedianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_graphn_min(s : ImagefiltermedianGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_median_graphn_max(s : ImagefiltermedianGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_median_graphn_to_string(s : ImagefiltermedianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_node_make(size : Int) -> ImagefiltermedianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_node_len(s : ImagefiltermedianNode) -> Int { s.size }

pub fn image_filter_median_node_get(s : ImagefiltermedianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_node_set(s : ImagefiltermedianNode, i : Int, v : Double) -> ImagefiltermedianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_node_sum(s : ImagefiltermedianNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_node_mean(s : ImagefiltermedianNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_node_scale(s : ImagefiltermedianNode, f : Double) -> ImagefiltermedianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_node_add(a : ImagefiltermedianNode, b : ImagefiltermedianNode) -> ImagefiltermedianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_node_copy(s : ImagefiltermedianNode) -> ImagefiltermedianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_node_fill(s : ImagefiltermedianNode, v : Double) -> ImagefiltermedianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_node_min(s : ImagefiltermedianNode) -> Double { @_common.min(s.data) }

pub fn image_filter_median_node_max(s : ImagefiltermedianNode) -> Double { @_common.max(s.data) }

pub fn image_filter_median_node_to_string(s : ImagefiltermedianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_edge_make(size : Int) -> ImagefiltermedianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_edge_len(s : ImagefiltermedianEdge) -> Int { s.size }

pub fn image_filter_median_edge_get(s : ImagefiltermedianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_edge_set(s : ImagefiltermedianEdge, i : Int, v : Double) -> ImagefiltermedianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_edge_sum(s : ImagefiltermedianEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_edge_mean(s : ImagefiltermedianEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_edge_scale(s : ImagefiltermedianEdge, f : Double) -> ImagefiltermedianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_edge_add(a : ImagefiltermedianEdge, b : ImagefiltermedianEdge) -> ImagefiltermedianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_edge_copy(s : ImagefiltermedianEdge) -> ImagefiltermedianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_edge_fill(s : ImagefiltermedianEdge, v : Double) -> ImagefiltermedianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_edge_min(s : ImagefiltermedianEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_median_edge_max(s : ImagefiltermedianEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_median_edge_to_string(s : ImagefiltermedianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_path_make(size : Int) -> ImagefiltermedianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_path_len(s : ImagefiltermedianPath) -> Int { s.size }

pub fn image_filter_median_path_get(s : ImagefiltermedianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_path_set(s : ImagefiltermedianPath, i : Int, v : Double) -> ImagefiltermedianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_path_sum(s : ImagefiltermedianPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_path_mean(s : ImagefiltermedianPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_path_scale(s : ImagefiltermedianPath, f : Double) -> ImagefiltermedianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_path_add(a : ImagefiltermedianPath, b : ImagefiltermedianPath) -> ImagefiltermedianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_path_copy(s : ImagefiltermedianPath) -> ImagefiltermedianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_path_fill(s : ImagefiltermedianPath, v : Double) -> ImagefiltermedianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_path_min(s : ImagefiltermedianPath) -> Double { @_common.min(s.data) }

pub fn image_filter_median_path_max(s : ImagefiltermedianPath) -> Double { @_common.max(s.data) }

pub fn image_filter_median_path_to_string(s : ImagefiltermedianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_cluster_make(size : Int) -> ImagefiltermedianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_cluster_len(s : ImagefiltermedianCluster) -> Int { s.size }

pub fn image_filter_median_cluster_get(s : ImagefiltermedianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_cluster_set(s : ImagefiltermedianCluster, i : Int, v : Double) -> ImagefiltermedianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_cluster_sum(s : ImagefiltermedianCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_cluster_mean(s : ImagefiltermedianCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_cluster_scale(s : ImagefiltermedianCluster, f : Double) -> ImagefiltermedianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_cluster_add(a : ImagefiltermedianCluster, b : ImagefiltermedianCluster) -> ImagefiltermedianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_cluster_copy(s : ImagefiltermedianCluster) -> ImagefiltermedianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_cluster_fill(s : ImagefiltermedianCluster, v : Double) -> ImagefiltermedianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_cluster_min(s : ImagefiltermedianCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_median_cluster_max(s : ImagefiltermedianCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_median_cluster_to_string(s : ImagefiltermedianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_model_make(size : Int) -> ImagefiltermedianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_model_len(s : ImagefiltermedianModel) -> Int { s.size }

pub fn image_filter_median_model_get(s : ImagefiltermedianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_model_set(s : ImagefiltermedianModel, i : Int, v : Double) -> ImagefiltermedianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_model_sum(s : ImagefiltermedianModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_model_mean(s : ImagefiltermedianModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_model_scale(s : ImagefiltermedianModel, f : Double) -> ImagefiltermedianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_model_add(a : ImagefiltermedianModel, b : ImagefiltermedianModel) -> ImagefiltermedianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_model_copy(s : ImagefiltermedianModel) -> ImagefiltermedianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_model_fill(s : ImagefiltermedianModel, v : Double) -> ImagefiltermedianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_model_min(s : ImagefiltermedianModel) -> Double { @_common.min(s.data) }

pub fn image_filter_median_model_max(s : ImagefiltermedianModel) -> Double { @_common.max(s.data) }

pub fn image_filter_median_model_to_string(s : ImagefiltermedianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_layer_make(size : Int) -> ImagefiltermedianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_layer_len(s : ImagefiltermedianLayer) -> Int { s.size }

pub fn image_filter_median_layer_get(s : ImagefiltermedianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_layer_set(s : ImagefiltermedianLayer, i : Int, v : Double) -> ImagefiltermedianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_layer_sum(s : ImagefiltermedianLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_layer_mean(s : ImagefiltermedianLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_layer_scale(s : ImagefiltermedianLayer, f : Double) -> ImagefiltermedianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_layer_add(a : ImagefiltermedianLayer, b : ImagefiltermedianLayer) -> ImagefiltermedianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_layer_copy(s : ImagefiltermedianLayer) -> ImagefiltermedianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_layer_fill(s : ImagefiltermedianLayer, v : Double) -> ImagefiltermedianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_layer_min(s : ImagefiltermedianLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_median_layer_max(s : ImagefiltermedianLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_median_layer_to_string(s : ImagefiltermedianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_buffer_make(size : Int) -> ImagefiltermedianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_buffer_len(s : ImagefiltermedianBuffer) -> Int { s.size }

pub fn image_filter_median_buffer_get(s : ImagefiltermedianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_buffer_set(s : ImagefiltermedianBuffer, i : Int, v : Double) -> ImagefiltermedianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_buffer_sum(s : ImagefiltermedianBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_buffer_mean(s : ImagefiltermedianBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_buffer_scale(s : ImagefiltermedianBuffer, f : Double) -> ImagefiltermedianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_buffer_add(a : ImagefiltermedianBuffer, b : ImagefiltermedianBuffer) -> ImagefiltermedianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_buffer_copy(s : ImagefiltermedianBuffer) -> ImagefiltermedianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_buffer_fill(s : ImagefiltermedianBuffer, v : Double) -> ImagefiltermedianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_buffer_min(s : ImagefiltermedianBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_median_buffer_max(s : ImagefiltermedianBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_median_buffer_to_string(s : ImagefiltermedianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_cursor_make(size : Int) -> ImagefiltermedianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_cursor_len(s : ImagefiltermedianCursor) -> Int { s.size }

pub fn image_filter_median_cursor_get(s : ImagefiltermedianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_cursor_set(s : ImagefiltermedianCursor, i : Int, v : Double) -> ImagefiltermedianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_cursor_sum(s : ImagefiltermedianCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_cursor_mean(s : ImagefiltermedianCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_cursor_scale(s : ImagefiltermedianCursor, f : Double) -> ImagefiltermedianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_cursor_add(a : ImagefiltermedianCursor, b : ImagefiltermedianCursor) -> ImagefiltermedianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_cursor_copy(s : ImagefiltermedianCursor) -> ImagefiltermedianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_cursor_fill(s : ImagefiltermedianCursor, v : Double) -> ImagefiltermedianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_cursor_min(s : ImagefiltermedianCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_median_cursor_max(s : ImagefiltermedianCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_median_cursor_to_string(s : ImagefiltermedianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_view_make(size : Int) -> ImagefiltermedianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_view_len(s : ImagefiltermedianView) -> Int { s.size }

pub fn image_filter_median_view_get(s : ImagefiltermedianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_view_set(s : ImagefiltermedianView, i : Int, v : Double) -> ImagefiltermedianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_view_sum(s : ImagefiltermedianView) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_view_mean(s : ImagefiltermedianView) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_view_scale(s : ImagefiltermedianView, f : Double) -> ImagefiltermedianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_view_add(a : ImagefiltermedianView, b : ImagefiltermedianView) -> ImagefiltermedianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_view_copy(s : ImagefiltermedianView) -> ImagefiltermedianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_view_fill(s : ImagefiltermedianView, v : Double) -> ImagefiltermedianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_view_min(s : ImagefiltermedianView) -> Double { @_common.min(s.data) }

pub fn image_filter_median_view_max(s : ImagefiltermedianView) -> Double { @_common.max(s.data) }

pub fn image_filter_median_view_to_string(s : ImagefiltermedianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_range_make(size : Int) -> ImagefiltermedianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_range_len(s : ImagefiltermedianRange) -> Int { s.size }

pub fn image_filter_median_range_get(s : ImagefiltermedianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_range_set(s : ImagefiltermedianRange, i : Int, v : Double) -> ImagefiltermedianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_range_sum(s : ImagefiltermedianRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_range_mean(s : ImagefiltermedianRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_range_scale(s : ImagefiltermedianRange, f : Double) -> ImagefiltermedianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_range_add(a : ImagefiltermedianRange, b : ImagefiltermedianRange) -> ImagefiltermedianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_range_copy(s : ImagefiltermedianRange) -> ImagefiltermedianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_range_fill(s : ImagefiltermedianRange, v : Double) -> ImagefiltermedianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_range_min(s : ImagefiltermedianRange) -> Double { @_common.min(s.data) }

pub fn image_filter_median_range_max(s : ImagefiltermedianRange) -> Double { @_common.max(s.data) }

pub fn image_filter_median_range_to_string(s : ImagefiltermedianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_slice_make(size : Int) -> ImagefiltermedianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_slice_len(s : ImagefiltermedianSlice) -> Int { s.size }

pub fn image_filter_median_slice_get(s : ImagefiltermedianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_slice_set(s : ImagefiltermedianSlice, i : Int, v : Double) -> ImagefiltermedianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_median_slice_sum(s : ImagefiltermedianSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_median_slice_mean(s : ImagefiltermedianSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_median_slice_scale(s : ImagefiltermedianSlice, f : Double) -> ImagefiltermedianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_median_slice_add(a : ImagefiltermedianSlice, b : ImagefiltermedianSlice) -> ImagefiltermedianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_median_slice_copy(s : ImagefiltermedianSlice) -> ImagefiltermedianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_median_slice_fill(s : ImagefiltermedianSlice, v : Double) -> ImagefiltermedianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_median_slice_min(s : ImagefiltermedianSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_median_slice_max(s : ImagefiltermedianSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_median_slice_to_string(s : ImagefiltermedianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

