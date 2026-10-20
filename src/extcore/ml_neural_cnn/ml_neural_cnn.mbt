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

pub fn MlneuralcnnFrame::len(self : MlneuralcnnFrame) -> Int { self.size }

pub fn MlneuralcnnFrame::get(self : MlneuralcnnFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnFrame::set(self : MlneuralcnnFrame, i : Int, v : Double) -> MlneuralcnnFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnFrame::sum(self : MlneuralcnnFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnFrame::mean(self : MlneuralcnnFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnFrame::scale(self : MlneuralcnnFrame, f : Double) -> MlneuralcnnFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnFrame::add(self : MlneuralcnnFrame, other : MlneuralcnnFrame) -> MlneuralcnnFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnFrame::copy(self : MlneuralcnnFrame) -> MlneuralcnnFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnFrame::fill(self : MlneuralcnnFrame, v : Double) -> MlneuralcnnFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnFrame::min(self : MlneuralcnnFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnFrame::max(self : MlneuralcnnFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnFrame::to_string(self : MlneuralcnnFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_table_make(size : Int) -> MlneuralcnnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnTable::len(self : MlneuralcnnTable) -> Int { self.size }

pub fn MlneuralcnnTable::get(self : MlneuralcnnTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnTable::set(self : MlneuralcnnTable, i : Int, v : Double) -> MlneuralcnnTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnTable::sum(self : MlneuralcnnTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnTable::mean(self : MlneuralcnnTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnTable::scale(self : MlneuralcnnTable, f : Double) -> MlneuralcnnTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnTable::add(self : MlneuralcnnTable, other : MlneuralcnnTable) -> MlneuralcnnTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnTable::copy(self : MlneuralcnnTable) -> MlneuralcnnTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnTable::fill(self : MlneuralcnnTable, v : Double) -> MlneuralcnnTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnTable::min(self : MlneuralcnnTable) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnTable::max(self : MlneuralcnnTable) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnTable::to_string(self : MlneuralcnnTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_graphn_make(size : Int) -> MlneuralcnnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnGraphN::len(self : MlneuralcnnGraphN) -> Int { self.size }

pub fn MlneuralcnnGraphN::get(self : MlneuralcnnGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnGraphN::set(self : MlneuralcnnGraphN, i : Int, v : Double) -> MlneuralcnnGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnGraphN::sum(self : MlneuralcnnGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnGraphN::mean(self : MlneuralcnnGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnGraphN::scale(self : MlneuralcnnGraphN, f : Double) -> MlneuralcnnGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnGraphN::add(self : MlneuralcnnGraphN, other : MlneuralcnnGraphN) -> MlneuralcnnGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnGraphN::copy(self : MlneuralcnnGraphN) -> MlneuralcnnGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnGraphN::fill(self : MlneuralcnnGraphN, v : Double) -> MlneuralcnnGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnGraphN::min(self : MlneuralcnnGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnGraphN::max(self : MlneuralcnnGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnGraphN::to_string(self : MlneuralcnnGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_node_make(size : Int) -> MlneuralcnnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnNode::len(self : MlneuralcnnNode) -> Int { self.size }

pub fn MlneuralcnnNode::get(self : MlneuralcnnNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnNode::set(self : MlneuralcnnNode, i : Int, v : Double) -> MlneuralcnnNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnNode::sum(self : MlneuralcnnNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnNode::mean(self : MlneuralcnnNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnNode::scale(self : MlneuralcnnNode, f : Double) -> MlneuralcnnNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnNode::add(self : MlneuralcnnNode, other : MlneuralcnnNode) -> MlneuralcnnNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnNode::copy(self : MlneuralcnnNode) -> MlneuralcnnNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnNode::fill(self : MlneuralcnnNode, v : Double) -> MlneuralcnnNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnNode::min(self : MlneuralcnnNode) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnNode::max(self : MlneuralcnnNode) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnNode::to_string(self : MlneuralcnnNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_edge_make(size : Int) -> MlneuralcnnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnEdge::len(self : MlneuralcnnEdge) -> Int { self.size }

pub fn MlneuralcnnEdge::get(self : MlneuralcnnEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnEdge::set(self : MlneuralcnnEdge, i : Int, v : Double) -> MlneuralcnnEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnEdge::sum(self : MlneuralcnnEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnEdge::mean(self : MlneuralcnnEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnEdge::scale(self : MlneuralcnnEdge, f : Double) -> MlneuralcnnEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnEdge::add(self : MlneuralcnnEdge, other : MlneuralcnnEdge) -> MlneuralcnnEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnEdge::copy(self : MlneuralcnnEdge) -> MlneuralcnnEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnEdge::fill(self : MlneuralcnnEdge, v : Double) -> MlneuralcnnEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnEdge::min(self : MlneuralcnnEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnEdge::max(self : MlneuralcnnEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnEdge::to_string(self : MlneuralcnnEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_path_make(size : Int) -> MlneuralcnnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnPath::len(self : MlneuralcnnPath) -> Int { self.size }

pub fn MlneuralcnnPath::get(self : MlneuralcnnPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnPath::set(self : MlneuralcnnPath, i : Int, v : Double) -> MlneuralcnnPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnPath::sum(self : MlneuralcnnPath) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnPath::mean(self : MlneuralcnnPath) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnPath::scale(self : MlneuralcnnPath, f : Double) -> MlneuralcnnPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnPath::add(self : MlneuralcnnPath, other : MlneuralcnnPath) -> MlneuralcnnPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnPath::copy(self : MlneuralcnnPath) -> MlneuralcnnPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnPath::fill(self : MlneuralcnnPath, v : Double) -> MlneuralcnnPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnPath::min(self : MlneuralcnnPath) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnPath::max(self : MlneuralcnnPath) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnPath::to_string(self : MlneuralcnnPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_cluster_make(size : Int) -> MlneuralcnnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnCluster::len(self : MlneuralcnnCluster) -> Int { self.size }

pub fn MlneuralcnnCluster::get(self : MlneuralcnnCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnCluster::set(self : MlneuralcnnCluster, i : Int, v : Double) -> MlneuralcnnCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCluster::sum(self : MlneuralcnnCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnCluster::mean(self : MlneuralcnnCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnCluster::scale(self : MlneuralcnnCluster, f : Double) -> MlneuralcnnCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCluster::add(self : MlneuralcnnCluster, other : MlneuralcnnCluster) -> MlneuralcnnCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnCluster::copy(self : MlneuralcnnCluster) -> MlneuralcnnCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCluster::fill(self : MlneuralcnnCluster, v : Double) -> MlneuralcnnCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCluster::min(self : MlneuralcnnCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnCluster::max(self : MlneuralcnnCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnCluster::to_string(self : MlneuralcnnCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_model_make(size : Int) -> MlneuralcnnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnModel::len(self : MlneuralcnnModel) -> Int { self.size }

pub fn MlneuralcnnModel::get(self : MlneuralcnnModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnModel::set(self : MlneuralcnnModel, i : Int, v : Double) -> MlneuralcnnModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnModel::sum(self : MlneuralcnnModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnModel::mean(self : MlneuralcnnModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnModel::scale(self : MlneuralcnnModel, f : Double) -> MlneuralcnnModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnModel::add(self : MlneuralcnnModel, other : MlneuralcnnModel) -> MlneuralcnnModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnModel::copy(self : MlneuralcnnModel) -> MlneuralcnnModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnModel::fill(self : MlneuralcnnModel, v : Double) -> MlneuralcnnModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnModel::min(self : MlneuralcnnModel) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnModel::max(self : MlneuralcnnModel) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnModel::to_string(self : MlneuralcnnModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_layer_make(size : Int) -> MlneuralcnnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnLayer::len(self : MlneuralcnnLayer) -> Int { self.size }

pub fn MlneuralcnnLayer::get(self : MlneuralcnnLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnLayer::set(self : MlneuralcnnLayer, i : Int, v : Double) -> MlneuralcnnLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnLayer::sum(self : MlneuralcnnLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnLayer::mean(self : MlneuralcnnLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnLayer::scale(self : MlneuralcnnLayer, f : Double) -> MlneuralcnnLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnLayer::add(self : MlneuralcnnLayer, other : MlneuralcnnLayer) -> MlneuralcnnLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnLayer::copy(self : MlneuralcnnLayer) -> MlneuralcnnLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnLayer::fill(self : MlneuralcnnLayer, v : Double) -> MlneuralcnnLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnLayer::min(self : MlneuralcnnLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnLayer::max(self : MlneuralcnnLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnLayer::to_string(self : MlneuralcnnLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_buffer_make(size : Int) -> MlneuralcnnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnBuffer::len(self : MlneuralcnnBuffer) -> Int { self.size }

pub fn MlneuralcnnBuffer::get(self : MlneuralcnnBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnBuffer::set(self : MlneuralcnnBuffer, i : Int, v : Double) -> MlneuralcnnBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnBuffer::sum(self : MlneuralcnnBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnBuffer::mean(self : MlneuralcnnBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnBuffer::scale(self : MlneuralcnnBuffer, f : Double) -> MlneuralcnnBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnBuffer::add(self : MlneuralcnnBuffer, other : MlneuralcnnBuffer) -> MlneuralcnnBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnBuffer::copy(self : MlneuralcnnBuffer) -> MlneuralcnnBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnBuffer::fill(self : MlneuralcnnBuffer, v : Double) -> MlneuralcnnBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnBuffer::min(self : MlneuralcnnBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnBuffer::max(self : MlneuralcnnBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnBuffer::to_string(self : MlneuralcnnBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_cursor_make(size : Int) -> MlneuralcnnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnCursor::len(self : MlneuralcnnCursor) -> Int { self.size }

pub fn MlneuralcnnCursor::get(self : MlneuralcnnCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnCursor::set(self : MlneuralcnnCursor, i : Int, v : Double) -> MlneuralcnnCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCursor::sum(self : MlneuralcnnCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnCursor::mean(self : MlneuralcnnCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnCursor::scale(self : MlneuralcnnCursor, f : Double) -> MlneuralcnnCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCursor::add(self : MlneuralcnnCursor, other : MlneuralcnnCursor) -> MlneuralcnnCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnCursor::copy(self : MlneuralcnnCursor) -> MlneuralcnnCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCursor::fill(self : MlneuralcnnCursor, v : Double) -> MlneuralcnnCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnCursor::min(self : MlneuralcnnCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnCursor::max(self : MlneuralcnnCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnCursor::to_string(self : MlneuralcnnCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_view_make(size : Int) -> MlneuralcnnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnView::len(self : MlneuralcnnView) -> Int { self.size }

pub fn MlneuralcnnView::get(self : MlneuralcnnView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnView::set(self : MlneuralcnnView, i : Int, v : Double) -> MlneuralcnnView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnView::sum(self : MlneuralcnnView) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnView::mean(self : MlneuralcnnView) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnView::scale(self : MlneuralcnnView, f : Double) -> MlneuralcnnView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnView::add(self : MlneuralcnnView, other : MlneuralcnnView) -> MlneuralcnnView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnView::copy(self : MlneuralcnnView) -> MlneuralcnnView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnView::fill(self : MlneuralcnnView, v : Double) -> MlneuralcnnView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnView::min(self : MlneuralcnnView) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnView::max(self : MlneuralcnnView) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnView::to_string(self : MlneuralcnnView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_range_make(size : Int) -> MlneuralcnnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnRange::len(self : MlneuralcnnRange) -> Int { self.size }

pub fn MlneuralcnnRange::get(self : MlneuralcnnRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnRange::set(self : MlneuralcnnRange, i : Int, v : Double) -> MlneuralcnnRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnRange::sum(self : MlneuralcnnRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnRange::mean(self : MlneuralcnnRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnRange::scale(self : MlneuralcnnRange, f : Double) -> MlneuralcnnRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnRange::add(self : MlneuralcnnRange, other : MlneuralcnnRange) -> MlneuralcnnRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnRange::copy(self : MlneuralcnnRange) -> MlneuralcnnRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnRange::fill(self : MlneuralcnnRange, v : Double) -> MlneuralcnnRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnRange::min(self : MlneuralcnnRange) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnRange::max(self : MlneuralcnnRange) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnRange::to_string(self : MlneuralcnnRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralcnnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_cnn_slice_make(size : Int) -> MlneuralcnnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralcnnSlice::len(self : MlneuralcnnSlice) -> Int { self.size }

pub fn MlneuralcnnSlice::get(self : MlneuralcnnSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralcnnSlice::set(self : MlneuralcnnSlice, i : Int, v : Double) -> MlneuralcnnSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralcnnSlice::sum(self : MlneuralcnnSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralcnnSlice::mean(self : MlneuralcnnSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralcnnSlice::scale(self : MlneuralcnnSlice, f : Double) -> MlneuralcnnSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnSlice::add(self : MlneuralcnnSlice, other : MlneuralcnnSlice) -> MlneuralcnnSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralcnnSlice::copy(self : MlneuralcnnSlice) -> MlneuralcnnSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnSlice::fill(self : MlneuralcnnSlice, v : Double) -> MlneuralcnnSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralcnnSlice::min(self : MlneuralcnnSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralcnnSlice::max(self : MlneuralcnnSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralcnnSlice::to_string(self : MlneuralcnnSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

