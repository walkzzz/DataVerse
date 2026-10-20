///===
/// extcore/ml_rl_trpo

pub(all) struct MlrltrpoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_trpo_make_point(x : Double, y : Double) -> MlrltrpoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_trpo_make_point3(x : Double, y : Double, z : Double) -> MlrltrpoPoint {
  { x, y, z, label: 0 }
}

pub fn MlrltrpoPoint::x(self : MlrltrpoPoint) -> Double { self.x }

pub fn MlrltrpoPoint::y(self : MlrltrpoPoint) -> Double { self.y }

pub fn MlrltrpoPoint::z(self : MlrltrpoPoint) -> Double { self.z }

pub fn MlrltrpoPoint::label(self : MlrltrpoPoint) -> Int { self.label }

pub fn MlrltrpoPoint::dist(self : MlrltrpoPoint, other : MlrltrpoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrltrpoPoint::add(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrltrpoPoint::sub(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrltrpoPoint::scale(self : MlrltrpoPoint, s : Double) -> MlrltrpoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrltrpoPoint::dot(self : MlrltrpoPoint, other : MlrltrpoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrltrpoPoint::cross(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrltrpoPoint::norm(self : MlrltrpoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrltrpoPoint::normalize(self : MlrltrpoPoint) -> MlrltrpoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrltrpoPoint::negate(self : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrltrpoPoint::mid(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrltrpoPoint::lerp(self : MlrltrpoPoint, other : MlrltrpoPoint, t : Double) -> MlrltrpoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrltrpoPoint::to_string(self : MlrltrpoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrltrpoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_trpo_make_series(vals : Array[Double], name : String) -> MlrltrpoSeries {
  { vals, name, meta: 0 }
}

pub fn MlrltrpoSeries::len(self : MlrltrpoSeries) -> Int { self.vals.length() }

pub fn MlrltrpoSeries::sum(self : MlrltrpoSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrltrpoSeries::mean(self : MlrltrpoSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrltrpoSeries::min(self : MlrltrpoSeries) -> Double { @_common.min(self.vals) }

pub fn MlrltrpoSeries::max(self : MlrltrpoSeries) -> Double { @_common.max(self.vals) }

pub fn MlrltrpoSeries::range(self : MlrltrpoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrltrpoSeries::variance(self : MlrltrpoSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrltrpoSeries::std(self : MlrltrpoSeries) -> Double { @_common.std(self.vals) }

pub fn MlrltrpoSeries::median(self : MlrltrpoSeries) -> Double { @_common.median(self.vals) }

pub fn MlrltrpoSeries::scale(self : MlrltrpoSeries, f : Double) -> MlrltrpoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrltrpoSeries::add(self : MlrltrpoSeries, other : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrltrpoSeries::sub(self : MlrltrpoSeries, other : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrltrpoSeries::normalize(self : MlrltrpoSeries) -> MlrltrpoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrltrpoSeries::cumsum(self : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrltrpoSeries::to_string(self : MlrltrpoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrltrpoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_trpo_make_matrix(rows : Int, cols : Int, val : Double) -> MlrltrpoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_trpo_matrix_identity(n : Int) -> MlrltrpoMatrix {
  let m = ml_rl_trpo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrltrpoMatrix::get(self : MlrltrpoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrltrpoMatrix::transpose(self : MlrltrpoMatrix) -> MlrltrpoMatrix {
  let result = ml_rl_trpo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrltrpoMatrix::add(self : MlrltrpoMatrix, other : MlrltrpoMatrix) -> MlrltrpoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_trpo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrltrpoMatrix::scale(self : MlrltrpoMatrix, s : Double) -> MlrltrpoMatrix {
  let result = ml_rl_trpo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrltrpoMatrix::multiply(self : MlrltrpoMatrix, other : MlrltrpoMatrix) -> MlrltrpoMatrix {
  if self.cols != other.rows { return ml_rl_trpo_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_trpo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrltrpoMatrix::trace(self : MlrltrpoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrltrpoMatrix::det(self : MlrltrpoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrltrpoMatrix::norm(self : MlrltrpoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrltrpoMatrix::to_string(self : MlrltrpoMatrix) -> String {
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

pub(all) struct MlrltrpoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_trpo_make_vector(comps : Array[Double]) -> MlrltrpoVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_trpo_vector_zero(dim : Int) -> MlrltrpoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrltrpoVector::add(self : MlrltrpoVector, other : MlrltrpoVector) -> MlrltrpoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrltrpoVector::sub(self : MlrltrpoVector, other : MlrltrpoVector) -> MlrltrpoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrltrpoVector::scale(self : MlrltrpoVector, s : Double) -> MlrltrpoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrltrpoVector::dot(self : MlrltrpoVector, other : MlrltrpoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrltrpoVector::norm(self : MlrltrpoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrltrpoVector::normalize(self : MlrltrpoVector) -> MlrltrpoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrltrpoVector::dist(self : MlrltrpoVector, other : MlrltrpoVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrltrpoVector::to_string(self : MlrltrpoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_trpo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_trpo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_trpo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_trpo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_trpo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_trpo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_trpo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_trpo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_trpo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_trpo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_trpo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_trpo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_trpo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_trpo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_trpo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_trpo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_trpo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_trpo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_trpo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_trpo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_trpo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_trpo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_trpo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_trpo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_trpo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_trpo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_trpo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_trpo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_trpo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrltrpoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_frame_make(size : Int) -> MlrltrpoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_frame_len(s : MlrltrpoFrame) -> Int { s.size }

pub fn ml_rl_trpo_frame_get(s : MlrltrpoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_frame_set(s : MlrltrpoFrame, i : Int, v : Double) -> MlrltrpoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_sum(s : MlrltrpoFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_frame_mean(s : MlrltrpoFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_frame_scale(s : MlrltrpoFrame, f : Double) -> MlrltrpoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_add(a : MlrltrpoFrame, b : MlrltrpoFrame) -> MlrltrpoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_frame_copy(s : MlrltrpoFrame) -> MlrltrpoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_fill(s : MlrltrpoFrame, v : Double) -> MlrltrpoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_frame_min(s : MlrltrpoFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_frame_max(s : MlrltrpoFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_frame_to_string(s : MlrltrpoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_table_make(size : Int) -> MlrltrpoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_table_len(s : MlrltrpoTable) -> Int { s.size }

pub fn ml_rl_trpo_table_get(s : MlrltrpoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_table_set(s : MlrltrpoTable, i : Int, v : Double) -> MlrltrpoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_sum(s : MlrltrpoTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_table_mean(s : MlrltrpoTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_table_scale(s : MlrltrpoTable, f : Double) -> MlrltrpoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_add(a : MlrltrpoTable, b : MlrltrpoTable) -> MlrltrpoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_table_copy(s : MlrltrpoTable) -> MlrltrpoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_fill(s : MlrltrpoTable, v : Double) -> MlrltrpoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_table_min(s : MlrltrpoTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_table_max(s : MlrltrpoTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_table_to_string(s : MlrltrpoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_graphn_make(size : Int) -> MlrltrpoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_graphn_len(s : MlrltrpoGraphN) -> Int { s.size }

pub fn ml_rl_trpo_graphn_get(s : MlrltrpoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_graphn_set(s : MlrltrpoGraphN, i : Int, v : Double) -> MlrltrpoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_sum(s : MlrltrpoGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_graphn_mean(s : MlrltrpoGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_graphn_scale(s : MlrltrpoGraphN, f : Double) -> MlrltrpoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_add(a : MlrltrpoGraphN, b : MlrltrpoGraphN) -> MlrltrpoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_graphn_copy(s : MlrltrpoGraphN) -> MlrltrpoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_fill(s : MlrltrpoGraphN, v : Double) -> MlrltrpoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_graphn_min(s : MlrltrpoGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_graphn_max(s : MlrltrpoGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_graphn_to_string(s : MlrltrpoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_node_make(size : Int) -> MlrltrpoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_node_len(s : MlrltrpoNode) -> Int { s.size }

pub fn ml_rl_trpo_node_get(s : MlrltrpoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_node_set(s : MlrltrpoNode, i : Int, v : Double) -> MlrltrpoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_sum(s : MlrltrpoNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_node_mean(s : MlrltrpoNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_node_scale(s : MlrltrpoNode, f : Double) -> MlrltrpoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_add(a : MlrltrpoNode, b : MlrltrpoNode) -> MlrltrpoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_node_copy(s : MlrltrpoNode) -> MlrltrpoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_fill(s : MlrltrpoNode, v : Double) -> MlrltrpoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_node_min(s : MlrltrpoNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_node_max(s : MlrltrpoNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_node_to_string(s : MlrltrpoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_edge_make(size : Int) -> MlrltrpoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_edge_len(s : MlrltrpoEdge) -> Int { s.size }

pub fn ml_rl_trpo_edge_get(s : MlrltrpoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_edge_set(s : MlrltrpoEdge, i : Int, v : Double) -> MlrltrpoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_sum(s : MlrltrpoEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_edge_mean(s : MlrltrpoEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_edge_scale(s : MlrltrpoEdge, f : Double) -> MlrltrpoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_add(a : MlrltrpoEdge, b : MlrltrpoEdge) -> MlrltrpoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_edge_copy(s : MlrltrpoEdge) -> MlrltrpoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_fill(s : MlrltrpoEdge, v : Double) -> MlrltrpoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_edge_min(s : MlrltrpoEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_edge_max(s : MlrltrpoEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_edge_to_string(s : MlrltrpoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_path_make(size : Int) -> MlrltrpoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_path_len(s : MlrltrpoPath) -> Int { s.size }

pub fn ml_rl_trpo_path_get(s : MlrltrpoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_path_set(s : MlrltrpoPath, i : Int, v : Double) -> MlrltrpoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_sum(s : MlrltrpoPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_path_mean(s : MlrltrpoPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_path_scale(s : MlrltrpoPath, f : Double) -> MlrltrpoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_add(a : MlrltrpoPath, b : MlrltrpoPath) -> MlrltrpoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_path_copy(s : MlrltrpoPath) -> MlrltrpoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_fill(s : MlrltrpoPath, v : Double) -> MlrltrpoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_path_min(s : MlrltrpoPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_path_max(s : MlrltrpoPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_path_to_string(s : MlrltrpoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_cluster_make(size : Int) -> MlrltrpoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_cluster_len(s : MlrltrpoCluster) -> Int { s.size }

pub fn ml_rl_trpo_cluster_get(s : MlrltrpoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_cluster_set(s : MlrltrpoCluster, i : Int, v : Double) -> MlrltrpoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_sum(s : MlrltrpoCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_cluster_mean(s : MlrltrpoCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_cluster_scale(s : MlrltrpoCluster, f : Double) -> MlrltrpoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_add(a : MlrltrpoCluster, b : MlrltrpoCluster) -> MlrltrpoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_cluster_copy(s : MlrltrpoCluster) -> MlrltrpoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_fill(s : MlrltrpoCluster, v : Double) -> MlrltrpoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cluster_min(s : MlrltrpoCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_cluster_max(s : MlrltrpoCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_cluster_to_string(s : MlrltrpoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_model_make(size : Int) -> MlrltrpoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_model_len(s : MlrltrpoModel) -> Int { s.size }

pub fn ml_rl_trpo_model_get(s : MlrltrpoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_model_set(s : MlrltrpoModel, i : Int, v : Double) -> MlrltrpoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_sum(s : MlrltrpoModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_model_mean(s : MlrltrpoModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_model_scale(s : MlrltrpoModel, f : Double) -> MlrltrpoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_add(a : MlrltrpoModel, b : MlrltrpoModel) -> MlrltrpoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_model_copy(s : MlrltrpoModel) -> MlrltrpoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_fill(s : MlrltrpoModel, v : Double) -> MlrltrpoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_model_min(s : MlrltrpoModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_model_max(s : MlrltrpoModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_model_to_string(s : MlrltrpoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_layer_make(size : Int) -> MlrltrpoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_layer_len(s : MlrltrpoLayer) -> Int { s.size }

pub fn ml_rl_trpo_layer_get(s : MlrltrpoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_layer_set(s : MlrltrpoLayer, i : Int, v : Double) -> MlrltrpoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_sum(s : MlrltrpoLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_layer_mean(s : MlrltrpoLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_layer_scale(s : MlrltrpoLayer, f : Double) -> MlrltrpoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_add(a : MlrltrpoLayer, b : MlrltrpoLayer) -> MlrltrpoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_layer_copy(s : MlrltrpoLayer) -> MlrltrpoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_fill(s : MlrltrpoLayer, v : Double) -> MlrltrpoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_layer_min(s : MlrltrpoLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_layer_max(s : MlrltrpoLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_layer_to_string(s : MlrltrpoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_buffer_make(size : Int) -> MlrltrpoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_buffer_len(s : MlrltrpoBuffer) -> Int { s.size }

pub fn ml_rl_trpo_buffer_get(s : MlrltrpoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_buffer_set(s : MlrltrpoBuffer, i : Int, v : Double) -> MlrltrpoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_sum(s : MlrltrpoBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_buffer_mean(s : MlrltrpoBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_buffer_scale(s : MlrltrpoBuffer, f : Double) -> MlrltrpoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_add(a : MlrltrpoBuffer, b : MlrltrpoBuffer) -> MlrltrpoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_buffer_copy(s : MlrltrpoBuffer) -> MlrltrpoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_fill(s : MlrltrpoBuffer, v : Double) -> MlrltrpoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_buffer_min(s : MlrltrpoBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_buffer_max(s : MlrltrpoBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_buffer_to_string(s : MlrltrpoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_cursor_make(size : Int) -> MlrltrpoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_cursor_len(s : MlrltrpoCursor) -> Int { s.size }

pub fn ml_rl_trpo_cursor_get(s : MlrltrpoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_cursor_set(s : MlrltrpoCursor, i : Int, v : Double) -> MlrltrpoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_sum(s : MlrltrpoCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_cursor_mean(s : MlrltrpoCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_cursor_scale(s : MlrltrpoCursor, f : Double) -> MlrltrpoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_add(a : MlrltrpoCursor, b : MlrltrpoCursor) -> MlrltrpoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_cursor_copy(s : MlrltrpoCursor) -> MlrltrpoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_fill(s : MlrltrpoCursor, v : Double) -> MlrltrpoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_cursor_min(s : MlrltrpoCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_cursor_max(s : MlrltrpoCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_cursor_to_string(s : MlrltrpoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_view_make(size : Int) -> MlrltrpoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_view_len(s : MlrltrpoView) -> Int { s.size }

pub fn ml_rl_trpo_view_get(s : MlrltrpoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_view_set(s : MlrltrpoView, i : Int, v : Double) -> MlrltrpoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_sum(s : MlrltrpoView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_view_mean(s : MlrltrpoView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_view_scale(s : MlrltrpoView, f : Double) -> MlrltrpoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_add(a : MlrltrpoView, b : MlrltrpoView) -> MlrltrpoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_view_copy(s : MlrltrpoView) -> MlrltrpoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_fill(s : MlrltrpoView, v : Double) -> MlrltrpoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_view_min(s : MlrltrpoView) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_view_max(s : MlrltrpoView) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_view_to_string(s : MlrltrpoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_range_make(size : Int) -> MlrltrpoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_range_len(s : MlrltrpoRange) -> Int { s.size }

pub fn ml_rl_trpo_range_get(s : MlrltrpoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_range_set(s : MlrltrpoRange, i : Int, v : Double) -> MlrltrpoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_sum(s : MlrltrpoRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_range_mean(s : MlrltrpoRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_range_scale(s : MlrltrpoRange, f : Double) -> MlrltrpoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_add(a : MlrltrpoRange, b : MlrltrpoRange) -> MlrltrpoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_range_copy(s : MlrltrpoRange) -> MlrltrpoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_fill(s : MlrltrpoRange, v : Double) -> MlrltrpoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_range_min(s : MlrltrpoRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_range_max(s : MlrltrpoRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_range_to_string(s : MlrltrpoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrltrpoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_slice_make(size : Int) -> MlrltrpoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_trpo_slice_len(s : MlrltrpoSlice) -> Int { s.size }

pub fn ml_rl_trpo_slice_get(s : MlrltrpoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_trpo_slice_set(s : MlrltrpoSlice, i : Int, v : Double) -> MlrltrpoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_sum(s : MlrltrpoSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_trpo_slice_mean(s : MlrltrpoSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_trpo_slice_scale(s : MlrltrpoSlice, f : Double) -> MlrltrpoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_add(a : MlrltrpoSlice, b : MlrltrpoSlice) -> MlrltrpoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_trpo_slice_copy(s : MlrltrpoSlice) -> MlrltrpoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_fill(s : MlrltrpoSlice, v : Double) -> MlrltrpoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_trpo_slice_min(s : MlrltrpoSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_trpo_slice_max(s : MlrltrpoSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_trpo_slice_to_string(s : MlrltrpoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

