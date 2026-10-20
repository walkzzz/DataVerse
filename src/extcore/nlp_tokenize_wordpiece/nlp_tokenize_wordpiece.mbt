///===
/// extcore/nlp_tokenize_wordpiece

pub(all) struct NlptokenizewordpiecePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_wordpiece_make_point(x : Double, y : Double) -> NlptokenizewordpiecePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_wordpiece_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordpiecePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizewordpiecePoint::x(self : NlptokenizewordpiecePoint) -> Double { self.x }

pub fn NlptokenizewordpiecePoint::y(self : NlptokenizewordpiecePoint) -> Double { self.y }

pub fn NlptokenizewordpiecePoint::z(self : NlptokenizewordpiecePoint) -> Double { self.z }

pub fn NlptokenizewordpiecePoint::label(self : NlptokenizewordpiecePoint) -> Int { self.label }

pub fn NlptokenizewordpiecePoint::dist(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizewordpiecePoint::add(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizewordpiecePoint::sub(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizewordpiecePoint::scale(self : NlptokenizewordpiecePoint, s : Double) -> NlptokenizewordpiecePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizewordpiecePoint::dot(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizewordpiecePoint::cross(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizewordpiecePoint::norm(self : NlptokenizewordpiecePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizewordpiecePoint::normalize(self : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordpiecePoint::negate(self : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizewordpiecePoint::mid(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint) -> NlptokenizewordpiecePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizewordpiecePoint::lerp(self : NlptokenizewordpiecePoint, other : NlptokenizewordpiecePoint, t : Double) -> NlptokenizewordpiecePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizewordpiecePoint::to_string(self : NlptokenizewordpiecePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_wordpiece_make_series(vals : Array[Double], name : String) -> NlptokenizewordpieceSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizewordpieceSeries::len(self : NlptokenizewordpieceSeries) -> Int { self.vals.length() }

pub fn NlptokenizewordpieceSeries::sum(self : NlptokenizewordpieceSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizewordpieceSeries::mean(self : NlptokenizewordpieceSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizewordpieceSeries::min(self : NlptokenizewordpieceSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizewordpieceSeries::max(self : NlptokenizewordpieceSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizewordpieceSeries::range(self : NlptokenizewordpieceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizewordpieceSeries::variance(self : NlptokenizewordpieceSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizewordpieceSeries::std(self : NlptokenizewordpieceSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizewordpieceSeries::median(self : NlptokenizewordpieceSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizewordpieceSeries::scale(self : NlptokenizewordpieceSeries, f : Double) -> NlptokenizewordpieceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::add(self : NlptokenizewordpieceSeries, other : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::sub(self : NlptokenizewordpieceSeries, other : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::normalize(self : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizewordpieceSeries::cumsum(self : NlptokenizewordpieceSeries) -> NlptokenizewordpieceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizewordpieceSeries::to_string(self : NlptokenizewordpieceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordpieceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_wordpiece_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordpieceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_wordpiece_matrix_identity(n : Int) -> NlptokenizewordpieceMatrix {
  let m = nlp_tokenize_wordpiece_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizewordpieceMatrix::get(self : NlptokenizewordpieceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizewordpieceMatrix::transpose(self : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  let result = nlp_tokenize_wordpiece_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizewordpieceMatrix::add(self : NlptokenizewordpieceMatrix, other : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_wordpiece_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizewordpieceMatrix::scale(self : NlptokenizewordpieceMatrix, s : Double) -> NlptokenizewordpieceMatrix {
  let result = nlp_tokenize_wordpiece_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizewordpieceMatrix::multiply(self : NlptokenizewordpieceMatrix, other : NlptokenizewordpieceMatrix) -> NlptokenizewordpieceMatrix {
  if self.cols != other.rows { return nlp_tokenize_wordpiece_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_wordpiece_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizewordpieceMatrix::trace(self : NlptokenizewordpieceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizewordpieceMatrix::det(self : NlptokenizewordpieceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizewordpieceMatrix::norm(self : NlptokenizewordpieceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizewordpieceMatrix::to_string(self : NlptokenizewordpieceMatrix) -> String {
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

pub(all) struct NlptokenizewordpieceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_wordpiece_make_vector(comps : Array[Double]) -> NlptokenizewordpieceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_wordpiece_vector_zero(dim : Int) -> NlptokenizewordpieceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizewordpieceVector::add(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordpieceVector::sub(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizewordpieceVector::scale(self : NlptokenizewordpieceVector, s : Double) -> NlptokenizewordpieceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizewordpieceVector::dot(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizewordpieceVector::norm(self : NlptokenizewordpieceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizewordpieceVector::normalize(self : NlptokenizewordpieceVector) -> NlptokenizewordpieceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizewordpieceVector::dist(self : NlptokenizewordpieceVector, other : NlptokenizewordpieceVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizewordpieceVector::to_string(self : NlptokenizewordpieceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_wordpiece_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_wordpiece_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_wordpiece_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_wordpiece_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_wordpiece_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_wordpiece_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_wordpiece_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_wordpiece_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_wordpiece_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_wordpiece_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_wordpiece_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_wordpiece_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_wordpiece_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_wordpiece_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_wordpiece_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_wordpiece_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_wordpiece_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_wordpiece_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_wordpiece_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_wordpiece_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_wordpiece_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_wordpiece_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_wordpiece_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_wordpiece_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_wordpiece_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_wordpiece_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_wordpiece_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_wordpiece_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_wordpiece_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizewordpieceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_frame_make(size : Int) -> NlptokenizewordpieceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_frame_len(s : NlptokenizewordpieceFrame) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_frame_get(s : NlptokenizewordpieceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_frame_set(s : NlptokenizewordpieceFrame, i : Int, v : Double) -> NlptokenizewordpieceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_sum(s : NlptokenizewordpieceFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_frame_mean(s : NlptokenizewordpieceFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_frame_scale(s : NlptokenizewordpieceFrame, f : Double) -> NlptokenizewordpieceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_add(a : NlptokenizewordpieceFrame, b : NlptokenizewordpieceFrame) -> NlptokenizewordpieceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_frame_copy(s : NlptokenizewordpieceFrame) -> NlptokenizewordpieceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_fill(s : NlptokenizewordpieceFrame, v : Double) -> NlptokenizewordpieceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_frame_min(s : NlptokenizewordpieceFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_frame_max(s : NlptokenizewordpieceFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_frame_to_string(s : NlptokenizewordpieceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_table_make(size : Int) -> NlptokenizewordpieceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_table_len(s : NlptokenizewordpieceTable) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_table_get(s : NlptokenizewordpieceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_table_set(s : NlptokenizewordpieceTable, i : Int, v : Double) -> NlptokenizewordpieceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_sum(s : NlptokenizewordpieceTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_table_mean(s : NlptokenizewordpieceTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_table_scale(s : NlptokenizewordpieceTable, f : Double) -> NlptokenizewordpieceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_add(a : NlptokenizewordpieceTable, b : NlptokenizewordpieceTable) -> NlptokenizewordpieceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_table_copy(s : NlptokenizewordpieceTable) -> NlptokenizewordpieceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_fill(s : NlptokenizewordpieceTable, v : Double) -> NlptokenizewordpieceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_table_min(s : NlptokenizewordpieceTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_table_max(s : NlptokenizewordpieceTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_table_to_string(s : NlptokenizewordpieceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_graphn_make(size : Int) -> NlptokenizewordpieceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_graphn_len(s : NlptokenizewordpieceGraphN) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_graphn_get(s : NlptokenizewordpieceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_graphn_set(s : NlptokenizewordpieceGraphN, i : Int, v : Double) -> NlptokenizewordpieceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_sum(s : NlptokenizewordpieceGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_mean(s : NlptokenizewordpieceGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_scale(s : NlptokenizewordpieceGraphN, f : Double) -> NlptokenizewordpieceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_add(a : NlptokenizewordpieceGraphN, b : NlptokenizewordpieceGraphN) -> NlptokenizewordpieceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_copy(s : NlptokenizewordpieceGraphN) -> NlptokenizewordpieceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_fill(s : NlptokenizewordpieceGraphN, v : Double) -> NlptokenizewordpieceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_graphn_min(s : NlptokenizewordpieceGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_max(s : NlptokenizewordpieceGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_graphn_to_string(s : NlptokenizewordpieceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_node_make(size : Int) -> NlptokenizewordpieceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_node_len(s : NlptokenizewordpieceNode) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_node_get(s : NlptokenizewordpieceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_node_set(s : NlptokenizewordpieceNode, i : Int, v : Double) -> NlptokenizewordpieceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_sum(s : NlptokenizewordpieceNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_node_mean(s : NlptokenizewordpieceNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_node_scale(s : NlptokenizewordpieceNode, f : Double) -> NlptokenizewordpieceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_add(a : NlptokenizewordpieceNode, b : NlptokenizewordpieceNode) -> NlptokenizewordpieceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_node_copy(s : NlptokenizewordpieceNode) -> NlptokenizewordpieceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_fill(s : NlptokenizewordpieceNode, v : Double) -> NlptokenizewordpieceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_node_min(s : NlptokenizewordpieceNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_node_max(s : NlptokenizewordpieceNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_node_to_string(s : NlptokenizewordpieceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_edge_make(size : Int) -> NlptokenizewordpieceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_edge_len(s : NlptokenizewordpieceEdge) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_edge_get(s : NlptokenizewordpieceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_edge_set(s : NlptokenizewordpieceEdge, i : Int, v : Double) -> NlptokenizewordpieceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_sum(s : NlptokenizewordpieceEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_edge_mean(s : NlptokenizewordpieceEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_edge_scale(s : NlptokenizewordpieceEdge, f : Double) -> NlptokenizewordpieceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_add(a : NlptokenizewordpieceEdge, b : NlptokenizewordpieceEdge) -> NlptokenizewordpieceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_edge_copy(s : NlptokenizewordpieceEdge) -> NlptokenizewordpieceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_fill(s : NlptokenizewordpieceEdge, v : Double) -> NlptokenizewordpieceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_edge_min(s : NlptokenizewordpieceEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_edge_max(s : NlptokenizewordpieceEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_edge_to_string(s : NlptokenizewordpieceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpiecePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_path_make(size : Int) -> NlptokenizewordpiecePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_path_len(s : NlptokenizewordpiecePath) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_path_get(s : NlptokenizewordpiecePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_path_set(s : NlptokenizewordpiecePath, i : Int, v : Double) -> NlptokenizewordpiecePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_sum(s : NlptokenizewordpiecePath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_path_mean(s : NlptokenizewordpiecePath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_path_scale(s : NlptokenizewordpiecePath, f : Double) -> NlptokenizewordpiecePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_add(a : NlptokenizewordpiecePath, b : NlptokenizewordpiecePath) -> NlptokenizewordpiecePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_path_copy(s : NlptokenizewordpiecePath) -> NlptokenizewordpiecePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_fill(s : NlptokenizewordpiecePath, v : Double) -> NlptokenizewordpiecePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_path_min(s : NlptokenizewordpiecePath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_path_max(s : NlptokenizewordpiecePath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_path_to_string(s : NlptokenizewordpiecePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_cluster_make(size : Int) -> NlptokenizewordpieceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_cluster_len(s : NlptokenizewordpieceCluster) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_cluster_get(s : NlptokenizewordpieceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_cluster_set(s : NlptokenizewordpieceCluster, i : Int, v : Double) -> NlptokenizewordpieceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_sum(s : NlptokenizewordpieceCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_mean(s : NlptokenizewordpieceCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_scale(s : NlptokenizewordpieceCluster, f : Double) -> NlptokenizewordpieceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_add(a : NlptokenizewordpieceCluster, b : NlptokenizewordpieceCluster) -> NlptokenizewordpieceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_copy(s : NlptokenizewordpieceCluster) -> NlptokenizewordpieceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_fill(s : NlptokenizewordpieceCluster, v : Double) -> NlptokenizewordpieceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cluster_min(s : NlptokenizewordpieceCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_max(s : NlptokenizewordpieceCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_cluster_to_string(s : NlptokenizewordpieceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_model_make(size : Int) -> NlptokenizewordpieceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_model_len(s : NlptokenizewordpieceModel) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_model_get(s : NlptokenizewordpieceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_model_set(s : NlptokenizewordpieceModel, i : Int, v : Double) -> NlptokenizewordpieceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_sum(s : NlptokenizewordpieceModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_model_mean(s : NlptokenizewordpieceModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_model_scale(s : NlptokenizewordpieceModel, f : Double) -> NlptokenizewordpieceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_add(a : NlptokenizewordpieceModel, b : NlptokenizewordpieceModel) -> NlptokenizewordpieceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_model_copy(s : NlptokenizewordpieceModel) -> NlptokenizewordpieceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_fill(s : NlptokenizewordpieceModel, v : Double) -> NlptokenizewordpieceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_model_min(s : NlptokenizewordpieceModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_model_max(s : NlptokenizewordpieceModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_model_to_string(s : NlptokenizewordpieceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_layer_make(size : Int) -> NlptokenizewordpieceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_layer_len(s : NlptokenizewordpieceLayer) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_layer_get(s : NlptokenizewordpieceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_layer_set(s : NlptokenizewordpieceLayer, i : Int, v : Double) -> NlptokenizewordpieceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_sum(s : NlptokenizewordpieceLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_layer_mean(s : NlptokenizewordpieceLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_layer_scale(s : NlptokenizewordpieceLayer, f : Double) -> NlptokenizewordpieceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_add(a : NlptokenizewordpieceLayer, b : NlptokenizewordpieceLayer) -> NlptokenizewordpieceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_layer_copy(s : NlptokenizewordpieceLayer) -> NlptokenizewordpieceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_fill(s : NlptokenizewordpieceLayer, v : Double) -> NlptokenizewordpieceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_layer_min(s : NlptokenizewordpieceLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_layer_max(s : NlptokenizewordpieceLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_layer_to_string(s : NlptokenizewordpieceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_buffer_make(size : Int) -> NlptokenizewordpieceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_buffer_len(s : NlptokenizewordpieceBuffer) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_buffer_get(s : NlptokenizewordpieceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_buffer_set(s : NlptokenizewordpieceBuffer, i : Int, v : Double) -> NlptokenizewordpieceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_sum(s : NlptokenizewordpieceBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_mean(s : NlptokenizewordpieceBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_scale(s : NlptokenizewordpieceBuffer, f : Double) -> NlptokenizewordpieceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_add(a : NlptokenizewordpieceBuffer, b : NlptokenizewordpieceBuffer) -> NlptokenizewordpieceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_copy(s : NlptokenizewordpieceBuffer) -> NlptokenizewordpieceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_fill(s : NlptokenizewordpieceBuffer, v : Double) -> NlptokenizewordpieceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_buffer_min(s : NlptokenizewordpieceBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_max(s : NlptokenizewordpieceBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_buffer_to_string(s : NlptokenizewordpieceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_cursor_make(size : Int) -> NlptokenizewordpieceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_cursor_len(s : NlptokenizewordpieceCursor) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_cursor_get(s : NlptokenizewordpieceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_cursor_set(s : NlptokenizewordpieceCursor, i : Int, v : Double) -> NlptokenizewordpieceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_sum(s : NlptokenizewordpieceCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_mean(s : NlptokenizewordpieceCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_scale(s : NlptokenizewordpieceCursor, f : Double) -> NlptokenizewordpieceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_add(a : NlptokenizewordpieceCursor, b : NlptokenizewordpieceCursor) -> NlptokenizewordpieceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_copy(s : NlptokenizewordpieceCursor) -> NlptokenizewordpieceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_fill(s : NlptokenizewordpieceCursor, v : Double) -> NlptokenizewordpieceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_cursor_min(s : NlptokenizewordpieceCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_max(s : NlptokenizewordpieceCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_cursor_to_string(s : NlptokenizewordpieceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_view_make(size : Int) -> NlptokenizewordpieceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_view_len(s : NlptokenizewordpieceView) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_view_get(s : NlptokenizewordpieceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_view_set(s : NlptokenizewordpieceView, i : Int, v : Double) -> NlptokenizewordpieceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_sum(s : NlptokenizewordpieceView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_view_mean(s : NlptokenizewordpieceView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_view_scale(s : NlptokenizewordpieceView, f : Double) -> NlptokenizewordpieceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_add(a : NlptokenizewordpieceView, b : NlptokenizewordpieceView) -> NlptokenizewordpieceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_view_copy(s : NlptokenizewordpieceView) -> NlptokenizewordpieceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_fill(s : NlptokenizewordpieceView, v : Double) -> NlptokenizewordpieceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_view_min(s : NlptokenizewordpieceView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_view_max(s : NlptokenizewordpieceView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_view_to_string(s : NlptokenizewordpieceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_range_make(size : Int) -> NlptokenizewordpieceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_range_len(s : NlptokenizewordpieceRange) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_range_get(s : NlptokenizewordpieceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_range_set(s : NlptokenizewordpieceRange, i : Int, v : Double) -> NlptokenizewordpieceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_sum(s : NlptokenizewordpieceRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_range_mean(s : NlptokenizewordpieceRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_range_scale(s : NlptokenizewordpieceRange, f : Double) -> NlptokenizewordpieceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_add(a : NlptokenizewordpieceRange, b : NlptokenizewordpieceRange) -> NlptokenizewordpieceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_range_copy(s : NlptokenizewordpieceRange) -> NlptokenizewordpieceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_fill(s : NlptokenizewordpieceRange, v : Double) -> NlptokenizewordpieceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_range_min(s : NlptokenizewordpieceRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_range_max(s : NlptokenizewordpieceRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_range_to_string(s : NlptokenizewordpieceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordpieceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_wordpiece_slice_make(size : Int) -> NlptokenizewordpieceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_wordpiece_slice_len(s : NlptokenizewordpieceSlice) -> Int { s.size }

pub fn nlp_tokenize_wordpiece_slice_get(s : NlptokenizewordpieceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_wordpiece_slice_set(s : NlptokenizewordpieceSlice, i : Int, v : Double) -> NlptokenizewordpieceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_sum(s : NlptokenizewordpieceSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_wordpiece_slice_mean(s : NlptokenizewordpieceSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_wordpiece_slice_scale(s : NlptokenizewordpieceSlice, f : Double) -> NlptokenizewordpieceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_add(a : NlptokenizewordpieceSlice, b : NlptokenizewordpieceSlice) -> NlptokenizewordpieceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_wordpiece_slice_copy(s : NlptokenizewordpieceSlice) -> NlptokenizewordpieceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_fill(s : NlptokenizewordpieceSlice, v : Double) -> NlptokenizewordpieceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_wordpiece_slice_min(s : NlptokenizewordpieceSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_wordpiece_slice_max(s : NlptokenizewordpieceSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_wordpiece_slice_to_string(s : NlptokenizewordpieceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

