///===
/// extcore/nlp_pos_svm

pub(all) struct NlppossvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_svm_make_point(x : Double, y : Double) -> NlppossvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_svm_make_point3(x : Double, y : Double, z : Double) -> NlppossvmPoint {
  { x, y, z, label: 0 }
}

pub fn NlppossvmPoint::x(self : NlppossvmPoint) -> Double { self.x }

pub fn NlppossvmPoint::y(self : NlppossvmPoint) -> Double { self.y }

pub fn NlppossvmPoint::z(self : NlppossvmPoint) -> Double { self.z }

pub fn NlppossvmPoint::label(self : NlppossvmPoint) -> Int { self.label }

pub fn NlppossvmPoint::dist(self : NlppossvmPoint, other : NlppossvmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlppossvmPoint::add(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlppossvmPoint::sub(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlppossvmPoint::scale(self : NlppossvmPoint, s : Double) -> NlppossvmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlppossvmPoint::dot(self : NlppossvmPoint, other : NlppossvmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlppossvmPoint::cross(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlppossvmPoint::norm(self : NlppossvmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlppossvmPoint::normalize(self : NlppossvmPoint) -> NlppossvmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppossvmPoint::negate(self : NlppossvmPoint) -> NlppossvmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlppossvmPoint::mid(self : NlppossvmPoint, other : NlppossvmPoint) -> NlppossvmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlppossvmPoint::lerp(self : NlppossvmPoint, other : NlppossvmPoint, t : Double) -> NlppossvmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlppossvmPoint::to_string(self : NlppossvmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlppossvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_svm_make_series(vals : Array[Double], name : String) -> NlppossvmSeries {
  { vals, name, meta: 0 }
}

pub fn NlppossvmSeries::len(self : NlppossvmSeries) -> Int { self.vals.length() }

pub fn NlppossvmSeries::sum(self : NlppossvmSeries) -> Double { @_common.sum(self.vals) }

pub fn NlppossvmSeries::mean(self : NlppossvmSeries) -> Double { @_common.mean(self.vals) }

pub fn NlppossvmSeries::min(self : NlppossvmSeries) -> Double { @_common.min(self.vals) }

pub fn NlppossvmSeries::max(self : NlppossvmSeries) -> Double { @_common.max(self.vals) }

pub fn NlppossvmSeries::range(self : NlppossvmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlppossvmSeries::variance(self : NlppossvmSeries) -> Double { @_common.variance(self.vals) }

pub fn NlppossvmSeries::std(self : NlppossvmSeries) -> Double { @_common.std(self.vals) }

pub fn NlppossvmSeries::median(self : NlppossvmSeries) -> Double { @_common.median(self.vals) }

pub fn NlppossvmSeries::scale(self : NlppossvmSeries, f : Double) -> NlppossvmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlppossvmSeries::add(self : NlppossvmSeries, other : NlppossvmSeries) -> NlppossvmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlppossvmSeries::sub(self : NlppossvmSeries, other : NlppossvmSeries) -> NlppossvmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlppossvmSeries::normalize(self : NlppossvmSeries) -> NlppossvmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlppossvmSeries::cumsum(self : NlppossvmSeries) -> NlppossvmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlppossvmSeries::to_string(self : NlppossvmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppossvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_svm_make_matrix(rows : Int, cols : Int, val : Double) -> NlppossvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_svm_matrix_identity(n : Int) -> NlppossvmMatrix {
  let m = nlp_pos_svm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlppossvmMatrix::get(self : NlppossvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlppossvmMatrix::transpose(self : NlppossvmMatrix) -> NlppossvmMatrix {
  let result = nlp_pos_svm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlppossvmMatrix::add(self : NlppossvmMatrix, other : NlppossvmMatrix) -> NlppossvmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_svm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlppossvmMatrix::scale(self : NlppossvmMatrix, s : Double) -> NlppossvmMatrix {
  let result = nlp_pos_svm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlppossvmMatrix::multiply(self : NlppossvmMatrix, other : NlppossvmMatrix) -> NlppossvmMatrix {
  if self.cols != other.rows { return nlp_pos_svm_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_svm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlppossvmMatrix::trace(self : NlppossvmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlppossvmMatrix::det(self : NlppossvmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlppossvmMatrix::norm(self : NlppossvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlppossvmMatrix::to_string(self : NlppossvmMatrix) -> String {
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

pub(all) struct NlppossvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_svm_make_vector(comps : Array[Double]) -> NlppossvmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_svm_vector_zero(dim : Int) -> NlppossvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlppossvmVector::add(self : NlppossvmVector, other : NlppossvmVector) -> NlppossvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlppossvmVector::sub(self : NlppossvmVector, other : NlppossvmVector) -> NlppossvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlppossvmVector::scale(self : NlppossvmVector, s : Double) -> NlppossvmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlppossvmVector::dot(self : NlppossvmVector, other : NlppossvmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlppossvmVector::norm(self : NlppossvmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlppossvmVector::normalize(self : NlppossvmVector) -> NlppossvmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppossvmVector::dist(self : NlppossvmVector, other : NlppossvmVector) -> Double {
  self.sub(other).norm()
}

pub fn NlppossvmVector::to_string(self : NlppossvmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_svm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_svm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_svm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_svm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_svm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_svm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_svm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_svm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_svm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_svm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_svm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_svm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_svm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_svm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_svm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_svm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_svm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_svm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_svm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_svm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_svm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_svm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_svm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_svm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_svm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_svm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_svm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_svm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_svm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlppossvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_frame_make(size : Int) -> NlppossvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_frame_len(s : NlppossvmFrame) -> Int { s.size }

pub fn nlp_pos_svm_frame_get(s : NlppossvmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_frame_set(s : NlppossvmFrame, i : Int, v : Double) -> NlppossvmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_frame_sum(s : NlppossvmFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_frame_mean(s : NlppossvmFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_frame_scale(s : NlppossvmFrame, f : Double) -> NlppossvmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_frame_add(a : NlppossvmFrame, b : NlppossvmFrame) -> NlppossvmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_frame_copy(s : NlppossvmFrame) -> NlppossvmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_frame_fill(s : NlppossvmFrame, v : Double) -> NlppossvmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_frame_min(s : NlppossvmFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_frame_max(s : NlppossvmFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_frame_to_string(s : NlppossvmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_table_make(size : Int) -> NlppossvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_table_len(s : NlppossvmTable) -> Int { s.size }

pub fn nlp_pos_svm_table_get(s : NlppossvmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_table_set(s : NlppossvmTable, i : Int, v : Double) -> NlppossvmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_table_sum(s : NlppossvmTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_table_mean(s : NlppossvmTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_table_scale(s : NlppossvmTable, f : Double) -> NlppossvmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_table_add(a : NlppossvmTable, b : NlppossvmTable) -> NlppossvmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_table_copy(s : NlppossvmTable) -> NlppossvmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_table_fill(s : NlppossvmTable, v : Double) -> NlppossvmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_table_min(s : NlppossvmTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_table_max(s : NlppossvmTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_table_to_string(s : NlppossvmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_graphn_make(size : Int) -> NlppossvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_graphn_len(s : NlppossvmGraphN) -> Int { s.size }

pub fn nlp_pos_svm_graphn_get(s : NlppossvmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_graphn_set(s : NlppossvmGraphN, i : Int, v : Double) -> NlppossvmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_graphn_sum(s : NlppossvmGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_graphn_mean(s : NlppossvmGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_graphn_scale(s : NlppossvmGraphN, f : Double) -> NlppossvmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_graphn_add(a : NlppossvmGraphN, b : NlppossvmGraphN) -> NlppossvmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_graphn_copy(s : NlppossvmGraphN) -> NlppossvmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_graphn_fill(s : NlppossvmGraphN, v : Double) -> NlppossvmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_graphn_min(s : NlppossvmGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_graphn_max(s : NlppossvmGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_graphn_to_string(s : NlppossvmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_node_make(size : Int) -> NlppossvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_node_len(s : NlppossvmNode) -> Int { s.size }

pub fn nlp_pos_svm_node_get(s : NlppossvmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_node_set(s : NlppossvmNode, i : Int, v : Double) -> NlppossvmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_node_sum(s : NlppossvmNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_node_mean(s : NlppossvmNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_node_scale(s : NlppossvmNode, f : Double) -> NlppossvmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_node_add(a : NlppossvmNode, b : NlppossvmNode) -> NlppossvmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_node_copy(s : NlppossvmNode) -> NlppossvmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_node_fill(s : NlppossvmNode, v : Double) -> NlppossvmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_node_min(s : NlppossvmNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_node_max(s : NlppossvmNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_node_to_string(s : NlppossvmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_edge_make(size : Int) -> NlppossvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_edge_len(s : NlppossvmEdge) -> Int { s.size }

pub fn nlp_pos_svm_edge_get(s : NlppossvmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_edge_set(s : NlppossvmEdge, i : Int, v : Double) -> NlppossvmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_edge_sum(s : NlppossvmEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_edge_mean(s : NlppossvmEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_edge_scale(s : NlppossvmEdge, f : Double) -> NlppossvmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_edge_add(a : NlppossvmEdge, b : NlppossvmEdge) -> NlppossvmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_edge_copy(s : NlppossvmEdge) -> NlppossvmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_edge_fill(s : NlppossvmEdge, v : Double) -> NlppossvmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_edge_min(s : NlppossvmEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_edge_max(s : NlppossvmEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_edge_to_string(s : NlppossvmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_path_make(size : Int) -> NlppossvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_path_len(s : NlppossvmPath) -> Int { s.size }

pub fn nlp_pos_svm_path_get(s : NlppossvmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_path_set(s : NlppossvmPath, i : Int, v : Double) -> NlppossvmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_path_sum(s : NlppossvmPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_path_mean(s : NlppossvmPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_path_scale(s : NlppossvmPath, f : Double) -> NlppossvmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_path_add(a : NlppossvmPath, b : NlppossvmPath) -> NlppossvmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_path_copy(s : NlppossvmPath) -> NlppossvmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_path_fill(s : NlppossvmPath, v : Double) -> NlppossvmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_path_min(s : NlppossvmPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_path_max(s : NlppossvmPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_path_to_string(s : NlppossvmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_cluster_make(size : Int) -> NlppossvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_cluster_len(s : NlppossvmCluster) -> Int { s.size }

pub fn nlp_pos_svm_cluster_get(s : NlppossvmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_cluster_set(s : NlppossvmCluster, i : Int, v : Double) -> NlppossvmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cluster_sum(s : NlppossvmCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_cluster_mean(s : NlppossvmCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_cluster_scale(s : NlppossvmCluster, f : Double) -> NlppossvmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cluster_add(a : NlppossvmCluster, b : NlppossvmCluster) -> NlppossvmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_cluster_copy(s : NlppossvmCluster) -> NlppossvmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cluster_fill(s : NlppossvmCluster, v : Double) -> NlppossvmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cluster_min(s : NlppossvmCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_cluster_max(s : NlppossvmCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_cluster_to_string(s : NlppossvmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_model_make(size : Int) -> NlppossvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_model_len(s : NlppossvmModel) -> Int { s.size }

pub fn nlp_pos_svm_model_get(s : NlppossvmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_model_set(s : NlppossvmModel, i : Int, v : Double) -> NlppossvmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_model_sum(s : NlppossvmModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_model_mean(s : NlppossvmModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_model_scale(s : NlppossvmModel, f : Double) -> NlppossvmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_model_add(a : NlppossvmModel, b : NlppossvmModel) -> NlppossvmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_model_copy(s : NlppossvmModel) -> NlppossvmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_model_fill(s : NlppossvmModel, v : Double) -> NlppossvmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_model_min(s : NlppossvmModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_model_max(s : NlppossvmModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_model_to_string(s : NlppossvmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_layer_make(size : Int) -> NlppossvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_layer_len(s : NlppossvmLayer) -> Int { s.size }

pub fn nlp_pos_svm_layer_get(s : NlppossvmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_layer_set(s : NlppossvmLayer, i : Int, v : Double) -> NlppossvmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_layer_sum(s : NlppossvmLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_layer_mean(s : NlppossvmLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_layer_scale(s : NlppossvmLayer, f : Double) -> NlppossvmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_layer_add(a : NlppossvmLayer, b : NlppossvmLayer) -> NlppossvmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_layer_copy(s : NlppossvmLayer) -> NlppossvmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_layer_fill(s : NlppossvmLayer, v : Double) -> NlppossvmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_layer_min(s : NlppossvmLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_layer_max(s : NlppossvmLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_layer_to_string(s : NlppossvmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_buffer_make(size : Int) -> NlppossvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_buffer_len(s : NlppossvmBuffer) -> Int { s.size }

pub fn nlp_pos_svm_buffer_get(s : NlppossvmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_buffer_set(s : NlppossvmBuffer, i : Int, v : Double) -> NlppossvmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_buffer_sum(s : NlppossvmBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_buffer_mean(s : NlppossvmBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_buffer_scale(s : NlppossvmBuffer, f : Double) -> NlppossvmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_buffer_add(a : NlppossvmBuffer, b : NlppossvmBuffer) -> NlppossvmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_buffer_copy(s : NlppossvmBuffer) -> NlppossvmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_buffer_fill(s : NlppossvmBuffer, v : Double) -> NlppossvmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_buffer_min(s : NlppossvmBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_buffer_max(s : NlppossvmBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_buffer_to_string(s : NlppossvmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_cursor_make(size : Int) -> NlppossvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_cursor_len(s : NlppossvmCursor) -> Int { s.size }

pub fn nlp_pos_svm_cursor_get(s : NlppossvmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_cursor_set(s : NlppossvmCursor, i : Int, v : Double) -> NlppossvmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cursor_sum(s : NlppossvmCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_cursor_mean(s : NlppossvmCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_cursor_scale(s : NlppossvmCursor, f : Double) -> NlppossvmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cursor_add(a : NlppossvmCursor, b : NlppossvmCursor) -> NlppossvmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_cursor_copy(s : NlppossvmCursor) -> NlppossvmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cursor_fill(s : NlppossvmCursor, v : Double) -> NlppossvmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_cursor_min(s : NlppossvmCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_cursor_max(s : NlppossvmCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_cursor_to_string(s : NlppossvmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_view_make(size : Int) -> NlppossvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_view_len(s : NlppossvmView) -> Int { s.size }

pub fn nlp_pos_svm_view_get(s : NlppossvmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_view_set(s : NlppossvmView, i : Int, v : Double) -> NlppossvmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_view_sum(s : NlppossvmView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_view_mean(s : NlppossvmView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_view_scale(s : NlppossvmView, f : Double) -> NlppossvmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_view_add(a : NlppossvmView, b : NlppossvmView) -> NlppossvmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_view_copy(s : NlppossvmView) -> NlppossvmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_view_fill(s : NlppossvmView, v : Double) -> NlppossvmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_view_min(s : NlppossvmView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_view_max(s : NlppossvmView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_view_to_string(s : NlppossvmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_range_make(size : Int) -> NlppossvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_range_len(s : NlppossvmRange) -> Int { s.size }

pub fn nlp_pos_svm_range_get(s : NlppossvmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_range_set(s : NlppossvmRange, i : Int, v : Double) -> NlppossvmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_range_sum(s : NlppossvmRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_range_mean(s : NlppossvmRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_range_scale(s : NlppossvmRange, f : Double) -> NlppossvmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_range_add(a : NlppossvmRange, b : NlppossvmRange) -> NlppossvmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_range_copy(s : NlppossvmRange) -> NlppossvmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_range_fill(s : NlppossvmRange, v : Double) -> NlppossvmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_range_min(s : NlppossvmRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_range_max(s : NlppossvmRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_range_to_string(s : NlppossvmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppossvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_svm_slice_make(size : Int) -> NlppossvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_svm_slice_len(s : NlppossvmSlice) -> Int { s.size }

pub fn nlp_pos_svm_slice_get(s : NlppossvmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_svm_slice_set(s : NlppossvmSlice, i : Int, v : Double) -> NlppossvmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_slice_sum(s : NlppossvmSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_svm_slice_mean(s : NlppossvmSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_svm_slice_scale(s : NlppossvmSlice, f : Double) -> NlppossvmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_slice_add(a : NlppossvmSlice, b : NlppossvmSlice) -> NlppossvmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_svm_slice_copy(s : NlppossvmSlice) -> NlppossvmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_slice_fill(s : NlppossvmSlice, v : Double) -> NlppossvmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_svm_slice_min(s : NlppossvmSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_svm_slice_max(s : NlppossvmSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_svm_slice_to_string(s : NlppossvmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

