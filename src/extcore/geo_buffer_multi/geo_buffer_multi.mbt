///===
/// extcore/geo_buffer_multi

pub(all) struct GeobuffermultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_multi_make_point(x : Double, y : Double) -> GeobuffermultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_multi_make_point3(x : Double, y : Double, z : Double) -> GeobuffermultiPoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffermultiPoint::x(self : GeobuffermultiPoint) -> Double { self.x }

pub fn GeobuffermultiPoint::y(self : GeobuffermultiPoint) -> Double { self.y }

pub fn GeobuffermultiPoint::z(self : GeobuffermultiPoint) -> Double { self.z }

pub fn GeobuffermultiPoint::label(self : GeobuffermultiPoint) -> Int { self.label }

pub fn GeobuffermultiPoint::dist(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffermultiPoint::add(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffermultiPoint::sub(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffermultiPoint::scale(self : GeobuffermultiPoint, s : Double) -> GeobuffermultiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffermultiPoint::dot(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffermultiPoint::cross(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffermultiPoint::norm(self : GeobuffermultiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffermultiPoint::normalize(self : GeobuffermultiPoint) -> GeobuffermultiPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffermultiPoint::negate(self : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffermultiPoint::mid(self : GeobuffermultiPoint, other : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffermultiPoint::lerp(self : GeobuffermultiPoint, other : GeobuffermultiPoint, t : Double) -> GeobuffermultiPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffermultiPoint::to_string(self : GeobuffermultiPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffermultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_multi_make_series(vals : Array[Double], name : String) -> GeobuffermultiSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffermultiSeries::len(self : GeobuffermultiSeries) -> Int { self.vals.length() }

pub fn GeobuffermultiSeries::sum(self : GeobuffermultiSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffermultiSeries::mean(self : GeobuffermultiSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffermultiSeries::min(self : GeobuffermultiSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffermultiSeries::max(self : GeobuffermultiSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffermultiSeries::range(self : GeobuffermultiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffermultiSeries::variance(self : GeobuffermultiSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffermultiSeries::std(self : GeobuffermultiSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffermultiSeries::median(self : GeobuffermultiSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffermultiSeries::scale(self : GeobuffermultiSeries, f : Double) -> GeobuffermultiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffermultiSeries::add(self : GeobuffermultiSeries, other : GeobuffermultiSeries) -> GeobuffermultiSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffermultiSeries::sub(self : GeobuffermultiSeries, other : GeobuffermultiSeries) -> GeobuffermultiSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffermultiSeries::normalize(self : GeobuffermultiSeries) -> GeobuffermultiSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffermultiSeries::cumsum(self : GeobuffermultiSeries) -> GeobuffermultiSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffermultiSeries::to_string(self : GeobuffermultiSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffermultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_multi_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffermultiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_multi_matrix_identity(n : Int) -> GeobuffermultiMatrix {
  let m = geo_buffer_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffermultiMatrix::get(self : GeobuffermultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffermultiMatrix::transpose(self : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  let result = geo_buffer_multi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffermultiMatrix::add(self : GeobuffermultiMatrix, other : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffermultiMatrix::scale(self : GeobuffermultiMatrix, s : Double) -> GeobuffermultiMatrix {
  let result = geo_buffer_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffermultiMatrix::multiply(self : GeobuffermultiMatrix, other : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  if self.cols != other.rows { return geo_buffer_multi_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_multi_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobuffermultiMatrix::trace(self : GeobuffermultiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffermultiMatrix::det(self : GeobuffermultiMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffermultiMatrix::norm(self : GeobuffermultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffermultiMatrix::to_string(self : GeobuffermultiMatrix) -> String {
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

pub(all) struct GeobuffermultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_multi_make_vector(comps : Array[Double]) -> GeobuffermultiVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_multi_vector_zero(dim : Int) -> GeobuffermultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffermultiVector::add(self : GeobuffermultiVector, other : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffermultiVector::sub(self : GeobuffermultiVector, other : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffermultiVector::scale(self : GeobuffermultiVector, s : Double) -> GeobuffermultiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffermultiVector::dot(self : GeobuffermultiVector, other : GeobuffermultiVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffermultiVector::norm(self : GeobuffermultiVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffermultiVector::normalize(self : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffermultiVector::dist(self : GeobuffermultiVector, other : GeobuffermultiVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffermultiVector::to_string(self : GeobuffermultiVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_multi_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_multi_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_multi_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_multi_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_multi_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_multi_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_multi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_multi_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_multi_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_multi_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_multi_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_multi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_multi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_multi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_multi_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_multi_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_multi_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_multi_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_multi_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_multi_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_multi_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_multi_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_multi_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_multi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_multi_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_multi_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_multi_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_multi_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_multi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobuffermultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_frame_make(size : Int) -> GeobuffermultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_frame_len(s : GeobuffermultiFrame) -> Int { s.size }

pub fn geo_buffer_multi_frame_get(s : GeobuffermultiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_frame_set(s : GeobuffermultiFrame, i : Int, v : Double) -> GeobuffermultiFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_frame_sum(s : GeobuffermultiFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_frame_mean(s : GeobuffermultiFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_frame_scale(s : GeobuffermultiFrame, f : Double) -> GeobuffermultiFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_frame_add(a : GeobuffermultiFrame, b : GeobuffermultiFrame) -> GeobuffermultiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_frame_copy(s : GeobuffermultiFrame) -> GeobuffermultiFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_frame_fill(s : GeobuffermultiFrame, v : Double) -> GeobuffermultiFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_frame_min(s : GeobuffermultiFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_frame_max(s : GeobuffermultiFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_frame_to_string(s : GeobuffermultiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_table_make(size : Int) -> GeobuffermultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_table_len(s : GeobuffermultiTable) -> Int { s.size }

pub fn geo_buffer_multi_table_get(s : GeobuffermultiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_table_set(s : GeobuffermultiTable, i : Int, v : Double) -> GeobuffermultiTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_table_sum(s : GeobuffermultiTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_table_mean(s : GeobuffermultiTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_table_scale(s : GeobuffermultiTable, f : Double) -> GeobuffermultiTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_table_add(a : GeobuffermultiTable, b : GeobuffermultiTable) -> GeobuffermultiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_table_copy(s : GeobuffermultiTable) -> GeobuffermultiTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_table_fill(s : GeobuffermultiTable, v : Double) -> GeobuffermultiTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_table_min(s : GeobuffermultiTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_table_max(s : GeobuffermultiTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_table_to_string(s : GeobuffermultiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_graphn_make(size : Int) -> GeobuffermultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_graphn_len(s : GeobuffermultiGraphN) -> Int { s.size }

pub fn geo_buffer_multi_graphn_get(s : GeobuffermultiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_graphn_set(s : GeobuffermultiGraphN, i : Int, v : Double) -> GeobuffermultiGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_graphn_sum(s : GeobuffermultiGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_graphn_mean(s : GeobuffermultiGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_graphn_scale(s : GeobuffermultiGraphN, f : Double) -> GeobuffermultiGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_graphn_add(a : GeobuffermultiGraphN, b : GeobuffermultiGraphN) -> GeobuffermultiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_graphn_copy(s : GeobuffermultiGraphN) -> GeobuffermultiGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_graphn_fill(s : GeobuffermultiGraphN, v : Double) -> GeobuffermultiGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_graphn_min(s : GeobuffermultiGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_graphn_max(s : GeobuffermultiGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_graphn_to_string(s : GeobuffermultiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_node_make(size : Int) -> GeobuffermultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_node_len(s : GeobuffermultiNode) -> Int { s.size }

pub fn geo_buffer_multi_node_get(s : GeobuffermultiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_node_set(s : GeobuffermultiNode, i : Int, v : Double) -> GeobuffermultiNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_node_sum(s : GeobuffermultiNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_node_mean(s : GeobuffermultiNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_node_scale(s : GeobuffermultiNode, f : Double) -> GeobuffermultiNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_node_add(a : GeobuffermultiNode, b : GeobuffermultiNode) -> GeobuffermultiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_node_copy(s : GeobuffermultiNode) -> GeobuffermultiNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_node_fill(s : GeobuffermultiNode, v : Double) -> GeobuffermultiNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_node_min(s : GeobuffermultiNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_node_max(s : GeobuffermultiNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_node_to_string(s : GeobuffermultiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_edge_make(size : Int) -> GeobuffermultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_edge_len(s : GeobuffermultiEdge) -> Int { s.size }

pub fn geo_buffer_multi_edge_get(s : GeobuffermultiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_edge_set(s : GeobuffermultiEdge, i : Int, v : Double) -> GeobuffermultiEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_edge_sum(s : GeobuffermultiEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_edge_mean(s : GeobuffermultiEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_edge_scale(s : GeobuffermultiEdge, f : Double) -> GeobuffermultiEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_edge_add(a : GeobuffermultiEdge, b : GeobuffermultiEdge) -> GeobuffermultiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_edge_copy(s : GeobuffermultiEdge) -> GeobuffermultiEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_edge_fill(s : GeobuffermultiEdge, v : Double) -> GeobuffermultiEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_edge_min(s : GeobuffermultiEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_edge_max(s : GeobuffermultiEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_edge_to_string(s : GeobuffermultiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_path_make(size : Int) -> GeobuffermultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_path_len(s : GeobuffermultiPath) -> Int { s.size }

pub fn geo_buffer_multi_path_get(s : GeobuffermultiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_path_set(s : GeobuffermultiPath, i : Int, v : Double) -> GeobuffermultiPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_path_sum(s : GeobuffermultiPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_path_mean(s : GeobuffermultiPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_path_scale(s : GeobuffermultiPath, f : Double) -> GeobuffermultiPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_path_add(a : GeobuffermultiPath, b : GeobuffermultiPath) -> GeobuffermultiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_path_copy(s : GeobuffermultiPath) -> GeobuffermultiPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_path_fill(s : GeobuffermultiPath, v : Double) -> GeobuffermultiPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_path_min(s : GeobuffermultiPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_path_max(s : GeobuffermultiPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_path_to_string(s : GeobuffermultiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_cluster_make(size : Int) -> GeobuffermultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_cluster_len(s : GeobuffermultiCluster) -> Int { s.size }

pub fn geo_buffer_multi_cluster_get(s : GeobuffermultiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_cluster_set(s : GeobuffermultiCluster, i : Int, v : Double) -> GeobuffermultiCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cluster_sum(s : GeobuffermultiCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_cluster_mean(s : GeobuffermultiCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_cluster_scale(s : GeobuffermultiCluster, f : Double) -> GeobuffermultiCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cluster_add(a : GeobuffermultiCluster, b : GeobuffermultiCluster) -> GeobuffermultiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_cluster_copy(s : GeobuffermultiCluster) -> GeobuffermultiCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cluster_fill(s : GeobuffermultiCluster, v : Double) -> GeobuffermultiCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cluster_min(s : GeobuffermultiCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_cluster_max(s : GeobuffermultiCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_cluster_to_string(s : GeobuffermultiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_model_make(size : Int) -> GeobuffermultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_model_len(s : GeobuffermultiModel) -> Int { s.size }

pub fn geo_buffer_multi_model_get(s : GeobuffermultiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_model_set(s : GeobuffermultiModel, i : Int, v : Double) -> GeobuffermultiModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_model_sum(s : GeobuffermultiModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_model_mean(s : GeobuffermultiModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_model_scale(s : GeobuffermultiModel, f : Double) -> GeobuffermultiModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_model_add(a : GeobuffermultiModel, b : GeobuffermultiModel) -> GeobuffermultiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_model_copy(s : GeobuffermultiModel) -> GeobuffermultiModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_model_fill(s : GeobuffermultiModel, v : Double) -> GeobuffermultiModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_model_min(s : GeobuffermultiModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_model_max(s : GeobuffermultiModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_model_to_string(s : GeobuffermultiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_layer_make(size : Int) -> GeobuffermultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_layer_len(s : GeobuffermultiLayer) -> Int { s.size }

pub fn geo_buffer_multi_layer_get(s : GeobuffermultiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_layer_set(s : GeobuffermultiLayer, i : Int, v : Double) -> GeobuffermultiLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_layer_sum(s : GeobuffermultiLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_layer_mean(s : GeobuffermultiLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_layer_scale(s : GeobuffermultiLayer, f : Double) -> GeobuffermultiLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_layer_add(a : GeobuffermultiLayer, b : GeobuffermultiLayer) -> GeobuffermultiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_layer_copy(s : GeobuffermultiLayer) -> GeobuffermultiLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_layer_fill(s : GeobuffermultiLayer, v : Double) -> GeobuffermultiLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_layer_min(s : GeobuffermultiLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_layer_max(s : GeobuffermultiLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_layer_to_string(s : GeobuffermultiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_buffer_make(size : Int) -> GeobuffermultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_buffer_len(s : GeobuffermultiBuffer) -> Int { s.size }

pub fn geo_buffer_multi_buffer_get(s : GeobuffermultiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_buffer_set(s : GeobuffermultiBuffer, i : Int, v : Double) -> GeobuffermultiBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_buffer_sum(s : GeobuffermultiBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_buffer_mean(s : GeobuffermultiBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_buffer_scale(s : GeobuffermultiBuffer, f : Double) -> GeobuffermultiBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_buffer_add(a : GeobuffermultiBuffer, b : GeobuffermultiBuffer) -> GeobuffermultiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_buffer_copy(s : GeobuffermultiBuffer) -> GeobuffermultiBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_buffer_fill(s : GeobuffermultiBuffer, v : Double) -> GeobuffermultiBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_buffer_min(s : GeobuffermultiBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_buffer_max(s : GeobuffermultiBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_buffer_to_string(s : GeobuffermultiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_cursor_make(size : Int) -> GeobuffermultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_cursor_len(s : GeobuffermultiCursor) -> Int { s.size }

pub fn geo_buffer_multi_cursor_get(s : GeobuffermultiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_cursor_set(s : GeobuffermultiCursor, i : Int, v : Double) -> GeobuffermultiCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cursor_sum(s : GeobuffermultiCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_cursor_mean(s : GeobuffermultiCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_cursor_scale(s : GeobuffermultiCursor, f : Double) -> GeobuffermultiCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cursor_add(a : GeobuffermultiCursor, b : GeobuffermultiCursor) -> GeobuffermultiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_cursor_copy(s : GeobuffermultiCursor) -> GeobuffermultiCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cursor_fill(s : GeobuffermultiCursor, v : Double) -> GeobuffermultiCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_cursor_min(s : GeobuffermultiCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_cursor_max(s : GeobuffermultiCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_cursor_to_string(s : GeobuffermultiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_view_make(size : Int) -> GeobuffermultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_view_len(s : GeobuffermultiView) -> Int { s.size }

pub fn geo_buffer_multi_view_get(s : GeobuffermultiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_view_set(s : GeobuffermultiView, i : Int, v : Double) -> GeobuffermultiView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_view_sum(s : GeobuffermultiView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_view_mean(s : GeobuffermultiView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_view_scale(s : GeobuffermultiView, f : Double) -> GeobuffermultiView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_view_add(a : GeobuffermultiView, b : GeobuffermultiView) -> GeobuffermultiView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_view_copy(s : GeobuffermultiView) -> GeobuffermultiView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_view_fill(s : GeobuffermultiView, v : Double) -> GeobuffermultiView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_view_min(s : GeobuffermultiView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_view_max(s : GeobuffermultiView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_view_to_string(s : GeobuffermultiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_range_make(size : Int) -> GeobuffermultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_range_len(s : GeobuffermultiRange) -> Int { s.size }

pub fn geo_buffer_multi_range_get(s : GeobuffermultiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_range_set(s : GeobuffermultiRange, i : Int, v : Double) -> GeobuffermultiRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_range_sum(s : GeobuffermultiRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_range_mean(s : GeobuffermultiRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_range_scale(s : GeobuffermultiRange, f : Double) -> GeobuffermultiRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_range_add(a : GeobuffermultiRange, b : GeobuffermultiRange) -> GeobuffermultiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_range_copy(s : GeobuffermultiRange) -> GeobuffermultiRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_range_fill(s : GeobuffermultiRange, v : Double) -> GeobuffermultiRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_range_min(s : GeobuffermultiRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_range_max(s : GeobuffermultiRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_range_to_string(s : GeobuffermultiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_slice_make(size : Int) -> GeobuffermultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_slice_len(s : GeobuffermultiSlice) -> Int { s.size }

pub fn geo_buffer_multi_slice_get(s : GeobuffermultiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_slice_set(s : GeobuffermultiSlice, i : Int, v : Double) -> GeobuffermultiSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_slice_sum(s : GeobuffermultiSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_multi_slice_mean(s : GeobuffermultiSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_multi_slice_scale(s : GeobuffermultiSlice, f : Double) -> GeobuffermultiSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_slice_add(a : GeobuffermultiSlice, b : GeobuffermultiSlice) -> GeobuffermultiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_multi_slice_copy(s : GeobuffermultiSlice) -> GeobuffermultiSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_slice_fill(s : GeobuffermultiSlice, v : Double) -> GeobuffermultiSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_multi_slice_min(s : GeobuffermultiSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_multi_slice_max(s : GeobuffermultiSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_multi_slice_to_string(s : GeobuffermultiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

