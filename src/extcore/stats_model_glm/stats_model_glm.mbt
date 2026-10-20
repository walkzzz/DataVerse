///===
/// extcore/stats_model_glm

pub(all) struct StatsmodelglmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_glm_make_point(x : Double, y : Double) -> StatsmodelglmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_glm_make_point3(x : Double, y : Double, z : Double) -> StatsmodelglmPoint {
  { x, y, z, label: 0 }
}

pub fn StatsmodelglmPoint::x(self : StatsmodelglmPoint) -> Double { self.x }

pub fn StatsmodelglmPoint::y(self : StatsmodelglmPoint) -> Double { self.y }

pub fn StatsmodelglmPoint::z(self : StatsmodelglmPoint) -> Double { self.z }

pub fn StatsmodelglmPoint::label(self : StatsmodelglmPoint) -> Int { self.label }

pub fn StatsmodelglmPoint::dist(self : StatsmodelglmPoint, other : StatsmodelglmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsmodelglmPoint::add(self : StatsmodelglmPoint, other : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsmodelglmPoint::sub(self : StatsmodelglmPoint, other : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsmodelglmPoint::scale(self : StatsmodelglmPoint, s : Double) -> StatsmodelglmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsmodelglmPoint::dot(self : StatsmodelglmPoint, other : StatsmodelglmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsmodelglmPoint::cross(self : StatsmodelglmPoint, other : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsmodelglmPoint::norm(self : StatsmodelglmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsmodelglmPoint::normalize(self : StatsmodelglmPoint) -> StatsmodelglmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelglmPoint::negate(self : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsmodelglmPoint::mid(self : StatsmodelglmPoint, other : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsmodelglmPoint::lerp(self : StatsmodelglmPoint, other : StatsmodelglmPoint, t : Double) -> StatsmodelglmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsmodelglmPoint::to_string(self : StatsmodelglmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsmodelglmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_glm_make_series(vals : Array[Double], name : String) -> StatsmodelglmSeries {
  { vals, name, meta: 0 }
}

pub fn StatsmodelglmSeries::len(self : StatsmodelglmSeries) -> Int { self.vals.length() }

pub fn StatsmodelglmSeries::sum(self : StatsmodelglmSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsmodelglmSeries::mean(self : StatsmodelglmSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsmodelglmSeries::min(self : StatsmodelglmSeries) -> Double { @_common.min(self.vals) }

pub fn StatsmodelglmSeries::max(self : StatsmodelglmSeries) -> Double { @_common.max(self.vals) }

pub fn StatsmodelglmSeries::range(self : StatsmodelglmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsmodelglmSeries::variance(self : StatsmodelglmSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsmodelglmSeries::std(self : StatsmodelglmSeries) -> Double { @_common.std(self.vals) }

pub fn StatsmodelglmSeries::median(self : StatsmodelglmSeries) -> Double { @_common.median(self.vals) }

pub fn StatsmodelglmSeries::scale(self : StatsmodelglmSeries, f : Double) -> StatsmodelglmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsmodelglmSeries::add(self : StatsmodelglmSeries, other : StatsmodelglmSeries) -> StatsmodelglmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsmodelglmSeries::sub(self : StatsmodelglmSeries, other : StatsmodelglmSeries) -> StatsmodelglmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsmodelglmSeries::normalize(self : StatsmodelglmSeries) -> StatsmodelglmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsmodelglmSeries::cumsum(self : StatsmodelglmSeries) -> StatsmodelglmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsmodelglmSeries::to_string(self : StatsmodelglmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelglmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_glm_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelglmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_glm_matrix_identity(n : Int) -> StatsmodelglmMatrix {
  let m = stats_model_glm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsmodelglmMatrix::get(self : StatsmodelglmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsmodelglmMatrix::transpose(self : StatsmodelglmMatrix) -> StatsmodelglmMatrix {
  let result = stats_model_glm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsmodelglmMatrix::add(self : StatsmodelglmMatrix, other : StatsmodelglmMatrix) -> StatsmodelglmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_model_glm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsmodelglmMatrix::scale(self : StatsmodelglmMatrix, s : Double) -> StatsmodelglmMatrix {
  let result = stats_model_glm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsmodelglmMatrix::multiply(self : StatsmodelglmMatrix, other : StatsmodelglmMatrix) -> StatsmodelglmMatrix {
  if self.cols != other.rows { return stats_model_glm_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_model_glm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsmodelglmMatrix::trace(self : StatsmodelglmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsmodelglmMatrix::det(self : StatsmodelglmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsmodelglmMatrix::norm(self : StatsmodelglmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsmodelglmMatrix::to_string(self : StatsmodelglmMatrix) -> String {
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

pub(all) struct StatsmodelglmVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_glm_make_vector(comps : Array[Double]) -> StatsmodelglmVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_glm_vector_zero(dim : Int) -> StatsmodelglmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsmodelglmVector::add(self : StatsmodelglmVector, other : StatsmodelglmVector) -> StatsmodelglmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelglmVector::sub(self : StatsmodelglmVector, other : StatsmodelglmVector) -> StatsmodelglmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelglmVector::scale(self : StatsmodelglmVector, s : Double) -> StatsmodelglmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsmodelglmVector::dot(self : StatsmodelglmVector, other : StatsmodelglmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsmodelglmVector::norm(self : StatsmodelglmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsmodelglmVector::normalize(self : StatsmodelglmVector) -> StatsmodelglmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelglmVector::dist(self : StatsmodelglmVector, other : StatsmodelglmVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsmodelglmVector::to_string(self : StatsmodelglmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_glm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_glm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_glm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_glm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_glm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_glm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_glm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_glm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_glm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_glm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_glm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_glm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_glm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_glm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_glm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_glm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_glm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_glm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_glm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_glm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_glm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_glm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_glm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_glm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_glm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_glm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_glm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_glm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_glm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodelglmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_frame_make(size : Int) -> StatsmodelglmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_frame_len(s : StatsmodelglmFrame) -> Int { s.size }

pub fn stats_model_glm_frame_get(s : StatsmodelglmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_frame_set(s : StatsmodelglmFrame, i : Int, v : Double) -> StatsmodelglmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_frame_sum(s : StatsmodelglmFrame) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_frame_mean(s : StatsmodelglmFrame) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_frame_scale(s : StatsmodelglmFrame, f : Double) -> StatsmodelglmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_frame_add(a : StatsmodelglmFrame, b : StatsmodelglmFrame) -> StatsmodelglmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_frame_copy(s : StatsmodelglmFrame) -> StatsmodelglmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_frame_fill(s : StatsmodelglmFrame, v : Double) -> StatsmodelglmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_frame_min(s : StatsmodelglmFrame) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_frame_max(s : StatsmodelglmFrame) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_frame_to_string(s : StatsmodelglmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_table_make(size : Int) -> StatsmodelglmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_table_len(s : StatsmodelglmTable) -> Int { s.size }

pub fn stats_model_glm_table_get(s : StatsmodelglmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_table_set(s : StatsmodelglmTable, i : Int, v : Double) -> StatsmodelglmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_table_sum(s : StatsmodelglmTable) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_table_mean(s : StatsmodelglmTable) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_table_scale(s : StatsmodelglmTable, f : Double) -> StatsmodelglmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_table_add(a : StatsmodelglmTable, b : StatsmodelglmTable) -> StatsmodelglmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_table_copy(s : StatsmodelglmTable) -> StatsmodelglmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_table_fill(s : StatsmodelglmTable, v : Double) -> StatsmodelglmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_table_min(s : StatsmodelglmTable) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_table_max(s : StatsmodelglmTable) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_table_to_string(s : StatsmodelglmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_graphn_make(size : Int) -> StatsmodelglmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_graphn_len(s : StatsmodelglmGraphN) -> Int { s.size }

pub fn stats_model_glm_graphn_get(s : StatsmodelglmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_graphn_set(s : StatsmodelglmGraphN, i : Int, v : Double) -> StatsmodelglmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_graphn_sum(s : StatsmodelglmGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_graphn_mean(s : StatsmodelglmGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_graphn_scale(s : StatsmodelglmGraphN, f : Double) -> StatsmodelglmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_graphn_add(a : StatsmodelglmGraphN, b : StatsmodelglmGraphN) -> StatsmodelglmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_graphn_copy(s : StatsmodelglmGraphN) -> StatsmodelglmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_graphn_fill(s : StatsmodelglmGraphN, v : Double) -> StatsmodelglmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_graphn_min(s : StatsmodelglmGraphN) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_graphn_max(s : StatsmodelglmGraphN) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_graphn_to_string(s : StatsmodelglmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_node_make(size : Int) -> StatsmodelglmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_node_len(s : StatsmodelglmNode) -> Int { s.size }

pub fn stats_model_glm_node_get(s : StatsmodelglmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_node_set(s : StatsmodelglmNode, i : Int, v : Double) -> StatsmodelglmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_node_sum(s : StatsmodelglmNode) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_node_mean(s : StatsmodelglmNode) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_node_scale(s : StatsmodelglmNode, f : Double) -> StatsmodelglmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_node_add(a : StatsmodelglmNode, b : StatsmodelglmNode) -> StatsmodelglmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_node_copy(s : StatsmodelglmNode) -> StatsmodelglmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_node_fill(s : StatsmodelglmNode, v : Double) -> StatsmodelglmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_node_min(s : StatsmodelglmNode) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_node_max(s : StatsmodelglmNode) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_node_to_string(s : StatsmodelglmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_edge_make(size : Int) -> StatsmodelglmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_edge_len(s : StatsmodelglmEdge) -> Int { s.size }

pub fn stats_model_glm_edge_get(s : StatsmodelglmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_edge_set(s : StatsmodelglmEdge, i : Int, v : Double) -> StatsmodelglmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_edge_sum(s : StatsmodelglmEdge) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_edge_mean(s : StatsmodelglmEdge) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_edge_scale(s : StatsmodelglmEdge, f : Double) -> StatsmodelglmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_edge_add(a : StatsmodelglmEdge, b : StatsmodelglmEdge) -> StatsmodelglmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_edge_copy(s : StatsmodelglmEdge) -> StatsmodelglmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_edge_fill(s : StatsmodelglmEdge, v : Double) -> StatsmodelglmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_edge_min(s : StatsmodelglmEdge) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_edge_max(s : StatsmodelglmEdge) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_edge_to_string(s : StatsmodelglmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_path_make(size : Int) -> StatsmodelglmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_path_len(s : StatsmodelglmPath) -> Int { s.size }

pub fn stats_model_glm_path_get(s : StatsmodelglmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_path_set(s : StatsmodelglmPath, i : Int, v : Double) -> StatsmodelglmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_path_sum(s : StatsmodelglmPath) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_path_mean(s : StatsmodelglmPath) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_path_scale(s : StatsmodelglmPath, f : Double) -> StatsmodelglmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_path_add(a : StatsmodelglmPath, b : StatsmodelglmPath) -> StatsmodelglmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_path_copy(s : StatsmodelglmPath) -> StatsmodelglmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_path_fill(s : StatsmodelglmPath, v : Double) -> StatsmodelglmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_path_min(s : StatsmodelglmPath) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_path_max(s : StatsmodelglmPath) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_path_to_string(s : StatsmodelglmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_cluster_make(size : Int) -> StatsmodelglmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_cluster_len(s : StatsmodelglmCluster) -> Int { s.size }

pub fn stats_model_glm_cluster_get(s : StatsmodelglmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_cluster_set(s : StatsmodelglmCluster, i : Int, v : Double) -> StatsmodelglmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cluster_sum(s : StatsmodelglmCluster) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_cluster_mean(s : StatsmodelglmCluster) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_cluster_scale(s : StatsmodelglmCluster, f : Double) -> StatsmodelglmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cluster_add(a : StatsmodelglmCluster, b : StatsmodelglmCluster) -> StatsmodelglmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_cluster_copy(s : StatsmodelglmCluster) -> StatsmodelglmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cluster_fill(s : StatsmodelglmCluster, v : Double) -> StatsmodelglmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cluster_min(s : StatsmodelglmCluster) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_cluster_max(s : StatsmodelglmCluster) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_cluster_to_string(s : StatsmodelglmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_model_make(size : Int) -> StatsmodelglmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_model_len(s : StatsmodelglmModel) -> Int { s.size }

pub fn stats_model_glm_model_get(s : StatsmodelglmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_model_set(s : StatsmodelglmModel, i : Int, v : Double) -> StatsmodelglmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_model_sum(s : StatsmodelglmModel) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_model_mean(s : StatsmodelglmModel) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_model_scale(s : StatsmodelglmModel, f : Double) -> StatsmodelglmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_model_add(a : StatsmodelglmModel, b : StatsmodelglmModel) -> StatsmodelglmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_model_copy(s : StatsmodelglmModel) -> StatsmodelglmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_model_fill(s : StatsmodelglmModel, v : Double) -> StatsmodelglmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_model_min(s : StatsmodelglmModel) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_model_max(s : StatsmodelglmModel) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_model_to_string(s : StatsmodelglmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_layer_make(size : Int) -> StatsmodelglmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_layer_len(s : StatsmodelglmLayer) -> Int { s.size }

pub fn stats_model_glm_layer_get(s : StatsmodelglmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_layer_set(s : StatsmodelglmLayer, i : Int, v : Double) -> StatsmodelglmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_layer_sum(s : StatsmodelglmLayer) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_layer_mean(s : StatsmodelglmLayer) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_layer_scale(s : StatsmodelglmLayer, f : Double) -> StatsmodelglmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_layer_add(a : StatsmodelglmLayer, b : StatsmodelglmLayer) -> StatsmodelglmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_layer_copy(s : StatsmodelglmLayer) -> StatsmodelglmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_layer_fill(s : StatsmodelglmLayer, v : Double) -> StatsmodelglmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_layer_min(s : StatsmodelglmLayer) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_layer_max(s : StatsmodelglmLayer) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_layer_to_string(s : StatsmodelglmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_buffer_make(size : Int) -> StatsmodelglmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_buffer_len(s : StatsmodelglmBuffer) -> Int { s.size }

pub fn stats_model_glm_buffer_get(s : StatsmodelglmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_buffer_set(s : StatsmodelglmBuffer, i : Int, v : Double) -> StatsmodelglmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_buffer_sum(s : StatsmodelglmBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_buffer_mean(s : StatsmodelglmBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_buffer_scale(s : StatsmodelglmBuffer, f : Double) -> StatsmodelglmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_buffer_add(a : StatsmodelglmBuffer, b : StatsmodelglmBuffer) -> StatsmodelglmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_buffer_copy(s : StatsmodelglmBuffer) -> StatsmodelglmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_buffer_fill(s : StatsmodelglmBuffer, v : Double) -> StatsmodelglmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_buffer_min(s : StatsmodelglmBuffer) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_buffer_max(s : StatsmodelglmBuffer) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_buffer_to_string(s : StatsmodelglmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_cursor_make(size : Int) -> StatsmodelglmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_cursor_len(s : StatsmodelglmCursor) -> Int { s.size }

pub fn stats_model_glm_cursor_get(s : StatsmodelglmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_cursor_set(s : StatsmodelglmCursor, i : Int, v : Double) -> StatsmodelglmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cursor_sum(s : StatsmodelglmCursor) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_cursor_mean(s : StatsmodelglmCursor) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_cursor_scale(s : StatsmodelglmCursor, f : Double) -> StatsmodelglmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cursor_add(a : StatsmodelglmCursor, b : StatsmodelglmCursor) -> StatsmodelglmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_cursor_copy(s : StatsmodelglmCursor) -> StatsmodelglmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cursor_fill(s : StatsmodelglmCursor, v : Double) -> StatsmodelglmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_cursor_min(s : StatsmodelglmCursor) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_cursor_max(s : StatsmodelglmCursor) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_cursor_to_string(s : StatsmodelglmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_view_make(size : Int) -> StatsmodelglmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_view_len(s : StatsmodelglmView) -> Int { s.size }

pub fn stats_model_glm_view_get(s : StatsmodelglmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_view_set(s : StatsmodelglmView, i : Int, v : Double) -> StatsmodelglmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_view_sum(s : StatsmodelglmView) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_view_mean(s : StatsmodelglmView) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_view_scale(s : StatsmodelglmView, f : Double) -> StatsmodelglmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_view_add(a : StatsmodelglmView, b : StatsmodelglmView) -> StatsmodelglmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_view_copy(s : StatsmodelglmView) -> StatsmodelglmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_view_fill(s : StatsmodelglmView, v : Double) -> StatsmodelglmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_view_min(s : StatsmodelglmView) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_view_max(s : StatsmodelglmView) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_view_to_string(s : StatsmodelglmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_range_make(size : Int) -> StatsmodelglmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_range_len(s : StatsmodelglmRange) -> Int { s.size }

pub fn stats_model_glm_range_get(s : StatsmodelglmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_range_set(s : StatsmodelglmRange, i : Int, v : Double) -> StatsmodelglmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_range_sum(s : StatsmodelglmRange) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_range_mean(s : StatsmodelglmRange) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_range_scale(s : StatsmodelglmRange, f : Double) -> StatsmodelglmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_range_add(a : StatsmodelglmRange, b : StatsmodelglmRange) -> StatsmodelglmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_range_copy(s : StatsmodelglmRange) -> StatsmodelglmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_range_fill(s : StatsmodelglmRange, v : Double) -> StatsmodelglmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_range_min(s : StatsmodelglmRange) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_range_max(s : StatsmodelglmRange) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_range_to_string(s : StatsmodelglmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_slice_make(size : Int) -> StatsmodelglmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_slice_len(s : StatsmodelglmSlice) -> Int { s.size }

pub fn stats_model_glm_slice_get(s : StatsmodelglmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_slice_set(s : StatsmodelglmSlice, i : Int, v : Double) -> StatsmodelglmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_glm_slice_sum(s : StatsmodelglmSlice) -> Double { @_common.sum(s.data) }

pub fn stats_model_glm_slice_mean(s : StatsmodelglmSlice) -> Double { @_common.mean(s.data) }

pub fn stats_model_glm_slice_scale(s : StatsmodelglmSlice, f : Double) -> StatsmodelglmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_slice_add(a : StatsmodelglmSlice, b : StatsmodelglmSlice) -> StatsmodelglmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_glm_slice_copy(s : StatsmodelglmSlice) -> StatsmodelglmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_slice_fill(s : StatsmodelglmSlice, v : Double) -> StatsmodelglmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_glm_slice_min(s : StatsmodelglmSlice) -> Double { @_common.min(s.data) }

pub fn stats_model_glm_slice_max(s : StatsmodelglmSlice) -> Double { @_common.max(s.data) }

pub fn stats_model_glm_slice_to_string(s : StatsmodelglmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

