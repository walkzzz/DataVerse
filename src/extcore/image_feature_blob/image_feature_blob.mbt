///===
/// extcore/image_feature_blob

pub(all) struct ImagefeatureblobPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_blob_make_point(x : Double, y : Double) -> ImagefeatureblobPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_blob_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureblobPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeatureblobPoint::x(self : ImagefeatureblobPoint) -> Double { self.x }

pub fn ImagefeatureblobPoint::y(self : ImagefeatureblobPoint) -> Double { self.y }

pub fn ImagefeatureblobPoint::z(self : ImagefeatureblobPoint) -> Double { self.z }

pub fn ImagefeatureblobPoint::label(self : ImagefeatureblobPoint) -> Int { self.label }

pub fn ImagefeatureblobPoint::dist(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeatureblobPoint::add(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeatureblobPoint::sub(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeatureblobPoint::scale(self : ImagefeatureblobPoint, s : Double) -> ImagefeatureblobPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeatureblobPoint::dot(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeatureblobPoint::cross(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeatureblobPoint::norm(self : ImagefeatureblobPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeatureblobPoint::normalize(self : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureblobPoint::negate(self : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeatureblobPoint::mid(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeatureblobPoint::lerp(self : ImagefeatureblobPoint, other : ImagefeatureblobPoint, t : Double) -> ImagefeatureblobPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeatureblobPoint::to_string(self : ImagefeatureblobPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeatureblobSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_blob_make_series(vals : Array[Double], name : String) -> ImagefeatureblobSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeatureblobSeries::len(self : ImagefeatureblobSeries) -> Int { self.vals.length() }

pub fn ImagefeatureblobSeries::sum(self : ImagefeatureblobSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeatureblobSeries::mean(self : ImagefeatureblobSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeatureblobSeries::min(self : ImagefeatureblobSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeatureblobSeries::max(self : ImagefeatureblobSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeatureblobSeries::range(self : ImagefeatureblobSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeatureblobSeries::variance(self : ImagefeatureblobSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeatureblobSeries::std(self : ImagefeatureblobSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeatureblobSeries::median(self : ImagefeatureblobSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeatureblobSeries::scale(self : ImagefeatureblobSeries, f : Double) -> ImagefeatureblobSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeatureblobSeries::add(self : ImagefeatureblobSeries, other : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeatureblobSeries::sub(self : ImagefeatureblobSeries, other : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeatureblobSeries::normalize(self : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeatureblobSeries::cumsum(self : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeatureblobSeries::to_string(self : ImagefeatureblobSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureblobMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_blob_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureblobMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_blob_matrix_identity(n : Int) -> ImagefeatureblobMatrix {
  let m = image_feature_blob_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeatureblobMatrix::get(self : ImagefeatureblobMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeatureblobMatrix::transpose(self : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  let result = image_feature_blob_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeatureblobMatrix::add(self : ImagefeatureblobMatrix, other : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_blob_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeatureblobMatrix::scale(self : ImagefeatureblobMatrix, s : Double) -> ImagefeatureblobMatrix {
  let result = image_feature_blob_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeatureblobMatrix::multiply(self : ImagefeatureblobMatrix, other : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  if self.cols != other.rows { return image_feature_blob_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_blob_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeatureblobMatrix::trace(self : ImagefeatureblobMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeatureblobMatrix::det(self : ImagefeatureblobMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeatureblobMatrix::norm(self : ImagefeatureblobMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeatureblobMatrix::to_string(self : ImagefeatureblobMatrix) -> String {
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

pub(all) struct ImagefeatureblobVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_blob_make_vector(comps : Array[Double]) -> ImagefeatureblobVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_blob_vector_zero(dim : Int) -> ImagefeatureblobVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeatureblobVector::add(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureblobVector::sub(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureblobVector::scale(self : ImagefeatureblobVector, s : Double) -> ImagefeatureblobVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeatureblobVector::dot(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeatureblobVector::norm(self : ImagefeatureblobVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeatureblobVector::normalize(self : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureblobVector::dist(self : ImagefeatureblobVector, other : ImagefeatureblobVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeatureblobVector::to_string(self : ImagefeatureblobVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_blob_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_blob_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_blob_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_blob_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_blob_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_blob_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_blob_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_blob_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_blob_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_blob_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_blob_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_blob_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_blob_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_blob_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_blob_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_blob_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_blob_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_blob_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_blob_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_blob_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_blob_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_blob_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_blob_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_blob_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_blob_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_blob_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_blob_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_blob_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_blob_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeatureblobFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_frame_make(size : Int) -> ImagefeatureblobFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_frame_len(s : ImagefeatureblobFrame) -> Int { s.size }

pub fn image_feature_blob_frame_get(s : ImagefeatureblobFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_frame_set(s : ImagefeatureblobFrame, i : Int, v : Double) -> ImagefeatureblobFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_frame_sum(s : ImagefeatureblobFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_frame_mean(s : ImagefeatureblobFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_frame_scale(s : ImagefeatureblobFrame, f : Double) -> ImagefeatureblobFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_frame_add(a : ImagefeatureblobFrame, b : ImagefeatureblobFrame) -> ImagefeatureblobFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_frame_copy(s : ImagefeatureblobFrame) -> ImagefeatureblobFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_frame_fill(s : ImagefeatureblobFrame, v : Double) -> ImagefeatureblobFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_frame_min(s : ImagefeatureblobFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_frame_max(s : ImagefeatureblobFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_frame_to_string(s : ImagefeatureblobFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_table_make(size : Int) -> ImagefeatureblobTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_table_len(s : ImagefeatureblobTable) -> Int { s.size }

pub fn image_feature_blob_table_get(s : ImagefeatureblobTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_table_set(s : ImagefeatureblobTable, i : Int, v : Double) -> ImagefeatureblobTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_table_sum(s : ImagefeatureblobTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_table_mean(s : ImagefeatureblobTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_table_scale(s : ImagefeatureblobTable, f : Double) -> ImagefeatureblobTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_table_add(a : ImagefeatureblobTable, b : ImagefeatureblobTable) -> ImagefeatureblobTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_table_copy(s : ImagefeatureblobTable) -> ImagefeatureblobTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_table_fill(s : ImagefeatureblobTable, v : Double) -> ImagefeatureblobTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_table_min(s : ImagefeatureblobTable) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_table_max(s : ImagefeatureblobTable) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_table_to_string(s : ImagefeatureblobTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_graphn_make(size : Int) -> ImagefeatureblobGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_graphn_len(s : ImagefeatureblobGraphN) -> Int { s.size }

pub fn image_feature_blob_graphn_get(s : ImagefeatureblobGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_graphn_set(s : ImagefeatureblobGraphN, i : Int, v : Double) -> ImagefeatureblobGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_graphn_sum(s : ImagefeatureblobGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_graphn_mean(s : ImagefeatureblobGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_graphn_scale(s : ImagefeatureblobGraphN, f : Double) -> ImagefeatureblobGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_graphn_add(a : ImagefeatureblobGraphN, b : ImagefeatureblobGraphN) -> ImagefeatureblobGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_graphn_copy(s : ImagefeatureblobGraphN) -> ImagefeatureblobGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_graphn_fill(s : ImagefeatureblobGraphN, v : Double) -> ImagefeatureblobGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_graphn_min(s : ImagefeatureblobGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_graphn_max(s : ImagefeatureblobGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_graphn_to_string(s : ImagefeatureblobGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_node_make(size : Int) -> ImagefeatureblobNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_node_len(s : ImagefeatureblobNode) -> Int { s.size }

pub fn image_feature_blob_node_get(s : ImagefeatureblobNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_node_set(s : ImagefeatureblobNode, i : Int, v : Double) -> ImagefeatureblobNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_node_sum(s : ImagefeatureblobNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_node_mean(s : ImagefeatureblobNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_node_scale(s : ImagefeatureblobNode, f : Double) -> ImagefeatureblobNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_node_add(a : ImagefeatureblobNode, b : ImagefeatureblobNode) -> ImagefeatureblobNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_node_copy(s : ImagefeatureblobNode) -> ImagefeatureblobNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_node_fill(s : ImagefeatureblobNode, v : Double) -> ImagefeatureblobNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_node_min(s : ImagefeatureblobNode) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_node_max(s : ImagefeatureblobNode) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_node_to_string(s : ImagefeatureblobNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_edge_make(size : Int) -> ImagefeatureblobEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_edge_len(s : ImagefeatureblobEdge) -> Int { s.size }

pub fn image_feature_blob_edge_get(s : ImagefeatureblobEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_edge_set(s : ImagefeatureblobEdge, i : Int, v : Double) -> ImagefeatureblobEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_edge_sum(s : ImagefeatureblobEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_edge_mean(s : ImagefeatureblobEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_edge_scale(s : ImagefeatureblobEdge, f : Double) -> ImagefeatureblobEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_edge_add(a : ImagefeatureblobEdge, b : ImagefeatureblobEdge) -> ImagefeatureblobEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_edge_copy(s : ImagefeatureblobEdge) -> ImagefeatureblobEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_edge_fill(s : ImagefeatureblobEdge, v : Double) -> ImagefeatureblobEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_edge_min(s : ImagefeatureblobEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_edge_max(s : ImagefeatureblobEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_edge_to_string(s : ImagefeatureblobEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_path_make(size : Int) -> ImagefeatureblobPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_path_len(s : ImagefeatureblobPath) -> Int { s.size }

pub fn image_feature_blob_path_get(s : ImagefeatureblobPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_path_set(s : ImagefeatureblobPath, i : Int, v : Double) -> ImagefeatureblobPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_path_sum(s : ImagefeatureblobPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_path_mean(s : ImagefeatureblobPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_path_scale(s : ImagefeatureblobPath, f : Double) -> ImagefeatureblobPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_path_add(a : ImagefeatureblobPath, b : ImagefeatureblobPath) -> ImagefeatureblobPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_path_copy(s : ImagefeatureblobPath) -> ImagefeatureblobPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_path_fill(s : ImagefeatureblobPath, v : Double) -> ImagefeatureblobPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_path_min(s : ImagefeatureblobPath) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_path_max(s : ImagefeatureblobPath) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_path_to_string(s : ImagefeatureblobPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_cluster_make(size : Int) -> ImagefeatureblobCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_cluster_len(s : ImagefeatureblobCluster) -> Int { s.size }

pub fn image_feature_blob_cluster_get(s : ImagefeatureblobCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_cluster_set(s : ImagefeatureblobCluster, i : Int, v : Double) -> ImagefeatureblobCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cluster_sum(s : ImagefeatureblobCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_cluster_mean(s : ImagefeatureblobCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_cluster_scale(s : ImagefeatureblobCluster, f : Double) -> ImagefeatureblobCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cluster_add(a : ImagefeatureblobCluster, b : ImagefeatureblobCluster) -> ImagefeatureblobCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_cluster_copy(s : ImagefeatureblobCluster) -> ImagefeatureblobCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cluster_fill(s : ImagefeatureblobCluster, v : Double) -> ImagefeatureblobCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cluster_min(s : ImagefeatureblobCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_cluster_max(s : ImagefeatureblobCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_cluster_to_string(s : ImagefeatureblobCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_model_make(size : Int) -> ImagefeatureblobModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_model_len(s : ImagefeatureblobModel) -> Int { s.size }

pub fn image_feature_blob_model_get(s : ImagefeatureblobModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_model_set(s : ImagefeatureblobModel, i : Int, v : Double) -> ImagefeatureblobModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_model_sum(s : ImagefeatureblobModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_model_mean(s : ImagefeatureblobModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_model_scale(s : ImagefeatureblobModel, f : Double) -> ImagefeatureblobModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_model_add(a : ImagefeatureblobModel, b : ImagefeatureblobModel) -> ImagefeatureblobModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_model_copy(s : ImagefeatureblobModel) -> ImagefeatureblobModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_model_fill(s : ImagefeatureblobModel, v : Double) -> ImagefeatureblobModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_model_min(s : ImagefeatureblobModel) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_model_max(s : ImagefeatureblobModel) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_model_to_string(s : ImagefeatureblobModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_layer_make(size : Int) -> ImagefeatureblobLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_layer_len(s : ImagefeatureblobLayer) -> Int { s.size }

pub fn image_feature_blob_layer_get(s : ImagefeatureblobLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_layer_set(s : ImagefeatureblobLayer, i : Int, v : Double) -> ImagefeatureblobLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_layer_sum(s : ImagefeatureblobLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_layer_mean(s : ImagefeatureblobLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_layer_scale(s : ImagefeatureblobLayer, f : Double) -> ImagefeatureblobLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_layer_add(a : ImagefeatureblobLayer, b : ImagefeatureblobLayer) -> ImagefeatureblobLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_layer_copy(s : ImagefeatureblobLayer) -> ImagefeatureblobLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_layer_fill(s : ImagefeatureblobLayer, v : Double) -> ImagefeatureblobLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_layer_min(s : ImagefeatureblobLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_layer_max(s : ImagefeatureblobLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_layer_to_string(s : ImagefeatureblobLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_buffer_make(size : Int) -> ImagefeatureblobBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_buffer_len(s : ImagefeatureblobBuffer) -> Int { s.size }

pub fn image_feature_blob_buffer_get(s : ImagefeatureblobBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_buffer_set(s : ImagefeatureblobBuffer, i : Int, v : Double) -> ImagefeatureblobBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_buffer_sum(s : ImagefeatureblobBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_buffer_mean(s : ImagefeatureblobBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_buffer_scale(s : ImagefeatureblobBuffer, f : Double) -> ImagefeatureblobBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_buffer_add(a : ImagefeatureblobBuffer, b : ImagefeatureblobBuffer) -> ImagefeatureblobBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_buffer_copy(s : ImagefeatureblobBuffer) -> ImagefeatureblobBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_buffer_fill(s : ImagefeatureblobBuffer, v : Double) -> ImagefeatureblobBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_buffer_min(s : ImagefeatureblobBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_buffer_max(s : ImagefeatureblobBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_buffer_to_string(s : ImagefeatureblobBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_cursor_make(size : Int) -> ImagefeatureblobCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_cursor_len(s : ImagefeatureblobCursor) -> Int { s.size }

pub fn image_feature_blob_cursor_get(s : ImagefeatureblobCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_cursor_set(s : ImagefeatureblobCursor, i : Int, v : Double) -> ImagefeatureblobCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cursor_sum(s : ImagefeatureblobCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_cursor_mean(s : ImagefeatureblobCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_cursor_scale(s : ImagefeatureblobCursor, f : Double) -> ImagefeatureblobCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cursor_add(a : ImagefeatureblobCursor, b : ImagefeatureblobCursor) -> ImagefeatureblobCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_cursor_copy(s : ImagefeatureblobCursor) -> ImagefeatureblobCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cursor_fill(s : ImagefeatureblobCursor, v : Double) -> ImagefeatureblobCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_cursor_min(s : ImagefeatureblobCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_cursor_max(s : ImagefeatureblobCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_cursor_to_string(s : ImagefeatureblobCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_view_make(size : Int) -> ImagefeatureblobView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_view_len(s : ImagefeatureblobView) -> Int { s.size }

pub fn image_feature_blob_view_get(s : ImagefeatureblobView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_view_set(s : ImagefeatureblobView, i : Int, v : Double) -> ImagefeatureblobView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_view_sum(s : ImagefeatureblobView) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_view_mean(s : ImagefeatureblobView) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_view_scale(s : ImagefeatureblobView, f : Double) -> ImagefeatureblobView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_view_add(a : ImagefeatureblobView, b : ImagefeatureblobView) -> ImagefeatureblobView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_view_copy(s : ImagefeatureblobView) -> ImagefeatureblobView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_view_fill(s : ImagefeatureblobView, v : Double) -> ImagefeatureblobView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_view_min(s : ImagefeatureblobView) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_view_max(s : ImagefeatureblobView) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_view_to_string(s : ImagefeatureblobView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_range_make(size : Int) -> ImagefeatureblobRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_range_len(s : ImagefeatureblobRange) -> Int { s.size }

pub fn image_feature_blob_range_get(s : ImagefeatureblobRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_range_set(s : ImagefeatureblobRange, i : Int, v : Double) -> ImagefeatureblobRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_range_sum(s : ImagefeatureblobRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_range_mean(s : ImagefeatureblobRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_range_scale(s : ImagefeatureblobRange, f : Double) -> ImagefeatureblobRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_range_add(a : ImagefeatureblobRange, b : ImagefeatureblobRange) -> ImagefeatureblobRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_range_copy(s : ImagefeatureblobRange) -> ImagefeatureblobRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_range_fill(s : ImagefeatureblobRange, v : Double) -> ImagefeatureblobRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_range_min(s : ImagefeatureblobRange) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_range_max(s : ImagefeatureblobRange) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_range_to_string(s : ImagefeatureblobRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_slice_make(size : Int) -> ImagefeatureblobSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_slice_len(s : ImagefeatureblobSlice) -> Int { s.size }

pub fn image_feature_blob_slice_get(s : ImagefeatureblobSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_slice_set(s : ImagefeatureblobSlice, i : Int, v : Double) -> ImagefeatureblobSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_blob_slice_sum(s : ImagefeatureblobSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_blob_slice_mean(s : ImagefeatureblobSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_blob_slice_scale(s : ImagefeatureblobSlice, f : Double) -> ImagefeatureblobSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_slice_add(a : ImagefeatureblobSlice, b : ImagefeatureblobSlice) -> ImagefeatureblobSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_blob_slice_copy(s : ImagefeatureblobSlice) -> ImagefeatureblobSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_slice_fill(s : ImagefeatureblobSlice, v : Double) -> ImagefeatureblobSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_blob_slice_min(s : ImagefeatureblobSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_blob_slice_max(s : ImagefeatureblobSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_blob_slice_to_string(s : ImagefeatureblobSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

