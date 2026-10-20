///===
/// extcore/nlp_pos_maxent

pub(all) struct NlpposmaxentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_maxent_make_point(x : Double, y : Double) -> NlpposmaxentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_maxent_make_point3(x : Double, y : Double, z : Double) -> NlpposmaxentPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposmaxentPoint::x(self : NlpposmaxentPoint) -> Double { self.x }

pub fn NlpposmaxentPoint::y(self : NlpposmaxentPoint) -> Double { self.y }

pub fn NlpposmaxentPoint::z(self : NlpposmaxentPoint) -> Double { self.z }

pub fn NlpposmaxentPoint::label(self : NlpposmaxentPoint) -> Int { self.label }

pub fn NlpposmaxentPoint::dist(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposmaxentPoint::add(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposmaxentPoint::sub(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposmaxentPoint::scale(self : NlpposmaxentPoint, s : Double) -> NlpposmaxentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposmaxentPoint::dot(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposmaxentPoint::cross(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposmaxentPoint::norm(self : NlpposmaxentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposmaxentPoint::normalize(self : NlpposmaxentPoint) -> NlpposmaxentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposmaxentPoint::negate(self : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposmaxentPoint::mid(self : NlpposmaxentPoint, other : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposmaxentPoint::lerp(self : NlpposmaxentPoint, other : NlpposmaxentPoint, t : Double) -> NlpposmaxentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposmaxentPoint::to_string(self : NlpposmaxentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposmaxentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_maxent_make_series(vals : Array[Double], name : String) -> NlpposmaxentSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposmaxentSeries::len(self : NlpposmaxentSeries) -> Int { self.vals.length() }

pub fn NlpposmaxentSeries::sum(self : NlpposmaxentSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposmaxentSeries::mean(self : NlpposmaxentSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposmaxentSeries::min(self : NlpposmaxentSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposmaxentSeries::max(self : NlpposmaxentSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposmaxentSeries::range(self : NlpposmaxentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposmaxentSeries::variance(self : NlpposmaxentSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposmaxentSeries::std(self : NlpposmaxentSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposmaxentSeries::median(self : NlpposmaxentSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposmaxentSeries::scale(self : NlpposmaxentSeries, f : Double) -> NlpposmaxentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposmaxentSeries::add(self : NlpposmaxentSeries, other : NlpposmaxentSeries) -> NlpposmaxentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposmaxentSeries::sub(self : NlpposmaxentSeries, other : NlpposmaxentSeries) -> NlpposmaxentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposmaxentSeries::normalize(self : NlpposmaxentSeries) -> NlpposmaxentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposmaxentSeries::cumsum(self : NlpposmaxentSeries) -> NlpposmaxentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposmaxentSeries::to_string(self : NlpposmaxentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposmaxentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_maxent_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposmaxentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_maxent_matrix_identity(n : Int) -> NlpposmaxentMatrix {
  let m = nlp_pos_maxent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposmaxentMatrix::get(self : NlpposmaxentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposmaxentMatrix::transpose(self : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  let result = nlp_pos_maxent_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposmaxentMatrix::add(self : NlpposmaxentMatrix, other : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_maxent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposmaxentMatrix::scale(self : NlpposmaxentMatrix, s : Double) -> NlpposmaxentMatrix {
  let result = nlp_pos_maxent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposmaxentMatrix::multiply(self : NlpposmaxentMatrix, other : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  if self.cols != other.rows { return nlp_pos_maxent_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_maxent_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposmaxentMatrix::trace(self : NlpposmaxentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposmaxentMatrix::det(self : NlpposmaxentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposmaxentMatrix::norm(self : NlpposmaxentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposmaxentMatrix::to_string(self : NlpposmaxentMatrix) -> String {
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

pub(all) struct NlpposmaxentVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_maxent_make_vector(comps : Array[Double]) -> NlpposmaxentVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_maxent_vector_zero(dim : Int) -> NlpposmaxentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposmaxentVector::add(self : NlpposmaxentVector, other : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposmaxentVector::sub(self : NlpposmaxentVector, other : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposmaxentVector::scale(self : NlpposmaxentVector, s : Double) -> NlpposmaxentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposmaxentVector::dot(self : NlpposmaxentVector, other : NlpposmaxentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposmaxentVector::norm(self : NlpposmaxentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposmaxentVector::normalize(self : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposmaxentVector::dist(self : NlpposmaxentVector, other : NlpposmaxentVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposmaxentVector::to_string(self : NlpposmaxentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_maxent_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_maxent_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_maxent_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_maxent_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_maxent_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_maxent_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_maxent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_maxent_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_maxent_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_maxent_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_maxent_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_maxent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_maxent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_maxent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_maxent_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_maxent_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_maxent_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_maxent_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_maxent_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_maxent_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_maxent_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_maxent_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_maxent_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_maxent_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_maxent_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_maxent_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_maxent_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_maxent_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_maxent_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposmaxentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_frame_make(size : Int) -> NlpposmaxentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_frame_len(s : NlpposmaxentFrame) -> Int { s.size }

pub fn nlp_pos_maxent_frame_get(s : NlpposmaxentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_frame_set(s : NlpposmaxentFrame, i : Int, v : Double) -> NlpposmaxentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_frame_sum(s : NlpposmaxentFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_frame_mean(s : NlpposmaxentFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_frame_scale(s : NlpposmaxentFrame, f : Double) -> NlpposmaxentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_frame_add(a : NlpposmaxentFrame, b : NlpposmaxentFrame) -> NlpposmaxentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_frame_copy(s : NlpposmaxentFrame) -> NlpposmaxentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_frame_fill(s : NlpposmaxentFrame, v : Double) -> NlpposmaxentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_frame_min(s : NlpposmaxentFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_frame_max(s : NlpposmaxentFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_frame_to_string(s : NlpposmaxentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_table_make(size : Int) -> NlpposmaxentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_table_len(s : NlpposmaxentTable) -> Int { s.size }

pub fn nlp_pos_maxent_table_get(s : NlpposmaxentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_table_set(s : NlpposmaxentTable, i : Int, v : Double) -> NlpposmaxentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_table_sum(s : NlpposmaxentTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_table_mean(s : NlpposmaxentTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_table_scale(s : NlpposmaxentTable, f : Double) -> NlpposmaxentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_table_add(a : NlpposmaxentTable, b : NlpposmaxentTable) -> NlpposmaxentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_table_copy(s : NlpposmaxentTable) -> NlpposmaxentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_table_fill(s : NlpposmaxentTable, v : Double) -> NlpposmaxentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_table_min(s : NlpposmaxentTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_table_max(s : NlpposmaxentTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_table_to_string(s : NlpposmaxentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_graphn_make(size : Int) -> NlpposmaxentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_graphn_len(s : NlpposmaxentGraphN) -> Int { s.size }

pub fn nlp_pos_maxent_graphn_get(s : NlpposmaxentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_graphn_set(s : NlpposmaxentGraphN, i : Int, v : Double) -> NlpposmaxentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_graphn_sum(s : NlpposmaxentGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_graphn_mean(s : NlpposmaxentGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_graphn_scale(s : NlpposmaxentGraphN, f : Double) -> NlpposmaxentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_graphn_add(a : NlpposmaxentGraphN, b : NlpposmaxentGraphN) -> NlpposmaxentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_graphn_copy(s : NlpposmaxentGraphN) -> NlpposmaxentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_graphn_fill(s : NlpposmaxentGraphN, v : Double) -> NlpposmaxentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_graphn_min(s : NlpposmaxentGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_graphn_max(s : NlpposmaxentGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_graphn_to_string(s : NlpposmaxentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_node_make(size : Int) -> NlpposmaxentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_node_len(s : NlpposmaxentNode) -> Int { s.size }

pub fn nlp_pos_maxent_node_get(s : NlpposmaxentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_node_set(s : NlpposmaxentNode, i : Int, v : Double) -> NlpposmaxentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_node_sum(s : NlpposmaxentNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_node_mean(s : NlpposmaxentNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_node_scale(s : NlpposmaxentNode, f : Double) -> NlpposmaxentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_node_add(a : NlpposmaxentNode, b : NlpposmaxentNode) -> NlpposmaxentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_node_copy(s : NlpposmaxentNode) -> NlpposmaxentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_node_fill(s : NlpposmaxentNode, v : Double) -> NlpposmaxentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_node_min(s : NlpposmaxentNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_node_max(s : NlpposmaxentNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_node_to_string(s : NlpposmaxentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_edge_make(size : Int) -> NlpposmaxentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_edge_len(s : NlpposmaxentEdge) -> Int { s.size }

pub fn nlp_pos_maxent_edge_get(s : NlpposmaxentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_edge_set(s : NlpposmaxentEdge, i : Int, v : Double) -> NlpposmaxentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_edge_sum(s : NlpposmaxentEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_edge_mean(s : NlpposmaxentEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_edge_scale(s : NlpposmaxentEdge, f : Double) -> NlpposmaxentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_edge_add(a : NlpposmaxentEdge, b : NlpposmaxentEdge) -> NlpposmaxentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_edge_copy(s : NlpposmaxentEdge) -> NlpposmaxentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_edge_fill(s : NlpposmaxentEdge, v : Double) -> NlpposmaxentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_edge_min(s : NlpposmaxentEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_edge_max(s : NlpposmaxentEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_edge_to_string(s : NlpposmaxentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_path_make(size : Int) -> NlpposmaxentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_path_len(s : NlpposmaxentPath) -> Int { s.size }

pub fn nlp_pos_maxent_path_get(s : NlpposmaxentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_path_set(s : NlpposmaxentPath, i : Int, v : Double) -> NlpposmaxentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_path_sum(s : NlpposmaxentPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_path_mean(s : NlpposmaxentPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_path_scale(s : NlpposmaxentPath, f : Double) -> NlpposmaxentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_path_add(a : NlpposmaxentPath, b : NlpposmaxentPath) -> NlpposmaxentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_path_copy(s : NlpposmaxentPath) -> NlpposmaxentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_path_fill(s : NlpposmaxentPath, v : Double) -> NlpposmaxentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_path_min(s : NlpposmaxentPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_path_max(s : NlpposmaxentPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_path_to_string(s : NlpposmaxentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_cluster_make(size : Int) -> NlpposmaxentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_cluster_len(s : NlpposmaxentCluster) -> Int { s.size }

pub fn nlp_pos_maxent_cluster_get(s : NlpposmaxentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_cluster_set(s : NlpposmaxentCluster, i : Int, v : Double) -> NlpposmaxentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cluster_sum(s : NlpposmaxentCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_cluster_mean(s : NlpposmaxentCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_cluster_scale(s : NlpposmaxentCluster, f : Double) -> NlpposmaxentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cluster_add(a : NlpposmaxentCluster, b : NlpposmaxentCluster) -> NlpposmaxentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_cluster_copy(s : NlpposmaxentCluster) -> NlpposmaxentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cluster_fill(s : NlpposmaxentCluster, v : Double) -> NlpposmaxentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cluster_min(s : NlpposmaxentCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_cluster_max(s : NlpposmaxentCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_cluster_to_string(s : NlpposmaxentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_model_make(size : Int) -> NlpposmaxentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_model_len(s : NlpposmaxentModel) -> Int { s.size }

pub fn nlp_pos_maxent_model_get(s : NlpposmaxentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_model_set(s : NlpposmaxentModel, i : Int, v : Double) -> NlpposmaxentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_model_sum(s : NlpposmaxentModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_model_mean(s : NlpposmaxentModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_model_scale(s : NlpposmaxentModel, f : Double) -> NlpposmaxentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_model_add(a : NlpposmaxentModel, b : NlpposmaxentModel) -> NlpposmaxentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_model_copy(s : NlpposmaxentModel) -> NlpposmaxentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_model_fill(s : NlpposmaxentModel, v : Double) -> NlpposmaxentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_model_min(s : NlpposmaxentModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_model_max(s : NlpposmaxentModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_model_to_string(s : NlpposmaxentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_layer_make(size : Int) -> NlpposmaxentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_layer_len(s : NlpposmaxentLayer) -> Int { s.size }

pub fn nlp_pos_maxent_layer_get(s : NlpposmaxentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_layer_set(s : NlpposmaxentLayer, i : Int, v : Double) -> NlpposmaxentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_layer_sum(s : NlpposmaxentLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_layer_mean(s : NlpposmaxentLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_layer_scale(s : NlpposmaxentLayer, f : Double) -> NlpposmaxentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_layer_add(a : NlpposmaxentLayer, b : NlpposmaxentLayer) -> NlpposmaxentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_layer_copy(s : NlpposmaxentLayer) -> NlpposmaxentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_layer_fill(s : NlpposmaxentLayer, v : Double) -> NlpposmaxentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_layer_min(s : NlpposmaxentLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_layer_max(s : NlpposmaxentLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_layer_to_string(s : NlpposmaxentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_buffer_make(size : Int) -> NlpposmaxentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_buffer_len(s : NlpposmaxentBuffer) -> Int { s.size }

pub fn nlp_pos_maxent_buffer_get(s : NlpposmaxentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_buffer_set(s : NlpposmaxentBuffer, i : Int, v : Double) -> NlpposmaxentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_buffer_sum(s : NlpposmaxentBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_buffer_mean(s : NlpposmaxentBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_buffer_scale(s : NlpposmaxentBuffer, f : Double) -> NlpposmaxentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_buffer_add(a : NlpposmaxentBuffer, b : NlpposmaxentBuffer) -> NlpposmaxentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_buffer_copy(s : NlpposmaxentBuffer) -> NlpposmaxentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_buffer_fill(s : NlpposmaxentBuffer, v : Double) -> NlpposmaxentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_buffer_min(s : NlpposmaxentBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_buffer_max(s : NlpposmaxentBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_buffer_to_string(s : NlpposmaxentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_cursor_make(size : Int) -> NlpposmaxentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_cursor_len(s : NlpposmaxentCursor) -> Int { s.size }

pub fn nlp_pos_maxent_cursor_get(s : NlpposmaxentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_cursor_set(s : NlpposmaxentCursor, i : Int, v : Double) -> NlpposmaxentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cursor_sum(s : NlpposmaxentCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_cursor_mean(s : NlpposmaxentCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_cursor_scale(s : NlpposmaxentCursor, f : Double) -> NlpposmaxentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cursor_add(a : NlpposmaxentCursor, b : NlpposmaxentCursor) -> NlpposmaxentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_cursor_copy(s : NlpposmaxentCursor) -> NlpposmaxentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cursor_fill(s : NlpposmaxentCursor, v : Double) -> NlpposmaxentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_cursor_min(s : NlpposmaxentCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_cursor_max(s : NlpposmaxentCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_cursor_to_string(s : NlpposmaxentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_view_make(size : Int) -> NlpposmaxentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_view_len(s : NlpposmaxentView) -> Int { s.size }

pub fn nlp_pos_maxent_view_get(s : NlpposmaxentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_view_set(s : NlpposmaxentView, i : Int, v : Double) -> NlpposmaxentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_view_sum(s : NlpposmaxentView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_view_mean(s : NlpposmaxentView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_view_scale(s : NlpposmaxentView, f : Double) -> NlpposmaxentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_view_add(a : NlpposmaxentView, b : NlpposmaxentView) -> NlpposmaxentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_view_copy(s : NlpposmaxentView) -> NlpposmaxentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_view_fill(s : NlpposmaxentView, v : Double) -> NlpposmaxentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_view_min(s : NlpposmaxentView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_view_max(s : NlpposmaxentView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_view_to_string(s : NlpposmaxentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_range_make(size : Int) -> NlpposmaxentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_range_len(s : NlpposmaxentRange) -> Int { s.size }

pub fn nlp_pos_maxent_range_get(s : NlpposmaxentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_range_set(s : NlpposmaxentRange, i : Int, v : Double) -> NlpposmaxentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_range_sum(s : NlpposmaxentRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_range_mean(s : NlpposmaxentRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_range_scale(s : NlpposmaxentRange, f : Double) -> NlpposmaxentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_range_add(a : NlpposmaxentRange, b : NlpposmaxentRange) -> NlpposmaxentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_range_copy(s : NlpposmaxentRange) -> NlpposmaxentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_range_fill(s : NlpposmaxentRange, v : Double) -> NlpposmaxentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_range_min(s : NlpposmaxentRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_range_max(s : NlpposmaxentRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_range_to_string(s : NlpposmaxentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_slice_make(size : Int) -> NlpposmaxentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_slice_len(s : NlpposmaxentSlice) -> Int { s.size }

pub fn nlp_pos_maxent_slice_get(s : NlpposmaxentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_slice_set(s : NlpposmaxentSlice, i : Int, v : Double) -> NlpposmaxentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_slice_sum(s : NlpposmaxentSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_maxent_slice_mean(s : NlpposmaxentSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_maxent_slice_scale(s : NlpposmaxentSlice, f : Double) -> NlpposmaxentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_slice_add(a : NlpposmaxentSlice, b : NlpposmaxentSlice) -> NlpposmaxentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_maxent_slice_copy(s : NlpposmaxentSlice) -> NlpposmaxentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_slice_fill(s : NlpposmaxentSlice, v : Double) -> NlpposmaxentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_maxent_slice_min(s : NlpposmaxentSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_maxent_slice_max(s : NlpposmaxentSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_maxent_slice_to_string(s : NlpposmaxentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

