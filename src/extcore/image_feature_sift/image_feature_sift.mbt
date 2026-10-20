///===
/// extcore/image_feature_sift

pub(all) struct ImagefeaturesiftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_sift_make_point(x : Double, y : Double) -> ImagefeaturesiftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_sift_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturesiftPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturesiftPoint::x(self : ImagefeaturesiftPoint) -> Double { self.x }

pub fn ImagefeaturesiftPoint::y(self : ImagefeaturesiftPoint) -> Double { self.y }

pub fn ImagefeaturesiftPoint::z(self : ImagefeaturesiftPoint) -> Double { self.z }

pub fn ImagefeaturesiftPoint::label(self : ImagefeaturesiftPoint) -> Int { self.label }

pub fn ImagefeaturesiftPoint::dist(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturesiftPoint::add(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturesiftPoint::sub(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturesiftPoint::scale(self : ImagefeaturesiftPoint, s : Double) -> ImagefeaturesiftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturesiftPoint::dot(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturesiftPoint::cross(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturesiftPoint::norm(self : ImagefeaturesiftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturesiftPoint::normalize(self : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesiftPoint::negate(self : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturesiftPoint::mid(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturesiftPoint::lerp(self : ImagefeaturesiftPoint, other : ImagefeaturesiftPoint, t : Double) -> ImagefeaturesiftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturesiftPoint::to_string(self : ImagefeaturesiftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturesiftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_sift_make_series(vals : Array[Double], name : String) -> ImagefeaturesiftSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturesiftSeries::len(self : ImagefeaturesiftSeries) -> Int { self.vals.length() }

pub fn ImagefeaturesiftSeries::sum(self : ImagefeaturesiftSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturesiftSeries::mean(self : ImagefeaturesiftSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturesiftSeries::min(self : ImagefeaturesiftSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturesiftSeries::max(self : ImagefeaturesiftSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturesiftSeries::range(self : ImagefeaturesiftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturesiftSeries::variance(self : ImagefeaturesiftSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturesiftSeries::std(self : ImagefeaturesiftSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturesiftSeries::median(self : ImagefeaturesiftSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturesiftSeries::scale(self : ImagefeaturesiftSeries, f : Double) -> ImagefeaturesiftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturesiftSeries::add(self : ImagefeaturesiftSeries, other : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturesiftSeries::sub(self : ImagefeaturesiftSeries, other : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturesiftSeries::normalize(self : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturesiftSeries::cumsum(self : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturesiftSeries::to_string(self : ImagefeaturesiftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesiftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_sift_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturesiftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_sift_matrix_identity(n : Int) -> ImagefeaturesiftMatrix {
  let m = image_feature_sift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturesiftMatrix::get(self : ImagefeaturesiftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturesiftMatrix::transpose(self : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  let result = image_feature_sift_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturesiftMatrix::add(self : ImagefeaturesiftMatrix, other : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_sift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturesiftMatrix::scale(self : ImagefeaturesiftMatrix, s : Double) -> ImagefeaturesiftMatrix {
  let result = image_feature_sift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturesiftMatrix::multiply(self : ImagefeaturesiftMatrix, other : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  if self.cols != other.rows { return image_feature_sift_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_sift_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturesiftMatrix::trace(self : ImagefeaturesiftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturesiftMatrix::det(self : ImagefeaturesiftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturesiftMatrix::norm(self : ImagefeaturesiftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturesiftMatrix::to_string(self : ImagefeaturesiftMatrix) -> String {
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

pub(all) struct ImagefeaturesiftVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_sift_make_vector(comps : Array[Double]) -> ImagefeaturesiftVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_sift_vector_zero(dim : Int) -> ImagefeaturesiftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturesiftVector::add(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesiftVector::sub(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesiftVector::scale(self : ImagefeaturesiftVector, s : Double) -> ImagefeaturesiftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturesiftVector::dot(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturesiftVector::norm(self : ImagefeaturesiftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturesiftVector::normalize(self : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesiftVector::dist(self : ImagefeaturesiftVector, other : ImagefeaturesiftVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturesiftVector::to_string(self : ImagefeaturesiftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_sift_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_sift_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_sift_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_sift_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_sift_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_sift_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_sift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_sift_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_sift_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_sift_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_sift_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_sift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_sift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_sift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_sift_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_sift_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_sift_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_sift_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_sift_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_sift_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_sift_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_sift_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_sift_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_sift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_sift_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_sift_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_sift_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_sift_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_sift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturesiftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_frame_make(size : Int) -> ImagefeaturesiftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_frame_len(s : ImagefeaturesiftFrame) -> Int { s.size }

pub fn image_feature_sift_frame_get(s : ImagefeaturesiftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_frame_set(s : ImagefeaturesiftFrame, i : Int, v : Double) -> ImagefeaturesiftFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_frame_sum(s : ImagefeaturesiftFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_frame_mean(s : ImagefeaturesiftFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_frame_scale(s : ImagefeaturesiftFrame, f : Double) -> ImagefeaturesiftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_frame_add(a : ImagefeaturesiftFrame, b : ImagefeaturesiftFrame) -> ImagefeaturesiftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_frame_copy(s : ImagefeaturesiftFrame) -> ImagefeaturesiftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_frame_fill(s : ImagefeaturesiftFrame, v : Double) -> ImagefeaturesiftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_frame_min(s : ImagefeaturesiftFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_frame_max(s : ImagefeaturesiftFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_frame_to_string(s : ImagefeaturesiftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_table_make(size : Int) -> ImagefeaturesiftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_table_len(s : ImagefeaturesiftTable) -> Int { s.size }

pub fn image_feature_sift_table_get(s : ImagefeaturesiftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_table_set(s : ImagefeaturesiftTable, i : Int, v : Double) -> ImagefeaturesiftTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_table_sum(s : ImagefeaturesiftTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_table_mean(s : ImagefeaturesiftTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_table_scale(s : ImagefeaturesiftTable, f : Double) -> ImagefeaturesiftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_table_add(a : ImagefeaturesiftTable, b : ImagefeaturesiftTable) -> ImagefeaturesiftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_table_copy(s : ImagefeaturesiftTable) -> ImagefeaturesiftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_table_fill(s : ImagefeaturesiftTable, v : Double) -> ImagefeaturesiftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_table_min(s : ImagefeaturesiftTable) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_table_max(s : ImagefeaturesiftTable) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_table_to_string(s : ImagefeaturesiftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_graphn_make(size : Int) -> ImagefeaturesiftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_graphn_len(s : ImagefeaturesiftGraphN) -> Int { s.size }

pub fn image_feature_sift_graphn_get(s : ImagefeaturesiftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_graphn_set(s : ImagefeaturesiftGraphN, i : Int, v : Double) -> ImagefeaturesiftGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_graphn_sum(s : ImagefeaturesiftGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_graphn_mean(s : ImagefeaturesiftGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_graphn_scale(s : ImagefeaturesiftGraphN, f : Double) -> ImagefeaturesiftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_graphn_add(a : ImagefeaturesiftGraphN, b : ImagefeaturesiftGraphN) -> ImagefeaturesiftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_graphn_copy(s : ImagefeaturesiftGraphN) -> ImagefeaturesiftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_graphn_fill(s : ImagefeaturesiftGraphN, v : Double) -> ImagefeaturesiftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_graphn_min(s : ImagefeaturesiftGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_graphn_max(s : ImagefeaturesiftGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_graphn_to_string(s : ImagefeaturesiftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_node_make(size : Int) -> ImagefeaturesiftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_node_len(s : ImagefeaturesiftNode) -> Int { s.size }

pub fn image_feature_sift_node_get(s : ImagefeaturesiftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_node_set(s : ImagefeaturesiftNode, i : Int, v : Double) -> ImagefeaturesiftNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_node_sum(s : ImagefeaturesiftNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_node_mean(s : ImagefeaturesiftNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_node_scale(s : ImagefeaturesiftNode, f : Double) -> ImagefeaturesiftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_node_add(a : ImagefeaturesiftNode, b : ImagefeaturesiftNode) -> ImagefeaturesiftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_node_copy(s : ImagefeaturesiftNode) -> ImagefeaturesiftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_node_fill(s : ImagefeaturesiftNode, v : Double) -> ImagefeaturesiftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_node_min(s : ImagefeaturesiftNode) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_node_max(s : ImagefeaturesiftNode) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_node_to_string(s : ImagefeaturesiftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_edge_make(size : Int) -> ImagefeaturesiftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_edge_len(s : ImagefeaturesiftEdge) -> Int { s.size }

pub fn image_feature_sift_edge_get(s : ImagefeaturesiftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_edge_set(s : ImagefeaturesiftEdge, i : Int, v : Double) -> ImagefeaturesiftEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_edge_sum(s : ImagefeaturesiftEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_edge_mean(s : ImagefeaturesiftEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_edge_scale(s : ImagefeaturesiftEdge, f : Double) -> ImagefeaturesiftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_edge_add(a : ImagefeaturesiftEdge, b : ImagefeaturesiftEdge) -> ImagefeaturesiftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_edge_copy(s : ImagefeaturesiftEdge) -> ImagefeaturesiftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_edge_fill(s : ImagefeaturesiftEdge, v : Double) -> ImagefeaturesiftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_edge_min(s : ImagefeaturesiftEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_edge_max(s : ImagefeaturesiftEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_edge_to_string(s : ImagefeaturesiftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_path_make(size : Int) -> ImagefeaturesiftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_path_len(s : ImagefeaturesiftPath) -> Int { s.size }

pub fn image_feature_sift_path_get(s : ImagefeaturesiftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_path_set(s : ImagefeaturesiftPath, i : Int, v : Double) -> ImagefeaturesiftPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_path_sum(s : ImagefeaturesiftPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_path_mean(s : ImagefeaturesiftPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_path_scale(s : ImagefeaturesiftPath, f : Double) -> ImagefeaturesiftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_path_add(a : ImagefeaturesiftPath, b : ImagefeaturesiftPath) -> ImagefeaturesiftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_path_copy(s : ImagefeaturesiftPath) -> ImagefeaturesiftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_path_fill(s : ImagefeaturesiftPath, v : Double) -> ImagefeaturesiftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_path_min(s : ImagefeaturesiftPath) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_path_max(s : ImagefeaturesiftPath) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_path_to_string(s : ImagefeaturesiftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_cluster_make(size : Int) -> ImagefeaturesiftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_cluster_len(s : ImagefeaturesiftCluster) -> Int { s.size }

pub fn image_feature_sift_cluster_get(s : ImagefeaturesiftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_cluster_set(s : ImagefeaturesiftCluster, i : Int, v : Double) -> ImagefeaturesiftCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cluster_sum(s : ImagefeaturesiftCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_cluster_mean(s : ImagefeaturesiftCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_cluster_scale(s : ImagefeaturesiftCluster, f : Double) -> ImagefeaturesiftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cluster_add(a : ImagefeaturesiftCluster, b : ImagefeaturesiftCluster) -> ImagefeaturesiftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_cluster_copy(s : ImagefeaturesiftCluster) -> ImagefeaturesiftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cluster_fill(s : ImagefeaturesiftCluster, v : Double) -> ImagefeaturesiftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cluster_min(s : ImagefeaturesiftCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_cluster_max(s : ImagefeaturesiftCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_cluster_to_string(s : ImagefeaturesiftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_model_make(size : Int) -> ImagefeaturesiftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_model_len(s : ImagefeaturesiftModel) -> Int { s.size }

pub fn image_feature_sift_model_get(s : ImagefeaturesiftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_model_set(s : ImagefeaturesiftModel, i : Int, v : Double) -> ImagefeaturesiftModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_model_sum(s : ImagefeaturesiftModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_model_mean(s : ImagefeaturesiftModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_model_scale(s : ImagefeaturesiftModel, f : Double) -> ImagefeaturesiftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_model_add(a : ImagefeaturesiftModel, b : ImagefeaturesiftModel) -> ImagefeaturesiftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_model_copy(s : ImagefeaturesiftModel) -> ImagefeaturesiftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_model_fill(s : ImagefeaturesiftModel, v : Double) -> ImagefeaturesiftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_model_min(s : ImagefeaturesiftModel) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_model_max(s : ImagefeaturesiftModel) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_model_to_string(s : ImagefeaturesiftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_layer_make(size : Int) -> ImagefeaturesiftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_layer_len(s : ImagefeaturesiftLayer) -> Int { s.size }

pub fn image_feature_sift_layer_get(s : ImagefeaturesiftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_layer_set(s : ImagefeaturesiftLayer, i : Int, v : Double) -> ImagefeaturesiftLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_layer_sum(s : ImagefeaturesiftLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_layer_mean(s : ImagefeaturesiftLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_layer_scale(s : ImagefeaturesiftLayer, f : Double) -> ImagefeaturesiftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_layer_add(a : ImagefeaturesiftLayer, b : ImagefeaturesiftLayer) -> ImagefeaturesiftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_layer_copy(s : ImagefeaturesiftLayer) -> ImagefeaturesiftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_layer_fill(s : ImagefeaturesiftLayer, v : Double) -> ImagefeaturesiftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_layer_min(s : ImagefeaturesiftLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_layer_max(s : ImagefeaturesiftLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_layer_to_string(s : ImagefeaturesiftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_buffer_make(size : Int) -> ImagefeaturesiftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_buffer_len(s : ImagefeaturesiftBuffer) -> Int { s.size }

pub fn image_feature_sift_buffer_get(s : ImagefeaturesiftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_buffer_set(s : ImagefeaturesiftBuffer, i : Int, v : Double) -> ImagefeaturesiftBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_buffer_sum(s : ImagefeaturesiftBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_buffer_mean(s : ImagefeaturesiftBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_buffer_scale(s : ImagefeaturesiftBuffer, f : Double) -> ImagefeaturesiftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_buffer_add(a : ImagefeaturesiftBuffer, b : ImagefeaturesiftBuffer) -> ImagefeaturesiftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_buffer_copy(s : ImagefeaturesiftBuffer) -> ImagefeaturesiftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_buffer_fill(s : ImagefeaturesiftBuffer, v : Double) -> ImagefeaturesiftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_buffer_min(s : ImagefeaturesiftBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_buffer_max(s : ImagefeaturesiftBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_buffer_to_string(s : ImagefeaturesiftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_cursor_make(size : Int) -> ImagefeaturesiftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_cursor_len(s : ImagefeaturesiftCursor) -> Int { s.size }

pub fn image_feature_sift_cursor_get(s : ImagefeaturesiftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_cursor_set(s : ImagefeaturesiftCursor, i : Int, v : Double) -> ImagefeaturesiftCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cursor_sum(s : ImagefeaturesiftCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_cursor_mean(s : ImagefeaturesiftCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_cursor_scale(s : ImagefeaturesiftCursor, f : Double) -> ImagefeaturesiftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cursor_add(a : ImagefeaturesiftCursor, b : ImagefeaturesiftCursor) -> ImagefeaturesiftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_cursor_copy(s : ImagefeaturesiftCursor) -> ImagefeaturesiftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cursor_fill(s : ImagefeaturesiftCursor, v : Double) -> ImagefeaturesiftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_cursor_min(s : ImagefeaturesiftCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_cursor_max(s : ImagefeaturesiftCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_cursor_to_string(s : ImagefeaturesiftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_view_make(size : Int) -> ImagefeaturesiftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_view_len(s : ImagefeaturesiftView) -> Int { s.size }

pub fn image_feature_sift_view_get(s : ImagefeaturesiftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_view_set(s : ImagefeaturesiftView, i : Int, v : Double) -> ImagefeaturesiftView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_view_sum(s : ImagefeaturesiftView) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_view_mean(s : ImagefeaturesiftView) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_view_scale(s : ImagefeaturesiftView, f : Double) -> ImagefeaturesiftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_view_add(a : ImagefeaturesiftView, b : ImagefeaturesiftView) -> ImagefeaturesiftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_view_copy(s : ImagefeaturesiftView) -> ImagefeaturesiftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_view_fill(s : ImagefeaturesiftView, v : Double) -> ImagefeaturesiftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_view_min(s : ImagefeaturesiftView) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_view_max(s : ImagefeaturesiftView) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_view_to_string(s : ImagefeaturesiftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_range_make(size : Int) -> ImagefeaturesiftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_range_len(s : ImagefeaturesiftRange) -> Int { s.size }

pub fn image_feature_sift_range_get(s : ImagefeaturesiftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_range_set(s : ImagefeaturesiftRange, i : Int, v : Double) -> ImagefeaturesiftRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_range_sum(s : ImagefeaturesiftRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_range_mean(s : ImagefeaturesiftRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_range_scale(s : ImagefeaturesiftRange, f : Double) -> ImagefeaturesiftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_range_add(a : ImagefeaturesiftRange, b : ImagefeaturesiftRange) -> ImagefeaturesiftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_range_copy(s : ImagefeaturesiftRange) -> ImagefeaturesiftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_range_fill(s : ImagefeaturesiftRange, v : Double) -> ImagefeaturesiftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_range_min(s : ImagefeaturesiftRange) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_range_max(s : ImagefeaturesiftRange) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_range_to_string(s : ImagefeaturesiftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_slice_make(size : Int) -> ImagefeaturesiftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_slice_len(s : ImagefeaturesiftSlice) -> Int { s.size }

pub fn image_feature_sift_slice_get(s : ImagefeaturesiftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_slice_set(s : ImagefeaturesiftSlice, i : Int, v : Double) -> ImagefeaturesiftSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_sift_slice_sum(s : ImagefeaturesiftSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_sift_slice_mean(s : ImagefeaturesiftSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_sift_slice_scale(s : ImagefeaturesiftSlice, f : Double) -> ImagefeaturesiftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_slice_add(a : ImagefeaturesiftSlice, b : ImagefeaturesiftSlice) -> ImagefeaturesiftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_sift_slice_copy(s : ImagefeaturesiftSlice) -> ImagefeaturesiftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_slice_fill(s : ImagefeaturesiftSlice, v : Double) -> ImagefeaturesiftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_sift_slice_min(s : ImagefeaturesiftSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_sift_slice_max(s : ImagefeaturesiftSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_sift_slice_to_string(s : ImagefeaturesiftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

