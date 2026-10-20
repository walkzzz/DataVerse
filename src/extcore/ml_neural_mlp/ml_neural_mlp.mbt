///===
/// extcore/ml_neural_mlp

pub(all) struct MlneuralmlpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_mlp_make_point(x : Double, y : Double) -> MlneuralmlpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_mlp_make_point3(x : Double, y : Double, z : Double) -> MlneuralmlpPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralmlpPoint::x(self : MlneuralmlpPoint) -> Double { self.x }

pub fn MlneuralmlpPoint::y(self : MlneuralmlpPoint) -> Double { self.y }

pub fn MlneuralmlpPoint::z(self : MlneuralmlpPoint) -> Double { self.z }

pub fn MlneuralmlpPoint::label(self : MlneuralmlpPoint) -> Int { self.label }

pub fn MlneuralmlpPoint::dist(self : MlneuralmlpPoint, other : MlneuralmlpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralmlpPoint::add(self : MlneuralmlpPoint, other : MlneuralmlpPoint) -> MlneuralmlpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralmlpPoint::sub(self : MlneuralmlpPoint, other : MlneuralmlpPoint) -> MlneuralmlpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralmlpPoint::scale(self : MlneuralmlpPoint, s : Double) -> MlneuralmlpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralmlpPoint::dot(self : MlneuralmlpPoint, other : MlneuralmlpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralmlpPoint::cross(self : MlneuralmlpPoint, other : MlneuralmlpPoint) -> MlneuralmlpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralmlpPoint::norm(self : MlneuralmlpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralmlpPoint::normalize(self : MlneuralmlpPoint) -> MlneuralmlpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralmlpPoint::negate(self : MlneuralmlpPoint) -> MlneuralmlpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralmlpPoint::mid(self : MlneuralmlpPoint, other : MlneuralmlpPoint) -> MlneuralmlpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralmlpPoint::lerp(self : MlneuralmlpPoint, other : MlneuralmlpPoint, t : Double) -> MlneuralmlpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralmlpPoint::to_string(self : MlneuralmlpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralmlpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_mlp_make_series(vals : Array[Double], name : String) -> MlneuralmlpSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralmlpSeries::len(self : MlneuralmlpSeries) -> Int { self.vals.length() }

pub fn MlneuralmlpSeries::sum(self : MlneuralmlpSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralmlpSeries::mean(self : MlneuralmlpSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralmlpSeries::min(self : MlneuralmlpSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralmlpSeries::max(self : MlneuralmlpSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralmlpSeries::range(self : MlneuralmlpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralmlpSeries::variance(self : MlneuralmlpSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralmlpSeries::std(self : MlneuralmlpSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralmlpSeries::median(self : MlneuralmlpSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralmlpSeries::scale(self : MlneuralmlpSeries, f : Double) -> MlneuralmlpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralmlpSeries::add(self : MlneuralmlpSeries, other : MlneuralmlpSeries) -> MlneuralmlpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralmlpSeries::sub(self : MlneuralmlpSeries, other : MlneuralmlpSeries) -> MlneuralmlpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralmlpSeries::normalize(self : MlneuralmlpSeries) -> MlneuralmlpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralmlpSeries::cumsum(self : MlneuralmlpSeries) -> MlneuralmlpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralmlpSeries::to_string(self : MlneuralmlpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralmlpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_mlp_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralmlpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_mlp_matrix_identity(n : Int) -> MlneuralmlpMatrix {
  let m = ml_neural_mlp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralmlpMatrix::get(self : MlneuralmlpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralmlpMatrix::transpose(self : MlneuralmlpMatrix) -> MlneuralmlpMatrix {
  let result = ml_neural_mlp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralmlpMatrix::add(self : MlneuralmlpMatrix, other : MlneuralmlpMatrix) -> MlneuralmlpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_mlp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralmlpMatrix::scale(self : MlneuralmlpMatrix, s : Double) -> MlneuralmlpMatrix {
  let result = ml_neural_mlp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralmlpMatrix::multiply(self : MlneuralmlpMatrix, other : MlneuralmlpMatrix) -> MlneuralmlpMatrix {
  if self.cols != other.rows { return ml_neural_mlp_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_mlp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralmlpMatrix::trace(self : MlneuralmlpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralmlpMatrix::det(self : MlneuralmlpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralmlpMatrix::norm(self : MlneuralmlpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralmlpMatrix::to_string(self : MlneuralmlpMatrix) -> String {
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

pub(all) struct MlneuralmlpVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_mlp_make_vector(comps : Array[Double]) -> MlneuralmlpVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_mlp_vector_zero(dim : Int) -> MlneuralmlpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralmlpVector::add(self : MlneuralmlpVector, other : MlneuralmlpVector) -> MlneuralmlpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralmlpVector::sub(self : MlneuralmlpVector, other : MlneuralmlpVector) -> MlneuralmlpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralmlpVector::scale(self : MlneuralmlpVector, s : Double) -> MlneuralmlpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralmlpVector::dot(self : MlneuralmlpVector, other : MlneuralmlpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralmlpVector::norm(self : MlneuralmlpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralmlpVector::normalize(self : MlneuralmlpVector) -> MlneuralmlpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralmlpVector::dist(self : MlneuralmlpVector, other : MlneuralmlpVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralmlpVector::to_string(self : MlneuralmlpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_mlp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_mlp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_mlp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_mlp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_mlp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_mlp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_mlp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_mlp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_mlp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_mlp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_mlp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_mlp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_mlp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_mlp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_mlp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_mlp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_mlp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_mlp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_mlp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_mlp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_mlp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_mlp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_mlp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_mlp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_mlp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_mlp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_mlp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_mlp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_mlp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralmlpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_frame_make(size : Int) -> MlneuralmlpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpFrame::len(self : MlneuralmlpFrame) -> Int { self.size }

pub fn MlneuralmlpFrame::get(self : MlneuralmlpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpFrame::set(self : MlneuralmlpFrame, i : Int, v : Double) -> MlneuralmlpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpFrame::sum(self : MlneuralmlpFrame) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpFrame::mean(self : MlneuralmlpFrame) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpFrame::scale(self : MlneuralmlpFrame, f : Double) -> MlneuralmlpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpFrame::add(self : MlneuralmlpFrame, other : MlneuralmlpFrame) -> MlneuralmlpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpFrame::copy(self : MlneuralmlpFrame) -> MlneuralmlpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpFrame::fill(self : MlneuralmlpFrame, v : Double) -> MlneuralmlpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpFrame::min(self : MlneuralmlpFrame) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpFrame::max(self : MlneuralmlpFrame) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpFrame::to_string(self : MlneuralmlpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_table_make(size : Int) -> MlneuralmlpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpTable::len(self : MlneuralmlpTable) -> Int { self.size }

pub fn MlneuralmlpTable::get(self : MlneuralmlpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpTable::set(self : MlneuralmlpTable, i : Int, v : Double) -> MlneuralmlpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpTable::sum(self : MlneuralmlpTable) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpTable::mean(self : MlneuralmlpTable) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpTable::scale(self : MlneuralmlpTable, f : Double) -> MlneuralmlpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpTable::add(self : MlneuralmlpTable, other : MlneuralmlpTable) -> MlneuralmlpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpTable::copy(self : MlneuralmlpTable) -> MlneuralmlpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpTable::fill(self : MlneuralmlpTable, v : Double) -> MlneuralmlpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpTable::min(self : MlneuralmlpTable) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpTable::max(self : MlneuralmlpTable) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpTable::to_string(self : MlneuralmlpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_graphn_make(size : Int) -> MlneuralmlpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpGraphN::len(self : MlneuralmlpGraphN) -> Int { self.size }

pub fn MlneuralmlpGraphN::get(self : MlneuralmlpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpGraphN::set(self : MlneuralmlpGraphN, i : Int, v : Double) -> MlneuralmlpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpGraphN::sum(self : MlneuralmlpGraphN) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpGraphN::mean(self : MlneuralmlpGraphN) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpGraphN::scale(self : MlneuralmlpGraphN, f : Double) -> MlneuralmlpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpGraphN::add(self : MlneuralmlpGraphN, other : MlneuralmlpGraphN) -> MlneuralmlpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpGraphN::copy(self : MlneuralmlpGraphN) -> MlneuralmlpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpGraphN::fill(self : MlneuralmlpGraphN, v : Double) -> MlneuralmlpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpGraphN::min(self : MlneuralmlpGraphN) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpGraphN::max(self : MlneuralmlpGraphN) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpGraphN::to_string(self : MlneuralmlpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_node_make(size : Int) -> MlneuralmlpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpNode::len(self : MlneuralmlpNode) -> Int { self.size }

pub fn MlneuralmlpNode::get(self : MlneuralmlpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpNode::set(self : MlneuralmlpNode, i : Int, v : Double) -> MlneuralmlpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpNode::sum(self : MlneuralmlpNode) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpNode::mean(self : MlneuralmlpNode) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpNode::scale(self : MlneuralmlpNode, f : Double) -> MlneuralmlpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpNode::add(self : MlneuralmlpNode, other : MlneuralmlpNode) -> MlneuralmlpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpNode::copy(self : MlneuralmlpNode) -> MlneuralmlpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpNode::fill(self : MlneuralmlpNode, v : Double) -> MlneuralmlpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpNode::min(self : MlneuralmlpNode) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpNode::max(self : MlneuralmlpNode) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpNode::to_string(self : MlneuralmlpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_edge_make(size : Int) -> MlneuralmlpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpEdge::len(self : MlneuralmlpEdge) -> Int { self.size }

pub fn MlneuralmlpEdge::get(self : MlneuralmlpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpEdge::set(self : MlneuralmlpEdge, i : Int, v : Double) -> MlneuralmlpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpEdge::sum(self : MlneuralmlpEdge) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpEdge::mean(self : MlneuralmlpEdge) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpEdge::scale(self : MlneuralmlpEdge, f : Double) -> MlneuralmlpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpEdge::add(self : MlneuralmlpEdge, other : MlneuralmlpEdge) -> MlneuralmlpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpEdge::copy(self : MlneuralmlpEdge) -> MlneuralmlpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpEdge::fill(self : MlneuralmlpEdge, v : Double) -> MlneuralmlpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpEdge::min(self : MlneuralmlpEdge) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpEdge::max(self : MlneuralmlpEdge) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpEdge::to_string(self : MlneuralmlpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_path_make(size : Int) -> MlneuralmlpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpPath::len(self : MlneuralmlpPath) -> Int { self.size }

pub fn MlneuralmlpPath::get(self : MlneuralmlpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpPath::set(self : MlneuralmlpPath, i : Int, v : Double) -> MlneuralmlpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpPath::sum(self : MlneuralmlpPath) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpPath::mean(self : MlneuralmlpPath) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpPath::scale(self : MlneuralmlpPath, f : Double) -> MlneuralmlpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpPath::add(self : MlneuralmlpPath, other : MlneuralmlpPath) -> MlneuralmlpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpPath::copy(self : MlneuralmlpPath) -> MlneuralmlpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpPath::fill(self : MlneuralmlpPath, v : Double) -> MlneuralmlpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpPath::min(self : MlneuralmlpPath) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpPath::max(self : MlneuralmlpPath) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpPath::to_string(self : MlneuralmlpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_cluster_make(size : Int) -> MlneuralmlpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpCluster::len(self : MlneuralmlpCluster) -> Int { self.size }

pub fn MlneuralmlpCluster::get(self : MlneuralmlpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpCluster::set(self : MlneuralmlpCluster, i : Int, v : Double) -> MlneuralmlpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCluster::sum(self : MlneuralmlpCluster) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpCluster::mean(self : MlneuralmlpCluster) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpCluster::scale(self : MlneuralmlpCluster, f : Double) -> MlneuralmlpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCluster::add(self : MlneuralmlpCluster, other : MlneuralmlpCluster) -> MlneuralmlpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpCluster::copy(self : MlneuralmlpCluster) -> MlneuralmlpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCluster::fill(self : MlneuralmlpCluster, v : Double) -> MlneuralmlpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCluster::min(self : MlneuralmlpCluster) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpCluster::max(self : MlneuralmlpCluster) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpCluster::to_string(self : MlneuralmlpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_model_make(size : Int) -> MlneuralmlpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpModel::len(self : MlneuralmlpModel) -> Int { self.size }

pub fn MlneuralmlpModel::get(self : MlneuralmlpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpModel::set(self : MlneuralmlpModel, i : Int, v : Double) -> MlneuralmlpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpModel::sum(self : MlneuralmlpModel) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpModel::mean(self : MlneuralmlpModel) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpModel::scale(self : MlneuralmlpModel, f : Double) -> MlneuralmlpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpModel::add(self : MlneuralmlpModel, other : MlneuralmlpModel) -> MlneuralmlpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpModel::copy(self : MlneuralmlpModel) -> MlneuralmlpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpModel::fill(self : MlneuralmlpModel, v : Double) -> MlneuralmlpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpModel::min(self : MlneuralmlpModel) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpModel::max(self : MlneuralmlpModel) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpModel::to_string(self : MlneuralmlpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_layer_make(size : Int) -> MlneuralmlpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpLayer::len(self : MlneuralmlpLayer) -> Int { self.size }

pub fn MlneuralmlpLayer::get(self : MlneuralmlpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpLayer::set(self : MlneuralmlpLayer, i : Int, v : Double) -> MlneuralmlpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpLayer::sum(self : MlneuralmlpLayer) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpLayer::mean(self : MlneuralmlpLayer) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpLayer::scale(self : MlneuralmlpLayer, f : Double) -> MlneuralmlpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpLayer::add(self : MlneuralmlpLayer, other : MlneuralmlpLayer) -> MlneuralmlpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpLayer::copy(self : MlneuralmlpLayer) -> MlneuralmlpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpLayer::fill(self : MlneuralmlpLayer, v : Double) -> MlneuralmlpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpLayer::min(self : MlneuralmlpLayer) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpLayer::max(self : MlneuralmlpLayer) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpLayer::to_string(self : MlneuralmlpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_buffer_make(size : Int) -> MlneuralmlpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpBuffer::len(self : MlneuralmlpBuffer) -> Int { self.size }

pub fn MlneuralmlpBuffer::get(self : MlneuralmlpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpBuffer::set(self : MlneuralmlpBuffer, i : Int, v : Double) -> MlneuralmlpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpBuffer::sum(self : MlneuralmlpBuffer) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpBuffer::mean(self : MlneuralmlpBuffer) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpBuffer::scale(self : MlneuralmlpBuffer, f : Double) -> MlneuralmlpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpBuffer::add(self : MlneuralmlpBuffer, other : MlneuralmlpBuffer) -> MlneuralmlpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpBuffer::copy(self : MlneuralmlpBuffer) -> MlneuralmlpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpBuffer::fill(self : MlneuralmlpBuffer, v : Double) -> MlneuralmlpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpBuffer::min(self : MlneuralmlpBuffer) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpBuffer::max(self : MlneuralmlpBuffer) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpBuffer::to_string(self : MlneuralmlpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_cursor_make(size : Int) -> MlneuralmlpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpCursor::len(self : MlneuralmlpCursor) -> Int { self.size }

pub fn MlneuralmlpCursor::get(self : MlneuralmlpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpCursor::set(self : MlneuralmlpCursor, i : Int, v : Double) -> MlneuralmlpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCursor::sum(self : MlneuralmlpCursor) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpCursor::mean(self : MlneuralmlpCursor) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpCursor::scale(self : MlneuralmlpCursor, f : Double) -> MlneuralmlpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCursor::add(self : MlneuralmlpCursor, other : MlneuralmlpCursor) -> MlneuralmlpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpCursor::copy(self : MlneuralmlpCursor) -> MlneuralmlpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCursor::fill(self : MlneuralmlpCursor, v : Double) -> MlneuralmlpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpCursor::min(self : MlneuralmlpCursor) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpCursor::max(self : MlneuralmlpCursor) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpCursor::to_string(self : MlneuralmlpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_view_make(size : Int) -> MlneuralmlpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpView::len(self : MlneuralmlpView) -> Int { self.size }

pub fn MlneuralmlpView::get(self : MlneuralmlpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpView::set(self : MlneuralmlpView, i : Int, v : Double) -> MlneuralmlpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpView::sum(self : MlneuralmlpView) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpView::mean(self : MlneuralmlpView) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpView::scale(self : MlneuralmlpView, f : Double) -> MlneuralmlpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpView::add(self : MlneuralmlpView, other : MlneuralmlpView) -> MlneuralmlpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpView::copy(self : MlneuralmlpView) -> MlneuralmlpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpView::fill(self : MlneuralmlpView, v : Double) -> MlneuralmlpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpView::min(self : MlneuralmlpView) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpView::max(self : MlneuralmlpView) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpView::to_string(self : MlneuralmlpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_range_make(size : Int) -> MlneuralmlpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpRange::len(self : MlneuralmlpRange) -> Int { self.size }

pub fn MlneuralmlpRange::get(self : MlneuralmlpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpRange::set(self : MlneuralmlpRange, i : Int, v : Double) -> MlneuralmlpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpRange::sum(self : MlneuralmlpRange) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpRange::mean(self : MlneuralmlpRange) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpRange::scale(self : MlneuralmlpRange, f : Double) -> MlneuralmlpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpRange::add(self : MlneuralmlpRange, other : MlneuralmlpRange) -> MlneuralmlpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpRange::copy(self : MlneuralmlpRange) -> MlneuralmlpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpRange::fill(self : MlneuralmlpRange, v : Double) -> MlneuralmlpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpRange::min(self : MlneuralmlpRange) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpRange::max(self : MlneuralmlpRange) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpRange::to_string(self : MlneuralmlpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_slice_make(size : Int) -> MlneuralmlpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlneuralmlpSlice::len(self : MlneuralmlpSlice) -> Int { self.size }

pub fn MlneuralmlpSlice::get(self : MlneuralmlpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlneuralmlpSlice::set(self : MlneuralmlpSlice, i : Int, v : Double) -> MlneuralmlpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlneuralmlpSlice::sum(self : MlneuralmlpSlice) -> Double { @_common.sum(self.data) }

pub fn MlneuralmlpSlice::mean(self : MlneuralmlpSlice) -> Double { @_common.mean(self.data) }

pub fn MlneuralmlpSlice::scale(self : MlneuralmlpSlice, f : Double) -> MlneuralmlpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpSlice::add(self : MlneuralmlpSlice, other : MlneuralmlpSlice) -> MlneuralmlpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlneuralmlpSlice::copy(self : MlneuralmlpSlice) -> MlneuralmlpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpSlice::fill(self : MlneuralmlpSlice, v : Double) -> MlneuralmlpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlneuralmlpSlice::min(self : MlneuralmlpSlice) -> Double { @_common.min(self.data) }

pub fn MlneuralmlpSlice::max(self : MlneuralmlpSlice) -> Double { @_common.max(self.data) }

pub fn MlneuralmlpSlice::to_string(self : MlneuralmlpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

