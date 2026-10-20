///===
/// extcore/ml_neural_vae

pub(all) struct MlneuralvaePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_vae_make_point(x : Double, y : Double) -> MlneuralvaePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_vae_make_point3(x : Double, y : Double, z : Double) -> MlneuralvaePoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralvaePoint::x(self : MlneuralvaePoint) -> Double { self.x }

pub fn MlneuralvaePoint::y(self : MlneuralvaePoint) -> Double { self.y }

pub fn MlneuralvaePoint::z(self : MlneuralvaePoint) -> Double { self.z }

pub fn MlneuralvaePoint::label(self : MlneuralvaePoint) -> Int { self.label }

pub fn MlneuralvaePoint::dist(self : MlneuralvaePoint, other : MlneuralvaePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralvaePoint::add(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralvaePoint::sub(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralvaePoint::scale(self : MlneuralvaePoint, s : Double) -> MlneuralvaePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralvaePoint::dot(self : MlneuralvaePoint, other : MlneuralvaePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralvaePoint::cross(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralvaePoint::norm(self : MlneuralvaePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralvaePoint::normalize(self : MlneuralvaePoint) -> MlneuralvaePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralvaePoint::negate(self : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralvaePoint::mid(self : MlneuralvaePoint, other : MlneuralvaePoint) -> MlneuralvaePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralvaePoint::lerp(self : MlneuralvaePoint, other : MlneuralvaePoint, t : Double) -> MlneuralvaePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralvaePoint::to_string(self : MlneuralvaePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralvaeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_vae_make_series(vals : Array[Double], name : String) -> MlneuralvaeSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralvaeSeries::len(self : MlneuralvaeSeries) -> Int { self.vals.length() }

pub fn MlneuralvaeSeries::sum(self : MlneuralvaeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralvaeSeries::mean(self : MlneuralvaeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralvaeSeries::min(self : MlneuralvaeSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralvaeSeries::max(self : MlneuralvaeSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralvaeSeries::range(self : MlneuralvaeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralvaeSeries::variance(self : MlneuralvaeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralvaeSeries::std(self : MlneuralvaeSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralvaeSeries::median(self : MlneuralvaeSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralvaeSeries::scale(self : MlneuralvaeSeries, f : Double) -> MlneuralvaeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralvaeSeries::add(self : MlneuralvaeSeries, other : MlneuralvaeSeries) -> MlneuralvaeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralvaeSeries::sub(self : MlneuralvaeSeries, other : MlneuralvaeSeries) -> MlneuralvaeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralvaeSeries::normalize(self : MlneuralvaeSeries) -> MlneuralvaeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralvaeSeries::cumsum(self : MlneuralvaeSeries) -> MlneuralvaeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralvaeSeries::to_string(self : MlneuralvaeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralvaeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_vae_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralvaeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_vae_matrix_identity(n : Int) -> MlneuralvaeMatrix {
  let m = ml_neural_vae_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralvaeMatrix::get(self : MlneuralvaeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralvaeMatrix::transpose(self : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  let result = ml_neural_vae_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralvaeMatrix::add(self : MlneuralvaeMatrix, other : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_vae_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralvaeMatrix::scale(self : MlneuralvaeMatrix, s : Double) -> MlneuralvaeMatrix {
  let result = ml_neural_vae_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralvaeMatrix::multiply(self : MlneuralvaeMatrix, other : MlneuralvaeMatrix) -> MlneuralvaeMatrix {
  if self.cols != other.rows { return ml_neural_vae_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_vae_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralvaeMatrix::trace(self : MlneuralvaeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralvaeMatrix::det(self : MlneuralvaeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralvaeMatrix::norm(self : MlneuralvaeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralvaeMatrix::to_string(self : MlneuralvaeMatrix) -> String {
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

pub(all) struct MlneuralvaeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_vae_make_vector(comps : Array[Double]) -> MlneuralvaeVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_vae_vector_zero(dim : Int) -> MlneuralvaeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralvaeVector::add(self : MlneuralvaeVector, other : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralvaeVector::sub(self : MlneuralvaeVector, other : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralvaeVector::scale(self : MlneuralvaeVector, s : Double) -> MlneuralvaeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralvaeVector::dot(self : MlneuralvaeVector, other : MlneuralvaeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralvaeVector::norm(self : MlneuralvaeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralvaeVector::normalize(self : MlneuralvaeVector) -> MlneuralvaeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralvaeVector::dist(self : MlneuralvaeVector, other : MlneuralvaeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralvaeVector::to_string(self : MlneuralvaeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_vae_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_vae_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_vae_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_vae_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_vae_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_vae_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_vae_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_vae_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_vae_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_vae_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_vae_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_vae_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_vae_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_vae_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_vae_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_vae_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_vae_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_vae_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_vae_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_vae_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_vae_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_vae_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_vae_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_vae_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_vae_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_vae_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_vae_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_vae_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_vae_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralvaeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_frame_make(size : Int) -> MlneuralvaeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_frame_len(s : MlneuralvaeFrame) -> Int { s.size }

pub fn ml_neural_vae_frame_get(s : MlneuralvaeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_frame_set(s : MlneuralvaeFrame, i : Int, v : Double) -> MlneuralvaeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_frame_sum(s : MlneuralvaeFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_frame_mean(s : MlneuralvaeFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_frame_scale(s : MlneuralvaeFrame, f : Double) -> MlneuralvaeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_frame_add(a : MlneuralvaeFrame, b : MlneuralvaeFrame) -> MlneuralvaeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_frame_copy(s : MlneuralvaeFrame) -> MlneuralvaeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_frame_fill(s : MlneuralvaeFrame, v : Double) -> MlneuralvaeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_frame_min(s : MlneuralvaeFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_frame_max(s : MlneuralvaeFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_frame_to_string(s : MlneuralvaeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_table_make(size : Int) -> MlneuralvaeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_table_len(s : MlneuralvaeTable) -> Int { s.size }

pub fn ml_neural_vae_table_get(s : MlneuralvaeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_table_set(s : MlneuralvaeTable, i : Int, v : Double) -> MlneuralvaeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_table_sum(s : MlneuralvaeTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_table_mean(s : MlneuralvaeTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_table_scale(s : MlneuralvaeTable, f : Double) -> MlneuralvaeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_table_add(a : MlneuralvaeTable, b : MlneuralvaeTable) -> MlneuralvaeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_table_copy(s : MlneuralvaeTable) -> MlneuralvaeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_table_fill(s : MlneuralvaeTable, v : Double) -> MlneuralvaeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_table_min(s : MlneuralvaeTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_table_max(s : MlneuralvaeTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_table_to_string(s : MlneuralvaeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_graphn_make(size : Int) -> MlneuralvaeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_graphn_len(s : MlneuralvaeGraphN) -> Int { s.size }

pub fn ml_neural_vae_graphn_get(s : MlneuralvaeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_graphn_set(s : MlneuralvaeGraphN, i : Int, v : Double) -> MlneuralvaeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_graphn_sum(s : MlneuralvaeGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_graphn_mean(s : MlneuralvaeGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_graphn_scale(s : MlneuralvaeGraphN, f : Double) -> MlneuralvaeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_graphn_add(a : MlneuralvaeGraphN, b : MlneuralvaeGraphN) -> MlneuralvaeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_graphn_copy(s : MlneuralvaeGraphN) -> MlneuralvaeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_graphn_fill(s : MlneuralvaeGraphN, v : Double) -> MlneuralvaeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_graphn_min(s : MlneuralvaeGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_graphn_max(s : MlneuralvaeGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_graphn_to_string(s : MlneuralvaeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_node_make(size : Int) -> MlneuralvaeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_node_len(s : MlneuralvaeNode) -> Int { s.size }

pub fn ml_neural_vae_node_get(s : MlneuralvaeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_node_set(s : MlneuralvaeNode, i : Int, v : Double) -> MlneuralvaeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_node_sum(s : MlneuralvaeNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_node_mean(s : MlneuralvaeNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_node_scale(s : MlneuralvaeNode, f : Double) -> MlneuralvaeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_node_add(a : MlneuralvaeNode, b : MlneuralvaeNode) -> MlneuralvaeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_node_copy(s : MlneuralvaeNode) -> MlneuralvaeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_node_fill(s : MlneuralvaeNode, v : Double) -> MlneuralvaeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_node_min(s : MlneuralvaeNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_node_max(s : MlneuralvaeNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_node_to_string(s : MlneuralvaeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_edge_make(size : Int) -> MlneuralvaeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_edge_len(s : MlneuralvaeEdge) -> Int { s.size }

pub fn ml_neural_vae_edge_get(s : MlneuralvaeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_edge_set(s : MlneuralvaeEdge, i : Int, v : Double) -> MlneuralvaeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_edge_sum(s : MlneuralvaeEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_edge_mean(s : MlneuralvaeEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_edge_scale(s : MlneuralvaeEdge, f : Double) -> MlneuralvaeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_edge_add(a : MlneuralvaeEdge, b : MlneuralvaeEdge) -> MlneuralvaeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_edge_copy(s : MlneuralvaeEdge) -> MlneuralvaeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_edge_fill(s : MlneuralvaeEdge, v : Double) -> MlneuralvaeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_edge_min(s : MlneuralvaeEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_edge_max(s : MlneuralvaeEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_edge_to_string(s : MlneuralvaeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_path_make(size : Int) -> MlneuralvaePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_path_len(s : MlneuralvaePath) -> Int { s.size }

pub fn ml_neural_vae_path_get(s : MlneuralvaePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_path_set(s : MlneuralvaePath, i : Int, v : Double) -> MlneuralvaePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_path_sum(s : MlneuralvaePath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_path_mean(s : MlneuralvaePath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_path_scale(s : MlneuralvaePath, f : Double) -> MlneuralvaePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_path_add(a : MlneuralvaePath, b : MlneuralvaePath) -> MlneuralvaePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_path_copy(s : MlneuralvaePath) -> MlneuralvaePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_path_fill(s : MlneuralvaePath, v : Double) -> MlneuralvaePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_path_min(s : MlneuralvaePath) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_path_max(s : MlneuralvaePath) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_path_to_string(s : MlneuralvaePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_cluster_make(size : Int) -> MlneuralvaeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_cluster_len(s : MlneuralvaeCluster) -> Int { s.size }

pub fn ml_neural_vae_cluster_get(s : MlneuralvaeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_cluster_set(s : MlneuralvaeCluster, i : Int, v : Double) -> MlneuralvaeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cluster_sum(s : MlneuralvaeCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_cluster_mean(s : MlneuralvaeCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_cluster_scale(s : MlneuralvaeCluster, f : Double) -> MlneuralvaeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cluster_add(a : MlneuralvaeCluster, b : MlneuralvaeCluster) -> MlneuralvaeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_cluster_copy(s : MlneuralvaeCluster) -> MlneuralvaeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cluster_fill(s : MlneuralvaeCluster, v : Double) -> MlneuralvaeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cluster_min(s : MlneuralvaeCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_cluster_max(s : MlneuralvaeCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_cluster_to_string(s : MlneuralvaeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_model_make(size : Int) -> MlneuralvaeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_model_len(s : MlneuralvaeModel) -> Int { s.size }

pub fn ml_neural_vae_model_get(s : MlneuralvaeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_model_set(s : MlneuralvaeModel, i : Int, v : Double) -> MlneuralvaeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_model_sum(s : MlneuralvaeModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_model_mean(s : MlneuralvaeModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_model_scale(s : MlneuralvaeModel, f : Double) -> MlneuralvaeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_model_add(a : MlneuralvaeModel, b : MlneuralvaeModel) -> MlneuralvaeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_model_copy(s : MlneuralvaeModel) -> MlneuralvaeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_model_fill(s : MlneuralvaeModel, v : Double) -> MlneuralvaeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_model_min(s : MlneuralvaeModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_model_max(s : MlneuralvaeModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_model_to_string(s : MlneuralvaeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_layer_make(size : Int) -> MlneuralvaeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_layer_len(s : MlneuralvaeLayer) -> Int { s.size }

pub fn ml_neural_vae_layer_get(s : MlneuralvaeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_layer_set(s : MlneuralvaeLayer, i : Int, v : Double) -> MlneuralvaeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_layer_sum(s : MlneuralvaeLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_layer_mean(s : MlneuralvaeLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_layer_scale(s : MlneuralvaeLayer, f : Double) -> MlneuralvaeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_layer_add(a : MlneuralvaeLayer, b : MlneuralvaeLayer) -> MlneuralvaeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_layer_copy(s : MlneuralvaeLayer) -> MlneuralvaeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_layer_fill(s : MlneuralvaeLayer, v : Double) -> MlneuralvaeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_layer_min(s : MlneuralvaeLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_layer_max(s : MlneuralvaeLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_layer_to_string(s : MlneuralvaeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_buffer_make(size : Int) -> MlneuralvaeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_buffer_len(s : MlneuralvaeBuffer) -> Int { s.size }

pub fn ml_neural_vae_buffer_get(s : MlneuralvaeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_buffer_set(s : MlneuralvaeBuffer, i : Int, v : Double) -> MlneuralvaeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_buffer_sum(s : MlneuralvaeBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_buffer_mean(s : MlneuralvaeBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_buffer_scale(s : MlneuralvaeBuffer, f : Double) -> MlneuralvaeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_buffer_add(a : MlneuralvaeBuffer, b : MlneuralvaeBuffer) -> MlneuralvaeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_buffer_copy(s : MlneuralvaeBuffer) -> MlneuralvaeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_buffer_fill(s : MlneuralvaeBuffer, v : Double) -> MlneuralvaeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_buffer_min(s : MlneuralvaeBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_buffer_max(s : MlneuralvaeBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_buffer_to_string(s : MlneuralvaeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_cursor_make(size : Int) -> MlneuralvaeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_cursor_len(s : MlneuralvaeCursor) -> Int { s.size }

pub fn ml_neural_vae_cursor_get(s : MlneuralvaeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_cursor_set(s : MlneuralvaeCursor, i : Int, v : Double) -> MlneuralvaeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cursor_sum(s : MlneuralvaeCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_cursor_mean(s : MlneuralvaeCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_cursor_scale(s : MlneuralvaeCursor, f : Double) -> MlneuralvaeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cursor_add(a : MlneuralvaeCursor, b : MlneuralvaeCursor) -> MlneuralvaeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_cursor_copy(s : MlneuralvaeCursor) -> MlneuralvaeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cursor_fill(s : MlneuralvaeCursor, v : Double) -> MlneuralvaeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_cursor_min(s : MlneuralvaeCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_cursor_max(s : MlneuralvaeCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_cursor_to_string(s : MlneuralvaeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_view_make(size : Int) -> MlneuralvaeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_view_len(s : MlneuralvaeView) -> Int { s.size }

pub fn ml_neural_vae_view_get(s : MlneuralvaeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_view_set(s : MlneuralvaeView, i : Int, v : Double) -> MlneuralvaeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_view_sum(s : MlneuralvaeView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_view_mean(s : MlneuralvaeView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_view_scale(s : MlneuralvaeView, f : Double) -> MlneuralvaeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_view_add(a : MlneuralvaeView, b : MlneuralvaeView) -> MlneuralvaeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_view_copy(s : MlneuralvaeView) -> MlneuralvaeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_view_fill(s : MlneuralvaeView, v : Double) -> MlneuralvaeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_view_min(s : MlneuralvaeView) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_view_max(s : MlneuralvaeView) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_view_to_string(s : MlneuralvaeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_range_make(size : Int) -> MlneuralvaeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_range_len(s : MlneuralvaeRange) -> Int { s.size }

pub fn ml_neural_vae_range_get(s : MlneuralvaeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_range_set(s : MlneuralvaeRange, i : Int, v : Double) -> MlneuralvaeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_range_sum(s : MlneuralvaeRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_range_mean(s : MlneuralvaeRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_range_scale(s : MlneuralvaeRange, f : Double) -> MlneuralvaeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_range_add(a : MlneuralvaeRange, b : MlneuralvaeRange) -> MlneuralvaeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_range_copy(s : MlneuralvaeRange) -> MlneuralvaeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_range_fill(s : MlneuralvaeRange, v : Double) -> MlneuralvaeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_range_min(s : MlneuralvaeRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_range_max(s : MlneuralvaeRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_range_to_string(s : MlneuralvaeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralvaeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_vae_slice_make(size : Int) -> MlneuralvaeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_vae_slice_len(s : MlneuralvaeSlice) -> Int { s.size }

pub fn ml_neural_vae_slice_get(s : MlneuralvaeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_vae_slice_set(s : MlneuralvaeSlice, i : Int, v : Double) -> MlneuralvaeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_slice_sum(s : MlneuralvaeSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_vae_slice_mean(s : MlneuralvaeSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_vae_slice_scale(s : MlneuralvaeSlice, f : Double) -> MlneuralvaeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_slice_add(a : MlneuralvaeSlice, b : MlneuralvaeSlice) -> MlneuralvaeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_vae_slice_copy(s : MlneuralvaeSlice) -> MlneuralvaeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_slice_fill(s : MlneuralvaeSlice, v : Double) -> MlneuralvaeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_vae_slice_min(s : MlneuralvaeSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_vae_slice_max(s : MlneuralvaeSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_vae_slice_to_string(s : MlneuralvaeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

