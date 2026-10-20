///===
/// extcore/ml_neural_gru

pub(all) struct MlneuralgruPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_gru_make_point(x : Double, y : Double) -> MlneuralgruPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_gru_make_point3(x : Double, y : Double, z : Double) -> MlneuralgruPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralgruPoint::x(self : MlneuralgruPoint) -> Double { self.x }

pub fn MlneuralgruPoint::y(self : MlneuralgruPoint) -> Double { self.y }

pub fn MlneuralgruPoint::z(self : MlneuralgruPoint) -> Double { self.z }

pub fn MlneuralgruPoint::label(self : MlneuralgruPoint) -> Int { self.label }

pub fn MlneuralgruPoint::dist(self : MlneuralgruPoint, other : MlneuralgruPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralgruPoint::add(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralgruPoint::sub(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralgruPoint::scale(self : MlneuralgruPoint, s : Double) -> MlneuralgruPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralgruPoint::dot(self : MlneuralgruPoint, other : MlneuralgruPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralgruPoint::cross(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralgruPoint::norm(self : MlneuralgruPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralgruPoint::normalize(self : MlneuralgruPoint) -> MlneuralgruPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralgruPoint::negate(self : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralgruPoint::mid(self : MlneuralgruPoint, other : MlneuralgruPoint) -> MlneuralgruPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralgruPoint::lerp(self : MlneuralgruPoint, other : MlneuralgruPoint, t : Double) -> MlneuralgruPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralgruPoint::to_string(self : MlneuralgruPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralgruSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_gru_make_series(vals : Array[Double], name : String) -> MlneuralgruSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralgruSeries::len(self : MlneuralgruSeries) -> Int { self.vals.length() }

pub fn MlneuralgruSeries::sum(self : MlneuralgruSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralgruSeries::mean(self : MlneuralgruSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralgruSeries::min(self : MlneuralgruSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralgruSeries::max(self : MlneuralgruSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralgruSeries::range(self : MlneuralgruSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralgruSeries::variance(self : MlneuralgruSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralgruSeries::std(self : MlneuralgruSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralgruSeries::median(self : MlneuralgruSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralgruSeries::scale(self : MlneuralgruSeries, f : Double) -> MlneuralgruSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralgruSeries::add(self : MlneuralgruSeries, other : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralgruSeries::sub(self : MlneuralgruSeries, other : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralgruSeries::normalize(self : MlneuralgruSeries) -> MlneuralgruSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralgruSeries::cumsum(self : MlneuralgruSeries) -> MlneuralgruSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralgruSeries::to_string(self : MlneuralgruSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralgruMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_gru_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralgruMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_gru_matrix_identity(n : Int) -> MlneuralgruMatrix {
  let m = ml_neural_gru_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralgruMatrix::get(self : MlneuralgruMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralgruMatrix::transpose(self : MlneuralgruMatrix) -> MlneuralgruMatrix {
  let result = ml_neural_gru_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralgruMatrix::add(self : MlneuralgruMatrix, other : MlneuralgruMatrix) -> MlneuralgruMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_gru_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralgruMatrix::scale(self : MlneuralgruMatrix, s : Double) -> MlneuralgruMatrix {
  let result = ml_neural_gru_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralgruMatrix::multiply(self : MlneuralgruMatrix, other : MlneuralgruMatrix) -> MlneuralgruMatrix {
  if self.cols != other.rows { return ml_neural_gru_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_gru_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralgruMatrix::trace(self : MlneuralgruMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralgruMatrix::det(self : MlneuralgruMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralgruMatrix::norm(self : MlneuralgruMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralgruMatrix::to_string(self : MlneuralgruMatrix) -> String {
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

pub(all) struct MlneuralgruVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_gru_make_vector(comps : Array[Double]) -> MlneuralgruVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_gru_vector_zero(dim : Int) -> MlneuralgruVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralgruVector::add(self : MlneuralgruVector, other : MlneuralgruVector) -> MlneuralgruVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralgruVector::sub(self : MlneuralgruVector, other : MlneuralgruVector) -> MlneuralgruVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralgruVector::scale(self : MlneuralgruVector, s : Double) -> MlneuralgruVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralgruVector::dot(self : MlneuralgruVector, other : MlneuralgruVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralgruVector::norm(self : MlneuralgruVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralgruVector::normalize(self : MlneuralgruVector) -> MlneuralgruVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralgruVector::dist(self : MlneuralgruVector, other : MlneuralgruVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralgruVector::to_string(self : MlneuralgruVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_gru_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_gru_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_gru_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_gru_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_gru_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_gru_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_gru_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_gru_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_gru_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_gru_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_gru_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_gru_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_gru_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_gru_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_gru_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_gru_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_gru_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_gru_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_gru_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_gru_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_gru_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_gru_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_gru_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_gru_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_gru_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_gru_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_gru_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_gru_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_gru_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralgruFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_frame_make(size : Int) -> MlneuralgruFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_frame_len(s : MlneuralgruFrame) -> Int { s.size }

pub fn ml_neural_gru_frame_get(s : MlneuralgruFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_frame_set(s : MlneuralgruFrame, i : Int, v : Double) -> MlneuralgruFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_sum(s : MlneuralgruFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_frame_mean(s : MlneuralgruFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_frame_scale(s : MlneuralgruFrame, f : Double) -> MlneuralgruFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_add(a : MlneuralgruFrame, b : MlneuralgruFrame) -> MlneuralgruFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_frame_copy(s : MlneuralgruFrame) -> MlneuralgruFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_fill(s : MlneuralgruFrame, v : Double) -> MlneuralgruFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_frame_min(s : MlneuralgruFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_frame_max(s : MlneuralgruFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_frame_to_string(s : MlneuralgruFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_table_make(size : Int) -> MlneuralgruTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_table_len(s : MlneuralgruTable) -> Int { s.size }

pub fn ml_neural_gru_table_get(s : MlneuralgruTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_table_set(s : MlneuralgruTable, i : Int, v : Double) -> MlneuralgruTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_sum(s : MlneuralgruTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_table_mean(s : MlneuralgruTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_table_scale(s : MlneuralgruTable, f : Double) -> MlneuralgruTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_add(a : MlneuralgruTable, b : MlneuralgruTable) -> MlneuralgruTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_table_copy(s : MlneuralgruTable) -> MlneuralgruTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_fill(s : MlneuralgruTable, v : Double) -> MlneuralgruTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_table_min(s : MlneuralgruTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_table_max(s : MlneuralgruTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_table_to_string(s : MlneuralgruTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_graphn_make(size : Int) -> MlneuralgruGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_graphn_len(s : MlneuralgruGraphN) -> Int { s.size }

pub fn ml_neural_gru_graphn_get(s : MlneuralgruGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_graphn_set(s : MlneuralgruGraphN, i : Int, v : Double) -> MlneuralgruGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_sum(s : MlneuralgruGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_graphn_mean(s : MlneuralgruGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_graphn_scale(s : MlneuralgruGraphN, f : Double) -> MlneuralgruGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_add(a : MlneuralgruGraphN, b : MlneuralgruGraphN) -> MlneuralgruGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_graphn_copy(s : MlneuralgruGraphN) -> MlneuralgruGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_fill(s : MlneuralgruGraphN, v : Double) -> MlneuralgruGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_graphn_min(s : MlneuralgruGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_graphn_max(s : MlneuralgruGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_graphn_to_string(s : MlneuralgruGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_node_make(size : Int) -> MlneuralgruNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_node_len(s : MlneuralgruNode) -> Int { s.size }

pub fn ml_neural_gru_node_get(s : MlneuralgruNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_node_set(s : MlneuralgruNode, i : Int, v : Double) -> MlneuralgruNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_sum(s : MlneuralgruNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_node_mean(s : MlneuralgruNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_node_scale(s : MlneuralgruNode, f : Double) -> MlneuralgruNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_add(a : MlneuralgruNode, b : MlneuralgruNode) -> MlneuralgruNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_node_copy(s : MlneuralgruNode) -> MlneuralgruNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_fill(s : MlneuralgruNode, v : Double) -> MlneuralgruNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_node_min(s : MlneuralgruNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_node_max(s : MlneuralgruNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_node_to_string(s : MlneuralgruNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_edge_make(size : Int) -> MlneuralgruEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_edge_len(s : MlneuralgruEdge) -> Int { s.size }

pub fn ml_neural_gru_edge_get(s : MlneuralgruEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_edge_set(s : MlneuralgruEdge, i : Int, v : Double) -> MlneuralgruEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_sum(s : MlneuralgruEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_edge_mean(s : MlneuralgruEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_edge_scale(s : MlneuralgruEdge, f : Double) -> MlneuralgruEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_add(a : MlneuralgruEdge, b : MlneuralgruEdge) -> MlneuralgruEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_edge_copy(s : MlneuralgruEdge) -> MlneuralgruEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_fill(s : MlneuralgruEdge, v : Double) -> MlneuralgruEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_edge_min(s : MlneuralgruEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_edge_max(s : MlneuralgruEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_edge_to_string(s : MlneuralgruEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_path_make(size : Int) -> MlneuralgruPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_path_len(s : MlneuralgruPath) -> Int { s.size }

pub fn ml_neural_gru_path_get(s : MlneuralgruPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_path_set(s : MlneuralgruPath, i : Int, v : Double) -> MlneuralgruPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_sum(s : MlneuralgruPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_path_mean(s : MlneuralgruPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_path_scale(s : MlneuralgruPath, f : Double) -> MlneuralgruPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_add(a : MlneuralgruPath, b : MlneuralgruPath) -> MlneuralgruPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_path_copy(s : MlneuralgruPath) -> MlneuralgruPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_fill(s : MlneuralgruPath, v : Double) -> MlneuralgruPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_path_min(s : MlneuralgruPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_path_max(s : MlneuralgruPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_path_to_string(s : MlneuralgruPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_cluster_make(size : Int) -> MlneuralgruCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_cluster_len(s : MlneuralgruCluster) -> Int { s.size }

pub fn ml_neural_gru_cluster_get(s : MlneuralgruCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_cluster_set(s : MlneuralgruCluster, i : Int, v : Double) -> MlneuralgruCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_sum(s : MlneuralgruCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_cluster_mean(s : MlneuralgruCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_cluster_scale(s : MlneuralgruCluster, f : Double) -> MlneuralgruCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_add(a : MlneuralgruCluster, b : MlneuralgruCluster) -> MlneuralgruCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_cluster_copy(s : MlneuralgruCluster) -> MlneuralgruCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_fill(s : MlneuralgruCluster, v : Double) -> MlneuralgruCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cluster_min(s : MlneuralgruCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_cluster_max(s : MlneuralgruCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_cluster_to_string(s : MlneuralgruCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_model_make(size : Int) -> MlneuralgruModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_model_len(s : MlneuralgruModel) -> Int { s.size }

pub fn ml_neural_gru_model_get(s : MlneuralgruModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_model_set(s : MlneuralgruModel, i : Int, v : Double) -> MlneuralgruModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_sum(s : MlneuralgruModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_model_mean(s : MlneuralgruModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_model_scale(s : MlneuralgruModel, f : Double) -> MlneuralgruModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_add(a : MlneuralgruModel, b : MlneuralgruModel) -> MlneuralgruModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_model_copy(s : MlneuralgruModel) -> MlneuralgruModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_fill(s : MlneuralgruModel, v : Double) -> MlneuralgruModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_model_min(s : MlneuralgruModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_model_max(s : MlneuralgruModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_model_to_string(s : MlneuralgruModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_layer_make(size : Int) -> MlneuralgruLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_layer_len(s : MlneuralgruLayer) -> Int { s.size }

pub fn ml_neural_gru_layer_get(s : MlneuralgruLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_layer_set(s : MlneuralgruLayer, i : Int, v : Double) -> MlneuralgruLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_sum(s : MlneuralgruLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_layer_mean(s : MlneuralgruLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_layer_scale(s : MlneuralgruLayer, f : Double) -> MlneuralgruLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_add(a : MlneuralgruLayer, b : MlneuralgruLayer) -> MlneuralgruLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_layer_copy(s : MlneuralgruLayer) -> MlneuralgruLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_fill(s : MlneuralgruLayer, v : Double) -> MlneuralgruLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_layer_min(s : MlneuralgruLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_layer_max(s : MlneuralgruLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_layer_to_string(s : MlneuralgruLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_buffer_make(size : Int) -> MlneuralgruBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_buffer_len(s : MlneuralgruBuffer) -> Int { s.size }

pub fn ml_neural_gru_buffer_get(s : MlneuralgruBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_buffer_set(s : MlneuralgruBuffer, i : Int, v : Double) -> MlneuralgruBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_sum(s : MlneuralgruBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_buffer_mean(s : MlneuralgruBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_buffer_scale(s : MlneuralgruBuffer, f : Double) -> MlneuralgruBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_add(a : MlneuralgruBuffer, b : MlneuralgruBuffer) -> MlneuralgruBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_buffer_copy(s : MlneuralgruBuffer) -> MlneuralgruBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_fill(s : MlneuralgruBuffer, v : Double) -> MlneuralgruBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_buffer_min(s : MlneuralgruBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_buffer_max(s : MlneuralgruBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_buffer_to_string(s : MlneuralgruBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_cursor_make(size : Int) -> MlneuralgruCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_cursor_len(s : MlneuralgruCursor) -> Int { s.size }

pub fn ml_neural_gru_cursor_get(s : MlneuralgruCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_cursor_set(s : MlneuralgruCursor, i : Int, v : Double) -> MlneuralgruCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_sum(s : MlneuralgruCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_cursor_mean(s : MlneuralgruCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_cursor_scale(s : MlneuralgruCursor, f : Double) -> MlneuralgruCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_add(a : MlneuralgruCursor, b : MlneuralgruCursor) -> MlneuralgruCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_cursor_copy(s : MlneuralgruCursor) -> MlneuralgruCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_fill(s : MlneuralgruCursor, v : Double) -> MlneuralgruCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_cursor_min(s : MlneuralgruCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_cursor_max(s : MlneuralgruCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_cursor_to_string(s : MlneuralgruCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_view_make(size : Int) -> MlneuralgruView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_view_len(s : MlneuralgruView) -> Int { s.size }

pub fn ml_neural_gru_view_get(s : MlneuralgruView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_view_set(s : MlneuralgruView, i : Int, v : Double) -> MlneuralgruView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_sum(s : MlneuralgruView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_view_mean(s : MlneuralgruView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_view_scale(s : MlneuralgruView, f : Double) -> MlneuralgruView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_add(a : MlneuralgruView, b : MlneuralgruView) -> MlneuralgruView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_view_copy(s : MlneuralgruView) -> MlneuralgruView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_fill(s : MlneuralgruView, v : Double) -> MlneuralgruView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_view_min(s : MlneuralgruView) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_view_max(s : MlneuralgruView) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_view_to_string(s : MlneuralgruView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_range_make(size : Int) -> MlneuralgruRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_range_len(s : MlneuralgruRange) -> Int { s.size }

pub fn ml_neural_gru_range_get(s : MlneuralgruRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_range_set(s : MlneuralgruRange, i : Int, v : Double) -> MlneuralgruRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_sum(s : MlneuralgruRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_range_mean(s : MlneuralgruRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_range_scale(s : MlneuralgruRange, f : Double) -> MlneuralgruRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_add(a : MlneuralgruRange, b : MlneuralgruRange) -> MlneuralgruRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_range_copy(s : MlneuralgruRange) -> MlneuralgruRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_fill(s : MlneuralgruRange, v : Double) -> MlneuralgruRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_range_min(s : MlneuralgruRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_range_max(s : MlneuralgruRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_range_to_string(s : MlneuralgruRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralgruSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gru_slice_make(size : Int) -> MlneuralgruSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gru_slice_len(s : MlneuralgruSlice) -> Int { s.size }

pub fn ml_neural_gru_slice_get(s : MlneuralgruSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gru_slice_set(s : MlneuralgruSlice, i : Int, v : Double) -> MlneuralgruSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_sum(s : MlneuralgruSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gru_slice_mean(s : MlneuralgruSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gru_slice_scale(s : MlneuralgruSlice, f : Double) -> MlneuralgruSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_add(a : MlneuralgruSlice, b : MlneuralgruSlice) -> MlneuralgruSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gru_slice_copy(s : MlneuralgruSlice) -> MlneuralgruSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_fill(s : MlneuralgruSlice, v : Double) -> MlneuralgruSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gru_slice_min(s : MlneuralgruSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_gru_slice_max(s : MlneuralgruSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_gru_slice_to_string(s : MlneuralgruSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

