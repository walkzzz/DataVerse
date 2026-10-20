///===
/// extcore/image_transform_flip

pub(all) struct ImagetransformflipPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_flip_make_point(x : Double, y : Double) -> ImagetransformflipPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_flip_make_point3(x : Double, y : Double, z : Double) -> ImagetransformflipPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformflipPoint::x(self : ImagetransformflipPoint) -> Double { self.x }

pub fn ImagetransformflipPoint::y(self : ImagetransformflipPoint) -> Double { self.y }

pub fn ImagetransformflipPoint::z(self : ImagetransformflipPoint) -> Double { self.z }

pub fn ImagetransformflipPoint::label(self : ImagetransformflipPoint) -> Int { self.label }

pub fn ImagetransformflipPoint::dist(self : ImagetransformflipPoint, other : ImagetransformflipPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformflipPoint::add(self : ImagetransformflipPoint, other : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformflipPoint::sub(self : ImagetransformflipPoint, other : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformflipPoint::scale(self : ImagetransformflipPoint, s : Double) -> ImagetransformflipPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformflipPoint::dot(self : ImagetransformflipPoint, other : ImagetransformflipPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformflipPoint::cross(self : ImagetransformflipPoint, other : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformflipPoint::norm(self : ImagetransformflipPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformflipPoint::normalize(self : ImagetransformflipPoint) -> ImagetransformflipPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformflipPoint::negate(self : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformflipPoint::mid(self : ImagetransformflipPoint, other : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformflipPoint::lerp(self : ImagetransformflipPoint, other : ImagetransformflipPoint, t : Double) -> ImagetransformflipPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformflipPoint::to_string(self : ImagetransformflipPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformflipSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_flip_make_series(vals : Array[Double], name : String) -> ImagetransformflipSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformflipSeries::len(self : ImagetransformflipSeries) -> Int { self.vals.length() }

pub fn ImagetransformflipSeries::sum(self : ImagetransformflipSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformflipSeries::mean(self : ImagetransformflipSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformflipSeries::min(self : ImagetransformflipSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformflipSeries::max(self : ImagetransformflipSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformflipSeries::range(self : ImagetransformflipSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformflipSeries::variance(self : ImagetransformflipSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformflipSeries::std(self : ImagetransformflipSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformflipSeries::median(self : ImagetransformflipSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformflipSeries::scale(self : ImagetransformflipSeries, f : Double) -> ImagetransformflipSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformflipSeries::add(self : ImagetransformflipSeries, other : ImagetransformflipSeries) -> ImagetransformflipSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformflipSeries::sub(self : ImagetransformflipSeries, other : ImagetransformflipSeries) -> ImagetransformflipSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformflipSeries::normalize(self : ImagetransformflipSeries) -> ImagetransformflipSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformflipSeries::cumsum(self : ImagetransformflipSeries) -> ImagetransformflipSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformflipSeries::to_string(self : ImagetransformflipSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformflipMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_flip_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformflipMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_flip_matrix_identity(n : Int) -> ImagetransformflipMatrix {
  let m = image_transform_flip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformflipMatrix::get(self : ImagetransformflipMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformflipMatrix::transpose(self : ImagetransformflipMatrix) -> ImagetransformflipMatrix {
  let result = image_transform_flip_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformflipMatrix::add(self : ImagetransformflipMatrix, other : ImagetransformflipMatrix) -> ImagetransformflipMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_flip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformflipMatrix::scale(self : ImagetransformflipMatrix, s : Double) -> ImagetransformflipMatrix {
  let result = image_transform_flip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformflipMatrix::multiply(self : ImagetransformflipMatrix, other : ImagetransformflipMatrix) -> ImagetransformflipMatrix {
  if self.cols != other.rows { return image_transform_flip_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_flip_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformflipMatrix::trace(self : ImagetransformflipMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformflipMatrix::det(self : ImagetransformflipMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformflipMatrix::norm(self : ImagetransformflipMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformflipMatrix::to_string(self : ImagetransformflipMatrix) -> String {
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

pub(all) struct ImagetransformflipVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_flip_make_vector(comps : Array[Double]) -> ImagetransformflipVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_flip_vector_zero(dim : Int) -> ImagetransformflipVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformflipVector::add(self : ImagetransformflipVector, other : ImagetransformflipVector) -> ImagetransformflipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformflipVector::sub(self : ImagetransformflipVector, other : ImagetransformflipVector) -> ImagetransformflipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformflipVector::scale(self : ImagetransformflipVector, s : Double) -> ImagetransformflipVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformflipVector::dot(self : ImagetransformflipVector, other : ImagetransformflipVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformflipVector::norm(self : ImagetransformflipVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformflipVector::normalize(self : ImagetransformflipVector) -> ImagetransformflipVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformflipVector::dist(self : ImagetransformflipVector, other : ImagetransformflipVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformflipVector::to_string(self : ImagetransformflipVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_flip_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_flip_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_flip_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_flip_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_flip_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_flip_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_flip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_flip_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_flip_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_flip_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_flip_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_flip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_flip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_flip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_flip_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_flip_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_flip_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_flip_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_flip_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_flip_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_flip_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_flip_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_flip_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_flip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_flip_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_flip_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_flip_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_flip_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_flip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformflipFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_frame_make(size : Int) -> ImagetransformflipFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_frame_len(s : ImagetransformflipFrame) -> Int { s.size }

pub fn image_transform_flip_frame_get(s : ImagetransformflipFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_frame_set(s : ImagetransformflipFrame, i : Int, v : Double) -> ImagetransformflipFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_frame_sum(s : ImagetransformflipFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_frame_mean(s : ImagetransformflipFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_frame_scale(s : ImagetransformflipFrame, f : Double) -> ImagetransformflipFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_frame_add(a : ImagetransformflipFrame, b : ImagetransformflipFrame) -> ImagetransformflipFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_frame_copy(s : ImagetransformflipFrame) -> ImagetransformflipFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_frame_fill(s : ImagetransformflipFrame, v : Double) -> ImagetransformflipFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_frame_min(s : ImagetransformflipFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_frame_max(s : ImagetransformflipFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_frame_to_string(s : ImagetransformflipFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_table_make(size : Int) -> ImagetransformflipTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_table_len(s : ImagetransformflipTable) -> Int { s.size }

pub fn image_transform_flip_table_get(s : ImagetransformflipTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_table_set(s : ImagetransformflipTable, i : Int, v : Double) -> ImagetransformflipTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_table_sum(s : ImagetransformflipTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_table_mean(s : ImagetransformflipTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_table_scale(s : ImagetransformflipTable, f : Double) -> ImagetransformflipTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_table_add(a : ImagetransformflipTable, b : ImagetransformflipTable) -> ImagetransformflipTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_table_copy(s : ImagetransformflipTable) -> ImagetransformflipTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_table_fill(s : ImagetransformflipTable, v : Double) -> ImagetransformflipTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_table_min(s : ImagetransformflipTable) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_table_max(s : ImagetransformflipTable) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_table_to_string(s : ImagetransformflipTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_graphn_make(size : Int) -> ImagetransformflipGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_graphn_len(s : ImagetransformflipGraphN) -> Int { s.size }

pub fn image_transform_flip_graphn_get(s : ImagetransformflipGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_graphn_set(s : ImagetransformflipGraphN, i : Int, v : Double) -> ImagetransformflipGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_graphn_sum(s : ImagetransformflipGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_graphn_mean(s : ImagetransformflipGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_graphn_scale(s : ImagetransformflipGraphN, f : Double) -> ImagetransformflipGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_graphn_add(a : ImagetransformflipGraphN, b : ImagetransformflipGraphN) -> ImagetransformflipGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_graphn_copy(s : ImagetransformflipGraphN) -> ImagetransformflipGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_graphn_fill(s : ImagetransformflipGraphN, v : Double) -> ImagetransformflipGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_graphn_min(s : ImagetransformflipGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_graphn_max(s : ImagetransformflipGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_graphn_to_string(s : ImagetransformflipGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_node_make(size : Int) -> ImagetransformflipNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_node_len(s : ImagetransformflipNode) -> Int { s.size }

pub fn image_transform_flip_node_get(s : ImagetransformflipNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_node_set(s : ImagetransformflipNode, i : Int, v : Double) -> ImagetransformflipNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_node_sum(s : ImagetransformflipNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_node_mean(s : ImagetransformflipNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_node_scale(s : ImagetransformflipNode, f : Double) -> ImagetransformflipNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_node_add(a : ImagetransformflipNode, b : ImagetransformflipNode) -> ImagetransformflipNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_node_copy(s : ImagetransformflipNode) -> ImagetransformflipNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_node_fill(s : ImagetransformflipNode, v : Double) -> ImagetransformflipNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_node_min(s : ImagetransformflipNode) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_node_max(s : ImagetransformflipNode) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_node_to_string(s : ImagetransformflipNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_edge_make(size : Int) -> ImagetransformflipEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_edge_len(s : ImagetransformflipEdge) -> Int { s.size }

pub fn image_transform_flip_edge_get(s : ImagetransformflipEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_edge_set(s : ImagetransformflipEdge, i : Int, v : Double) -> ImagetransformflipEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_edge_sum(s : ImagetransformflipEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_edge_mean(s : ImagetransformflipEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_edge_scale(s : ImagetransformflipEdge, f : Double) -> ImagetransformflipEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_edge_add(a : ImagetransformflipEdge, b : ImagetransformflipEdge) -> ImagetransformflipEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_edge_copy(s : ImagetransformflipEdge) -> ImagetransformflipEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_edge_fill(s : ImagetransformflipEdge, v : Double) -> ImagetransformflipEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_edge_min(s : ImagetransformflipEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_edge_max(s : ImagetransformflipEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_edge_to_string(s : ImagetransformflipEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_path_make(size : Int) -> ImagetransformflipPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_path_len(s : ImagetransformflipPath) -> Int { s.size }

pub fn image_transform_flip_path_get(s : ImagetransformflipPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_path_set(s : ImagetransformflipPath, i : Int, v : Double) -> ImagetransformflipPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_path_sum(s : ImagetransformflipPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_path_mean(s : ImagetransformflipPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_path_scale(s : ImagetransformflipPath, f : Double) -> ImagetransformflipPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_path_add(a : ImagetransformflipPath, b : ImagetransformflipPath) -> ImagetransformflipPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_path_copy(s : ImagetransformflipPath) -> ImagetransformflipPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_path_fill(s : ImagetransformflipPath, v : Double) -> ImagetransformflipPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_path_min(s : ImagetransformflipPath) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_path_max(s : ImagetransformflipPath) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_path_to_string(s : ImagetransformflipPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_cluster_make(size : Int) -> ImagetransformflipCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_cluster_len(s : ImagetransformflipCluster) -> Int { s.size }

pub fn image_transform_flip_cluster_get(s : ImagetransformflipCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_cluster_set(s : ImagetransformflipCluster, i : Int, v : Double) -> ImagetransformflipCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cluster_sum(s : ImagetransformflipCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_cluster_mean(s : ImagetransformflipCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_cluster_scale(s : ImagetransformflipCluster, f : Double) -> ImagetransformflipCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cluster_add(a : ImagetransformflipCluster, b : ImagetransformflipCluster) -> ImagetransformflipCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_cluster_copy(s : ImagetransformflipCluster) -> ImagetransformflipCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cluster_fill(s : ImagetransformflipCluster, v : Double) -> ImagetransformflipCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cluster_min(s : ImagetransformflipCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_cluster_max(s : ImagetransformflipCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_cluster_to_string(s : ImagetransformflipCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_model_make(size : Int) -> ImagetransformflipModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_model_len(s : ImagetransformflipModel) -> Int { s.size }

pub fn image_transform_flip_model_get(s : ImagetransformflipModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_model_set(s : ImagetransformflipModel, i : Int, v : Double) -> ImagetransformflipModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_model_sum(s : ImagetransformflipModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_model_mean(s : ImagetransformflipModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_model_scale(s : ImagetransformflipModel, f : Double) -> ImagetransformflipModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_model_add(a : ImagetransformflipModel, b : ImagetransformflipModel) -> ImagetransformflipModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_model_copy(s : ImagetransformflipModel) -> ImagetransformflipModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_model_fill(s : ImagetransformflipModel, v : Double) -> ImagetransformflipModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_model_min(s : ImagetransformflipModel) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_model_max(s : ImagetransformflipModel) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_model_to_string(s : ImagetransformflipModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_layer_make(size : Int) -> ImagetransformflipLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_layer_len(s : ImagetransformflipLayer) -> Int { s.size }

pub fn image_transform_flip_layer_get(s : ImagetransformflipLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_layer_set(s : ImagetransformflipLayer, i : Int, v : Double) -> ImagetransformflipLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_layer_sum(s : ImagetransformflipLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_layer_mean(s : ImagetransformflipLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_layer_scale(s : ImagetransformflipLayer, f : Double) -> ImagetransformflipLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_layer_add(a : ImagetransformflipLayer, b : ImagetransformflipLayer) -> ImagetransformflipLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_layer_copy(s : ImagetransformflipLayer) -> ImagetransformflipLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_layer_fill(s : ImagetransformflipLayer, v : Double) -> ImagetransformflipLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_layer_min(s : ImagetransformflipLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_layer_max(s : ImagetransformflipLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_layer_to_string(s : ImagetransformflipLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_buffer_make(size : Int) -> ImagetransformflipBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_buffer_len(s : ImagetransformflipBuffer) -> Int { s.size }

pub fn image_transform_flip_buffer_get(s : ImagetransformflipBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_buffer_set(s : ImagetransformflipBuffer, i : Int, v : Double) -> ImagetransformflipBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_buffer_sum(s : ImagetransformflipBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_buffer_mean(s : ImagetransformflipBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_buffer_scale(s : ImagetransformflipBuffer, f : Double) -> ImagetransformflipBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_buffer_add(a : ImagetransformflipBuffer, b : ImagetransformflipBuffer) -> ImagetransformflipBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_buffer_copy(s : ImagetransformflipBuffer) -> ImagetransformflipBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_buffer_fill(s : ImagetransformflipBuffer, v : Double) -> ImagetransformflipBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_buffer_min(s : ImagetransformflipBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_buffer_max(s : ImagetransformflipBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_buffer_to_string(s : ImagetransformflipBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_cursor_make(size : Int) -> ImagetransformflipCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_cursor_len(s : ImagetransformflipCursor) -> Int { s.size }

pub fn image_transform_flip_cursor_get(s : ImagetransformflipCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_cursor_set(s : ImagetransformflipCursor, i : Int, v : Double) -> ImagetransformflipCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cursor_sum(s : ImagetransformflipCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_cursor_mean(s : ImagetransformflipCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_cursor_scale(s : ImagetransformflipCursor, f : Double) -> ImagetransformflipCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cursor_add(a : ImagetransformflipCursor, b : ImagetransformflipCursor) -> ImagetransformflipCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_cursor_copy(s : ImagetransformflipCursor) -> ImagetransformflipCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cursor_fill(s : ImagetransformflipCursor, v : Double) -> ImagetransformflipCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_cursor_min(s : ImagetransformflipCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_cursor_max(s : ImagetransformflipCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_cursor_to_string(s : ImagetransformflipCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_view_make(size : Int) -> ImagetransformflipView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_view_len(s : ImagetransformflipView) -> Int { s.size }

pub fn image_transform_flip_view_get(s : ImagetransformflipView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_view_set(s : ImagetransformflipView, i : Int, v : Double) -> ImagetransformflipView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_view_sum(s : ImagetransformflipView) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_view_mean(s : ImagetransformflipView) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_view_scale(s : ImagetransformflipView, f : Double) -> ImagetransformflipView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_view_add(a : ImagetransformflipView, b : ImagetransformflipView) -> ImagetransformflipView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_view_copy(s : ImagetransformflipView) -> ImagetransformflipView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_view_fill(s : ImagetransformflipView, v : Double) -> ImagetransformflipView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_view_min(s : ImagetransformflipView) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_view_max(s : ImagetransformflipView) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_view_to_string(s : ImagetransformflipView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_range_make(size : Int) -> ImagetransformflipRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_range_len(s : ImagetransformflipRange) -> Int { s.size }

pub fn image_transform_flip_range_get(s : ImagetransformflipRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_range_set(s : ImagetransformflipRange, i : Int, v : Double) -> ImagetransformflipRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_range_sum(s : ImagetransformflipRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_range_mean(s : ImagetransformflipRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_range_scale(s : ImagetransformflipRange, f : Double) -> ImagetransformflipRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_range_add(a : ImagetransformflipRange, b : ImagetransformflipRange) -> ImagetransformflipRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_range_copy(s : ImagetransformflipRange) -> ImagetransformflipRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_range_fill(s : ImagetransformflipRange, v : Double) -> ImagetransformflipRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_range_min(s : ImagetransformflipRange) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_range_max(s : ImagetransformflipRange) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_range_to_string(s : ImagetransformflipRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_slice_make(size : Int) -> ImagetransformflipSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_slice_len(s : ImagetransformflipSlice) -> Int { s.size }

pub fn image_transform_flip_slice_get(s : ImagetransformflipSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_slice_set(s : ImagetransformflipSlice, i : Int, v : Double) -> ImagetransformflipSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_flip_slice_sum(s : ImagetransformflipSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_slice_mean(s : ImagetransformflipSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_slice_scale(s : ImagetransformflipSlice, f : Double) -> ImagetransformflipSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_slice_add(a : ImagetransformflipSlice, b : ImagetransformflipSlice) -> ImagetransformflipSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_flip_slice_copy(s : ImagetransformflipSlice) -> ImagetransformflipSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_slice_fill(s : ImagetransformflipSlice, v : Double) -> ImagetransformflipSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_flip_slice_min(s : ImagetransformflipSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_slice_max(s : ImagetransformflipSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_slice_to_string(s : ImagetransformflipSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

