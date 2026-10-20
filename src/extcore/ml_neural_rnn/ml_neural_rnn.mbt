///===
/// extcore/ml_neural_rnn

pub(all) struct MlneuralrnnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_rnn_make_point(x : Double, y : Double) -> MlneuralrnnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_rnn_make_point3(x : Double, y : Double, z : Double) -> MlneuralrnnPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralrnnPoint::x(self : MlneuralrnnPoint) -> Double { self.x }

pub fn MlneuralrnnPoint::y(self : MlneuralrnnPoint) -> Double { self.y }

pub fn MlneuralrnnPoint::z(self : MlneuralrnnPoint) -> Double { self.z }

pub fn MlneuralrnnPoint::label(self : MlneuralrnnPoint) -> Int { self.label }

pub fn MlneuralrnnPoint::dist(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralrnnPoint::add(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralrnnPoint::sub(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralrnnPoint::scale(self : MlneuralrnnPoint, s : Double) -> MlneuralrnnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralrnnPoint::dot(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralrnnPoint::cross(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralrnnPoint::norm(self : MlneuralrnnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralrnnPoint::normalize(self : MlneuralrnnPoint) -> MlneuralrnnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralrnnPoint::negate(self : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralrnnPoint::mid(self : MlneuralrnnPoint, other : MlneuralrnnPoint) -> MlneuralrnnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralrnnPoint::lerp(self : MlneuralrnnPoint, other : MlneuralrnnPoint, t : Double) -> MlneuralrnnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralrnnPoint::to_string(self : MlneuralrnnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralrnnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_rnn_make_series(vals : Array[Double], name : String) -> MlneuralrnnSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralrnnSeries::len(self : MlneuralrnnSeries) -> Int { self.vals.length() }

pub fn MlneuralrnnSeries::sum(self : MlneuralrnnSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralrnnSeries::mean(self : MlneuralrnnSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralrnnSeries::min(self : MlneuralrnnSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralrnnSeries::max(self : MlneuralrnnSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralrnnSeries::range(self : MlneuralrnnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralrnnSeries::variance(self : MlneuralrnnSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralrnnSeries::std(self : MlneuralrnnSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralrnnSeries::median(self : MlneuralrnnSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralrnnSeries::scale(self : MlneuralrnnSeries, f : Double) -> MlneuralrnnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralrnnSeries::add(self : MlneuralrnnSeries, other : MlneuralrnnSeries) -> MlneuralrnnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralrnnSeries::sub(self : MlneuralrnnSeries, other : MlneuralrnnSeries) -> MlneuralrnnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralrnnSeries::normalize(self : MlneuralrnnSeries) -> MlneuralrnnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralrnnSeries::cumsum(self : MlneuralrnnSeries) -> MlneuralrnnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralrnnSeries::to_string(self : MlneuralrnnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralrnnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_rnn_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralrnnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_rnn_matrix_identity(n : Int) -> MlneuralrnnMatrix {
  let m = ml_neural_rnn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralrnnMatrix::get(self : MlneuralrnnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralrnnMatrix::transpose(self : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  let result = ml_neural_rnn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralrnnMatrix::add(self : MlneuralrnnMatrix, other : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_rnn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralrnnMatrix::scale(self : MlneuralrnnMatrix, s : Double) -> MlneuralrnnMatrix {
  let result = ml_neural_rnn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralrnnMatrix::multiply(self : MlneuralrnnMatrix, other : MlneuralrnnMatrix) -> MlneuralrnnMatrix {
  if self.cols != other.rows { return ml_neural_rnn_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_rnn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralrnnMatrix::trace(self : MlneuralrnnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralrnnMatrix::det(self : MlneuralrnnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralrnnMatrix::norm(self : MlneuralrnnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralrnnMatrix::to_string(self : MlneuralrnnMatrix) -> String {
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

pub(all) struct MlneuralrnnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_rnn_make_vector(comps : Array[Double]) -> MlneuralrnnVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_rnn_vector_zero(dim : Int) -> MlneuralrnnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralrnnVector::add(self : MlneuralrnnVector, other : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralrnnVector::sub(self : MlneuralrnnVector, other : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralrnnVector::scale(self : MlneuralrnnVector, s : Double) -> MlneuralrnnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralrnnVector::dot(self : MlneuralrnnVector, other : MlneuralrnnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralrnnVector::norm(self : MlneuralrnnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralrnnVector::normalize(self : MlneuralrnnVector) -> MlneuralrnnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralrnnVector::dist(self : MlneuralrnnVector, other : MlneuralrnnVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralrnnVector::to_string(self : MlneuralrnnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_rnn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_rnn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_rnn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_rnn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_rnn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_rnn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_rnn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_rnn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_rnn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_rnn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_rnn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_rnn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_rnn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_rnn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_rnn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_rnn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_rnn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_rnn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_rnn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_rnn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_rnn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_rnn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_rnn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_rnn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_rnn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_rnn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_rnn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_rnn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_rnn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralrnnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_frame_make(size : Int) -> MlneuralrnnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_frame_len(s : MlneuralrnnFrame) -> Int { s.size }

pub fn ml_neural_rnn_frame_get(s : MlneuralrnnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_frame_set(s : MlneuralrnnFrame, i : Int, v : Double) -> MlneuralrnnFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_frame_sum(s : MlneuralrnnFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_frame_mean(s : MlneuralrnnFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_frame_scale(s : MlneuralrnnFrame, f : Double) -> MlneuralrnnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_frame_add(a : MlneuralrnnFrame, b : MlneuralrnnFrame) -> MlneuralrnnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_frame_copy(s : MlneuralrnnFrame) -> MlneuralrnnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_frame_fill(s : MlneuralrnnFrame, v : Double) -> MlneuralrnnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_frame_min(s : MlneuralrnnFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_frame_max(s : MlneuralrnnFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_frame_to_string(s : MlneuralrnnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_table_make(size : Int) -> MlneuralrnnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_table_len(s : MlneuralrnnTable) -> Int { s.size }

pub fn ml_neural_rnn_table_get(s : MlneuralrnnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_table_set(s : MlneuralrnnTable, i : Int, v : Double) -> MlneuralrnnTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_table_sum(s : MlneuralrnnTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_table_mean(s : MlneuralrnnTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_table_scale(s : MlneuralrnnTable, f : Double) -> MlneuralrnnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_table_add(a : MlneuralrnnTable, b : MlneuralrnnTable) -> MlneuralrnnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_table_copy(s : MlneuralrnnTable) -> MlneuralrnnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_table_fill(s : MlneuralrnnTable, v : Double) -> MlneuralrnnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_table_min(s : MlneuralrnnTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_table_max(s : MlneuralrnnTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_table_to_string(s : MlneuralrnnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_graphn_make(size : Int) -> MlneuralrnnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_graphn_len(s : MlneuralrnnGraphN) -> Int { s.size }

pub fn ml_neural_rnn_graphn_get(s : MlneuralrnnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_graphn_set(s : MlneuralrnnGraphN, i : Int, v : Double) -> MlneuralrnnGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_graphn_sum(s : MlneuralrnnGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_graphn_mean(s : MlneuralrnnGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_graphn_scale(s : MlneuralrnnGraphN, f : Double) -> MlneuralrnnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_graphn_add(a : MlneuralrnnGraphN, b : MlneuralrnnGraphN) -> MlneuralrnnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_graphn_copy(s : MlneuralrnnGraphN) -> MlneuralrnnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_graphn_fill(s : MlneuralrnnGraphN, v : Double) -> MlneuralrnnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_graphn_min(s : MlneuralrnnGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_graphn_max(s : MlneuralrnnGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_graphn_to_string(s : MlneuralrnnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_node_make(size : Int) -> MlneuralrnnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_node_len(s : MlneuralrnnNode) -> Int { s.size }

pub fn ml_neural_rnn_node_get(s : MlneuralrnnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_node_set(s : MlneuralrnnNode, i : Int, v : Double) -> MlneuralrnnNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_node_sum(s : MlneuralrnnNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_node_mean(s : MlneuralrnnNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_node_scale(s : MlneuralrnnNode, f : Double) -> MlneuralrnnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_node_add(a : MlneuralrnnNode, b : MlneuralrnnNode) -> MlneuralrnnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_node_copy(s : MlneuralrnnNode) -> MlneuralrnnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_node_fill(s : MlneuralrnnNode, v : Double) -> MlneuralrnnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_node_min(s : MlneuralrnnNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_node_max(s : MlneuralrnnNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_node_to_string(s : MlneuralrnnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_edge_make(size : Int) -> MlneuralrnnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_edge_len(s : MlneuralrnnEdge) -> Int { s.size }

pub fn ml_neural_rnn_edge_get(s : MlneuralrnnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_edge_set(s : MlneuralrnnEdge, i : Int, v : Double) -> MlneuralrnnEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_edge_sum(s : MlneuralrnnEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_edge_mean(s : MlneuralrnnEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_edge_scale(s : MlneuralrnnEdge, f : Double) -> MlneuralrnnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_edge_add(a : MlneuralrnnEdge, b : MlneuralrnnEdge) -> MlneuralrnnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_edge_copy(s : MlneuralrnnEdge) -> MlneuralrnnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_edge_fill(s : MlneuralrnnEdge, v : Double) -> MlneuralrnnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_edge_min(s : MlneuralrnnEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_edge_max(s : MlneuralrnnEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_edge_to_string(s : MlneuralrnnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_path_make(size : Int) -> MlneuralrnnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_path_len(s : MlneuralrnnPath) -> Int { s.size }

pub fn ml_neural_rnn_path_get(s : MlneuralrnnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_path_set(s : MlneuralrnnPath, i : Int, v : Double) -> MlneuralrnnPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_path_sum(s : MlneuralrnnPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_path_mean(s : MlneuralrnnPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_path_scale(s : MlneuralrnnPath, f : Double) -> MlneuralrnnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_path_add(a : MlneuralrnnPath, b : MlneuralrnnPath) -> MlneuralrnnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_path_copy(s : MlneuralrnnPath) -> MlneuralrnnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_path_fill(s : MlneuralrnnPath, v : Double) -> MlneuralrnnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_path_min(s : MlneuralrnnPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_path_max(s : MlneuralrnnPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_path_to_string(s : MlneuralrnnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_cluster_make(size : Int) -> MlneuralrnnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_cluster_len(s : MlneuralrnnCluster) -> Int { s.size }

pub fn ml_neural_rnn_cluster_get(s : MlneuralrnnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_cluster_set(s : MlneuralrnnCluster, i : Int, v : Double) -> MlneuralrnnCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cluster_sum(s : MlneuralrnnCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_cluster_mean(s : MlneuralrnnCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_cluster_scale(s : MlneuralrnnCluster, f : Double) -> MlneuralrnnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cluster_add(a : MlneuralrnnCluster, b : MlneuralrnnCluster) -> MlneuralrnnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_cluster_copy(s : MlneuralrnnCluster) -> MlneuralrnnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cluster_fill(s : MlneuralrnnCluster, v : Double) -> MlneuralrnnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cluster_min(s : MlneuralrnnCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_cluster_max(s : MlneuralrnnCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_cluster_to_string(s : MlneuralrnnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_model_make(size : Int) -> MlneuralrnnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_model_len(s : MlneuralrnnModel) -> Int { s.size }

pub fn ml_neural_rnn_model_get(s : MlneuralrnnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_model_set(s : MlneuralrnnModel, i : Int, v : Double) -> MlneuralrnnModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_model_sum(s : MlneuralrnnModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_model_mean(s : MlneuralrnnModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_model_scale(s : MlneuralrnnModel, f : Double) -> MlneuralrnnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_model_add(a : MlneuralrnnModel, b : MlneuralrnnModel) -> MlneuralrnnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_model_copy(s : MlneuralrnnModel) -> MlneuralrnnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_model_fill(s : MlneuralrnnModel, v : Double) -> MlneuralrnnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_model_min(s : MlneuralrnnModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_model_max(s : MlneuralrnnModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_model_to_string(s : MlneuralrnnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_layer_make(size : Int) -> MlneuralrnnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_layer_len(s : MlneuralrnnLayer) -> Int { s.size }

pub fn ml_neural_rnn_layer_get(s : MlneuralrnnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_layer_set(s : MlneuralrnnLayer, i : Int, v : Double) -> MlneuralrnnLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_layer_sum(s : MlneuralrnnLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_layer_mean(s : MlneuralrnnLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_layer_scale(s : MlneuralrnnLayer, f : Double) -> MlneuralrnnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_layer_add(a : MlneuralrnnLayer, b : MlneuralrnnLayer) -> MlneuralrnnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_layer_copy(s : MlneuralrnnLayer) -> MlneuralrnnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_layer_fill(s : MlneuralrnnLayer, v : Double) -> MlneuralrnnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_layer_min(s : MlneuralrnnLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_layer_max(s : MlneuralrnnLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_layer_to_string(s : MlneuralrnnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_buffer_make(size : Int) -> MlneuralrnnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_buffer_len(s : MlneuralrnnBuffer) -> Int { s.size }

pub fn ml_neural_rnn_buffer_get(s : MlneuralrnnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_buffer_set(s : MlneuralrnnBuffer, i : Int, v : Double) -> MlneuralrnnBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_buffer_sum(s : MlneuralrnnBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_buffer_mean(s : MlneuralrnnBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_buffer_scale(s : MlneuralrnnBuffer, f : Double) -> MlneuralrnnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_buffer_add(a : MlneuralrnnBuffer, b : MlneuralrnnBuffer) -> MlneuralrnnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_buffer_copy(s : MlneuralrnnBuffer) -> MlneuralrnnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_buffer_fill(s : MlneuralrnnBuffer, v : Double) -> MlneuralrnnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_buffer_min(s : MlneuralrnnBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_buffer_max(s : MlneuralrnnBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_buffer_to_string(s : MlneuralrnnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_cursor_make(size : Int) -> MlneuralrnnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_cursor_len(s : MlneuralrnnCursor) -> Int { s.size }

pub fn ml_neural_rnn_cursor_get(s : MlneuralrnnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_cursor_set(s : MlneuralrnnCursor, i : Int, v : Double) -> MlneuralrnnCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cursor_sum(s : MlneuralrnnCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_cursor_mean(s : MlneuralrnnCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_cursor_scale(s : MlneuralrnnCursor, f : Double) -> MlneuralrnnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cursor_add(a : MlneuralrnnCursor, b : MlneuralrnnCursor) -> MlneuralrnnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_cursor_copy(s : MlneuralrnnCursor) -> MlneuralrnnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cursor_fill(s : MlneuralrnnCursor, v : Double) -> MlneuralrnnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_cursor_min(s : MlneuralrnnCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_cursor_max(s : MlneuralrnnCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_cursor_to_string(s : MlneuralrnnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_view_make(size : Int) -> MlneuralrnnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_view_len(s : MlneuralrnnView) -> Int { s.size }

pub fn ml_neural_rnn_view_get(s : MlneuralrnnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_view_set(s : MlneuralrnnView, i : Int, v : Double) -> MlneuralrnnView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_view_sum(s : MlneuralrnnView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_view_mean(s : MlneuralrnnView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_view_scale(s : MlneuralrnnView, f : Double) -> MlneuralrnnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_view_add(a : MlneuralrnnView, b : MlneuralrnnView) -> MlneuralrnnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_view_copy(s : MlneuralrnnView) -> MlneuralrnnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_view_fill(s : MlneuralrnnView, v : Double) -> MlneuralrnnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_view_min(s : MlneuralrnnView) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_view_max(s : MlneuralrnnView) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_view_to_string(s : MlneuralrnnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_range_make(size : Int) -> MlneuralrnnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_range_len(s : MlneuralrnnRange) -> Int { s.size }

pub fn ml_neural_rnn_range_get(s : MlneuralrnnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_range_set(s : MlneuralrnnRange, i : Int, v : Double) -> MlneuralrnnRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_range_sum(s : MlneuralrnnRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_range_mean(s : MlneuralrnnRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_range_scale(s : MlneuralrnnRange, f : Double) -> MlneuralrnnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_range_add(a : MlneuralrnnRange, b : MlneuralrnnRange) -> MlneuralrnnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_range_copy(s : MlneuralrnnRange) -> MlneuralrnnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_range_fill(s : MlneuralrnnRange, v : Double) -> MlneuralrnnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_range_min(s : MlneuralrnnRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_range_max(s : MlneuralrnnRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_range_to_string(s : MlneuralrnnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralrnnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_rnn_slice_make(size : Int) -> MlneuralrnnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_rnn_slice_len(s : MlneuralrnnSlice) -> Int { s.size }

pub fn ml_neural_rnn_slice_get(s : MlneuralrnnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_rnn_slice_set(s : MlneuralrnnSlice, i : Int, v : Double) -> MlneuralrnnSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_slice_sum(s : MlneuralrnnSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_rnn_slice_mean(s : MlneuralrnnSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_rnn_slice_scale(s : MlneuralrnnSlice, f : Double) -> MlneuralrnnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_slice_add(a : MlneuralrnnSlice, b : MlneuralrnnSlice) -> MlneuralrnnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_rnn_slice_copy(s : MlneuralrnnSlice) -> MlneuralrnnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_slice_fill(s : MlneuralrnnSlice, v : Double) -> MlneuralrnnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_rnn_slice_min(s : MlneuralrnnSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_rnn_slice_max(s : MlneuralrnnSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_rnn_slice_to_string(s : MlneuralrnnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

