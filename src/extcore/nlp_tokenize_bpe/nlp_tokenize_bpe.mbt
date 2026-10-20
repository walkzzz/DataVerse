///===
/// extcore/nlp_tokenize_bpe

pub(all) struct NlptokenizebpePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_bpe_make_point(x : Double, y : Double) -> NlptokenizebpePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_bpe_make_point3(x : Double, y : Double, z : Double) -> NlptokenizebpePoint {
  { x, y, z, label: 0 }
}

pub fn NlptokenizebpePoint::x(self : NlptokenizebpePoint) -> Double { self.x }

pub fn NlptokenizebpePoint::y(self : NlptokenizebpePoint) -> Double { self.y }

pub fn NlptokenizebpePoint::z(self : NlptokenizebpePoint) -> Double { self.z }

pub fn NlptokenizebpePoint::label(self : NlptokenizebpePoint) -> Int { self.label }

pub fn NlptokenizebpePoint::dist(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlptokenizebpePoint::add(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlptokenizebpePoint::sub(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlptokenizebpePoint::scale(self : NlptokenizebpePoint, s : Double) -> NlptokenizebpePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlptokenizebpePoint::dot(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlptokenizebpePoint::cross(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlptokenizebpePoint::norm(self : NlptokenizebpePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlptokenizebpePoint::normalize(self : NlptokenizebpePoint) -> NlptokenizebpePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizebpePoint::negate(self : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlptokenizebpePoint::mid(self : NlptokenizebpePoint, other : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlptokenizebpePoint::lerp(self : NlptokenizebpePoint, other : NlptokenizebpePoint, t : Double) -> NlptokenizebpePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlptokenizebpePoint::to_string(self : NlptokenizebpePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlptokenizebpeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_bpe_make_series(vals : Array[Double], name : String) -> NlptokenizebpeSeries {
  { vals, name, meta: 0 }
}

pub fn NlptokenizebpeSeries::len(self : NlptokenizebpeSeries) -> Int { self.vals.length() }

pub fn NlptokenizebpeSeries::sum(self : NlptokenizebpeSeries) -> Double { @_common.sum(self.vals) }

pub fn NlptokenizebpeSeries::mean(self : NlptokenizebpeSeries) -> Double { @_common.mean(self.vals) }

pub fn NlptokenizebpeSeries::min(self : NlptokenizebpeSeries) -> Double { @_common.min(self.vals) }

pub fn NlptokenizebpeSeries::max(self : NlptokenizebpeSeries) -> Double { @_common.max(self.vals) }

pub fn NlptokenizebpeSeries::range(self : NlptokenizebpeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlptokenizebpeSeries::variance(self : NlptokenizebpeSeries) -> Double { @_common.variance(self.vals) }

pub fn NlptokenizebpeSeries::std(self : NlptokenizebpeSeries) -> Double { @_common.std(self.vals) }

pub fn NlptokenizebpeSeries::median(self : NlptokenizebpeSeries) -> Double { @_common.median(self.vals) }

pub fn NlptokenizebpeSeries::scale(self : NlptokenizebpeSeries, f : Double) -> NlptokenizebpeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlptokenizebpeSeries::add(self : NlptokenizebpeSeries, other : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlptokenizebpeSeries::sub(self : NlptokenizebpeSeries, other : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlptokenizebpeSeries::normalize(self : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlptokenizebpeSeries::cumsum(self : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlptokenizebpeSeries::to_string(self : NlptokenizebpeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizebpeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_bpe_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizebpeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_bpe_matrix_identity(n : Int) -> NlptokenizebpeMatrix {
  let m = nlp_tokenize_bpe_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlptokenizebpeMatrix::get(self : NlptokenizebpeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlptokenizebpeMatrix::transpose(self : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  let result = nlp_tokenize_bpe_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlptokenizebpeMatrix::add(self : NlptokenizebpeMatrix, other : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_tokenize_bpe_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlptokenizebpeMatrix::scale(self : NlptokenizebpeMatrix, s : Double) -> NlptokenizebpeMatrix {
  let result = nlp_tokenize_bpe_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlptokenizebpeMatrix::multiply(self : NlptokenizebpeMatrix, other : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  if self.cols != other.rows { return nlp_tokenize_bpe_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_tokenize_bpe_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlptokenizebpeMatrix::trace(self : NlptokenizebpeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlptokenizebpeMatrix::det(self : NlptokenizebpeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlptokenizebpeMatrix::norm(self : NlptokenizebpeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlptokenizebpeMatrix::to_string(self : NlptokenizebpeMatrix) -> String {
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

pub(all) struct NlptokenizebpeVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_bpe_make_vector(comps : Array[Double]) -> NlptokenizebpeVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_bpe_vector_zero(dim : Int) -> NlptokenizebpeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlptokenizebpeVector::add(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizebpeVector::sub(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlptokenizebpeVector::scale(self : NlptokenizebpeVector, s : Double) -> NlptokenizebpeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlptokenizebpeVector::dot(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlptokenizebpeVector::norm(self : NlptokenizebpeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlptokenizebpeVector::normalize(self : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlptokenizebpeVector::dist(self : NlptokenizebpeVector, other : NlptokenizebpeVector) -> Double {
  self.sub(other).norm()
}

pub fn NlptokenizebpeVector::to_string(self : NlptokenizebpeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_bpe_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_bpe_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_bpe_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_bpe_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_bpe_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_bpe_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_bpe_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_bpe_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_bpe_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_bpe_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_bpe_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_bpe_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_bpe_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_bpe_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_bpe_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_bpe_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_bpe_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_bpe_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_bpe_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_bpe_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_bpe_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_bpe_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_bpe_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_bpe_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_bpe_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_bpe_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_bpe_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_bpe_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_bpe_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizebpeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_frame_make(size : Int) -> NlptokenizebpeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_frame_len(s : NlptokenizebpeFrame) -> Int { s.size }

pub fn nlp_tokenize_bpe_frame_get(s : NlptokenizebpeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_frame_set(s : NlptokenizebpeFrame, i : Int, v : Double) -> NlptokenizebpeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_frame_sum(s : NlptokenizebpeFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_frame_mean(s : NlptokenizebpeFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_frame_scale(s : NlptokenizebpeFrame, f : Double) -> NlptokenizebpeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_frame_add(a : NlptokenizebpeFrame, b : NlptokenizebpeFrame) -> NlptokenizebpeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_frame_copy(s : NlptokenizebpeFrame) -> NlptokenizebpeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_frame_fill(s : NlptokenizebpeFrame, v : Double) -> NlptokenizebpeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_frame_min(s : NlptokenizebpeFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_frame_max(s : NlptokenizebpeFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_frame_to_string(s : NlptokenizebpeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_table_make(size : Int) -> NlptokenizebpeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_table_len(s : NlptokenizebpeTable) -> Int { s.size }

pub fn nlp_tokenize_bpe_table_get(s : NlptokenizebpeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_table_set(s : NlptokenizebpeTable, i : Int, v : Double) -> NlptokenizebpeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_table_sum(s : NlptokenizebpeTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_table_mean(s : NlptokenizebpeTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_table_scale(s : NlptokenizebpeTable, f : Double) -> NlptokenizebpeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_table_add(a : NlptokenizebpeTable, b : NlptokenizebpeTable) -> NlptokenizebpeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_table_copy(s : NlptokenizebpeTable) -> NlptokenizebpeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_table_fill(s : NlptokenizebpeTable, v : Double) -> NlptokenizebpeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_table_min(s : NlptokenizebpeTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_table_max(s : NlptokenizebpeTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_table_to_string(s : NlptokenizebpeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_graphn_make(size : Int) -> NlptokenizebpeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_graphn_len(s : NlptokenizebpeGraphN) -> Int { s.size }

pub fn nlp_tokenize_bpe_graphn_get(s : NlptokenizebpeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_graphn_set(s : NlptokenizebpeGraphN, i : Int, v : Double) -> NlptokenizebpeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_graphn_sum(s : NlptokenizebpeGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_graphn_mean(s : NlptokenizebpeGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_graphn_scale(s : NlptokenizebpeGraphN, f : Double) -> NlptokenizebpeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_graphn_add(a : NlptokenizebpeGraphN, b : NlptokenizebpeGraphN) -> NlptokenizebpeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_graphn_copy(s : NlptokenizebpeGraphN) -> NlptokenizebpeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_graphn_fill(s : NlptokenizebpeGraphN, v : Double) -> NlptokenizebpeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_graphn_min(s : NlptokenizebpeGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_graphn_max(s : NlptokenizebpeGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_graphn_to_string(s : NlptokenizebpeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_node_make(size : Int) -> NlptokenizebpeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_node_len(s : NlptokenizebpeNode) -> Int { s.size }

pub fn nlp_tokenize_bpe_node_get(s : NlptokenizebpeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_node_set(s : NlptokenizebpeNode, i : Int, v : Double) -> NlptokenizebpeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_node_sum(s : NlptokenizebpeNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_node_mean(s : NlptokenizebpeNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_node_scale(s : NlptokenizebpeNode, f : Double) -> NlptokenizebpeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_node_add(a : NlptokenizebpeNode, b : NlptokenizebpeNode) -> NlptokenizebpeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_node_copy(s : NlptokenizebpeNode) -> NlptokenizebpeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_node_fill(s : NlptokenizebpeNode, v : Double) -> NlptokenizebpeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_node_min(s : NlptokenizebpeNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_node_max(s : NlptokenizebpeNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_node_to_string(s : NlptokenizebpeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_edge_make(size : Int) -> NlptokenizebpeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_edge_len(s : NlptokenizebpeEdge) -> Int { s.size }

pub fn nlp_tokenize_bpe_edge_get(s : NlptokenizebpeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_edge_set(s : NlptokenizebpeEdge, i : Int, v : Double) -> NlptokenizebpeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_edge_sum(s : NlptokenizebpeEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_edge_mean(s : NlptokenizebpeEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_edge_scale(s : NlptokenizebpeEdge, f : Double) -> NlptokenizebpeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_edge_add(a : NlptokenizebpeEdge, b : NlptokenizebpeEdge) -> NlptokenizebpeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_edge_copy(s : NlptokenizebpeEdge) -> NlptokenizebpeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_edge_fill(s : NlptokenizebpeEdge, v : Double) -> NlptokenizebpeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_edge_min(s : NlptokenizebpeEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_edge_max(s : NlptokenizebpeEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_edge_to_string(s : NlptokenizebpeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_path_make(size : Int) -> NlptokenizebpePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_path_len(s : NlptokenizebpePath) -> Int { s.size }

pub fn nlp_tokenize_bpe_path_get(s : NlptokenizebpePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_path_set(s : NlptokenizebpePath, i : Int, v : Double) -> NlptokenizebpePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_path_sum(s : NlptokenizebpePath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_path_mean(s : NlptokenizebpePath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_path_scale(s : NlptokenizebpePath, f : Double) -> NlptokenizebpePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_path_add(a : NlptokenizebpePath, b : NlptokenizebpePath) -> NlptokenizebpePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_path_copy(s : NlptokenizebpePath) -> NlptokenizebpePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_path_fill(s : NlptokenizebpePath, v : Double) -> NlptokenizebpePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_path_min(s : NlptokenizebpePath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_path_max(s : NlptokenizebpePath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_path_to_string(s : NlptokenizebpePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_cluster_make(size : Int) -> NlptokenizebpeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_cluster_len(s : NlptokenizebpeCluster) -> Int { s.size }

pub fn nlp_tokenize_bpe_cluster_get(s : NlptokenizebpeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_cluster_set(s : NlptokenizebpeCluster, i : Int, v : Double) -> NlptokenizebpeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cluster_sum(s : NlptokenizebpeCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_cluster_mean(s : NlptokenizebpeCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_cluster_scale(s : NlptokenizebpeCluster, f : Double) -> NlptokenizebpeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cluster_add(a : NlptokenizebpeCluster, b : NlptokenizebpeCluster) -> NlptokenizebpeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_cluster_copy(s : NlptokenizebpeCluster) -> NlptokenizebpeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cluster_fill(s : NlptokenizebpeCluster, v : Double) -> NlptokenizebpeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cluster_min(s : NlptokenizebpeCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_cluster_max(s : NlptokenizebpeCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_cluster_to_string(s : NlptokenizebpeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_model_make(size : Int) -> NlptokenizebpeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_model_len(s : NlptokenizebpeModel) -> Int { s.size }

pub fn nlp_tokenize_bpe_model_get(s : NlptokenizebpeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_model_set(s : NlptokenizebpeModel, i : Int, v : Double) -> NlptokenizebpeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_model_sum(s : NlptokenizebpeModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_model_mean(s : NlptokenizebpeModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_model_scale(s : NlptokenizebpeModel, f : Double) -> NlptokenizebpeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_model_add(a : NlptokenizebpeModel, b : NlptokenizebpeModel) -> NlptokenizebpeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_model_copy(s : NlptokenizebpeModel) -> NlptokenizebpeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_model_fill(s : NlptokenizebpeModel, v : Double) -> NlptokenizebpeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_model_min(s : NlptokenizebpeModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_model_max(s : NlptokenizebpeModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_model_to_string(s : NlptokenizebpeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_layer_make(size : Int) -> NlptokenizebpeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_layer_len(s : NlptokenizebpeLayer) -> Int { s.size }

pub fn nlp_tokenize_bpe_layer_get(s : NlptokenizebpeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_layer_set(s : NlptokenizebpeLayer, i : Int, v : Double) -> NlptokenizebpeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_layer_sum(s : NlptokenizebpeLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_layer_mean(s : NlptokenizebpeLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_layer_scale(s : NlptokenizebpeLayer, f : Double) -> NlptokenizebpeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_layer_add(a : NlptokenizebpeLayer, b : NlptokenizebpeLayer) -> NlptokenizebpeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_layer_copy(s : NlptokenizebpeLayer) -> NlptokenizebpeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_layer_fill(s : NlptokenizebpeLayer, v : Double) -> NlptokenizebpeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_layer_min(s : NlptokenizebpeLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_layer_max(s : NlptokenizebpeLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_layer_to_string(s : NlptokenizebpeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_buffer_make(size : Int) -> NlptokenizebpeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_buffer_len(s : NlptokenizebpeBuffer) -> Int { s.size }

pub fn nlp_tokenize_bpe_buffer_get(s : NlptokenizebpeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_buffer_set(s : NlptokenizebpeBuffer, i : Int, v : Double) -> NlptokenizebpeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_buffer_sum(s : NlptokenizebpeBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_buffer_mean(s : NlptokenizebpeBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_buffer_scale(s : NlptokenizebpeBuffer, f : Double) -> NlptokenizebpeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_buffer_add(a : NlptokenizebpeBuffer, b : NlptokenizebpeBuffer) -> NlptokenizebpeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_buffer_copy(s : NlptokenizebpeBuffer) -> NlptokenizebpeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_buffer_fill(s : NlptokenizebpeBuffer, v : Double) -> NlptokenizebpeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_buffer_min(s : NlptokenizebpeBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_buffer_max(s : NlptokenizebpeBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_buffer_to_string(s : NlptokenizebpeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_cursor_make(size : Int) -> NlptokenizebpeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_cursor_len(s : NlptokenizebpeCursor) -> Int { s.size }

pub fn nlp_tokenize_bpe_cursor_get(s : NlptokenizebpeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_cursor_set(s : NlptokenizebpeCursor, i : Int, v : Double) -> NlptokenizebpeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cursor_sum(s : NlptokenizebpeCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_cursor_mean(s : NlptokenizebpeCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_cursor_scale(s : NlptokenizebpeCursor, f : Double) -> NlptokenizebpeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cursor_add(a : NlptokenizebpeCursor, b : NlptokenizebpeCursor) -> NlptokenizebpeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_cursor_copy(s : NlptokenizebpeCursor) -> NlptokenizebpeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cursor_fill(s : NlptokenizebpeCursor, v : Double) -> NlptokenizebpeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_cursor_min(s : NlptokenizebpeCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_cursor_max(s : NlptokenizebpeCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_cursor_to_string(s : NlptokenizebpeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_view_make(size : Int) -> NlptokenizebpeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_view_len(s : NlptokenizebpeView) -> Int { s.size }

pub fn nlp_tokenize_bpe_view_get(s : NlptokenizebpeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_view_set(s : NlptokenizebpeView, i : Int, v : Double) -> NlptokenizebpeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_view_sum(s : NlptokenizebpeView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_view_mean(s : NlptokenizebpeView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_view_scale(s : NlptokenizebpeView, f : Double) -> NlptokenizebpeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_view_add(a : NlptokenizebpeView, b : NlptokenizebpeView) -> NlptokenizebpeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_view_copy(s : NlptokenizebpeView) -> NlptokenizebpeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_view_fill(s : NlptokenizebpeView, v : Double) -> NlptokenizebpeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_view_min(s : NlptokenizebpeView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_view_max(s : NlptokenizebpeView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_view_to_string(s : NlptokenizebpeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_range_make(size : Int) -> NlptokenizebpeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_range_len(s : NlptokenizebpeRange) -> Int { s.size }

pub fn nlp_tokenize_bpe_range_get(s : NlptokenizebpeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_range_set(s : NlptokenizebpeRange, i : Int, v : Double) -> NlptokenizebpeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_range_sum(s : NlptokenizebpeRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_range_mean(s : NlptokenizebpeRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_range_scale(s : NlptokenizebpeRange, f : Double) -> NlptokenizebpeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_range_add(a : NlptokenizebpeRange, b : NlptokenizebpeRange) -> NlptokenizebpeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_range_copy(s : NlptokenizebpeRange) -> NlptokenizebpeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_range_fill(s : NlptokenizebpeRange, v : Double) -> NlptokenizebpeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_range_min(s : NlptokenizebpeRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_range_max(s : NlptokenizebpeRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_range_to_string(s : NlptokenizebpeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_slice_make(size : Int) -> NlptokenizebpeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_slice_len(s : NlptokenizebpeSlice) -> Int { s.size }

pub fn nlp_tokenize_bpe_slice_get(s : NlptokenizebpeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_slice_set(s : NlptokenizebpeSlice, i : Int, v : Double) -> NlptokenizebpeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_slice_sum(s : NlptokenizebpeSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_bpe_slice_mean(s : NlptokenizebpeSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_bpe_slice_scale(s : NlptokenizebpeSlice, f : Double) -> NlptokenizebpeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_slice_add(a : NlptokenizebpeSlice, b : NlptokenizebpeSlice) -> NlptokenizebpeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_tokenize_bpe_slice_copy(s : NlptokenizebpeSlice) -> NlptokenizebpeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_slice_fill(s : NlptokenizebpeSlice, v : Double) -> NlptokenizebpeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_tokenize_bpe_slice_min(s : NlptokenizebpeSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_bpe_slice_max(s : NlptokenizebpeSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_bpe_slice_to_string(s : NlptokenizebpeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

