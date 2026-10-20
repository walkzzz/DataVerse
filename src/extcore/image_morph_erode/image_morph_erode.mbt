///===
/// extcore/image_morph_erode

pub(all) struct ImagemorpherodePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_erode_make_point(x : Double, y : Double) -> ImagemorpherodePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_erode_make_point3(x : Double, y : Double, z : Double) -> ImagemorpherodePoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorpherodePoint::x(self : ImagemorpherodePoint) -> Double { self.x }

pub fn ImagemorpherodePoint::y(self : ImagemorpherodePoint) -> Double { self.y }

pub fn ImagemorpherodePoint::z(self : ImagemorpherodePoint) -> Double { self.z }

pub fn ImagemorpherodePoint::label(self : ImagemorpherodePoint) -> Int { self.label }

pub fn ImagemorpherodePoint::dist(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorpherodePoint::add(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorpherodePoint::sub(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorpherodePoint::scale(self : ImagemorpherodePoint, s : Double) -> ImagemorpherodePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorpherodePoint::dot(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorpherodePoint::cross(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorpherodePoint::norm(self : ImagemorpherodePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorpherodePoint::normalize(self : ImagemorpherodePoint) -> ImagemorpherodePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorpherodePoint::negate(self : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorpherodePoint::mid(self : ImagemorpherodePoint, other : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorpherodePoint::lerp(self : ImagemorpherodePoint, other : ImagemorpherodePoint, t : Double) -> ImagemorpherodePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorpherodePoint::to_string(self : ImagemorpherodePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorpherodeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_erode_make_series(vals : Array[Double], name : String) -> ImagemorpherodeSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorpherodeSeries::len(self : ImagemorpherodeSeries) -> Int { self.vals.length() }

pub fn ImagemorpherodeSeries::sum(self : ImagemorpherodeSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorpherodeSeries::mean(self : ImagemorpherodeSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorpherodeSeries::min(self : ImagemorpherodeSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorpherodeSeries::max(self : ImagemorpherodeSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorpherodeSeries::range(self : ImagemorpherodeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorpherodeSeries::variance(self : ImagemorpherodeSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorpherodeSeries::std(self : ImagemorpherodeSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorpherodeSeries::median(self : ImagemorpherodeSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorpherodeSeries::scale(self : ImagemorpherodeSeries, f : Double) -> ImagemorpherodeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorpherodeSeries::add(self : ImagemorpherodeSeries, other : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorpherodeSeries::sub(self : ImagemorpherodeSeries, other : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorpherodeSeries::normalize(self : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorpherodeSeries::cumsum(self : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorpherodeSeries::to_string(self : ImagemorpherodeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorpherodeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_erode_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorpherodeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_erode_matrix_identity(n : Int) -> ImagemorpherodeMatrix {
  let m = image_morph_erode_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorpherodeMatrix::get(self : ImagemorpherodeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorpherodeMatrix::transpose(self : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  let result = image_morph_erode_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorpherodeMatrix::add(self : ImagemorpherodeMatrix, other : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_erode_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorpherodeMatrix::scale(self : ImagemorpherodeMatrix, s : Double) -> ImagemorpherodeMatrix {
  let result = image_morph_erode_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorpherodeMatrix::multiply(self : ImagemorpherodeMatrix, other : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  if self.cols != other.rows { return image_morph_erode_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_erode_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorpherodeMatrix::trace(self : ImagemorpherodeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorpherodeMatrix::det(self : ImagemorpherodeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorpherodeMatrix::norm(self : ImagemorpherodeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorpherodeMatrix::to_string(self : ImagemorpherodeMatrix) -> String {
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

pub(all) struct ImagemorpherodeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_erode_make_vector(comps : Array[Double]) -> ImagemorpherodeVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_erode_vector_zero(dim : Int) -> ImagemorpherodeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorpherodeVector::add(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorpherodeVector::sub(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorpherodeVector::scale(self : ImagemorpherodeVector, s : Double) -> ImagemorpherodeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorpherodeVector::dot(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorpherodeVector::norm(self : ImagemorpherodeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorpherodeVector::normalize(self : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorpherodeVector::dist(self : ImagemorpherodeVector, other : ImagemorpherodeVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorpherodeVector::to_string(self : ImagemorpherodeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_erode_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_erode_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_erode_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_erode_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_erode_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_erode_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_erode_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_erode_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_erode_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_erode_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_erode_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_erode_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_erode_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_erode_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_erode_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_erode_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_erode_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_erode_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_erode_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_erode_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_erode_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_erode_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_erode_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_erode_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_erode_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_erode_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_erode_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_erode_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_erode_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorpherodeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_frame_make(size : Int) -> ImagemorpherodeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_frame_len(s : ImagemorpherodeFrame) -> Int { s.size }

pub fn image_morph_erode_frame_get(s : ImagemorpherodeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_frame_set(s : ImagemorpherodeFrame, i : Int, v : Double) -> ImagemorpherodeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_frame_sum(s : ImagemorpherodeFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_frame_mean(s : ImagemorpherodeFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_frame_scale(s : ImagemorpherodeFrame, f : Double) -> ImagemorpherodeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_frame_add(a : ImagemorpherodeFrame, b : ImagemorpherodeFrame) -> ImagemorpherodeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_frame_copy(s : ImagemorpherodeFrame) -> ImagemorpherodeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_frame_fill(s : ImagemorpherodeFrame, v : Double) -> ImagemorpherodeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_frame_min(s : ImagemorpherodeFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_frame_max(s : ImagemorpherodeFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_frame_to_string(s : ImagemorpherodeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_table_make(size : Int) -> ImagemorpherodeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_table_len(s : ImagemorpherodeTable) -> Int { s.size }

pub fn image_morph_erode_table_get(s : ImagemorpherodeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_table_set(s : ImagemorpherodeTable, i : Int, v : Double) -> ImagemorpherodeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_table_sum(s : ImagemorpherodeTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_table_mean(s : ImagemorpherodeTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_table_scale(s : ImagemorpherodeTable, f : Double) -> ImagemorpherodeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_table_add(a : ImagemorpherodeTable, b : ImagemorpherodeTable) -> ImagemorpherodeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_table_copy(s : ImagemorpherodeTable) -> ImagemorpherodeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_table_fill(s : ImagemorpherodeTable, v : Double) -> ImagemorpherodeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_table_min(s : ImagemorpherodeTable) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_table_max(s : ImagemorpherodeTable) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_table_to_string(s : ImagemorpherodeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_graphn_make(size : Int) -> ImagemorpherodeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_graphn_len(s : ImagemorpherodeGraphN) -> Int { s.size }

pub fn image_morph_erode_graphn_get(s : ImagemorpherodeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_graphn_set(s : ImagemorpherodeGraphN, i : Int, v : Double) -> ImagemorpherodeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_graphn_sum(s : ImagemorpherodeGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_graphn_mean(s : ImagemorpherodeGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_graphn_scale(s : ImagemorpherodeGraphN, f : Double) -> ImagemorpherodeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_graphn_add(a : ImagemorpherodeGraphN, b : ImagemorpherodeGraphN) -> ImagemorpherodeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_graphn_copy(s : ImagemorpherodeGraphN) -> ImagemorpherodeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_graphn_fill(s : ImagemorpherodeGraphN, v : Double) -> ImagemorpherodeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_graphn_min(s : ImagemorpherodeGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_graphn_max(s : ImagemorpherodeGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_graphn_to_string(s : ImagemorpherodeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_node_make(size : Int) -> ImagemorpherodeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_node_len(s : ImagemorpherodeNode) -> Int { s.size }

pub fn image_morph_erode_node_get(s : ImagemorpherodeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_node_set(s : ImagemorpherodeNode, i : Int, v : Double) -> ImagemorpherodeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_node_sum(s : ImagemorpherodeNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_node_mean(s : ImagemorpherodeNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_node_scale(s : ImagemorpherodeNode, f : Double) -> ImagemorpherodeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_node_add(a : ImagemorpherodeNode, b : ImagemorpherodeNode) -> ImagemorpherodeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_node_copy(s : ImagemorpherodeNode) -> ImagemorpherodeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_node_fill(s : ImagemorpherodeNode, v : Double) -> ImagemorpherodeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_node_min(s : ImagemorpherodeNode) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_node_max(s : ImagemorpherodeNode) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_node_to_string(s : ImagemorpherodeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_edge_make(size : Int) -> ImagemorpherodeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_edge_len(s : ImagemorpherodeEdge) -> Int { s.size }

pub fn image_morph_erode_edge_get(s : ImagemorpherodeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_edge_set(s : ImagemorpherodeEdge, i : Int, v : Double) -> ImagemorpherodeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_edge_sum(s : ImagemorpherodeEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_edge_mean(s : ImagemorpherodeEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_edge_scale(s : ImagemorpherodeEdge, f : Double) -> ImagemorpherodeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_edge_add(a : ImagemorpherodeEdge, b : ImagemorpherodeEdge) -> ImagemorpherodeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_edge_copy(s : ImagemorpherodeEdge) -> ImagemorpherodeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_edge_fill(s : ImagemorpherodeEdge, v : Double) -> ImagemorpherodeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_edge_min(s : ImagemorpherodeEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_edge_max(s : ImagemorpherodeEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_edge_to_string(s : ImagemorpherodeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_path_make(size : Int) -> ImagemorpherodePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_path_len(s : ImagemorpherodePath) -> Int { s.size }

pub fn image_morph_erode_path_get(s : ImagemorpherodePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_path_set(s : ImagemorpherodePath, i : Int, v : Double) -> ImagemorpherodePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_path_sum(s : ImagemorpherodePath) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_path_mean(s : ImagemorpherodePath) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_path_scale(s : ImagemorpherodePath, f : Double) -> ImagemorpherodePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_path_add(a : ImagemorpherodePath, b : ImagemorpherodePath) -> ImagemorpherodePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_path_copy(s : ImagemorpherodePath) -> ImagemorpherodePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_path_fill(s : ImagemorpherodePath, v : Double) -> ImagemorpherodePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_path_min(s : ImagemorpherodePath) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_path_max(s : ImagemorpherodePath) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_path_to_string(s : ImagemorpherodePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_cluster_make(size : Int) -> ImagemorpherodeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_cluster_len(s : ImagemorpherodeCluster) -> Int { s.size }

pub fn image_morph_erode_cluster_get(s : ImagemorpherodeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_cluster_set(s : ImagemorpherodeCluster, i : Int, v : Double) -> ImagemorpherodeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cluster_sum(s : ImagemorpherodeCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_cluster_mean(s : ImagemorpherodeCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_cluster_scale(s : ImagemorpherodeCluster, f : Double) -> ImagemorpherodeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cluster_add(a : ImagemorpherodeCluster, b : ImagemorpherodeCluster) -> ImagemorpherodeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_cluster_copy(s : ImagemorpherodeCluster) -> ImagemorpherodeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cluster_fill(s : ImagemorpherodeCluster, v : Double) -> ImagemorpherodeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cluster_min(s : ImagemorpherodeCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_cluster_max(s : ImagemorpherodeCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_cluster_to_string(s : ImagemorpherodeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_model_make(size : Int) -> ImagemorpherodeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_model_len(s : ImagemorpherodeModel) -> Int { s.size }

pub fn image_morph_erode_model_get(s : ImagemorpherodeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_model_set(s : ImagemorpherodeModel, i : Int, v : Double) -> ImagemorpherodeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_model_sum(s : ImagemorpherodeModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_model_mean(s : ImagemorpherodeModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_model_scale(s : ImagemorpherodeModel, f : Double) -> ImagemorpherodeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_model_add(a : ImagemorpherodeModel, b : ImagemorpherodeModel) -> ImagemorpherodeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_model_copy(s : ImagemorpherodeModel) -> ImagemorpherodeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_model_fill(s : ImagemorpherodeModel, v : Double) -> ImagemorpherodeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_model_min(s : ImagemorpherodeModel) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_model_max(s : ImagemorpherodeModel) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_model_to_string(s : ImagemorpherodeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_layer_make(size : Int) -> ImagemorpherodeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_layer_len(s : ImagemorpherodeLayer) -> Int { s.size }

pub fn image_morph_erode_layer_get(s : ImagemorpherodeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_layer_set(s : ImagemorpherodeLayer, i : Int, v : Double) -> ImagemorpherodeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_layer_sum(s : ImagemorpherodeLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_layer_mean(s : ImagemorpherodeLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_layer_scale(s : ImagemorpherodeLayer, f : Double) -> ImagemorpherodeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_layer_add(a : ImagemorpherodeLayer, b : ImagemorpherodeLayer) -> ImagemorpherodeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_layer_copy(s : ImagemorpherodeLayer) -> ImagemorpherodeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_layer_fill(s : ImagemorpherodeLayer, v : Double) -> ImagemorpherodeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_layer_min(s : ImagemorpherodeLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_layer_max(s : ImagemorpherodeLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_layer_to_string(s : ImagemorpherodeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_buffer_make(size : Int) -> ImagemorpherodeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_buffer_len(s : ImagemorpherodeBuffer) -> Int { s.size }

pub fn image_morph_erode_buffer_get(s : ImagemorpherodeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_buffer_set(s : ImagemorpherodeBuffer, i : Int, v : Double) -> ImagemorpherodeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_buffer_sum(s : ImagemorpherodeBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_buffer_mean(s : ImagemorpherodeBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_buffer_scale(s : ImagemorpherodeBuffer, f : Double) -> ImagemorpherodeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_buffer_add(a : ImagemorpherodeBuffer, b : ImagemorpherodeBuffer) -> ImagemorpherodeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_buffer_copy(s : ImagemorpherodeBuffer) -> ImagemorpherodeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_buffer_fill(s : ImagemorpherodeBuffer, v : Double) -> ImagemorpherodeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_buffer_min(s : ImagemorpherodeBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_buffer_max(s : ImagemorpherodeBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_buffer_to_string(s : ImagemorpherodeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_cursor_make(size : Int) -> ImagemorpherodeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_cursor_len(s : ImagemorpherodeCursor) -> Int { s.size }

pub fn image_morph_erode_cursor_get(s : ImagemorpherodeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_cursor_set(s : ImagemorpherodeCursor, i : Int, v : Double) -> ImagemorpherodeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cursor_sum(s : ImagemorpherodeCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_cursor_mean(s : ImagemorpherodeCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_cursor_scale(s : ImagemorpherodeCursor, f : Double) -> ImagemorpherodeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cursor_add(a : ImagemorpherodeCursor, b : ImagemorpherodeCursor) -> ImagemorpherodeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_cursor_copy(s : ImagemorpherodeCursor) -> ImagemorpherodeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cursor_fill(s : ImagemorpherodeCursor, v : Double) -> ImagemorpherodeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_cursor_min(s : ImagemorpherodeCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_cursor_max(s : ImagemorpherodeCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_cursor_to_string(s : ImagemorpherodeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_view_make(size : Int) -> ImagemorpherodeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_view_len(s : ImagemorpherodeView) -> Int { s.size }

pub fn image_morph_erode_view_get(s : ImagemorpherodeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_view_set(s : ImagemorpherodeView, i : Int, v : Double) -> ImagemorpherodeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_view_sum(s : ImagemorpherodeView) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_view_mean(s : ImagemorpherodeView) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_view_scale(s : ImagemorpherodeView, f : Double) -> ImagemorpherodeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_view_add(a : ImagemorpherodeView, b : ImagemorpherodeView) -> ImagemorpherodeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_view_copy(s : ImagemorpherodeView) -> ImagemorpherodeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_view_fill(s : ImagemorpherodeView, v : Double) -> ImagemorpherodeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_view_min(s : ImagemorpherodeView) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_view_max(s : ImagemorpherodeView) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_view_to_string(s : ImagemorpherodeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_range_make(size : Int) -> ImagemorpherodeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_range_len(s : ImagemorpherodeRange) -> Int { s.size }

pub fn image_morph_erode_range_get(s : ImagemorpherodeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_range_set(s : ImagemorpherodeRange, i : Int, v : Double) -> ImagemorpherodeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_range_sum(s : ImagemorpherodeRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_range_mean(s : ImagemorpherodeRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_range_scale(s : ImagemorpherodeRange, f : Double) -> ImagemorpherodeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_range_add(a : ImagemorpherodeRange, b : ImagemorpherodeRange) -> ImagemorpherodeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_range_copy(s : ImagemorpherodeRange) -> ImagemorpherodeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_range_fill(s : ImagemorpherodeRange, v : Double) -> ImagemorpherodeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_range_min(s : ImagemorpherodeRange) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_range_max(s : ImagemorpherodeRange) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_range_to_string(s : ImagemorpherodeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_slice_make(size : Int) -> ImagemorpherodeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_slice_len(s : ImagemorpherodeSlice) -> Int { s.size }

pub fn image_morph_erode_slice_get(s : ImagemorpherodeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_slice_set(s : ImagemorpherodeSlice, i : Int, v : Double) -> ImagemorpherodeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_erode_slice_sum(s : ImagemorpherodeSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_erode_slice_mean(s : ImagemorpherodeSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_erode_slice_scale(s : ImagemorpherodeSlice, f : Double) -> ImagemorpherodeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_slice_add(a : ImagemorpherodeSlice, b : ImagemorpherodeSlice) -> ImagemorpherodeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_erode_slice_copy(s : ImagemorpherodeSlice) -> ImagemorpherodeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_slice_fill(s : ImagemorpherodeSlice, v : Double) -> ImagemorpherodeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_erode_slice_min(s : ImagemorpherodeSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_erode_slice_max(s : ImagemorpherodeSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_erode_slice_to_string(s : ImagemorpherodeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

