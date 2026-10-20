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

pub fn NlpposbilstmFrame::len(self : NlpposbilstmFrame) -> Int { self.size }

pub fn NlpposbilstmFrame::get(self : NlpposbilstmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmFrame::set(self : NlpposbilstmFrame, i : Int, v : Double) -> NlpposbilstmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmFrame::sum(self : NlpposbilstmFrame) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmFrame::mean(self : NlpposbilstmFrame) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmFrame::scale(self : NlpposbilstmFrame, f : Double) -> NlpposbilstmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmFrame::add(self : NlpposbilstmFrame, other : NlpposbilstmFrame) -> NlpposbilstmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmFrame::copy(self : NlpposbilstmFrame) -> NlpposbilstmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmFrame::fill(self : NlpposbilstmFrame, v : Double) -> NlpposbilstmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmFrame::min(self : NlpposbilstmFrame) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmFrame::max(self : NlpposbilstmFrame) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmFrame::to_string(self : NlpposbilstmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_table_make(size : Int) -> NlpposbilstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmTable::len(self : NlpposbilstmTable) -> Int { self.size }

pub fn NlpposbilstmTable::get(self : NlpposbilstmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmTable::set(self : NlpposbilstmTable, i : Int, v : Double) -> NlpposbilstmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmTable::sum(self : NlpposbilstmTable) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmTable::mean(self : NlpposbilstmTable) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmTable::scale(self : NlpposbilstmTable, f : Double) -> NlpposbilstmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmTable::add(self : NlpposbilstmTable, other : NlpposbilstmTable) -> NlpposbilstmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmTable::copy(self : NlpposbilstmTable) -> NlpposbilstmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmTable::fill(self : NlpposbilstmTable, v : Double) -> NlpposbilstmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmTable::min(self : NlpposbilstmTable) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmTable::max(self : NlpposbilstmTable) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmTable::to_string(self : NlpposbilstmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_graphn_make(size : Int) -> NlpposbilstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmGraphN::len(self : NlpposbilstmGraphN) -> Int { self.size }

pub fn NlpposbilstmGraphN::get(self : NlpposbilstmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmGraphN::set(self : NlpposbilstmGraphN, i : Int, v : Double) -> NlpposbilstmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmGraphN::sum(self : NlpposbilstmGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmGraphN::mean(self : NlpposbilstmGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmGraphN::scale(self : NlpposbilstmGraphN, f : Double) -> NlpposbilstmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmGraphN::add(self : NlpposbilstmGraphN, other : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmGraphN::copy(self : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmGraphN::fill(self : NlpposbilstmGraphN, v : Double) -> NlpposbilstmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmGraphN::min(self : NlpposbilstmGraphN) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmGraphN::max(self : NlpposbilstmGraphN) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmGraphN::to_string(self : NlpposbilstmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_node_make(size : Int) -> NlpposbilstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmNode::len(self : NlpposbilstmNode) -> Int { self.size }

pub fn NlpposbilstmNode::get(self : NlpposbilstmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmNode::set(self : NlpposbilstmNode, i : Int, v : Double) -> NlpposbilstmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmNode::sum(self : NlpposbilstmNode) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmNode::mean(self : NlpposbilstmNode) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmNode::scale(self : NlpposbilstmNode, f : Double) -> NlpposbilstmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmNode::add(self : NlpposbilstmNode, other : NlpposbilstmNode) -> NlpposbilstmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmNode::copy(self : NlpposbilstmNode) -> NlpposbilstmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmNode::fill(self : NlpposbilstmNode, v : Double) -> NlpposbilstmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmNode::min(self : NlpposbilstmNode) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmNode::max(self : NlpposbilstmNode) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmNode::to_string(self : NlpposbilstmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_edge_make(size : Int) -> NlpposbilstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmEdge::len(self : NlpposbilstmEdge) -> Int { self.size }

pub fn NlpposbilstmEdge::get(self : NlpposbilstmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmEdge::set(self : NlpposbilstmEdge, i : Int, v : Double) -> NlpposbilstmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmEdge::sum(self : NlpposbilstmEdge) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmEdge::mean(self : NlpposbilstmEdge) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmEdge::scale(self : NlpposbilstmEdge, f : Double) -> NlpposbilstmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmEdge::add(self : NlpposbilstmEdge, other : NlpposbilstmEdge) -> NlpposbilstmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmEdge::copy(self : NlpposbilstmEdge) -> NlpposbilstmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmEdge::fill(self : NlpposbilstmEdge, v : Double) -> NlpposbilstmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmEdge::min(self : NlpposbilstmEdge) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmEdge::max(self : NlpposbilstmEdge) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmEdge::to_string(self : NlpposbilstmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_path_make(size : Int) -> NlpposbilstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmPath::len(self : NlpposbilstmPath) -> Int { self.size }

pub fn NlpposbilstmPath::get(self : NlpposbilstmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmPath::set(self : NlpposbilstmPath, i : Int, v : Double) -> NlpposbilstmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmPath::sum(self : NlpposbilstmPath) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmPath::mean(self : NlpposbilstmPath) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmPath::scale(self : NlpposbilstmPath, f : Double) -> NlpposbilstmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmPath::add(self : NlpposbilstmPath, other : NlpposbilstmPath) -> NlpposbilstmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmPath::copy(self : NlpposbilstmPath) -> NlpposbilstmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmPath::fill(self : NlpposbilstmPath, v : Double) -> NlpposbilstmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmPath::min(self : NlpposbilstmPath) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmPath::max(self : NlpposbilstmPath) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmPath::to_string(self : NlpposbilstmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cluster_make(size : Int) -> NlpposbilstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmCluster::len(self : NlpposbilstmCluster) -> Int { self.size }

pub fn NlpposbilstmCluster::get(self : NlpposbilstmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmCluster::set(self : NlpposbilstmCluster, i : Int, v : Double) -> NlpposbilstmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCluster::sum(self : NlpposbilstmCluster) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmCluster::mean(self : NlpposbilstmCluster) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmCluster::scale(self : NlpposbilstmCluster, f : Double) -> NlpposbilstmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCluster::add(self : NlpposbilstmCluster, other : NlpposbilstmCluster) -> NlpposbilstmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmCluster::copy(self : NlpposbilstmCluster) -> NlpposbilstmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCluster::fill(self : NlpposbilstmCluster, v : Double) -> NlpposbilstmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCluster::min(self : NlpposbilstmCluster) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmCluster::max(self : NlpposbilstmCluster) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmCluster::to_string(self : NlpposbilstmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_model_make(size : Int) -> NlpposbilstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmModel::len(self : NlpposbilstmModel) -> Int { self.size }

pub fn NlpposbilstmModel::get(self : NlpposbilstmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmModel::set(self : NlpposbilstmModel, i : Int, v : Double) -> NlpposbilstmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmModel::sum(self : NlpposbilstmModel) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmModel::mean(self : NlpposbilstmModel) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmModel::scale(self : NlpposbilstmModel, f : Double) -> NlpposbilstmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmModel::add(self : NlpposbilstmModel, other : NlpposbilstmModel) -> NlpposbilstmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmModel::copy(self : NlpposbilstmModel) -> NlpposbilstmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmModel::fill(self : NlpposbilstmModel, v : Double) -> NlpposbilstmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmModel::min(self : NlpposbilstmModel) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmModel::max(self : NlpposbilstmModel) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmModel::to_string(self : NlpposbilstmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_layer_make(size : Int) -> NlpposbilstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmLayer::len(self : NlpposbilstmLayer) -> Int { self.size }

pub fn NlpposbilstmLayer::get(self : NlpposbilstmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmLayer::set(self : NlpposbilstmLayer, i : Int, v : Double) -> NlpposbilstmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmLayer::sum(self : NlpposbilstmLayer) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmLayer::mean(self : NlpposbilstmLayer) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmLayer::scale(self : NlpposbilstmLayer, f : Double) -> NlpposbilstmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmLayer::add(self : NlpposbilstmLayer, other : NlpposbilstmLayer) -> NlpposbilstmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmLayer::copy(self : NlpposbilstmLayer) -> NlpposbilstmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmLayer::fill(self : NlpposbilstmLayer, v : Double) -> NlpposbilstmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmLayer::min(self : NlpposbilstmLayer) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmLayer::max(self : NlpposbilstmLayer) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmLayer::to_string(self : NlpposbilstmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_buffer_make(size : Int) -> NlpposbilstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmBuffer::len(self : NlpposbilstmBuffer) -> Int { self.size }

pub fn NlpposbilstmBuffer::get(self : NlpposbilstmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmBuffer::set(self : NlpposbilstmBuffer, i : Int, v : Double) -> NlpposbilstmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmBuffer::sum(self : NlpposbilstmBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmBuffer::mean(self : NlpposbilstmBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmBuffer::scale(self : NlpposbilstmBuffer, f : Double) -> NlpposbilstmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmBuffer::add(self : NlpposbilstmBuffer, other : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmBuffer::copy(self : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmBuffer::fill(self : NlpposbilstmBuffer, v : Double) -> NlpposbilstmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmBuffer::min(self : NlpposbilstmBuffer) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmBuffer::max(self : NlpposbilstmBuffer) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmBuffer::to_string(self : NlpposbilstmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cursor_make(size : Int) -> NlpposbilstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmCursor::len(self : NlpposbilstmCursor) -> Int { self.size }

pub fn NlpposbilstmCursor::get(self : NlpposbilstmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmCursor::set(self : NlpposbilstmCursor, i : Int, v : Double) -> NlpposbilstmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCursor::sum(self : NlpposbilstmCursor) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmCursor::mean(self : NlpposbilstmCursor) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmCursor::scale(self : NlpposbilstmCursor, f : Double) -> NlpposbilstmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCursor::add(self : NlpposbilstmCursor, other : NlpposbilstmCursor) -> NlpposbilstmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmCursor::copy(self : NlpposbilstmCursor) -> NlpposbilstmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCursor::fill(self : NlpposbilstmCursor, v : Double) -> NlpposbilstmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmCursor::min(self : NlpposbilstmCursor) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmCursor::max(self : NlpposbilstmCursor) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmCursor::to_string(self : NlpposbilstmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_view_make(size : Int) -> NlpposbilstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmView::len(self : NlpposbilstmView) -> Int { self.size }

pub fn NlpposbilstmView::get(self : NlpposbilstmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmView::set(self : NlpposbilstmView, i : Int, v : Double) -> NlpposbilstmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmView::sum(self : NlpposbilstmView) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmView::mean(self : NlpposbilstmView) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmView::scale(self : NlpposbilstmView, f : Double) -> NlpposbilstmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmView::add(self : NlpposbilstmView, other : NlpposbilstmView) -> NlpposbilstmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmView::copy(self : NlpposbilstmView) -> NlpposbilstmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmView::fill(self : NlpposbilstmView, v : Double) -> NlpposbilstmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmView::min(self : NlpposbilstmView) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmView::max(self : NlpposbilstmView) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmView::to_string(self : NlpposbilstmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_range_make(size : Int) -> NlpposbilstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmRange::len(self : NlpposbilstmRange) -> Int { self.size }

pub fn NlpposbilstmRange::get(self : NlpposbilstmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmRange::set(self : NlpposbilstmRange, i : Int, v : Double) -> NlpposbilstmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmRange::sum(self : NlpposbilstmRange) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmRange::mean(self : NlpposbilstmRange) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmRange::scale(self : NlpposbilstmRange, f : Double) -> NlpposbilstmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmRange::add(self : NlpposbilstmRange, other : NlpposbilstmRange) -> NlpposbilstmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmRange::copy(self : NlpposbilstmRange) -> NlpposbilstmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmRange::fill(self : NlpposbilstmRange, v : Double) -> NlpposbilstmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmRange::min(self : NlpposbilstmRange) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmRange::max(self : NlpposbilstmRange) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmRange::to_string(self : NlpposbilstmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_slice_make(size : Int) -> NlpposbilstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbilstmSlice::len(self : NlpposbilstmSlice) -> Int { self.size }

pub fn NlpposbilstmSlice::get(self : NlpposbilstmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbilstmSlice::set(self : NlpposbilstmSlice, i : Int, v : Double) -> NlpposbilstmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbilstmSlice::sum(self : NlpposbilstmSlice) -> Double { @_common.sum(self.data) }

pub fn NlpposbilstmSlice::mean(self : NlpposbilstmSlice) -> Double { @_common.mean(self.data) }

pub fn NlpposbilstmSlice::scale(self : NlpposbilstmSlice, f : Double) -> NlpposbilstmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmSlice::add(self : NlpposbilstmSlice, other : NlpposbilstmSlice) -> NlpposbilstmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbilstmSlice::copy(self : NlpposbilstmSlice) -> NlpposbilstmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmSlice::fill(self : NlpposbilstmSlice, v : Double) -> NlpposbilstmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbilstmSlice::min(self : NlpposbilstmSlice) -> Double { @_common.min(self.data) }

pub fn NlpposbilstmSlice::max(self : NlpposbilstmSlice) -> Double { @_common.max(self.data) }

pub fn NlpposbilstmSlice::to_string(self : NlpposbilstmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

