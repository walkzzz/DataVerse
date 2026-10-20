///===
/// extcore/nlp_tokenize_syllable

pub(all) struct NlptokenizesyllablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_syllable_make_point(x : Double, y : Double) -> NlptokenizesyllablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_syllable_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesyllablePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizesyllablePoint::x(self : NlptokenizesyllablePoint) -> Double { self.x }

pub fn NlptokenizesyllablePoint::y(self : NlptokenizesyllablePoint) -> Double { self.y }

pub fn NlptokenizesyllablePoint::z(self : NlptokenizesyllablePoint) -> Double { self.z }

pub fn NlptokenizesyllablePoint::label(self : NlptokenizesyllablePoint) -> Int { self.label }

pub fn NlptokenizesyllablePoint::dist(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizesyllablePoint::add(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizesyllablePoint::sub(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizesyllablePoint::scale(self : NlptokenizesyllablePoint, s : Double) -> NlptokenizesyllablePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizesyllablePoint::dot(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizesyllablePoint::cross(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizesyllablePoint::norm(self : NlptokenizesyllablePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizesyllablePoint::normalize(self : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesyllablePoint::negate(self : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizesyllablePoint::mid(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizesyllablePoint::lerp(self : NlptokenizesyllablePoint, other : NlptokenizesyllablePoint, t : Double) -> NlptokenizesyllablePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizesyllablePoint::to_string(self : NlptokenizesyllablePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizesyllableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_syllable_make_series(vals : Array[Double], name : String) -> NlptokenizesyllableSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizesyllableSeries::len(self : NlptokenizesyllableSeries) -> Int { self.vals.length() }

pub fn NlptokenizesyllableSeries::sum(self : NlptokenizesyllableSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizesyllableSeries::mean(self : NlptokenizesyllableSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizesyllableSeries::min(self : NlptokenizesyllableSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizesyllableSeries::max(self : NlptokenizesyllableSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizesyllableSeries::range(self : NlptokenizesyllableSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizesyllableSeries::variance(self : NlptokenizesyllableSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizesyllableSeries::std(self : NlptokenizesyllableSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizesyllableSeries::median(self : NlptokenizesyllableSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizesyllableSeries::scale(self : NlptokenizesyllableSeries, f : Double) -> NlptokenizesyllableSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizesyllableSeries::add(self : NlptokenizesyllableSeries, other : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizesyllableSeries::sub(self : NlptokenizesyllableSeries, other : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizesyllableSeries::normalize(self : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizesyllableSeries::cumsum(self : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizesyllableSeries::to_string(self : NlptokenizesyllableSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesyllableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_syllable_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesyllableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_syllable_matrix_identity(n : Int) -> NlptokenizesyllableMatrix {
  let m = nlp_tokenize_syllable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizesyllableMatrix::get(self : NlptokenizesyllableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizesyllableMatrix::transpose(self : NlptokenizesyllableMatrix) -> NlptokenizesyllableMatrix {
  let result = nlp_tokenize_syllable_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizesyllableMatrix::add(self : NlptokenizesyllableMatrix, other : NlptokenizesyllableMatrix) -> NlptokenizesyllableMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_syllable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizesyllableMatrix::scale(self : NlptokenizesyllableMatrix, s : Double) -> NlptokenizesyllableMatrix {
  let result = nlp_tokenize_syllable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizesyllableMatrix::multiply(self : NlptokenizesyllableMatrix, other : NlptokenizesyllableMatrix) -> NlptokenizesyllableMatrix {
  if self.cols != other.rows { return nlp_tokenize_syllable_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_syllable_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizesyllableMatrix::trace(self : NlptokenizesyllableMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizesyllableMatrix::det(self : NlptokenizesyllableMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizesyllableMatrix::norm(self : NlptokenizesyllableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizesyllableMatrix::to_string(self : NlptokenizesyllableMatrix) -> String {
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

pub(all) struct NlptokenizesyllableVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_syllable_make_vector(comps : Array[Double]) -> NlptokenizesyllableVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_syllable_vector_zero(dim : Int) -> NlptokenizesyllableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizesyllableVector::add(self : NlptokenizesyllableVector, other : NlptokenizesyllableVector) -> NlptokenizesyllableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesyllableVector::sub(self : NlptokenizesyllableVector, other : NlptokenizesyllableVector) -> NlptokenizesyllableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesyllableVector::scale(self : NlptokenizesyllableVector, s : Double) -> NlptokenizesyllableVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizesyllableVector::dot(self : NlptokenizesyllableVector, other : NlptokenizesyllableVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizesyllableVector::norm(self : NlptokenizesyllableVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizesyllableVector::normalize(self : NlptokenizesyllableVector) -> NlptokenizesyllableVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesyllableVector::dist(self : NlptokenizesyllableVector, other : NlptokenizesyllableVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizesyllableVector::to_string(self : NlptokenizesyllableVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_syllable_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_syllable_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_syllable_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_syllable_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_syllable_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_syllable_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_syllable_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_syllable_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_syllable_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_syllable_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_syllable_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_syllable_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_syllable_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_syllable_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_syllable_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_syllable_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_syllable_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_syllable_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_syllable_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_syllable_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_syllable_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_syllable_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_syllable_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_syllable_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_syllable_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_syllable_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_syllable_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_syllable_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_syllable_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizesyllableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_frame_make(size : Int) -> NlptokenizesyllableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_frame_len(s : NlptokenizesyllableFrame) -> Int { s.size }

pub fn nlp_tokenize_syllable_frame_get(s : NlptokenizesyllableFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_frame_set(s : NlptokenizesyllableFrame, i : Int, v : Double) -> NlptokenizesyllableFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_frame_sum(s : NlptokenizesyllableFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_frame_mean(s : NlptokenizesyllableFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_frame_scale(s : NlptokenizesyllableFrame, f : Double) -> NlptokenizesyllableFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_frame_add(a : NlptokenizesyllableFrame, b : NlptokenizesyllableFrame) -> NlptokenizesyllableFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_frame_copy(s : NlptokenizesyllableFrame) -> NlptokenizesyllableFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_frame_fill(s : NlptokenizesyllableFrame, v : Double) -> NlptokenizesyllableFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_frame_min(s : NlptokenizesyllableFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_frame_max(s : NlptokenizesyllableFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_frame_to_string(s : NlptokenizesyllableFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_table_make(size : Int) -> NlptokenizesyllableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_table_len(s : NlptokenizesyllableTable) -> Int { s.size }

pub fn nlp_tokenize_syllable_table_get(s : NlptokenizesyllableTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_table_set(s : NlptokenizesyllableTable, i : Int, v : Double) -> NlptokenizesyllableTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_table_sum(s : NlptokenizesyllableTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_table_mean(s : NlptokenizesyllableTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_table_scale(s : NlptokenizesyllableTable, f : Double) -> NlptokenizesyllableTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_table_add(a : NlptokenizesyllableTable, b : NlptokenizesyllableTable) -> NlptokenizesyllableTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_table_copy(s : NlptokenizesyllableTable) -> NlptokenizesyllableTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_table_fill(s : NlptokenizesyllableTable, v : Double) -> NlptokenizesyllableTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_table_min(s : NlptokenizesyllableTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_table_max(s : NlptokenizesyllableTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_table_to_string(s : NlptokenizesyllableTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_graphn_make(size : Int) -> NlptokenizesyllableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_graphn_len(s : NlptokenizesyllableGraphN) -> Int { s.size }

pub fn nlp_tokenize_syllable_graphn_get(s : NlptokenizesyllableGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_graphn_set(s : NlptokenizesyllableGraphN, i : Int, v : Double) -> NlptokenizesyllableGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_graphn_sum(s : NlptokenizesyllableGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_graphn_mean(s : NlptokenizesyllableGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_graphn_scale(s : NlptokenizesyllableGraphN, f : Double) -> NlptokenizesyllableGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_graphn_add(a : NlptokenizesyllableGraphN, b : NlptokenizesyllableGraphN) -> NlptokenizesyllableGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_graphn_copy(s : NlptokenizesyllableGraphN) -> NlptokenizesyllableGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_graphn_fill(s : NlptokenizesyllableGraphN, v : Double) -> NlptokenizesyllableGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_graphn_min(s : NlptokenizesyllableGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_graphn_max(s : NlptokenizesyllableGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_graphn_to_string(s : NlptokenizesyllableGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_node_make(size : Int) -> NlptokenizesyllableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_node_len(s : NlptokenizesyllableNode) -> Int { s.size }

pub fn nlp_tokenize_syllable_node_get(s : NlptokenizesyllableNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_node_set(s : NlptokenizesyllableNode, i : Int, v : Double) -> NlptokenizesyllableNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_node_sum(s : NlptokenizesyllableNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_node_mean(s : NlptokenizesyllableNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_node_scale(s : NlptokenizesyllableNode, f : Double) -> NlptokenizesyllableNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_node_add(a : NlptokenizesyllableNode, b : NlptokenizesyllableNode) -> NlptokenizesyllableNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_node_copy(s : NlptokenizesyllableNode) -> NlptokenizesyllableNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_node_fill(s : NlptokenizesyllableNode, v : Double) -> NlptokenizesyllableNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_node_min(s : NlptokenizesyllableNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_node_max(s : NlptokenizesyllableNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_node_to_string(s : NlptokenizesyllableNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_edge_make(size : Int) -> NlptokenizesyllableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_edge_len(s : NlptokenizesyllableEdge) -> Int { s.size }

pub fn nlp_tokenize_syllable_edge_get(s : NlptokenizesyllableEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_edge_set(s : NlptokenizesyllableEdge, i : Int, v : Double) -> NlptokenizesyllableEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_edge_sum(s : NlptokenizesyllableEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_edge_mean(s : NlptokenizesyllableEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_edge_scale(s : NlptokenizesyllableEdge, f : Double) -> NlptokenizesyllableEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_edge_add(a : NlptokenizesyllableEdge, b : NlptokenizesyllableEdge) -> NlptokenizesyllableEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_edge_copy(s : NlptokenizesyllableEdge) -> NlptokenizesyllableEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_edge_fill(s : NlptokenizesyllableEdge, v : Double) -> NlptokenizesyllableEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_edge_min(s : NlptokenizesyllableEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_edge_max(s : NlptokenizesyllableEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_edge_to_string(s : NlptokenizesyllableEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_path_make(size : Int) -> NlptokenizesyllablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_path_len(s : NlptokenizesyllablePath) -> Int { s.size }

pub fn nlp_tokenize_syllable_path_get(s : NlptokenizesyllablePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_path_set(s : NlptokenizesyllablePath, i : Int, v : Double) -> NlptokenizesyllablePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_path_sum(s : NlptokenizesyllablePath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_path_mean(s : NlptokenizesyllablePath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_path_scale(s : NlptokenizesyllablePath, f : Double) -> NlptokenizesyllablePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_path_add(a : NlptokenizesyllablePath, b : NlptokenizesyllablePath) -> NlptokenizesyllablePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_path_copy(s : NlptokenizesyllablePath) -> NlptokenizesyllablePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_path_fill(s : NlptokenizesyllablePath, v : Double) -> NlptokenizesyllablePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_path_min(s : NlptokenizesyllablePath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_path_max(s : NlptokenizesyllablePath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_path_to_string(s : NlptokenizesyllablePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_cluster_make(size : Int) -> NlptokenizesyllableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_cluster_len(s : NlptokenizesyllableCluster) -> Int { s.size }

pub fn nlp_tokenize_syllable_cluster_get(s : NlptokenizesyllableCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_cluster_set(s : NlptokenizesyllableCluster, i : Int, v : Double) -> NlptokenizesyllableCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cluster_sum(s : NlptokenizesyllableCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_cluster_mean(s : NlptokenizesyllableCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_cluster_scale(s : NlptokenizesyllableCluster, f : Double) -> NlptokenizesyllableCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cluster_add(a : NlptokenizesyllableCluster, b : NlptokenizesyllableCluster) -> NlptokenizesyllableCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_cluster_copy(s : NlptokenizesyllableCluster) -> NlptokenizesyllableCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cluster_fill(s : NlptokenizesyllableCluster, v : Double) -> NlptokenizesyllableCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cluster_min(s : NlptokenizesyllableCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_cluster_max(s : NlptokenizesyllableCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_cluster_to_string(s : NlptokenizesyllableCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_model_make(size : Int) -> NlptokenizesyllableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_model_len(s : NlptokenizesyllableModel) -> Int { s.size }

pub fn nlp_tokenize_syllable_model_get(s : NlptokenizesyllableModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_model_set(s : NlptokenizesyllableModel, i : Int, v : Double) -> NlptokenizesyllableModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_model_sum(s : NlptokenizesyllableModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_model_mean(s : NlptokenizesyllableModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_model_scale(s : NlptokenizesyllableModel, f : Double) -> NlptokenizesyllableModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_model_add(a : NlptokenizesyllableModel, b : NlptokenizesyllableModel) -> NlptokenizesyllableModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_model_copy(s : NlptokenizesyllableModel) -> NlptokenizesyllableModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_model_fill(s : NlptokenizesyllableModel, v : Double) -> NlptokenizesyllableModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_model_min(s : NlptokenizesyllableModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_model_max(s : NlptokenizesyllableModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_model_to_string(s : NlptokenizesyllableModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_layer_make(size : Int) -> NlptokenizesyllableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_layer_len(s : NlptokenizesyllableLayer) -> Int { s.size }

pub fn nlp_tokenize_syllable_layer_get(s : NlptokenizesyllableLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_layer_set(s : NlptokenizesyllableLayer, i : Int, v : Double) -> NlptokenizesyllableLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_layer_sum(s : NlptokenizesyllableLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_layer_mean(s : NlptokenizesyllableLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_layer_scale(s : NlptokenizesyllableLayer, f : Double) -> NlptokenizesyllableLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_layer_add(a : NlptokenizesyllableLayer, b : NlptokenizesyllableLayer) -> NlptokenizesyllableLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_layer_copy(s : NlptokenizesyllableLayer) -> NlptokenizesyllableLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_layer_fill(s : NlptokenizesyllableLayer, v : Double) -> NlptokenizesyllableLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_layer_min(s : NlptokenizesyllableLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_layer_max(s : NlptokenizesyllableLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_layer_to_string(s : NlptokenizesyllableLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_buffer_make(size : Int) -> NlptokenizesyllableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_buffer_len(s : NlptokenizesyllableBuffer) -> Int { s.size }

pub fn nlp_tokenize_syllable_buffer_get(s : NlptokenizesyllableBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_buffer_set(s : NlptokenizesyllableBuffer, i : Int, v : Double) -> NlptokenizesyllableBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_buffer_sum(s : NlptokenizesyllableBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_buffer_mean(s : NlptokenizesyllableBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_buffer_scale(s : NlptokenizesyllableBuffer, f : Double) -> NlptokenizesyllableBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_buffer_add(a : NlptokenizesyllableBuffer, b : NlptokenizesyllableBuffer) -> NlptokenizesyllableBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_buffer_copy(s : NlptokenizesyllableBuffer) -> NlptokenizesyllableBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_buffer_fill(s : NlptokenizesyllableBuffer, v : Double) -> NlptokenizesyllableBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_buffer_min(s : NlptokenizesyllableBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_buffer_max(s : NlptokenizesyllableBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_buffer_to_string(s : NlptokenizesyllableBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_cursor_make(size : Int) -> NlptokenizesyllableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_cursor_len(s : NlptokenizesyllableCursor) -> Int { s.size }

pub fn nlp_tokenize_syllable_cursor_get(s : NlptokenizesyllableCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_cursor_set(s : NlptokenizesyllableCursor, i : Int, v : Double) -> NlptokenizesyllableCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cursor_sum(s : NlptokenizesyllableCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_cursor_mean(s : NlptokenizesyllableCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_cursor_scale(s : NlptokenizesyllableCursor, f : Double) -> NlptokenizesyllableCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cursor_add(a : NlptokenizesyllableCursor, b : NlptokenizesyllableCursor) -> NlptokenizesyllableCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_cursor_copy(s : NlptokenizesyllableCursor) -> NlptokenizesyllableCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cursor_fill(s : NlptokenizesyllableCursor, v : Double) -> NlptokenizesyllableCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_cursor_min(s : NlptokenizesyllableCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_cursor_max(s : NlptokenizesyllableCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_cursor_to_string(s : NlptokenizesyllableCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_view_make(size : Int) -> NlptokenizesyllableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_view_len(s : NlptokenizesyllableView) -> Int { s.size }

pub fn nlp_tokenize_syllable_view_get(s : NlptokenizesyllableView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_view_set(s : NlptokenizesyllableView, i : Int, v : Double) -> NlptokenizesyllableView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_view_sum(s : NlptokenizesyllableView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_view_mean(s : NlptokenizesyllableView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_view_scale(s : NlptokenizesyllableView, f : Double) -> NlptokenizesyllableView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_view_add(a : NlptokenizesyllableView, b : NlptokenizesyllableView) -> NlptokenizesyllableView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_view_copy(s : NlptokenizesyllableView) -> NlptokenizesyllableView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_view_fill(s : NlptokenizesyllableView, v : Double) -> NlptokenizesyllableView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_view_min(s : NlptokenizesyllableView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_view_max(s : NlptokenizesyllableView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_view_to_string(s : NlptokenizesyllableView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_range_make(size : Int) -> NlptokenizesyllableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_range_len(s : NlptokenizesyllableRange) -> Int { s.size }

pub fn nlp_tokenize_syllable_range_get(s : NlptokenizesyllableRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_range_set(s : NlptokenizesyllableRange, i : Int, v : Double) -> NlptokenizesyllableRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_range_sum(s : NlptokenizesyllableRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_range_mean(s : NlptokenizesyllableRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_range_scale(s : NlptokenizesyllableRange, f : Double) -> NlptokenizesyllableRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_range_add(a : NlptokenizesyllableRange, b : NlptokenizesyllableRange) -> NlptokenizesyllableRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_range_copy(s : NlptokenizesyllableRange) -> NlptokenizesyllableRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_range_fill(s : NlptokenizesyllableRange, v : Double) -> NlptokenizesyllableRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_range_min(s : NlptokenizesyllableRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_range_max(s : NlptokenizesyllableRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_range_to_string(s : NlptokenizesyllableRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_slice_make(size : Int) -> NlptokenizesyllableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_slice_len(s : NlptokenizesyllableSlice) -> Int { s.size }

pub fn nlp_tokenize_syllable_slice_get(s : NlptokenizesyllableSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_slice_set(s : NlptokenizesyllableSlice, i : Int, v : Double) -> NlptokenizesyllableSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_slice_sum(s : NlptokenizesyllableSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_syllable_slice_mean(s : NlptokenizesyllableSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_syllable_slice_scale(s : NlptokenizesyllableSlice, f : Double) -> NlptokenizesyllableSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_slice_add(a : NlptokenizesyllableSlice, b : NlptokenizesyllableSlice) -> NlptokenizesyllableSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_syllable_slice_copy(s : NlptokenizesyllableSlice) -> NlptokenizesyllableSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_slice_fill(s : NlptokenizesyllableSlice, v : Double) -> NlptokenizesyllableSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_syllable_slice_min(s : NlptokenizesyllableSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_syllable_slice_max(s : NlptokenizesyllableSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_syllable_slice_to_string(s : NlptokenizesyllableSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

