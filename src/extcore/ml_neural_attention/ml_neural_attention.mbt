///===
/// extcore/ml_neural_attention

pub(all) struct MlneuralattentionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_attention_make_point(x : Double, y : Double) -> MlneuralattentionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_attention_make_point3(x : Double, y : Double, z : Double) -> MlneuralattentionPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralattentionPoint::x(self : MlneuralattentionPoint) -> Double { self.x }

pub fn MlneuralattentionPoint::y(self : MlneuralattentionPoint) -> Double { self.y }

pub fn MlneuralattentionPoint::z(self : MlneuralattentionPoint) -> Double { self.z }

pub fn MlneuralattentionPoint::label(self : MlneuralattentionPoint) -> Int { self.label }

pub fn MlneuralattentionPoint::dist(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralattentionPoint::add(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralattentionPoint::sub(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralattentionPoint::scale(self : MlneuralattentionPoint, s : Double) -> MlneuralattentionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralattentionPoint::dot(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralattentionPoint::cross(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralattentionPoint::norm(self : MlneuralattentionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralattentionPoint::normalize(self : MlneuralattentionPoint) -> MlneuralattentionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralattentionPoint::negate(self : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralattentionPoint::mid(self : MlneuralattentionPoint, other : MlneuralattentionPoint) -> MlneuralattentionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralattentionPoint::lerp(self : MlneuralattentionPoint, other : MlneuralattentionPoint, t : Double) -> MlneuralattentionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralattentionPoint::to_string(self : MlneuralattentionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralattentionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_attention_make_series(vals : Array[Double], name : String) -> MlneuralattentionSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralattentionSeries::len(self : MlneuralattentionSeries) -> Int { self.vals.length() }

pub fn MlneuralattentionSeries::sum(self : MlneuralattentionSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralattentionSeries::mean(self : MlneuralattentionSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralattentionSeries::min(self : MlneuralattentionSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralattentionSeries::max(self : MlneuralattentionSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralattentionSeries::range(self : MlneuralattentionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralattentionSeries::variance(self : MlneuralattentionSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralattentionSeries::std(self : MlneuralattentionSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralattentionSeries::median(self : MlneuralattentionSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralattentionSeries::scale(self : MlneuralattentionSeries, f : Double) -> MlneuralattentionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralattentionSeries::add(self : MlneuralattentionSeries, other : MlneuralattentionSeries) -> MlneuralattentionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralattentionSeries::sub(self : MlneuralattentionSeries, other : MlneuralattentionSeries) -> MlneuralattentionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralattentionSeries::normalize(self : MlneuralattentionSeries) -> MlneuralattentionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralattentionSeries::cumsum(self : MlneuralattentionSeries) -> MlneuralattentionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralattentionSeries::to_string(self : MlneuralattentionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralattentionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_attention_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralattentionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_attention_matrix_identity(n : Int) -> MlneuralattentionMatrix {
  let m = ml_neural_attention_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralattentionMatrix::get(self : MlneuralattentionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralattentionMatrix::transpose(self : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  let result = ml_neural_attention_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralattentionMatrix::add(self : MlneuralattentionMatrix, other : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_attention_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralattentionMatrix::scale(self : MlneuralattentionMatrix, s : Double) -> MlneuralattentionMatrix {
  let result = ml_neural_attention_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralattentionMatrix::multiply(self : MlneuralattentionMatrix, other : MlneuralattentionMatrix) -> MlneuralattentionMatrix {
  if self.cols != other.rows { return ml_neural_attention_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_attention_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralattentionMatrix::trace(self : MlneuralattentionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralattentionMatrix::det(self : MlneuralattentionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralattentionMatrix::norm(self : MlneuralattentionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralattentionMatrix::to_string(self : MlneuralattentionMatrix) -> String {
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

pub(all) struct MlneuralattentionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_attention_make_vector(comps : Array[Double]) -> MlneuralattentionVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_attention_vector_zero(dim : Int) -> MlneuralattentionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralattentionVector::add(self : MlneuralattentionVector, other : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralattentionVector::sub(self : MlneuralattentionVector, other : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralattentionVector::scale(self : MlneuralattentionVector, s : Double) -> MlneuralattentionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralattentionVector::dot(self : MlneuralattentionVector, other : MlneuralattentionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralattentionVector::norm(self : MlneuralattentionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralattentionVector::normalize(self : MlneuralattentionVector) -> MlneuralattentionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralattentionVector::dist(self : MlneuralattentionVector, other : MlneuralattentionVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralattentionVector::to_string(self : MlneuralattentionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_attention_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_attention_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_attention_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_attention_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_attention_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_attention_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_attention_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_attention_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_attention_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_attention_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_attention_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_attention_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_attention_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_attention_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_attention_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_attention_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_attention_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_attention_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_attention_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_attention_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_attention_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_attention_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_attention_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_attention_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_attention_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_attention_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_attention_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_attention_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_attention_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralattentionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_frame_make(size : Int) -> MlneuralattentionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_frame_len(s : MlneuralattentionFrame) -> Int { s.size }

pub fn ml_neural_attention_frame_get(s : MlneuralattentionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_frame_set(s : MlneuralattentionFrame, i : Int, v : Double) -> MlneuralattentionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_frame_sum(s : MlneuralattentionFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_frame_mean(s : MlneuralattentionFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_frame_scale(s : MlneuralattentionFrame, f : Double) -> MlneuralattentionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_frame_add(a : MlneuralattentionFrame, b : MlneuralattentionFrame) -> MlneuralattentionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_frame_copy(s : MlneuralattentionFrame) -> MlneuralattentionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_frame_fill(s : MlneuralattentionFrame, v : Double) -> MlneuralattentionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_frame_min(s : MlneuralattentionFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_frame_max(s : MlneuralattentionFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_frame_to_string(s : MlneuralattentionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_table_make(size : Int) -> MlneuralattentionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_table_len(s : MlneuralattentionTable) -> Int { s.size }

pub fn ml_neural_attention_table_get(s : MlneuralattentionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_table_set(s : MlneuralattentionTable, i : Int, v : Double) -> MlneuralattentionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_table_sum(s : MlneuralattentionTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_table_mean(s : MlneuralattentionTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_table_scale(s : MlneuralattentionTable, f : Double) -> MlneuralattentionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_table_add(a : MlneuralattentionTable, b : MlneuralattentionTable) -> MlneuralattentionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_table_copy(s : MlneuralattentionTable) -> MlneuralattentionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_table_fill(s : MlneuralattentionTable, v : Double) -> MlneuralattentionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_table_min(s : MlneuralattentionTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_table_max(s : MlneuralattentionTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_table_to_string(s : MlneuralattentionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_graphn_make(size : Int) -> MlneuralattentionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_graphn_len(s : MlneuralattentionGraphN) -> Int { s.size }

pub fn ml_neural_attention_graphn_get(s : MlneuralattentionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_graphn_set(s : MlneuralattentionGraphN, i : Int, v : Double) -> MlneuralattentionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_graphn_sum(s : MlneuralattentionGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_graphn_mean(s : MlneuralattentionGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_graphn_scale(s : MlneuralattentionGraphN, f : Double) -> MlneuralattentionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_graphn_add(a : MlneuralattentionGraphN, b : MlneuralattentionGraphN) -> MlneuralattentionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_graphn_copy(s : MlneuralattentionGraphN) -> MlneuralattentionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_graphn_fill(s : MlneuralattentionGraphN, v : Double) -> MlneuralattentionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_graphn_min(s : MlneuralattentionGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_graphn_max(s : MlneuralattentionGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_graphn_to_string(s : MlneuralattentionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_node_make(size : Int) -> MlneuralattentionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_node_len(s : MlneuralattentionNode) -> Int { s.size }

pub fn ml_neural_attention_node_get(s : MlneuralattentionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_node_set(s : MlneuralattentionNode, i : Int, v : Double) -> MlneuralattentionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_node_sum(s : MlneuralattentionNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_node_mean(s : MlneuralattentionNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_node_scale(s : MlneuralattentionNode, f : Double) -> MlneuralattentionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_node_add(a : MlneuralattentionNode, b : MlneuralattentionNode) -> MlneuralattentionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_node_copy(s : MlneuralattentionNode) -> MlneuralattentionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_node_fill(s : MlneuralattentionNode, v : Double) -> MlneuralattentionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_node_min(s : MlneuralattentionNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_node_max(s : MlneuralattentionNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_node_to_string(s : MlneuralattentionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_edge_make(size : Int) -> MlneuralattentionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_edge_len(s : MlneuralattentionEdge) -> Int { s.size }

pub fn ml_neural_attention_edge_get(s : MlneuralattentionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_edge_set(s : MlneuralattentionEdge, i : Int, v : Double) -> MlneuralattentionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_edge_sum(s : MlneuralattentionEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_edge_mean(s : MlneuralattentionEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_edge_scale(s : MlneuralattentionEdge, f : Double) -> MlneuralattentionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_edge_add(a : MlneuralattentionEdge, b : MlneuralattentionEdge) -> MlneuralattentionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_edge_copy(s : MlneuralattentionEdge) -> MlneuralattentionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_edge_fill(s : MlneuralattentionEdge, v : Double) -> MlneuralattentionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_edge_min(s : MlneuralattentionEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_edge_max(s : MlneuralattentionEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_edge_to_string(s : MlneuralattentionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_path_make(size : Int) -> MlneuralattentionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_path_len(s : MlneuralattentionPath) -> Int { s.size }

pub fn ml_neural_attention_path_get(s : MlneuralattentionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_path_set(s : MlneuralattentionPath, i : Int, v : Double) -> MlneuralattentionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_path_sum(s : MlneuralattentionPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_path_mean(s : MlneuralattentionPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_path_scale(s : MlneuralattentionPath, f : Double) -> MlneuralattentionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_path_add(a : MlneuralattentionPath, b : MlneuralattentionPath) -> MlneuralattentionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_path_copy(s : MlneuralattentionPath) -> MlneuralattentionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_path_fill(s : MlneuralattentionPath, v : Double) -> MlneuralattentionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_path_min(s : MlneuralattentionPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_path_max(s : MlneuralattentionPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_path_to_string(s : MlneuralattentionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_cluster_make(size : Int) -> MlneuralattentionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_cluster_len(s : MlneuralattentionCluster) -> Int { s.size }

pub fn ml_neural_attention_cluster_get(s : MlneuralattentionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_cluster_set(s : MlneuralattentionCluster, i : Int, v : Double) -> MlneuralattentionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cluster_sum(s : MlneuralattentionCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_cluster_mean(s : MlneuralattentionCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_cluster_scale(s : MlneuralattentionCluster, f : Double) -> MlneuralattentionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cluster_add(a : MlneuralattentionCluster, b : MlneuralattentionCluster) -> MlneuralattentionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_cluster_copy(s : MlneuralattentionCluster) -> MlneuralattentionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cluster_fill(s : MlneuralattentionCluster, v : Double) -> MlneuralattentionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cluster_min(s : MlneuralattentionCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_cluster_max(s : MlneuralattentionCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_cluster_to_string(s : MlneuralattentionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_model_make(size : Int) -> MlneuralattentionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_model_len(s : MlneuralattentionModel) -> Int { s.size }

pub fn ml_neural_attention_model_get(s : MlneuralattentionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_model_set(s : MlneuralattentionModel, i : Int, v : Double) -> MlneuralattentionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_model_sum(s : MlneuralattentionModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_model_mean(s : MlneuralattentionModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_model_scale(s : MlneuralattentionModel, f : Double) -> MlneuralattentionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_model_add(a : MlneuralattentionModel, b : MlneuralattentionModel) -> MlneuralattentionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_model_copy(s : MlneuralattentionModel) -> MlneuralattentionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_model_fill(s : MlneuralattentionModel, v : Double) -> MlneuralattentionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_model_min(s : MlneuralattentionModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_model_max(s : MlneuralattentionModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_model_to_string(s : MlneuralattentionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_layer_make(size : Int) -> MlneuralattentionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_layer_len(s : MlneuralattentionLayer) -> Int { s.size }

pub fn ml_neural_attention_layer_get(s : MlneuralattentionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_layer_set(s : MlneuralattentionLayer, i : Int, v : Double) -> MlneuralattentionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_layer_sum(s : MlneuralattentionLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_layer_mean(s : MlneuralattentionLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_layer_scale(s : MlneuralattentionLayer, f : Double) -> MlneuralattentionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_layer_add(a : MlneuralattentionLayer, b : MlneuralattentionLayer) -> MlneuralattentionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_layer_copy(s : MlneuralattentionLayer) -> MlneuralattentionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_layer_fill(s : MlneuralattentionLayer, v : Double) -> MlneuralattentionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_layer_min(s : MlneuralattentionLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_layer_max(s : MlneuralattentionLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_layer_to_string(s : MlneuralattentionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_buffer_make(size : Int) -> MlneuralattentionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_buffer_len(s : MlneuralattentionBuffer) -> Int { s.size }

pub fn ml_neural_attention_buffer_get(s : MlneuralattentionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_buffer_set(s : MlneuralattentionBuffer, i : Int, v : Double) -> MlneuralattentionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_buffer_sum(s : MlneuralattentionBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_buffer_mean(s : MlneuralattentionBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_buffer_scale(s : MlneuralattentionBuffer, f : Double) -> MlneuralattentionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_buffer_add(a : MlneuralattentionBuffer, b : MlneuralattentionBuffer) -> MlneuralattentionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_buffer_copy(s : MlneuralattentionBuffer) -> MlneuralattentionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_buffer_fill(s : MlneuralattentionBuffer, v : Double) -> MlneuralattentionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_buffer_min(s : MlneuralattentionBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_buffer_max(s : MlneuralattentionBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_buffer_to_string(s : MlneuralattentionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_cursor_make(size : Int) -> MlneuralattentionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_cursor_len(s : MlneuralattentionCursor) -> Int { s.size }

pub fn ml_neural_attention_cursor_get(s : MlneuralattentionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_cursor_set(s : MlneuralattentionCursor, i : Int, v : Double) -> MlneuralattentionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cursor_sum(s : MlneuralattentionCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_cursor_mean(s : MlneuralattentionCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_cursor_scale(s : MlneuralattentionCursor, f : Double) -> MlneuralattentionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cursor_add(a : MlneuralattentionCursor, b : MlneuralattentionCursor) -> MlneuralattentionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_cursor_copy(s : MlneuralattentionCursor) -> MlneuralattentionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cursor_fill(s : MlneuralattentionCursor, v : Double) -> MlneuralattentionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_cursor_min(s : MlneuralattentionCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_cursor_max(s : MlneuralattentionCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_cursor_to_string(s : MlneuralattentionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_view_make(size : Int) -> MlneuralattentionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_view_len(s : MlneuralattentionView) -> Int { s.size }

pub fn ml_neural_attention_view_get(s : MlneuralattentionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_view_set(s : MlneuralattentionView, i : Int, v : Double) -> MlneuralattentionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_view_sum(s : MlneuralattentionView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_view_mean(s : MlneuralattentionView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_view_scale(s : MlneuralattentionView, f : Double) -> MlneuralattentionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_view_add(a : MlneuralattentionView, b : MlneuralattentionView) -> MlneuralattentionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_view_copy(s : MlneuralattentionView) -> MlneuralattentionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_view_fill(s : MlneuralattentionView, v : Double) -> MlneuralattentionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_view_min(s : MlneuralattentionView) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_view_max(s : MlneuralattentionView) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_view_to_string(s : MlneuralattentionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_range_make(size : Int) -> MlneuralattentionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_range_len(s : MlneuralattentionRange) -> Int { s.size }

pub fn ml_neural_attention_range_get(s : MlneuralattentionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_range_set(s : MlneuralattentionRange, i : Int, v : Double) -> MlneuralattentionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_range_sum(s : MlneuralattentionRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_range_mean(s : MlneuralattentionRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_range_scale(s : MlneuralattentionRange, f : Double) -> MlneuralattentionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_range_add(a : MlneuralattentionRange, b : MlneuralattentionRange) -> MlneuralattentionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_range_copy(s : MlneuralattentionRange) -> MlneuralattentionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_range_fill(s : MlneuralattentionRange, v : Double) -> MlneuralattentionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_range_min(s : MlneuralattentionRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_range_max(s : MlneuralattentionRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_range_to_string(s : MlneuralattentionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralattentionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_attention_slice_make(size : Int) -> MlneuralattentionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_attention_slice_len(s : MlneuralattentionSlice) -> Int { s.size }

pub fn ml_neural_attention_slice_get(s : MlneuralattentionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_attention_slice_set(s : MlneuralattentionSlice, i : Int, v : Double) -> MlneuralattentionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_slice_sum(s : MlneuralattentionSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_attention_slice_mean(s : MlneuralattentionSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_attention_slice_scale(s : MlneuralattentionSlice, f : Double) -> MlneuralattentionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_slice_add(a : MlneuralattentionSlice, b : MlneuralattentionSlice) -> MlneuralattentionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_attention_slice_copy(s : MlneuralattentionSlice) -> MlneuralattentionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_slice_fill(s : MlneuralattentionSlice, v : Double) -> MlneuralattentionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_attention_slice_min(s : MlneuralattentionSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_attention_slice_max(s : MlneuralattentionSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_attention_slice_to_string(s : MlneuralattentionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

