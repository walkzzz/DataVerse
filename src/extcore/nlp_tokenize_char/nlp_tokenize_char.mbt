///===
/// extcore/nlp_tokenize_char

pub(all) struct NlptokenizecharPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_char_make_point(x : Double, y : Double) -> NlptokenizecharPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_char_make_point3(x : Double, y : Double, z : Double) -> NlptokenizecharPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizecharPoint::x(self : NlptokenizecharPoint) -> Double { self.x }

pub fn NlptokenizecharPoint::y(self : NlptokenizecharPoint) -> Double { self.y }

pub fn NlptokenizecharPoint::z(self : NlptokenizecharPoint) -> Double { self.z }

pub fn NlptokenizecharPoint::label(self : NlptokenizecharPoint) -> Int { self.label }

pub fn NlptokenizecharPoint::dist(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizecharPoint::add(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizecharPoint::sub(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizecharPoint::scale(self : NlptokenizecharPoint, s : Double) -> NlptokenizecharPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizecharPoint::dot(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizecharPoint::cross(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizecharPoint::norm(self : NlptokenizecharPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizecharPoint::normalize(self : NlptokenizecharPoint) -> NlptokenizecharPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizecharPoint::negate(self : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizecharPoint::mid(self : NlptokenizecharPoint, other : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizecharPoint::lerp(self : NlptokenizecharPoint, other : NlptokenizecharPoint, t : Double) -> NlptokenizecharPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizecharPoint::to_string(self : NlptokenizecharPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizecharSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_char_make_series(vals : Array[Double], name : String) -> NlptokenizecharSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizecharSeries::len(self : NlptokenizecharSeries) -> Int { self.vals.length() }

pub fn NlptokenizecharSeries::sum(self : NlptokenizecharSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizecharSeries::mean(self : NlptokenizecharSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizecharSeries::min(self : NlptokenizecharSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizecharSeries::max(self : NlptokenizecharSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizecharSeries::range(self : NlptokenizecharSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizecharSeries::variance(self : NlptokenizecharSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizecharSeries::std(self : NlptokenizecharSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizecharSeries::median(self : NlptokenizecharSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizecharSeries::scale(self : NlptokenizecharSeries, f : Double) -> NlptokenizecharSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizecharSeries::add(self : NlptokenizecharSeries, other : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizecharSeries::sub(self : NlptokenizecharSeries, other : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizecharSeries::normalize(self : NlptokenizecharSeries) -> NlptokenizecharSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizecharSeries::cumsum(self : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizecharSeries::to_string(self : NlptokenizecharSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizecharMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_char_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizecharMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_char_matrix_identity(n : Int) -> NlptokenizecharMatrix {
  let m = nlp_tokenize_char_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizecharMatrix::get(self : NlptokenizecharMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizecharMatrix::transpose(self : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  let result = nlp_tokenize_char_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizecharMatrix::add(self : NlptokenizecharMatrix, other : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_char_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizecharMatrix::scale(self : NlptokenizecharMatrix, s : Double) -> NlptokenizecharMatrix {
  let result = nlp_tokenize_char_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizecharMatrix::multiply(self : NlptokenizecharMatrix, other : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  if self.cols != other.rows { return nlp_tokenize_char_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_char_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizecharMatrix::trace(self : NlptokenizecharMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizecharMatrix::det(self : NlptokenizecharMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizecharMatrix::norm(self : NlptokenizecharMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizecharMatrix::to_string(self : NlptokenizecharMatrix) -> String {
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

pub(all) struct NlptokenizecharVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_char_make_vector(comps : Array[Double]) -> NlptokenizecharVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_char_vector_zero(dim : Int) -> NlptokenizecharVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizecharVector::add(self : NlptokenizecharVector, other : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizecharVector::sub(self : NlptokenizecharVector, other : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizecharVector::scale(self : NlptokenizecharVector, s : Double) -> NlptokenizecharVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizecharVector::dot(self : NlptokenizecharVector, other : NlptokenizecharVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizecharVector::norm(self : NlptokenizecharVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizecharVector::normalize(self : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizecharVector::dist(self : NlptokenizecharVector, other : NlptokenizecharVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizecharVector::to_string(self : NlptokenizecharVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_char_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_char_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_char_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_char_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_char_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_char_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_char_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_char_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_char_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_char_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_char_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_char_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_char_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_char_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_char_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_char_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_char_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_char_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_char_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_char_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_char_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_char_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_char_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_char_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_char_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_char_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_char_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_char_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_char_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizecharFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_frame_make(size : Int) -> NlptokenizecharFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_frame_len(s : NlptokenizecharFrame) -> Int { s.size }

pub fn nlp_tokenize_char_frame_get(s : NlptokenizecharFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_frame_set(s : NlptokenizecharFrame, i : Int, v : Double) -> NlptokenizecharFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_frame_sum(s : NlptokenizecharFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_frame_mean(s : NlptokenizecharFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_frame_scale(s : NlptokenizecharFrame, f : Double) -> NlptokenizecharFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_frame_add(a : NlptokenizecharFrame, b : NlptokenizecharFrame) -> NlptokenizecharFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_frame_copy(s : NlptokenizecharFrame) -> NlptokenizecharFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_frame_fill(s : NlptokenizecharFrame, v : Double) -> NlptokenizecharFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_frame_min(s : NlptokenizecharFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_frame_max(s : NlptokenizecharFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_frame_to_string(s : NlptokenizecharFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_table_make(size : Int) -> NlptokenizecharTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_table_len(s : NlptokenizecharTable) -> Int { s.size }

pub fn nlp_tokenize_char_table_get(s : NlptokenizecharTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_table_set(s : NlptokenizecharTable, i : Int, v : Double) -> NlptokenizecharTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_table_sum(s : NlptokenizecharTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_table_mean(s : NlptokenizecharTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_table_scale(s : NlptokenizecharTable, f : Double) -> NlptokenizecharTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_table_add(a : NlptokenizecharTable, b : NlptokenizecharTable) -> NlptokenizecharTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_table_copy(s : NlptokenizecharTable) -> NlptokenizecharTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_table_fill(s : NlptokenizecharTable, v : Double) -> NlptokenizecharTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_table_min(s : NlptokenizecharTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_table_max(s : NlptokenizecharTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_table_to_string(s : NlptokenizecharTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_graphn_make(size : Int) -> NlptokenizecharGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_graphn_len(s : NlptokenizecharGraphN) -> Int { s.size }

pub fn nlp_tokenize_char_graphn_get(s : NlptokenizecharGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_graphn_set(s : NlptokenizecharGraphN, i : Int, v : Double) -> NlptokenizecharGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_graphn_sum(s : NlptokenizecharGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_graphn_mean(s : NlptokenizecharGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_graphn_scale(s : NlptokenizecharGraphN, f : Double) -> NlptokenizecharGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_graphn_add(a : NlptokenizecharGraphN, b : NlptokenizecharGraphN) -> NlptokenizecharGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_graphn_copy(s : NlptokenizecharGraphN) -> NlptokenizecharGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_graphn_fill(s : NlptokenizecharGraphN, v : Double) -> NlptokenizecharGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_graphn_min(s : NlptokenizecharGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_graphn_max(s : NlptokenizecharGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_graphn_to_string(s : NlptokenizecharGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_node_make(size : Int) -> NlptokenizecharNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_node_len(s : NlptokenizecharNode) -> Int { s.size }

pub fn nlp_tokenize_char_node_get(s : NlptokenizecharNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_node_set(s : NlptokenizecharNode, i : Int, v : Double) -> NlptokenizecharNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_node_sum(s : NlptokenizecharNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_node_mean(s : NlptokenizecharNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_node_scale(s : NlptokenizecharNode, f : Double) -> NlptokenizecharNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_node_add(a : NlptokenizecharNode, b : NlptokenizecharNode) -> NlptokenizecharNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_node_copy(s : NlptokenizecharNode) -> NlptokenizecharNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_node_fill(s : NlptokenizecharNode, v : Double) -> NlptokenizecharNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_node_min(s : NlptokenizecharNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_node_max(s : NlptokenizecharNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_node_to_string(s : NlptokenizecharNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_edge_make(size : Int) -> NlptokenizecharEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_edge_len(s : NlptokenizecharEdge) -> Int { s.size }

pub fn nlp_tokenize_char_edge_get(s : NlptokenizecharEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_edge_set(s : NlptokenizecharEdge, i : Int, v : Double) -> NlptokenizecharEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_edge_sum(s : NlptokenizecharEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_edge_mean(s : NlptokenizecharEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_edge_scale(s : NlptokenizecharEdge, f : Double) -> NlptokenizecharEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_edge_add(a : NlptokenizecharEdge, b : NlptokenizecharEdge) -> NlptokenizecharEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_edge_copy(s : NlptokenizecharEdge) -> NlptokenizecharEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_edge_fill(s : NlptokenizecharEdge, v : Double) -> NlptokenizecharEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_edge_min(s : NlptokenizecharEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_edge_max(s : NlptokenizecharEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_edge_to_string(s : NlptokenizecharEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_path_make(size : Int) -> NlptokenizecharPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_path_len(s : NlptokenizecharPath) -> Int { s.size }

pub fn nlp_tokenize_char_path_get(s : NlptokenizecharPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_path_set(s : NlptokenizecharPath, i : Int, v : Double) -> NlptokenizecharPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_path_sum(s : NlptokenizecharPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_path_mean(s : NlptokenizecharPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_path_scale(s : NlptokenizecharPath, f : Double) -> NlptokenizecharPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_path_add(a : NlptokenizecharPath, b : NlptokenizecharPath) -> NlptokenizecharPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_path_copy(s : NlptokenizecharPath) -> NlptokenizecharPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_path_fill(s : NlptokenizecharPath, v : Double) -> NlptokenizecharPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_path_min(s : NlptokenizecharPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_path_max(s : NlptokenizecharPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_path_to_string(s : NlptokenizecharPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_cluster_make(size : Int) -> NlptokenizecharCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_cluster_len(s : NlptokenizecharCluster) -> Int { s.size }

pub fn nlp_tokenize_char_cluster_get(s : NlptokenizecharCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_cluster_set(s : NlptokenizecharCluster, i : Int, v : Double) -> NlptokenizecharCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cluster_sum(s : NlptokenizecharCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_cluster_mean(s : NlptokenizecharCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_cluster_scale(s : NlptokenizecharCluster, f : Double) -> NlptokenizecharCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cluster_add(a : NlptokenizecharCluster, b : NlptokenizecharCluster) -> NlptokenizecharCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_cluster_copy(s : NlptokenizecharCluster) -> NlptokenizecharCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cluster_fill(s : NlptokenizecharCluster, v : Double) -> NlptokenizecharCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cluster_min(s : NlptokenizecharCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_cluster_max(s : NlptokenizecharCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_cluster_to_string(s : NlptokenizecharCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_model_make(size : Int) -> NlptokenizecharModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_model_len(s : NlptokenizecharModel) -> Int { s.size }

pub fn nlp_tokenize_char_model_get(s : NlptokenizecharModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_model_set(s : NlptokenizecharModel, i : Int, v : Double) -> NlptokenizecharModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_model_sum(s : NlptokenizecharModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_model_mean(s : NlptokenizecharModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_model_scale(s : NlptokenizecharModel, f : Double) -> NlptokenizecharModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_model_add(a : NlptokenizecharModel, b : NlptokenizecharModel) -> NlptokenizecharModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_model_copy(s : NlptokenizecharModel) -> NlptokenizecharModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_model_fill(s : NlptokenizecharModel, v : Double) -> NlptokenizecharModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_model_min(s : NlptokenizecharModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_model_max(s : NlptokenizecharModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_model_to_string(s : NlptokenizecharModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_layer_make(size : Int) -> NlptokenizecharLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_layer_len(s : NlptokenizecharLayer) -> Int { s.size }

pub fn nlp_tokenize_char_layer_get(s : NlptokenizecharLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_layer_set(s : NlptokenizecharLayer, i : Int, v : Double) -> NlptokenizecharLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_layer_sum(s : NlptokenizecharLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_layer_mean(s : NlptokenizecharLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_layer_scale(s : NlptokenizecharLayer, f : Double) -> NlptokenizecharLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_layer_add(a : NlptokenizecharLayer, b : NlptokenizecharLayer) -> NlptokenizecharLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_layer_copy(s : NlptokenizecharLayer) -> NlptokenizecharLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_layer_fill(s : NlptokenizecharLayer, v : Double) -> NlptokenizecharLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_layer_min(s : NlptokenizecharLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_layer_max(s : NlptokenizecharLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_layer_to_string(s : NlptokenizecharLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_buffer_make(size : Int) -> NlptokenizecharBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_buffer_len(s : NlptokenizecharBuffer) -> Int { s.size }

pub fn nlp_tokenize_char_buffer_get(s : NlptokenizecharBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_buffer_set(s : NlptokenizecharBuffer, i : Int, v : Double) -> NlptokenizecharBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_buffer_sum(s : NlptokenizecharBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_buffer_mean(s : NlptokenizecharBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_buffer_scale(s : NlptokenizecharBuffer, f : Double) -> NlptokenizecharBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_buffer_add(a : NlptokenizecharBuffer, b : NlptokenizecharBuffer) -> NlptokenizecharBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_buffer_copy(s : NlptokenizecharBuffer) -> NlptokenizecharBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_buffer_fill(s : NlptokenizecharBuffer, v : Double) -> NlptokenizecharBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_buffer_min(s : NlptokenizecharBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_buffer_max(s : NlptokenizecharBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_buffer_to_string(s : NlptokenizecharBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_cursor_make(size : Int) -> NlptokenizecharCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_cursor_len(s : NlptokenizecharCursor) -> Int { s.size }

pub fn nlp_tokenize_char_cursor_get(s : NlptokenizecharCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_cursor_set(s : NlptokenizecharCursor, i : Int, v : Double) -> NlptokenizecharCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cursor_sum(s : NlptokenizecharCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_cursor_mean(s : NlptokenizecharCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_cursor_scale(s : NlptokenizecharCursor, f : Double) -> NlptokenizecharCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cursor_add(a : NlptokenizecharCursor, b : NlptokenizecharCursor) -> NlptokenizecharCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_cursor_copy(s : NlptokenizecharCursor) -> NlptokenizecharCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cursor_fill(s : NlptokenizecharCursor, v : Double) -> NlptokenizecharCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_cursor_min(s : NlptokenizecharCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_cursor_max(s : NlptokenizecharCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_cursor_to_string(s : NlptokenizecharCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_view_make(size : Int) -> NlptokenizecharView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_view_len(s : NlptokenizecharView) -> Int { s.size }

pub fn nlp_tokenize_char_view_get(s : NlptokenizecharView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_view_set(s : NlptokenizecharView, i : Int, v : Double) -> NlptokenizecharView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_view_sum(s : NlptokenizecharView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_view_mean(s : NlptokenizecharView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_view_scale(s : NlptokenizecharView, f : Double) -> NlptokenizecharView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_view_add(a : NlptokenizecharView, b : NlptokenizecharView) -> NlptokenizecharView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_view_copy(s : NlptokenizecharView) -> NlptokenizecharView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_view_fill(s : NlptokenizecharView, v : Double) -> NlptokenizecharView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_view_min(s : NlptokenizecharView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_view_max(s : NlptokenizecharView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_view_to_string(s : NlptokenizecharView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_range_make(size : Int) -> NlptokenizecharRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_range_len(s : NlptokenizecharRange) -> Int { s.size }

pub fn nlp_tokenize_char_range_get(s : NlptokenizecharRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_range_set(s : NlptokenizecharRange, i : Int, v : Double) -> NlptokenizecharRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_range_sum(s : NlptokenizecharRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_range_mean(s : NlptokenizecharRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_range_scale(s : NlptokenizecharRange, f : Double) -> NlptokenizecharRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_range_add(a : NlptokenizecharRange, b : NlptokenizecharRange) -> NlptokenizecharRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_range_copy(s : NlptokenizecharRange) -> NlptokenizecharRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_range_fill(s : NlptokenizecharRange, v : Double) -> NlptokenizecharRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_range_min(s : NlptokenizecharRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_range_max(s : NlptokenizecharRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_range_to_string(s : NlptokenizecharRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_slice_make(size : Int) -> NlptokenizecharSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_slice_len(s : NlptokenizecharSlice) -> Int { s.size }

pub fn nlp_tokenize_char_slice_get(s : NlptokenizecharSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_slice_set(s : NlptokenizecharSlice, i : Int, v : Double) -> NlptokenizecharSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_slice_sum(s : NlptokenizecharSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_char_slice_mean(s : NlptokenizecharSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_char_slice_scale(s : NlptokenizecharSlice, f : Double) -> NlptokenizecharSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_slice_add(a : NlptokenizecharSlice, b : NlptokenizecharSlice) -> NlptokenizecharSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_char_slice_copy(s : NlptokenizecharSlice) -> NlptokenizecharSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_slice_fill(s : NlptokenizecharSlice, v : Double) -> NlptokenizecharSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_char_slice_min(s : NlptokenizecharSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_char_slice_max(s : NlptokenizecharSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_char_slice_to_string(s : NlptokenizecharSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

