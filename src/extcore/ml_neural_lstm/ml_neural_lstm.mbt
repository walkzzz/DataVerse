///===
/// extcore/ml_neural_lstm

pub(all) struct MlneurallstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_lstm_make_point(x : Double, y : Double) -> MlneurallstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_lstm_make_point3(x : Double, y : Double, z : Double) -> MlneurallstmPoint {
  { x, y, z, label: 0 }
}

pub fn MlneurallstmPoint::x(self : MlneurallstmPoint) -> Double { self.x }

pub fn MlneurallstmPoint::y(self : MlneurallstmPoint) -> Double { self.y }

pub fn MlneurallstmPoint::z(self : MlneurallstmPoint) -> Double { self.z }

pub fn MlneurallstmPoint::label(self : MlneurallstmPoint) -> Int { self.label }

pub fn MlneurallstmPoint::dist(self : MlneurallstmPoint, other : MlneurallstmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneurallstmPoint::add(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneurallstmPoint::sub(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneurallstmPoint::scale(self : MlneurallstmPoint, s : Double) -> MlneurallstmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneurallstmPoint::dot(self : MlneurallstmPoint, other : MlneurallstmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneurallstmPoint::cross(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneurallstmPoint::norm(self : MlneurallstmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneurallstmPoint::normalize(self : MlneurallstmPoint) -> MlneurallstmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneurallstmPoint::negate(self : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneurallstmPoint::mid(self : MlneurallstmPoint, other : MlneurallstmPoint) -> MlneurallstmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneurallstmPoint::lerp(self : MlneurallstmPoint, other : MlneurallstmPoint, t : Double) -> MlneurallstmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneurallstmPoint::to_string(self : MlneurallstmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneurallstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_lstm_make_series(vals : Array[Double], name : String) -> MlneurallstmSeries {
  { vals, name, meta: 0 }
}

pub fn MlneurallstmSeries::len(self : MlneurallstmSeries) -> Int { self.vals.length() }

pub fn MlneurallstmSeries::sum(self : MlneurallstmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneurallstmSeries::mean(self : MlneurallstmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneurallstmSeries::min(self : MlneurallstmSeries) -> Double { @_common.min(self.vals) }

pub fn MlneurallstmSeries::max(self : MlneurallstmSeries) -> Double { @_common.max(self.vals) }

pub fn MlneurallstmSeries::range(self : MlneurallstmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneurallstmSeries::variance(self : MlneurallstmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneurallstmSeries::std(self : MlneurallstmSeries) -> Double { @_common.std(self.vals) }

pub fn MlneurallstmSeries::median(self : MlneurallstmSeries) -> Double { @_common.median(self.vals) }

pub fn MlneurallstmSeries::scale(self : MlneurallstmSeries, f : Double) -> MlneurallstmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneurallstmSeries::add(self : MlneurallstmSeries, other : MlneurallstmSeries) -> MlneurallstmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneurallstmSeries::sub(self : MlneurallstmSeries, other : MlneurallstmSeries) -> MlneurallstmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneurallstmSeries::normalize(self : MlneurallstmSeries) -> MlneurallstmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneurallstmSeries::cumsum(self : MlneurallstmSeries) -> MlneurallstmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneurallstmSeries::to_string(self : MlneurallstmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneurallstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_lstm_make_matrix(rows : Int, cols : Int, val : Double) -> MlneurallstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_lstm_matrix_identity(n : Int) -> MlneurallstmMatrix {
  let m = ml_neural_lstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneurallstmMatrix::get(self : MlneurallstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneurallstmMatrix::transpose(self : MlneurallstmMatrix) -> MlneurallstmMatrix {
  let result = ml_neural_lstm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneurallstmMatrix::add(self : MlneurallstmMatrix, other : MlneurallstmMatrix) -> MlneurallstmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneurallstmMatrix::scale(self : MlneurallstmMatrix, s : Double) -> MlneurallstmMatrix {
  let result = ml_neural_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneurallstmMatrix::multiply(self : MlneurallstmMatrix, other : MlneurallstmMatrix) -> MlneurallstmMatrix {
  if self.cols != other.rows { return ml_neural_lstm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_lstm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneurallstmMatrix::trace(self : MlneurallstmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneurallstmMatrix::det(self : MlneurallstmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneurallstmMatrix::norm(self : MlneurallstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneurallstmMatrix::to_string(self : MlneurallstmMatrix) -> String {
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

pub(all) struct MlneurallstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_lstm_make_vector(comps : Array[Double]) -> MlneurallstmVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_lstm_vector_zero(dim : Int) -> MlneurallstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneurallstmVector::add(self : MlneurallstmVector, other : MlneurallstmVector) -> MlneurallstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneurallstmVector::sub(self : MlneurallstmVector, other : MlneurallstmVector) -> MlneurallstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneurallstmVector::scale(self : MlneurallstmVector, s : Double) -> MlneurallstmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneurallstmVector::dot(self : MlneurallstmVector, other : MlneurallstmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneurallstmVector::norm(self : MlneurallstmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneurallstmVector::normalize(self : MlneurallstmVector) -> MlneurallstmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneurallstmVector::dist(self : MlneurallstmVector, other : MlneurallstmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneurallstmVector::to_string(self : MlneurallstmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_lstm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_lstm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_lstm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_lstm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_lstm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_lstm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_lstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_lstm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_lstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_lstm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_lstm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_lstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_lstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_lstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_lstm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_lstm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_lstm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_lstm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_lstm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_lstm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_lstm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_lstm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_lstm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_lstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_lstm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_lstm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_lstm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_lstm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_lstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneurallstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_frame_make(size : Int) -> MlneurallstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_frame_len(s : MlneurallstmFrame) -> Int { s.size }

pub fn ml_neural_lstm_frame_get(s : MlneurallstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_frame_set(s : MlneurallstmFrame, i : Int, v : Double) -> MlneurallstmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_frame_sum(s : MlneurallstmFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_frame_mean(s : MlneurallstmFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_frame_scale(s : MlneurallstmFrame, f : Double) -> MlneurallstmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_frame_add(a : MlneurallstmFrame, b : MlneurallstmFrame) -> MlneurallstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_frame_copy(s : MlneurallstmFrame) -> MlneurallstmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_frame_fill(s : MlneurallstmFrame, v : Double) -> MlneurallstmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_frame_min(s : MlneurallstmFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_frame_max(s : MlneurallstmFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_frame_to_string(s : MlneurallstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_table_make(size : Int) -> MlneurallstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_table_len(s : MlneurallstmTable) -> Int { s.size }

pub fn ml_neural_lstm_table_get(s : MlneurallstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_table_set(s : MlneurallstmTable, i : Int, v : Double) -> MlneurallstmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_table_sum(s : MlneurallstmTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_table_mean(s : MlneurallstmTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_table_scale(s : MlneurallstmTable, f : Double) -> MlneurallstmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_table_add(a : MlneurallstmTable, b : MlneurallstmTable) -> MlneurallstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_table_copy(s : MlneurallstmTable) -> MlneurallstmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_table_fill(s : MlneurallstmTable, v : Double) -> MlneurallstmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_table_min(s : MlneurallstmTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_table_max(s : MlneurallstmTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_table_to_string(s : MlneurallstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_graphn_make(size : Int) -> MlneurallstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_graphn_len(s : MlneurallstmGraphN) -> Int { s.size }

pub fn ml_neural_lstm_graphn_get(s : MlneurallstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_graphn_set(s : MlneurallstmGraphN, i : Int, v : Double) -> MlneurallstmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_graphn_sum(s : MlneurallstmGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_graphn_mean(s : MlneurallstmGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_graphn_scale(s : MlneurallstmGraphN, f : Double) -> MlneurallstmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_graphn_add(a : MlneurallstmGraphN, b : MlneurallstmGraphN) -> MlneurallstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_graphn_copy(s : MlneurallstmGraphN) -> MlneurallstmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_graphn_fill(s : MlneurallstmGraphN, v : Double) -> MlneurallstmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_graphn_min(s : MlneurallstmGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_graphn_max(s : MlneurallstmGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_graphn_to_string(s : MlneurallstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_node_make(size : Int) -> MlneurallstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_node_len(s : MlneurallstmNode) -> Int { s.size }

pub fn ml_neural_lstm_node_get(s : MlneurallstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_node_set(s : MlneurallstmNode, i : Int, v : Double) -> MlneurallstmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_node_sum(s : MlneurallstmNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_node_mean(s : MlneurallstmNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_node_scale(s : MlneurallstmNode, f : Double) -> MlneurallstmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_node_add(a : MlneurallstmNode, b : MlneurallstmNode) -> MlneurallstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_node_copy(s : MlneurallstmNode) -> MlneurallstmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_node_fill(s : MlneurallstmNode, v : Double) -> MlneurallstmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_node_min(s : MlneurallstmNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_node_max(s : MlneurallstmNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_node_to_string(s : MlneurallstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_edge_make(size : Int) -> MlneurallstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_edge_len(s : MlneurallstmEdge) -> Int { s.size }

pub fn ml_neural_lstm_edge_get(s : MlneurallstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_edge_set(s : MlneurallstmEdge, i : Int, v : Double) -> MlneurallstmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_edge_sum(s : MlneurallstmEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_edge_mean(s : MlneurallstmEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_edge_scale(s : MlneurallstmEdge, f : Double) -> MlneurallstmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_edge_add(a : MlneurallstmEdge, b : MlneurallstmEdge) -> MlneurallstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_edge_copy(s : MlneurallstmEdge) -> MlneurallstmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_edge_fill(s : MlneurallstmEdge, v : Double) -> MlneurallstmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_edge_min(s : MlneurallstmEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_edge_max(s : MlneurallstmEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_edge_to_string(s : MlneurallstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_path_make(size : Int) -> MlneurallstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_path_len(s : MlneurallstmPath) -> Int { s.size }

pub fn ml_neural_lstm_path_get(s : MlneurallstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_path_set(s : MlneurallstmPath, i : Int, v : Double) -> MlneurallstmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_path_sum(s : MlneurallstmPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_path_mean(s : MlneurallstmPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_path_scale(s : MlneurallstmPath, f : Double) -> MlneurallstmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_path_add(a : MlneurallstmPath, b : MlneurallstmPath) -> MlneurallstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_path_copy(s : MlneurallstmPath) -> MlneurallstmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_path_fill(s : MlneurallstmPath, v : Double) -> MlneurallstmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_path_min(s : MlneurallstmPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_path_max(s : MlneurallstmPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_path_to_string(s : MlneurallstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_cluster_make(size : Int) -> MlneurallstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_cluster_len(s : MlneurallstmCluster) -> Int { s.size }

pub fn ml_neural_lstm_cluster_get(s : MlneurallstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_cluster_set(s : MlneurallstmCluster, i : Int, v : Double) -> MlneurallstmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cluster_sum(s : MlneurallstmCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_cluster_mean(s : MlneurallstmCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_cluster_scale(s : MlneurallstmCluster, f : Double) -> MlneurallstmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cluster_add(a : MlneurallstmCluster, b : MlneurallstmCluster) -> MlneurallstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_cluster_copy(s : MlneurallstmCluster) -> MlneurallstmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cluster_fill(s : MlneurallstmCluster, v : Double) -> MlneurallstmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cluster_min(s : MlneurallstmCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_cluster_max(s : MlneurallstmCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_cluster_to_string(s : MlneurallstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_model_make(size : Int) -> MlneurallstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_model_len(s : MlneurallstmModel) -> Int { s.size }

pub fn ml_neural_lstm_model_get(s : MlneurallstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_model_set(s : MlneurallstmModel, i : Int, v : Double) -> MlneurallstmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_model_sum(s : MlneurallstmModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_model_mean(s : MlneurallstmModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_model_scale(s : MlneurallstmModel, f : Double) -> MlneurallstmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_model_add(a : MlneurallstmModel, b : MlneurallstmModel) -> MlneurallstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_model_copy(s : MlneurallstmModel) -> MlneurallstmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_model_fill(s : MlneurallstmModel, v : Double) -> MlneurallstmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_model_min(s : MlneurallstmModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_model_max(s : MlneurallstmModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_model_to_string(s : MlneurallstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_layer_make(size : Int) -> MlneurallstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_layer_len(s : MlneurallstmLayer) -> Int { s.size }

pub fn ml_neural_lstm_layer_get(s : MlneurallstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_layer_set(s : MlneurallstmLayer, i : Int, v : Double) -> MlneurallstmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_layer_sum(s : MlneurallstmLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_layer_mean(s : MlneurallstmLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_layer_scale(s : MlneurallstmLayer, f : Double) -> MlneurallstmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_layer_add(a : MlneurallstmLayer, b : MlneurallstmLayer) -> MlneurallstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_layer_copy(s : MlneurallstmLayer) -> MlneurallstmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_layer_fill(s : MlneurallstmLayer, v : Double) -> MlneurallstmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_layer_min(s : MlneurallstmLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_layer_max(s : MlneurallstmLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_layer_to_string(s : MlneurallstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_buffer_make(size : Int) -> MlneurallstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_buffer_len(s : MlneurallstmBuffer) -> Int { s.size }

pub fn ml_neural_lstm_buffer_get(s : MlneurallstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_buffer_set(s : MlneurallstmBuffer, i : Int, v : Double) -> MlneurallstmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_buffer_sum(s : MlneurallstmBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_buffer_mean(s : MlneurallstmBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_buffer_scale(s : MlneurallstmBuffer, f : Double) -> MlneurallstmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_buffer_add(a : MlneurallstmBuffer, b : MlneurallstmBuffer) -> MlneurallstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_buffer_copy(s : MlneurallstmBuffer) -> MlneurallstmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_buffer_fill(s : MlneurallstmBuffer, v : Double) -> MlneurallstmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_buffer_min(s : MlneurallstmBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_buffer_max(s : MlneurallstmBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_buffer_to_string(s : MlneurallstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_cursor_make(size : Int) -> MlneurallstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_cursor_len(s : MlneurallstmCursor) -> Int { s.size }

pub fn ml_neural_lstm_cursor_get(s : MlneurallstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_cursor_set(s : MlneurallstmCursor, i : Int, v : Double) -> MlneurallstmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cursor_sum(s : MlneurallstmCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_cursor_mean(s : MlneurallstmCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_cursor_scale(s : MlneurallstmCursor, f : Double) -> MlneurallstmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cursor_add(a : MlneurallstmCursor, b : MlneurallstmCursor) -> MlneurallstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_cursor_copy(s : MlneurallstmCursor) -> MlneurallstmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cursor_fill(s : MlneurallstmCursor, v : Double) -> MlneurallstmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_cursor_min(s : MlneurallstmCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_cursor_max(s : MlneurallstmCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_cursor_to_string(s : MlneurallstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_view_make(size : Int) -> MlneurallstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_view_len(s : MlneurallstmView) -> Int { s.size }

pub fn ml_neural_lstm_view_get(s : MlneurallstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_view_set(s : MlneurallstmView, i : Int, v : Double) -> MlneurallstmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_view_sum(s : MlneurallstmView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_view_mean(s : MlneurallstmView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_view_scale(s : MlneurallstmView, f : Double) -> MlneurallstmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_view_add(a : MlneurallstmView, b : MlneurallstmView) -> MlneurallstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_view_copy(s : MlneurallstmView) -> MlneurallstmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_view_fill(s : MlneurallstmView, v : Double) -> MlneurallstmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_view_min(s : MlneurallstmView) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_view_max(s : MlneurallstmView) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_view_to_string(s : MlneurallstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_range_make(size : Int) -> MlneurallstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_range_len(s : MlneurallstmRange) -> Int { s.size }

pub fn ml_neural_lstm_range_get(s : MlneurallstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_range_set(s : MlneurallstmRange, i : Int, v : Double) -> MlneurallstmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_range_sum(s : MlneurallstmRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_range_mean(s : MlneurallstmRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_range_scale(s : MlneurallstmRange, f : Double) -> MlneurallstmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_range_add(a : MlneurallstmRange, b : MlneurallstmRange) -> MlneurallstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_range_copy(s : MlneurallstmRange) -> MlneurallstmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_range_fill(s : MlneurallstmRange, v : Double) -> MlneurallstmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_range_min(s : MlneurallstmRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_range_max(s : MlneurallstmRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_range_to_string(s : MlneurallstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneurallstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_lstm_slice_make(size : Int) -> MlneurallstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_lstm_slice_len(s : MlneurallstmSlice) -> Int { s.size }

pub fn ml_neural_lstm_slice_get(s : MlneurallstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_lstm_slice_set(s : MlneurallstmSlice, i : Int, v : Double) -> MlneurallstmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_slice_sum(s : MlneurallstmSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_lstm_slice_mean(s : MlneurallstmSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_lstm_slice_scale(s : MlneurallstmSlice, f : Double) -> MlneurallstmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_slice_add(a : MlneurallstmSlice, b : MlneurallstmSlice) -> MlneurallstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_lstm_slice_copy(s : MlneurallstmSlice) -> MlneurallstmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_slice_fill(s : MlneurallstmSlice, v : Double) -> MlneurallstmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_lstm_slice_min(s : MlneurallstmSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_lstm_slice_max(s : MlneurallstmSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_lstm_slice_to_string(s : MlneurallstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

