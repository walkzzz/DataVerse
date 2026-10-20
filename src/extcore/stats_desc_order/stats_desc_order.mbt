///===
/// extcore/stats_desc_order

pub(all) struct StatsdescorderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_order_make_point(x : Double, y : Double) -> StatsdescorderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_order_make_point3(x : Double, y : Double, z : Double) -> StatsdescorderPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescorderPoint::x(self : StatsdescorderPoint) -> Double { self.x }

pub fn StatsdescorderPoint::y(self : StatsdescorderPoint) -> Double { self.y }

pub fn StatsdescorderPoint::z(self : StatsdescorderPoint) -> Double { self.z }

pub fn StatsdescorderPoint::label(self : StatsdescorderPoint) -> Int { self.label }

pub fn StatsdescorderPoint::dist(self : StatsdescorderPoint, other : StatsdescorderPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescorderPoint::add(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescorderPoint::sub(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescorderPoint::scale(self : StatsdescorderPoint, s : Double) -> StatsdescorderPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescorderPoint::dot(self : StatsdescorderPoint, other : StatsdescorderPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescorderPoint::cross(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescorderPoint::norm(self : StatsdescorderPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescorderPoint::normalize(self : StatsdescorderPoint) -> StatsdescorderPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescorderPoint::negate(self : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescorderPoint::mid(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescorderPoint::lerp(self : StatsdescorderPoint, other : StatsdescorderPoint, t : Double) -> StatsdescorderPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescorderPoint::to_string(self : StatsdescorderPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescorderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_order_make_series(vals : Array[Double], name : String) -> StatsdescorderSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescorderSeries::len(self : StatsdescorderSeries) -> Int { self.vals.length() }

pub fn StatsdescorderSeries::sum(self : StatsdescorderSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescorderSeries::mean(self : StatsdescorderSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescorderSeries::min(self : StatsdescorderSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescorderSeries::max(self : StatsdescorderSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescorderSeries::range(self : StatsdescorderSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescorderSeries::variance(self : StatsdescorderSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescorderSeries::std(self : StatsdescorderSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescorderSeries::median(self : StatsdescorderSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescorderSeries::scale(self : StatsdescorderSeries, f : Double) -> StatsdescorderSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescorderSeries::add(self : StatsdescorderSeries, other : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescorderSeries::sub(self : StatsdescorderSeries, other : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescorderSeries::normalize(self : StatsdescorderSeries) -> StatsdescorderSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescorderSeries::cumsum(self : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescorderSeries::to_string(self : StatsdescorderSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescorderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_order_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescorderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_order_matrix_identity(n : Int) -> StatsdescorderMatrix {
  let m = stats_desc_order_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescorderMatrix::get(self : StatsdescorderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescorderMatrix::transpose(self : StatsdescorderMatrix) -> StatsdescorderMatrix {
  let result = stats_desc_order_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescorderMatrix::add(self : StatsdescorderMatrix, other : StatsdescorderMatrix) -> StatsdescorderMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_order_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescorderMatrix::scale(self : StatsdescorderMatrix, s : Double) -> StatsdescorderMatrix {
  let result = stats_desc_order_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescorderMatrix::multiply(self : StatsdescorderMatrix, other : StatsdescorderMatrix) -> StatsdescorderMatrix {
  if self.cols != other.rows { return stats_desc_order_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_order_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdescorderMatrix::trace(self : StatsdescorderMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescorderMatrix::det(self : StatsdescorderMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescorderMatrix::norm(self : StatsdescorderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescorderMatrix::to_string(self : StatsdescorderMatrix) -> String {
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

pub(all) struct StatsdescorderVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_order_make_vector(comps : Array[Double]) -> StatsdescorderVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_order_vector_zero(dim : Int) -> StatsdescorderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescorderVector::add(self : StatsdescorderVector, other : StatsdescorderVector) -> StatsdescorderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescorderVector::sub(self : StatsdescorderVector, other : StatsdescorderVector) -> StatsdescorderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescorderVector::scale(self : StatsdescorderVector, s : Double) -> StatsdescorderVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescorderVector::dot(self : StatsdescorderVector, other : StatsdescorderVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescorderVector::norm(self : StatsdescorderVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescorderVector::normalize(self : StatsdescorderVector) -> StatsdescorderVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescorderVector::dist(self : StatsdescorderVector, other : StatsdescorderVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescorderVector::to_string(self : StatsdescorderVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_order_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_order_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_order_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_order_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_order_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_order_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_order_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_order_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_order_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_order_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_order_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_order_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_order_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_order_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_order_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_order_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_order_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_order_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_order_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_order_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_order_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_order_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_order_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_order_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_order_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_order_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_order_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_order_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_order_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescorderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_frame_make(size : Int) -> StatsdescorderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_frame_len(s : StatsdescorderFrame) -> Int { s.size }

pub fn stats_desc_order_frame_get(s : StatsdescorderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_frame_set(s : StatsdescorderFrame, i : Int, v : Double) -> StatsdescorderFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_frame_sum(s : StatsdescorderFrame) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_frame_mean(s : StatsdescorderFrame) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_frame_scale(s : StatsdescorderFrame, f : Double) -> StatsdescorderFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_frame_add(a : StatsdescorderFrame, b : StatsdescorderFrame) -> StatsdescorderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_frame_copy(s : StatsdescorderFrame) -> StatsdescorderFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_frame_fill(s : StatsdescorderFrame, v : Double) -> StatsdescorderFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_frame_min(s : StatsdescorderFrame) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_frame_max(s : StatsdescorderFrame) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_frame_to_string(s : StatsdescorderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_table_make(size : Int) -> StatsdescorderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_table_len(s : StatsdescorderTable) -> Int { s.size }

pub fn stats_desc_order_table_get(s : StatsdescorderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_table_set(s : StatsdescorderTable, i : Int, v : Double) -> StatsdescorderTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_table_sum(s : StatsdescorderTable) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_table_mean(s : StatsdescorderTable) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_table_scale(s : StatsdescorderTable, f : Double) -> StatsdescorderTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_table_add(a : StatsdescorderTable, b : StatsdescorderTable) -> StatsdescorderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_table_copy(s : StatsdescorderTable) -> StatsdescorderTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_table_fill(s : StatsdescorderTable, v : Double) -> StatsdescorderTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_table_min(s : StatsdescorderTable) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_table_max(s : StatsdescorderTable) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_table_to_string(s : StatsdescorderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_graphn_make(size : Int) -> StatsdescorderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_graphn_len(s : StatsdescorderGraphN) -> Int { s.size }

pub fn stats_desc_order_graphn_get(s : StatsdescorderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_graphn_set(s : StatsdescorderGraphN, i : Int, v : Double) -> StatsdescorderGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_graphn_sum(s : StatsdescorderGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_graphn_mean(s : StatsdescorderGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_graphn_scale(s : StatsdescorderGraphN, f : Double) -> StatsdescorderGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_graphn_add(a : StatsdescorderGraphN, b : StatsdescorderGraphN) -> StatsdescorderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_graphn_copy(s : StatsdescorderGraphN) -> StatsdescorderGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_graphn_fill(s : StatsdescorderGraphN, v : Double) -> StatsdescorderGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_graphn_min(s : StatsdescorderGraphN) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_graphn_max(s : StatsdescorderGraphN) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_graphn_to_string(s : StatsdescorderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_node_make(size : Int) -> StatsdescorderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_node_len(s : StatsdescorderNode) -> Int { s.size }

pub fn stats_desc_order_node_get(s : StatsdescorderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_node_set(s : StatsdescorderNode, i : Int, v : Double) -> StatsdescorderNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_node_sum(s : StatsdescorderNode) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_node_mean(s : StatsdescorderNode) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_node_scale(s : StatsdescorderNode, f : Double) -> StatsdescorderNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_node_add(a : StatsdescorderNode, b : StatsdescorderNode) -> StatsdescorderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_node_copy(s : StatsdescorderNode) -> StatsdescorderNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_node_fill(s : StatsdescorderNode, v : Double) -> StatsdescorderNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_node_min(s : StatsdescorderNode) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_node_max(s : StatsdescorderNode) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_node_to_string(s : StatsdescorderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_edge_make(size : Int) -> StatsdescorderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_edge_len(s : StatsdescorderEdge) -> Int { s.size }

pub fn stats_desc_order_edge_get(s : StatsdescorderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_edge_set(s : StatsdescorderEdge, i : Int, v : Double) -> StatsdescorderEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_edge_sum(s : StatsdescorderEdge) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_edge_mean(s : StatsdescorderEdge) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_edge_scale(s : StatsdescorderEdge, f : Double) -> StatsdescorderEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_edge_add(a : StatsdescorderEdge, b : StatsdescorderEdge) -> StatsdescorderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_edge_copy(s : StatsdescorderEdge) -> StatsdescorderEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_edge_fill(s : StatsdescorderEdge, v : Double) -> StatsdescorderEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_edge_min(s : StatsdescorderEdge) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_edge_max(s : StatsdescorderEdge) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_edge_to_string(s : StatsdescorderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_path_make(size : Int) -> StatsdescorderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_path_len(s : StatsdescorderPath) -> Int { s.size }

pub fn stats_desc_order_path_get(s : StatsdescorderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_path_set(s : StatsdescorderPath, i : Int, v : Double) -> StatsdescorderPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_path_sum(s : StatsdescorderPath) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_path_mean(s : StatsdescorderPath) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_path_scale(s : StatsdescorderPath, f : Double) -> StatsdescorderPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_path_add(a : StatsdescorderPath, b : StatsdescorderPath) -> StatsdescorderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_path_copy(s : StatsdescorderPath) -> StatsdescorderPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_path_fill(s : StatsdescorderPath, v : Double) -> StatsdescorderPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_path_min(s : StatsdescorderPath) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_path_max(s : StatsdescorderPath) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_path_to_string(s : StatsdescorderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_cluster_make(size : Int) -> StatsdescorderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_cluster_len(s : StatsdescorderCluster) -> Int { s.size }

pub fn stats_desc_order_cluster_get(s : StatsdescorderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_cluster_set(s : StatsdescorderCluster, i : Int, v : Double) -> StatsdescorderCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cluster_sum(s : StatsdescorderCluster) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_cluster_mean(s : StatsdescorderCluster) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_cluster_scale(s : StatsdescorderCluster, f : Double) -> StatsdescorderCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cluster_add(a : StatsdescorderCluster, b : StatsdescorderCluster) -> StatsdescorderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_cluster_copy(s : StatsdescorderCluster) -> StatsdescorderCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cluster_fill(s : StatsdescorderCluster, v : Double) -> StatsdescorderCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cluster_min(s : StatsdescorderCluster) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_cluster_max(s : StatsdescorderCluster) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_cluster_to_string(s : StatsdescorderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_model_make(size : Int) -> StatsdescorderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_model_len(s : StatsdescorderModel) -> Int { s.size }

pub fn stats_desc_order_model_get(s : StatsdescorderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_model_set(s : StatsdescorderModel, i : Int, v : Double) -> StatsdescorderModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_model_sum(s : StatsdescorderModel) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_model_mean(s : StatsdescorderModel) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_model_scale(s : StatsdescorderModel, f : Double) -> StatsdescorderModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_model_add(a : StatsdescorderModel, b : StatsdescorderModel) -> StatsdescorderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_model_copy(s : StatsdescorderModel) -> StatsdescorderModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_model_fill(s : StatsdescorderModel, v : Double) -> StatsdescorderModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_model_min(s : StatsdescorderModel) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_model_max(s : StatsdescorderModel) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_model_to_string(s : StatsdescorderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_layer_make(size : Int) -> StatsdescorderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_layer_len(s : StatsdescorderLayer) -> Int { s.size }

pub fn stats_desc_order_layer_get(s : StatsdescorderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_layer_set(s : StatsdescorderLayer, i : Int, v : Double) -> StatsdescorderLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_layer_sum(s : StatsdescorderLayer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_layer_mean(s : StatsdescorderLayer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_layer_scale(s : StatsdescorderLayer, f : Double) -> StatsdescorderLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_layer_add(a : StatsdescorderLayer, b : StatsdescorderLayer) -> StatsdescorderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_layer_copy(s : StatsdescorderLayer) -> StatsdescorderLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_layer_fill(s : StatsdescorderLayer, v : Double) -> StatsdescorderLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_layer_min(s : StatsdescorderLayer) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_layer_max(s : StatsdescorderLayer) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_layer_to_string(s : StatsdescorderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_buffer_make(size : Int) -> StatsdescorderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_buffer_len(s : StatsdescorderBuffer) -> Int { s.size }

pub fn stats_desc_order_buffer_get(s : StatsdescorderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_buffer_set(s : StatsdescorderBuffer, i : Int, v : Double) -> StatsdescorderBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_buffer_sum(s : StatsdescorderBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_buffer_mean(s : StatsdescorderBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_buffer_scale(s : StatsdescorderBuffer, f : Double) -> StatsdescorderBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_buffer_add(a : StatsdescorderBuffer, b : StatsdescorderBuffer) -> StatsdescorderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_buffer_copy(s : StatsdescorderBuffer) -> StatsdescorderBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_buffer_fill(s : StatsdescorderBuffer, v : Double) -> StatsdescorderBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_buffer_min(s : StatsdescorderBuffer) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_buffer_max(s : StatsdescorderBuffer) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_buffer_to_string(s : StatsdescorderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_cursor_make(size : Int) -> StatsdescorderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_cursor_len(s : StatsdescorderCursor) -> Int { s.size }

pub fn stats_desc_order_cursor_get(s : StatsdescorderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_cursor_set(s : StatsdescorderCursor, i : Int, v : Double) -> StatsdescorderCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cursor_sum(s : StatsdescorderCursor) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_cursor_mean(s : StatsdescorderCursor) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_cursor_scale(s : StatsdescorderCursor, f : Double) -> StatsdescorderCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cursor_add(a : StatsdescorderCursor, b : StatsdescorderCursor) -> StatsdescorderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_cursor_copy(s : StatsdescorderCursor) -> StatsdescorderCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cursor_fill(s : StatsdescorderCursor, v : Double) -> StatsdescorderCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_cursor_min(s : StatsdescorderCursor) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_cursor_max(s : StatsdescorderCursor) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_cursor_to_string(s : StatsdescorderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_view_make(size : Int) -> StatsdescorderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_view_len(s : StatsdescorderView) -> Int { s.size }

pub fn stats_desc_order_view_get(s : StatsdescorderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_view_set(s : StatsdescorderView, i : Int, v : Double) -> StatsdescorderView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_view_sum(s : StatsdescorderView) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_view_mean(s : StatsdescorderView) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_view_scale(s : StatsdescorderView, f : Double) -> StatsdescorderView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_view_add(a : StatsdescorderView, b : StatsdescorderView) -> StatsdescorderView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_view_copy(s : StatsdescorderView) -> StatsdescorderView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_view_fill(s : StatsdescorderView, v : Double) -> StatsdescorderView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_view_min(s : StatsdescorderView) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_view_max(s : StatsdescorderView) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_view_to_string(s : StatsdescorderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_range_make(size : Int) -> StatsdescorderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_range_len(s : StatsdescorderRange) -> Int { s.size }

pub fn stats_desc_order_range_get(s : StatsdescorderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_range_set(s : StatsdescorderRange, i : Int, v : Double) -> StatsdescorderRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_range_sum(s : StatsdescorderRange) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_range_mean(s : StatsdescorderRange) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_range_scale(s : StatsdescorderRange, f : Double) -> StatsdescorderRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_range_add(a : StatsdescorderRange, b : StatsdescorderRange) -> StatsdescorderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_range_copy(s : StatsdescorderRange) -> StatsdescorderRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_range_fill(s : StatsdescorderRange, v : Double) -> StatsdescorderRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_range_min(s : StatsdescorderRange) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_range_max(s : StatsdescorderRange) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_range_to_string(s : StatsdescorderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescorderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_slice_make(size : Int) -> StatsdescorderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_order_slice_len(s : StatsdescorderSlice) -> Int { s.size }

pub fn stats_desc_order_slice_get(s : StatsdescorderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_order_slice_set(s : StatsdescorderSlice, i : Int, v : Double) -> StatsdescorderSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_desc_order_slice_sum(s : StatsdescorderSlice) -> Double { @_common.sum(s.data) }

pub fn stats_desc_order_slice_mean(s : StatsdescorderSlice) -> Double { @_common.mean(s.data) }

pub fn stats_desc_order_slice_scale(s : StatsdescorderSlice, f : Double) -> StatsdescorderSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_slice_add(a : StatsdescorderSlice, b : StatsdescorderSlice) -> StatsdescorderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_desc_order_slice_copy(s : StatsdescorderSlice) -> StatsdescorderSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_slice_fill(s : StatsdescorderSlice, v : Double) -> StatsdescorderSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_desc_order_slice_min(s : StatsdescorderSlice) -> Double { @_common.min(s.data) }

pub fn stats_desc_order_slice_max(s : StatsdescorderSlice) -> Double { @_common.max(s.data) }

pub fn stats_desc_order_slice_to_string(s : StatsdescorderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

