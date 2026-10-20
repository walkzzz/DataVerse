///===
/// extcore/nlp_tokenize_unigram

pub(all) struct NlptokenizeunigramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_unigram_make_point(x : Double, y : Double) -> NlptokenizeunigramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_unigram_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeunigramPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizeunigramPoint::x(self : NlptokenizeunigramPoint) -> Double { self.x }

pub fn NlptokenizeunigramPoint::y(self : NlptokenizeunigramPoint) -> Double { self.y }

pub fn NlptokenizeunigramPoint::z(self : NlptokenizeunigramPoint) -> Double { self.z }

pub fn NlptokenizeunigramPoint::label(self : NlptokenizeunigramPoint) -> Int { self.label }

pub fn NlptokenizeunigramPoint::dist(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizeunigramPoint::add(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizeunigramPoint::sub(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizeunigramPoint::scale(self : NlptokenizeunigramPoint, s : Double) -> NlptokenizeunigramPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizeunigramPoint::dot(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizeunigramPoint::cross(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizeunigramPoint::norm(self : NlptokenizeunigramPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizeunigramPoint::normalize(self : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeunigramPoint::negate(self : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizeunigramPoint::mid(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizeunigramPoint::lerp(self : NlptokenizeunigramPoint, other : NlptokenizeunigramPoint, t : Double) -> NlptokenizeunigramPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizeunigramPoint::to_string(self : NlptokenizeunigramPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_unigram_make_series(vals : Array[Double], name : String) -> NlptokenizeunigramSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizeunigramSeries::len(self : NlptokenizeunigramSeries) -> Int { self.vals.length() }

pub fn NlptokenizeunigramSeries::sum(self : NlptokenizeunigramSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizeunigramSeries::mean(self : NlptokenizeunigramSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizeunigramSeries::min(self : NlptokenizeunigramSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizeunigramSeries::max(self : NlptokenizeunigramSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizeunigramSeries::range(self : NlptokenizeunigramSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizeunigramSeries::variance(self : NlptokenizeunigramSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizeunigramSeries::std(self : NlptokenizeunigramSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizeunigramSeries::median(self : NlptokenizeunigramSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizeunigramSeries::scale(self : NlptokenizeunigramSeries, f : Double) -> NlptokenizeunigramSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizeunigramSeries::add(self : NlptokenizeunigramSeries, other : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizeunigramSeries::sub(self : NlptokenizeunigramSeries, other : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizeunigramSeries::normalize(self : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizeunigramSeries::cumsum(self : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizeunigramSeries::to_string(self : NlptokenizeunigramSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeunigramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_unigram_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeunigramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_unigram_matrix_identity(n : Int) -> NlptokenizeunigramMatrix {
  let m = nlp_tokenize_unigram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizeunigramMatrix::get(self : NlptokenizeunigramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizeunigramMatrix::transpose(self : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizeunigramMatrix::add(self : NlptokenizeunigramMatrix, other : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_unigram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizeunigramMatrix::scale(self : NlptokenizeunigramMatrix, s : Double) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizeunigramMatrix::multiply(self : NlptokenizeunigramMatrix, other : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if self.cols != other.rows { return nlp_tokenize_unigram_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_unigram_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizeunigramMatrix::trace(self : NlptokenizeunigramMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizeunigramMatrix::det(self : NlptokenizeunigramMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizeunigramMatrix::norm(self : NlptokenizeunigramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizeunigramMatrix::to_string(self : NlptokenizeunigramMatrix) -> String {
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

pub(all) struct NlptokenizeunigramVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_unigram_make_vector(comps : Array[Double]) -> NlptokenizeunigramVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_unigram_vector_zero(dim : Int) -> NlptokenizeunigramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizeunigramVector::add(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeunigramVector::sub(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizeunigramVector::scale(self : NlptokenizeunigramVector, s : Double) -> NlptokenizeunigramVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizeunigramVector::dot(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizeunigramVector::norm(self : NlptokenizeunigramVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizeunigramVector::normalize(self : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizeunigramVector::dist(self : NlptokenizeunigramVector, other : NlptokenizeunigramVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizeunigramVector::to_string(self : NlptokenizeunigramVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_unigram_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_unigram_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_unigram_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_unigram_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_unigram_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_unigram_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_unigram_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_unigram_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_unigram_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_unigram_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_unigram_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_unigram_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_unigram_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_unigram_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_unigram_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_unigram_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_unigram_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_unigram_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_unigram_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_unigram_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_unigram_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_unigram_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_unigram_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_unigram_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_unigram_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_unigram_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_unigram_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_unigram_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_unigram_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizeunigramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_frame_make(size : Int) -> NlptokenizeunigramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_frame_len(s : NlptokenizeunigramFrame) -> Int { s.size }

pub fn nlp_tokenize_unigram_frame_get(s : NlptokenizeunigramFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_frame_set(s : NlptokenizeunigramFrame, i : Int, v : Double) -> NlptokenizeunigramFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_sum(s : NlptokenizeunigramFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_frame_mean(s : NlptokenizeunigramFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_frame_scale(s : NlptokenizeunigramFrame, f : Double) -> NlptokenizeunigramFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_add(a : NlptokenizeunigramFrame, b : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_frame_copy(s : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_fill(s : NlptokenizeunigramFrame, v : Double) -> NlptokenizeunigramFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_frame_min(s : NlptokenizeunigramFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_frame_max(s : NlptokenizeunigramFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_frame_to_string(s : NlptokenizeunigramFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_table_make(size : Int) -> NlptokenizeunigramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_table_len(s : NlptokenizeunigramTable) -> Int { s.size }

pub fn nlp_tokenize_unigram_table_get(s : NlptokenizeunigramTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_table_set(s : NlptokenizeunigramTable, i : Int, v : Double) -> NlptokenizeunigramTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_sum(s : NlptokenizeunigramTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_table_mean(s : NlptokenizeunigramTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_table_scale(s : NlptokenizeunigramTable, f : Double) -> NlptokenizeunigramTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_add(a : NlptokenizeunigramTable, b : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_table_copy(s : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_fill(s : NlptokenizeunigramTable, v : Double) -> NlptokenizeunigramTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_table_min(s : NlptokenizeunigramTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_table_max(s : NlptokenizeunigramTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_table_to_string(s : NlptokenizeunigramTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_graphn_make(size : Int) -> NlptokenizeunigramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_graphn_len(s : NlptokenizeunigramGraphN) -> Int { s.size }

pub fn nlp_tokenize_unigram_graphn_get(s : NlptokenizeunigramGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_graphn_set(s : NlptokenizeunigramGraphN, i : Int, v : Double) -> NlptokenizeunigramGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_sum(s : NlptokenizeunigramGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_graphn_mean(s : NlptokenizeunigramGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_graphn_scale(s : NlptokenizeunigramGraphN, f : Double) -> NlptokenizeunigramGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_add(a : NlptokenizeunigramGraphN, b : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_graphn_copy(s : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_fill(s : NlptokenizeunigramGraphN, v : Double) -> NlptokenizeunigramGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_graphn_min(s : NlptokenizeunigramGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_graphn_max(s : NlptokenizeunigramGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_graphn_to_string(s : NlptokenizeunigramGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_node_make(size : Int) -> NlptokenizeunigramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_node_len(s : NlptokenizeunigramNode) -> Int { s.size }

pub fn nlp_tokenize_unigram_node_get(s : NlptokenizeunigramNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_node_set(s : NlptokenizeunigramNode, i : Int, v : Double) -> NlptokenizeunigramNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_sum(s : NlptokenizeunigramNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_node_mean(s : NlptokenizeunigramNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_node_scale(s : NlptokenizeunigramNode, f : Double) -> NlptokenizeunigramNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_add(a : NlptokenizeunigramNode, b : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_node_copy(s : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_fill(s : NlptokenizeunigramNode, v : Double) -> NlptokenizeunigramNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_node_min(s : NlptokenizeunigramNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_node_max(s : NlptokenizeunigramNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_node_to_string(s : NlptokenizeunigramNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_edge_make(size : Int) -> NlptokenizeunigramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_edge_len(s : NlptokenizeunigramEdge) -> Int { s.size }

pub fn nlp_tokenize_unigram_edge_get(s : NlptokenizeunigramEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_edge_set(s : NlptokenizeunigramEdge, i : Int, v : Double) -> NlptokenizeunigramEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_sum(s : NlptokenizeunigramEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_edge_mean(s : NlptokenizeunigramEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_edge_scale(s : NlptokenizeunigramEdge, f : Double) -> NlptokenizeunigramEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_add(a : NlptokenizeunigramEdge, b : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_edge_copy(s : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_fill(s : NlptokenizeunigramEdge, v : Double) -> NlptokenizeunigramEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_edge_min(s : NlptokenizeunigramEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_edge_max(s : NlptokenizeunigramEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_edge_to_string(s : NlptokenizeunigramEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_path_make(size : Int) -> NlptokenizeunigramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_path_len(s : NlptokenizeunigramPath) -> Int { s.size }

pub fn nlp_tokenize_unigram_path_get(s : NlptokenizeunigramPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_path_set(s : NlptokenizeunigramPath, i : Int, v : Double) -> NlptokenizeunigramPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_sum(s : NlptokenizeunigramPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_path_mean(s : NlptokenizeunigramPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_path_scale(s : NlptokenizeunigramPath, f : Double) -> NlptokenizeunigramPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_add(a : NlptokenizeunigramPath, b : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_path_copy(s : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_fill(s : NlptokenizeunigramPath, v : Double) -> NlptokenizeunigramPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_path_min(s : NlptokenizeunigramPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_path_max(s : NlptokenizeunigramPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_path_to_string(s : NlptokenizeunigramPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cluster_make(size : Int) -> NlptokenizeunigramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_cluster_len(s : NlptokenizeunigramCluster) -> Int { s.size }

pub fn nlp_tokenize_unigram_cluster_get(s : NlptokenizeunigramCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_cluster_set(s : NlptokenizeunigramCluster, i : Int, v : Double) -> NlptokenizeunigramCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_sum(s : NlptokenizeunigramCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_cluster_mean(s : NlptokenizeunigramCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_cluster_scale(s : NlptokenizeunigramCluster, f : Double) -> NlptokenizeunigramCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_add(a : NlptokenizeunigramCluster, b : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_cluster_copy(s : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_fill(s : NlptokenizeunigramCluster, v : Double) -> NlptokenizeunigramCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cluster_min(s : NlptokenizeunigramCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_cluster_max(s : NlptokenizeunigramCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_cluster_to_string(s : NlptokenizeunigramCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_model_make(size : Int) -> NlptokenizeunigramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_model_len(s : NlptokenizeunigramModel) -> Int { s.size }

pub fn nlp_tokenize_unigram_model_get(s : NlptokenizeunigramModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_model_set(s : NlptokenizeunigramModel, i : Int, v : Double) -> NlptokenizeunigramModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_sum(s : NlptokenizeunigramModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_model_mean(s : NlptokenizeunigramModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_model_scale(s : NlptokenizeunigramModel, f : Double) -> NlptokenizeunigramModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_add(a : NlptokenizeunigramModel, b : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_model_copy(s : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_fill(s : NlptokenizeunigramModel, v : Double) -> NlptokenizeunigramModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_model_min(s : NlptokenizeunigramModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_model_max(s : NlptokenizeunigramModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_model_to_string(s : NlptokenizeunigramModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_layer_make(size : Int) -> NlptokenizeunigramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_layer_len(s : NlptokenizeunigramLayer) -> Int { s.size }

pub fn nlp_tokenize_unigram_layer_get(s : NlptokenizeunigramLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_layer_set(s : NlptokenizeunigramLayer, i : Int, v : Double) -> NlptokenizeunigramLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_sum(s : NlptokenizeunigramLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_layer_mean(s : NlptokenizeunigramLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_layer_scale(s : NlptokenizeunigramLayer, f : Double) -> NlptokenizeunigramLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_add(a : NlptokenizeunigramLayer, b : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_layer_copy(s : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_fill(s : NlptokenizeunigramLayer, v : Double) -> NlptokenizeunigramLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_layer_min(s : NlptokenizeunigramLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_layer_max(s : NlptokenizeunigramLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_layer_to_string(s : NlptokenizeunigramLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_buffer_make(size : Int) -> NlptokenizeunigramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_buffer_len(s : NlptokenizeunigramBuffer) -> Int { s.size }

pub fn nlp_tokenize_unigram_buffer_get(s : NlptokenizeunigramBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_buffer_set(s : NlptokenizeunigramBuffer, i : Int, v : Double) -> NlptokenizeunigramBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_sum(s : NlptokenizeunigramBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_buffer_mean(s : NlptokenizeunigramBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_buffer_scale(s : NlptokenizeunigramBuffer, f : Double) -> NlptokenizeunigramBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_add(a : NlptokenizeunigramBuffer, b : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_buffer_copy(s : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_fill(s : NlptokenizeunigramBuffer, v : Double) -> NlptokenizeunigramBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_buffer_min(s : NlptokenizeunigramBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_buffer_max(s : NlptokenizeunigramBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_buffer_to_string(s : NlptokenizeunigramBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cursor_make(size : Int) -> NlptokenizeunigramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_cursor_len(s : NlptokenizeunigramCursor) -> Int { s.size }

pub fn nlp_tokenize_unigram_cursor_get(s : NlptokenizeunigramCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_cursor_set(s : NlptokenizeunigramCursor, i : Int, v : Double) -> NlptokenizeunigramCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_sum(s : NlptokenizeunigramCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_cursor_mean(s : NlptokenizeunigramCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_cursor_scale(s : NlptokenizeunigramCursor, f : Double) -> NlptokenizeunigramCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_add(a : NlptokenizeunigramCursor, b : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_cursor_copy(s : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_fill(s : NlptokenizeunigramCursor, v : Double) -> NlptokenizeunigramCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_cursor_min(s : NlptokenizeunigramCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_cursor_max(s : NlptokenizeunigramCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_cursor_to_string(s : NlptokenizeunigramCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_view_make(size : Int) -> NlptokenizeunigramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_view_len(s : NlptokenizeunigramView) -> Int { s.size }

pub fn nlp_tokenize_unigram_view_get(s : NlptokenizeunigramView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_view_set(s : NlptokenizeunigramView, i : Int, v : Double) -> NlptokenizeunigramView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_sum(s : NlptokenizeunigramView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_view_mean(s : NlptokenizeunigramView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_view_scale(s : NlptokenizeunigramView, f : Double) -> NlptokenizeunigramView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_add(a : NlptokenizeunigramView, b : NlptokenizeunigramView) -> NlptokenizeunigramView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_view_copy(s : NlptokenizeunigramView) -> NlptokenizeunigramView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_fill(s : NlptokenizeunigramView, v : Double) -> NlptokenizeunigramView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_view_min(s : NlptokenizeunigramView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_view_max(s : NlptokenizeunigramView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_view_to_string(s : NlptokenizeunigramView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_range_make(size : Int) -> NlptokenizeunigramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_range_len(s : NlptokenizeunigramRange) -> Int { s.size }

pub fn nlp_tokenize_unigram_range_get(s : NlptokenizeunigramRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_range_set(s : NlptokenizeunigramRange, i : Int, v : Double) -> NlptokenizeunigramRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_sum(s : NlptokenizeunigramRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_range_mean(s : NlptokenizeunigramRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_range_scale(s : NlptokenizeunigramRange, f : Double) -> NlptokenizeunigramRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_add(a : NlptokenizeunigramRange, b : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_range_copy(s : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_fill(s : NlptokenizeunigramRange, v : Double) -> NlptokenizeunigramRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_range_min(s : NlptokenizeunigramRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_range_max(s : NlptokenizeunigramRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_range_to_string(s : NlptokenizeunigramRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_slice_make(size : Int) -> NlptokenizeunigramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_slice_len(s : NlptokenizeunigramSlice) -> Int { s.size }

pub fn nlp_tokenize_unigram_slice_get(s : NlptokenizeunigramSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_slice_set(s : NlptokenizeunigramSlice, i : Int, v : Double) -> NlptokenizeunigramSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_sum(s : NlptokenizeunigramSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_unigram_slice_mean(s : NlptokenizeunigramSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_unigram_slice_scale(s : NlptokenizeunigramSlice, f : Double) -> NlptokenizeunigramSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_add(a : NlptokenizeunigramSlice, b : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_unigram_slice_copy(s : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_fill(s : NlptokenizeunigramSlice, v : Double) -> NlptokenizeunigramSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_unigram_slice_min(s : NlptokenizeunigramSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_unigram_slice_max(s : NlptokenizeunigramSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_unigram_slice_to_string(s : NlptokenizeunigramSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

