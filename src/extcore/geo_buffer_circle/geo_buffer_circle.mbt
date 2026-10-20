///===
/// extcore/geo_buffer_circle

pub(all) struct GeobuffercirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_circle_make_point(x : Double, y : Double) -> GeobuffercirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_circle_make_point3(x : Double, y : Double, z : Double) -> GeobuffercirclePoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffercirclePoint::x(self : GeobuffercirclePoint) -> Double { self.x }

pub fn GeobuffercirclePoint::y(self : GeobuffercirclePoint) -> Double { self.y }

pub fn GeobuffercirclePoint::z(self : GeobuffercirclePoint) -> Double { self.z }

pub fn GeobuffercirclePoint::label(self : GeobuffercirclePoint) -> Int { self.label }

pub fn GeobuffercirclePoint::dist(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffercirclePoint::add(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffercirclePoint::sub(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffercirclePoint::scale(self : GeobuffercirclePoint, s : Double) -> GeobuffercirclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffercirclePoint::dot(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffercirclePoint::cross(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffercirclePoint::norm(self : GeobuffercirclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffercirclePoint::normalize(self : GeobuffercirclePoint) -> GeobuffercirclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercirclePoint::negate(self : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffercirclePoint::mid(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffercirclePoint::lerp(self : GeobuffercirclePoint, other : GeobuffercirclePoint, t : Double) -> GeobuffercirclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffercirclePoint::to_string(self : GeobuffercirclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffercircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_circle_make_series(vals : Array[Double], name : String) -> GeobuffercircleSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffercircleSeries::len(self : GeobuffercircleSeries) -> Int { self.vals.length() }

pub fn GeobuffercircleSeries::sum(self : GeobuffercircleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffercircleSeries::mean(self : GeobuffercircleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffercircleSeries::min(self : GeobuffercircleSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffercircleSeries::max(self : GeobuffercircleSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffercircleSeries::range(self : GeobuffercircleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffercircleSeries::variance(self : GeobuffercircleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffercircleSeries::std(self : GeobuffercircleSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffercircleSeries::median(self : GeobuffercircleSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffercircleSeries::scale(self : GeobuffercircleSeries, f : Double) -> GeobuffercircleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffercircleSeries::add(self : GeobuffercircleSeries, other : GeobuffercircleSeries) -> GeobuffercircleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffercircleSeries::sub(self : GeobuffercircleSeries, other : GeobuffercircleSeries) -> GeobuffercircleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffercircleSeries::normalize(self : GeobuffercircleSeries) -> GeobuffercircleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffercircleSeries::cumsum(self : GeobuffercircleSeries) -> GeobuffercircleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffercircleSeries::to_string(self : GeobuffercircleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffercircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffercircleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_circle_matrix_identity(n : Int) -> GeobuffercircleMatrix {
  let m = geo_buffer_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffercircleMatrix::get(self : GeobuffercircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffercircleMatrix::transpose(self : GeobuffercircleMatrix) -> GeobuffercircleMatrix {
  let result = geo_buffer_circle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffercircleMatrix::add(self : GeobuffercircleMatrix, other : GeobuffercircleMatrix) -> GeobuffercircleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffercircleMatrix::scale(self : GeobuffercircleMatrix, s : Double) -> GeobuffercircleMatrix {
  let result = geo_buffer_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffercircleMatrix::multiply(self : GeobuffercircleMatrix, other : GeobuffercircleMatrix) -> GeobuffercircleMatrix {
  if self.cols != other.rows { return geo_buffer_circle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_circle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobuffercircleMatrix::trace(self : GeobuffercircleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffercircleMatrix::det(self : GeobuffercircleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffercircleMatrix::norm(self : GeobuffercircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffercircleMatrix::to_string(self : GeobuffercircleMatrix) -> String {
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

pub(all) struct GeobuffercircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_circle_make_vector(comps : Array[Double]) -> GeobuffercircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_circle_vector_zero(dim : Int) -> GeobuffercircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffercircleVector::add(self : GeobuffercircleVector, other : GeobuffercircleVector) -> GeobuffercircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercircleVector::sub(self : GeobuffercircleVector, other : GeobuffercircleVector) -> GeobuffercircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercircleVector::scale(self : GeobuffercircleVector, s : Double) -> GeobuffercircleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffercircleVector::dot(self : GeobuffercircleVector, other : GeobuffercircleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffercircleVector::norm(self : GeobuffercircleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffercircleVector::normalize(self : GeobuffercircleVector) -> GeobuffercircleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercircleVector::dist(self : GeobuffercircleVector, other : GeobuffercircleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffercircleVector::to_string(self : GeobuffercircleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_circle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_circle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_circle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_circle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_circle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_circle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_circle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_circle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_circle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_circle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_circle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_circle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_circle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_circle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_circle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_circle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_circle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_circle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_circle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_circle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_circle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_circle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_circle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_circle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_circle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_circle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_circle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_circle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_circle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobuffercircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_frame_make(size : Int) -> GeobuffercircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_frame_len(s : GeobuffercircleFrame) -> Int { s.size }

pub fn geo_buffer_circle_frame_get(s : GeobuffercircleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_frame_set(s : GeobuffercircleFrame, i : Int, v : Double) -> GeobuffercircleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_frame_sum(s : GeobuffercircleFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_frame_mean(s : GeobuffercircleFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_frame_scale(s : GeobuffercircleFrame, f : Double) -> GeobuffercircleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_frame_add(a : GeobuffercircleFrame, b : GeobuffercircleFrame) -> GeobuffercircleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_frame_copy(s : GeobuffercircleFrame) -> GeobuffercircleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_frame_fill(s : GeobuffercircleFrame, v : Double) -> GeobuffercircleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_frame_min(s : GeobuffercircleFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_frame_max(s : GeobuffercircleFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_frame_to_string(s : GeobuffercircleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_table_make(size : Int) -> GeobuffercircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_table_len(s : GeobuffercircleTable) -> Int { s.size }

pub fn geo_buffer_circle_table_get(s : GeobuffercircleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_table_set(s : GeobuffercircleTable, i : Int, v : Double) -> GeobuffercircleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_table_sum(s : GeobuffercircleTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_table_mean(s : GeobuffercircleTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_table_scale(s : GeobuffercircleTable, f : Double) -> GeobuffercircleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_table_add(a : GeobuffercircleTable, b : GeobuffercircleTable) -> GeobuffercircleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_table_copy(s : GeobuffercircleTable) -> GeobuffercircleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_table_fill(s : GeobuffercircleTable, v : Double) -> GeobuffercircleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_table_min(s : GeobuffercircleTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_table_max(s : GeobuffercircleTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_table_to_string(s : GeobuffercircleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_graphn_make(size : Int) -> GeobuffercircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_graphn_len(s : GeobuffercircleGraphN) -> Int { s.size }

pub fn geo_buffer_circle_graphn_get(s : GeobuffercircleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_graphn_set(s : GeobuffercircleGraphN, i : Int, v : Double) -> GeobuffercircleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_graphn_sum(s : GeobuffercircleGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_graphn_mean(s : GeobuffercircleGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_graphn_scale(s : GeobuffercircleGraphN, f : Double) -> GeobuffercircleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_graphn_add(a : GeobuffercircleGraphN, b : GeobuffercircleGraphN) -> GeobuffercircleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_graphn_copy(s : GeobuffercircleGraphN) -> GeobuffercircleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_graphn_fill(s : GeobuffercircleGraphN, v : Double) -> GeobuffercircleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_graphn_min(s : GeobuffercircleGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_graphn_max(s : GeobuffercircleGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_graphn_to_string(s : GeobuffercircleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_node_make(size : Int) -> GeobuffercircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_node_len(s : GeobuffercircleNode) -> Int { s.size }

pub fn geo_buffer_circle_node_get(s : GeobuffercircleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_node_set(s : GeobuffercircleNode, i : Int, v : Double) -> GeobuffercircleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_node_sum(s : GeobuffercircleNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_node_mean(s : GeobuffercircleNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_node_scale(s : GeobuffercircleNode, f : Double) -> GeobuffercircleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_node_add(a : GeobuffercircleNode, b : GeobuffercircleNode) -> GeobuffercircleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_node_copy(s : GeobuffercircleNode) -> GeobuffercircleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_node_fill(s : GeobuffercircleNode, v : Double) -> GeobuffercircleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_node_min(s : GeobuffercircleNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_node_max(s : GeobuffercircleNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_node_to_string(s : GeobuffercircleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_edge_make(size : Int) -> GeobuffercircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_edge_len(s : GeobuffercircleEdge) -> Int { s.size }

pub fn geo_buffer_circle_edge_get(s : GeobuffercircleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_edge_set(s : GeobuffercircleEdge, i : Int, v : Double) -> GeobuffercircleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_edge_sum(s : GeobuffercircleEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_edge_mean(s : GeobuffercircleEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_edge_scale(s : GeobuffercircleEdge, f : Double) -> GeobuffercircleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_edge_add(a : GeobuffercircleEdge, b : GeobuffercircleEdge) -> GeobuffercircleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_edge_copy(s : GeobuffercircleEdge) -> GeobuffercircleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_edge_fill(s : GeobuffercircleEdge, v : Double) -> GeobuffercircleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_edge_min(s : GeobuffercircleEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_edge_max(s : GeobuffercircleEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_edge_to_string(s : GeobuffercircleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_path_make(size : Int) -> GeobuffercirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_path_len(s : GeobuffercirclePath) -> Int { s.size }

pub fn geo_buffer_circle_path_get(s : GeobuffercirclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_path_set(s : GeobuffercirclePath, i : Int, v : Double) -> GeobuffercirclePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_path_sum(s : GeobuffercirclePath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_path_mean(s : GeobuffercirclePath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_path_scale(s : GeobuffercirclePath, f : Double) -> GeobuffercirclePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_path_add(a : GeobuffercirclePath, b : GeobuffercirclePath) -> GeobuffercirclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_path_copy(s : GeobuffercirclePath) -> GeobuffercirclePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_path_fill(s : GeobuffercirclePath, v : Double) -> GeobuffercirclePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_path_min(s : GeobuffercirclePath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_path_max(s : GeobuffercirclePath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_path_to_string(s : GeobuffercirclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_cluster_make(size : Int) -> GeobuffercircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_cluster_len(s : GeobuffercircleCluster) -> Int { s.size }

pub fn geo_buffer_circle_cluster_get(s : GeobuffercircleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_cluster_set(s : GeobuffercircleCluster, i : Int, v : Double) -> GeobuffercircleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cluster_sum(s : GeobuffercircleCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_cluster_mean(s : GeobuffercircleCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_cluster_scale(s : GeobuffercircleCluster, f : Double) -> GeobuffercircleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cluster_add(a : GeobuffercircleCluster, b : GeobuffercircleCluster) -> GeobuffercircleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_cluster_copy(s : GeobuffercircleCluster) -> GeobuffercircleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cluster_fill(s : GeobuffercircleCluster, v : Double) -> GeobuffercircleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cluster_min(s : GeobuffercircleCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_cluster_max(s : GeobuffercircleCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_cluster_to_string(s : GeobuffercircleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_model_make(size : Int) -> GeobuffercircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_model_len(s : GeobuffercircleModel) -> Int { s.size }

pub fn geo_buffer_circle_model_get(s : GeobuffercircleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_model_set(s : GeobuffercircleModel, i : Int, v : Double) -> GeobuffercircleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_model_sum(s : GeobuffercircleModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_model_mean(s : GeobuffercircleModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_model_scale(s : GeobuffercircleModel, f : Double) -> GeobuffercircleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_model_add(a : GeobuffercircleModel, b : GeobuffercircleModel) -> GeobuffercircleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_model_copy(s : GeobuffercircleModel) -> GeobuffercircleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_model_fill(s : GeobuffercircleModel, v : Double) -> GeobuffercircleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_model_min(s : GeobuffercircleModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_model_max(s : GeobuffercircleModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_model_to_string(s : GeobuffercircleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_layer_make(size : Int) -> GeobuffercircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_layer_len(s : GeobuffercircleLayer) -> Int { s.size }

pub fn geo_buffer_circle_layer_get(s : GeobuffercircleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_layer_set(s : GeobuffercircleLayer, i : Int, v : Double) -> GeobuffercircleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_layer_sum(s : GeobuffercircleLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_layer_mean(s : GeobuffercircleLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_layer_scale(s : GeobuffercircleLayer, f : Double) -> GeobuffercircleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_layer_add(a : GeobuffercircleLayer, b : GeobuffercircleLayer) -> GeobuffercircleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_layer_copy(s : GeobuffercircleLayer) -> GeobuffercircleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_layer_fill(s : GeobuffercircleLayer, v : Double) -> GeobuffercircleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_layer_min(s : GeobuffercircleLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_layer_max(s : GeobuffercircleLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_layer_to_string(s : GeobuffercircleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_buffer_make(size : Int) -> GeobuffercircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_buffer_len(s : GeobuffercircleBuffer) -> Int { s.size }

pub fn geo_buffer_circle_buffer_get(s : GeobuffercircleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_buffer_set(s : GeobuffercircleBuffer, i : Int, v : Double) -> GeobuffercircleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_buffer_sum(s : GeobuffercircleBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_buffer_mean(s : GeobuffercircleBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_buffer_scale(s : GeobuffercircleBuffer, f : Double) -> GeobuffercircleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_buffer_add(a : GeobuffercircleBuffer, b : GeobuffercircleBuffer) -> GeobuffercircleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_buffer_copy(s : GeobuffercircleBuffer) -> GeobuffercircleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_buffer_fill(s : GeobuffercircleBuffer, v : Double) -> GeobuffercircleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_buffer_min(s : GeobuffercircleBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_buffer_max(s : GeobuffercircleBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_buffer_to_string(s : GeobuffercircleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_cursor_make(size : Int) -> GeobuffercircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_cursor_len(s : GeobuffercircleCursor) -> Int { s.size }

pub fn geo_buffer_circle_cursor_get(s : GeobuffercircleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_cursor_set(s : GeobuffercircleCursor, i : Int, v : Double) -> GeobuffercircleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cursor_sum(s : GeobuffercircleCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_cursor_mean(s : GeobuffercircleCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_cursor_scale(s : GeobuffercircleCursor, f : Double) -> GeobuffercircleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cursor_add(a : GeobuffercircleCursor, b : GeobuffercircleCursor) -> GeobuffercircleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_cursor_copy(s : GeobuffercircleCursor) -> GeobuffercircleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cursor_fill(s : GeobuffercircleCursor, v : Double) -> GeobuffercircleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_cursor_min(s : GeobuffercircleCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_cursor_max(s : GeobuffercircleCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_cursor_to_string(s : GeobuffercircleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_view_make(size : Int) -> GeobuffercircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_view_len(s : GeobuffercircleView) -> Int { s.size }

pub fn geo_buffer_circle_view_get(s : GeobuffercircleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_view_set(s : GeobuffercircleView, i : Int, v : Double) -> GeobuffercircleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_view_sum(s : GeobuffercircleView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_view_mean(s : GeobuffercircleView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_view_scale(s : GeobuffercircleView, f : Double) -> GeobuffercircleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_view_add(a : GeobuffercircleView, b : GeobuffercircleView) -> GeobuffercircleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_view_copy(s : GeobuffercircleView) -> GeobuffercircleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_view_fill(s : GeobuffercircleView, v : Double) -> GeobuffercircleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_view_min(s : GeobuffercircleView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_view_max(s : GeobuffercircleView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_view_to_string(s : GeobuffercircleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_range_make(size : Int) -> GeobuffercircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_range_len(s : GeobuffercircleRange) -> Int { s.size }

pub fn geo_buffer_circle_range_get(s : GeobuffercircleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_range_set(s : GeobuffercircleRange, i : Int, v : Double) -> GeobuffercircleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_range_sum(s : GeobuffercircleRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_range_mean(s : GeobuffercircleRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_range_scale(s : GeobuffercircleRange, f : Double) -> GeobuffercircleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_range_add(a : GeobuffercircleRange, b : GeobuffercircleRange) -> GeobuffercircleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_range_copy(s : GeobuffercircleRange) -> GeobuffercircleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_range_fill(s : GeobuffercircleRange, v : Double) -> GeobuffercircleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_range_min(s : GeobuffercircleRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_range_max(s : GeobuffercircleRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_range_to_string(s : GeobuffercircleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_slice_make(size : Int) -> GeobuffercircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_circle_slice_len(s : GeobuffercircleSlice) -> Int { s.size }

pub fn geo_buffer_circle_slice_get(s : GeobuffercircleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_circle_slice_set(s : GeobuffercircleSlice, i : Int, v : Double) -> GeobuffercircleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_slice_sum(s : GeobuffercircleSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_circle_slice_mean(s : GeobuffercircleSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_circle_slice_scale(s : GeobuffercircleSlice, f : Double) -> GeobuffercircleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_slice_add(a : GeobuffercircleSlice, b : GeobuffercircleSlice) -> GeobuffercircleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_circle_slice_copy(s : GeobuffercircleSlice) -> GeobuffercircleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_slice_fill(s : GeobuffercircleSlice, v : Double) -> GeobuffercircleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_circle_slice_min(s : GeobuffercircleSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_circle_slice_max(s : GeobuffercircleSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_circle_slice_to_string(s : GeobuffercircleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

