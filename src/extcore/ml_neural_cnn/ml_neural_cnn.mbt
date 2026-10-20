///===
/// extcore/ml_neural_cnn

pub(all) struct MlneuralcnnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_cnn_make_point(x : Double, y : Double) -> MlneuralcnnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_cnn_make_point3(x : Double, y : Double, z : Double) -> MlneuralcnnPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralcnnPoint::x(self : MlneuralcnnPoint) -> Double { self.x }

pub fn MlneuralcnnPoint::y(self : MlneuralcnnPoint) -> Double { self.y }

pub fn MlneuralcnnPoint::z(self : MlneuralcnnPoint) -> Double { self.z }

pub fn MlneuralcnnPoint::label(self : MlneuralcnnPoint) -> Int { self.label }

pub fn MlneuralcnnPoint::dist(self : MlneuralcnnPoint, other : MlneuralcnnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralcnnPoint::add(self : MlneuralcnnPoint, other : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralcnnPoint::sub(self : MlneuralcnnPoint, other : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralcnnPoint::scale(self : MlneuralcnnPoint, s : Double) -> MlneuralcnnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralcnnPoint::dot(self : MlneuralcnnPoint, other : MlneuralcnnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralcnnPoint::cross(self : MlneuralcnnPoint, other : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralcnnPoint::norm(self : MlneuralcnnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralcnnPoint::normalize(self : MlneuralcnnPoint) -> MlneuralcnnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralcnnPoint::negate(self : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralcnnPoint::mid(self : MlneuralcnnPoint, other : MlneuralcnnPoint) -> MlneuralcnnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralcnnPoint::lerp(self : MlneuralcnnPoint, other : MlneuralcnnPoint, t : Double) -> MlneuralcnnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralcnnPoint::to_string(self : MlneuralcnnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralcnnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_cnn_make_series(vals : Array[Double], name : String) -> MlneuralcnnSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralcnnSeries::len(self : MlneuralcnnSeries) -> Int { self.vals.length() }

pub fn MlneuralcnnSeries::sum(self : MlneuralcnnSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralcnnSeries::mean(self : MlneuralcnnSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralcnnSeries::min(self : MlneuralcnnSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralcnnSeries::max(self : MlneuralcnnSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralcnnSeries::range(self : MlneuralcnnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralcnnSeries::variance(self : MlneuralcnnSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralcnnSeries::std(self : MlneuralcnnSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralcnnSeries::median(self : MlneuralcnnSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralcnnSeries::scale(self : MlneuralcnnSeries, f : Double) -> MlneuralcnnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralcnnSeries::add(self : MlneuralcnnSeries, other : MlneuralcnnSeries) -> MlneuralcnnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralcnnSeries::sub(self : MlneuralcnnSeries, other : MlneuralcnnSeries) -> MlneuralcnnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralcnnSeries::normalize(self : MlneuralcnnSeries) -> MlneuralcnnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralcnnSeries::cumsum(self : MlneuralcnnSeries) -> MlneuralcnnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralcnnSeries::to_string(self : MlneuralcnnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralcnnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_cnn_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralcnnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_cnn_matrix_identity(n : Int) -> MlneuralcnnMatrix {
  let m = ml_neural_cnn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralcnnMatrix::get(self : MlneuralcnnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralcnnMatrix::transpose(self : MlneuralcnnMatrix) -> MlneuralcnnMatrix {
  let result = ml_neural_cnn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralcnnMatrix::add(self : MlneuralcnnMatrix, other : MlneuralcnnMatrix) -> MlneuralcnnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_cnn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralcnnMatrix::scale(self : MlneuralcnnMatrix, s : Double) -> MlneuralcnnMatrix {
  let result = ml_neural_cnn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralcnnMatrix::multiply(self : MlneuralcnnMatrix, other : MlneuralcnnMatrix) -> MlneuralcnnMatrix {
  if self.cols != other.rows { return ml_neural_cnn_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_cnn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralcnnMatrix::trace(self : MlneuralcnnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralcnnMatrix::det(self : MlneuralcnnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralcnnMatrix::norm(self : MlneuralcnnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralcnnMatrix::to_string(self : MlneuralcnnMatrix) -> String {
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

pub(all) struct MlneuralcnnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_cnn_make_vector(comps : Array[Double]) -> MlneuralcnnVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_cnn_vector_zero(dim : Int) -> MlneuralcnnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralcnnVector::add(self : MlneuralcnnVector, other : MlneuralcnnVector) -> MlneuralcnnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralcnnVector::sub(self : MlneuralcnnVector, other : MlneuralcnnVector) -> MlneuralcnnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralcnnVector::scale(self : MlneuralcnnVector, s : Double) -> MlneuralcnnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralcnnVector::dot(self : MlneuralcnnVector, other : MlneuralcnnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralcnnVector::norm(self : MlneuralcnnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralcnnVector::normalize(self : MlneuralcnnVector) -> MlneuralcnnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralcnnVector::dist(self : MlneuralcnnVector, other : MlneuralcnnVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralcnnVector::to_string(self : MlneuralcnnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_cnn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_cnn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_cnn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_cnn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_cnn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_cnn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_cnn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_cnn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_cnn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_cnn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_cnn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_cnn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_cnn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_cnn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_cnn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_cnn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_cnn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_cnn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_cnn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_cnn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_cnn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_cnn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_cnn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_cnn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_cnn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_cnn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_cnn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_cnn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_cnn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralcnnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_frame_make(size : Int) -> MlneuralcnnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_frame_len(s : MlneuralcnnFrame) -> Int { s.size }

pub fn ml_neural_cnn_frame_get(s : MlneuralcnnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_frame_set(s : MlneuralcnnFrame, i : Int, v : Double) -> MlneuralcnnFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_frame_sum(s : MlneuralcnnFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_frame_mean(s : MlneuralcnnFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_frame_scale(s : MlneuralcnnFrame, f : Double) -> MlneuralcnnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_frame_add(a : MlneuralcnnFrame, b : MlneuralcnnFrame) -> MlneuralcnnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_frame_copy(s : MlneuralcnnFrame) -> MlneuralcnnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_frame_fill(s : MlneuralcnnFrame, v : Double) -> MlneuralcnnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_frame_min(s : MlneuralcnnFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_frame_max(s : MlneuralcnnFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_frame_to_string(s : MlneuralcnnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_table_make(size : Int) -> MlneuralcnnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_table_len(s : MlneuralcnnTable) -> Int { s.size }

pub fn ml_neural_cnn_table_get(s : MlneuralcnnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_table_set(s : MlneuralcnnTable, i : Int, v : Double) -> MlneuralcnnTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_table_sum(s : MlneuralcnnTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_table_mean(s : MlneuralcnnTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_table_scale(s : MlneuralcnnTable, f : Double) -> MlneuralcnnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_table_add(a : MlneuralcnnTable, b : MlneuralcnnTable) -> MlneuralcnnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_table_copy(s : MlneuralcnnTable) -> MlneuralcnnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_table_fill(s : MlneuralcnnTable, v : Double) -> MlneuralcnnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_table_min(s : MlneuralcnnTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_table_max(s : MlneuralcnnTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_table_to_string(s : MlneuralcnnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_graphn_make(size : Int) -> MlneuralcnnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_graphn_len(s : MlneuralcnnGraphN) -> Int { s.size }

pub fn ml_neural_cnn_graphn_get(s : MlneuralcnnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_graphn_set(s : MlneuralcnnGraphN, i : Int, v : Double) -> MlneuralcnnGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_graphn_sum(s : MlneuralcnnGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_graphn_mean(s : MlneuralcnnGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_graphn_scale(s : MlneuralcnnGraphN, f : Double) -> MlneuralcnnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_graphn_add(a : MlneuralcnnGraphN, b : MlneuralcnnGraphN) -> MlneuralcnnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_graphn_copy(s : MlneuralcnnGraphN) -> MlneuralcnnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_graphn_fill(s : MlneuralcnnGraphN, v : Double) -> MlneuralcnnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_graphn_min(s : MlneuralcnnGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_graphn_max(s : MlneuralcnnGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_graphn_to_string(s : MlneuralcnnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_node_make(size : Int) -> MlneuralcnnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_node_len(s : MlneuralcnnNode) -> Int { s.size }

pub fn ml_neural_cnn_node_get(s : MlneuralcnnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_node_set(s : MlneuralcnnNode, i : Int, v : Double) -> MlneuralcnnNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_node_sum(s : MlneuralcnnNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_node_mean(s : MlneuralcnnNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_node_scale(s : MlneuralcnnNode, f : Double) -> MlneuralcnnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_node_add(a : MlneuralcnnNode, b : MlneuralcnnNode) -> MlneuralcnnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_node_copy(s : MlneuralcnnNode) -> MlneuralcnnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_node_fill(s : MlneuralcnnNode, v : Double) -> MlneuralcnnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_node_min(s : MlneuralcnnNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_node_max(s : MlneuralcnnNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_node_to_string(s : MlneuralcnnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_edge_make(size : Int) -> MlneuralcnnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_edge_len(s : MlneuralcnnEdge) -> Int { s.size }

pub fn ml_neural_cnn_edge_get(s : MlneuralcnnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_edge_set(s : MlneuralcnnEdge, i : Int, v : Double) -> MlneuralcnnEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_edge_sum(s : MlneuralcnnEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_edge_mean(s : MlneuralcnnEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_edge_scale(s : MlneuralcnnEdge, f : Double) -> MlneuralcnnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_edge_add(a : MlneuralcnnEdge, b : MlneuralcnnEdge) -> MlneuralcnnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_edge_copy(s : MlneuralcnnEdge) -> MlneuralcnnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_edge_fill(s : MlneuralcnnEdge, v : Double) -> MlneuralcnnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_edge_min(s : MlneuralcnnEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_edge_max(s : MlneuralcnnEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_edge_to_string(s : MlneuralcnnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_path_make(size : Int) -> MlneuralcnnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_path_len(s : MlneuralcnnPath) -> Int { s.size }

pub fn ml_neural_cnn_path_get(s : MlneuralcnnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_path_set(s : MlneuralcnnPath, i : Int, v : Double) -> MlneuralcnnPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_path_sum(s : MlneuralcnnPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_path_mean(s : MlneuralcnnPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_path_scale(s : MlneuralcnnPath, f : Double) -> MlneuralcnnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_path_add(a : MlneuralcnnPath, b : MlneuralcnnPath) -> MlneuralcnnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_path_copy(s : MlneuralcnnPath) -> MlneuralcnnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_path_fill(s : MlneuralcnnPath, v : Double) -> MlneuralcnnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_path_min(s : MlneuralcnnPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_path_max(s : MlneuralcnnPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_path_to_string(s : MlneuralcnnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_cluster_make(size : Int) -> MlneuralcnnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_cluster_len(s : MlneuralcnnCluster) -> Int { s.size }

pub fn ml_neural_cnn_cluster_get(s : MlneuralcnnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_cluster_set(s : MlneuralcnnCluster, i : Int, v : Double) -> MlneuralcnnCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cluster_sum(s : MlneuralcnnCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_cluster_mean(s : MlneuralcnnCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_cluster_scale(s : MlneuralcnnCluster, f : Double) -> MlneuralcnnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cluster_add(a : MlneuralcnnCluster, b : MlneuralcnnCluster) -> MlneuralcnnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_cluster_copy(s : MlneuralcnnCluster) -> MlneuralcnnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cluster_fill(s : MlneuralcnnCluster, v : Double) -> MlneuralcnnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cluster_min(s : MlneuralcnnCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_cluster_max(s : MlneuralcnnCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_cluster_to_string(s : MlneuralcnnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_model_make(size : Int) -> MlneuralcnnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_model_len(s : MlneuralcnnModel) -> Int { s.size }

pub fn ml_neural_cnn_model_get(s : MlneuralcnnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_model_set(s : MlneuralcnnModel, i : Int, v : Double) -> MlneuralcnnModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_model_sum(s : MlneuralcnnModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_model_mean(s : MlneuralcnnModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_model_scale(s : MlneuralcnnModel, f : Double) -> MlneuralcnnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_model_add(a : MlneuralcnnModel, b : MlneuralcnnModel) -> MlneuralcnnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_model_copy(s : MlneuralcnnModel) -> MlneuralcnnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_model_fill(s : MlneuralcnnModel, v : Double) -> MlneuralcnnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_model_min(s : MlneuralcnnModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_model_max(s : MlneuralcnnModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_model_to_string(s : MlneuralcnnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_layer_make(size : Int) -> MlneuralcnnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_layer_len(s : MlneuralcnnLayer) -> Int { s.size }

pub fn ml_neural_cnn_layer_get(s : MlneuralcnnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_layer_set(s : MlneuralcnnLayer, i : Int, v : Double) -> MlneuralcnnLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_layer_sum(s : MlneuralcnnLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_layer_mean(s : MlneuralcnnLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_layer_scale(s : MlneuralcnnLayer, f : Double) -> MlneuralcnnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_layer_add(a : MlneuralcnnLayer, b : MlneuralcnnLayer) -> MlneuralcnnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_layer_copy(s : MlneuralcnnLayer) -> MlneuralcnnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_layer_fill(s : MlneuralcnnLayer, v : Double) -> MlneuralcnnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_layer_min(s : MlneuralcnnLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_layer_max(s : MlneuralcnnLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_layer_to_string(s : MlneuralcnnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_buffer_make(size : Int) -> MlneuralcnnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_buffer_len(s : MlneuralcnnBuffer) -> Int { s.size }

pub fn ml_neural_cnn_buffer_get(s : MlneuralcnnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_buffer_set(s : MlneuralcnnBuffer, i : Int, v : Double) -> MlneuralcnnBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_buffer_sum(s : MlneuralcnnBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_buffer_mean(s : MlneuralcnnBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_buffer_scale(s : MlneuralcnnBuffer, f : Double) -> MlneuralcnnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_buffer_add(a : MlneuralcnnBuffer, b : MlneuralcnnBuffer) -> MlneuralcnnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_buffer_copy(s : MlneuralcnnBuffer) -> MlneuralcnnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_buffer_fill(s : MlneuralcnnBuffer, v : Double) -> MlneuralcnnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_buffer_min(s : MlneuralcnnBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_buffer_max(s : MlneuralcnnBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_buffer_to_string(s : MlneuralcnnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_cursor_make(size : Int) -> MlneuralcnnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_cursor_len(s : MlneuralcnnCursor) -> Int { s.size }

pub fn ml_neural_cnn_cursor_get(s : MlneuralcnnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_cursor_set(s : MlneuralcnnCursor, i : Int, v : Double) -> MlneuralcnnCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cursor_sum(s : MlneuralcnnCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_cursor_mean(s : MlneuralcnnCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_cursor_scale(s : MlneuralcnnCursor, f : Double) -> MlneuralcnnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cursor_add(a : MlneuralcnnCursor, b : MlneuralcnnCursor) -> MlneuralcnnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_cursor_copy(s : MlneuralcnnCursor) -> MlneuralcnnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cursor_fill(s : MlneuralcnnCursor, v : Double) -> MlneuralcnnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_cursor_min(s : MlneuralcnnCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_cursor_max(s : MlneuralcnnCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_cursor_to_string(s : MlneuralcnnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_view_make(size : Int) -> MlneuralcnnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_view_len(s : MlneuralcnnView) -> Int { s.size }

pub fn ml_neural_cnn_view_get(s : MlneuralcnnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_view_set(s : MlneuralcnnView, i : Int, v : Double) -> MlneuralcnnView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_view_sum(s : MlneuralcnnView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_view_mean(s : MlneuralcnnView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_view_scale(s : MlneuralcnnView, f : Double) -> MlneuralcnnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_view_add(a : MlneuralcnnView, b : MlneuralcnnView) -> MlneuralcnnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_view_copy(s : MlneuralcnnView) -> MlneuralcnnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_view_fill(s : MlneuralcnnView, v : Double) -> MlneuralcnnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_view_min(s : MlneuralcnnView) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_view_max(s : MlneuralcnnView) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_view_to_string(s : MlneuralcnnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_range_make(size : Int) -> MlneuralcnnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_range_len(s : MlneuralcnnRange) -> Int { s.size }

pub fn ml_neural_cnn_range_get(s : MlneuralcnnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_range_set(s : MlneuralcnnRange, i : Int, v : Double) -> MlneuralcnnRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_range_sum(s : MlneuralcnnRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_range_mean(s : MlneuralcnnRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_range_scale(s : MlneuralcnnRange, f : Double) -> MlneuralcnnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_range_add(a : MlneuralcnnRange, b : MlneuralcnnRange) -> MlneuralcnnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_range_copy(s : MlneuralcnnRange) -> MlneuralcnnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_range_fill(s : MlneuralcnnRange, v : Double) -> MlneuralcnnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_range_min(s : MlneuralcnnRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_range_max(s : MlneuralcnnRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_range_to_string(s : MlneuralcnnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_slice_make(size : Int) -> MlneuralcnnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_cnn_slice_len(s : MlneuralcnnSlice) -> Int { s.size }

pub fn ml_neural_cnn_slice_get(s : MlneuralcnnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_cnn_slice_set(s : MlneuralcnnSlice, i : Int, v : Double) -> MlneuralcnnSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_slice_sum(s : MlneuralcnnSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_cnn_slice_mean(s : MlneuralcnnSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_cnn_slice_scale(s : MlneuralcnnSlice, f : Double) -> MlneuralcnnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_slice_add(a : MlneuralcnnSlice, b : MlneuralcnnSlice) -> MlneuralcnnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_cnn_slice_copy(s : MlneuralcnnSlice) -> MlneuralcnnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_slice_fill(s : MlneuralcnnSlice, v : Double) -> MlneuralcnnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_cnn_slice_min(s : MlneuralcnnSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_cnn_slice_max(s : MlneuralcnnSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_cnn_slice_to_string(s : MlneuralcnnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

