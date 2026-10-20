///===
/// extcore/nlp_tokenize_word

pub(all) struct NlptokenizewordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_word_make_point(x : Double, y : Double) -> NlptokenizewordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_word_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizewordPoint::x(self : NlptokenizewordPoint) -> Double { self.x }

pub fn NlptokenizewordPoint::y(self : NlptokenizewordPoint) -> Double { self.y }

pub fn NlptokenizewordPoint::z(self : NlptokenizewordPoint) -> Double { self.z }

pub fn NlptokenizewordPoint::label(self : NlptokenizewordPoint) -> Int { self.label }

pub fn NlptokenizewordPoint::dist(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizewordPoint::add(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizewordPoint::sub(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizewordPoint::scale(self : NlptokenizewordPoint, s : Double) -> NlptokenizewordPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizewordPoint::dot(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizewordPoint::cross(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizewordPoint::norm(self : NlptokenizewordPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizewordPoint::normalize(self : NlptokenizewordPoint) -> NlptokenizewordPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordPoint::negate(self : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizewordPoint::mid(self : NlptokenizewordPoint, other : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizewordPoint::lerp(self : NlptokenizewordPoint, other : NlptokenizewordPoint, t : Double) -> NlptokenizewordPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizewordPoint::to_string(self : NlptokenizewordPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizewordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_word_make_series(vals : Array[Double], name : String) -> NlptokenizewordSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizewordSeries::len(self : NlptokenizewordSeries) -> Int { self.vals.length() }

pub fn NlptokenizewordSeries::sum(self : NlptokenizewordSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizewordSeries::mean(self : NlptokenizewordSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizewordSeries::min(self : NlptokenizewordSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizewordSeries::max(self : NlptokenizewordSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizewordSeries::range(self : NlptokenizewordSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizewordSeries::variance(self : NlptokenizewordSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizewordSeries::std(self : NlptokenizewordSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizewordSeries::median(self : NlptokenizewordSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizewordSeries::scale(self : NlptokenizewordSeries, f : Double) -> NlptokenizewordSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizewordSeries::add(self : NlptokenizewordSeries, other : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizewordSeries::sub(self : NlptokenizewordSeries, other : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizewordSeries::normalize(self : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizewordSeries::cumsum(self : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizewordSeries::to_string(self : NlptokenizewordSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_word_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_word_matrix_identity(n : Int) -> NlptokenizewordMatrix {
  let m = nlp_tokenize_word_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizewordMatrix::get(self : NlptokenizewordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizewordMatrix::transpose(self : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizewordMatrix::add(self : NlptokenizewordMatrix, other : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_word_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizewordMatrix::scale(self : NlptokenizewordMatrix, s : Double) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizewordMatrix::multiply(self : NlptokenizewordMatrix, other : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if self.cols != other.rows { return nlp_tokenize_word_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_word_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizewordMatrix::trace(self : NlptokenizewordMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizewordMatrix::det(self : NlptokenizewordMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizewordMatrix::norm(self : NlptokenizewordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizewordMatrix::to_string(self : NlptokenizewordMatrix) -> String {
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

pub(all) struct NlptokenizewordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_word_make_vector(comps : Array[Double]) -> NlptokenizewordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_word_vector_zero(dim : Int) -> NlptokenizewordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizewordVector::add(self : NlptokenizewordVector, other : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordVector::sub(self : NlptokenizewordVector, other : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordVector::scale(self : NlptokenizewordVector, s : Double) -> NlptokenizewordVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizewordVector::dot(self : NlptokenizewordVector, other : NlptokenizewordVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizewordVector::norm(self : NlptokenizewordVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizewordVector::normalize(self : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordVector::dist(self : NlptokenizewordVector, other : NlptokenizewordVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizewordVector::to_string(self : NlptokenizewordVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_word_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_word_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_word_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_word_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_word_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_word_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_word_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_word_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_word_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_word_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_word_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_word_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_word_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_word_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_word_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_word_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_word_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_word_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_word_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_word_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_word_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_word_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_word_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_word_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_word_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_word_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_word_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_word_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_word_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizewordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_frame_make(size : Int) -> NlptokenizewordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_frame_len(s : NlptokenizewordFrame) -> Int { s.size }

pub fn nlp_tokenize_word_frame_get(s : NlptokenizewordFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_frame_set(s : NlptokenizewordFrame, i : Int, v : Double) -> NlptokenizewordFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_frame_sum(s : NlptokenizewordFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_frame_mean(s : NlptokenizewordFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_frame_scale(s : NlptokenizewordFrame, f : Double) -> NlptokenizewordFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_frame_add(a : NlptokenizewordFrame, b : NlptokenizewordFrame) -> NlptokenizewordFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_frame_copy(s : NlptokenizewordFrame) -> NlptokenizewordFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_frame_fill(s : NlptokenizewordFrame, v : Double) -> NlptokenizewordFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_frame_min(s : NlptokenizewordFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_frame_max(s : NlptokenizewordFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_frame_to_string(s : NlptokenizewordFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_table_make(size : Int) -> NlptokenizewordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_table_len(s : NlptokenizewordTable) -> Int { s.size }

pub fn nlp_tokenize_word_table_get(s : NlptokenizewordTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_table_set(s : NlptokenizewordTable, i : Int, v : Double) -> NlptokenizewordTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_table_sum(s : NlptokenizewordTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_table_mean(s : NlptokenizewordTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_table_scale(s : NlptokenizewordTable, f : Double) -> NlptokenizewordTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_table_add(a : NlptokenizewordTable, b : NlptokenizewordTable) -> NlptokenizewordTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_table_copy(s : NlptokenizewordTable) -> NlptokenizewordTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_table_fill(s : NlptokenizewordTable, v : Double) -> NlptokenizewordTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_table_min(s : NlptokenizewordTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_table_max(s : NlptokenizewordTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_table_to_string(s : NlptokenizewordTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_graphn_make(size : Int) -> NlptokenizewordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_graphn_len(s : NlptokenizewordGraphN) -> Int { s.size }

pub fn nlp_tokenize_word_graphn_get(s : NlptokenizewordGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_graphn_set(s : NlptokenizewordGraphN, i : Int, v : Double) -> NlptokenizewordGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_graphn_sum(s : NlptokenizewordGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_graphn_mean(s : NlptokenizewordGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_graphn_scale(s : NlptokenizewordGraphN, f : Double) -> NlptokenizewordGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_graphn_add(a : NlptokenizewordGraphN, b : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_graphn_copy(s : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_graphn_fill(s : NlptokenizewordGraphN, v : Double) -> NlptokenizewordGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_graphn_min(s : NlptokenizewordGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_graphn_max(s : NlptokenizewordGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_graphn_to_string(s : NlptokenizewordGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_node_make(size : Int) -> NlptokenizewordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_node_len(s : NlptokenizewordNode) -> Int { s.size }

pub fn nlp_tokenize_word_node_get(s : NlptokenizewordNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_node_set(s : NlptokenizewordNode, i : Int, v : Double) -> NlptokenizewordNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_node_sum(s : NlptokenizewordNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_node_mean(s : NlptokenizewordNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_node_scale(s : NlptokenizewordNode, f : Double) -> NlptokenizewordNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_node_add(a : NlptokenizewordNode, b : NlptokenizewordNode) -> NlptokenizewordNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_node_copy(s : NlptokenizewordNode) -> NlptokenizewordNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_node_fill(s : NlptokenizewordNode, v : Double) -> NlptokenizewordNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_node_min(s : NlptokenizewordNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_node_max(s : NlptokenizewordNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_node_to_string(s : NlptokenizewordNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_edge_make(size : Int) -> NlptokenizewordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_edge_len(s : NlptokenizewordEdge) -> Int { s.size }

pub fn nlp_tokenize_word_edge_get(s : NlptokenizewordEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_edge_set(s : NlptokenizewordEdge, i : Int, v : Double) -> NlptokenizewordEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_edge_sum(s : NlptokenizewordEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_edge_mean(s : NlptokenizewordEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_edge_scale(s : NlptokenizewordEdge, f : Double) -> NlptokenizewordEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_edge_add(a : NlptokenizewordEdge, b : NlptokenizewordEdge) -> NlptokenizewordEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_edge_copy(s : NlptokenizewordEdge) -> NlptokenizewordEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_edge_fill(s : NlptokenizewordEdge, v : Double) -> NlptokenizewordEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_edge_min(s : NlptokenizewordEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_edge_max(s : NlptokenizewordEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_edge_to_string(s : NlptokenizewordEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_path_make(size : Int) -> NlptokenizewordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_path_len(s : NlptokenizewordPath) -> Int { s.size }

pub fn nlp_tokenize_word_path_get(s : NlptokenizewordPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_path_set(s : NlptokenizewordPath, i : Int, v : Double) -> NlptokenizewordPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_path_sum(s : NlptokenizewordPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_path_mean(s : NlptokenizewordPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_path_scale(s : NlptokenizewordPath, f : Double) -> NlptokenizewordPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_path_add(a : NlptokenizewordPath, b : NlptokenizewordPath) -> NlptokenizewordPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_path_copy(s : NlptokenizewordPath) -> NlptokenizewordPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_path_fill(s : NlptokenizewordPath, v : Double) -> NlptokenizewordPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_path_min(s : NlptokenizewordPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_path_max(s : NlptokenizewordPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_path_to_string(s : NlptokenizewordPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cluster_make(size : Int) -> NlptokenizewordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_cluster_len(s : NlptokenizewordCluster) -> Int { s.size }

pub fn nlp_tokenize_word_cluster_get(s : NlptokenizewordCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_cluster_set(s : NlptokenizewordCluster, i : Int, v : Double) -> NlptokenizewordCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cluster_sum(s : NlptokenizewordCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_cluster_mean(s : NlptokenizewordCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_cluster_scale(s : NlptokenizewordCluster, f : Double) -> NlptokenizewordCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cluster_add(a : NlptokenizewordCluster, b : NlptokenizewordCluster) -> NlptokenizewordCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_cluster_copy(s : NlptokenizewordCluster) -> NlptokenizewordCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cluster_fill(s : NlptokenizewordCluster, v : Double) -> NlptokenizewordCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cluster_min(s : NlptokenizewordCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_cluster_max(s : NlptokenizewordCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_cluster_to_string(s : NlptokenizewordCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_model_make(size : Int) -> NlptokenizewordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_model_len(s : NlptokenizewordModel) -> Int { s.size }

pub fn nlp_tokenize_word_model_get(s : NlptokenizewordModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_model_set(s : NlptokenizewordModel, i : Int, v : Double) -> NlptokenizewordModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_model_sum(s : NlptokenizewordModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_model_mean(s : NlptokenizewordModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_model_scale(s : NlptokenizewordModel, f : Double) -> NlptokenizewordModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_model_add(a : NlptokenizewordModel, b : NlptokenizewordModel) -> NlptokenizewordModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_model_copy(s : NlptokenizewordModel) -> NlptokenizewordModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_model_fill(s : NlptokenizewordModel, v : Double) -> NlptokenizewordModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_model_min(s : NlptokenizewordModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_model_max(s : NlptokenizewordModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_model_to_string(s : NlptokenizewordModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_layer_make(size : Int) -> NlptokenizewordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_layer_len(s : NlptokenizewordLayer) -> Int { s.size }

pub fn nlp_tokenize_word_layer_get(s : NlptokenizewordLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_layer_set(s : NlptokenizewordLayer, i : Int, v : Double) -> NlptokenizewordLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_layer_sum(s : NlptokenizewordLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_layer_mean(s : NlptokenizewordLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_layer_scale(s : NlptokenizewordLayer, f : Double) -> NlptokenizewordLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_layer_add(a : NlptokenizewordLayer, b : NlptokenizewordLayer) -> NlptokenizewordLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_layer_copy(s : NlptokenizewordLayer) -> NlptokenizewordLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_layer_fill(s : NlptokenizewordLayer, v : Double) -> NlptokenizewordLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_layer_min(s : NlptokenizewordLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_layer_max(s : NlptokenizewordLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_layer_to_string(s : NlptokenizewordLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_buffer_make(size : Int) -> NlptokenizewordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_buffer_len(s : NlptokenizewordBuffer) -> Int { s.size }

pub fn nlp_tokenize_word_buffer_get(s : NlptokenizewordBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_buffer_set(s : NlptokenizewordBuffer, i : Int, v : Double) -> NlptokenizewordBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_buffer_sum(s : NlptokenizewordBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_buffer_mean(s : NlptokenizewordBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_buffer_scale(s : NlptokenizewordBuffer, f : Double) -> NlptokenizewordBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_buffer_add(a : NlptokenizewordBuffer, b : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_buffer_copy(s : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_buffer_fill(s : NlptokenizewordBuffer, v : Double) -> NlptokenizewordBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_buffer_min(s : NlptokenizewordBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_buffer_max(s : NlptokenizewordBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_buffer_to_string(s : NlptokenizewordBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cursor_make(size : Int) -> NlptokenizewordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_cursor_len(s : NlptokenizewordCursor) -> Int { s.size }

pub fn nlp_tokenize_word_cursor_get(s : NlptokenizewordCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_cursor_set(s : NlptokenizewordCursor, i : Int, v : Double) -> NlptokenizewordCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cursor_sum(s : NlptokenizewordCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_cursor_mean(s : NlptokenizewordCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_cursor_scale(s : NlptokenizewordCursor, f : Double) -> NlptokenizewordCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cursor_add(a : NlptokenizewordCursor, b : NlptokenizewordCursor) -> NlptokenizewordCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_cursor_copy(s : NlptokenizewordCursor) -> NlptokenizewordCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cursor_fill(s : NlptokenizewordCursor, v : Double) -> NlptokenizewordCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_cursor_min(s : NlptokenizewordCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_cursor_max(s : NlptokenizewordCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_cursor_to_string(s : NlptokenizewordCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_view_make(size : Int) -> NlptokenizewordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_view_len(s : NlptokenizewordView) -> Int { s.size }

pub fn nlp_tokenize_word_view_get(s : NlptokenizewordView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_view_set(s : NlptokenizewordView, i : Int, v : Double) -> NlptokenizewordView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_view_sum(s : NlptokenizewordView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_view_mean(s : NlptokenizewordView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_view_scale(s : NlptokenizewordView, f : Double) -> NlptokenizewordView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_view_add(a : NlptokenizewordView, b : NlptokenizewordView) -> NlptokenizewordView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_view_copy(s : NlptokenizewordView) -> NlptokenizewordView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_view_fill(s : NlptokenizewordView, v : Double) -> NlptokenizewordView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_view_min(s : NlptokenizewordView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_view_max(s : NlptokenizewordView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_view_to_string(s : NlptokenizewordView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_range_make(size : Int) -> NlptokenizewordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_range_len(s : NlptokenizewordRange) -> Int { s.size }

pub fn nlp_tokenize_word_range_get(s : NlptokenizewordRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_range_set(s : NlptokenizewordRange, i : Int, v : Double) -> NlptokenizewordRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_range_sum(s : NlptokenizewordRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_range_mean(s : NlptokenizewordRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_range_scale(s : NlptokenizewordRange, f : Double) -> NlptokenizewordRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_range_add(a : NlptokenizewordRange, b : NlptokenizewordRange) -> NlptokenizewordRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_range_copy(s : NlptokenizewordRange) -> NlptokenizewordRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_range_fill(s : NlptokenizewordRange, v : Double) -> NlptokenizewordRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_range_min(s : NlptokenizewordRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_range_max(s : NlptokenizewordRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_range_to_string(s : NlptokenizewordRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_slice_make(size : Int) -> NlptokenizewordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_slice_len(s : NlptokenizewordSlice) -> Int { s.size }

pub fn nlp_tokenize_word_slice_get(s : NlptokenizewordSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_slice_set(s : NlptokenizewordSlice, i : Int, v : Double) -> NlptokenizewordSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_slice_sum(s : NlptokenizewordSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_word_slice_mean(s : NlptokenizewordSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_word_slice_scale(s : NlptokenizewordSlice, f : Double) -> NlptokenizewordSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_slice_add(a : NlptokenizewordSlice, b : NlptokenizewordSlice) -> NlptokenizewordSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_word_slice_copy(s : NlptokenizewordSlice) -> NlptokenizewordSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_slice_fill(s : NlptokenizewordSlice, v : Double) -> NlptokenizewordSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_word_slice_min(s : NlptokenizewordSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_word_slice_max(s : NlptokenizewordSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_word_slice_to_string(s : NlptokenizewordSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

