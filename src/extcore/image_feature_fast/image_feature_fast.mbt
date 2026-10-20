///===
/// extcore/image_feature_fast

pub(all) struct ImagefeaturefastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_fast_make_point(x : Double, y : Double) -> ImagefeaturefastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_fast_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturefastPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturefastPoint::x(self : ImagefeaturefastPoint) -> Double { self.x }

pub fn ImagefeaturefastPoint::y(self : ImagefeaturefastPoint) -> Double { self.y }

pub fn ImagefeaturefastPoint::z(self : ImagefeaturefastPoint) -> Double { self.z }

pub fn ImagefeaturefastPoint::label(self : ImagefeaturefastPoint) -> Int { self.label }

pub fn ImagefeaturefastPoint::dist(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturefastPoint::add(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturefastPoint::sub(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturefastPoint::scale(self : ImagefeaturefastPoint, s : Double) -> ImagefeaturefastPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturefastPoint::dot(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturefastPoint::cross(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturefastPoint::norm(self : ImagefeaturefastPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturefastPoint::normalize(self : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturefastPoint::negate(self : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturefastPoint::mid(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturefastPoint::lerp(self : ImagefeaturefastPoint, other : ImagefeaturefastPoint, t : Double) -> ImagefeaturefastPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturefastPoint::to_string(self : ImagefeaturefastPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturefastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_fast_make_series(vals : Array[Double], name : String) -> ImagefeaturefastSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturefastSeries::len(self : ImagefeaturefastSeries) -> Int { self.vals.length() }

pub fn ImagefeaturefastSeries::sum(self : ImagefeaturefastSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturefastSeries::mean(self : ImagefeaturefastSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturefastSeries::min(self : ImagefeaturefastSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturefastSeries::max(self : ImagefeaturefastSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturefastSeries::range(self : ImagefeaturefastSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturefastSeries::variance(self : ImagefeaturefastSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturefastSeries::std(self : ImagefeaturefastSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturefastSeries::median(self : ImagefeaturefastSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturefastSeries::scale(self : ImagefeaturefastSeries, f : Double) -> ImagefeaturefastSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturefastSeries::add(self : ImagefeaturefastSeries, other : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturefastSeries::sub(self : ImagefeaturefastSeries, other : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturefastSeries::normalize(self : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturefastSeries::cumsum(self : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturefastSeries::to_string(self : ImagefeaturefastSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturefastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_fast_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturefastMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_fast_matrix_identity(n : Int) -> ImagefeaturefastMatrix {
  let m = image_feature_fast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturefastMatrix::get(self : ImagefeaturefastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturefastMatrix::transpose(self : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  let result = image_feature_fast_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturefastMatrix::add(self : ImagefeaturefastMatrix, other : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_fast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturefastMatrix::scale(self : ImagefeaturefastMatrix, s : Double) -> ImagefeaturefastMatrix {
  let result = image_feature_fast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturefastMatrix::multiply(self : ImagefeaturefastMatrix, other : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  if self.cols != other.rows { return image_feature_fast_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_fast_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturefastMatrix::trace(self : ImagefeaturefastMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturefastMatrix::det(self : ImagefeaturefastMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturefastMatrix::norm(self : ImagefeaturefastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturefastMatrix::to_string(self : ImagefeaturefastMatrix) -> String {
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

pub(all) struct ImagefeaturefastVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_fast_make_vector(comps : Array[Double]) -> ImagefeaturefastVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_fast_vector_zero(dim : Int) -> ImagefeaturefastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturefastVector::add(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturefastVector::sub(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturefastVector::scale(self : ImagefeaturefastVector, s : Double) -> ImagefeaturefastVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturefastVector::dot(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturefastVector::norm(self : ImagefeaturefastVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturefastVector::normalize(self : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturefastVector::dist(self : ImagefeaturefastVector, other : ImagefeaturefastVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturefastVector::to_string(self : ImagefeaturefastVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_fast_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_fast_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_fast_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_fast_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_fast_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_fast_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_fast_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_fast_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_fast_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_fast_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_fast_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_fast_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_fast_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_fast_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_fast_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_fast_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_fast_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_fast_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_fast_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_fast_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_fast_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_fast_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_fast_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_fast_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_fast_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_fast_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_fast_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_fast_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_fast_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturefastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_frame_make(size : Int) -> ImagefeaturefastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_frame_len(s : ImagefeaturefastFrame) -> Int { s.size }

pub fn image_feature_fast_frame_get(s : ImagefeaturefastFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_frame_set(s : ImagefeaturefastFrame, i : Int, v : Double) -> ImagefeaturefastFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_frame_sum(s : ImagefeaturefastFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_frame_mean(s : ImagefeaturefastFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_frame_scale(s : ImagefeaturefastFrame, f : Double) -> ImagefeaturefastFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_frame_add(a : ImagefeaturefastFrame, b : ImagefeaturefastFrame) -> ImagefeaturefastFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_frame_copy(s : ImagefeaturefastFrame) -> ImagefeaturefastFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_frame_fill(s : ImagefeaturefastFrame, v : Double) -> ImagefeaturefastFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_frame_min(s : ImagefeaturefastFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_frame_max(s : ImagefeaturefastFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_frame_to_string(s : ImagefeaturefastFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_table_make(size : Int) -> ImagefeaturefastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_table_len(s : ImagefeaturefastTable) -> Int { s.size }

pub fn image_feature_fast_table_get(s : ImagefeaturefastTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_table_set(s : ImagefeaturefastTable, i : Int, v : Double) -> ImagefeaturefastTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_table_sum(s : ImagefeaturefastTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_table_mean(s : ImagefeaturefastTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_table_scale(s : ImagefeaturefastTable, f : Double) -> ImagefeaturefastTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_table_add(a : ImagefeaturefastTable, b : ImagefeaturefastTable) -> ImagefeaturefastTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_table_copy(s : ImagefeaturefastTable) -> ImagefeaturefastTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_table_fill(s : ImagefeaturefastTable, v : Double) -> ImagefeaturefastTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_table_min(s : ImagefeaturefastTable) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_table_max(s : ImagefeaturefastTable) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_table_to_string(s : ImagefeaturefastTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_graphn_make(size : Int) -> ImagefeaturefastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_graphn_len(s : ImagefeaturefastGraphN) -> Int { s.size }

pub fn image_feature_fast_graphn_get(s : ImagefeaturefastGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_graphn_set(s : ImagefeaturefastGraphN, i : Int, v : Double) -> ImagefeaturefastGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_graphn_sum(s : ImagefeaturefastGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_graphn_mean(s : ImagefeaturefastGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_graphn_scale(s : ImagefeaturefastGraphN, f : Double) -> ImagefeaturefastGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_graphn_add(a : ImagefeaturefastGraphN, b : ImagefeaturefastGraphN) -> ImagefeaturefastGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_graphn_copy(s : ImagefeaturefastGraphN) -> ImagefeaturefastGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_graphn_fill(s : ImagefeaturefastGraphN, v : Double) -> ImagefeaturefastGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_graphn_min(s : ImagefeaturefastGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_graphn_max(s : ImagefeaturefastGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_graphn_to_string(s : ImagefeaturefastGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_node_make(size : Int) -> ImagefeaturefastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_node_len(s : ImagefeaturefastNode) -> Int { s.size }

pub fn image_feature_fast_node_get(s : ImagefeaturefastNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_node_set(s : ImagefeaturefastNode, i : Int, v : Double) -> ImagefeaturefastNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_node_sum(s : ImagefeaturefastNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_node_mean(s : ImagefeaturefastNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_node_scale(s : ImagefeaturefastNode, f : Double) -> ImagefeaturefastNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_node_add(a : ImagefeaturefastNode, b : ImagefeaturefastNode) -> ImagefeaturefastNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_node_copy(s : ImagefeaturefastNode) -> ImagefeaturefastNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_node_fill(s : ImagefeaturefastNode, v : Double) -> ImagefeaturefastNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_node_min(s : ImagefeaturefastNode) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_node_max(s : ImagefeaturefastNode) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_node_to_string(s : ImagefeaturefastNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_edge_make(size : Int) -> ImagefeaturefastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_edge_len(s : ImagefeaturefastEdge) -> Int { s.size }

pub fn image_feature_fast_edge_get(s : ImagefeaturefastEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_edge_set(s : ImagefeaturefastEdge, i : Int, v : Double) -> ImagefeaturefastEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_edge_sum(s : ImagefeaturefastEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_edge_mean(s : ImagefeaturefastEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_edge_scale(s : ImagefeaturefastEdge, f : Double) -> ImagefeaturefastEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_edge_add(a : ImagefeaturefastEdge, b : ImagefeaturefastEdge) -> ImagefeaturefastEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_edge_copy(s : ImagefeaturefastEdge) -> ImagefeaturefastEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_edge_fill(s : ImagefeaturefastEdge, v : Double) -> ImagefeaturefastEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_edge_min(s : ImagefeaturefastEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_edge_max(s : ImagefeaturefastEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_edge_to_string(s : ImagefeaturefastEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_path_make(size : Int) -> ImagefeaturefastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_path_len(s : ImagefeaturefastPath) -> Int { s.size }

pub fn image_feature_fast_path_get(s : ImagefeaturefastPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_path_set(s : ImagefeaturefastPath, i : Int, v : Double) -> ImagefeaturefastPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_path_sum(s : ImagefeaturefastPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_path_mean(s : ImagefeaturefastPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_path_scale(s : ImagefeaturefastPath, f : Double) -> ImagefeaturefastPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_path_add(a : ImagefeaturefastPath, b : ImagefeaturefastPath) -> ImagefeaturefastPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_path_copy(s : ImagefeaturefastPath) -> ImagefeaturefastPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_path_fill(s : ImagefeaturefastPath, v : Double) -> ImagefeaturefastPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_path_min(s : ImagefeaturefastPath) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_path_max(s : ImagefeaturefastPath) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_path_to_string(s : ImagefeaturefastPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_cluster_make(size : Int) -> ImagefeaturefastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_cluster_len(s : ImagefeaturefastCluster) -> Int { s.size }

pub fn image_feature_fast_cluster_get(s : ImagefeaturefastCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_cluster_set(s : ImagefeaturefastCluster, i : Int, v : Double) -> ImagefeaturefastCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cluster_sum(s : ImagefeaturefastCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_cluster_mean(s : ImagefeaturefastCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_cluster_scale(s : ImagefeaturefastCluster, f : Double) -> ImagefeaturefastCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cluster_add(a : ImagefeaturefastCluster, b : ImagefeaturefastCluster) -> ImagefeaturefastCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_cluster_copy(s : ImagefeaturefastCluster) -> ImagefeaturefastCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cluster_fill(s : ImagefeaturefastCluster, v : Double) -> ImagefeaturefastCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cluster_min(s : ImagefeaturefastCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_cluster_max(s : ImagefeaturefastCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_cluster_to_string(s : ImagefeaturefastCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_model_make(size : Int) -> ImagefeaturefastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_model_len(s : ImagefeaturefastModel) -> Int { s.size }

pub fn image_feature_fast_model_get(s : ImagefeaturefastModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_model_set(s : ImagefeaturefastModel, i : Int, v : Double) -> ImagefeaturefastModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_model_sum(s : ImagefeaturefastModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_model_mean(s : ImagefeaturefastModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_model_scale(s : ImagefeaturefastModel, f : Double) -> ImagefeaturefastModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_model_add(a : ImagefeaturefastModel, b : ImagefeaturefastModel) -> ImagefeaturefastModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_model_copy(s : ImagefeaturefastModel) -> ImagefeaturefastModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_model_fill(s : ImagefeaturefastModel, v : Double) -> ImagefeaturefastModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_model_min(s : ImagefeaturefastModel) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_model_max(s : ImagefeaturefastModel) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_model_to_string(s : ImagefeaturefastModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_layer_make(size : Int) -> ImagefeaturefastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_layer_len(s : ImagefeaturefastLayer) -> Int { s.size }

pub fn image_feature_fast_layer_get(s : ImagefeaturefastLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_layer_set(s : ImagefeaturefastLayer, i : Int, v : Double) -> ImagefeaturefastLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_layer_sum(s : ImagefeaturefastLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_layer_mean(s : ImagefeaturefastLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_layer_scale(s : ImagefeaturefastLayer, f : Double) -> ImagefeaturefastLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_layer_add(a : ImagefeaturefastLayer, b : ImagefeaturefastLayer) -> ImagefeaturefastLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_layer_copy(s : ImagefeaturefastLayer) -> ImagefeaturefastLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_layer_fill(s : ImagefeaturefastLayer, v : Double) -> ImagefeaturefastLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_layer_min(s : ImagefeaturefastLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_layer_max(s : ImagefeaturefastLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_layer_to_string(s : ImagefeaturefastLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_buffer_make(size : Int) -> ImagefeaturefastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_buffer_len(s : ImagefeaturefastBuffer) -> Int { s.size }

pub fn image_feature_fast_buffer_get(s : ImagefeaturefastBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_buffer_set(s : ImagefeaturefastBuffer, i : Int, v : Double) -> ImagefeaturefastBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_buffer_sum(s : ImagefeaturefastBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_buffer_mean(s : ImagefeaturefastBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_buffer_scale(s : ImagefeaturefastBuffer, f : Double) -> ImagefeaturefastBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_buffer_add(a : ImagefeaturefastBuffer, b : ImagefeaturefastBuffer) -> ImagefeaturefastBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_buffer_copy(s : ImagefeaturefastBuffer) -> ImagefeaturefastBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_buffer_fill(s : ImagefeaturefastBuffer, v : Double) -> ImagefeaturefastBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_buffer_min(s : ImagefeaturefastBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_buffer_max(s : ImagefeaturefastBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_buffer_to_string(s : ImagefeaturefastBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_cursor_make(size : Int) -> ImagefeaturefastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_cursor_len(s : ImagefeaturefastCursor) -> Int { s.size }

pub fn image_feature_fast_cursor_get(s : ImagefeaturefastCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_cursor_set(s : ImagefeaturefastCursor, i : Int, v : Double) -> ImagefeaturefastCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cursor_sum(s : ImagefeaturefastCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_cursor_mean(s : ImagefeaturefastCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_cursor_scale(s : ImagefeaturefastCursor, f : Double) -> ImagefeaturefastCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cursor_add(a : ImagefeaturefastCursor, b : ImagefeaturefastCursor) -> ImagefeaturefastCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_cursor_copy(s : ImagefeaturefastCursor) -> ImagefeaturefastCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cursor_fill(s : ImagefeaturefastCursor, v : Double) -> ImagefeaturefastCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_cursor_min(s : ImagefeaturefastCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_cursor_max(s : ImagefeaturefastCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_cursor_to_string(s : ImagefeaturefastCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_view_make(size : Int) -> ImagefeaturefastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_view_len(s : ImagefeaturefastView) -> Int { s.size }

pub fn image_feature_fast_view_get(s : ImagefeaturefastView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_view_set(s : ImagefeaturefastView, i : Int, v : Double) -> ImagefeaturefastView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_view_sum(s : ImagefeaturefastView) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_view_mean(s : ImagefeaturefastView) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_view_scale(s : ImagefeaturefastView, f : Double) -> ImagefeaturefastView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_view_add(a : ImagefeaturefastView, b : ImagefeaturefastView) -> ImagefeaturefastView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_view_copy(s : ImagefeaturefastView) -> ImagefeaturefastView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_view_fill(s : ImagefeaturefastView, v : Double) -> ImagefeaturefastView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_view_min(s : ImagefeaturefastView) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_view_max(s : ImagefeaturefastView) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_view_to_string(s : ImagefeaturefastView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_range_make(size : Int) -> ImagefeaturefastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_range_len(s : ImagefeaturefastRange) -> Int { s.size }

pub fn image_feature_fast_range_get(s : ImagefeaturefastRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_range_set(s : ImagefeaturefastRange, i : Int, v : Double) -> ImagefeaturefastRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_range_sum(s : ImagefeaturefastRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_range_mean(s : ImagefeaturefastRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_range_scale(s : ImagefeaturefastRange, f : Double) -> ImagefeaturefastRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_range_add(a : ImagefeaturefastRange, b : ImagefeaturefastRange) -> ImagefeaturefastRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_range_copy(s : ImagefeaturefastRange) -> ImagefeaturefastRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_range_fill(s : ImagefeaturefastRange, v : Double) -> ImagefeaturefastRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_range_min(s : ImagefeaturefastRange) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_range_max(s : ImagefeaturefastRange) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_range_to_string(s : ImagefeaturefastRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_slice_make(size : Int) -> ImagefeaturefastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_slice_len(s : ImagefeaturefastSlice) -> Int { s.size }

pub fn image_feature_fast_slice_get(s : ImagefeaturefastSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_slice_set(s : ImagefeaturefastSlice, i : Int, v : Double) -> ImagefeaturefastSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_fast_slice_sum(s : ImagefeaturefastSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_fast_slice_mean(s : ImagefeaturefastSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_fast_slice_scale(s : ImagefeaturefastSlice, f : Double) -> ImagefeaturefastSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_slice_add(a : ImagefeaturefastSlice, b : ImagefeaturefastSlice) -> ImagefeaturefastSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_fast_slice_copy(s : ImagefeaturefastSlice) -> ImagefeaturefastSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_slice_fill(s : ImagefeaturefastSlice, v : Double) -> ImagefeaturefastSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_fast_slice_min(s : ImagefeaturefastSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_fast_slice_max(s : ImagefeaturefastSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_fast_slice_to_string(s : ImagefeaturefastSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

