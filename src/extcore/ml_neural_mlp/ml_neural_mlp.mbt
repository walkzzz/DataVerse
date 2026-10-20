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

pub fn ml_neural_mlp_frame_len(s : MlneuralmlpFrame) -> Int { s.size }

pub fn ml_neural_mlp_frame_get(s : MlneuralmlpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_frame_set(s : MlneuralmlpFrame, i : Int, v : Double) -> MlneuralmlpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_frame_sum(s : MlneuralmlpFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_frame_mean(s : MlneuralmlpFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_frame_scale(s : MlneuralmlpFrame, f : Double) -> MlneuralmlpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_frame_add(a : MlneuralmlpFrame, b : MlneuralmlpFrame) -> MlneuralmlpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_frame_copy(s : MlneuralmlpFrame) -> MlneuralmlpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_frame_fill(s : MlneuralmlpFrame, v : Double) -> MlneuralmlpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_frame_min(s : MlneuralmlpFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_frame_max(s : MlneuralmlpFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_frame_to_string(s : MlneuralmlpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_table_make(size : Int) -> MlneuralmlpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_table_len(s : MlneuralmlpTable) -> Int { s.size }

pub fn ml_neural_mlp_table_get(s : MlneuralmlpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_table_set(s : MlneuralmlpTable, i : Int, v : Double) -> MlneuralmlpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_table_sum(s : MlneuralmlpTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_table_mean(s : MlneuralmlpTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_table_scale(s : MlneuralmlpTable, f : Double) -> MlneuralmlpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_table_add(a : MlneuralmlpTable, b : MlneuralmlpTable) -> MlneuralmlpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_table_copy(s : MlneuralmlpTable) -> MlneuralmlpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_table_fill(s : MlneuralmlpTable, v : Double) -> MlneuralmlpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_table_min(s : MlneuralmlpTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_table_max(s : MlneuralmlpTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_table_to_string(s : MlneuralmlpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_graphn_make(size : Int) -> MlneuralmlpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_graphn_len(s : MlneuralmlpGraphN) -> Int { s.size }

pub fn ml_neural_mlp_graphn_get(s : MlneuralmlpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_graphn_set(s : MlneuralmlpGraphN, i : Int, v : Double) -> MlneuralmlpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_graphn_sum(s : MlneuralmlpGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_graphn_mean(s : MlneuralmlpGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_graphn_scale(s : MlneuralmlpGraphN, f : Double) -> MlneuralmlpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_graphn_add(a : MlneuralmlpGraphN, b : MlneuralmlpGraphN) -> MlneuralmlpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_graphn_copy(s : MlneuralmlpGraphN) -> MlneuralmlpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_graphn_fill(s : MlneuralmlpGraphN, v : Double) -> MlneuralmlpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_graphn_min(s : MlneuralmlpGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_graphn_max(s : MlneuralmlpGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_graphn_to_string(s : MlneuralmlpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_node_make(size : Int) -> MlneuralmlpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_node_len(s : MlneuralmlpNode) -> Int { s.size }

pub fn ml_neural_mlp_node_get(s : MlneuralmlpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_node_set(s : MlneuralmlpNode, i : Int, v : Double) -> MlneuralmlpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_node_sum(s : MlneuralmlpNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_node_mean(s : MlneuralmlpNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_node_scale(s : MlneuralmlpNode, f : Double) -> MlneuralmlpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_node_add(a : MlneuralmlpNode, b : MlneuralmlpNode) -> MlneuralmlpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_node_copy(s : MlneuralmlpNode) -> MlneuralmlpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_node_fill(s : MlneuralmlpNode, v : Double) -> MlneuralmlpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_node_min(s : MlneuralmlpNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_node_max(s : MlneuralmlpNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_node_to_string(s : MlneuralmlpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_edge_make(size : Int) -> MlneuralmlpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_edge_len(s : MlneuralmlpEdge) -> Int { s.size }

pub fn ml_neural_mlp_edge_get(s : MlneuralmlpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_edge_set(s : MlneuralmlpEdge, i : Int, v : Double) -> MlneuralmlpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_edge_sum(s : MlneuralmlpEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_edge_mean(s : MlneuralmlpEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_edge_scale(s : MlneuralmlpEdge, f : Double) -> MlneuralmlpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_edge_add(a : MlneuralmlpEdge, b : MlneuralmlpEdge) -> MlneuralmlpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_edge_copy(s : MlneuralmlpEdge) -> MlneuralmlpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_edge_fill(s : MlneuralmlpEdge, v : Double) -> MlneuralmlpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_edge_min(s : MlneuralmlpEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_edge_max(s : MlneuralmlpEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_edge_to_string(s : MlneuralmlpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_path_make(size : Int) -> MlneuralmlpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_path_len(s : MlneuralmlpPath) -> Int { s.size }

pub fn ml_neural_mlp_path_get(s : MlneuralmlpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_path_set(s : MlneuralmlpPath, i : Int, v : Double) -> MlneuralmlpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_path_sum(s : MlneuralmlpPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_path_mean(s : MlneuralmlpPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_path_scale(s : MlneuralmlpPath, f : Double) -> MlneuralmlpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_path_add(a : MlneuralmlpPath, b : MlneuralmlpPath) -> MlneuralmlpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_path_copy(s : MlneuralmlpPath) -> MlneuralmlpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_path_fill(s : MlneuralmlpPath, v : Double) -> MlneuralmlpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_path_min(s : MlneuralmlpPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_path_max(s : MlneuralmlpPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_path_to_string(s : MlneuralmlpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_cluster_make(size : Int) -> MlneuralmlpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_cluster_len(s : MlneuralmlpCluster) -> Int { s.size }

pub fn ml_neural_mlp_cluster_get(s : MlneuralmlpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_cluster_set(s : MlneuralmlpCluster, i : Int, v : Double) -> MlneuralmlpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cluster_sum(s : MlneuralmlpCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_cluster_mean(s : MlneuralmlpCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_cluster_scale(s : MlneuralmlpCluster, f : Double) -> MlneuralmlpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cluster_add(a : MlneuralmlpCluster, b : MlneuralmlpCluster) -> MlneuralmlpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_cluster_copy(s : MlneuralmlpCluster) -> MlneuralmlpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cluster_fill(s : MlneuralmlpCluster, v : Double) -> MlneuralmlpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cluster_min(s : MlneuralmlpCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_cluster_max(s : MlneuralmlpCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_cluster_to_string(s : MlneuralmlpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_model_make(size : Int) -> MlneuralmlpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_model_len(s : MlneuralmlpModel) -> Int { s.size }

pub fn ml_neural_mlp_model_get(s : MlneuralmlpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_model_set(s : MlneuralmlpModel, i : Int, v : Double) -> MlneuralmlpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_model_sum(s : MlneuralmlpModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_model_mean(s : MlneuralmlpModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_model_scale(s : MlneuralmlpModel, f : Double) -> MlneuralmlpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_model_add(a : MlneuralmlpModel, b : MlneuralmlpModel) -> MlneuralmlpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_model_copy(s : MlneuralmlpModel) -> MlneuralmlpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_model_fill(s : MlneuralmlpModel, v : Double) -> MlneuralmlpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_model_min(s : MlneuralmlpModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_model_max(s : MlneuralmlpModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_model_to_string(s : MlneuralmlpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_layer_make(size : Int) -> MlneuralmlpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_layer_len(s : MlneuralmlpLayer) -> Int { s.size }

pub fn ml_neural_mlp_layer_get(s : MlneuralmlpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_layer_set(s : MlneuralmlpLayer, i : Int, v : Double) -> MlneuralmlpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_layer_sum(s : MlneuralmlpLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_layer_mean(s : MlneuralmlpLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_layer_scale(s : MlneuralmlpLayer, f : Double) -> MlneuralmlpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_layer_add(a : MlneuralmlpLayer, b : MlneuralmlpLayer) -> MlneuralmlpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_layer_copy(s : MlneuralmlpLayer) -> MlneuralmlpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_layer_fill(s : MlneuralmlpLayer, v : Double) -> MlneuralmlpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_layer_min(s : MlneuralmlpLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_layer_max(s : MlneuralmlpLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_layer_to_string(s : MlneuralmlpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_buffer_make(size : Int) -> MlneuralmlpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_buffer_len(s : MlneuralmlpBuffer) -> Int { s.size }

pub fn ml_neural_mlp_buffer_get(s : MlneuralmlpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_buffer_set(s : MlneuralmlpBuffer, i : Int, v : Double) -> MlneuralmlpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_buffer_sum(s : MlneuralmlpBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_buffer_mean(s : MlneuralmlpBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_buffer_scale(s : MlneuralmlpBuffer, f : Double) -> MlneuralmlpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_buffer_add(a : MlneuralmlpBuffer, b : MlneuralmlpBuffer) -> MlneuralmlpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_buffer_copy(s : MlneuralmlpBuffer) -> MlneuralmlpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_buffer_fill(s : MlneuralmlpBuffer, v : Double) -> MlneuralmlpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_buffer_min(s : MlneuralmlpBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_buffer_max(s : MlneuralmlpBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_buffer_to_string(s : MlneuralmlpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_cursor_make(size : Int) -> MlneuralmlpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_cursor_len(s : MlneuralmlpCursor) -> Int { s.size }

pub fn ml_neural_mlp_cursor_get(s : MlneuralmlpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_cursor_set(s : MlneuralmlpCursor, i : Int, v : Double) -> MlneuralmlpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cursor_sum(s : MlneuralmlpCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_cursor_mean(s : MlneuralmlpCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_cursor_scale(s : MlneuralmlpCursor, f : Double) -> MlneuralmlpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cursor_add(a : MlneuralmlpCursor, b : MlneuralmlpCursor) -> MlneuralmlpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_cursor_copy(s : MlneuralmlpCursor) -> MlneuralmlpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cursor_fill(s : MlneuralmlpCursor, v : Double) -> MlneuralmlpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_cursor_min(s : MlneuralmlpCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_cursor_max(s : MlneuralmlpCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_cursor_to_string(s : MlneuralmlpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_view_make(size : Int) -> MlneuralmlpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_view_len(s : MlneuralmlpView) -> Int { s.size }

pub fn ml_neural_mlp_view_get(s : MlneuralmlpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_view_set(s : MlneuralmlpView, i : Int, v : Double) -> MlneuralmlpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_view_sum(s : MlneuralmlpView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_view_mean(s : MlneuralmlpView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_view_scale(s : MlneuralmlpView, f : Double) -> MlneuralmlpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_view_add(a : MlneuralmlpView, b : MlneuralmlpView) -> MlneuralmlpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_view_copy(s : MlneuralmlpView) -> MlneuralmlpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_view_fill(s : MlneuralmlpView, v : Double) -> MlneuralmlpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_view_min(s : MlneuralmlpView) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_view_max(s : MlneuralmlpView) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_view_to_string(s : MlneuralmlpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_range_make(size : Int) -> MlneuralmlpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_range_len(s : MlneuralmlpRange) -> Int { s.size }

pub fn ml_neural_mlp_range_get(s : MlneuralmlpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_range_set(s : MlneuralmlpRange, i : Int, v : Double) -> MlneuralmlpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_range_sum(s : MlneuralmlpRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_range_mean(s : MlneuralmlpRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_range_scale(s : MlneuralmlpRange, f : Double) -> MlneuralmlpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_range_add(a : MlneuralmlpRange, b : MlneuralmlpRange) -> MlneuralmlpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_range_copy(s : MlneuralmlpRange) -> MlneuralmlpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_range_fill(s : MlneuralmlpRange, v : Double) -> MlneuralmlpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_range_min(s : MlneuralmlpRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_range_max(s : MlneuralmlpRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_range_to_string(s : MlneuralmlpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralmlpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_mlp_slice_make(size : Int) -> MlneuralmlpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_mlp_slice_len(s : MlneuralmlpSlice) -> Int { s.size }

pub fn ml_neural_mlp_slice_get(s : MlneuralmlpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_mlp_slice_set(s : MlneuralmlpSlice, i : Int, v : Double) -> MlneuralmlpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_slice_sum(s : MlneuralmlpSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_mlp_slice_mean(s : MlneuralmlpSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_mlp_slice_scale(s : MlneuralmlpSlice, f : Double) -> MlneuralmlpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_slice_add(a : MlneuralmlpSlice, b : MlneuralmlpSlice) -> MlneuralmlpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_mlp_slice_copy(s : MlneuralmlpSlice) -> MlneuralmlpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_slice_fill(s : MlneuralmlpSlice, v : Double) -> MlneuralmlpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_mlp_slice_min(s : MlneuralmlpSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_mlp_slice_max(s : MlneuralmlpSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_mlp_slice_to_string(s : MlneuralmlpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

