///===
/// extcore/ml_neural_gan

pub(all) struct MlneuralganPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_gan_make_point(x : Double, y : Double) -> MlneuralganPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_gan_make_point3(x : Double, y : Double, z : Double) -> MlneuralganPoint {
  { x, y, z, label: 0 }
}

pub fn MlneuralganPoint::x(self : MlneuralganPoint) -> Double { self.x }

pub fn MlneuralganPoint::y(self : MlneuralganPoint) -> Double { self.y }

pub fn MlneuralganPoint::z(self : MlneuralganPoint) -> Double { self.z }

pub fn MlneuralganPoint::label(self : MlneuralganPoint) -> Int { self.label }

pub fn MlneuralganPoint::dist(self : MlneuralganPoint, other : MlneuralganPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlneuralganPoint::add(self : MlneuralganPoint, other : MlneuralganPoint) -> MlneuralganPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlneuralganPoint::sub(self : MlneuralganPoint, other : MlneuralganPoint) -> MlneuralganPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlneuralganPoint::scale(self : MlneuralganPoint, s : Double) -> MlneuralganPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlneuralganPoint::dot(self : MlneuralganPoint, other : MlneuralganPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlneuralganPoint::cross(self : MlneuralganPoint, other : MlneuralganPoint) -> MlneuralganPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlneuralganPoint::norm(self : MlneuralganPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlneuralganPoint::normalize(self : MlneuralganPoint) -> MlneuralganPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralganPoint::negate(self : MlneuralganPoint) -> MlneuralganPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlneuralganPoint::mid(self : MlneuralganPoint, other : MlneuralganPoint) -> MlneuralganPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlneuralganPoint::lerp(self : MlneuralganPoint, other : MlneuralganPoint, t : Double) -> MlneuralganPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlneuralganPoint::to_string(self : MlneuralganPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlneuralganSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_gan_make_series(vals : Array[Double], name : String) -> MlneuralganSeries {
  { vals, name, meta: 0 }
}

pub fn MlneuralganSeries::len(self : MlneuralganSeries) -> Int { self.vals.length() }

pub fn MlneuralganSeries::sum(self : MlneuralganSeries) -> Double { @_common.sum(self.vals) }

pub fn MlneuralganSeries::mean(self : MlneuralganSeries) -> Double { @_common.mean(self.vals) }

pub fn MlneuralganSeries::min(self : MlneuralganSeries) -> Double { @_common.min(self.vals) }

pub fn MlneuralganSeries::max(self : MlneuralganSeries) -> Double { @_common.max(self.vals) }

pub fn MlneuralganSeries::range(self : MlneuralganSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlneuralganSeries::variance(self : MlneuralganSeries) -> Double { @_common.variance(self.vals) }

pub fn MlneuralganSeries::std(self : MlneuralganSeries) -> Double { @_common.std(self.vals) }

pub fn MlneuralganSeries::median(self : MlneuralganSeries) -> Double { @_common.median(self.vals) }

pub fn MlneuralganSeries::scale(self : MlneuralganSeries, f : Double) -> MlneuralganSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlneuralganSeries::add(self : MlneuralganSeries, other : MlneuralganSeries) -> MlneuralganSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlneuralganSeries::sub(self : MlneuralganSeries, other : MlneuralganSeries) -> MlneuralganSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlneuralganSeries::normalize(self : MlneuralganSeries) -> MlneuralganSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlneuralganSeries::cumsum(self : MlneuralganSeries) -> MlneuralganSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlneuralganSeries::to_string(self : MlneuralganSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralganMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_gan_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralganMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_gan_matrix_identity(n : Int) -> MlneuralganMatrix {
  let m = ml_neural_gan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlneuralganMatrix::get(self : MlneuralganMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlneuralganMatrix::transpose(self : MlneuralganMatrix) -> MlneuralganMatrix {
  let result = ml_neural_gan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlneuralganMatrix::add(self : MlneuralganMatrix, other : MlneuralganMatrix) -> MlneuralganMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_neural_gan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlneuralganMatrix::scale(self : MlneuralganMatrix, s : Double) -> MlneuralganMatrix {
  let result = ml_neural_gan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlneuralganMatrix::multiply(self : MlneuralganMatrix, other : MlneuralganMatrix) -> MlneuralganMatrix {
  if self.cols != other.rows { return ml_neural_gan_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_neural_gan_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlneuralganMatrix::trace(self : MlneuralganMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlneuralganMatrix::det(self : MlneuralganMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlneuralganMatrix::norm(self : MlneuralganMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlneuralganMatrix::to_string(self : MlneuralganMatrix) -> String {
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

pub(all) struct MlneuralganVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_gan_make_vector(comps : Array[Double]) -> MlneuralganVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_gan_vector_zero(dim : Int) -> MlneuralganVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlneuralganVector::add(self : MlneuralganVector, other : MlneuralganVector) -> MlneuralganVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralganVector::sub(self : MlneuralganVector, other : MlneuralganVector) -> MlneuralganVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlneuralganVector::scale(self : MlneuralganVector, s : Double) -> MlneuralganVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlneuralganVector::dot(self : MlneuralganVector, other : MlneuralganVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlneuralganVector::norm(self : MlneuralganVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlneuralganVector::normalize(self : MlneuralganVector) -> MlneuralganVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlneuralganVector::dist(self : MlneuralganVector, other : MlneuralganVector) -> Double {
  self.sub(other).norm()
}

pub fn MlneuralganVector::to_string(self : MlneuralganVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_gan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_gan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_gan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_gan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_gan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_gan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_gan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_gan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_gan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_gan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_gan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_gan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_gan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_gan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_gan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_gan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_gan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_gan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_gan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_gan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_gan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_gan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_gan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_gan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_gan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_gan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_gan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_gan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_gan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralganFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_frame_make(size : Int) -> MlneuralganFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_frame_len(s : MlneuralganFrame) -> Int { s.size }

pub fn ml_neural_gan_frame_get(s : MlneuralganFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_frame_set(s : MlneuralganFrame, i : Int, v : Double) -> MlneuralganFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_frame_sum(s : MlneuralganFrame) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_frame_mean(s : MlneuralganFrame) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_frame_scale(s : MlneuralganFrame, f : Double) -> MlneuralganFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_frame_add(a : MlneuralganFrame, b : MlneuralganFrame) -> MlneuralganFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_frame_copy(s : MlneuralganFrame) -> MlneuralganFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_frame_fill(s : MlneuralganFrame, v : Double) -> MlneuralganFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_frame_min(s : MlneuralganFrame) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_frame_max(s : MlneuralganFrame) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_frame_to_string(s : MlneuralganFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_table_make(size : Int) -> MlneuralganTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_table_len(s : MlneuralganTable) -> Int { s.size }

pub fn ml_neural_gan_table_get(s : MlneuralganTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_table_set(s : MlneuralganTable, i : Int, v : Double) -> MlneuralganTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_table_sum(s : MlneuralganTable) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_table_mean(s : MlneuralganTable) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_table_scale(s : MlneuralganTable, f : Double) -> MlneuralganTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_table_add(a : MlneuralganTable, b : MlneuralganTable) -> MlneuralganTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_table_copy(s : MlneuralganTable) -> MlneuralganTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_table_fill(s : MlneuralganTable, v : Double) -> MlneuralganTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_table_min(s : MlneuralganTable) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_table_max(s : MlneuralganTable) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_table_to_string(s : MlneuralganTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_graphn_make(size : Int) -> MlneuralganGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_graphn_len(s : MlneuralganGraphN) -> Int { s.size }

pub fn ml_neural_gan_graphn_get(s : MlneuralganGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_graphn_set(s : MlneuralganGraphN, i : Int, v : Double) -> MlneuralganGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_graphn_sum(s : MlneuralganGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_graphn_mean(s : MlneuralganGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_graphn_scale(s : MlneuralganGraphN, f : Double) -> MlneuralganGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_graphn_add(a : MlneuralganGraphN, b : MlneuralganGraphN) -> MlneuralganGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_graphn_copy(s : MlneuralganGraphN) -> MlneuralganGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_graphn_fill(s : MlneuralganGraphN, v : Double) -> MlneuralganGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_graphn_min(s : MlneuralganGraphN) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_graphn_max(s : MlneuralganGraphN) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_graphn_to_string(s : MlneuralganGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_node_make(size : Int) -> MlneuralganNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_node_len(s : MlneuralganNode) -> Int { s.size }

pub fn ml_neural_gan_node_get(s : MlneuralganNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_node_set(s : MlneuralganNode, i : Int, v : Double) -> MlneuralganNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_node_sum(s : MlneuralganNode) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_node_mean(s : MlneuralganNode) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_node_scale(s : MlneuralganNode, f : Double) -> MlneuralganNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_node_add(a : MlneuralganNode, b : MlneuralganNode) -> MlneuralganNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_node_copy(s : MlneuralganNode) -> MlneuralganNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_node_fill(s : MlneuralganNode, v : Double) -> MlneuralganNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_node_min(s : MlneuralganNode) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_node_max(s : MlneuralganNode) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_node_to_string(s : MlneuralganNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_edge_make(size : Int) -> MlneuralganEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_edge_len(s : MlneuralganEdge) -> Int { s.size }

pub fn ml_neural_gan_edge_get(s : MlneuralganEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_edge_set(s : MlneuralganEdge, i : Int, v : Double) -> MlneuralganEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_edge_sum(s : MlneuralganEdge) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_edge_mean(s : MlneuralganEdge) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_edge_scale(s : MlneuralganEdge, f : Double) -> MlneuralganEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_edge_add(a : MlneuralganEdge, b : MlneuralganEdge) -> MlneuralganEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_edge_copy(s : MlneuralganEdge) -> MlneuralganEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_edge_fill(s : MlneuralganEdge, v : Double) -> MlneuralganEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_edge_min(s : MlneuralganEdge) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_edge_max(s : MlneuralganEdge) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_edge_to_string(s : MlneuralganEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_path_make(size : Int) -> MlneuralganPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_path_len(s : MlneuralganPath) -> Int { s.size }

pub fn ml_neural_gan_path_get(s : MlneuralganPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_path_set(s : MlneuralganPath, i : Int, v : Double) -> MlneuralganPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_path_sum(s : MlneuralganPath) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_path_mean(s : MlneuralganPath) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_path_scale(s : MlneuralganPath, f : Double) -> MlneuralganPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_path_add(a : MlneuralganPath, b : MlneuralganPath) -> MlneuralganPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_path_copy(s : MlneuralganPath) -> MlneuralganPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_path_fill(s : MlneuralganPath, v : Double) -> MlneuralganPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_path_min(s : MlneuralganPath) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_path_max(s : MlneuralganPath) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_path_to_string(s : MlneuralganPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_cluster_make(size : Int) -> MlneuralganCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_cluster_len(s : MlneuralganCluster) -> Int { s.size }

pub fn ml_neural_gan_cluster_get(s : MlneuralganCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_cluster_set(s : MlneuralganCluster, i : Int, v : Double) -> MlneuralganCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cluster_sum(s : MlneuralganCluster) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_cluster_mean(s : MlneuralganCluster) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_cluster_scale(s : MlneuralganCluster, f : Double) -> MlneuralganCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cluster_add(a : MlneuralganCluster, b : MlneuralganCluster) -> MlneuralganCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_cluster_copy(s : MlneuralganCluster) -> MlneuralganCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cluster_fill(s : MlneuralganCluster, v : Double) -> MlneuralganCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cluster_min(s : MlneuralganCluster) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_cluster_max(s : MlneuralganCluster) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_cluster_to_string(s : MlneuralganCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_model_make(size : Int) -> MlneuralganModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_model_len(s : MlneuralganModel) -> Int { s.size }

pub fn ml_neural_gan_model_get(s : MlneuralganModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_model_set(s : MlneuralganModel, i : Int, v : Double) -> MlneuralganModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_model_sum(s : MlneuralganModel) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_model_mean(s : MlneuralganModel) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_model_scale(s : MlneuralganModel, f : Double) -> MlneuralganModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_model_add(a : MlneuralganModel, b : MlneuralganModel) -> MlneuralganModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_model_copy(s : MlneuralganModel) -> MlneuralganModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_model_fill(s : MlneuralganModel, v : Double) -> MlneuralganModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_model_min(s : MlneuralganModel) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_model_max(s : MlneuralganModel) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_model_to_string(s : MlneuralganModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_layer_make(size : Int) -> MlneuralganLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_layer_len(s : MlneuralganLayer) -> Int { s.size }

pub fn ml_neural_gan_layer_get(s : MlneuralganLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_layer_set(s : MlneuralganLayer, i : Int, v : Double) -> MlneuralganLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_layer_sum(s : MlneuralganLayer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_layer_mean(s : MlneuralganLayer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_layer_scale(s : MlneuralganLayer, f : Double) -> MlneuralganLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_layer_add(a : MlneuralganLayer, b : MlneuralganLayer) -> MlneuralganLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_layer_copy(s : MlneuralganLayer) -> MlneuralganLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_layer_fill(s : MlneuralganLayer, v : Double) -> MlneuralganLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_layer_min(s : MlneuralganLayer) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_layer_max(s : MlneuralganLayer) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_layer_to_string(s : MlneuralganLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_buffer_make(size : Int) -> MlneuralganBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_buffer_len(s : MlneuralganBuffer) -> Int { s.size }

pub fn ml_neural_gan_buffer_get(s : MlneuralganBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_buffer_set(s : MlneuralganBuffer, i : Int, v : Double) -> MlneuralganBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_buffer_sum(s : MlneuralganBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_buffer_mean(s : MlneuralganBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_buffer_scale(s : MlneuralganBuffer, f : Double) -> MlneuralganBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_buffer_add(a : MlneuralganBuffer, b : MlneuralganBuffer) -> MlneuralganBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_buffer_copy(s : MlneuralganBuffer) -> MlneuralganBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_buffer_fill(s : MlneuralganBuffer, v : Double) -> MlneuralganBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_buffer_min(s : MlneuralganBuffer) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_buffer_max(s : MlneuralganBuffer) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_buffer_to_string(s : MlneuralganBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_cursor_make(size : Int) -> MlneuralganCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_cursor_len(s : MlneuralganCursor) -> Int { s.size }

pub fn ml_neural_gan_cursor_get(s : MlneuralganCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_cursor_set(s : MlneuralganCursor, i : Int, v : Double) -> MlneuralganCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cursor_sum(s : MlneuralganCursor) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_cursor_mean(s : MlneuralganCursor) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_cursor_scale(s : MlneuralganCursor, f : Double) -> MlneuralganCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cursor_add(a : MlneuralganCursor, b : MlneuralganCursor) -> MlneuralganCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_cursor_copy(s : MlneuralganCursor) -> MlneuralganCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cursor_fill(s : MlneuralganCursor, v : Double) -> MlneuralganCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_cursor_min(s : MlneuralganCursor) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_cursor_max(s : MlneuralganCursor) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_cursor_to_string(s : MlneuralganCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_view_make(size : Int) -> MlneuralganView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_view_len(s : MlneuralganView) -> Int { s.size }

pub fn ml_neural_gan_view_get(s : MlneuralganView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_view_set(s : MlneuralganView, i : Int, v : Double) -> MlneuralganView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_view_sum(s : MlneuralganView) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_view_mean(s : MlneuralganView) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_view_scale(s : MlneuralganView, f : Double) -> MlneuralganView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_view_add(a : MlneuralganView, b : MlneuralganView) -> MlneuralganView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_view_copy(s : MlneuralganView) -> MlneuralganView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_view_fill(s : MlneuralganView, v : Double) -> MlneuralganView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_view_min(s : MlneuralganView) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_view_max(s : MlneuralganView) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_view_to_string(s : MlneuralganView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_range_make(size : Int) -> MlneuralganRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_range_len(s : MlneuralganRange) -> Int { s.size }

pub fn ml_neural_gan_range_get(s : MlneuralganRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_range_set(s : MlneuralganRange, i : Int, v : Double) -> MlneuralganRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_range_sum(s : MlneuralganRange) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_range_mean(s : MlneuralganRange) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_range_scale(s : MlneuralganRange, f : Double) -> MlneuralganRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_range_add(a : MlneuralganRange, b : MlneuralganRange) -> MlneuralganRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_range_copy(s : MlneuralganRange) -> MlneuralganRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_range_fill(s : MlneuralganRange, v : Double) -> MlneuralganRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_range_min(s : MlneuralganRange) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_range_max(s : MlneuralganRange) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_range_to_string(s : MlneuralganRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_slice_make(size : Int) -> MlneuralganSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_slice_len(s : MlneuralganSlice) -> Int { s.size }

pub fn ml_neural_gan_slice_get(s : MlneuralganSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_slice_set(s : MlneuralganSlice, i : Int, v : Double) -> MlneuralganSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_slice_sum(s : MlneuralganSlice) -> Double { @_common.sum(s.data) }

pub fn ml_neural_gan_slice_mean(s : MlneuralganSlice) -> Double { @_common.mean(s.data) }

pub fn ml_neural_gan_slice_scale(s : MlneuralganSlice, f : Double) -> MlneuralganSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_slice_add(a : MlneuralganSlice, b : MlneuralganSlice) -> MlneuralganSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_neural_gan_slice_copy(s : MlneuralganSlice) -> MlneuralganSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_slice_fill(s : MlneuralganSlice, v : Double) -> MlneuralganSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_neural_gan_slice_min(s : MlneuralganSlice) -> Double { @_common.min(s.data) }

pub fn ml_neural_gan_slice_max(s : MlneuralganSlice) -> Double { @_common.max(s.data) }

pub fn ml_neural_gan_slice_to_string(s : MlneuralganSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

