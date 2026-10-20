///===
/// extcore/nlp_tokenize_sentence

pub(all) struct NlptokenizesentencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_sentence_make_point(x : Double, y : Double) -> NlptokenizesentencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_sentence_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesentencePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizesentencePoint::x(self : NlptokenizesentencePoint) -> Double { self.x }

pub fn NlptokenizesentencePoint::y(self : NlptokenizesentencePoint) -> Double { self.y }

pub fn NlptokenizesentencePoint::z(self : NlptokenizesentencePoint) -> Double { self.z }

pub fn NlptokenizesentencePoint::label(self : NlptokenizesentencePoint) -> Int { self.label }

pub fn NlptokenizesentencePoint::dist(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizesentencePoint::add(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizesentencePoint::sub(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizesentencePoint::scale(self : NlptokenizesentencePoint, s : Double) -> NlptokenizesentencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizesentencePoint::dot(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizesentencePoint::cross(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizesentencePoint::norm(self : NlptokenizesentencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizesentencePoint::normalize(self : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesentencePoint::negate(self : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizesentencePoint::mid(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizesentencePoint::lerp(self : NlptokenizesentencePoint, other : NlptokenizesentencePoint, t : Double) -> NlptokenizesentencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizesentencePoint::to_string(self : NlptokenizesentencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizesentenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_sentence_make_series(vals : Array[Double], name : String) -> NlptokenizesentenceSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizesentenceSeries::len(self : NlptokenizesentenceSeries) -> Int { self.vals.length() }

pub fn NlptokenizesentenceSeries::sum(self : NlptokenizesentenceSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizesentenceSeries::mean(self : NlptokenizesentenceSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizesentenceSeries::min(self : NlptokenizesentenceSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizesentenceSeries::max(self : NlptokenizesentenceSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizesentenceSeries::range(self : NlptokenizesentenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizesentenceSeries::variance(self : NlptokenizesentenceSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizesentenceSeries::std(self : NlptokenizesentenceSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizesentenceSeries::median(self : NlptokenizesentenceSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizesentenceSeries::scale(self : NlptokenizesentenceSeries, f : Double) -> NlptokenizesentenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizesentenceSeries::add(self : NlptokenizesentenceSeries, other : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizesentenceSeries::sub(self : NlptokenizesentenceSeries, other : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizesentenceSeries::normalize(self : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizesentenceSeries::cumsum(self : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizesentenceSeries::to_string(self : NlptokenizesentenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesentenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_sentence_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesentenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_sentence_matrix_identity(n : Int) -> NlptokenizesentenceMatrix {
  let m = nlp_tokenize_sentence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizesentenceMatrix::get(self : NlptokenizesentenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizesentenceMatrix::transpose(self : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  let result = nlp_tokenize_sentence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizesentenceMatrix::add(self : NlptokenizesentenceMatrix, other : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_sentence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizesentenceMatrix::scale(self : NlptokenizesentenceMatrix, s : Double) -> NlptokenizesentenceMatrix {
  let result = nlp_tokenize_sentence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizesentenceMatrix::multiply(self : NlptokenizesentenceMatrix, other : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  if self.cols != other.rows { return nlp_tokenize_sentence_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_sentence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizesentenceMatrix::trace(self : NlptokenizesentenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizesentenceMatrix::det(self : NlptokenizesentenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizesentenceMatrix::norm(self : NlptokenizesentenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizesentenceMatrix::to_string(self : NlptokenizesentenceMatrix) -> String {
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

pub(all) struct NlptokenizesentenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_sentence_make_vector(comps : Array[Double]) -> NlptokenizesentenceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_sentence_vector_zero(dim : Int) -> NlptokenizesentenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizesentenceVector::add(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesentenceVector::sub(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesentenceVector::scale(self : NlptokenizesentenceVector, s : Double) -> NlptokenizesentenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizesentenceVector::dot(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizesentenceVector::norm(self : NlptokenizesentenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizesentenceVector::normalize(self : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesentenceVector::dist(self : NlptokenizesentenceVector, other : NlptokenizesentenceVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizesentenceVector::to_string(self : NlptokenizesentenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_sentence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_sentence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_sentence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_sentence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_sentence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_sentence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_sentence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_sentence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_sentence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_sentence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_sentence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_sentence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_sentence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_sentence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_sentence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_sentence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_sentence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_sentence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_sentence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_sentence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_sentence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_sentence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_sentence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_sentence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_sentence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_sentence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_sentence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_sentence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_sentence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizesentenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_frame_make(size : Int) -> NlptokenizesentenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_frame_len(s : NlptokenizesentenceFrame) -> Int { s.size }

pub fn nlp_tokenize_sentence_frame_get(s : NlptokenizesentenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_frame_set(s : NlptokenizesentenceFrame, i : Int, v : Double) -> NlptokenizesentenceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_frame_sum(s : NlptokenizesentenceFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_frame_mean(s : NlptokenizesentenceFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_frame_scale(s : NlptokenizesentenceFrame, f : Double) -> NlptokenizesentenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_frame_add(a : NlptokenizesentenceFrame, b : NlptokenizesentenceFrame) -> NlptokenizesentenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_frame_copy(s : NlptokenizesentenceFrame) -> NlptokenizesentenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_frame_fill(s : NlptokenizesentenceFrame, v : Double) -> NlptokenizesentenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_frame_min(s : NlptokenizesentenceFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_frame_max(s : NlptokenizesentenceFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_frame_to_string(s : NlptokenizesentenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_table_make(size : Int) -> NlptokenizesentenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_table_len(s : NlptokenizesentenceTable) -> Int { s.size }

pub fn nlp_tokenize_sentence_table_get(s : NlptokenizesentenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_table_set(s : NlptokenizesentenceTable, i : Int, v : Double) -> NlptokenizesentenceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_table_sum(s : NlptokenizesentenceTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_table_mean(s : NlptokenizesentenceTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_table_scale(s : NlptokenizesentenceTable, f : Double) -> NlptokenizesentenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_table_add(a : NlptokenizesentenceTable, b : NlptokenizesentenceTable) -> NlptokenizesentenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_table_copy(s : NlptokenizesentenceTable) -> NlptokenizesentenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_table_fill(s : NlptokenizesentenceTable, v : Double) -> NlptokenizesentenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_table_min(s : NlptokenizesentenceTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_table_max(s : NlptokenizesentenceTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_table_to_string(s : NlptokenizesentenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_graphn_make(size : Int) -> NlptokenizesentenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_graphn_len(s : NlptokenizesentenceGraphN) -> Int { s.size }

pub fn nlp_tokenize_sentence_graphn_get(s : NlptokenizesentenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_graphn_set(s : NlptokenizesentenceGraphN, i : Int, v : Double) -> NlptokenizesentenceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_graphn_sum(s : NlptokenizesentenceGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_graphn_mean(s : NlptokenizesentenceGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_graphn_scale(s : NlptokenizesentenceGraphN, f : Double) -> NlptokenizesentenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_graphn_add(a : NlptokenizesentenceGraphN, b : NlptokenizesentenceGraphN) -> NlptokenizesentenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_graphn_copy(s : NlptokenizesentenceGraphN) -> NlptokenizesentenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_graphn_fill(s : NlptokenizesentenceGraphN, v : Double) -> NlptokenizesentenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_graphn_min(s : NlptokenizesentenceGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_graphn_max(s : NlptokenizesentenceGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_graphn_to_string(s : NlptokenizesentenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_node_make(size : Int) -> NlptokenizesentenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_node_len(s : NlptokenizesentenceNode) -> Int { s.size }

pub fn nlp_tokenize_sentence_node_get(s : NlptokenizesentenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_node_set(s : NlptokenizesentenceNode, i : Int, v : Double) -> NlptokenizesentenceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_node_sum(s : NlptokenizesentenceNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_node_mean(s : NlptokenizesentenceNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_node_scale(s : NlptokenizesentenceNode, f : Double) -> NlptokenizesentenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_node_add(a : NlptokenizesentenceNode, b : NlptokenizesentenceNode) -> NlptokenizesentenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_node_copy(s : NlptokenizesentenceNode) -> NlptokenizesentenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_node_fill(s : NlptokenizesentenceNode, v : Double) -> NlptokenizesentenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_node_min(s : NlptokenizesentenceNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_node_max(s : NlptokenizesentenceNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_node_to_string(s : NlptokenizesentenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_edge_make(size : Int) -> NlptokenizesentenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_edge_len(s : NlptokenizesentenceEdge) -> Int { s.size }

pub fn nlp_tokenize_sentence_edge_get(s : NlptokenizesentenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_edge_set(s : NlptokenizesentenceEdge, i : Int, v : Double) -> NlptokenizesentenceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_edge_sum(s : NlptokenizesentenceEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_edge_mean(s : NlptokenizesentenceEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_edge_scale(s : NlptokenizesentenceEdge, f : Double) -> NlptokenizesentenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_edge_add(a : NlptokenizesentenceEdge, b : NlptokenizesentenceEdge) -> NlptokenizesentenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_edge_copy(s : NlptokenizesentenceEdge) -> NlptokenizesentenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_edge_fill(s : NlptokenizesentenceEdge, v : Double) -> NlptokenizesentenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_edge_min(s : NlptokenizesentenceEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_edge_max(s : NlptokenizesentenceEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_edge_to_string(s : NlptokenizesentenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_path_make(size : Int) -> NlptokenizesentencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_path_len(s : NlptokenizesentencePath) -> Int { s.size }

pub fn nlp_tokenize_sentence_path_get(s : NlptokenizesentencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_path_set(s : NlptokenizesentencePath, i : Int, v : Double) -> NlptokenizesentencePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_path_sum(s : NlptokenizesentencePath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_path_mean(s : NlptokenizesentencePath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_path_scale(s : NlptokenizesentencePath, f : Double) -> NlptokenizesentencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_path_add(a : NlptokenizesentencePath, b : NlptokenizesentencePath) -> NlptokenizesentencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_path_copy(s : NlptokenizesentencePath) -> NlptokenizesentencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_path_fill(s : NlptokenizesentencePath, v : Double) -> NlptokenizesentencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_path_min(s : NlptokenizesentencePath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_path_max(s : NlptokenizesentencePath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_path_to_string(s : NlptokenizesentencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_cluster_make(size : Int) -> NlptokenizesentenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_cluster_len(s : NlptokenizesentenceCluster) -> Int { s.size }

pub fn nlp_tokenize_sentence_cluster_get(s : NlptokenizesentenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_cluster_set(s : NlptokenizesentenceCluster, i : Int, v : Double) -> NlptokenizesentenceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cluster_sum(s : NlptokenizesentenceCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_cluster_mean(s : NlptokenizesentenceCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_cluster_scale(s : NlptokenizesentenceCluster, f : Double) -> NlptokenizesentenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cluster_add(a : NlptokenizesentenceCluster, b : NlptokenizesentenceCluster) -> NlptokenizesentenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_cluster_copy(s : NlptokenizesentenceCluster) -> NlptokenizesentenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cluster_fill(s : NlptokenizesentenceCluster, v : Double) -> NlptokenizesentenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cluster_min(s : NlptokenizesentenceCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_cluster_max(s : NlptokenizesentenceCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_cluster_to_string(s : NlptokenizesentenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_model_make(size : Int) -> NlptokenizesentenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_model_len(s : NlptokenizesentenceModel) -> Int { s.size }

pub fn nlp_tokenize_sentence_model_get(s : NlptokenizesentenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_model_set(s : NlptokenizesentenceModel, i : Int, v : Double) -> NlptokenizesentenceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_model_sum(s : NlptokenizesentenceModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_model_mean(s : NlptokenizesentenceModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_model_scale(s : NlptokenizesentenceModel, f : Double) -> NlptokenizesentenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_model_add(a : NlptokenizesentenceModel, b : NlptokenizesentenceModel) -> NlptokenizesentenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_model_copy(s : NlptokenizesentenceModel) -> NlptokenizesentenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_model_fill(s : NlptokenizesentenceModel, v : Double) -> NlptokenizesentenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_model_min(s : NlptokenizesentenceModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_model_max(s : NlptokenizesentenceModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_model_to_string(s : NlptokenizesentenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_layer_make(size : Int) -> NlptokenizesentenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_layer_len(s : NlptokenizesentenceLayer) -> Int { s.size }

pub fn nlp_tokenize_sentence_layer_get(s : NlptokenizesentenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_layer_set(s : NlptokenizesentenceLayer, i : Int, v : Double) -> NlptokenizesentenceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_layer_sum(s : NlptokenizesentenceLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_layer_mean(s : NlptokenizesentenceLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_layer_scale(s : NlptokenizesentenceLayer, f : Double) -> NlptokenizesentenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_layer_add(a : NlptokenizesentenceLayer, b : NlptokenizesentenceLayer) -> NlptokenizesentenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_layer_copy(s : NlptokenizesentenceLayer) -> NlptokenizesentenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_layer_fill(s : NlptokenizesentenceLayer, v : Double) -> NlptokenizesentenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_layer_min(s : NlptokenizesentenceLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_layer_max(s : NlptokenizesentenceLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_layer_to_string(s : NlptokenizesentenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_buffer_make(size : Int) -> NlptokenizesentenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_buffer_len(s : NlptokenizesentenceBuffer) -> Int { s.size }

pub fn nlp_tokenize_sentence_buffer_get(s : NlptokenizesentenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_buffer_set(s : NlptokenizesentenceBuffer, i : Int, v : Double) -> NlptokenizesentenceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_buffer_sum(s : NlptokenizesentenceBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_buffer_mean(s : NlptokenizesentenceBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_buffer_scale(s : NlptokenizesentenceBuffer, f : Double) -> NlptokenizesentenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_buffer_add(a : NlptokenizesentenceBuffer, b : NlptokenizesentenceBuffer) -> NlptokenizesentenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_buffer_copy(s : NlptokenizesentenceBuffer) -> NlptokenizesentenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_buffer_fill(s : NlptokenizesentenceBuffer, v : Double) -> NlptokenizesentenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_buffer_min(s : NlptokenizesentenceBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_buffer_max(s : NlptokenizesentenceBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_buffer_to_string(s : NlptokenizesentenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_cursor_make(size : Int) -> NlptokenizesentenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_cursor_len(s : NlptokenizesentenceCursor) -> Int { s.size }

pub fn nlp_tokenize_sentence_cursor_get(s : NlptokenizesentenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_cursor_set(s : NlptokenizesentenceCursor, i : Int, v : Double) -> NlptokenizesentenceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cursor_sum(s : NlptokenizesentenceCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_cursor_mean(s : NlptokenizesentenceCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_cursor_scale(s : NlptokenizesentenceCursor, f : Double) -> NlptokenizesentenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cursor_add(a : NlptokenizesentenceCursor, b : NlptokenizesentenceCursor) -> NlptokenizesentenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_cursor_copy(s : NlptokenizesentenceCursor) -> NlptokenizesentenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cursor_fill(s : NlptokenizesentenceCursor, v : Double) -> NlptokenizesentenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_cursor_min(s : NlptokenizesentenceCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_cursor_max(s : NlptokenizesentenceCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_cursor_to_string(s : NlptokenizesentenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_view_make(size : Int) -> NlptokenizesentenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_view_len(s : NlptokenizesentenceView) -> Int { s.size }

pub fn nlp_tokenize_sentence_view_get(s : NlptokenizesentenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_view_set(s : NlptokenizesentenceView, i : Int, v : Double) -> NlptokenizesentenceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_view_sum(s : NlptokenizesentenceView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_view_mean(s : NlptokenizesentenceView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_view_scale(s : NlptokenizesentenceView, f : Double) -> NlptokenizesentenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_view_add(a : NlptokenizesentenceView, b : NlptokenizesentenceView) -> NlptokenizesentenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_view_copy(s : NlptokenizesentenceView) -> NlptokenizesentenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_view_fill(s : NlptokenizesentenceView, v : Double) -> NlptokenizesentenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_view_min(s : NlptokenizesentenceView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_view_max(s : NlptokenizesentenceView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_view_to_string(s : NlptokenizesentenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_range_make(size : Int) -> NlptokenizesentenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_range_len(s : NlptokenizesentenceRange) -> Int { s.size }

pub fn nlp_tokenize_sentence_range_get(s : NlptokenizesentenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_range_set(s : NlptokenizesentenceRange, i : Int, v : Double) -> NlptokenizesentenceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_range_sum(s : NlptokenizesentenceRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_range_mean(s : NlptokenizesentenceRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_range_scale(s : NlptokenizesentenceRange, f : Double) -> NlptokenizesentenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_range_add(a : NlptokenizesentenceRange, b : NlptokenizesentenceRange) -> NlptokenizesentenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_range_copy(s : NlptokenizesentenceRange) -> NlptokenizesentenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_range_fill(s : NlptokenizesentenceRange, v : Double) -> NlptokenizesentenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_range_min(s : NlptokenizesentenceRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_range_max(s : NlptokenizesentenceRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_range_to_string(s : NlptokenizesentenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_slice_make(size : Int) -> NlptokenizesentenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_slice_len(s : NlptokenizesentenceSlice) -> Int { s.size }

pub fn nlp_tokenize_sentence_slice_get(s : NlptokenizesentenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_slice_set(s : NlptokenizesentenceSlice, i : Int, v : Double) -> NlptokenizesentenceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_slice_sum(s : NlptokenizesentenceSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_slice_mean(s : NlptokenizesentenceSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_slice_scale(s : NlptokenizesentenceSlice, f : Double) -> NlptokenizesentenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_slice_add(a : NlptokenizesentenceSlice, b : NlptokenizesentenceSlice) -> NlptokenizesentenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_sentence_slice_copy(s : NlptokenizesentenceSlice) -> NlptokenizesentenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_slice_fill(s : NlptokenizesentenceSlice, v : Double) -> NlptokenizesentenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_sentence_slice_min(s : NlptokenizesentenceSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_slice_max(s : NlptokenizesentenceSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_slice_to_string(s : NlptokenizesentenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

