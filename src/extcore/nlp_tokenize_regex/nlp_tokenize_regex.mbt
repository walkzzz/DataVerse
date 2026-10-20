///===
/// extcore/nlp_tokenize_regex

pub(all) struct NlptokenizeregexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_regex_make_point(x : Double, y : Double) -> NlptokenizeregexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_regex_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeregexPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizeregexPoint::x(self : NlptokenizeregexPoint) -> Double { self.x }

pub fn NlptokenizeregexPoint::y(self : NlptokenizeregexPoint) -> Double { self.y }

pub fn NlptokenizeregexPoint::z(self : NlptokenizeregexPoint) -> Double { self.z }

pub fn NlptokenizeregexPoint::label(self : NlptokenizeregexPoint) -> Int { self.label }

pub fn NlptokenizeregexPoint::dist(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizeregexPoint::add(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizeregexPoint::sub(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizeregexPoint::scale(self : NlptokenizeregexPoint, s : Double) -> NlptokenizeregexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizeregexPoint::dot(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizeregexPoint::cross(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizeregexPoint::norm(self : NlptokenizeregexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizeregexPoint::normalize(self : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeregexPoint::negate(self : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizeregexPoint::mid(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizeregexPoint::lerp(self : NlptokenizeregexPoint, other : NlptokenizeregexPoint, t : Double) -> NlptokenizeregexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizeregexPoint::to_string(self : NlptokenizeregexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizeregexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_regex_make_series(vals : Array[Double], name : String) -> NlptokenizeregexSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizeregexSeries::len(self : NlptokenizeregexSeries) -> Int { self.vals.length() }

pub fn NlptokenizeregexSeries::sum(self : NlptokenizeregexSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizeregexSeries::mean(self : NlptokenizeregexSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizeregexSeries::min(self : NlptokenizeregexSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizeregexSeries::max(self : NlptokenizeregexSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizeregexSeries::range(self : NlptokenizeregexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizeregexSeries::variance(self : NlptokenizeregexSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizeregexSeries::std(self : NlptokenizeregexSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizeregexSeries::median(self : NlptokenizeregexSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizeregexSeries::scale(self : NlptokenizeregexSeries, f : Double) -> NlptokenizeregexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizeregexSeries::add(self : NlptokenizeregexSeries, other : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizeregexSeries::sub(self : NlptokenizeregexSeries, other : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizeregexSeries::normalize(self : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizeregexSeries::cumsum(self : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizeregexSeries::to_string(self : NlptokenizeregexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeregexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_regex_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeregexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_regex_matrix_identity(n : Int) -> NlptokenizeregexMatrix {
  let m = nlp_tokenize_regex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizeregexMatrix::get(self : NlptokenizeregexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizeregexMatrix::transpose(self : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  let result = nlp_tokenize_regex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizeregexMatrix::add(self : NlptokenizeregexMatrix, other : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_regex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizeregexMatrix::scale(self : NlptokenizeregexMatrix, s : Double) -> NlptokenizeregexMatrix {
  let result = nlp_tokenize_regex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizeregexMatrix::multiply(self : NlptokenizeregexMatrix, other : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  if self.cols != other.rows { return nlp_tokenize_regex_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_regex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizeregexMatrix::trace(self : NlptokenizeregexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizeregexMatrix::det(self : NlptokenizeregexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizeregexMatrix::norm(self : NlptokenizeregexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizeregexMatrix::to_string(self : NlptokenizeregexMatrix) -> String {
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

pub(all) struct NlptokenizeregexVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_regex_make_vector(comps : Array[Double]) -> NlptokenizeregexVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_regex_vector_zero(dim : Int) -> NlptokenizeregexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizeregexVector::add(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeregexVector::sub(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeregexVector::scale(self : NlptokenizeregexVector, s : Double) -> NlptokenizeregexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizeregexVector::dot(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizeregexVector::norm(self : NlptokenizeregexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizeregexVector::normalize(self : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeregexVector::dist(self : NlptokenizeregexVector, other : NlptokenizeregexVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizeregexVector::to_string(self : NlptokenizeregexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_regex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_regex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_regex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_regex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_regex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_regex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_regex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_regex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_regex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_regex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_regex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_regex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_regex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_regex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_regex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_regex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_regex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_regex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_regex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_regex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_regex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_regex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_regex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_regex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_regex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_regex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_regex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_regex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_regex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizeregexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_frame_make(size : Int) -> NlptokenizeregexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_frame_len(s : NlptokenizeregexFrame) -> Int { s.size }

pub fn nlp_tokenize_regex_frame_get(s : NlptokenizeregexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_frame_set(s : NlptokenizeregexFrame, i : Int, v : Double) -> NlptokenizeregexFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_frame_sum(s : NlptokenizeregexFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_frame_mean(s : NlptokenizeregexFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_frame_scale(s : NlptokenizeregexFrame, f : Double) -> NlptokenizeregexFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_frame_add(a : NlptokenizeregexFrame, b : NlptokenizeregexFrame) -> NlptokenizeregexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_frame_copy(s : NlptokenizeregexFrame) -> NlptokenizeregexFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_frame_fill(s : NlptokenizeregexFrame, v : Double) -> NlptokenizeregexFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_frame_min(s : NlptokenizeregexFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_frame_max(s : NlptokenizeregexFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_frame_to_string(s : NlptokenizeregexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_table_make(size : Int) -> NlptokenizeregexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_table_len(s : NlptokenizeregexTable) -> Int { s.size }

pub fn nlp_tokenize_regex_table_get(s : NlptokenizeregexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_table_set(s : NlptokenizeregexTable, i : Int, v : Double) -> NlptokenizeregexTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_table_sum(s : NlptokenizeregexTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_table_mean(s : NlptokenizeregexTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_table_scale(s : NlptokenizeregexTable, f : Double) -> NlptokenizeregexTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_table_add(a : NlptokenizeregexTable, b : NlptokenizeregexTable) -> NlptokenizeregexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_table_copy(s : NlptokenizeregexTable) -> NlptokenizeregexTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_table_fill(s : NlptokenizeregexTable, v : Double) -> NlptokenizeregexTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_table_min(s : NlptokenizeregexTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_table_max(s : NlptokenizeregexTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_table_to_string(s : NlptokenizeregexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_graphn_make(size : Int) -> NlptokenizeregexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_graphn_len(s : NlptokenizeregexGraphN) -> Int { s.size }

pub fn nlp_tokenize_regex_graphn_get(s : NlptokenizeregexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_graphn_set(s : NlptokenizeregexGraphN, i : Int, v : Double) -> NlptokenizeregexGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_graphn_sum(s : NlptokenizeregexGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_graphn_mean(s : NlptokenizeregexGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_graphn_scale(s : NlptokenizeregexGraphN, f : Double) -> NlptokenizeregexGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_graphn_add(a : NlptokenizeregexGraphN, b : NlptokenizeregexGraphN) -> NlptokenizeregexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_graphn_copy(s : NlptokenizeregexGraphN) -> NlptokenizeregexGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_graphn_fill(s : NlptokenizeregexGraphN, v : Double) -> NlptokenizeregexGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_graphn_min(s : NlptokenizeregexGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_graphn_max(s : NlptokenizeregexGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_graphn_to_string(s : NlptokenizeregexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_node_make(size : Int) -> NlptokenizeregexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_node_len(s : NlptokenizeregexNode) -> Int { s.size }

pub fn nlp_tokenize_regex_node_get(s : NlptokenizeregexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_node_set(s : NlptokenizeregexNode, i : Int, v : Double) -> NlptokenizeregexNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_node_sum(s : NlptokenizeregexNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_node_mean(s : NlptokenizeregexNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_node_scale(s : NlptokenizeregexNode, f : Double) -> NlptokenizeregexNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_node_add(a : NlptokenizeregexNode, b : NlptokenizeregexNode) -> NlptokenizeregexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_node_copy(s : NlptokenizeregexNode) -> NlptokenizeregexNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_node_fill(s : NlptokenizeregexNode, v : Double) -> NlptokenizeregexNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_node_min(s : NlptokenizeregexNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_node_max(s : NlptokenizeregexNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_node_to_string(s : NlptokenizeregexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_edge_make(size : Int) -> NlptokenizeregexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_edge_len(s : NlptokenizeregexEdge) -> Int { s.size }

pub fn nlp_tokenize_regex_edge_get(s : NlptokenizeregexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_edge_set(s : NlptokenizeregexEdge, i : Int, v : Double) -> NlptokenizeregexEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_edge_sum(s : NlptokenizeregexEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_edge_mean(s : NlptokenizeregexEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_edge_scale(s : NlptokenizeregexEdge, f : Double) -> NlptokenizeregexEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_edge_add(a : NlptokenizeregexEdge, b : NlptokenizeregexEdge) -> NlptokenizeregexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_edge_copy(s : NlptokenizeregexEdge) -> NlptokenizeregexEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_edge_fill(s : NlptokenizeregexEdge, v : Double) -> NlptokenizeregexEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_edge_min(s : NlptokenizeregexEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_edge_max(s : NlptokenizeregexEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_edge_to_string(s : NlptokenizeregexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_path_make(size : Int) -> NlptokenizeregexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_path_len(s : NlptokenizeregexPath) -> Int { s.size }

pub fn nlp_tokenize_regex_path_get(s : NlptokenizeregexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_path_set(s : NlptokenizeregexPath, i : Int, v : Double) -> NlptokenizeregexPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_path_sum(s : NlptokenizeregexPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_path_mean(s : NlptokenizeregexPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_path_scale(s : NlptokenizeregexPath, f : Double) -> NlptokenizeregexPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_path_add(a : NlptokenizeregexPath, b : NlptokenizeregexPath) -> NlptokenizeregexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_path_copy(s : NlptokenizeregexPath) -> NlptokenizeregexPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_path_fill(s : NlptokenizeregexPath, v : Double) -> NlptokenizeregexPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_path_min(s : NlptokenizeregexPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_path_max(s : NlptokenizeregexPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_path_to_string(s : NlptokenizeregexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_cluster_make(size : Int) -> NlptokenizeregexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_cluster_len(s : NlptokenizeregexCluster) -> Int { s.size }

pub fn nlp_tokenize_regex_cluster_get(s : NlptokenizeregexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_cluster_set(s : NlptokenizeregexCluster, i : Int, v : Double) -> NlptokenizeregexCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cluster_sum(s : NlptokenizeregexCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_cluster_mean(s : NlptokenizeregexCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_cluster_scale(s : NlptokenizeregexCluster, f : Double) -> NlptokenizeregexCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cluster_add(a : NlptokenizeregexCluster, b : NlptokenizeregexCluster) -> NlptokenizeregexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_cluster_copy(s : NlptokenizeregexCluster) -> NlptokenizeregexCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cluster_fill(s : NlptokenizeregexCluster, v : Double) -> NlptokenizeregexCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cluster_min(s : NlptokenizeregexCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_cluster_max(s : NlptokenizeregexCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_cluster_to_string(s : NlptokenizeregexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_model_make(size : Int) -> NlptokenizeregexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_model_len(s : NlptokenizeregexModel) -> Int { s.size }

pub fn nlp_tokenize_regex_model_get(s : NlptokenizeregexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_model_set(s : NlptokenizeregexModel, i : Int, v : Double) -> NlptokenizeregexModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_model_sum(s : NlptokenizeregexModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_model_mean(s : NlptokenizeregexModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_model_scale(s : NlptokenizeregexModel, f : Double) -> NlptokenizeregexModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_model_add(a : NlptokenizeregexModel, b : NlptokenizeregexModel) -> NlptokenizeregexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_model_copy(s : NlptokenizeregexModel) -> NlptokenizeregexModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_model_fill(s : NlptokenizeregexModel, v : Double) -> NlptokenizeregexModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_model_min(s : NlptokenizeregexModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_model_max(s : NlptokenizeregexModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_model_to_string(s : NlptokenizeregexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_layer_make(size : Int) -> NlptokenizeregexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_layer_len(s : NlptokenizeregexLayer) -> Int { s.size }

pub fn nlp_tokenize_regex_layer_get(s : NlptokenizeregexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_layer_set(s : NlptokenizeregexLayer, i : Int, v : Double) -> NlptokenizeregexLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_layer_sum(s : NlptokenizeregexLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_layer_mean(s : NlptokenizeregexLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_layer_scale(s : NlptokenizeregexLayer, f : Double) -> NlptokenizeregexLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_layer_add(a : NlptokenizeregexLayer, b : NlptokenizeregexLayer) -> NlptokenizeregexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_layer_copy(s : NlptokenizeregexLayer) -> NlptokenizeregexLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_layer_fill(s : NlptokenizeregexLayer, v : Double) -> NlptokenizeregexLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_layer_min(s : NlptokenizeregexLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_layer_max(s : NlptokenizeregexLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_layer_to_string(s : NlptokenizeregexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_buffer_make(size : Int) -> NlptokenizeregexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_buffer_len(s : NlptokenizeregexBuffer) -> Int { s.size }

pub fn nlp_tokenize_regex_buffer_get(s : NlptokenizeregexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_buffer_set(s : NlptokenizeregexBuffer, i : Int, v : Double) -> NlptokenizeregexBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_buffer_sum(s : NlptokenizeregexBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_buffer_mean(s : NlptokenizeregexBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_buffer_scale(s : NlptokenizeregexBuffer, f : Double) -> NlptokenizeregexBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_buffer_add(a : NlptokenizeregexBuffer, b : NlptokenizeregexBuffer) -> NlptokenizeregexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_buffer_copy(s : NlptokenizeregexBuffer) -> NlptokenizeregexBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_buffer_fill(s : NlptokenizeregexBuffer, v : Double) -> NlptokenizeregexBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_buffer_min(s : NlptokenizeregexBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_buffer_max(s : NlptokenizeregexBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_buffer_to_string(s : NlptokenizeregexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_cursor_make(size : Int) -> NlptokenizeregexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_cursor_len(s : NlptokenizeregexCursor) -> Int { s.size }

pub fn nlp_tokenize_regex_cursor_get(s : NlptokenizeregexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_cursor_set(s : NlptokenizeregexCursor, i : Int, v : Double) -> NlptokenizeregexCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cursor_sum(s : NlptokenizeregexCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_cursor_mean(s : NlptokenizeregexCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_cursor_scale(s : NlptokenizeregexCursor, f : Double) -> NlptokenizeregexCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cursor_add(a : NlptokenizeregexCursor, b : NlptokenizeregexCursor) -> NlptokenizeregexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_cursor_copy(s : NlptokenizeregexCursor) -> NlptokenizeregexCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cursor_fill(s : NlptokenizeregexCursor, v : Double) -> NlptokenizeregexCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_cursor_min(s : NlptokenizeregexCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_cursor_max(s : NlptokenizeregexCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_cursor_to_string(s : NlptokenizeregexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_view_make(size : Int) -> NlptokenizeregexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_view_len(s : NlptokenizeregexView) -> Int { s.size }

pub fn nlp_tokenize_regex_view_get(s : NlptokenizeregexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_view_set(s : NlptokenizeregexView, i : Int, v : Double) -> NlptokenizeregexView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_view_sum(s : NlptokenizeregexView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_view_mean(s : NlptokenizeregexView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_view_scale(s : NlptokenizeregexView, f : Double) -> NlptokenizeregexView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_view_add(a : NlptokenizeregexView, b : NlptokenizeregexView) -> NlptokenizeregexView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_view_copy(s : NlptokenizeregexView) -> NlptokenizeregexView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_view_fill(s : NlptokenizeregexView, v : Double) -> NlptokenizeregexView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_view_min(s : NlptokenizeregexView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_view_max(s : NlptokenizeregexView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_view_to_string(s : NlptokenizeregexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_range_make(size : Int) -> NlptokenizeregexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_range_len(s : NlptokenizeregexRange) -> Int { s.size }

pub fn nlp_tokenize_regex_range_get(s : NlptokenizeregexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_range_set(s : NlptokenizeregexRange, i : Int, v : Double) -> NlptokenizeregexRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_range_sum(s : NlptokenizeregexRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_range_mean(s : NlptokenizeregexRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_range_scale(s : NlptokenizeregexRange, f : Double) -> NlptokenizeregexRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_range_add(a : NlptokenizeregexRange, b : NlptokenizeregexRange) -> NlptokenizeregexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_range_copy(s : NlptokenizeregexRange) -> NlptokenizeregexRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_range_fill(s : NlptokenizeregexRange, v : Double) -> NlptokenizeregexRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_range_min(s : NlptokenizeregexRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_range_max(s : NlptokenizeregexRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_range_to_string(s : NlptokenizeregexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_slice_make(size : Int) -> NlptokenizeregexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_slice_len(s : NlptokenizeregexSlice) -> Int { s.size }

pub fn nlp_tokenize_regex_slice_get(s : NlptokenizeregexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_slice_set(s : NlptokenizeregexSlice, i : Int, v : Double) -> NlptokenizeregexSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_slice_sum(s : NlptokenizeregexSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_slice_mean(s : NlptokenizeregexSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_slice_scale(s : NlptokenizeregexSlice, f : Double) -> NlptokenizeregexSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_slice_add(a : NlptokenizeregexSlice, b : NlptokenizeregexSlice) -> NlptokenizeregexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_regex_slice_copy(s : NlptokenizeregexSlice) -> NlptokenizeregexSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_slice_fill(s : NlptokenizeregexSlice, v : Double) -> NlptokenizeregexSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_regex_slice_min(s : NlptokenizeregexSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_slice_max(s : NlptokenizeregexSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_slice_to_string(s : NlptokenizeregexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

