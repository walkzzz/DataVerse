///===
/// extcore/nlp_tokenize_morph

pub(all) struct NlptokenizemorphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_morph_make_point(x : Double, y : Double) -> NlptokenizemorphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_morph_make_point3(x : Double, y : Double, z : Double) -> NlptokenizemorphPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizemorphPoint::x(self : NlptokenizemorphPoint) -> Double { self.x }

pub fn NlptokenizemorphPoint::y(self : NlptokenizemorphPoint) -> Double { self.y }

pub fn NlptokenizemorphPoint::z(self : NlptokenizemorphPoint) -> Double { self.z }

pub fn NlptokenizemorphPoint::label(self : NlptokenizemorphPoint) -> Int { self.label }

pub fn NlptokenizemorphPoint::dist(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizemorphPoint::add(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizemorphPoint::sub(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizemorphPoint::scale(self : NlptokenizemorphPoint, s : Double) -> NlptokenizemorphPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizemorphPoint::dot(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizemorphPoint::cross(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizemorphPoint::norm(self : NlptokenizemorphPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizemorphPoint::normalize(self : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizemorphPoint::negate(self : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizemorphPoint::mid(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizemorphPoint::lerp(self : NlptokenizemorphPoint, other : NlptokenizemorphPoint, t : Double) -> NlptokenizemorphPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizemorphPoint::to_string(self : NlptokenizemorphPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizemorphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_morph_make_series(vals : Array[Double], name : String) -> NlptokenizemorphSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizemorphSeries::len(self : NlptokenizemorphSeries) -> Int { self.vals.length() }

pub fn NlptokenizemorphSeries::sum(self : NlptokenizemorphSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizemorphSeries::mean(self : NlptokenizemorphSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizemorphSeries::min(self : NlptokenizemorphSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizemorphSeries::max(self : NlptokenizemorphSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizemorphSeries::range(self : NlptokenizemorphSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizemorphSeries::variance(self : NlptokenizemorphSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizemorphSeries::std(self : NlptokenizemorphSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizemorphSeries::median(self : NlptokenizemorphSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizemorphSeries::scale(self : NlptokenizemorphSeries, f : Double) -> NlptokenizemorphSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizemorphSeries::add(self : NlptokenizemorphSeries, other : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizemorphSeries::sub(self : NlptokenizemorphSeries, other : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizemorphSeries::normalize(self : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizemorphSeries::cumsum(self : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizemorphSeries::to_string(self : NlptokenizemorphSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizemorphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_morph_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizemorphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_morph_matrix_identity(n : Int) -> NlptokenizemorphMatrix {
  let m = nlp_tokenize_morph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizemorphMatrix::get(self : NlptokenizemorphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizemorphMatrix::transpose(self : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  let result = nlp_tokenize_morph_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizemorphMatrix::add(self : NlptokenizemorphMatrix, other : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_morph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizemorphMatrix::scale(self : NlptokenizemorphMatrix, s : Double) -> NlptokenizemorphMatrix {
  let result = nlp_tokenize_morph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizemorphMatrix::multiply(self : NlptokenizemorphMatrix, other : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  if self.cols != other.rows { return nlp_tokenize_morph_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_morph_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizemorphMatrix::trace(self : NlptokenizemorphMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizemorphMatrix::det(self : NlptokenizemorphMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizemorphMatrix::norm(self : NlptokenizemorphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizemorphMatrix::to_string(self : NlptokenizemorphMatrix) -> String {
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

pub(all) struct NlptokenizemorphVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_morph_make_vector(comps : Array[Double]) -> NlptokenizemorphVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_morph_vector_zero(dim : Int) -> NlptokenizemorphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizemorphVector::add(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizemorphVector::sub(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizemorphVector::scale(self : NlptokenizemorphVector, s : Double) -> NlptokenizemorphVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizemorphVector::dot(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizemorphVector::norm(self : NlptokenizemorphVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizemorphVector::normalize(self : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizemorphVector::dist(self : NlptokenizemorphVector, other : NlptokenizemorphVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizemorphVector::to_string(self : NlptokenizemorphVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_morph_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_morph_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_morph_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_morph_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_morph_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_morph_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_morph_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_morph_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_morph_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_morph_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_morph_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_morph_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_morph_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_morph_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_morph_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_morph_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_morph_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_morph_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_morph_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_morph_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_morph_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_morph_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_morph_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_morph_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_morph_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_morph_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_morph_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_morph_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_morph_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizemorphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_frame_make(size : Int) -> NlptokenizemorphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_frame_len(s : NlptokenizemorphFrame) -> Int { s.size }

pub fn nlp_tokenize_morph_frame_get(s : NlptokenizemorphFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_frame_set(s : NlptokenizemorphFrame, i : Int, v : Double) -> NlptokenizemorphFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_frame_sum(s : NlptokenizemorphFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_frame_mean(s : NlptokenizemorphFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_frame_scale(s : NlptokenizemorphFrame, f : Double) -> NlptokenizemorphFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_frame_add(a : NlptokenizemorphFrame, b : NlptokenizemorphFrame) -> NlptokenizemorphFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_frame_copy(s : NlptokenizemorphFrame) -> NlptokenizemorphFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_frame_fill(s : NlptokenizemorphFrame, v : Double) -> NlptokenizemorphFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_frame_min(s : NlptokenizemorphFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_frame_max(s : NlptokenizemorphFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_frame_to_string(s : NlptokenizemorphFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_table_make(size : Int) -> NlptokenizemorphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_table_len(s : NlptokenizemorphTable) -> Int { s.size }

pub fn nlp_tokenize_morph_table_get(s : NlptokenizemorphTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_table_set(s : NlptokenizemorphTable, i : Int, v : Double) -> NlptokenizemorphTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_table_sum(s : NlptokenizemorphTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_table_mean(s : NlptokenizemorphTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_table_scale(s : NlptokenizemorphTable, f : Double) -> NlptokenizemorphTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_table_add(a : NlptokenizemorphTable, b : NlptokenizemorphTable) -> NlptokenizemorphTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_table_copy(s : NlptokenizemorphTable) -> NlptokenizemorphTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_table_fill(s : NlptokenizemorphTable, v : Double) -> NlptokenizemorphTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_table_min(s : NlptokenizemorphTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_table_max(s : NlptokenizemorphTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_table_to_string(s : NlptokenizemorphTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_graphn_make(size : Int) -> NlptokenizemorphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_graphn_len(s : NlptokenizemorphGraphN) -> Int { s.size }

pub fn nlp_tokenize_morph_graphn_get(s : NlptokenizemorphGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_graphn_set(s : NlptokenizemorphGraphN, i : Int, v : Double) -> NlptokenizemorphGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_graphn_sum(s : NlptokenizemorphGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_graphn_mean(s : NlptokenizemorphGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_graphn_scale(s : NlptokenizemorphGraphN, f : Double) -> NlptokenizemorphGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_graphn_add(a : NlptokenizemorphGraphN, b : NlptokenizemorphGraphN) -> NlptokenizemorphGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_graphn_copy(s : NlptokenizemorphGraphN) -> NlptokenizemorphGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_graphn_fill(s : NlptokenizemorphGraphN, v : Double) -> NlptokenizemorphGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_graphn_min(s : NlptokenizemorphGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_graphn_max(s : NlptokenizemorphGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_graphn_to_string(s : NlptokenizemorphGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_node_make(size : Int) -> NlptokenizemorphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_node_len(s : NlptokenizemorphNode) -> Int { s.size }

pub fn nlp_tokenize_morph_node_get(s : NlptokenizemorphNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_node_set(s : NlptokenizemorphNode, i : Int, v : Double) -> NlptokenizemorphNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_node_sum(s : NlptokenizemorphNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_node_mean(s : NlptokenizemorphNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_node_scale(s : NlptokenizemorphNode, f : Double) -> NlptokenizemorphNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_node_add(a : NlptokenizemorphNode, b : NlptokenizemorphNode) -> NlptokenizemorphNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_node_copy(s : NlptokenizemorphNode) -> NlptokenizemorphNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_node_fill(s : NlptokenizemorphNode, v : Double) -> NlptokenizemorphNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_node_min(s : NlptokenizemorphNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_node_max(s : NlptokenizemorphNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_node_to_string(s : NlptokenizemorphNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_edge_make(size : Int) -> NlptokenizemorphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_edge_len(s : NlptokenizemorphEdge) -> Int { s.size }

pub fn nlp_tokenize_morph_edge_get(s : NlptokenizemorphEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_edge_set(s : NlptokenizemorphEdge, i : Int, v : Double) -> NlptokenizemorphEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_edge_sum(s : NlptokenizemorphEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_edge_mean(s : NlptokenizemorphEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_edge_scale(s : NlptokenizemorphEdge, f : Double) -> NlptokenizemorphEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_edge_add(a : NlptokenizemorphEdge, b : NlptokenizemorphEdge) -> NlptokenizemorphEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_edge_copy(s : NlptokenizemorphEdge) -> NlptokenizemorphEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_edge_fill(s : NlptokenizemorphEdge, v : Double) -> NlptokenizemorphEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_edge_min(s : NlptokenizemorphEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_edge_max(s : NlptokenizemorphEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_edge_to_string(s : NlptokenizemorphEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_path_make(size : Int) -> NlptokenizemorphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_path_len(s : NlptokenizemorphPath) -> Int { s.size }

pub fn nlp_tokenize_morph_path_get(s : NlptokenizemorphPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_path_set(s : NlptokenizemorphPath, i : Int, v : Double) -> NlptokenizemorphPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_path_sum(s : NlptokenizemorphPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_path_mean(s : NlptokenizemorphPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_path_scale(s : NlptokenizemorphPath, f : Double) -> NlptokenizemorphPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_path_add(a : NlptokenizemorphPath, b : NlptokenizemorphPath) -> NlptokenizemorphPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_path_copy(s : NlptokenizemorphPath) -> NlptokenizemorphPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_path_fill(s : NlptokenizemorphPath, v : Double) -> NlptokenizemorphPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_path_min(s : NlptokenizemorphPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_path_max(s : NlptokenizemorphPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_path_to_string(s : NlptokenizemorphPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_cluster_make(size : Int) -> NlptokenizemorphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_cluster_len(s : NlptokenizemorphCluster) -> Int { s.size }

pub fn nlp_tokenize_morph_cluster_get(s : NlptokenizemorphCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_cluster_set(s : NlptokenizemorphCluster, i : Int, v : Double) -> NlptokenizemorphCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cluster_sum(s : NlptokenizemorphCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_cluster_mean(s : NlptokenizemorphCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_cluster_scale(s : NlptokenizemorphCluster, f : Double) -> NlptokenizemorphCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cluster_add(a : NlptokenizemorphCluster, b : NlptokenizemorphCluster) -> NlptokenizemorphCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_cluster_copy(s : NlptokenizemorphCluster) -> NlptokenizemorphCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cluster_fill(s : NlptokenizemorphCluster, v : Double) -> NlptokenizemorphCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cluster_min(s : NlptokenizemorphCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_cluster_max(s : NlptokenizemorphCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_cluster_to_string(s : NlptokenizemorphCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_model_make(size : Int) -> NlptokenizemorphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_model_len(s : NlptokenizemorphModel) -> Int { s.size }

pub fn nlp_tokenize_morph_model_get(s : NlptokenizemorphModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_model_set(s : NlptokenizemorphModel, i : Int, v : Double) -> NlptokenizemorphModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_model_sum(s : NlptokenizemorphModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_model_mean(s : NlptokenizemorphModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_model_scale(s : NlptokenizemorphModel, f : Double) -> NlptokenizemorphModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_model_add(a : NlptokenizemorphModel, b : NlptokenizemorphModel) -> NlptokenizemorphModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_model_copy(s : NlptokenizemorphModel) -> NlptokenizemorphModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_model_fill(s : NlptokenizemorphModel, v : Double) -> NlptokenizemorphModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_model_min(s : NlptokenizemorphModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_model_max(s : NlptokenizemorphModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_model_to_string(s : NlptokenizemorphModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_layer_make(size : Int) -> NlptokenizemorphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_layer_len(s : NlptokenizemorphLayer) -> Int { s.size }

pub fn nlp_tokenize_morph_layer_get(s : NlptokenizemorphLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_layer_set(s : NlptokenizemorphLayer, i : Int, v : Double) -> NlptokenizemorphLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_layer_sum(s : NlptokenizemorphLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_layer_mean(s : NlptokenizemorphLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_layer_scale(s : NlptokenizemorphLayer, f : Double) -> NlptokenizemorphLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_layer_add(a : NlptokenizemorphLayer, b : NlptokenizemorphLayer) -> NlptokenizemorphLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_layer_copy(s : NlptokenizemorphLayer) -> NlptokenizemorphLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_layer_fill(s : NlptokenizemorphLayer, v : Double) -> NlptokenizemorphLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_layer_min(s : NlptokenizemorphLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_layer_max(s : NlptokenizemorphLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_layer_to_string(s : NlptokenizemorphLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_buffer_make(size : Int) -> NlptokenizemorphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_buffer_len(s : NlptokenizemorphBuffer) -> Int { s.size }

pub fn nlp_tokenize_morph_buffer_get(s : NlptokenizemorphBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_buffer_set(s : NlptokenizemorphBuffer, i : Int, v : Double) -> NlptokenizemorphBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_buffer_sum(s : NlptokenizemorphBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_buffer_mean(s : NlptokenizemorphBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_buffer_scale(s : NlptokenizemorphBuffer, f : Double) -> NlptokenizemorphBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_buffer_add(a : NlptokenizemorphBuffer, b : NlptokenizemorphBuffer) -> NlptokenizemorphBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_buffer_copy(s : NlptokenizemorphBuffer) -> NlptokenizemorphBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_buffer_fill(s : NlptokenizemorphBuffer, v : Double) -> NlptokenizemorphBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_buffer_min(s : NlptokenizemorphBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_buffer_max(s : NlptokenizemorphBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_buffer_to_string(s : NlptokenizemorphBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_cursor_make(size : Int) -> NlptokenizemorphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_cursor_len(s : NlptokenizemorphCursor) -> Int { s.size }

pub fn nlp_tokenize_morph_cursor_get(s : NlptokenizemorphCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_cursor_set(s : NlptokenizemorphCursor, i : Int, v : Double) -> NlptokenizemorphCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cursor_sum(s : NlptokenizemorphCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_cursor_mean(s : NlptokenizemorphCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_cursor_scale(s : NlptokenizemorphCursor, f : Double) -> NlptokenizemorphCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cursor_add(a : NlptokenizemorphCursor, b : NlptokenizemorphCursor) -> NlptokenizemorphCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_cursor_copy(s : NlptokenizemorphCursor) -> NlptokenizemorphCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cursor_fill(s : NlptokenizemorphCursor, v : Double) -> NlptokenizemorphCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_cursor_min(s : NlptokenizemorphCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_cursor_max(s : NlptokenizemorphCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_cursor_to_string(s : NlptokenizemorphCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_view_make(size : Int) -> NlptokenizemorphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_view_len(s : NlptokenizemorphView) -> Int { s.size }

pub fn nlp_tokenize_morph_view_get(s : NlptokenizemorphView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_view_set(s : NlptokenizemorphView, i : Int, v : Double) -> NlptokenizemorphView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_view_sum(s : NlptokenizemorphView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_view_mean(s : NlptokenizemorphView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_view_scale(s : NlptokenizemorphView, f : Double) -> NlptokenizemorphView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_view_add(a : NlptokenizemorphView, b : NlptokenizemorphView) -> NlptokenizemorphView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_view_copy(s : NlptokenizemorphView) -> NlptokenizemorphView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_view_fill(s : NlptokenizemorphView, v : Double) -> NlptokenizemorphView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_view_min(s : NlptokenizemorphView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_view_max(s : NlptokenizemorphView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_view_to_string(s : NlptokenizemorphView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_range_make(size : Int) -> NlptokenizemorphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_range_len(s : NlptokenizemorphRange) -> Int { s.size }

pub fn nlp_tokenize_morph_range_get(s : NlptokenizemorphRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_range_set(s : NlptokenizemorphRange, i : Int, v : Double) -> NlptokenizemorphRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_range_sum(s : NlptokenizemorphRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_range_mean(s : NlptokenizemorphRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_range_scale(s : NlptokenizemorphRange, f : Double) -> NlptokenizemorphRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_range_add(a : NlptokenizemorphRange, b : NlptokenizemorphRange) -> NlptokenizemorphRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_range_copy(s : NlptokenizemorphRange) -> NlptokenizemorphRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_range_fill(s : NlptokenizemorphRange, v : Double) -> NlptokenizemorphRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_range_min(s : NlptokenizemorphRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_range_max(s : NlptokenizemorphRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_range_to_string(s : NlptokenizemorphRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_slice_make(size : Int) -> NlptokenizemorphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_slice_len(s : NlptokenizemorphSlice) -> Int { s.size }

pub fn nlp_tokenize_morph_slice_get(s : NlptokenizemorphSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_slice_set(s : NlptokenizemorphSlice, i : Int, v : Double) -> NlptokenizemorphSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_slice_sum(s : NlptokenizemorphSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_slice_mean(s : NlptokenizemorphSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_slice_scale(s : NlptokenizemorphSlice, f : Double) -> NlptokenizemorphSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_slice_add(a : NlptokenizemorphSlice, b : NlptokenizemorphSlice) -> NlptokenizemorphSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_morph_slice_copy(s : NlptokenizemorphSlice) -> NlptokenizemorphSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_slice_fill(s : NlptokenizemorphSlice, v : Double) -> NlptokenizemorphSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_morph_slice_min(s : NlptokenizemorphSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_slice_max(s : NlptokenizemorphSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_slice_to_string(s : NlptokenizemorphSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

