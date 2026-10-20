///===
/// extcore/nlp_tokenize_subword

pub(all) struct NlptokenizesubwordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_subword_make_point(x : Double, y : Double) -> NlptokenizesubwordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_subword_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesubwordPoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizesubwordPoint::x(self : NlptokenizesubwordPoint) -> Double { self.x }

pub fn NlptokenizesubwordPoint::y(self : NlptokenizesubwordPoint) -> Double { self.y }

pub fn NlptokenizesubwordPoint::z(self : NlptokenizesubwordPoint) -> Double { self.z }

pub fn NlptokenizesubwordPoint::label(self : NlptokenizesubwordPoint) -> Int { self.label }

pub fn NlptokenizesubwordPoint::dist(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizesubwordPoint::add(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizesubwordPoint::sub(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizesubwordPoint::scale(self : NlptokenizesubwordPoint, s : Double) -> NlptokenizesubwordPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizesubwordPoint::dot(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizesubwordPoint::cross(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizesubwordPoint::norm(self : NlptokenizesubwordPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizesubwordPoint::normalize(self : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesubwordPoint::negate(self : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizesubwordPoint::mid(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint) -> NlptokenizesubwordPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizesubwordPoint::lerp(self : NlptokenizesubwordPoint, other : NlptokenizesubwordPoint, t : Double) -> NlptokenizesubwordPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizesubwordPoint::to_string(self : NlptokenizesubwordPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizesubwordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_subword_make_series(vals : Array[Double], name : String) -> NlptokenizesubwordSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizesubwordSeries::len(self : NlptokenizesubwordSeries) -> Int { self.vals.length() }

pub fn NlptokenizesubwordSeries::sum(self : NlptokenizesubwordSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizesubwordSeries::mean(self : NlptokenizesubwordSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizesubwordSeries::min(self : NlptokenizesubwordSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizesubwordSeries::max(self : NlptokenizesubwordSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizesubwordSeries::range(self : NlptokenizesubwordSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizesubwordSeries::variance(self : NlptokenizesubwordSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizesubwordSeries::std(self : NlptokenizesubwordSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizesubwordSeries::median(self : NlptokenizesubwordSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizesubwordSeries::scale(self : NlptokenizesubwordSeries, f : Double) -> NlptokenizesubwordSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizesubwordSeries::add(self : NlptokenizesubwordSeries, other : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizesubwordSeries::sub(self : NlptokenizesubwordSeries, other : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizesubwordSeries::normalize(self : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizesubwordSeries::cumsum(self : NlptokenizesubwordSeries) -> NlptokenizesubwordSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizesubwordSeries::to_string(self : NlptokenizesubwordSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesubwordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_subword_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesubwordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_subword_matrix_identity(n : Int) -> NlptokenizesubwordMatrix {
  let m = nlp_tokenize_subword_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizesubwordMatrix::get(self : NlptokenizesubwordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizesubwordMatrix::transpose(self : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  let result = nlp_tokenize_subword_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizesubwordMatrix::add(self : NlptokenizesubwordMatrix, other : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_subword_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizesubwordMatrix::scale(self : NlptokenizesubwordMatrix, s : Double) -> NlptokenizesubwordMatrix {
  let result = nlp_tokenize_subword_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizesubwordMatrix::multiply(self : NlptokenizesubwordMatrix, other : NlptokenizesubwordMatrix) -> NlptokenizesubwordMatrix {
  if self.cols != other.rows { return nlp_tokenize_subword_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_subword_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizesubwordMatrix::trace(self : NlptokenizesubwordMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizesubwordMatrix::det(self : NlptokenizesubwordMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizesubwordMatrix::norm(self : NlptokenizesubwordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizesubwordMatrix::to_string(self : NlptokenizesubwordMatrix) -> String {
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

pub(all) struct NlptokenizesubwordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_subword_make_vector(comps : Array[Double]) -> NlptokenizesubwordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_subword_vector_zero(dim : Int) -> NlptokenizesubwordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizesubwordVector::add(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesubwordVector::sub(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizesubwordVector::scale(self : NlptokenizesubwordVector, s : Double) -> NlptokenizesubwordVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizesubwordVector::dot(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizesubwordVector::norm(self : NlptokenizesubwordVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizesubwordVector::normalize(self : NlptokenizesubwordVector) -> NlptokenizesubwordVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizesubwordVector::dist(self : NlptokenizesubwordVector, other : NlptokenizesubwordVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizesubwordVector::to_string(self : NlptokenizesubwordVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_subword_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_subword_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_subword_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_subword_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_subword_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_subword_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_subword_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_subword_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_subword_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_subword_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_subword_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_subword_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_subword_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_subword_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_subword_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_subword_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_subword_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_subword_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_subword_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_subword_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_subword_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_subword_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_subword_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_subword_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_subword_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_subword_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_subword_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_subword_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_subword_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizesubwordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_frame_make(size : Int) -> NlptokenizesubwordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_frame_len(s : NlptokenizesubwordFrame) -> Int { s.size }

pub fn nlp_tokenize_subword_frame_get(s : NlptokenizesubwordFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_frame_set(s : NlptokenizesubwordFrame, i : Int, v : Double) -> NlptokenizesubwordFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_sum(s : NlptokenizesubwordFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_frame_mean(s : NlptokenizesubwordFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_frame_scale(s : NlptokenizesubwordFrame, f : Double) -> NlptokenizesubwordFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_add(a : NlptokenizesubwordFrame, b : NlptokenizesubwordFrame) -> NlptokenizesubwordFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_frame_copy(s : NlptokenizesubwordFrame) -> NlptokenizesubwordFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_fill(s : NlptokenizesubwordFrame, v : Double) -> NlptokenizesubwordFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_frame_min(s : NlptokenizesubwordFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_frame_max(s : NlptokenizesubwordFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_frame_to_string(s : NlptokenizesubwordFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_table_make(size : Int) -> NlptokenizesubwordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_table_len(s : NlptokenizesubwordTable) -> Int { s.size }

pub fn nlp_tokenize_subword_table_get(s : NlptokenizesubwordTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_table_set(s : NlptokenizesubwordTable, i : Int, v : Double) -> NlptokenizesubwordTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_sum(s : NlptokenizesubwordTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_table_mean(s : NlptokenizesubwordTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_table_scale(s : NlptokenizesubwordTable, f : Double) -> NlptokenizesubwordTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_add(a : NlptokenizesubwordTable, b : NlptokenizesubwordTable) -> NlptokenizesubwordTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_table_copy(s : NlptokenizesubwordTable) -> NlptokenizesubwordTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_fill(s : NlptokenizesubwordTable, v : Double) -> NlptokenizesubwordTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_table_min(s : NlptokenizesubwordTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_table_max(s : NlptokenizesubwordTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_table_to_string(s : NlptokenizesubwordTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_graphn_make(size : Int) -> NlptokenizesubwordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_graphn_len(s : NlptokenizesubwordGraphN) -> Int { s.size }

pub fn nlp_tokenize_subword_graphn_get(s : NlptokenizesubwordGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_graphn_set(s : NlptokenizesubwordGraphN, i : Int, v : Double) -> NlptokenizesubwordGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_sum(s : NlptokenizesubwordGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_graphn_mean(s : NlptokenizesubwordGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_graphn_scale(s : NlptokenizesubwordGraphN, f : Double) -> NlptokenizesubwordGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_add(a : NlptokenizesubwordGraphN, b : NlptokenizesubwordGraphN) -> NlptokenizesubwordGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_graphn_copy(s : NlptokenizesubwordGraphN) -> NlptokenizesubwordGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_fill(s : NlptokenizesubwordGraphN, v : Double) -> NlptokenizesubwordGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_graphn_min(s : NlptokenizesubwordGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_graphn_max(s : NlptokenizesubwordGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_graphn_to_string(s : NlptokenizesubwordGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_node_make(size : Int) -> NlptokenizesubwordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_node_len(s : NlptokenizesubwordNode) -> Int { s.size }

pub fn nlp_tokenize_subword_node_get(s : NlptokenizesubwordNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_node_set(s : NlptokenizesubwordNode, i : Int, v : Double) -> NlptokenizesubwordNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_sum(s : NlptokenizesubwordNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_node_mean(s : NlptokenizesubwordNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_node_scale(s : NlptokenizesubwordNode, f : Double) -> NlptokenizesubwordNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_add(a : NlptokenizesubwordNode, b : NlptokenizesubwordNode) -> NlptokenizesubwordNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_node_copy(s : NlptokenizesubwordNode) -> NlptokenizesubwordNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_fill(s : NlptokenizesubwordNode, v : Double) -> NlptokenizesubwordNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_node_min(s : NlptokenizesubwordNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_node_max(s : NlptokenizesubwordNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_node_to_string(s : NlptokenizesubwordNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_edge_make(size : Int) -> NlptokenizesubwordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_edge_len(s : NlptokenizesubwordEdge) -> Int { s.size }

pub fn nlp_tokenize_subword_edge_get(s : NlptokenizesubwordEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_edge_set(s : NlptokenizesubwordEdge, i : Int, v : Double) -> NlptokenizesubwordEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_sum(s : NlptokenizesubwordEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_edge_mean(s : NlptokenizesubwordEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_edge_scale(s : NlptokenizesubwordEdge, f : Double) -> NlptokenizesubwordEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_add(a : NlptokenizesubwordEdge, b : NlptokenizesubwordEdge) -> NlptokenizesubwordEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_edge_copy(s : NlptokenizesubwordEdge) -> NlptokenizesubwordEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_fill(s : NlptokenizesubwordEdge, v : Double) -> NlptokenizesubwordEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_edge_min(s : NlptokenizesubwordEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_edge_max(s : NlptokenizesubwordEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_edge_to_string(s : NlptokenizesubwordEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_path_make(size : Int) -> NlptokenizesubwordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_path_len(s : NlptokenizesubwordPath) -> Int { s.size }

pub fn nlp_tokenize_subword_path_get(s : NlptokenizesubwordPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_path_set(s : NlptokenizesubwordPath, i : Int, v : Double) -> NlptokenizesubwordPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_sum(s : NlptokenizesubwordPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_path_mean(s : NlptokenizesubwordPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_path_scale(s : NlptokenizesubwordPath, f : Double) -> NlptokenizesubwordPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_add(a : NlptokenizesubwordPath, b : NlptokenizesubwordPath) -> NlptokenizesubwordPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_path_copy(s : NlptokenizesubwordPath) -> NlptokenizesubwordPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_fill(s : NlptokenizesubwordPath, v : Double) -> NlptokenizesubwordPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_path_min(s : NlptokenizesubwordPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_path_max(s : NlptokenizesubwordPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_path_to_string(s : NlptokenizesubwordPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_cluster_make(size : Int) -> NlptokenizesubwordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_cluster_len(s : NlptokenizesubwordCluster) -> Int { s.size }

pub fn nlp_tokenize_subword_cluster_get(s : NlptokenizesubwordCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_cluster_set(s : NlptokenizesubwordCluster, i : Int, v : Double) -> NlptokenizesubwordCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_sum(s : NlptokenizesubwordCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_cluster_mean(s : NlptokenizesubwordCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_cluster_scale(s : NlptokenizesubwordCluster, f : Double) -> NlptokenizesubwordCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_add(a : NlptokenizesubwordCluster, b : NlptokenizesubwordCluster) -> NlptokenizesubwordCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_cluster_copy(s : NlptokenizesubwordCluster) -> NlptokenizesubwordCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_fill(s : NlptokenizesubwordCluster, v : Double) -> NlptokenizesubwordCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cluster_min(s : NlptokenizesubwordCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_cluster_max(s : NlptokenizesubwordCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_cluster_to_string(s : NlptokenizesubwordCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_model_make(size : Int) -> NlptokenizesubwordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_model_len(s : NlptokenizesubwordModel) -> Int { s.size }

pub fn nlp_tokenize_subword_model_get(s : NlptokenizesubwordModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_model_set(s : NlptokenizesubwordModel, i : Int, v : Double) -> NlptokenizesubwordModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_sum(s : NlptokenizesubwordModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_model_mean(s : NlptokenizesubwordModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_model_scale(s : NlptokenizesubwordModel, f : Double) -> NlptokenizesubwordModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_add(a : NlptokenizesubwordModel, b : NlptokenizesubwordModel) -> NlptokenizesubwordModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_model_copy(s : NlptokenizesubwordModel) -> NlptokenizesubwordModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_fill(s : NlptokenizesubwordModel, v : Double) -> NlptokenizesubwordModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_model_min(s : NlptokenizesubwordModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_model_max(s : NlptokenizesubwordModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_model_to_string(s : NlptokenizesubwordModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_layer_make(size : Int) -> NlptokenizesubwordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_layer_len(s : NlptokenizesubwordLayer) -> Int { s.size }

pub fn nlp_tokenize_subword_layer_get(s : NlptokenizesubwordLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_layer_set(s : NlptokenizesubwordLayer, i : Int, v : Double) -> NlptokenizesubwordLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_sum(s : NlptokenizesubwordLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_layer_mean(s : NlptokenizesubwordLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_layer_scale(s : NlptokenizesubwordLayer, f : Double) -> NlptokenizesubwordLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_add(a : NlptokenizesubwordLayer, b : NlptokenizesubwordLayer) -> NlptokenizesubwordLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_layer_copy(s : NlptokenizesubwordLayer) -> NlptokenizesubwordLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_fill(s : NlptokenizesubwordLayer, v : Double) -> NlptokenizesubwordLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_layer_min(s : NlptokenizesubwordLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_layer_max(s : NlptokenizesubwordLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_layer_to_string(s : NlptokenizesubwordLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_buffer_make(size : Int) -> NlptokenizesubwordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_buffer_len(s : NlptokenizesubwordBuffer) -> Int { s.size }

pub fn nlp_tokenize_subword_buffer_get(s : NlptokenizesubwordBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_buffer_set(s : NlptokenizesubwordBuffer, i : Int, v : Double) -> NlptokenizesubwordBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_sum(s : NlptokenizesubwordBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_buffer_mean(s : NlptokenizesubwordBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_buffer_scale(s : NlptokenizesubwordBuffer, f : Double) -> NlptokenizesubwordBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_add(a : NlptokenizesubwordBuffer, b : NlptokenizesubwordBuffer) -> NlptokenizesubwordBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_buffer_copy(s : NlptokenizesubwordBuffer) -> NlptokenizesubwordBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_fill(s : NlptokenizesubwordBuffer, v : Double) -> NlptokenizesubwordBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_buffer_min(s : NlptokenizesubwordBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_buffer_max(s : NlptokenizesubwordBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_buffer_to_string(s : NlptokenizesubwordBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_cursor_make(size : Int) -> NlptokenizesubwordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_cursor_len(s : NlptokenizesubwordCursor) -> Int { s.size }

pub fn nlp_tokenize_subword_cursor_get(s : NlptokenizesubwordCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_cursor_set(s : NlptokenizesubwordCursor, i : Int, v : Double) -> NlptokenizesubwordCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_sum(s : NlptokenizesubwordCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_cursor_mean(s : NlptokenizesubwordCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_cursor_scale(s : NlptokenizesubwordCursor, f : Double) -> NlptokenizesubwordCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_add(a : NlptokenizesubwordCursor, b : NlptokenizesubwordCursor) -> NlptokenizesubwordCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_cursor_copy(s : NlptokenizesubwordCursor) -> NlptokenizesubwordCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_fill(s : NlptokenizesubwordCursor, v : Double) -> NlptokenizesubwordCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_cursor_min(s : NlptokenizesubwordCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_cursor_max(s : NlptokenizesubwordCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_cursor_to_string(s : NlptokenizesubwordCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_view_make(size : Int) -> NlptokenizesubwordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_view_len(s : NlptokenizesubwordView) -> Int { s.size }

pub fn nlp_tokenize_subword_view_get(s : NlptokenizesubwordView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_view_set(s : NlptokenizesubwordView, i : Int, v : Double) -> NlptokenizesubwordView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_sum(s : NlptokenizesubwordView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_view_mean(s : NlptokenizesubwordView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_view_scale(s : NlptokenizesubwordView, f : Double) -> NlptokenizesubwordView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_add(a : NlptokenizesubwordView, b : NlptokenizesubwordView) -> NlptokenizesubwordView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_view_copy(s : NlptokenizesubwordView) -> NlptokenizesubwordView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_fill(s : NlptokenizesubwordView, v : Double) -> NlptokenizesubwordView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_view_min(s : NlptokenizesubwordView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_view_max(s : NlptokenizesubwordView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_view_to_string(s : NlptokenizesubwordView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_range_make(size : Int) -> NlptokenizesubwordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_range_len(s : NlptokenizesubwordRange) -> Int { s.size }

pub fn nlp_tokenize_subword_range_get(s : NlptokenizesubwordRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_range_set(s : NlptokenizesubwordRange, i : Int, v : Double) -> NlptokenizesubwordRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_sum(s : NlptokenizesubwordRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_range_mean(s : NlptokenizesubwordRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_range_scale(s : NlptokenizesubwordRange, f : Double) -> NlptokenizesubwordRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_add(a : NlptokenizesubwordRange, b : NlptokenizesubwordRange) -> NlptokenizesubwordRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_range_copy(s : NlptokenizesubwordRange) -> NlptokenizesubwordRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_fill(s : NlptokenizesubwordRange, v : Double) -> NlptokenizesubwordRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_range_min(s : NlptokenizesubwordRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_range_max(s : NlptokenizesubwordRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_range_to_string(s : NlptokenizesubwordRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesubwordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_subword_slice_make(size : Int) -> NlptokenizesubwordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_subword_slice_len(s : NlptokenizesubwordSlice) -> Int { s.size }

pub fn nlp_tokenize_subword_slice_get(s : NlptokenizesubwordSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_subword_slice_set(s : NlptokenizesubwordSlice, i : Int, v : Double) -> NlptokenizesubwordSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_sum(s : NlptokenizesubwordSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_subword_slice_mean(s : NlptokenizesubwordSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_subword_slice_scale(s : NlptokenizesubwordSlice, f : Double) -> NlptokenizesubwordSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_add(a : NlptokenizesubwordSlice, b : NlptokenizesubwordSlice) -> NlptokenizesubwordSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_subword_slice_copy(s : NlptokenizesubwordSlice) -> NlptokenizesubwordSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_fill(s : NlptokenizesubwordSlice, v : Double) -> NlptokenizesubwordSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_subword_slice_min(s : NlptokenizesubwordSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_subword_slice_max(s : NlptokenizesubwordSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_subword_slice_to_string(s : NlptokenizesubwordSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

