///===
/// extcore/ml_neural_transformer

pub(all) struct MlneuraltransformerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_transformer_make_point(x : Double, y : Double) -> MlneuraltransformerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_transformer_make_point3(x : Double, y : Double, z : Double) -> MlneuraltransformerPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuraltransformerPoint::x(self : MlneuraltransformerPoint) -> Double { self.x }

pub fn MlneuraltransformerPoint::y(self : MlneuraltransformerPoint) -> Double { self.y }

pub fn MlneuraltransformerPoint::z(self : MlneuraltransformerPoint) -> Double { self.z }

pub fn MlneuraltransformerPoint::label(self : MlneuraltransformerPoint) -> Int { self.label }

pub fn MlneuraltransformerPoint::dist(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuraltransformerPoint::add(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuraltransformerPoint::sub(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuraltransformerPoint::scale(self : MlneuraltransformerPoint, s : Double) -> MlneuraltransformerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuraltransformerPoint::dot(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuraltransformerPoint::cross(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuraltransformerPoint::norm(self : MlneuraltransformerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuraltransformerPoint::normalize(self : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuraltransformerPoint::negate(self : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuraltransformerPoint::mid(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint) -> MlneuraltransformerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuraltransformerPoint::lerp(self : MlneuraltransformerPoint, other : MlneuraltransformerPoint, t : Double) -> MlneuraltransformerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuraltransformerPoint::to_string(self : MlneuraltransformerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuraltransformerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_transformer_make_series(vals : Array[Double], name : String) -> MlneuraltransformerSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuraltransformerSeries::len(self : MlneuraltransformerSeries) -> Int { self.vals.length() }

pub fn MlneuraltransformerSeries::sum(self : MlneuraltransformerSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuraltransformerSeries::mean(self : MlneuraltransformerSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuraltransformerSeries::min(self : MlneuraltransformerSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuraltransformerSeries::max(self : MlneuraltransformerSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuraltransformerSeries::range(self : MlneuraltransformerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuraltransformerSeries::variance(self : MlneuraltransformerSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuraltransformerSeries::std(self : MlneuraltransformerSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuraltransformerSeries::median(self : MlneuraltransformerSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuraltransformerSeries::scale(self : MlneuraltransformerSeries, f : Double) -> MlneuraltransformerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuraltransformerSeries::add(self : MlneuraltransformerSeries, other : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuraltransformerSeries::sub(self : MlneuraltransformerSeries, other : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuraltransformerSeries::normalize(self : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuraltransformerSeries::cumsum(self : MlneuraltransformerSeries) -> MlneuraltransformerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuraltransformerSeries::to_string(self : MlneuraltransformerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuraltransformerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_transformer_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuraltransformerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_transformer_matrix_identity(n : Int) -> MlneuraltransformerMatrix {
  let m = ml_neural_transformer_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuraltransformerMatrix::get(self : MlneuraltransformerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuraltransformerMatrix::transpose(self : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  let result = ml_neural_transformer_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuraltransformerMatrix::add(self : MlneuraltransformerMatrix, other : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuraltransformerMatrix::scale(self : MlneuraltransformerMatrix, s : Double) -> MlneuraltransformerMatrix {
  let result = ml_neural_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuraltransformerMatrix::multiply(self : MlneuraltransformerMatrix, other : MlneuraltransformerMatrix) -> MlneuraltransformerMatrix {
  if self.cols != other.rows { return ml_neural_transformer_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_transformer_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuraltransformerMatrix::trace(self : MlneuraltransformerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuraltransformerMatrix::det(self : MlneuraltransformerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuraltransformerMatrix::norm(self : MlneuraltransformerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuraltransformerMatrix::to_string(self : MlneuraltransformerMatrix) -> String {
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

pub(all) struct MlneuraltransformerVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_transformer_make_vector(comps : Array[Double]) -> MlneuraltransformerVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_transformer_vector_zero(dim : Int) -> MlneuraltransformerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuraltransformerVector::add(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuraltransformerVector::sub(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuraltransformerVector::scale(self : MlneuraltransformerVector, s : Double) -> MlneuraltransformerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuraltransformerVector::dot(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuraltransformerVector::norm(self : MlneuraltransformerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuraltransformerVector::normalize(self : MlneuraltransformerVector) -> MlneuraltransformerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuraltransformerVector::dist(self : MlneuraltransformerVector, other : MlneuraltransformerVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuraltransformerVector::to_string(self : MlneuraltransformerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_transformer_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_transformer_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_transformer_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_transformer_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_transformer_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_transformer_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_transformer_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_transformer_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_transformer_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_transformer_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_transformer_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_transformer_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_transformer_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_transformer_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_transformer_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_transformer_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_transformer_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_transformer_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_transformer_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_transformer_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_transformer_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_transformer_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_transformer_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_transformer_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_transformer_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_transformer_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_transformer_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_transformer_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_transformer_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuraltransformerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_frame_make(size : Int) -> MlneuraltransformerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_frame_len(s : MlneuraltransformerFrame) -> Int { s.size }

pub fn ml_neural_transformer_frame_get(s : MlneuraltransformerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_frame_set(s : MlneuraltransformerFrame, i : Int, v : Double) -> MlneuraltransformerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_frame_sum(s : MlneuraltransformerFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_frame_mean(s : MlneuraltransformerFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_frame_scale(s : MlneuraltransformerFrame, f : Double) -> MlneuraltransformerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_frame_add(a : MlneuraltransformerFrame, b : MlneuraltransformerFrame) -> MlneuraltransformerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_frame_copy(s : MlneuraltransformerFrame) -> MlneuraltransformerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_frame_fill(s : MlneuraltransformerFrame, v : Double) -> MlneuraltransformerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_frame_min(s : MlneuraltransformerFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_frame_max(s : MlneuraltransformerFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_frame_to_string(s : MlneuraltransformerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_table_make(size : Int) -> MlneuraltransformerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_table_len(s : MlneuraltransformerTable) -> Int { s.size }

pub fn ml_neural_transformer_table_get(s : MlneuraltransformerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_table_set(s : MlneuraltransformerTable, i : Int, v : Double) -> MlneuraltransformerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_table_sum(s : MlneuraltransformerTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_table_mean(s : MlneuraltransformerTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_table_scale(s : MlneuraltransformerTable, f : Double) -> MlneuraltransformerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_table_add(a : MlneuraltransformerTable, b : MlneuraltransformerTable) -> MlneuraltransformerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_table_copy(s : MlneuraltransformerTable) -> MlneuraltransformerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_table_fill(s : MlneuraltransformerTable, v : Double) -> MlneuraltransformerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_table_min(s : MlneuraltransformerTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_table_max(s : MlneuraltransformerTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_table_to_string(s : MlneuraltransformerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_graphn_make(size : Int) -> MlneuraltransformerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_graphn_len(s : MlneuraltransformerGraphN) -> Int { s.size }

pub fn ml_neural_transformer_graphn_get(s : MlneuraltransformerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_graphn_set(s : MlneuraltransformerGraphN, i : Int, v : Double) -> MlneuraltransformerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_graphn_sum(s : MlneuraltransformerGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_graphn_mean(s : MlneuraltransformerGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_graphn_scale(s : MlneuraltransformerGraphN, f : Double) -> MlneuraltransformerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_graphn_add(a : MlneuraltransformerGraphN, b : MlneuraltransformerGraphN) -> MlneuraltransformerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_graphn_copy(s : MlneuraltransformerGraphN) -> MlneuraltransformerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_graphn_fill(s : MlneuraltransformerGraphN, v : Double) -> MlneuraltransformerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_graphn_min(s : MlneuraltransformerGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_graphn_max(s : MlneuraltransformerGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_graphn_to_string(s : MlneuraltransformerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_node_make(size : Int) -> MlneuraltransformerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_node_len(s : MlneuraltransformerNode) -> Int { s.size }

pub fn ml_neural_transformer_node_get(s : MlneuraltransformerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_node_set(s : MlneuraltransformerNode, i : Int, v : Double) -> MlneuraltransformerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_node_sum(s : MlneuraltransformerNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_node_mean(s : MlneuraltransformerNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_node_scale(s : MlneuraltransformerNode, f : Double) -> MlneuraltransformerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_node_add(a : MlneuraltransformerNode, b : MlneuraltransformerNode) -> MlneuraltransformerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_node_copy(s : MlneuraltransformerNode) -> MlneuraltransformerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_node_fill(s : MlneuraltransformerNode, v : Double) -> MlneuraltransformerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_node_min(s : MlneuraltransformerNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_node_max(s : MlneuraltransformerNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_node_to_string(s : MlneuraltransformerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_edge_make(size : Int) -> MlneuraltransformerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_edge_len(s : MlneuraltransformerEdge) -> Int { s.size }

pub fn ml_neural_transformer_edge_get(s : MlneuraltransformerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_edge_set(s : MlneuraltransformerEdge, i : Int, v : Double) -> MlneuraltransformerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_edge_sum(s : MlneuraltransformerEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_edge_mean(s : MlneuraltransformerEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_edge_scale(s : MlneuraltransformerEdge, f : Double) -> MlneuraltransformerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_edge_add(a : MlneuraltransformerEdge, b : MlneuraltransformerEdge) -> MlneuraltransformerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_edge_copy(s : MlneuraltransformerEdge) -> MlneuraltransformerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_edge_fill(s : MlneuraltransformerEdge, v : Double) -> MlneuraltransformerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_edge_min(s : MlneuraltransformerEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_edge_max(s : MlneuraltransformerEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_edge_to_string(s : MlneuraltransformerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_path_make(size : Int) -> MlneuraltransformerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_path_len(s : MlneuraltransformerPath) -> Int { s.size }

pub fn ml_neural_transformer_path_get(s : MlneuraltransformerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_path_set(s : MlneuraltransformerPath, i : Int, v : Double) -> MlneuraltransformerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_path_sum(s : MlneuraltransformerPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_path_mean(s : MlneuraltransformerPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_path_scale(s : MlneuraltransformerPath, f : Double) -> MlneuraltransformerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_path_add(a : MlneuraltransformerPath, b : MlneuraltransformerPath) -> MlneuraltransformerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_path_copy(s : MlneuraltransformerPath) -> MlneuraltransformerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_path_fill(s : MlneuraltransformerPath, v : Double) -> MlneuraltransformerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_path_min(s : MlneuraltransformerPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_path_max(s : MlneuraltransformerPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_path_to_string(s : MlneuraltransformerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_cluster_make(size : Int) -> MlneuraltransformerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_cluster_len(s : MlneuraltransformerCluster) -> Int { s.size }

pub fn ml_neural_transformer_cluster_get(s : MlneuraltransformerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_cluster_set(s : MlneuraltransformerCluster, i : Int, v : Double) -> MlneuraltransformerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cluster_sum(s : MlneuraltransformerCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_cluster_mean(s : MlneuraltransformerCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_cluster_scale(s : MlneuraltransformerCluster, f : Double) -> MlneuraltransformerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cluster_add(a : MlneuraltransformerCluster, b : MlneuraltransformerCluster) -> MlneuraltransformerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_cluster_copy(s : MlneuraltransformerCluster) -> MlneuraltransformerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cluster_fill(s : MlneuraltransformerCluster, v : Double) -> MlneuraltransformerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cluster_min(s : MlneuraltransformerCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_cluster_max(s : MlneuraltransformerCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_cluster_to_string(s : MlneuraltransformerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_model_make(size : Int) -> MlneuraltransformerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_model_len(s : MlneuraltransformerModel) -> Int { s.size }

pub fn ml_neural_transformer_model_get(s : MlneuraltransformerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_model_set(s : MlneuraltransformerModel, i : Int, v : Double) -> MlneuraltransformerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_model_sum(s : MlneuraltransformerModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_model_mean(s : MlneuraltransformerModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_model_scale(s : MlneuraltransformerModel, f : Double) -> MlneuraltransformerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_model_add(a : MlneuraltransformerModel, b : MlneuraltransformerModel) -> MlneuraltransformerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_model_copy(s : MlneuraltransformerModel) -> MlneuraltransformerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_model_fill(s : MlneuraltransformerModel, v : Double) -> MlneuraltransformerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_model_min(s : MlneuraltransformerModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_model_max(s : MlneuraltransformerModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_model_to_string(s : MlneuraltransformerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_layer_make(size : Int) -> MlneuraltransformerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_layer_len(s : MlneuraltransformerLayer) -> Int { s.size }

pub fn ml_neural_transformer_layer_get(s : MlneuraltransformerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_layer_set(s : MlneuraltransformerLayer, i : Int, v : Double) -> MlneuraltransformerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_layer_sum(s : MlneuraltransformerLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_layer_mean(s : MlneuraltransformerLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_layer_scale(s : MlneuraltransformerLayer, f : Double) -> MlneuraltransformerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_layer_add(a : MlneuraltransformerLayer, b : MlneuraltransformerLayer) -> MlneuraltransformerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_layer_copy(s : MlneuraltransformerLayer) -> MlneuraltransformerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_layer_fill(s : MlneuraltransformerLayer, v : Double) -> MlneuraltransformerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_layer_min(s : MlneuraltransformerLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_layer_max(s : MlneuraltransformerLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_layer_to_string(s : MlneuraltransformerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_buffer_make(size : Int) -> MlneuraltransformerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_buffer_len(s : MlneuraltransformerBuffer) -> Int { s.size }

pub fn ml_neural_transformer_buffer_get(s : MlneuraltransformerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_buffer_set(s : MlneuraltransformerBuffer, i : Int, v : Double) -> MlneuraltransformerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_buffer_sum(s : MlneuraltransformerBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_buffer_mean(s : MlneuraltransformerBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_buffer_scale(s : MlneuraltransformerBuffer, f : Double) -> MlneuraltransformerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_buffer_add(a : MlneuraltransformerBuffer, b : MlneuraltransformerBuffer) -> MlneuraltransformerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_buffer_copy(s : MlneuraltransformerBuffer) -> MlneuraltransformerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_buffer_fill(s : MlneuraltransformerBuffer, v : Double) -> MlneuraltransformerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_buffer_min(s : MlneuraltransformerBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_buffer_max(s : MlneuraltransformerBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_buffer_to_string(s : MlneuraltransformerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_cursor_make(size : Int) -> MlneuraltransformerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_cursor_len(s : MlneuraltransformerCursor) -> Int { s.size }

pub fn ml_neural_transformer_cursor_get(s : MlneuraltransformerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_cursor_set(s : MlneuraltransformerCursor, i : Int, v : Double) -> MlneuraltransformerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cursor_sum(s : MlneuraltransformerCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_cursor_mean(s : MlneuraltransformerCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_cursor_scale(s : MlneuraltransformerCursor, f : Double) -> MlneuraltransformerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cursor_add(a : MlneuraltransformerCursor, b : MlneuraltransformerCursor) -> MlneuraltransformerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_cursor_copy(s : MlneuraltransformerCursor) -> MlneuraltransformerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cursor_fill(s : MlneuraltransformerCursor, v : Double) -> MlneuraltransformerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_cursor_min(s : MlneuraltransformerCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_cursor_max(s : MlneuraltransformerCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_cursor_to_string(s : MlneuraltransformerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_view_make(size : Int) -> MlneuraltransformerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_view_len(s : MlneuraltransformerView) -> Int { s.size }

pub fn ml_neural_transformer_view_get(s : MlneuraltransformerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_view_set(s : MlneuraltransformerView, i : Int, v : Double) -> MlneuraltransformerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_view_sum(s : MlneuraltransformerView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_view_mean(s : MlneuraltransformerView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_view_scale(s : MlneuraltransformerView, f : Double) -> MlneuraltransformerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_view_add(a : MlneuraltransformerView, b : MlneuraltransformerView) -> MlneuraltransformerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_view_copy(s : MlneuraltransformerView) -> MlneuraltransformerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_view_fill(s : MlneuraltransformerView, v : Double) -> MlneuraltransformerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_view_min(s : MlneuraltransformerView) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_view_max(s : MlneuraltransformerView) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_view_to_string(s : MlneuraltransformerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_range_make(size : Int) -> MlneuraltransformerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_range_len(s : MlneuraltransformerRange) -> Int { s.size }

pub fn ml_neural_transformer_range_get(s : MlneuraltransformerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_range_set(s : MlneuraltransformerRange, i : Int, v : Double) -> MlneuraltransformerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_range_sum(s : MlneuraltransformerRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_range_mean(s : MlneuraltransformerRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_range_scale(s : MlneuraltransformerRange, f : Double) -> MlneuraltransformerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_range_add(a : MlneuraltransformerRange, b : MlneuraltransformerRange) -> MlneuraltransformerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_range_copy(s : MlneuraltransformerRange) -> MlneuraltransformerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_range_fill(s : MlneuraltransformerRange, v : Double) -> MlneuraltransformerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_range_min(s : MlneuraltransformerRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_range_max(s : MlneuraltransformerRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_range_to_string(s : MlneuraltransformerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuraltransformerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_transformer_slice_make(size : Int) -> MlneuraltransformerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_transformer_slice_len(s : MlneuraltransformerSlice) -> Int { s.size }

pub fn ml_neural_transformer_slice_get(s : MlneuraltransformerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_transformer_slice_set(s : MlneuraltransformerSlice, i : Int, v : Double) -> MlneuraltransformerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_slice_sum(s : MlneuraltransformerSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_transformer_slice_mean(s : MlneuraltransformerSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_transformer_slice_scale(s : MlneuraltransformerSlice, f : Double) -> MlneuraltransformerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_slice_add(a : MlneuraltransformerSlice, b : MlneuraltransformerSlice) -> MlneuraltransformerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_transformer_slice_copy(s : MlneuraltransformerSlice) -> MlneuraltransformerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_slice_fill(s : MlneuraltransformerSlice, v : Double) -> MlneuraltransformerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_transformer_slice_min(s : MlneuraltransformerSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_transformer_slice_max(s : MlneuraltransformerSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_transformer_slice_to_string(s : MlneuraltransformerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

