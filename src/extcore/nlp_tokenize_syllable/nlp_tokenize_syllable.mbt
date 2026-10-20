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

pub fn NlptokenizesyllableFrame::len(self : NlptokenizesyllableFrame) -> Int { self.size }

pub fn NlptokenizesyllableFrame::get(self : NlptokenizesyllableFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableFrame::set(self : NlptokenizesyllableFrame, i : Int, v : Double) -> NlptokenizesyllableFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableFrame::sum(self : NlptokenizesyllableFrame) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableFrame::mean(self : NlptokenizesyllableFrame) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableFrame::scale(self : NlptokenizesyllableFrame, f : Double) -> NlptokenizesyllableFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableFrame::add(self : NlptokenizesyllableFrame, other : NlptokenizesyllableFrame) -> NlptokenizesyllableFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableFrame::copy(self : NlptokenizesyllableFrame) -> NlptokenizesyllableFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableFrame::fill(self : NlptokenizesyllableFrame, v : Double) -> NlptokenizesyllableFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableFrame::min(self : NlptokenizesyllableFrame) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableFrame::max(self : NlptokenizesyllableFrame) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableFrame::to_string(self : NlptokenizesyllableFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_table_make(size : Int) -> NlptokenizesyllableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableTable::len(self : NlptokenizesyllableTable) -> Int { self.size }

pub fn NlptokenizesyllableTable::get(self : NlptokenizesyllableTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableTable::set(self : NlptokenizesyllableTable, i : Int, v : Double) -> NlptokenizesyllableTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableTable::sum(self : NlptokenizesyllableTable) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableTable::mean(self : NlptokenizesyllableTable) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableTable::scale(self : NlptokenizesyllableTable, f : Double) -> NlptokenizesyllableTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableTable::add(self : NlptokenizesyllableTable, other : NlptokenizesyllableTable) -> NlptokenizesyllableTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableTable::copy(self : NlptokenizesyllableTable) -> NlptokenizesyllableTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableTable::fill(self : NlptokenizesyllableTable, v : Double) -> NlptokenizesyllableTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableTable::min(self : NlptokenizesyllableTable) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableTable::max(self : NlptokenizesyllableTable) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableTable::to_string(self : NlptokenizesyllableTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_graphn_make(size : Int) -> NlptokenizesyllableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableGraphN::len(self : NlptokenizesyllableGraphN) -> Int { self.size }

pub fn NlptokenizesyllableGraphN::get(self : NlptokenizesyllableGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableGraphN::set(self : NlptokenizesyllableGraphN, i : Int, v : Double) -> NlptokenizesyllableGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableGraphN::sum(self : NlptokenizesyllableGraphN) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableGraphN::mean(self : NlptokenizesyllableGraphN) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableGraphN::scale(self : NlptokenizesyllableGraphN, f : Double) -> NlptokenizesyllableGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableGraphN::add(self : NlptokenizesyllableGraphN, other : NlptokenizesyllableGraphN) -> NlptokenizesyllableGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableGraphN::copy(self : NlptokenizesyllableGraphN) -> NlptokenizesyllableGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableGraphN::fill(self : NlptokenizesyllableGraphN, v : Double) -> NlptokenizesyllableGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableGraphN::min(self : NlptokenizesyllableGraphN) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableGraphN::max(self : NlptokenizesyllableGraphN) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableGraphN::to_string(self : NlptokenizesyllableGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_node_make(size : Int) -> NlptokenizesyllableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableNode::len(self : NlptokenizesyllableNode) -> Int { self.size }

pub fn NlptokenizesyllableNode::get(self : NlptokenizesyllableNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableNode::set(self : NlptokenizesyllableNode, i : Int, v : Double) -> NlptokenizesyllableNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableNode::sum(self : NlptokenizesyllableNode) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableNode::mean(self : NlptokenizesyllableNode) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableNode::scale(self : NlptokenizesyllableNode, f : Double) -> NlptokenizesyllableNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableNode::add(self : NlptokenizesyllableNode, other : NlptokenizesyllableNode) -> NlptokenizesyllableNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableNode::copy(self : NlptokenizesyllableNode) -> NlptokenizesyllableNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableNode::fill(self : NlptokenizesyllableNode, v : Double) -> NlptokenizesyllableNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableNode::min(self : NlptokenizesyllableNode) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableNode::max(self : NlptokenizesyllableNode) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableNode::to_string(self : NlptokenizesyllableNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_edge_make(size : Int) -> NlptokenizesyllableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableEdge::len(self : NlptokenizesyllableEdge) -> Int { self.size }

pub fn NlptokenizesyllableEdge::get(self : NlptokenizesyllableEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableEdge::set(self : NlptokenizesyllableEdge, i : Int, v : Double) -> NlptokenizesyllableEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableEdge::sum(self : NlptokenizesyllableEdge) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableEdge::mean(self : NlptokenizesyllableEdge) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableEdge::scale(self : NlptokenizesyllableEdge, f : Double) -> NlptokenizesyllableEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableEdge::add(self : NlptokenizesyllableEdge, other : NlptokenizesyllableEdge) -> NlptokenizesyllableEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableEdge::copy(self : NlptokenizesyllableEdge) -> NlptokenizesyllableEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableEdge::fill(self : NlptokenizesyllableEdge, v : Double) -> NlptokenizesyllableEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableEdge::min(self : NlptokenizesyllableEdge) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableEdge::max(self : NlptokenizesyllableEdge) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableEdge::to_string(self : NlptokenizesyllableEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_path_make(size : Int) -> NlptokenizesyllablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllablePath::len(self : NlptokenizesyllablePath) -> Int { self.size }

pub fn NlptokenizesyllablePath::get(self : NlptokenizesyllablePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllablePath::set(self : NlptokenizesyllablePath, i : Int, v : Double) -> NlptokenizesyllablePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllablePath::sum(self : NlptokenizesyllablePath) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllablePath::mean(self : NlptokenizesyllablePath) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllablePath::scale(self : NlptokenizesyllablePath, f : Double) -> NlptokenizesyllablePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllablePath::add(self : NlptokenizesyllablePath, other : NlptokenizesyllablePath) -> NlptokenizesyllablePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllablePath::copy(self : NlptokenizesyllablePath) -> NlptokenizesyllablePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllablePath::fill(self : NlptokenizesyllablePath, v : Double) -> NlptokenizesyllablePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllablePath::min(self : NlptokenizesyllablePath) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllablePath::max(self : NlptokenizesyllablePath) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllablePath::to_string(self : NlptokenizesyllablePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_cluster_make(size : Int) -> NlptokenizesyllableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableCluster::len(self : NlptokenizesyllableCluster) -> Int { self.size }

pub fn NlptokenizesyllableCluster::get(self : NlptokenizesyllableCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableCluster::set(self : NlptokenizesyllableCluster, i : Int, v : Double) -> NlptokenizesyllableCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCluster::sum(self : NlptokenizesyllableCluster) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableCluster::mean(self : NlptokenizesyllableCluster) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableCluster::scale(self : NlptokenizesyllableCluster, f : Double) -> NlptokenizesyllableCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCluster::add(self : NlptokenizesyllableCluster, other : NlptokenizesyllableCluster) -> NlptokenizesyllableCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableCluster::copy(self : NlptokenizesyllableCluster) -> NlptokenizesyllableCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCluster::fill(self : NlptokenizesyllableCluster, v : Double) -> NlptokenizesyllableCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCluster::min(self : NlptokenizesyllableCluster) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableCluster::max(self : NlptokenizesyllableCluster) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableCluster::to_string(self : NlptokenizesyllableCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_model_make(size : Int) -> NlptokenizesyllableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableModel::len(self : NlptokenizesyllableModel) -> Int { self.size }

pub fn NlptokenizesyllableModel::get(self : NlptokenizesyllableModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableModel::set(self : NlptokenizesyllableModel, i : Int, v : Double) -> NlptokenizesyllableModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableModel::sum(self : NlptokenizesyllableModel) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableModel::mean(self : NlptokenizesyllableModel) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableModel::scale(self : NlptokenizesyllableModel, f : Double) -> NlptokenizesyllableModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableModel::add(self : NlptokenizesyllableModel, other : NlptokenizesyllableModel) -> NlptokenizesyllableModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableModel::copy(self : NlptokenizesyllableModel) -> NlptokenizesyllableModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableModel::fill(self : NlptokenizesyllableModel, v : Double) -> NlptokenizesyllableModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableModel::min(self : NlptokenizesyllableModel) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableModel::max(self : NlptokenizesyllableModel) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableModel::to_string(self : NlptokenizesyllableModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_layer_make(size : Int) -> NlptokenizesyllableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableLayer::len(self : NlptokenizesyllableLayer) -> Int { self.size }

pub fn NlptokenizesyllableLayer::get(self : NlptokenizesyllableLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableLayer::set(self : NlptokenizesyllableLayer, i : Int, v : Double) -> NlptokenizesyllableLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableLayer::sum(self : NlptokenizesyllableLayer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableLayer::mean(self : NlptokenizesyllableLayer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableLayer::scale(self : NlptokenizesyllableLayer, f : Double) -> NlptokenizesyllableLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableLayer::add(self : NlptokenizesyllableLayer, other : NlptokenizesyllableLayer) -> NlptokenizesyllableLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableLayer::copy(self : NlptokenizesyllableLayer) -> NlptokenizesyllableLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableLayer::fill(self : NlptokenizesyllableLayer, v : Double) -> NlptokenizesyllableLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableLayer::min(self : NlptokenizesyllableLayer) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableLayer::max(self : NlptokenizesyllableLayer) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableLayer::to_string(self : NlptokenizesyllableLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_buffer_make(size : Int) -> NlptokenizesyllableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableBuffer::len(self : NlptokenizesyllableBuffer) -> Int { self.size }

pub fn NlptokenizesyllableBuffer::get(self : NlptokenizesyllableBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableBuffer::set(self : NlptokenizesyllableBuffer, i : Int, v : Double) -> NlptokenizesyllableBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableBuffer::sum(self : NlptokenizesyllableBuffer) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableBuffer::mean(self : NlptokenizesyllableBuffer) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableBuffer::scale(self : NlptokenizesyllableBuffer, f : Double) -> NlptokenizesyllableBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableBuffer::add(self : NlptokenizesyllableBuffer, other : NlptokenizesyllableBuffer) -> NlptokenizesyllableBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableBuffer::copy(self : NlptokenizesyllableBuffer) -> NlptokenizesyllableBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableBuffer::fill(self : NlptokenizesyllableBuffer, v : Double) -> NlptokenizesyllableBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableBuffer::min(self : NlptokenizesyllableBuffer) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableBuffer::max(self : NlptokenizesyllableBuffer) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableBuffer::to_string(self : NlptokenizesyllableBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_cursor_make(size : Int) -> NlptokenizesyllableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableCursor::len(self : NlptokenizesyllableCursor) -> Int { self.size }

pub fn NlptokenizesyllableCursor::get(self : NlptokenizesyllableCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableCursor::set(self : NlptokenizesyllableCursor, i : Int, v : Double) -> NlptokenizesyllableCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCursor::sum(self : NlptokenizesyllableCursor) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableCursor::mean(self : NlptokenizesyllableCursor) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableCursor::scale(self : NlptokenizesyllableCursor, f : Double) -> NlptokenizesyllableCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCursor::add(self : NlptokenizesyllableCursor, other : NlptokenizesyllableCursor) -> NlptokenizesyllableCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableCursor::copy(self : NlptokenizesyllableCursor) -> NlptokenizesyllableCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCursor::fill(self : NlptokenizesyllableCursor, v : Double) -> NlptokenizesyllableCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableCursor::min(self : NlptokenizesyllableCursor) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableCursor::max(self : NlptokenizesyllableCursor) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableCursor::to_string(self : NlptokenizesyllableCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_view_make(size : Int) -> NlptokenizesyllableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableView::len(self : NlptokenizesyllableView) -> Int { self.size }

pub fn NlptokenizesyllableView::get(self : NlptokenizesyllableView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableView::set(self : NlptokenizesyllableView, i : Int, v : Double) -> NlptokenizesyllableView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableView::sum(self : NlptokenizesyllableView) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableView::mean(self : NlptokenizesyllableView) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableView::scale(self : NlptokenizesyllableView, f : Double) -> NlptokenizesyllableView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableView::add(self : NlptokenizesyllableView, other : NlptokenizesyllableView) -> NlptokenizesyllableView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableView::copy(self : NlptokenizesyllableView) -> NlptokenizesyllableView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableView::fill(self : NlptokenizesyllableView, v : Double) -> NlptokenizesyllableView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableView::min(self : NlptokenizesyllableView) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableView::max(self : NlptokenizesyllableView) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableView::to_string(self : NlptokenizesyllableView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_range_make(size : Int) -> NlptokenizesyllableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableRange::len(self : NlptokenizesyllableRange) -> Int { self.size }

pub fn NlptokenizesyllableRange::get(self : NlptokenizesyllableRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableRange::set(self : NlptokenizesyllableRange, i : Int, v : Double) -> NlptokenizesyllableRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableRange::sum(self : NlptokenizesyllableRange) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableRange::mean(self : NlptokenizesyllableRange) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableRange::scale(self : NlptokenizesyllableRange, f : Double) -> NlptokenizesyllableRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableRange::add(self : NlptokenizesyllableRange, other : NlptokenizesyllableRange) -> NlptokenizesyllableRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableRange::copy(self : NlptokenizesyllableRange) -> NlptokenizesyllableRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableRange::fill(self : NlptokenizesyllableRange, v : Double) -> NlptokenizesyllableRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableRange::min(self : NlptokenizesyllableRange) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableRange::max(self : NlptokenizesyllableRange) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableRange::to_string(self : NlptokenizesyllableRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_slice_make(size : Int) -> NlptokenizesyllableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlptokenizesyllableSlice::len(self : NlptokenizesyllableSlice) -> Int { self.size }

pub fn NlptokenizesyllableSlice::get(self : NlptokenizesyllableSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlptokenizesyllableSlice::set(self : NlptokenizesyllableSlice, i : Int, v : Double) -> NlptokenizesyllableSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableSlice::sum(self : NlptokenizesyllableSlice) -> Double { @_common.sum(self.data) }

pub fn NlptokenizesyllableSlice::mean(self : NlptokenizesyllableSlice) -> Double { @_common.mean(self.data) }

pub fn NlptokenizesyllableSlice::scale(self : NlptokenizesyllableSlice, f : Double) -> NlptokenizesyllableSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableSlice::add(self : NlptokenizesyllableSlice, other : NlptokenizesyllableSlice) -> NlptokenizesyllableSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlptokenizesyllableSlice::copy(self : NlptokenizesyllableSlice) -> NlptokenizesyllableSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableSlice::fill(self : NlptokenizesyllableSlice, v : Double) -> NlptokenizesyllableSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlptokenizesyllableSlice::min(self : NlptokenizesyllableSlice) -> Double { @_common.min(self.data) }

pub fn NlptokenizesyllableSlice::max(self : NlptokenizesyllableSlice) -> Double { @_common.max(self.data) }

pub fn NlptokenizesyllableSlice::to_string(self : NlptokenizesyllableSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

