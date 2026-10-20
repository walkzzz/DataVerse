///===
/// extcore/ml_rl_ddpg

pub(all) struct MlrlddpgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_ddpg_make_point(x : Double, y : Double) -> MlrlddpgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_ddpg_make_point3(x : Double, y : Double, z : Double) -> MlrlddpgPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlddpgPoint::x(self : MlrlddpgPoint) -> Double { self.x }

pub fn MlrlddpgPoint::y(self : MlrlddpgPoint) -> Double { self.y }

pub fn MlrlddpgPoint::z(self : MlrlddpgPoint) -> Double { self.z }

pub fn MlrlddpgPoint::label(self : MlrlddpgPoint) -> Int { self.label }

pub fn MlrlddpgPoint::dist(self : MlrlddpgPoint, other : MlrlddpgPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlddpgPoint::add(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlddpgPoint::sub(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlddpgPoint::scale(self : MlrlddpgPoint, s : Double) -> MlrlddpgPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlddpgPoint::dot(self : MlrlddpgPoint, other : MlrlddpgPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlddpgPoint::cross(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlddpgPoint::norm(self : MlrlddpgPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlddpgPoint::normalize(self : MlrlddpgPoint) -> MlrlddpgPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlddpgPoint::negate(self : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlddpgPoint::mid(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlddpgPoint::lerp(self : MlrlddpgPoint, other : MlrlddpgPoint, t : Double) -> MlrlddpgPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlddpgPoint::to_string(self : MlrlddpgPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlddpgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_ddpg_make_series(vals : Array[Double], name : String) -> MlrlddpgSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlddpgSeries::len(self : MlrlddpgSeries) -> Int { self.vals.length() }

pub fn MlrlddpgSeries::sum(self : MlrlddpgSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlddpgSeries::mean(self : MlrlddpgSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlddpgSeries::min(self : MlrlddpgSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlddpgSeries::max(self : MlrlddpgSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlddpgSeries::range(self : MlrlddpgSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlddpgSeries::variance(self : MlrlddpgSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlddpgSeries::std(self : MlrlddpgSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlddpgSeries::median(self : MlrlddpgSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlddpgSeries::scale(self : MlrlddpgSeries, f : Double) -> MlrlddpgSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlddpgSeries::add(self : MlrlddpgSeries, other : MlrlddpgSeries) -> MlrlddpgSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlddpgSeries::sub(self : MlrlddpgSeries, other : MlrlddpgSeries) -> MlrlddpgSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlddpgSeries::normalize(self : MlrlddpgSeries) -> MlrlddpgSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlddpgSeries::cumsum(self : MlrlddpgSeries) -> MlrlddpgSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlddpgSeries::to_string(self : MlrlddpgSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlddpgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_ddpg_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlddpgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_ddpg_matrix_identity(n : Int) -> MlrlddpgMatrix {
  let m = ml_rl_ddpg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlddpgMatrix::get(self : MlrlddpgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlddpgMatrix::transpose(self : MlrlddpgMatrix) -> MlrlddpgMatrix {
  let result = ml_rl_ddpg_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlddpgMatrix::add(self : MlrlddpgMatrix, other : MlrlddpgMatrix) -> MlrlddpgMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_ddpg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlddpgMatrix::scale(self : MlrlddpgMatrix, s : Double) -> MlrlddpgMatrix {
  let result = ml_rl_ddpg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlddpgMatrix::multiply(self : MlrlddpgMatrix, other : MlrlddpgMatrix) -> MlrlddpgMatrix {
  if self.cols != other.rows { return ml_rl_ddpg_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_ddpg_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlddpgMatrix::trace(self : MlrlddpgMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlddpgMatrix::det(self : MlrlddpgMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlddpgMatrix::norm(self : MlrlddpgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlddpgMatrix::to_string(self : MlrlddpgMatrix) -> String {
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

pub(all) struct MlrlddpgVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_ddpg_make_vector(comps : Array[Double]) -> MlrlddpgVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_ddpg_vector_zero(dim : Int) -> MlrlddpgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlddpgVector::add(self : MlrlddpgVector, other : MlrlddpgVector) -> MlrlddpgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlddpgVector::sub(self : MlrlddpgVector, other : MlrlddpgVector) -> MlrlddpgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlddpgVector::scale(self : MlrlddpgVector, s : Double) -> MlrlddpgVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlddpgVector::dot(self : MlrlddpgVector, other : MlrlddpgVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlddpgVector::norm(self : MlrlddpgVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlddpgVector::normalize(self : MlrlddpgVector) -> MlrlddpgVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlddpgVector::dist(self : MlrlddpgVector, other : MlrlddpgVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlddpgVector::to_string(self : MlrlddpgVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_ddpg_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_ddpg_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_ddpg_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_ddpg_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_ddpg_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_ddpg_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_ddpg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_ddpg_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_ddpg_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_ddpg_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_ddpg_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_ddpg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_ddpg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_ddpg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_ddpg_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_ddpg_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_ddpg_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_ddpg_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_ddpg_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_ddpg_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_ddpg_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_ddpg_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_ddpg_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_ddpg_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_ddpg_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_ddpg_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_ddpg_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_ddpg_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_ddpg_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlddpgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_frame_make(size : Int) -> MlrlddpgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_frame_len(s : MlrlddpgFrame) -> Int { s.size }

pub fn ml_rl_ddpg_frame_get(s : MlrlddpgFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_frame_set(s : MlrlddpgFrame, i : Int, v : Double) -> MlrlddpgFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_frame_sum(s : MlrlddpgFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_frame_mean(s : MlrlddpgFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_frame_scale(s : MlrlddpgFrame, f : Double) -> MlrlddpgFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_frame_add(a : MlrlddpgFrame, b : MlrlddpgFrame) -> MlrlddpgFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_frame_copy(s : MlrlddpgFrame) -> MlrlddpgFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_frame_fill(s : MlrlddpgFrame, v : Double) -> MlrlddpgFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_frame_min(s : MlrlddpgFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_frame_max(s : MlrlddpgFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_frame_to_string(s : MlrlddpgFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_table_make(size : Int) -> MlrlddpgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_table_len(s : MlrlddpgTable) -> Int { s.size }

pub fn ml_rl_ddpg_table_get(s : MlrlddpgTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_table_set(s : MlrlddpgTable, i : Int, v : Double) -> MlrlddpgTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_table_sum(s : MlrlddpgTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_table_mean(s : MlrlddpgTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_table_scale(s : MlrlddpgTable, f : Double) -> MlrlddpgTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_table_add(a : MlrlddpgTable, b : MlrlddpgTable) -> MlrlddpgTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_table_copy(s : MlrlddpgTable) -> MlrlddpgTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_table_fill(s : MlrlddpgTable, v : Double) -> MlrlddpgTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_table_min(s : MlrlddpgTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_table_max(s : MlrlddpgTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_table_to_string(s : MlrlddpgTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_graphn_make(size : Int) -> MlrlddpgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_graphn_len(s : MlrlddpgGraphN) -> Int { s.size }

pub fn ml_rl_ddpg_graphn_get(s : MlrlddpgGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_graphn_set(s : MlrlddpgGraphN, i : Int, v : Double) -> MlrlddpgGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_graphn_sum(s : MlrlddpgGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_graphn_mean(s : MlrlddpgGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_graphn_scale(s : MlrlddpgGraphN, f : Double) -> MlrlddpgGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_graphn_add(a : MlrlddpgGraphN, b : MlrlddpgGraphN) -> MlrlddpgGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_graphn_copy(s : MlrlddpgGraphN) -> MlrlddpgGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_graphn_fill(s : MlrlddpgGraphN, v : Double) -> MlrlddpgGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_graphn_min(s : MlrlddpgGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_graphn_max(s : MlrlddpgGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_graphn_to_string(s : MlrlddpgGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_node_make(size : Int) -> MlrlddpgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_node_len(s : MlrlddpgNode) -> Int { s.size }

pub fn ml_rl_ddpg_node_get(s : MlrlddpgNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_node_set(s : MlrlddpgNode, i : Int, v : Double) -> MlrlddpgNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_node_sum(s : MlrlddpgNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_node_mean(s : MlrlddpgNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_node_scale(s : MlrlddpgNode, f : Double) -> MlrlddpgNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_node_add(a : MlrlddpgNode, b : MlrlddpgNode) -> MlrlddpgNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_node_copy(s : MlrlddpgNode) -> MlrlddpgNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_node_fill(s : MlrlddpgNode, v : Double) -> MlrlddpgNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_node_min(s : MlrlddpgNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_node_max(s : MlrlddpgNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_node_to_string(s : MlrlddpgNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_edge_make(size : Int) -> MlrlddpgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_edge_len(s : MlrlddpgEdge) -> Int { s.size }

pub fn ml_rl_ddpg_edge_get(s : MlrlddpgEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_edge_set(s : MlrlddpgEdge, i : Int, v : Double) -> MlrlddpgEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_edge_sum(s : MlrlddpgEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_edge_mean(s : MlrlddpgEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_edge_scale(s : MlrlddpgEdge, f : Double) -> MlrlddpgEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_edge_add(a : MlrlddpgEdge, b : MlrlddpgEdge) -> MlrlddpgEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_edge_copy(s : MlrlddpgEdge) -> MlrlddpgEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_edge_fill(s : MlrlddpgEdge, v : Double) -> MlrlddpgEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_edge_min(s : MlrlddpgEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_edge_max(s : MlrlddpgEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_edge_to_string(s : MlrlddpgEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_path_make(size : Int) -> MlrlddpgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_path_len(s : MlrlddpgPath) -> Int { s.size }

pub fn ml_rl_ddpg_path_get(s : MlrlddpgPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_path_set(s : MlrlddpgPath, i : Int, v : Double) -> MlrlddpgPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_path_sum(s : MlrlddpgPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_path_mean(s : MlrlddpgPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_path_scale(s : MlrlddpgPath, f : Double) -> MlrlddpgPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_path_add(a : MlrlddpgPath, b : MlrlddpgPath) -> MlrlddpgPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_path_copy(s : MlrlddpgPath) -> MlrlddpgPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_path_fill(s : MlrlddpgPath, v : Double) -> MlrlddpgPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_path_min(s : MlrlddpgPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_path_max(s : MlrlddpgPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_path_to_string(s : MlrlddpgPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_cluster_make(size : Int) -> MlrlddpgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_cluster_len(s : MlrlddpgCluster) -> Int { s.size }

pub fn ml_rl_ddpg_cluster_get(s : MlrlddpgCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_cluster_set(s : MlrlddpgCluster, i : Int, v : Double) -> MlrlddpgCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cluster_sum(s : MlrlddpgCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_cluster_mean(s : MlrlddpgCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_cluster_scale(s : MlrlddpgCluster, f : Double) -> MlrlddpgCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cluster_add(a : MlrlddpgCluster, b : MlrlddpgCluster) -> MlrlddpgCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_cluster_copy(s : MlrlddpgCluster) -> MlrlddpgCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cluster_fill(s : MlrlddpgCluster, v : Double) -> MlrlddpgCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cluster_min(s : MlrlddpgCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_cluster_max(s : MlrlddpgCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_cluster_to_string(s : MlrlddpgCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_model_make(size : Int) -> MlrlddpgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_model_len(s : MlrlddpgModel) -> Int { s.size }

pub fn ml_rl_ddpg_model_get(s : MlrlddpgModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_model_set(s : MlrlddpgModel, i : Int, v : Double) -> MlrlddpgModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_model_sum(s : MlrlddpgModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_model_mean(s : MlrlddpgModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_model_scale(s : MlrlddpgModel, f : Double) -> MlrlddpgModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_model_add(a : MlrlddpgModel, b : MlrlddpgModel) -> MlrlddpgModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_model_copy(s : MlrlddpgModel) -> MlrlddpgModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_model_fill(s : MlrlddpgModel, v : Double) -> MlrlddpgModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_model_min(s : MlrlddpgModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_model_max(s : MlrlddpgModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_model_to_string(s : MlrlddpgModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_layer_make(size : Int) -> MlrlddpgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_layer_len(s : MlrlddpgLayer) -> Int { s.size }

pub fn ml_rl_ddpg_layer_get(s : MlrlddpgLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_layer_set(s : MlrlddpgLayer, i : Int, v : Double) -> MlrlddpgLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_layer_sum(s : MlrlddpgLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_layer_mean(s : MlrlddpgLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_layer_scale(s : MlrlddpgLayer, f : Double) -> MlrlddpgLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_layer_add(a : MlrlddpgLayer, b : MlrlddpgLayer) -> MlrlddpgLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_layer_copy(s : MlrlddpgLayer) -> MlrlddpgLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_layer_fill(s : MlrlddpgLayer, v : Double) -> MlrlddpgLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_layer_min(s : MlrlddpgLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_layer_max(s : MlrlddpgLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_layer_to_string(s : MlrlddpgLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_buffer_make(size : Int) -> MlrlddpgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_buffer_len(s : MlrlddpgBuffer) -> Int { s.size }

pub fn ml_rl_ddpg_buffer_get(s : MlrlddpgBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_buffer_set(s : MlrlddpgBuffer, i : Int, v : Double) -> MlrlddpgBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_buffer_sum(s : MlrlddpgBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_buffer_mean(s : MlrlddpgBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_buffer_scale(s : MlrlddpgBuffer, f : Double) -> MlrlddpgBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_buffer_add(a : MlrlddpgBuffer, b : MlrlddpgBuffer) -> MlrlddpgBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_buffer_copy(s : MlrlddpgBuffer) -> MlrlddpgBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_buffer_fill(s : MlrlddpgBuffer, v : Double) -> MlrlddpgBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_buffer_min(s : MlrlddpgBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_buffer_max(s : MlrlddpgBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_buffer_to_string(s : MlrlddpgBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_cursor_make(size : Int) -> MlrlddpgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_cursor_len(s : MlrlddpgCursor) -> Int { s.size }

pub fn ml_rl_ddpg_cursor_get(s : MlrlddpgCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_cursor_set(s : MlrlddpgCursor, i : Int, v : Double) -> MlrlddpgCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cursor_sum(s : MlrlddpgCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_cursor_mean(s : MlrlddpgCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_cursor_scale(s : MlrlddpgCursor, f : Double) -> MlrlddpgCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cursor_add(a : MlrlddpgCursor, b : MlrlddpgCursor) -> MlrlddpgCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_cursor_copy(s : MlrlddpgCursor) -> MlrlddpgCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cursor_fill(s : MlrlddpgCursor, v : Double) -> MlrlddpgCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_cursor_min(s : MlrlddpgCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_cursor_max(s : MlrlddpgCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_cursor_to_string(s : MlrlddpgCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_view_make(size : Int) -> MlrlddpgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_view_len(s : MlrlddpgView) -> Int { s.size }

pub fn ml_rl_ddpg_view_get(s : MlrlddpgView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_view_set(s : MlrlddpgView, i : Int, v : Double) -> MlrlddpgView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_view_sum(s : MlrlddpgView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_view_mean(s : MlrlddpgView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_view_scale(s : MlrlddpgView, f : Double) -> MlrlddpgView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_view_add(a : MlrlddpgView, b : MlrlddpgView) -> MlrlddpgView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_view_copy(s : MlrlddpgView) -> MlrlddpgView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_view_fill(s : MlrlddpgView, v : Double) -> MlrlddpgView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_view_min(s : MlrlddpgView) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_view_max(s : MlrlddpgView) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_view_to_string(s : MlrlddpgView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_range_make(size : Int) -> MlrlddpgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_range_len(s : MlrlddpgRange) -> Int { s.size }

pub fn ml_rl_ddpg_range_get(s : MlrlddpgRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_range_set(s : MlrlddpgRange, i : Int, v : Double) -> MlrlddpgRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_range_sum(s : MlrlddpgRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_range_mean(s : MlrlddpgRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_range_scale(s : MlrlddpgRange, f : Double) -> MlrlddpgRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_range_add(a : MlrlddpgRange, b : MlrlddpgRange) -> MlrlddpgRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_range_copy(s : MlrlddpgRange) -> MlrlddpgRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_range_fill(s : MlrlddpgRange, v : Double) -> MlrlddpgRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_range_min(s : MlrlddpgRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_range_max(s : MlrlddpgRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_range_to_string(s : MlrlddpgRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_slice_make(size : Int) -> MlrlddpgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_slice_len(s : MlrlddpgSlice) -> Int { s.size }

pub fn ml_rl_ddpg_slice_get(s : MlrlddpgSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_slice_set(s : MlrlddpgSlice, i : Int, v : Double) -> MlrlddpgSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_slice_sum(s : MlrlddpgSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ddpg_slice_mean(s : MlrlddpgSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ddpg_slice_scale(s : MlrlddpgSlice, f : Double) -> MlrlddpgSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_slice_add(a : MlrlddpgSlice, b : MlrlddpgSlice) -> MlrlddpgSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_ddpg_slice_copy(s : MlrlddpgSlice) -> MlrlddpgSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_slice_fill(s : MlrlddpgSlice, v : Double) -> MlrlddpgSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_ddpg_slice_min(s : MlrlddpgSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_ddpg_slice_max(s : MlrlddpgSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_ddpg_slice_to_string(s : MlrlddpgSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

