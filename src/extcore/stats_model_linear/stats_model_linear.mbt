///===
/// extcore/stats_model_linear

pub(all) struct StatsmodellinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_linear_make_point(x : Double, y : Double) -> StatsmodellinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_linear_make_point3(x : Double, y : Double, z : Double) -> StatsmodellinearPoint {
  { x, y, z, label: 0 }
}

pub fn StatsmodellinearPoint::x(self : StatsmodellinearPoint) -> Double { self.x }

pub fn StatsmodellinearPoint::y(self : StatsmodellinearPoint) -> Double { self.y }

pub fn StatsmodellinearPoint::z(self : StatsmodellinearPoint) -> Double { self.z }

pub fn StatsmodellinearPoint::label(self : StatsmodellinearPoint) -> Int { self.label }

pub fn StatsmodellinearPoint::dist(self : StatsmodellinearPoint, other : StatsmodellinearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsmodellinearPoint::add(self : StatsmodellinearPoint, other : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsmodellinearPoint::sub(self : StatsmodellinearPoint, other : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsmodellinearPoint::scale(self : StatsmodellinearPoint, s : Double) -> StatsmodellinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsmodellinearPoint::dot(self : StatsmodellinearPoint, other : StatsmodellinearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsmodellinearPoint::cross(self : StatsmodellinearPoint, other : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsmodellinearPoint::norm(self : StatsmodellinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsmodellinearPoint::normalize(self : StatsmodellinearPoint) -> StatsmodellinearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodellinearPoint::negate(self : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsmodellinearPoint::mid(self : StatsmodellinearPoint, other : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsmodellinearPoint::lerp(self : StatsmodellinearPoint, other : StatsmodellinearPoint, t : Double) -> StatsmodellinearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsmodellinearPoint::to_string(self : StatsmodellinearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsmodellinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_linear_make_series(vals : Array[Double], name : String) -> StatsmodellinearSeries {
  { vals, name, meta: 0 }
}

pub fn StatsmodellinearSeries::len(self : StatsmodellinearSeries) -> Int { self.vals.length() }

pub fn StatsmodellinearSeries::sum(self : StatsmodellinearSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsmodellinearSeries::mean(self : StatsmodellinearSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsmodellinearSeries::min(self : StatsmodellinearSeries) -> Double { @_common.min(self.vals) }

pub fn StatsmodellinearSeries::max(self : StatsmodellinearSeries) -> Double { @_common.max(self.vals) }

pub fn StatsmodellinearSeries::range(self : StatsmodellinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsmodellinearSeries::variance(self : StatsmodellinearSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsmodellinearSeries::std(self : StatsmodellinearSeries) -> Double { @_common.std(self.vals) }

pub fn StatsmodellinearSeries::median(self : StatsmodellinearSeries) -> Double { @_common.median(self.vals) }

pub fn StatsmodellinearSeries::scale(self : StatsmodellinearSeries, f : Double) -> StatsmodellinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsmodellinearSeries::add(self : StatsmodellinearSeries, other : StatsmodellinearSeries) -> StatsmodellinearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsmodellinearSeries::sub(self : StatsmodellinearSeries, other : StatsmodellinearSeries) -> StatsmodellinearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsmodellinearSeries::normalize(self : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsmodellinearSeries::cumsum(self : StatsmodellinearSeries) -> StatsmodellinearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsmodellinearSeries::to_string(self : StatsmodellinearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodellinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_linear_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodellinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_linear_matrix_identity(n : Int) -> StatsmodellinearMatrix {
  let m = stats_model_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsmodellinearMatrix::get(self : StatsmodellinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsmodellinearMatrix::transpose(self : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsmodellinearMatrix::add(self : StatsmodellinearMatrix, other : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_model_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsmodellinearMatrix::scale(self : StatsmodellinearMatrix, s : Double) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsmodellinearMatrix::multiply(self : StatsmodellinearMatrix, other : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  if self.cols != other.rows { return stats_model_linear_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_model_linear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsmodellinearMatrix::trace(self : StatsmodellinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsmodellinearMatrix::det(self : StatsmodellinearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsmodellinearMatrix::norm(self : StatsmodellinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsmodellinearMatrix::to_string(self : StatsmodellinearMatrix) -> String {
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

pub(all) struct StatsmodellinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_linear_make_vector(comps : Array[Double]) -> StatsmodellinearVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_linear_vector_zero(dim : Int) -> StatsmodellinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsmodellinearVector::add(self : StatsmodellinearVector, other : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodellinearVector::sub(self : StatsmodellinearVector, other : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodellinearVector::scale(self : StatsmodellinearVector, s : Double) -> StatsmodellinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsmodellinearVector::dot(self : StatsmodellinearVector, other : StatsmodellinearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsmodellinearVector::norm(self : StatsmodellinearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsmodellinearVector::normalize(self : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodellinearVector::dist(self : StatsmodellinearVector, other : StatsmodellinearVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsmodellinearVector::to_string(self : StatsmodellinearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_linear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_linear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_linear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_linear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_linear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_linear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_linear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_linear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_linear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_linear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_linear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_linear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_linear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_linear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_linear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_linear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_linear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_linear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_linear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodellinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_frame_make(size : Int) -> StatsmodellinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_frame_len(s : StatsmodellinearFrame) -> Int { s.size }

pub fn stats_model_linear_frame_get(s : StatsmodellinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_frame_set(s : StatsmodellinearFrame, i : Int, v : Double) -> StatsmodellinearFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_frame_sum(s : StatsmodellinearFrame) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_frame_mean(s : StatsmodellinearFrame) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_frame_scale(s : StatsmodellinearFrame, f : Double) -> StatsmodellinearFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_frame_add(a : StatsmodellinearFrame, b : StatsmodellinearFrame) -> StatsmodellinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_frame_copy(s : StatsmodellinearFrame) -> StatsmodellinearFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_frame_fill(s : StatsmodellinearFrame, v : Double) -> StatsmodellinearFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_frame_min(s : StatsmodellinearFrame) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_frame_max(s : StatsmodellinearFrame) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_frame_to_string(s : StatsmodellinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_table_make(size : Int) -> StatsmodellinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_table_len(s : StatsmodellinearTable) -> Int { s.size }

pub fn stats_model_linear_table_get(s : StatsmodellinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_table_set(s : StatsmodellinearTable, i : Int, v : Double) -> StatsmodellinearTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_table_sum(s : StatsmodellinearTable) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_table_mean(s : StatsmodellinearTable) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_table_scale(s : StatsmodellinearTable, f : Double) -> StatsmodellinearTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_table_add(a : StatsmodellinearTable, b : StatsmodellinearTable) -> StatsmodellinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_table_copy(s : StatsmodellinearTable) -> StatsmodellinearTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_table_fill(s : StatsmodellinearTable, v : Double) -> StatsmodellinearTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_table_min(s : StatsmodellinearTable) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_table_max(s : StatsmodellinearTable) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_table_to_string(s : StatsmodellinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_graphn_make(size : Int) -> StatsmodellinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_graphn_len(s : StatsmodellinearGraphN) -> Int { s.size }

pub fn stats_model_linear_graphn_get(s : StatsmodellinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_graphn_set(s : StatsmodellinearGraphN, i : Int, v : Double) -> StatsmodellinearGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_graphn_sum(s : StatsmodellinearGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_graphn_mean(s : StatsmodellinearGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_graphn_scale(s : StatsmodellinearGraphN, f : Double) -> StatsmodellinearGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_graphn_add(a : StatsmodellinearGraphN, b : StatsmodellinearGraphN) -> StatsmodellinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_graphn_copy(s : StatsmodellinearGraphN) -> StatsmodellinearGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_graphn_fill(s : StatsmodellinearGraphN, v : Double) -> StatsmodellinearGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_graphn_min(s : StatsmodellinearGraphN) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_graphn_max(s : StatsmodellinearGraphN) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_graphn_to_string(s : StatsmodellinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_node_make(size : Int) -> StatsmodellinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_node_len(s : StatsmodellinearNode) -> Int { s.size }

pub fn stats_model_linear_node_get(s : StatsmodellinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_node_set(s : StatsmodellinearNode, i : Int, v : Double) -> StatsmodellinearNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_node_sum(s : StatsmodellinearNode) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_node_mean(s : StatsmodellinearNode) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_node_scale(s : StatsmodellinearNode, f : Double) -> StatsmodellinearNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_node_add(a : StatsmodellinearNode, b : StatsmodellinearNode) -> StatsmodellinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_node_copy(s : StatsmodellinearNode) -> StatsmodellinearNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_node_fill(s : StatsmodellinearNode, v : Double) -> StatsmodellinearNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_node_min(s : StatsmodellinearNode) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_node_max(s : StatsmodellinearNode) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_node_to_string(s : StatsmodellinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_edge_make(size : Int) -> StatsmodellinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_edge_len(s : StatsmodellinearEdge) -> Int { s.size }

pub fn stats_model_linear_edge_get(s : StatsmodellinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_edge_set(s : StatsmodellinearEdge, i : Int, v : Double) -> StatsmodellinearEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_edge_sum(s : StatsmodellinearEdge) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_edge_mean(s : StatsmodellinearEdge) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_edge_scale(s : StatsmodellinearEdge, f : Double) -> StatsmodellinearEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_edge_add(a : StatsmodellinearEdge, b : StatsmodellinearEdge) -> StatsmodellinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_edge_copy(s : StatsmodellinearEdge) -> StatsmodellinearEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_edge_fill(s : StatsmodellinearEdge, v : Double) -> StatsmodellinearEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_edge_min(s : StatsmodellinearEdge) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_edge_max(s : StatsmodellinearEdge) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_edge_to_string(s : StatsmodellinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_path_make(size : Int) -> StatsmodellinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_path_len(s : StatsmodellinearPath) -> Int { s.size }

pub fn stats_model_linear_path_get(s : StatsmodellinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_path_set(s : StatsmodellinearPath, i : Int, v : Double) -> StatsmodellinearPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_path_sum(s : StatsmodellinearPath) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_path_mean(s : StatsmodellinearPath) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_path_scale(s : StatsmodellinearPath, f : Double) -> StatsmodellinearPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_path_add(a : StatsmodellinearPath, b : StatsmodellinearPath) -> StatsmodellinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_path_copy(s : StatsmodellinearPath) -> StatsmodellinearPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_path_fill(s : StatsmodellinearPath, v : Double) -> StatsmodellinearPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_path_min(s : StatsmodellinearPath) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_path_max(s : StatsmodellinearPath) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_path_to_string(s : StatsmodellinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_cluster_make(size : Int) -> StatsmodellinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_cluster_len(s : StatsmodellinearCluster) -> Int { s.size }

pub fn stats_model_linear_cluster_get(s : StatsmodellinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_cluster_set(s : StatsmodellinearCluster, i : Int, v : Double) -> StatsmodellinearCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cluster_sum(s : StatsmodellinearCluster) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_cluster_mean(s : StatsmodellinearCluster) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_cluster_scale(s : StatsmodellinearCluster, f : Double) -> StatsmodellinearCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cluster_add(a : StatsmodellinearCluster, b : StatsmodellinearCluster) -> StatsmodellinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_cluster_copy(s : StatsmodellinearCluster) -> StatsmodellinearCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cluster_fill(s : StatsmodellinearCluster, v : Double) -> StatsmodellinearCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cluster_min(s : StatsmodellinearCluster) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_cluster_max(s : StatsmodellinearCluster) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_cluster_to_string(s : StatsmodellinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_model_make(size : Int) -> StatsmodellinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_model_len(s : StatsmodellinearModel) -> Int { s.size }

pub fn stats_model_linear_model_get(s : StatsmodellinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_model_set(s : StatsmodellinearModel, i : Int, v : Double) -> StatsmodellinearModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_model_sum(s : StatsmodellinearModel) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_model_mean(s : StatsmodellinearModel) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_model_scale(s : StatsmodellinearModel, f : Double) -> StatsmodellinearModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_model_add(a : StatsmodellinearModel, b : StatsmodellinearModel) -> StatsmodellinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_model_copy(s : StatsmodellinearModel) -> StatsmodellinearModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_model_fill(s : StatsmodellinearModel, v : Double) -> StatsmodellinearModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_model_min(s : StatsmodellinearModel) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_model_max(s : StatsmodellinearModel) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_model_to_string(s : StatsmodellinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_layer_make(size : Int) -> StatsmodellinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_layer_len(s : StatsmodellinearLayer) -> Int { s.size }

pub fn stats_model_linear_layer_get(s : StatsmodellinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_layer_set(s : StatsmodellinearLayer, i : Int, v : Double) -> StatsmodellinearLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_layer_sum(s : StatsmodellinearLayer) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_layer_mean(s : StatsmodellinearLayer) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_layer_scale(s : StatsmodellinearLayer, f : Double) -> StatsmodellinearLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_layer_add(a : StatsmodellinearLayer, b : StatsmodellinearLayer) -> StatsmodellinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_layer_copy(s : StatsmodellinearLayer) -> StatsmodellinearLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_layer_fill(s : StatsmodellinearLayer, v : Double) -> StatsmodellinearLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_layer_min(s : StatsmodellinearLayer) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_layer_max(s : StatsmodellinearLayer) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_layer_to_string(s : StatsmodellinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_buffer_make(size : Int) -> StatsmodellinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_buffer_len(s : StatsmodellinearBuffer) -> Int { s.size }

pub fn stats_model_linear_buffer_get(s : StatsmodellinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_buffer_set(s : StatsmodellinearBuffer, i : Int, v : Double) -> StatsmodellinearBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_buffer_sum(s : StatsmodellinearBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_buffer_mean(s : StatsmodellinearBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_buffer_scale(s : StatsmodellinearBuffer, f : Double) -> StatsmodellinearBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_buffer_add(a : StatsmodellinearBuffer, b : StatsmodellinearBuffer) -> StatsmodellinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_buffer_copy(s : StatsmodellinearBuffer) -> StatsmodellinearBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_buffer_fill(s : StatsmodellinearBuffer, v : Double) -> StatsmodellinearBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_buffer_min(s : StatsmodellinearBuffer) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_buffer_max(s : StatsmodellinearBuffer) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_buffer_to_string(s : StatsmodellinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_cursor_make(size : Int) -> StatsmodellinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_cursor_len(s : StatsmodellinearCursor) -> Int { s.size }

pub fn stats_model_linear_cursor_get(s : StatsmodellinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_cursor_set(s : StatsmodellinearCursor, i : Int, v : Double) -> StatsmodellinearCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cursor_sum(s : StatsmodellinearCursor) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_cursor_mean(s : StatsmodellinearCursor) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_cursor_scale(s : StatsmodellinearCursor, f : Double) -> StatsmodellinearCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cursor_add(a : StatsmodellinearCursor, b : StatsmodellinearCursor) -> StatsmodellinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_cursor_copy(s : StatsmodellinearCursor) -> StatsmodellinearCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cursor_fill(s : StatsmodellinearCursor, v : Double) -> StatsmodellinearCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_cursor_min(s : StatsmodellinearCursor) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_cursor_max(s : StatsmodellinearCursor) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_cursor_to_string(s : StatsmodellinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_view_make(size : Int) -> StatsmodellinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_view_len(s : StatsmodellinearView) -> Int { s.size }

pub fn stats_model_linear_view_get(s : StatsmodellinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_view_set(s : StatsmodellinearView, i : Int, v : Double) -> StatsmodellinearView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_view_sum(s : StatsmodellinearView) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_view_mean(s : StatsmodellinearView) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_view_scale(s : StatsmodellinearView, f : Double) -> StatsmodellinearView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_view_add(a : StatsmodellinearView, b : StatsmodellinearView) -> StatsmodellinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_view_copy(s : StatsmodellinearView) -> StatsmodellinearView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_view_fill(s : StatsmodellinearView, v : Double) -> StatsmodellinearView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_view_min(s : StatsmodellinearView) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_view_max(s : StatsmodellinearView) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_view_to_string(s : StatsmodellinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_range_make(size : Int) -> StatsmodellinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_range_len(s : StatsmodellinearRange) -> Int { s.size }

pub fn stats_model_linear_range_get(s : StatsmodellinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_range_set(s : StatsmodellinearRange, i : Int, v : Double) -> StatsmodellinearRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_range_sum(s : StatsmodellinearRange) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_range_mean(s : StatsmodellinearRange) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_range_scale(s : StatsmodellinearRange, f : Double) -> StatsmodellinearRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_range_add(a : StatsmodellinearRange, b : StatsmodellinearRange) -> StatsmodellinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_range_copy(s : StatsmodellinearRange) -> StatsmodellinearRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_range_fill(s : StatsmodellinearRange, v : Double) -> StatsmodellinearRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_range_min(s : StatsmodellinearRange) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_range_max(s : StatsmodellinearRange) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_range_to_string(s : StatsmodellinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_slice_make(size : Int) -> StatsmodellinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_slice_len(s : StatsmodellinearSlice) -> Int { s.size }

pub fn stats_model_linear_slice_get(s : StatsmodellinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_slice_set(s : StatsmodellinearSlice, i : Int, v : Double) -> StatsmodellinearSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_linear_slice_sum(s : StatsmodellinearSlice) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_slice_mean(s : StatsmodellinearSlice) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_slice_scale(s : StatsmodellinearSlice, f : Double) -> StatsmodellinearSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_slice_add(a : StatsmodellinearSlice, b : StatsmodellinearSlice) -> StatsmodellinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_linear_slice_copy(s : StatsmodellinearSlice) -> StatsmodellinearSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_slice_fill(s : StatsmodellinearSlice, v : Double) -> StatsmodellinearSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_linear_slice_min(s : StatsmodellinearSlice) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_slice_max(s : StatsmodellinearSlice) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_slice_to_string(s : StatsmodellinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

