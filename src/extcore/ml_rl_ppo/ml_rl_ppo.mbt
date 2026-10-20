///===
/// extcore/ml_rl_ppo

pub(all) struct MlrlppoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_ppo_make_point(x : Double, y : Double) -> MlrlppoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_ppo_make_point3(x : Double, y : Double, z : Double) -> MlrlppoPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlppoPoint::x(self : MlrlppoPoint) -> Double { self.x }

pub fn MlrlppoPoint::y(self : MlrlppoPoint) -> Double { self.y }

pub fn MlrlppoPoint::z(self : MlrlppoPoint) -> Double { self.z }

pub fn MlrlppoPoint::label(self : MlrlppoPoint) -> Int { self.label }

pub fn MlrlppoPoint::dist(self : MlrlppoPoint, other : MlrlppoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlppoPoint::add(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlppoPoint::sub(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlppoPoint::scale(self : MlrlppoPoint, s : Double) -> MlrlppoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlppoPoint::dot(self : MlrlppoPoint, other : MlrlppoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlppoPoint::cross(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlppoPoint::norm(self : MlrlppoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlppoPoint::normalize(self : MlrlppoPoint) -> MlrlppoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlppoPoint::negate(self : MlrlppoPoint) -> MlrlppoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlppoPoint::mid(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlppoPoint::lerp(self : MlrlppoPoint, other : MlrlppoPoint, t : Double) -> MlrlppoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlppoPoint::to_string(self : MlrlppoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlppoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_ppo_make_series(vals : Array[Double], name : String) -> MlrlppoSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlppoSeries::len(self : MlrlppoSeries) -> Int { self.vals.length() }

pub fn MlrlppoSeries::sum(self : MlrlppoSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlppoSeries::mean(self : MlrlppoSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlppoSeries::min(self : MlrlppoSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlppoSeries::max(self : MlrlppoSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlppoSeries::range(self : MlrlppoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlppoSeries::variance(self : MlrlppoSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlppoSeries::std(self : MlrlppoSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlppoSeries::median(self : MlrlppoSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlppoSeries::scale(self : MlrlppoSeries, f : Double) -> MlrlppoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlppoSeries::add(self : MlrlppoSeries, other : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlppoSeries::sub(self : MlrlppoSeries, other : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlppoSeries::normalize(self : MlrlppoSeries) -> MlrlppoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlppoSeries::cumsum(self : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlppoSeries::to_string(self : MlrlppoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlppoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_ppo_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlppoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_ppo_matrix_identity(n : Int) -> MlrlppoMatrix {
  let m = ml_rl_ppo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlppoMatrix::get(self : MlrlppoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlppoMatrix::transpose(self : MlrlppoMatrix) -> MlrlppoMatrix {
  let result = ml_rl_ppo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlppoMatrix::add(self : MlrlppoMatrix, other : MlrlppoMatrix) -> MlrlppoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_ppo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlppoMatrix::scale(self : MlrlppoMatrix, s : Double) -> MlrlppoMatrix {
  let result = ml_rl_ppo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlppoMatrix::multiply(self : MlrlppoMatrix, other : MlrlppoMatrix) -> MlrlppoMatrix {
  if self.cols != other.rows { return ml_rl_ppo_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_ppo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlppoMatrix::trace(self : MlrlppoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlppoMatrix::det(self : MlrlppoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlppoMatrix::norm(self : MlrlppoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlppoMatrix::to_string(self : MlrlppoMatrix) -> String {
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

pub(all) struct MlrlppoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_ppo_make_vector(comps : Array[Double]) -> MlrlppoVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_ppo_vector_zero(dim : Int) -> MlrlppoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlppoVector::add(self : MlrlppoVector, other : MlrlppoVector) -> MlrlppoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlppoVector::sub(self : MlrlppoVector, other : MlrlppoVector) -> MlrlppoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlppoVector::scale(self : MlrlppoVector, s : Double) -> MlrlppoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlppoVector::dot(self : MlrlppoVector, other : MlrlppoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlppoVector::norm(self : MlrlppoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlppoVector::normalize(self : MlrlppoVector) -> MlrlppoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlppoVector::dist(self : MlrlppoVector, other : MlrlppoVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlppoVector::to_string(self : MlrlppoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_ppo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_ppo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_ppo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_ppo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_ppo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_ppo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_ppo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_ppo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_ppo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_ppo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_ppo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_ppo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_ppo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_ppo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_ppo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_ppo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_ppo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_ppo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_ppo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_ppo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_ppo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_ppo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_ppo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_ppo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_ppo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_ppo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_ppo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_ppo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_ppo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlppoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_frame_make(size : Int) -> MlrlppoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_frame_len(s : MlrlppoFrame) -> Int { s.size }

pub fn ml_rl_ppo_frame_get(s : MlrlppoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_frame_set(s : MlrlppoFrame, i : Int, v : Double) -> MlrlppoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_frame_sum(s : MlrlppoFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_frame_mean(s : MlrlppoFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_frame_scale(s : MlrlppoFrame, f : Double) -> MlrlppoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_frame_add(a : MlrlppoFrame, b : MlrlppoFrame) -> MlrlppoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_frame_copy(s : MlrlppoFrame) -> MlrlppoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_frame_fill(s : MlrlppoFrame, v : Double) -> MlrlppoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_frame_min(s : MlrlppoFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_frame_max(s : MlrlppoFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_frame_to_string(s : MlrlppoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_table_make(size : Int) -> MlrlppoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_table_len(s : MlrlppoTable) -> Int { s.size }

pub fn ml_rl_ppo_table_get(s : MlrlppoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_table_set(s : MlrlppoTable, i : Int, v : Double) -> MlrlppoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_table_sum(s : MlrlppoTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_table_mean(s : MlrlppoTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_table_scale(s : MlrlppoTable, f : Double) -> MlrlppoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_table_add(a : MlrlppoTable, b : MlrlppoTable) -> MlrlppoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_table_copy(s : MlrlppoTable) -> MlrlppoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_table_fill(s : MlrlppoTable, v : Double) -> MlrlppoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_table_min(s : MlrlppoTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_table_max(s : MlrlppoTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_table_to_string(s : MlrlppoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_graphn_make(size : Int) -> MlrlppoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_graphn_len(s : MlrlppoGraphN) -> Int { s.size }

pub fn ml_rl_ppo_graphn_get(s : MlrlppoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_graphn_set(s : MlrlppoGraphN, i : Int, v : Double) -> MlrlppoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_graphn_sum(s : MlrlppoGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_graphn_mean(s : MlrlppoGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_graphn_scale(s : MlrlppoGraphN, f : Double) -> MlrlppoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_graphn_add(a : MlrlppoGraphN, b : MlrlppoGraphN) -> MlrlppoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_graphn_copy(s : MlrlppoGraphN) -> MlrlppoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_graphn_fill(s : MlrlppoGraphN, v : Double) -> MlrlppoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_graphn_min(s : MlrlppoGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_graphn_max(s : MlrlppoGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_graphn_to_string(s : MlrlppoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_node_make(size : Int) -> MlrlppoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_node_len(s : MlrlppoNode) -> Int { s.size }

pub fn ml_rl_ppo_node_get(s : MlrlppoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_node_set(s : MlrlppoNode, i : Int, v : Double) -> MlrlppoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_node_sum(s : MlrlppoNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_node_mean(s : MlrlppoNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_node_scale(s : MlrlppoNode, f : Double) -> MlrlppoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_node_add(a : MlrlppoNode, b : MlrlppoNode) -> MlrlppoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_node_copy(s : MlrlppoNode) -> MlrlppoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_node_fill(s : MlrlppoNode, v : Double) -> MlrlppoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_node_min(s : MlrlppoNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_node_max(s : MlrlppoNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_node_to_string(s : MlrlppoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_edge_make(size : Int) -> MlrlppoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_edge_len(s : MlrlppoEdge) -> Int { s.size }

pub fn ml_rl_ppo_edge_get(s : MlrlppoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_edge_set(s : MlrlppoEdge, i : Int, v : Double) -> MlrlppoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_edge_sum(s : MlrlppoEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_edge_mean(s : MlrlppoEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_edge_scale(s : MlrlppoEdge, f : Double) -> MlrlppoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_edge_add(a : MlrlppoEdge, b : MlrlppoEdge) -> MlrlppoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_edge_copy(s : MlrlppoEdge) -> MlrlppoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_edge_fill(s : MlrlppoEdge, v : Double) -> MlrlppoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_edge_min(s : MlrlppoEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_edge_max(s : MlrlppoEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_edge_to_string(s : MlrlppoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_path_make(size : Int) -> MlrlppoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_path_len(s : MlrlppoPath) -> Int { s.size }

pub fn ml_rl_ppo_path_get(s : MlrlppoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_path_set(s : MlrlppoPath, i : Int, v : Double) -> MlrlppoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_path_sum(s : MlrlppoPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_path_mean(s : MlrlppoPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_path_scale(s : MlrlppoPath, f : Double) -> MlrlppoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_path_add(a : MlrlppoPath, b : MlrlppoPath) -> MlrlppoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_path_copy(s : MlrlppoPath) -> MlrlppoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_path_fill(s : MlrlppoPath, v : Double) -> MlrlppoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_path_min(s : MlrlppoPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_path_max(s : MlrlppoPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_path_to_string(s : MlrlppoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_cluster_make(size : Int) -> MlrlppoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_cluster_len(s : MlrlppoCluster) -> Int { s.size }

pub fn ml_rl_ppo_cluster_get(s : MlrlppoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_cluster_set(s : MlrlppoCluster, i : Int, v : Double) -> MlrlppoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cluster_sum(s : MlrlppoCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_cluster_mean(s : MlrlppoCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_cluster_scale(s : MlrlppoCluster, f : Double) -> MlrlppoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cluster_add(a : MlrlppoCluster, b : MlrlppoCluster) -> MlrlppoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_cluster_copy(s : MlrlppoCluster) -> MlrlppoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cluster_fill(s : MlrlppoCluster, v : Double) -> MlrlppoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cluster_min(s : MlrlppoCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_cluster_max(s : MlrlppoCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_cluster_to_string(s : MlrlppoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_model_make(size : Int) -> MlrlppoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_model_len(s : MlrlppoModel) -> Int { s.size }

pub fn ml_rl_ppo_model_get(s : MlrlppoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_model_set(s : MlrlppoModel, i : Int, v : Double) -> MlrlppoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_model_sum(s : MlrlppoModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_model_mean(s : MlrlppoModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_model_scale(s : MlrlppoModel, f : Double) -> MlrlppoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_model_add(a : MlrlppoModel, b : MlrlppoModel) -> MlrlppoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_model_copy(s : MlrlppoModel) -> MlrlppoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_model_fill(s : MlrlppoModel, v : Double) -> MlrlppoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_model_min(s : MlrlppoModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_model_max(s : MlrlppoModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_model_to_string(s : MlrlppoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_layer_make(size : Int) -> MlrlppoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_layer_len(s : MlrlppoLayer) -> Int { s.size }

pub fn ml_rl_ppo_layer_get(s : MlrlppoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_layer_set(s : MlrlppoLayer, i : Int, v : Double) -> MlrlppoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_layer_sum(s : MlrlppoLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_layer_mean(s : MlrlppoLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_layer_scale(s : MlrlppoLayer, f : Double) -> MlrlppoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_layer_add(a : MlrlppoLayer, b : MlrlppoLayer) -> MlrlppoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_layer_copy(s : MlrlppoLayer) -> MlrlppoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_layer_fill(s : MlrlppoLayer, v : Double) -> MlrlppoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_layer_min(s : MlrlppoLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_layer_max(s : MlrlppoLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_layer_to_string(s : MlrlppoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_buffer_make(size : Int) -> MlrlppoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_buffer_len(s : MlrlppoBuffer) -> Int { s.size }

pub fn ml_rl_ppo_buffer_get(s : MlrlppoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_buffer_set(s : MlrlppoBuffer, i : Int, v : Double) -> MlrlppoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_buffer_sum(s : MlrlppoBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_buffer_mean(s : MlrlppoBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_buffer_scale(s : MlrlppoBuffer, f : Double) -> MlrlppoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_buffer_add(a : MlrlppoBuffer, b : MlrlppoBuffer) -> MlrlppoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_buffer_copy(s : MlrlppoBuffer) -> MlrlppoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_buffer_fill(s : MlrlppoBuffer, v : Double) -> MlrlppoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_buffer_min(s : MlrlppoBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_buffer_max(s : MlrlppoBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_buffer_to_string(s : MlrlppoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_cursor_make(size : Int) -> MlrlppoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_cursor_len(s : MlrlppoCursor) -> Int { s.size }

pub fn ml_rl_ppo_cursor_get(s : MlrlppoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_cursor_set(s : MlrlppoCursor, i : Int, v : Double) -> MlrlppoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cursor_sum(s : MlrlppoCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_cursor_mean(s : MlrlppoCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_cursor_scale(s : MlrlppoCursor, f : Double) -> MlrlppoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cursor_add(a : MlrlppoCursor, b : MlrlppoCursor) -> MlrlppoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_cursor_copy(s : MlrlppoCursor) -> MlrlppoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cursor_fill(s : MlrlppoCursor, v : Double) -> MlrlppoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_cursor_min(s : MlrlppoCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_cursor_max(s : MlrlppoCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_cursor_to_string(s : MlrlppoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_view_make(size : Int) -> MlrlppoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_view_len(s : MlrlppoView) -> Int { s.size }

pub fn ml_rl_ppo_view_get(s : MlrlppoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_view_set(s : MlrlppoView, i : Int, v : Double) -> MlrlppoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_view_sum(s : MlrlppoView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_view_mean(s : MlrlppoView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_view_scale(s : MlrlppoView, f : Double) -> MlrlppoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_view_add(a : MlrlppoView, b : MlrlppoView) -> MlrlppoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_view_copy(s : MlrlppoView) -> MlrlppoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_view_fill(s : MlrlppoView, v : Double) -> MlrlppoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_view_min(s : MlrlppoView) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_view_max(s : MlrlppoView) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_view_to_string(s : MlrlppoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_range_make(size : Int) -> MlrlppoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_range_len(s : MlrlppoRange) -> Int { s.size }

pub fn ml_rl_ppo_range_get(s : MlrlppoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_range_set(s : MlrlppoRange, i : Int, v : Double) -> MlrlppoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_range_sum(s : MlrlppoRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_range_mean(s : MlrlppoRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_range_scale(s : MlrlppoRange, f : Double) -> MlrlppoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_range_add(a : MlrlppoRange, b : MlrlppoRange) -> MlrlppoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_range_copy(s : MlrlppoRange) -> MlrlppoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_range_fill(s : MlrlppoRange, v : Double) -> MlrlppoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_range_min(s : MlrlppoRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_range_max(s : MlrlppoRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_range_to_string(s : MlrlppoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_slice_make(size : Int) -> MlrlppoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_slice_len(s : MlrlppoSlice) -> Int { s.size }

pub fn ml_rl_ppo_slice_get(s : MlrlppoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_slice_set(s : MlrlppoSlice, i : Int, v : Double) -> MlrlppoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_slice_sum(s : MlrlppoSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_slice_mean(s : MlrlppoSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_slice_scale(s : MlrlppoSlice, f : Double) -> MlrlppoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_slice_add(a : MlrlppoSlice, b : MlrlppoSlice) -> MlrlppoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ppo_slice_copy(s : MlrlppoSlice) -> MlrlppoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_slice_fill(s : MlrlppoSlice, v : Double) -> MlrlppoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ppo_slice_min(s : MlrlppoSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_slice_max(s : MlrlppoSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_slice_to_string(s : MlrlppoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

