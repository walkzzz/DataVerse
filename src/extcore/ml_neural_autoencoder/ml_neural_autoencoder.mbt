///===
/// extcore/ml_neural_autoencoder

pub(all) struct MlneuralautoencoderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_autoencoder_make_point(x : Double, y : Double) -> MlneuralautoencoderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_autoencoder_make_point3(x : Double, y : Double, z : Double) -> MlneuralautoencoderPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralautoencoderPoint::x(self : MlneuralautoencoderPoint) -> Double { self.x }

pub fn MlneuralautoencoderPoint::y(self : MlneuralautoencoderPoint) -> Double { self.y }

pub fn MlneuralautoencoderPoint::z(self : MlneuralautoencoderPoint) -> Double { self.z }

pub fn MlneuralautoencoderPoint::label(self : MlneuralautoencoderPoint) -> Int { self.label }

pub fn MlneuralautoencoderPoint::dist(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralautoencoderPoint::add(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralautoencoderPoint::sub(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralautoencoderPoint::scale(self : MlneuralautoencoderPoint, s : Double) -> MlneuralautoencoderPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralautoencoderPoint::dot(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralautoencoderPoint::cross(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralautoencoderPoint::norm(self : MlneuralautoencoderPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralautoencoderPoint::normalize(self : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralautoencoderPoint::negate(self : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralautoencoderPoint::mid(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint) -> MlneuralautoencoderPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralautoencoderPoint::lerp(self : MlneuralautoencoderPoint, other : MlneuralautoencoderPoint, t : Double) -> MlneuralautoencoderPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralautoencoderPoint::to_string(self : MlneuralautoencoderPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralautoencoderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_autoencoder_make_series(vals : Array[Double], name : String) -> MlneuralautoencoderSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralautoencoderSeries::len(self : MlneuralautoencoderSeries) -> Int { self.vals.length() }

pub fn MlneuralautoencoderSeries::sum(self : MlneuralautoencoderSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralautoencoderSeries::mean(self : MlneuralautoencoderSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralautoencoderSeries::min(self : MlneuralautoencoderSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralautoencoderSeries::max(self : MlneuralautoencoderSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralautoencoderSeries::range(self : MlneuralautoencoderSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralautoencoderSeries::variance(self : MlneuralautoencoderSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralautoencoderSeries::std(self : MlneuralautoencoderSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralautoencoderSeries::median(self : MlneuralautoencoderSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralautoencoderSeries::scale(self : MlneuralautoencoderSeries, f : Double) -> MlneuralautoencoderSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralautoencoderSeries::add(self : MlneuralautoencoderSeries, other : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralautoencoderSeries::sub(self : MlneuralautoencoderSeries, other : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralautoencoderSeries::normalize(self : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralautoencoderSeries::cumsum(self : MlneuralautoencoderSeries) -> MlneuralautoencoderSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralautoencoderSeries::to_string(self : MlneuralautoencoderSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralautoencoderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_autoencoder_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralautoencoderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_autoencoder_matrix_identity(n : Int) -> MlneuralautoencoderMatrix {
  let m = ml_neural_autoencoder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralautoencoderMatrix::get(self : MlneuralautoencoderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralautoencoderMatrix::transpose(self : MlneuralautoencoderMatrix) -> MlneuralautoencoderMatrix {
  let result = ml_neural_autoencoder_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralautoencoderMatrix::add(self : MlneuralautoencoderMatrix, other : MlneuralautoencoderMatrix) -> MlneuralautoencoderMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_autoencoder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralautoencoderMatrix::scale(self : MlneuralautoencoderMatrix, s : Double) -> MlneuralautoencoderMatrix {
  let result = ml_neural_autoencoder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralautoencoderMatrix::multiply(self : MlneuralautoencoderMatrix, other : MlneuralautoencoderMatrix) -> MlneuralautoencoderMatrix {
  if self.cols != other.rows { return ml_neural_autoencoder_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_autoencoder_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralautoencoderMatrix::trace(self : MlneuralautoencoderMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralautoencoderMatrix::det(self : MlneuralautoencoderMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralautoencoderMatrix::norm(self : MlneuralautoencoderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralautoencoderMatrix::to_string(self : MlneuralautoencoderMatrix) -> String {
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

pub(all) struct MlneuralautoencoderVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_autoencoder_make_vector(comps : Array[Double]) -> MlneuralautoencoderVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_autoencoder_vector_zero(dim : Int) -> MlneuralautoencoderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralautoencoderVector::add(self : MlneuralautoencoderVector, other : MlneuralautoencoderVector) -> MlneuralautoencoderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralautoencoderVector::sub(self : MlneuralautoencoderVector, other : MlneuralautoencoderVector) -> MlneuralautoencoderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralautoencoderVector::scale(self : MlneuralautoencoderVector, s : Double) -> MlneuralautoencoderVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralautoencoderVector::dot(self : MlneuralautoencoderVector, other : MlneuralautoencoderVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralautoencoderVector::norm(self : MlneuralautoencoderVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralautoencoderVector::normalize(self : MlneuralautoencoderVector) -> MlneuralautoencoderVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralautoencoderVector::dist(self : MlneuralautoencoderVector, other : MlneuralautoencoderVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralautoencoderVector::to_string(self : MlneuralautoencoderVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_autoencoder_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_autoencoder_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_autoencoder_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_autoencoder_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_autoencoder_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_autoencoder_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_autoencoder_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_autoencoder_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_autoencoder_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_autoencoder_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_autoencoder_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_autoencoder_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_autoencoder_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_autoencoder_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_autoencoder_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_autoencoder_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_autoencoder_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_autoencoder_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_autoencoder_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_autoencoder_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_autoencoder_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_autoencoder_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_autoencoder_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_autoencoder_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_autoencoder_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_autoencoder_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_autoencoder_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_autoencoder_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_autoencoder_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralautoencoderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_frame_make(size : Int) -> MlneuralautoencoderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderFrame::len(self : MlneuralautoencoderFrame) -> Int { self.size }

pub fn MlneuralautoencoderFrame::get(self : MlneuralautoencoderFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderFrame::set(self : MlneuralautoencoderFrame, i : Int, v : Double) -> MlneuralautoencoderFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderFrame::sum(self : MlneuralautoencoderFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderFrame::mean(self : MlneuralautoencoderFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderFrame::scale(self : MlneuralautoencoderFrame, f : Double) -> MlneuralautoencoderFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderFrame::add(self : MlneuralautoencoderFrame, other : MlneuralautoencoderFrame) -> MlneuralautoencoderFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderFrame::copy(self : MlneuralautoencoderFrame) -> MlneuralautoencoderFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderFrame::fill(self : MlneuralautoencoderFrame, v : Double) -> MlneuralautoencoderFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderFrame::min(self : MlneuralautoencoderFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderFrame::max(self : MlneuralautoencoderFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderFrame::to_string(self : MlneuralautoencoderFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_table_make(size : Int) -> MlneuralautoencoderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderTable::len(self : MlneuralautoencoderTable) -> Int { self.size }

pub fn MlneuralautoencoderTable::get(self : MlneuralautoencoderTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderTable::set(self : MlneuralautoencoderTable, i : Int, v : Double) -> MlneuralautoencoderTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderTable::sum(self : MlneuralautoencoderTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderTable::mean(self : MlneuralautoencoderTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderTable::scale(self : MlneuralautoencoderTable, f : Double) -> MlneuralautoencoderTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderTable::add(self : MlneuralautoencoderTable, other : MlneuralautoencoderTable) -> MlneuralautoencoderTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderTable::copy(self : MlneuralautoencoderTable) -> MlneuralautoencoderTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderTable::fill(self : MlneuralautoencoderTable, v : Double) -> MlneuralautoencoderTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderTable::min(self : MlneuralautoencoderTable) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderTable::max(self : MlneuralautoencoderTable) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderTable::to_string(self : MlneuralautoencoderTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_graphn_make(size : Int) -> MlneuralautoencoderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderGraphN::len(self : MlneuralautoencoderGraphN) -> Int { self.size }

pub fn MlneuralautoencoderGraphN::get(self : MlneuralautoencoderGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderGraphN::set(self : MlneuralautoencoderGraphN, i : Int, v : Double) -> MlneuralautoencoderGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderGraphN::sum(self : MlneuralautoencoderGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderGraphN::mean(self : MlneuralautoencoderGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderGraphN::scale(self : MlneuralautoencoderGraphN, f : Double) -> MlneuralautoencoderGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderGraphN::add(self : MlneuralautoencoderGraphN, other : MlneuralautoencoderGraphN) -> MlneuralautoencoderGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderGraphN::copy(self : MlneuralautoencoderGraphN) -> MlneuralautoencoderGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderGraphN::fill(self : MlneuralautoencoderGraphN, v : Double) -> MlneuralautoencoderGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderGraphN::min(self : MlneuralautoencoderGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderGraphN::max(self : MlneuralautoencoderGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderGraphN::to_string(self : MlneuralautoencoderGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_node_make(size : Int) -> MlneuralautoencoderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderNode::len(self : MlneuralautoencoderNode) -> Int { self.size }

pub fn MlneuralautoencoderNode::get(self : MlneuralautoencoderNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderNode::set(self : MlneuralautoencoderNode, i : Int, v : Double) -> MlneuralautoencoderNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderNode::sum(self : MlneuralautoencoderNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderNode::mean(self : MlneuralautoencoderNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderNode::scale(self : MlneuralautoencoderNode, f : Double) -> MlneuralautoencoderNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderNode::add(self : MlneuralautoencoderNode, other : MlneuralautoencoderNode) -> MlneuralautoencoderNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderNode::copy(self : MlneuralautoencoderNode) -> MlneuralautoencoderNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderNode::fill(self : MlneuralautoencoderNode, v : Double) -> MlneuralautoencoderNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderNode::min(self : MlneuralautoencoderNode) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderNode::max(self : MlneuralautoencoderNode) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderNode::to_string(self : MlneuralautoencoderNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_edge_make(size : Int) -> MlneuralautoencoderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderEdge::len(self : MlneuralautoencoderEdge) -> Int { self.size }

pub fn MlneuralautoencoderEdge::get(self : MlneuralautoencoderEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderEdge::set(self : MlneuralautoencoderEdge, i : Int, v : Double) -> MlneuralautoencoderEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderEdge::sum(self : MlneuralautoencoderEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderEdge::mean(self : MlneuralautoencoderEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderEdge::scale(self : MlneuralautoencoderEdge, f : Double) -> MlneuralautoencoderEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderEdge::add(self : MlneuralautoencoderEdge, other : MlneuralautoencoderEdge) -> MlneuralautoencoderEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderEdge::copy(self : MlneuralautoencoderEdge) -> MlneuralautoencoderEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderEdge::fill(self : MlneuralautoencoderEdge, v : Double) -> MlneuralautoencoderEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderEdge::min(self : MlneuralautoencoderEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderEdge::max(self : MlneuralautoencoderEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderEdge::to_string(self : MlneuralautoencoderEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_path_make(size : Int) -> MlneuralautoencoderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderPath::len(self : MlneuralautoencoderPath) -> Int { self.size }

pub fn MlneuralautoencoderPath::get(self : MlneuralautoencoderPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderPath::set(self : MlneuralautoencoderPath, i : Int, v : Double) -> MlneuralautoencoderPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderPath::sum(self : MlneuralautoencoderPath) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderPath::mean(self : MlneuralautoencoderPath) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderPath::scale(self : MlneuralautoencoderPath, f : Double) -> MlneuralautoencoderPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderPath::add(self : MlneuralautoencoderPath, other : MlneuralautoencoderPath) -> MlneuralautoencoderPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderPath::copy(self : MlneuralautoencoderPath) -> MlneuralautoencoderPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderPath::fill(self : MlneuralautoencoderPath, v : Double) -> MlneuralautoencoderPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderPath::min(self : MlneuralautoencoderPath) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderPath::max(self : MlneuralautoencoderPath) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderPath::to_string(self : MlneuralautoencoderPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_cluster_make(size : Int) -> MlneuralautoencoderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderCluster::len(self : MlneuralautoencoderCluster) -> Int { self.size }

pub fn MlneuralautoencoderCluster::get(self : MlneuralautoencoderCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderCluster::set(self : MlneuralautoencoderCluster, i : Int, v : Double) -> MlneuralautoencoderCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCluster::sum(self : MlneuralautoencoderCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderCluster::mean(self : MlneuralautoencoderCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderCluster::scale(self : MlneuralautoencoderCluster, f : Double) -> MlneuralautoencoderCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCluster::add(self : MlneuralautoencoderCluster, other : MlneuralautoencoderCluster) -> MlneuralautoencoderCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderCluster::copy(self : MlneuralautoencoderCluster) -> MlneuralautoencoderCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCluster::fill(self : MlneuralautoencoderCluster, v : Double) -> MlneuralautoencoderCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCluster::min(self : MlneuralautoencoderCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderCluster::max(self : MlneuralautoencoderCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderCluster::to_string(self : MlneuralautoencoderCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_model_make(size : Int) -> MlneuralautoencoderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderModel::len(self : MlneuralautoencoderModel) -> Int { self.size }

pub fn MlneuralautoencoderModel::get(self : MlneuralautoencoderModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderModel::set(self : MlneuralautoencoderModel, i : Int, v : Double) -> MlneuralautoencoderModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderModel::sum(self : MlneuralautoencoderModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderModel::mean(self : MlneuralautoencoderModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderModel::scale(self : MlneuralautoencoderModel, f : Double) -> MlneuralautoencoderModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderModel::add(self : MlneuralautoencoderModel, other : MlneuralautoencoderModel) -> MlneuralautoencoderModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderModel::copy(self : MlneuralautoencoderModel) -> MlneuralautoencoderModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderModel::fill(self : MlneuralautoencoderModel, v : Double) -> MlneuralautoencoderModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderModel::min(self : MlneuralautoencoderModel) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderModel::max(self : MlneuralautoencoderModel) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderModel::to_string(self : MlneuralautoencoderModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_layer_make(size : Int) -> MlneuralautoencoderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderLayer::len(self : MlneuralautoencoderLayer) -> Int { self.size }

pub fn MlneuralautoencoderLayer::get(self : MlneuralautoencoderLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderLayer::set(self : MlneuralautoencoderLayer, i : Int, v : Double) -> MlneuralautoencoderLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderLayer::sum(self : MlneuralautoencoderLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderLayer::mean(self : MlneuralautoencoderLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderLayer::scale(self : MlneuralautoencoderLayer, f : Double) -> MlneuralautoencoderLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderLayer::add(self : MlneuralautoencoderLayer, other : MlneuralautoencoderLayer) -> MlneuralautoencoderLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderLayer::copy(self : MlneuralautoencoderLayer) -> MlneuralautoencoderLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderLayer::fill(self : MlneuralautoencoderLayer, v : Double) -> MlneuralautoencoderLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderLayer::min(self : MlneuralautoencoderLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderLayer::max(self : MlneuralautoencoderLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderLayer::to_string(self : MlneuralautoencoderLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_buffer_make(size : Int) -> MlneuralautoencoderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderBuffer::len(self : MlneuralautoencoderBuffer) -> Int { self.size }

pub fn MlneuralautoencoderBuffer::get(self : MlneuralautoencoderBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderBuffer::set(self : MlneuralautoencoderBuffer, i : Int, v : Double) -> MlneuralautoencoderBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderBuffer::sum(self : MlneuralautoencoderBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderBuffer::mean(self : MlneuralautoencoderBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderBuffer::scale(self : MlneuralautoencoderBuffer, f : Double) -> MlneuralautoencoderBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderBuffer::add(self : MlneuralautoencoderBuffer, other : MlneuralautoencoderBuffer) -> MlneuralautoencoderBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderBuffer::copy(self : MlneuralautoencoderBuffer) -> MlneuralautoencoderBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderBuffer::fill(self : MlneuralautoencoderBuffer, v : Double) -> MlneuralautoencoderBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderBuffer::min(self : MlneuralautoencoderBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderBuffer::max(self : MlneuralautoencoderBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderBuffer::to_string(self : MlneuralautoencoderBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_cursor_make(size : Int) -> MlneuralautoencoderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderCursor::len(self : MlneuralautoencoderCursor) -> Int { self.size }

pub fn MlneuralautoencoderCursor::get(self : MlneuralautoencoderCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderCursor::set(self : MlneuralautoencoderCursor, i : Int, v : Double) -> MlneuralautoencoderCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCursor::sum(self : MlneuralautoencoderCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderCursor::mean(self : MlneuralautoencoderCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderCursor::scale(self : MlneuralautoencoderCursor, f : Double) -> MlneuralautoencoderCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCursor::add(self : MlneuralautoencoderCursor, other : MlneuralautoencoderCursor) -> MlneuralautoencoderCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderCursor::copy(self : MlneuralautoencoderCursor) -> MlneuralautoencoderCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCursor::fill(self : MlneuralautoencoderCursor, v : Double) -> MlneuralautoencoderCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderCursor::min(self : MlneuralautoencoderCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderCursor::max(self : MlneuralautoencoderCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderCursor::to_string(self : MlneuralautoencoderCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_view_make(size : Int) -> MlneuralautoencoderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderView::len(self : MlneuralautoencoderView) -> Int { self.size }

pub fn MlneuralautoencoderView::get(self : MlneuralautoencoderView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderView::set(self : MlneuralautoencoderView, i : Int, v : Double) -> MlneuralautoencoderView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderView::sum(self : MlneuralautoencoderView) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderView::mean(self : MlneuralautoencoderView) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderView::scale(self : MlneuralautoencoderView, f : Double) -> MlneuralautoencoderView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderView::add(self : MlneuralautoencoderView, other : MlneuralautoencoderView) -> MlneuralautoencoderView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderView::copy(self : MlneuralautoencoderView) -> MlneuralautoencoderView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderView::fill(self : MlneuralautoencoderView, v : Double) -> MlneuralautoencoderView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderView::min(self : MlneuralautoencoderView) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderView::max(self : MlneuralautoencoderView) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderView::to_string(self : MlneuralautoencoderView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_range_make(size : Int) -> MlneuralautoencoderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderRange::len(self : MlneuralautoencoderRange) -> Int { self.size }

pub fn MlneuralautoencoderRange::get(self : MlneuralautoencoderRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderRange::set(self : MlneuralautoencoderRange, i : Int, v : Double) -> MlneuralautoencoderRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderRange::sum(self : MlneuralautoencoderRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderRange::mean(self : MlneuralautoencoderRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderRange::scale(self : MlneuralautoencoderRange, f : Double) -> MlneuralautoencoderRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderRange::add(self : MlneuralautoencoderRange, other : MlneuralautoencoderRange) -> MlneuralautoencoderRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderRange::copy(self : MlneuralautoencoderRange) -> MlneuralautoencoderRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderRange::fill(self : MlneuralautoencoderRange, v : Double) -> MlneuralautoencoderRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderRange::min(self : MlneuralautoencoderRange) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderRange::max(self : MlneuralautoencoderRange) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderRange::to_string(self : MlneuralautoencoderRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralautoencoderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_autoencoder_slice_make(size : Int) -> MlneuralautoencoderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralautoencoderSlice::len(self : MlneuralautoencoderSlice) -> Int { self.size }

pub fn MlneuralautoencoderSlice::get(self : MlneuralautoencoderSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralautoencoderSlice::set(self : MlneuralautoencoderSlice, i : Int, v : Double) -> MlneuralautoencoderSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderSlice::sum(self : MlneuralautoencoderSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralautoencoderSlice::mean(self : MlneuralautoencoderSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralautoencoderSlice::scale(self : MlneuralautoencoderSlice, f : Double) -> MlneuralautoencoderSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderSlice::add(self : MlneuralautoencoderSlice, other : MlneuralautoencoderSlice) -> MlneuralautoencoderSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralautoencoderSlice::copy(self : MlneuralautoencoderSlice) -> MlneuralautoencoderSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderSlice::fill(self : MlneuralautoencoderSlice, v : Double) -> MlneuralautoencoderSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralautoencoderSlice::min(self : MlneuralautoencoderSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralautoencoderSlice::max(self : MlneuralautoencoderSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralautoencoderSlice::to_string(self : MlneuralautoencoderSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

