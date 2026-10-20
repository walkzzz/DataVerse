///===
/// extcore/image_filter_mean

pub(all) struct ImagefiltermeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_mean_make_point(x : Double, y : Double) -> ImagefiltermeanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_mean_make_point3(x : Double, y : Double, z : Double) -> ImagefiltermeanPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltermeanPoint::x(self : ImagefiltermeanPoint) -> Double { self.x }

pub fn ImagefiltermeanPoint::y(self : ImagefiltermeanPoint) -> Double { self.y }

pub fn ImagefiltermeanPoint::z(self : ImagefiltermeanPoint) -> Double { self.z }

pub fn ImagefiltermeanPoint::label(self : ImagefiltermeanPoint) -> Int { self.label }

pub fn ImagefiltermeanPoint::dist(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltermeanPoint::add(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltermeanPoint::sub(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltermeanPoint::scale(self : ImagefiltermeanPoint, s : Double) -> ImagefiltermeanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltermeanPoint::dot(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltermeanPoint::cross(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltermeanPoint::norm(self : ImagefiltermeanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltermeanPoint::normalize(self : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltermeanPoint::negate(self : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltermeanPoint::mid(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltermeanPoint::lerp(self : ImagefiltermeanPoint, other : ImagefiltermeanPoint, t : Double) -> ImagefiltermeanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltermeanPoint::to_string(self : ImagefiltermeanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltermeanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_mean_make_series(vals : Array[Double], name : String) -> ImagefiltermeanSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltermeanSeries::len(self : ImagefiltermeanSeries) -> Int { self.vals.length() }

pub fn ImagefiltermeanSeries::sum(self : ImagefiltermeanSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltermeanSeries::mean(self : ImagefiltermeanSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltermeanSeries::min(self : ImagefiltermeanSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltermeanSeries::max(self : ImagefiltermeanSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltermeanSeries::range(self : ImagefiltermeanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltermeanSeries::variance(self : ImagefiltermeanSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltermeanSeries::std(self : ImagefiltermeanSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltermeanSeries::median(self : ImagefiltermeanSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltermeanSeries::scale(self : ImagefiltermeanSeries, f : Double) -> ImagefiltermeanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltermeanSeries::add(self : ImagefiltermeanSeries, other : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltermeanSeries::sub(self : ImagefiltermeanSeries, other : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltermeanSeries::normalize(self : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltermeanSeries::cumsum(self : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltermeanSeries::to_string(self : ImagefiltermeanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltermeanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_mean_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltermeanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_mean_matrix_identity(n : Int) -> ImagefiltermeanMatrix {
  let m = image_filter_mean_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltermeanMatrix::get(self : ImagefiltermeanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltermeanMatrix::transpose(self : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltermeanMatrix::add(self : ImagefiltermeanMatrix, other : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_mean_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltermeanMatrix::scale(self : ImagefiltermeanMatrix, s : Double) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltermeanMatrix::multiply(self : ImagefiltermeanMatrix, other : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  if self.cols != other.rows { return image_filter_mean_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_mean_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefiltermeanMatrix::trace(self : ImagefiltermeanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltermeanMatrix::det(self : ImagefiltermeanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltermeanMatrix::norm(self : ImagefiltermeanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltermeanMatrix::to_string(self : ImagefiltermeanMatrix) -> String {
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

pub(all) struct ImagefiltermeanVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_mean_make_vector(comps : Array[Double]) -> ImagefiltermeanVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_mean_vector_zero(dim : Int) -> ImagefiltermeanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltermeanVector::add(self : ImagefiltermeanVector, other : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltermeanVector::sub(self : ImagefiltermeanVector, other : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltermeanVector::scale(self : ImagefiltermeanVector, s : Double) -> ImagefiltermeanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltermeanVector::dot(self : ImagefiltermeanVector, other : ImagefiltermeanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltermeanVector::norm(self : ImagefiltermeanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltermeanVector::normalize(self : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltermeanVector::dist(self : ImagefiltermeanVector, other : ImagefiltermeanVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltermeanVector::to_string(self : ImagefiltermeanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_mean_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_mean_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_mean_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_mean_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_mean_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_mean_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_mean_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_mean_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_mean_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_mean_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_mean_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_mean_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_mean_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_mean_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_mean_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_mean_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_mean_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_mean_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_mean_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_mean_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_mean_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_mean_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_mean_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_mean_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_mean_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_mean_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_mean_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_mean_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_mean_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltermeanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_frame_make(size : Int) -> ImagefiltermeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_frame_len(s : ImagefiltermeanFrame) -> Int { s.size }

pub fn image_filter_mean_frame_get(s : ImagefiltermeanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_frame_set(s : ImagefiltermeanFrame, i : Int, v : Double) -> ImagefiltermeanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_sum(s : ImagefiltermeanFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_frame_mean(s : ImagefiltermeanFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_frame_scale(s : ImagefiltermeanFrame, f : Double) -> ImagefiltermeanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_add(a : ImagefiltermeanFrame, b : ImagefiltermeanFrame) -> ImagefiltermeanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_frame_copy(s : ImagefiltermeanFrame) -> ImagefiltermeanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_fill(s : ImagefiltermeanFrame, v : Double) -> ImagefiltermeanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_min(s : ImagefiltermeanFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_frame_max(s : ImagefiltermeanFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_frame_to_string(s : ImagefiltermeanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_table_make(size : Int) -> ImagefiltermeanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_table_len(s : ImagefiltermeanTable) -> Int { s.size }

pub fn image_filter_mean_table_get(s : ImagefiltermeanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_table_set(s : ImagefiltermeanTable, i : Int, v : Double) -> ImagefiltermeanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_sum(s : ImagefiltermeanTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_table_mean(s : ImagefiltermeanTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_table_scale(s : ImagefiltermeanTable, f : Double) -> ImagefiltermeanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_add(a : ImagefiltermeanTable, b : ImagefiltermeanTable) -> ImagefiltermeanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_table_copy(s : ImagefiltermeanTable) -> ImagefiltermeanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_fill(s : ImagefiltermeanTable, v : Double) -> ImagefiltermeanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_min(s : ImagefiltermeanTable) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_table_max(s : ImagefiltermeanTable) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_table_to_string(s : ImagefiltermeanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_graphn_make(size : Int) -> ImagefiltermeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_graphn_len(s : ImagefiltermeanGraphN) -> Int { s.size }

pub fn image_filter_mean_graphn_get(s : ImagefiltermeanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_graphn_set(s : ImagefiltermeanGraphN, i : Int, v : Double) -> ImagefiltermeanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_sum(s : ImagefiltermeanGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_graphn_mean(s : ImagefiltermeanGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_graphn_scale(s : ImagefiltermeanGraphN, f : Double) -> ImagefiltermeanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_add(a : ImagefiltermeanGraphN, b : ImagefiltermeanGraphN) -> ImagefiltermeanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_graphn_copy(s : ImagefiltermeanGraphN) -> ImagefiltermeanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_fill(s : ImagefiltermeanGraphN, v : Double) -> ImagefiltermeanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_min(s : ImagefiltermeanGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_graphn_max(s : ImagefiltermeanGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_graphn_to_string(s : ImagefiltermeanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_node_make(size : Int) -> ImagefiltermeanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_node_len(s : ImagefiltermeanNode) -> Int { s.size }

pub fn image_filter_mean_node_get(s : ImagefiltermeanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_node_set(s : ImagefiltermeanNode, i : Int, v : Double) -> ImagefiltermeanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_sum(s : ImagefiltermeanNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_node_mean(s : ImagefiltermeanNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_node_scale(s : ImagefiltermeanNode, f : Double) -> ImagefiltermeanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_add(a : ImagefiltermeanNode, b : ImagefiltermeanNode) -> ImagefiltermeanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_node_copy(s : ImagefiltermeanNode) -> ImagefiltermeanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_fill(s : ImagefiltermeanNode, v : Double) -> ImagefiltermeanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_min(s : ImagefiltermeanNode) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_node_max(s : ImagefiltermeanNode) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_node_to_string(s : ImagefiltermeanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_edge_make(size : Int) -> ImagefiltermeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_edge_len(s : ImagefiltermeanEdge) -> Int { s.size }

pub fn image_filter_mean_edge_get(s : ImagefiltermeanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_edge_set(s : ImagefiltermeanEdge, i : Int, v : Double) -> ImagefiltermeanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_sum(s : ImagefiltermeanEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_edge_mean(s : ImagefiltermeanEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_edge_scale(s : ImagefiltermeanEdge, f : Double) -> ImagefiltermeanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_add(a : ImagefiltermeanEdge, b : ImagefiltermeanEdge) -> ImagefiltermeanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_edge_copy(s : ImagefiltermeanEdge) -> ImagefiltermeanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_fill(s : ImagefiltermeanEdge, v : Double) -> ImagefiltermeanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_min(s : ImagefiltermeanEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_edge_max(s : ImagefiltermeanEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_edge_to_string(s : ImagefiltermeanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_path_make(size : Int) -> ImagefiltermeanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_path_len(s : ImagefiltermeanPath) -> Int { s.size }

pub fn image_filter_mean_path_get(s : ImagefiltermeanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_path_set(s : ImagefiltermeanPath, i : Int, v : Double) -> ImagefiltermeanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_sum(s : ImagefiltermeanPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_path_mean(s : ImagefiltermeanPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_path_scale(s : ImagefiltermeanPath, f : Double) -> ImagefiltermeanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_add(a : ImagefiltermeanPath, b : ImagefiltermeanPath) -> ImagefiltermeanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_path_copy(s : ImagefiltermeanPath) -> ImagefiltermeanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_fill(s : ImagefiltermeanPath, v : Double) -> ImagefiltermeanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_min(s : ImagefiltermeanPath) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_path_max(s : ImagefiltermeanPath) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_path_to_string(s : ImagefiltermeanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_cluster_make(size : Int) -> ImagefiltermeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_cluster_len(s : ImagefiltermeanCluster) -> Int { s.size }

pub fn image_filter_mean_cluster_get(s : ImagefiltermeanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_cluster_set(s : ImagefiltermeanCluster, i : Int, v : Double) -> ImagefiltermeanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_sum(s : ImagefiltermeanCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_cluster_mean(s : ImagefiltermeanCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_cluster_scale(s : ImagefiltermeanCluster, f : Double) -> ImagefiltermeanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_add(a : ImagefiltermeanCluster, b : ImagefiltermeanCluster) -> ImagefiltermeanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_cluster_copy(s : ImagefiltermeanCluster) -> ImagefiltermeanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_fill(s : ImagefiltermeanCluster, v : Double) -> ImagefiltermeanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_min(s : ImagefiltermeanCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_cluster_max(s : ImagefiltermeanCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_cluster_to_string(s : ImagefiltermeanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_model_make(size : Int) -> ImagefiltermeanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_model_len(s : ImagefiltermeanModel) -> Int { s.size }

pub fn image_filter_mean_model_get(s : ImagefiltermeanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_model_set(s : ImagefiltermeanModel, i : Int, v : Double) -> ImagefiltermeanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_sum(s : ImagefiltermeanModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_model_mean(s : ImagefiltermeanModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_model_scale(s : ImagefiltermeanModel, f : Double) -> ImagefiltermeanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_add(a : ImagefiltermeanModel, b : ImagefiltermeanModel) -> ImagefiltermeanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_model_copy(s : ImagefiltermeanModel) -> ImagefiltermeanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_fill(s : ImagefiltermeanModel, v : Double) -> ImagefiltermeanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_min(s : ImagefiltermeanModel) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_model_max(s : ImagefiltermeanModel) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_model_to_string(s : ImagefiltermeanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_layer_make(size : Int) -> ImagefiltermeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_layer_len(s : ImagefiltermeanLayer) -> Int { s.size }

pub fn image_filter_mean_layer_get(s : ImagefiltermeanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_layer_set(s : ImagefiltermeanLayer, i : Int, v : Double) -> ImagefiltermeanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_sum(s : ImagefiltermeanLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_layer_mean(s : ImagefiltermeanLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_layer_scale(s : ImagefiltermeanLayer, f : Double) -> ImagefiltermeanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_add(a : ImagefiltermeanLayer, b : ImagefiltermeanLayer) -> ImagefiltermeanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_layer_copy(s : ImagefiltermeanLayer) -> ImagefiltermeanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_fill(s : ImagefiltermeanLayer, v : Double) -> ImagefiltermeanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_min(s : ImagefiltermeanLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_layer_max(s : ImagefiltermeanLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_layer_to_string(s : ImagefiltermeanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_buffer_make(size : Int) -> ImagefiltermeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_buffer_len(s : ImagefiltermeanBuffer) -> Int { s.size }

pub fn image_filter_mean_buffer_get(s : ImagefiltermeanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_buffer_set(s : ImagefiltermeanBuffer, i : Int, v : Double) -> ImagefiltermeanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_sum(s : ImagefiltermeanBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_buffer_mean(s : ImagefiltermeanBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_buffer_scale(s : ImagefiltermeanBuffer, f : Double) -> ImagefiltermeanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_add(a : ImagefiltermeanBuffer, b : ImagefiltermeanBuffer) -> ImagefiltermeanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_buffer_copy(s : ImagefiltermeanBuffer) -> ImagefiltermeanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_fill(s : ImagefiltermeanBuffer, v : Double) -> ImagefiltermeanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_min(s : ImagefiltermeanBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_buffer_max(s : ImagefiltermeanBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_buffer_to_string(s : ImagefiltermeanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_cursor_make(size : Int) -> ImagefiltermeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_cursor_len(s : ImagefiltermeanCursor) -> Int { s.size }

pub fn image_filter_mean_cursor_get(s : ImagefiltermeanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_cursor_set(s : ImagefiltermeanCursor, i : Int, v : Double) -> ImagefiltermeanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_sum(s : ImagefiltermeanCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_cursor_mean(s : ImagefiltermeanCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_cursor_scale(s : ImagefiltermeanCursor, f : Double) -> ImagefiltermeanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_add(a : ImagefiltermeanCursor, b : ImagefiltermeanCursor) -> ImagefiltermeanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_cursor_copy(s : ImagefiltermeanCursor) -> ImagefiltermeanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_fill(s : ImagefiltermeanCursor, v : Double) -> ImagefiltermeanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_min(s : ImagefiltermeanCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_cursor_max(s : ImagefiltermeanCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_cursor_to_string(s : ImagefiltermeanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_view_make(size : Int) -> ImagefiltermeanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_view_len(s : ImagefiltermeanView) -> Int { s.size }

pub fn image_filter_mean_view_get(s : ImagefiltermeanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_view_set(s : ImagefiltermeanView, i : Int, v : Double) -> ImagefiltermeanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_sum(s : ImagefiltermeanView) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_view_mean(s : ImagefiltermeanView) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_view_scale(s : ImagefiltermeanView, f : Double) -> ImagefiltermeanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_add(a : ImagefiltermeanView, b : ImagefiltermeanView) -> ImagefiltermeanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_view_copy(s : ImagefiltermeanView) -> ImagefiltermeanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_fill(s : ImagefiltermeanView, v : Double) -> ImagefiltermeanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_min(s : ImagefiltermeanView) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_view_max(s : ImagefiltermeanView) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_view_to_string(s : ImagefiltermeanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_range_make(size : Int) -> ImagefiltermeanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_range_len(s : ImagefiltermeanRange) -> Int { s.size }

pub fn image_filter_mean_range_get(s : ImagefiltermeanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_range_set(s : ImagefiltermeanRange, i : Int, v : Double) -> ImagefiltermeanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_sum(s : ImagefiltermeanRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_range_mean(s : ImagefiltermeanRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_range_scale(s : ImagefiltermeanRange, f : Double) -> ImagefiltermeanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_add(a : ImagefiltermeanRange, b : ImagefiltermeanRange) -> ImagefiltermeanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_range_copy(s : ImagefiltermeanRange) -> ImagefiltermeanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_fill(s : ImagefiltermeanRange, v : Double) -> ImagefiltermeanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_min(s : ImagefiltermeanRange) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_range_max(s : ImagefiltermeanRange) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_range_to_string(s : ImagefiltermeanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_slice_make(size : Int) -> ImagefiltermeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_slice_len(s : ImagefiltermeanSlice) -> Int { s.size }

pub fn image_filter_mean_slice_get(s : ImagefiltermeanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_slice_set(s : ImagefiltermeanSlice, i : Int, v : Double) -> ImagefiltermeanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_sum(s : ImagefiltermeanSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_slice_mean(s : ImagefiltermeanSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_slice_scale(s : ImagefiltermeanSlice, f : Double) -> ImagefiltermeanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_add(a : ImagefiltermeanSlice, b : ImagefiltermeanSlice) -> ImagefiltermeanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_slice_copy(s : ImagefiltermeanSlice) -> ImagefiltermeanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_fill(s : ImagefiltermeanSlice, v : Double) -> ImagefiltermeanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_min(s : ImagefiltermeanSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_slice_max(s : ImagefiltermeanSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_slice_to_string(s : ImagefiltermeanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

