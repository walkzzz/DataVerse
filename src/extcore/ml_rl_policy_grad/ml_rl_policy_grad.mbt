///===
/// extcore/ml_rl_policy_grad

pub(all) struct MlrlpolicygradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_policy_grad_make_point(x : Double, y : Double) -> MlrlpolicygradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_policy_grad_make_point3(x : Double, y : Double, z : Double) -> MlrlpolicygradPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlpolicygradPoint::x(self : MlrlpolicygradPoint) -> Double { self.x }

pub fn MlrlpolicygradPoint::y(self : MlrlpolicygradPoint) -> Double { self.y }

pub fn MlrlpolicygradPoint::z(self : MlrlpolicygradPoint) -> Double { self.z }

pub fn MlrlpolicygradPoint::label(self : MlrlpolicygradPoint) -> Int { self.label }

pub fn MlrlpolicygradPoint::dist(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlpolicygradPoint::add(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlpolicygradPoint::sub(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlpolicygradPoint::scale(self : MlrlpolicygradPoint, s : Double) -> MlrlpolicygradPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlpolicygradPoint::dot(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlpolicygradPoint::cross(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlpolicygradPoint::norm(self : MlrlpolicygradPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlpolicygradPoint::normalize(self : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlpolicygradPoint::negate(self : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlpolicygradPoint::mid(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlpolicygradPoint::lerp(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint, t : Double) -> MlrlpolicygradPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlpolicygradPoint::to_string(self : MlrlpolicygradPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlpolicygradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_policy_grad_make_series(vals : Array[Double], name : String) -> MlrlpolicygradSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlpolicygradSeries::len(self : MlrlpolicygradSeries) -> Int { self.vals.length() }

pub fn MlrlpolicygradSeries::sum(self : MlrlpolicygradSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlpolicygradSeries::mean(self : MlrlpolicygradSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlpolicygradSeries::min(self : MlrlpolicygradSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlpolicygradSeries::max(self : MlrlpolicygradSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlpolicygradSeries::range(self : MlrlpolicygradSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlpolicygradSeries::variance(self : MlrlpolicygradSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlpolicygradSeries::std(self : MlrlpolicygradSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlpolicygradSeries::median(self : MlrlpolicygradSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlpolicygradSeries::scale(self : MlrlpolicygradSeries, f : Double) -> MlrlpolicygradSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlpolicygradSeries::add(self : MlrlpolicygradSeries, other : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlpolicygradSeries::sub(self : MlrlpolicygradSeries, other : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlpolicygradSeries::normalize(self : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlpolicygradSeries::cumsum(self : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlpolicygradSeries::to_string(self : MlrlpolicygradSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlpolicygradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_policy_grad_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlpolicygradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_policy_grad_matrix_identity(n : Int) -> MlrlpolicygradMatrix {
  let m = ml_rl_policy_grad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlpolicygradMatrix::get(self : MlrlpolicygradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlpolicygradMatrix::transpose(self : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  let result = ml_rl_policy_grad_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlpolicygradMatrix::add(self : MlrlpolicygradMatrix, other : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_policy_grad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlpolicygradMatrix::scale(self : MlrlpolicygradMatrix, s : Double) -> MlrlpolicygradMatrix {
  let result = ml_rl_policy_grad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlpolicygradMatrix::multiply(self : MlrlpolicygradMatrix, other : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  if self.cols != other.rows { return ml_rl_policy_grad_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_policy_grad_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlpolicygradMatrix::trace(self : MlrlpolicygradMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlpolicygradMatrix::det(self : MlrlpolicygradMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlpolicygradMatrix::norm(self : MlrlpolicygradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlpolicygradMatrix::to_string(self : MlrlpolicygradMatrix) -> String {
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

pub(all) struct MlrlpolicygradVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_policy_grad_make_vector(comps : Array[Double]) -> MlrlpolicygradVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_policy_grad_vector_zero(dim : Int) -> MlrlpolicygradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlpolicygradVector::add(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlpolicygradVector::sub(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlpolicygradVector::scale(self : MlrlpolicygradVector, s : Double) -> MlrlpolicygradVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlpolicygradVector::dot(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlpolicygradVector::norm(self : MlrlpolicygradVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlpolicygradVector::normalize(self : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlpolicygradVector::dist(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlpolicygradVector::to_string(self : MlrlpolicygradVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_policy_grad_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_policy_grad_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_policy_grad_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_policy_grad_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_policy_grad_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_policy_grad_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_policy_grad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_policy_grad_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_policy_grad_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_policy_grad_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_policy_grad_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_policy_grad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_policy_grad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_policy_grad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_policy_grad_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_policy_grad_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_policy_grad_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_policy_grad_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_policy_grad_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_policy_grad_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_policy_grad_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_policy_grad_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_policy_grad_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_policy_grad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_policy_grad_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_policy_grad_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_policy_grad_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_policy_grad_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_policy_grad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlpolicygradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_frame_make(size : Int) -> MlrlpolicygradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_frame_len(s : MlrlpolicygradFrame) -> Int { s.size }

pub fn ml_rl_policy_grad_frame_get(s : MlrlpolicygradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_frame_set(s : MlrlpolicygradFrame, i : Int, v : Double) -> MlrlpolicygradFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_frame_sum(s : MlrlpolicygradFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_frame_mean(s : MlrlpolicygradFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_frame_scale(s : MlrlpolicygradFrame, f : Double) -> MlrlpolicygradFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_frame_add(a : MlrlpolicygradFrame, b : MlrlpolicygradFrame) -> MlrlpolicygradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_frame_copy(s : MlrlpolicygradFrame) -> MlrlpolicygradFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_frame_fill(s : MlrlpolicygradFrame, v : Double) -> MlrlpolicygradFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_frame_min(s : MlrlpolicygradFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_frame_max(s : MlrlpolicygradFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_frame_to_string(s : MlrlpolicygradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_table_make(size : Int) -> MlrlpolicygradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_table_len(s : MlrlpolicygradTable) -> Int { s.size }

pub fn ml_rl_policy_grad_table_get(s : MlrlpolicygradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_table_set(s : MlrlpolicygradTable, i : Int, v : Double) -> MlrlpolicygradTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_table_sum(s : MlrlpolicygradTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_table_mean(s : MlrlpolicygradTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_table_scale(s : MlrlpolicygradTable, f : Double) -> MlrlpolicygradTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_table_add(a : MlrlpolicygradTable, b : MlrlpolicygradTable) -> MlrlpolicygradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_table_copy(s : MlrlpolicygradTable) -> MlrlpolicygradTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_table_fill(s : MlrlpolicygradTable, v : Double) -> MlrlpolicygradTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_table_min(s : MlrlpolicygradTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_table_max(s : MlrlpolicygradTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_table_to_string(s : MlrlpolicygradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_graphn_make(size : Int) -> MlrlpolicygradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_graphn_len(s : MlrlpolicygradGraphN) -> Int { s.size }

pub fn ml_rl_policy_grad_graphn_get(s : MlrlpolicygradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_graphn_set(s : MlrlpolicygradGraphN, i : Int, v : Double) -> MlrlpolicygradGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_graphn_sum(s : MlrlpolicygradGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_graphn_mean(s : MlrlpolicygradGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_graphn_scale(s : MlrlpolicygradGraphN, f : Double) -> MlrlpolicygradGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_graphn_add(a : MlrlpolicygradGraphN, b : MlrlpolicygradGraphN) -> MlrlpolicygradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_graphn_copy(s : MlrlpolicygradGraphN) -> MlrlpolicygradGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_graphn_fill(s : MlrlpolicygradGraphN, v : Double) -> MlrlpolicygradGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_graphn_min(s : MlrlpolicygradGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_graphn_max(s : MlrlpolicygradGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_graphn_to_string(s : MlrlpolicygradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_node_make(size : Int) -> MlrlpolicygradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_node_len(s : MlrlpolicygradNode) -> Int { s.size }

pub fn ml_rl_policy_grad_node_get(s : MlrlpolicygradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_node_set(s : MlrlpolicygradNode, i : Int, v : Double) -> MlrlpolicygradNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_node_sum(s : MlrlpolicygradNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_node_mean(s : MlrlpolicygradNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_node_scale(s : MlrlpolicygradNode, f : Double) -> MlrlpolicygradNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_node_add(a : MlrlpolicygradNode, b : MlrlpolicygradNode) -> MlrlpolicygradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_node_copy(s : MlrlpolicygradNode) -> MlrlpolicygradNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_node_fill(s : MlrlpolicygradNode, v : Double) -> MlrlpolicygradNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_node_min(s : MlrlpolicygradNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_node_max(s : MlrlpolicygradNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_node_to_string(s : MlrlpolicygradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_edge_make(size : Int) -> MlrlpolicygradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_edge_len(s : MlrlpolicygradEdge) -> Int { s.size }

pub fn ml_rl_policy_grad_edge_get(s : MlrlpolicygradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_edge_set(s : MlrlpolicygradEdge, i : Int, v : Double) -> MlrlpolicygradEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_edge_sum(s : MlrlpolicygradEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_edge_mean(s : MlrlpolicygradEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_edge_scale(s : MlrlpolicygradEdge, f : Double) -> MlrlpolicygradEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_edge_add(a : MlrlpolicygradEdge, b : MlrlpolicygradEdge) -> MlrlpolicygradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_edge_copy(s : MlrlpolicygradEdge) -> MlrlpolicygradEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_edge_fill(s : MlrlpolicygradEdge, v : Double) -> MlrlpolicygradEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_edge_min(s : MlrlpolicygradEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_edge_max(s : MlrlpolicygradEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_edge_to_string(s : MlrlpolicygradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_path_make(size : Int) -> MlrlpolicygradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_path_len(s : MlrlpolicygradPath) -> Int { s.size }

pub fn ml_rl_policy_grad_path_get(s : MlrlpolicygradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_path_set(s : MlrlpolicygradPath, i : Int, v : Double) -> MlrlpolicygradPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_path_sum(s : MlrlpolicygradPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_path_mean(s : MlrlpolicygradPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_path_scale(s : MlrlpolicygradPath, f : Double) -> MlrlpolicygradPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_path_add(a : MlrlpolicygradPath, b : MlrlpolicygradPath) -> MlrlpolicygradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_path_copy(s : MlrlpolicygradPath) -> MlrlpolicygradPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_path_fill(s : MlrlpolicygradPath, v : Double) -> MlrlpolicygradPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_path_min(s : MlrlpolicygradPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_path_max(s : MlrlpolicygradPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_path_to_string(s : MlrlpolicygradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_cluster_make(size : Int) -> MlrlpolicygradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_cluster_len(s : MlrlpolicygradCluster) -> Int { s.size }

pub fn ml_rl_policy_grad_cluster_get(s : MlrlpolicygradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_cluster_set(s : MlrlpolicygradCluster, i : Int, v : Double) -> MlrlpolicygradCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cluster_sum(s : MlrlpolicygradCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_cluster_mean(s : MlrlpolicygradCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_cluster_scale(s : MlrlpolicygradCluster, f : Double) -> MlrlpolicygradCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cluster_add(a : MlrlpolicygradCluster, b : MlrlpolicygradCluster) -> MlrlpolicygradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_cluster_copy(s : MlrlpolicygradCluster) -> MlrlpolicygradCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cluster_fill(s : MlrlpolicygradCluster, v : Double) -> MlrlpolicygradCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cluster_min(s : MlrlpolicygradCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_cluster_max(s : MlrlpolicygradCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_cluster_to_string(s : MlrlpolicygradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_model_make(size : Int) -> MlrlpolicygradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_model_len(s : MlrlpolicygradModel) -> Int { s.size }

pub fn ml_rl_policy_grad_model_get(s : MlrlpolicygradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_model_set(s : MlrlpolicygradModel, i : Int, v : Double) -> MlrlpolicygradModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_model_sum(s : MlrlpolicygradModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_model_mean(s : MlrlpolicygradModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_model_scale(s : MlrlpolicygradModel, f : Double) -> MlrlpolicygradModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_model_add(a : MlrlpolicygradModel, b : MlrlpolicygradModel) -> MlrlpolicygradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_model_copy(s : MlrlpolicygradModel) -> MlrlpolicygradModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_model_fill(s : MlrlpolicygradModel, v : Double) -> MlrlpolicygradModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_model_min(s : MlrlpolicygradModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_model_max(s : MlrlpolicygradModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_model_to_string(s : MlrlpolicygradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_layer_make(size : Int) -> MlrlpolicygradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_layer_len(s : MlrlpolicygradLayer) -> Int { s.size }

pub fn ml_rl_policy_grad_layer_get(s : MlrlpolicygradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_layer_set(s : MlrlpolicygradLayer, i : Int, v : Double) -> MlrlpolicygradLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_layer_sum(s : MlrlpolicygradLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_layer_mean(s : MlrlpolicygradLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_layer_scale(s : MlrlpolicygradLayer, f : Double) -> MlrlpolicygradLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_layer_add(a : MlrlpolicygradLayer, b : MlrlpolicygradLayer) -> MlrlpolicygradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_layer_copy(s : MlrlpolicygradLayer) -> MlrlpolicygradLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_layer_fill(s : MlrlpolicygradLayer, v : Double) -> MlrlpolicygradLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_layer_min(s : MlrlpolicygradLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_layer_max(s : MlrlpolicygradLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_layer_to_string(s : MlrlpolicygradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_buffer_make(size : Int) -> MlrlpolicygradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_buffer_len(s : MlrlpolicygradBuffer) -> Int { s.size }

pub fn ml_rl_policy_grad_buffer_get(s : MlrlpolicygradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_buffer_set(s : MlrlpolicygradBuffer, i : Int, v : Double) -> MlrlpolicygradBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_buffer_sum(s : MlrlpolicygradBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_buffer_mean(s : MlrlpolicygradBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_buffer_scale(s : MlrlpolicygradBuffer, f : Double) -> MlrlpolicygradBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_buffer_add(a : MlrlpolicygradBuffer, b : MlrlpolicygradBuffer) -> MlrlpolicygradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_buffer_copy(s : MlrlpolicygradBuffer) -> MlrlpolicygradBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_buffer_fill(s : MlrlpolicygradBuffer, v : Double) -> MlrlpolicygradBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_buffer_min(s : MlrlpolicygradBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_buffer_max(s : MlrlpolicygradBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_buffer_to_string(s : MlrlpolicygradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_cursor_make(size : Int) -> MlrlpolicygradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_cursor_len(s : MlrlpolicygradCursor) -> Int { s.size }

pub fn ml_rl_policy_grad_cursor_get(s : MlrlpolicygradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_cursor_set(s : MlrlpolicygradCursor, i : Int, v : Double) -> MlrlpolicygradCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cursor_sum(s : MlrlpolicygradCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_cursor_mean(s : MlrlpolicygradCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_cursor_scale(s : MlrlpolicygradCursor, f : Double) -> MlrlpolicygradCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cursor_add(a : MlrlpolicygradCursor, b : MlrlpolicygradCursor) -> MlrlpolicygradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_cursor_copy(s : MlrlpolicygradCursor) -> MlrlpolicygradCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cursor_fill(s : MlrlpolicygradCursor, v : Double) -> MlrlpolicygradCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_cursor_min(s : MlrlpolicygradCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_cursor_max(s : MlrlpolicygradCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_cursor_to_string(s : MlrlpolicygradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_view_make(size : Int) -> MlrlpolicygradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_view_len(s : MlrlpolicygradView) -> Int { s.size }

pub fn ml_rl_policy_grad_view_get(s : MlrlpolicygradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_view_set(s : MlrlpolicygradView, i : Int, v : Double) -> MlrlpolicygradView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_view_sum(s : MlrlpolicygradView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_view_mean(s : MlrlpolicygradView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_view_scale(s : MlrlpolicygradView, f : Double) -> MlrlpolicygradView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_view_add(a : MlrlpolicygradView, b : MlrlpolicygradView) -> MlrlpolicygradView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_view_copy(s : MlrlpolicygradView) -> MlrlpolicygradView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_view_fill(s : MlrlpolicygradView, v : Double) -> MlrlpolicygradView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_view_min(s : MlrlpolicygradView) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_view_max(s : MlrlpolicygradView) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_view_to_string(s : MlrlpolicygradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_range_make(size : Int) -> MlrlpolicygradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_range_len(s : MlrlpolicygradRange) -> Int { s.size }

pub fn ml_rl_policy_grad_range_get(s : MlrlpolicygradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_range_set(s : MlrlpolicygradRange, i : Int, v : Double) -> MlrlpolicygradRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_range_sum(s : MlrlpolicygradRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_range_mean(s : MlrlpolicygradRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_range_scale(s : MlrlpolicygradRange, f : Double) -> MlrlpolicygradRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_range_add(a : MlrlpolicygradRange, b : MlrlpolicygradRange) -> MlrlpolicygradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_range_copy(s : MlrlpolicygradRange) -> MlrlpolicygradRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_range_fill(s : MlrlpolicygradRange, v : Double) -> MlrlpolicygradRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_range_min(s : MlrlpolicygradRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_range_max(s : MlrlpolicygradRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_range_to_string(s : MlrlpolicygradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_slice_make(size : Int) -> MlrlpolicygradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_slice_len(s : MlrlpolicygradSlice) -> Int { s.size }

pub fn ml_rl_policy_grad_slice_get(s : MlrlpolicygradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_slice_set(s : MlrlpolicygradSlice, i : Int, v : Double) -> MlrlpolicygradSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_slice_sum(s : MlrlpolicygradSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_policy_grad_slice_mean(s : MlrlpolicygradSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_policy_grad_slice_scale(s : MlrlpolicygradSlice, f : Double) -> MlrlpolicygradSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_slice_add(a : MlrlpolicygradSlice, b : MlrlpolicygradSlice) -> MlrlpolicygradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_policy_grad_slice_copy(s : MlrlpolicygradSlice) -> MlrlpolicygradSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_slice_fill(s : MlrlpolicygradSlice, v : Double) -> MlrlpolicygradSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_policy_grad_slice_min(s : MlrlpolicygradSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_policy_grad_slice_max(s : MlrlpolicygradSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_policy_grad_slice_to_string(s : MlrlpolicygradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

