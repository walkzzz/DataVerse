///===
/// extcore/nlp_pos_bilstm

pub(all) struct NlpposbilstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_bilstm_make_point(x : Double, y : Double) -> NlpposbilstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_bilstm_make_point3(x : Double, y : Double, z : Double) -> NlpposbilstmPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposbilstmPoint::x(self : NlpposbilstmPoint) -> Double { self.x }

pub fn NlpposbilstmPoint::y(self : NlpposbilstmPoint) -> Double { self.y }

pub fn NlpposbilstmPoint::z(self : NlpposbilstmPoint) -> Double { self.z }

pub fn NlpposbilstmPoint::label(self : NlpposbilstmPoint) -> Int { self.label }

pub fn NlpposbilstmPoint::dist(self : NlpposbilstmPoint, other : NlpposbilstmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposbilstmPoint::add(self : NlpposbilstmPoint, other : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposbilstmPoint::sub(self : NlpposbilstmPoint, other : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposbilstmPoint::scale(self : NlpposbilstmPoint, s : Double) -> NlpposbilstmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposbilstmPoint::dot(self : NlpposbilstmPoint, other : NlpposbilstmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposbilstmPoint::cross(self : NlpposbilstmPoint, other : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposbilstmPoint::norm(self : NlpposbilstmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposbilstmPoint::normalize(self : NlpposbilstmPoint) -> NlpposbilstmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposbilstmPoint::negate(self : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposbilstmPoint::mid(self : NlpposbilstmPoint, other : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposbilstmPoint::lerp(self : NlpposbilstmPoint, other : NlpposbilstmPoint, t : Double) -> NlpposbilstmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposbilstmPoint::to_string(self : NlpposbilstmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposbilstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_bilstm_make_series(vals : Array[Double], name : String) -> NlpposbilstmSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposbilstmSeries::len(self : NlpposbilstmSeries) -> Int { self.vals.length() }

pub fn NlpposbilstmSeries::sum(self : NlpposbilstmSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposbilstmSeries::mean(self : NlpposbilstmSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposbilstmSeries::min(self : NlpposbilstmSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposbilstmSeries::max(self : NlpposbilstmSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposbilstmSeries::range(self : NlpposbilstmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposbilstmSeries::variance(self : NlpposbilstmSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposbilstmSeries::std(self : NlpposbilstmSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposbilstmSeries::median(self : NlpposbilstmSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposbilstmSeries::scale(self : NlpposbilstmSeries, f : Double) -> NlpposbilstmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposbilstmSeries::add(self : NlpposbilstmSeries, other : NlpposbilstmSeries) -> NlpposbilstmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposbilstmSeries::sub(self : NlpposbilstmSeries, other : NlpposbilstmSeries) -> NlpposbilstmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposbilstmSeries::normalize(self : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposbilstmSeries::cumsum(self : NlpposbilstmSeries) -> NlpposbilstmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposbilstmSeries::to_string(self : NlpposbilstmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposbilstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_bilstm_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposbilstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_bilstm_matrix_identity(n : Int) -> NlpposbilstmMatrix {
  let m = nlp_pos_bilstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposbilstmMatrix::get(self : NlpposbilstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposbilstmMatrix::transpose(self : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  let result = nlp_pos_bilstm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposbilstmMatrix::add(self : NlpposbilstmMatrix, other : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_bilstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposbilstmMatrix::scale(self : NlpposbilstmMatrix, s : Double) -> NlpposbilstmMatrix {
  let result = nlp_pos_bilstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposbilstmMatrix::multiply(self : NlpposbilstmMatrix, other : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  if self.cols != other.rows { return nlp_pos_bilstm_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_bilstm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposbilstmMatrix::trace(self : NlpposbilstmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposbilstmMatrix::det(self : NlpposbilstmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposbilstmMatrix::norm(self : NlpposbilstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposbilstmMatrix::to_string(self : NlpposbilstmMatrix) -> String {
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

pub(all) struct NlpposbilstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_bilstm_make_vector(comps : Array[Double]) -> NlpposbilstmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_bilstm_vector_zero(dim : Int) -> NlpposbilstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposbilstmVector::add(self : NlpposbilstmVector, other : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposbilstmVector::sub(self : NlpposbilstmVector, other : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposbilstmVector::scale(self : NlpposbilstmVector, s : Double) -> NlpposbilstmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposbilstmVector::dot(self : NlpposbilstmVector, other : NlpposbilstmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposbilstmVector::norm(self : NlpposbilstmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposbilstmVector::normalize(self : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposbilstmVector::dist(self : NlpposbilstmVector, other : NlpposbilstmVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposbilstmVector::to_string(self : NlpposbilstmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_bilstm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_bilstm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_bilstm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_bilstm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_bilstm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_bilstm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_bilstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_bilstm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_bilstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_bilstm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_bilstm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_bilstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_bilstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_bilstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_bilstm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_bilstm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_bilstm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_bilstm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_bilstm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_bilstm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_bilstm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_bilstm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_bilstm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_bilstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_bilstm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_bilstm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_bilstm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_bilstm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_bilstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposbilstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_frame_make(size : Int) -> NlpposbilstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_frame_len(s : NlpposbilstmFrame) -> Int { s.size }

pub fn nlp_pos_bilstm_frame_get(s : NlpposbilstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_frame_set(s : NlpposbilstmFrame, i : Int, v : Double) -> NlpposbilstmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_frame_sum(s : NlpposbilstmFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_frame_mean(s : NlpposbilstmFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_frame_scale(s : NlpposbilstmFrame, f : Double) -> NlpposbilstmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_frame_add(a : NlpposbilstmFrame, b : NlpposbilstmFrame) -> NlpposbilstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_frame_copy(s : NlpposbilstmFrame) -> NlpposbilstmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_frame_fill(s : NlpposbilstmFrame, v : Double) -> NlpposbilstmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_frame_min(s : NlpposbilstmFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_frame_max(s : NlpposbilstmFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_frame_to_string(s : NlpposbilstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_table_make(size : Int) -> NlpposbilstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_table_len(s : NlpposbilstmTable) -> Int { s.size }

pub fn nlp_pos_bilstm_table_get(s : NlpposbilstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_table_set(s : NlpposbilstmTable, i : Int, v : Double) -> NlpposbilstmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_table_sum(s : NlpposbilstmTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_table_mean(s : NlpposbilstmTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_table_scale(s : NlpposbilstmTable, f : Double) -> NlpposbilstmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_table_add(a : NlpposbilstmTable, b : NlpposbilstmTable) -> NlpposbilstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_table_copy(s : NlpposbilstmTable) -> NlpposbilstmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_table_fill(s : NlpposbilstmTable, v : Double) -> NlpposbilstmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_table_min(s : NlpposbilstmTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_table_max(s : NlpposbilstmTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_table_to_string(s : NlpposbilstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_graphn_make(size : Int) -> NlpposbilstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_graphn_len(s : NlpposbilstmGraphN) -> Int { s.size }

pub fn nlp_pos_bilstm_graphn_get(s : NlpposbilstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_graphn_set(s : NlpposbilstmGraphN, i : Int, v : Double) -> NlpposbilstmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_graphn_sum(s : NlpposbilstmGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_graphn_mean(s : NlpposbilstmGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_graphn_scale(s : NlpposbilstmGraphN, f : Double) -> NlpposbilstmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_graphn_add(a : NlpposbilstmGraphN, b : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_graphn_copy(s : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_graphn_fill(s : NlpposbilstmGraphN, v : Double) -> NlpposbilstmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_graphn_min(s : NlpposbilstmGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_graphn_max(s : NlpposbilstmGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_graphn_to_string(s : NlpposbilstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_node_make(size : Int) -> NlpposbilstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_node_len(s : NlpposbilstmNode) -> Int { s.size }

pub fn nlp_pos_bilstm_node_get(s : NlpposbilstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_node_set(s : NlpposbilstmNode, i : Int, v : Double) -> NlpposbilstmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_node_sum(s : NlpposbilstmNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_node_mean(s : NlpposbilstmNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_node_scale(s : NlpposbilstmNode, f : Double) -> NlpposbilstmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_node_add(a : NlpposbilstmNode, b : NlpposbilstmNode) -> NlpposbilstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_node_copy(s : NlpposbilstmNode) -> NlpposbilstmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_node_fill(s : NlpposbilstmNode, v : Double) -> NlpposbilstmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_node_min(s : NlpposbilstmNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_node_max(s : NlpposbilstmNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_node_to_string(s : NlpposbilstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_edge_make(size : Int) -> NlpposbilstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_edge_len(s : NlpposbilstmEdge) -> Int { s.size }

pub fn nlp_pos_bilstm_edge_get(s : NlpposbilstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_edge_set(s : NlpposbilstmEdge, i : Int, v : Double) -> NlpposbilstmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_edge_sum(s : NlpposbilstmEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_edge_mean(s : NlpposbilstmEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_edge_scale(s : NlpposbilstmEdge, f : Double) -> NlpposbilstmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_edge_add(a : NlpposbilstmEdge, b : NlpposbilstmEdge) -> NlpposbilstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_edge_copy(s : NlpposbilstmEdge) -> NlpposbilstmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_edge_fill(s : NlpposbilstmEdge, v : Double) -> NlpposbilstmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_edge_min(s : NlpposbilstmEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_edge_max(s : NlpposbilstmEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_edge_to_string(s : NlpposbilstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_path_make(size : Int) -> NlpposbilstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_path_len(s : NlpposbilstmPath) -> Int { s.size }

pub fn nlp_pos_bilstm_path_get(s : NlpposbilstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_path_set(s : NlpposbilstmPath, i : Int, v : Double) -> NlpposbilstmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_path_sum(s : NlpposbilstmPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_path_mean(s : NlpposbilstmPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_path_scale(s : NlpposbilstmPath, f : Double) -> NlpposbilstmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_path_add(a : NlpposbilstmPath, b : NlpposbilstmPath) -> NlpposbilstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_path_copy(s : NlpposbilstmPath) -> NlpposbilstmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_path_fill(s : NlpposbilstmPath, v : Double) -> NlpposbilstmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_path_min(s : NlpposbilstmPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_path_max(s : NlpposbilstmPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_path_to_string(s : NlpposbilstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cluster_make(size : Int) -> NlpposbilstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_cluster_len(s : NlpposbilstmCluster) -> Int { s.size }

pub fn nlp_pos_bilstm_cluster_get(s : NlpposbilstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_cluster_set(s : NlpposbilstmCluster, i : Int, v : Double) -> NlpposbilstmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cluster_sum(s : NlpposbilstmCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_cluster_mean(s : NlpposbilstmCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_cluster_scale(s : NlpposbilstmCluster, f : Double) -> NlpposbilstmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cluster_add(a : NlpposbilstmCluster, b : NlpposbilstmCluster) -> NlpposbilstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_cluster_copy(s : NlpposbilstmCluster) -> NlpposbilstmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cluster_fill(s : NlpposbilstmCluster, v : Double) -> NlpposbilstmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cluster_min(s : NlpposbilstmCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_cluster_max(s : NlpposbilstmCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_cluster_to_string(s : NlpposbilstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_model_make(size : Int) -> NlpposbilstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_model_len(s : NlpposbilstmModel) -> Int { s.size }

pub fn nlp_pos_bilstm_model_get(s : NlpposbilstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_model_set(s : NlpposbilstmModel, i : Int, v : Double) -> NlpposbilstmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_model_sum(s : NlpposbilstmModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_model_mean(s : NlpposbilstmModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_model_scale(s : NlpposbilstmModel, f : Double) -> NlpposbilstmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_model_add(a : NlpposbilstmModel, b : NlpposbilstmModel) -> NlpposbilstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_model_copy(s : NlpposbilstmModel) -> NlpposbilstmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_model_fill(s : NlpposbilstmModel, v : Double) -> NlpposbilstmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_model_min(s : NlpposbilstmModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_model_max(s : NlpposbilstmModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_model_to_string(s : NlpposbilstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_layer_make(size : Int) -> NlpposbilstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_layer_len(s : NlpposbilstmLayer) -> Int { s.size }

pub fn nlp_pos_bilstm_layer_get(s : NlpposbilstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_layer_set(s : NlpposbilstmLayer, i : Int, v : Double) -> NlpposbilstmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_layer_sum(s : NlpposbilstmLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_layer_mean(s : NlpposbilstmLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_layer_scale(s : NlpposbilstmLayer, f : Double) -> NlpposbilstmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_layer_add(a : NlpposbilstmLayer, b : NlpposbilstmLayer) -> NlpposbilstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_layer_copy(s : NlpposbilstmLayer) -> NlpposbilstmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_layer_fill(s : NlpposbilstmLayer, v : Double) -> NlpposbilstmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_layer_min(s : NlpposbilstmLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_layer_max(s : NlpposbilstmLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_layer_to_string(s : NlpposbilstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_buffer_make(size : Int) -> NlpposbilstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_buffer_len(s : NlpposbilstmBuffer) -> Int { s.size }

pub fn nlp_pos_bilstm_buffer_get(s : NlpposbilstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_buffer_set(s : NlpposbilstmBuffer, i : Int, v : Double) -> NlpposbilstmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_buffer_sum(s : NlpposbilstmBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_buffer_mean(s : NlpposbilstmBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_buffer_scale(s : NlpposbilstmBuffer, f : Double) -> NlpposbilstmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_buffer_add(a : NlpposbilstmBuffer, b : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_buffer_copy(s : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_buffer_fill(s : NlpposbilstmBuffer, v : Double) -> NlpposbilstmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_buffer_min(s : NlpposbilstmBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_buffer_max(s : NlpposbilstmBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_buffer_to_string(s : NlpposbilstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cursor_make(size : Int) -> NlpposbilstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_cursor_len(s : NlpposbilstmCursor) -> Int { s.size }

pub fn nlp_pos_bilstm_cursor_get(s : NlpposbilstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_cursor_set(s : NlpposbilstmCursor, i : Int, v : Double) -> NlpposbilstmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cursor_sum(s : NlpposbilstmCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_cursor_mean(s : NlpposbilstmCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_cursor_scale(s : NlpposbilstmCursor, f : Double) -> NlpposbilstmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cursor_add(a : NlpposbilstmCursor, b : NlpposbilstmCursor) -> NlpposbilstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_cursor_copy(s : NlpposbilstmCursor) -> NlpposbilstmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cursor_fill(s : NlpposbilstmCursor, v : Double) -> NlpposbilstmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_cursor_min(s : NlpposbilstmCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_cursor_max(s : NlpposbilstmCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_cursor_to_string(s : NlpposbilstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_view_make(size : Int) -> NlpposbilstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_view_len(s : NlpposbilstmView) -> Int { s.size }

pub fn nlp_pos_bilstm_view_get(s : NlpposbilstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_view_set(s : NlpposbilstmView, i : Int, v : Double) -> NlpposbilstmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_view_sum(s : NlpposbilstmView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_view_mean(s : NlpposbilstmView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_view_scale(s : NlpposbilstmView, f : Double) -> NlpposbilstmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_view_add(a : NlpposbilstmView, b : NlpposbilstmView) -> NlpposbilstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_view_copy(s : NlpposbilstmView) -> NlpposbilstmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_view_fill(s : NlpposbilstmView, v : Double) -> NlpposbilstmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_view_min(s : NlpposbilstmView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_view_max(s : NlpposbilstmView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_view_to_string(s : NlpposbilstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_range_make(size : Int) -> NlpposbilstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_range_len(s : NlpposbilstmRange) -> Int { s.size }

pub fn nlp_pos_bilstm_range_get(s : NlpposbilstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_range_set(s : NlpposbilstmRange, i : Int, v : Double) -> NlpposbilstmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_range_sum(s : NlpposbilstmRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_range_mean(s : NlpposbilstmRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_range_scale(s : NlpposbilstmRange, f : Double) -> NlpposbilstmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_range_add(a : NlpposbilstmRange, b : NlpposbilstmRange) -> NlpposbilstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_range_copy(s : NlpposbilstmRange) -> NlpposbilstmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_range_fill(s : NlpposbilstmRange, v : Double) -> NlpposbilstmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_range_min(s : NlpposbilstmRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_range_max(s : NlpposbilstmRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_range_to_string(s : NlpposbilstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_slice_make(size : Int) -> NlpposbilstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_slice_len(s : NlpposbilstmSlice) -> Int { s.size }

pub fn nlp_pos_bilstm_slice_get(s : NlpposbilstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_slice_set(s : NlpposbilstmSlice, i : Int, v : Double) -> NlpposbilstmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_slice_sum(s : NlpposbilstmSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_bilstm_slice_mean(s : NlpposbilstmSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_bilstm_slice_scale(s : NlpposbilstmSlice, f : Double) -> NlpposbilstmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_slice_add(a : NlpposbilstmSlice, b : NlpposbilstmSlice) -> NlpposbilstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_bilstm_slice_copy(s : NlpposbilstmSlice) -> NlpposbilstmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_slice_fill(s : NlpposbilstmSlice, v : Double) -> NlpposbilstmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_bilstm_slice_min(s : NlpposbilstmSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_bilstm_slice_max(s : NlpposbilstmSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_bilstm_slice_to_string(s : NlpposbilstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

