///===
/// extcore/stats_test_ks

pub(all) struct StatstestksPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_ks_make_point(x : Double, y : Double) -> StatstestksPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_ks_make_point3(x : Double, y : Double, z : Double) -> StatstestksPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestksPoint::x(self : StatstestksPoint) -> Double { self.x }

pub fn StatstestksPoint::y(self : StatstestksPoint) -> Double { self.y }

pub fn StatstestksPoint::z(self : StatstestksPoint) -> Double { self.z }

pub fn StatstestksPoint::label(self : StatstestksPoint) -> Int { self.label }

pub fn StatstestksPoint::dist(self : StatstestksPoint, other : StatstestksPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestksPoint::add(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestksPoint::sub(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestksPoint::scale(self : StatstestksPoint, s : Double) -> StatstestksPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestksPoint::dot(self : StatstestksPoint, other : StatstestksPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestksPoint::cross(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestksPoint::norm(self : StatstestksPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestksPoint::normalize(self : StatstestksPoint) -> StatstestksPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestksPoint::negate(self : StatstestksPoint) -> StatstestksPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestksPoint::mid(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestksPoint::lerp(self : StatstestksPoint, other : StatstestksPoint, t : Double) -> StatstestksPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestksPoint::to_string(self : StatstestksPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestksSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_ks_make_series(vals : Array[Double], name : String) -> StatstestksSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestksSeries::len(self : StatstestksSeries) -> Int { self.vals.length() }

pub fn StatstestksSeries::sum(self : StatstestksSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestksSeries::mean(self : StatstestksSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestksSeries::min(self : StatstestksSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestksSeries::max(self : StatstestksSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestksSeries::range(self : StatstestksSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestksSeries::variance(self : StatstestksSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestksSeries::std(self : StatstestksSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestksSeries::median(self : StatstestksSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestksSeries::scale(self : StatstestksSeries, f : Double) -> StatstestksSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestksSeries::add(self : StatstestksSeries, other : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestksSeries::sub(self : StatstestksSeries, other : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestksSeries::normalize(self : StatstestksSeries) -> StatstestksSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestksSeries::cumsum(self : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestksSeries::to_string(self : StatstestksSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestksMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_ks_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestksMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_ks_matrix_identity(n : Int) -> StatstestksMatrix {
  let m = stats_test_ks_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestksMatrix::get(self : StatstestksMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestksMatrix::transpose(self : StatstestksMatrix) -> StatstestksMatrix {
  let result = stats_test_ks_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestksMatrix::add(self : StatstestksMatrix, other : StatstestksMatrix) -> StatstestksMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_ks_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestksMatrix::scale(self : StatstestksMatrix, s : Double) -> StatstestksMatrix {
  let result = stats_test_ks_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestksMatrix::multiply(self : StatstestksMatrix, other : StatstestksMatrix) -> StatstestksMatrix {
  if self.cols != other.rows { return stats_test_ks_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_ks_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestksMatrix::trace(self : StatstestksMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestksMatrix::det(self : StatstestksMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestksMatrix::norm(self : StatstestksMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestksMatrix::to_string(self : StatstestksMatrix) -> String {
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

pub(all) struct StatstestksVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_ks_make_vector(comps : Array[Double]) -> StatstestksVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_ks_vector_zero(dim : Int) -> StatstestksVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestksVector::add(self : StatstestksVector, other : StatstestksVector) -> StatstestksVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestksVector::sub(self : StatstestksVector, other : StatstestksVector) -> StatstestksVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestksVector::scale(self : StatstestksVector, s : Double) -> StatstestksVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestksVector::dot(self : StatstestksVector, other : StatstestksVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestksVector::norm(self : StatstestksVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestksVector::normalize(self : StatstestksVector) -> StatstestksVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestksVector::dist(self : StatstestksVector, other : StatstestksVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestksVector::to_string(self : StatstestksVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_ks_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_ks_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_ks_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_ks_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_ks_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_ks_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_ks_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_ks_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_ks_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_ks_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_ks_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_ks_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_ks_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_ks_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_ks_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_ks_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_ks_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_ks_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_ks_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_ks_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_ks_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_ks_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_ks_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_ks_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_ks_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_ks_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_ks_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_ks_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_ks_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestksFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_frame_make(size : Int) -> StatstestksFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_frame_len(s : StatstestksFrame) -> Int { s.size }

pub fn stats_test_ks_frame_get(s : StatstestksFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_frame_set(s : StatstestksFrame, i : Int, v : Double) -> StatstestksFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_frame_sum(s : StatstestksFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_frame_mean(s : StatstestksFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_frame_scale(s : StatstestksFrame, f : Double) -> StatstestksFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_frame_add(a : StatstestksFrame, b : StatstestksFrame) -> StatstestksFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_frame_copy(s : StatstestksFrame) -> StatstestksFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_frame_fill(s : StatstestksFrame, v : Double) -> StatstestksFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_frame_min(s : StatstestksFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_frame_max(s : StatstestksFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_frame_to_string(s : StatstestksFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_table_make(size : Int) -> StatstestksTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_table_len(s : StatstestksTable) -> Int { s.size }

pub fn stats_test_ks_table_get(s : StatstestksTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_table_set(s : StatstestksTable, i : Int, v : Double) -> StatstestksTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_table_sum(s : StatstestksTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_table_mean(s : StatstestksTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_table_scale(s : StatstestksTable, f : Double) -> StatstestksTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_table_add(a : StatstestksTable, b : StatstestksTable) -> StatstestksTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_table_copy(s : StatstestksTable) -> StatstestksTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_table_fill(s : StatstestksTable, v : Double) -> StatstestksTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_table_min(s : StatstestksTable) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_table_max(s : StatstestksTable) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_table_to_string(s : StatstestksTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_graphn_make(size : Int) -> StatstestksGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_graphn_len(s : StatstestksGraphN) -> Int { s.size }

pub fn stats_test_ks_graphn_get(s : StatstestksGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_graphn_set(s : StatstestksGraphN, i : Int, v : Double) -> StatstestksGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_graphn_sum(s : StatstestksGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_graphn_mean(s : StatstestksGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_graphn_scale(s : StatstestksGraphN, f : Double) -> StatstestksGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_graphn_add(a : StatstestksGraphN, b : StatstestksGraphN) -> StatstestksGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_graphn_copy(s : StatstestksGraphN) -> StatstestksGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_graphn_fill(s : StatstestksGraphN, v : Double) -> StatstestksGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_graphn_min(s : StatstestksGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_graphn_max(s : StatstestksGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_graphn_to_string(s : StatstestksGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_node_make(size : Int) -> StatstestksNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_node_len(s : StatstestksNode) -> Int { s.size }

pub fn stats_test_ks_node_get(s : StatstestksNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_node_set(s : StatstestksNode, i : Int, v : Double) -> StatstestksNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_node_sum(s : StatstestksNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_node_mean(s : StatstestksNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_node_scale(s : StatstestksNode, f : Double) -> StatstestksNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_node_add(a : StatstestksNode, b : StatstestksNode) -> StatstestksNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_node_copy(s : StatstestksNode) -> StatstestksNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_node_fill(s : StatstestksNode, v : Double) -> StatstestksNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_node_min(s : StatstestksNode) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_node_max(s : StatstestksNode) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_node_to_string(s : StatstestksNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_edge_make(size : Int) -> StatstestksEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_edge_len(s : StatstestksEdge) -> Int { s.size }

pub fn stats_test_ks_edge_get(s : StatstestksEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_edge_set(s : StatstestksEdge, i : Int, v : Double) -> StatstestksEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_edge_sum(s : StatstestksEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_edge_mean(s : StatstestksEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_edge_scale(s : StatstestksEdge, f : Double) -> StatstestksEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_edge_add(a : StatstestksEdge, b : StatstestksEdge) -> StatstestksEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_edge_copy(s : StatstestksEdge) -> StatstestksEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_edge_fill(s : StatstestksEdge, v : Double) -> StatstestksEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_edge_min(s : StatstestksEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_edge_max(s : StatstestksEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_edge_to_string(s : StatstestksEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_path_make(size : Int) -> StatstestksPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_path_len(s : StatstestksPath) -> Int { s.size }

pub fn stats_test_ks_path_get(s : StatstestksPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_path_set(s : StatstestksPath, i : Int, v : Double) -> StatstestksPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_path_sum(s : StatstestksPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_path_mean(s : StatstestksPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_path_scale(s : StatstestksPath, f : Double) -> StatstestksPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_path_add(a : StatstestksPath, b : StatstestksPath) -> StatstestksPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_path_copy(s : StatstestksPath) -> StatstestksPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_path_fill(s : StatstestksPath, v : Double) -> StatstestksPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_path_min(s : StatstestksPath) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_path_max(s : StatstestksPath) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_path_to_string(s : StatstestksPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_cluster_make(size : Int) -> StatstestksCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_cluster_len(s : StatstestksCluster) -> Int { s.size }

pub fn stats_test_ks_cluster_get(s : StatstestksCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_cluster_set(s : StatstestksCluster, i : Int, v : Double) -> StatstestksCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cluster_sum(s : StatstestksCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_cluster_mean(s : StatstestksCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_cluster_scale(s : StatstestksCluster, f : Double) -> StatstestksCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cluster_add(a : StatstestksCluster, b : StatstestksCluster) -> StatstestksCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_cluster_copy(s : StatstestksCluster) -> StatstestksCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cluster_fill(s : StatstestksCluster, v : Double) -> StatstestksCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cluster_min(s : StatstestksCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_cluster_max(s : StatstestksCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_cluster_to_string(s : StatstestksCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_model_make(size : Int) -> StatstestksModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_model_len(s : StatstestksModel) -> Int { s.size }

pub fn stats_test_ks_model_get(s : StatstestksModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_model_set(s : StatstestksModel, i : Int, v : Double) -> StatstestksModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_model_sum(s : StatstestksModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_model_mean(s : StatstestksModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_model_scale(s : StatstestksModel, f : Double) -> StatstestksModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_model_add(a : StatstestksModel, b : StatstestksModel) -> StatstestksModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_model_copy(s : StatstestksModel) -> StatstestksModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_model_fill(s : StatstestksModel, v : Double) -> StatstestksModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_model_min(s : StatstestksModel) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_model_max(s : StatstestksModel) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_model_to_string(s : StatstestksModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_layer_make(size : Int) -> StatstestksLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_layer_len(s : StatstestksLayer) -> Int { s.size }

pub fn stats_test_ks_layer_get(s : StatstestksLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_layer_set(s : StatstestksLayer, i : Int, v : Double) -> StatstestksLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_layer_sum(s : StatstestksLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_layer_mean(s : StatstestksLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_layer_scale(s : StatstestksLayer, f : Double) -> StatstestksLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_layer_add(a : StatstestksLayer, b : StatstestksLayer) -> StatstestksLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_layer_copy(s : StatstestksLayer) -> StatstestksLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_layer_fill(s : StatstestksLayer, v : Double) -> StatstestksLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_layer_min(s : StatstestksLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_layer_max(s : StatstestksLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_layer_to_string(s : StatstestksLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_buffer_make(size : Int) -> StatstestksBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_buffer_len(s : StatstestksBuffer) -> Int { s.size }

pub fn stats_test_ks_buffer_get(s : StatstestksBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_buffer_set(s : StatstestksBuffer, i : Int, v : Double) -> StatstestksBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_buffer_sum(s : StatstestksBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_buffer_mean(s : StatstestksBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_buffer_scale(s : StatstestksBuffer, f : Double) -> StatstestksBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_buffer_add(a : StatstestksBuffer, b : StatstestksBuffer) -> StatstestksBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_buffer_copy(s : StatstestksBuffer) -> StatstestksBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_buffer_fill(s : StatstestksBuffer, v : Double) -> StatstestksBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_buffer_min(s : StatstestksBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_buffer_max(s : StatstestksBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_buffer_to_string(s : StatstestksBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_cursor_make(size : Int) -> StatstestksCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_cursor_len(s : StatstestksCursor) -> Int { s.size }

pub fn stats_test_ks_cursor_get(s : StatstestksCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_cursor_set(s : StatstestksCursor, i : Int, v : Double) -> StatstestksCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cursor_sum(s : StatstestksCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_cursor_mean(s : StatstestksCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_cursor_scale(s : StatstestksCursor, f : Double) -> StatstestksCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cursor_add(a : StatstestksCursor, b : StatstestksCursor) -> StatstestksCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_cursor_copy(s : StatstestksCursor) -> StatstestksCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cursor_fill(s : StatstestksCursor, v : Double) -> StatstestksCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_cursor_min(s : StatstestksCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_cursor_max(s : StatstestksCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_cursor_to_string(s : StatstestksCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_view_make(size : Int) -> StatstestksView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_view_len(s : StatstestksView) -> Int { s.size }

pub fn stats_test_ks_view_get(s : StatstestksView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_view_set(s : StatstestksView, i : Int, v : Double) -> StatstestksView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_view_sum(s : StatstestksView) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_view_mean(s : StatstestksView) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_view_scale(s : StatstestksView, f : Double) -> StatstestksView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_view_add(a : StatstestksView, b : StatstestksView) -> StatstestksView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_view_copy(s : StatstestksView) -> StatstestksView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_view_fill(s : StatstestksView, v : Double) -> StatstestksView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_view_min(s : StatstestksView) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_view_max(s : StatstestksView) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_view_to_string(s : StatstestksView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_range_make(size : Int) -> StatstestksRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_range_len(s : StatstestksRange) -> Int { s.size }

pub fn stats_test_ks_range_get(s : StatstestksRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_range_set(s : StatstestksRange, i : Int, v : Double) -> StatstestksRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_range_sum(s : StatstestksRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_range_mean(s : StatstestksRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_range_scale(s : StatstestksRange, f : Double) -> StatstestksRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_range_add(a : StatstestksRange, b : StatstestksRange) -> StatstestksRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_range_copy(s : StatstestksRange) -> StatstestksRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_range_fill(s : StatstestksRange, v : Double) -> StatstestksRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_range_min(s : StatstestksRange) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_range_max(s : StatstestksRange) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_range_to_string(s : StatstestksRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_slice_make(size : Int) -> StatstestksSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_slice_len(s : StatstestksSlice) -> Int { s.size }

pub fn stats_test_ks_slice_get(s : StatstestksSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_slice_set(s : StatstestksSlice, i : Int, v : Double) -> StatstestksSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_ks_slice_sum(s : StatstestksSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_slice_mean(s : StatstestksSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_slice_scale(s : StatstestksSlice, f : Double) -> StatstestksSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_slice_add(a : StatstestksSlice, b : StatstestksSlice) -> StatstestksSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_ks_slice_copy(s : StatstestksSlice) -> StatstestksSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_slice_fill(s : StatstestksSlice, v : Double) -> StatstestksSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_ks_slice_min(s : StatstestksSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_slice_max(s : StatstestksSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_slice_to_string(s : StatstestksSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

