///===
/// extcore/geo_buffer_line

pub(all) struct GeobufferlinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_line_make_point(x : Double, y : Double) -> GeobufferlinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_line_make_point3(x : Double, y : Double, z : Double) -> GeobufferlinePoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferlinePoint::x(self : GeobufferlinePoint) -> Double { self.x }

pub fn GeobufferlinePoint::y(self : GeobufferlinePoint) -> Double { self.y }

pub fn GeobufferlinePoint::z(self : GeobufferlinePoint) -> Double { self.z }

pub fn GeobufferlinePoint::label(self : GeobufferlinePoint) -> Int { self.label }

pub fn GeobufferlinePoint::dist(self : GeobufferlinePoint, other : GeobufferlinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferlinePoint::add(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferlinePoint::sub(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferlinePoint::scale(self : GeobufferlinePoint, s : Double) -> GeobufferlinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferlinePoint::dot(self : GeobufferlinePoint, other : GeobufferlinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferlinePoint::cross(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferlinePoint::norm(self : GeobufferlinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferlinePoint::normalize(self : GeobufferlinePoint) -> GeobufferlinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferlinePoint::negate(self : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferlinePoint::mid(self : GeobufferlinePoint, other : GeobufferlinePoint) -> GeobufferlinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferlinePoint::lerp(self : GeobufferlinePoint, other : GeobufferlinePoint, t : Double) -> GeobufferlinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferlinePoint::to_string(self : GeobufferlinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferlineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_line_make_series(vals : Array[Double], name : String) -> GeobufferlineSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferlineSeries::len(self : GeobufferlineSeries) -> Int { self.vals.length() }

pub fn GeobufferlineSeries::sum(self : GeobufferlineSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferlineSeries::mean(self : GeobufferlineSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferlineSeries::min(self : GeobufferlineSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferlineSeries::max(self : GeobufferlineSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferlineSeries::range(self : GeobufferlineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferlineSeries::variance(self : GeobufferlineSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferlineSeries::std(self : GeobufferlineSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferlineSeries::median(self : GeobufferlineSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferlineSeries::scale(self : GeobufferlineSeries, f : Double) -> GeobufferlineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferlineSeries::add(self : GeobufferlineSeries, other : GeobufferlineSeries) -> GeobufferlineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferlineSeries::sub(self : GeobufferlineSeries, other : GeobufferlineSeries) -> GeobufferlineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferlineSeries::normalize(self : GeobufferlineSeries) -> GeobufferlineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferlineSeries::cumsum(self : GeobufferlineSeries) -> GeobufferlineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferlineSeries::to_string(self : GeobufferlineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferlineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_line_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferlineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_line_matrix_identity(n : Int) -> GeobufferlineMatrix {
  let m = geo_buffer_line_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferlineMatrix::get(self : GeobufferlineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferlineMatrix::transpose(self : GeobufferlineMatrix) -> GeobufferlineMatrix {
  let result = geo_buffer_line_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferlineMatrix::add(self : GeobufferlineMatrix, other : GeobufferlineMatrix) -> GeobufferlineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferlineMatrix::scale(self : GeobufferlineMatrix, s : Double) -> GeobufferlineMatrix {
  let result = geo_buffer_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferlineMatrix::multiply(self : GeobufferlineMatrix, other : GeobufferlineMatrix) -> GeobufferlineMatrix {
  if self.cols != other.rows { return geo_buffer_line_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_line_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferlineMatrix::trace(self : GeobufferlineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferlineMatrix::det(self : GeobufferlineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferlineMatrix::norm(self : GeobufferlineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferlineMatrix::to_string(self : GeobufferlineMatrix) -> String {
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

pub(all) struct GeobufferlineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_line_make_vector(comps : Array[Double]) -> GeobufferlineVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_line_vector_zero(dim : Int) -> GeobufferlineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferlineVector::add(self : GeobufferlineVector, other : GeobufferlineVector) -> GeobufferlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferlineVector::sub(self : GeobufferlineVector, other : GeobufferlineVector) -> GeobufferlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferlineVector::scale(self : GeobufferlineVector, s : Double) -> GeobufferlineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferlineVector::dot(self : GeobufferlineVector, other : GeobufferlineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferlineVector::norm(self : GeobufferlineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferlineVector::normalize(self : GeobufferlineVector) -> GeobufferlineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferlineVector::dist(self : GeobufferlineVector, other : GeobufferlineVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferlineVector::to_string(self : GeobufferlineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_line_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_line_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_line_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_line_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_line_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_line_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_line_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_line_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_line_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_line_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_line_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_line_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_line_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_line_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_line_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_line_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_line_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_line_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_line_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_line_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_line_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_line_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_line_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_line_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_line_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_line_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_line_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_line_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_line_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferlineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_frame_make(size : Int) -> GeobufferlineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_frame_len(s : GeobufferlineFrame) -> Int { s.size }

pub fn geo_buffer_line_frame_get(s : GeobufferlineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_frame_set(s : GeobufferlineFrame, i : Int, v : Double) -> GeobufferlineFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_frame_sum(s : GeobufferlineFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_frame_mean(s : GeobufferlineFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_frame_scale(s : GeobufferlineFrame, f : Double) -> GeobufferlineFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_frame_add(a : GeobufferlineFrame, b : GeobufferlineFrame) -> GeobufferlineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_frame_copy(s : GeobufferlineFrame) -> GeobufferlineFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_frame_fill(s : GeobufferlineFrame, v : Double) -> GeobufferlineFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_frame_min(s : GeobufferlineFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_frame_max(s : GeobufferlineFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_frame_to_string(s : GeobufferlineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_table_make(size : Int) -> GeobufferlineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_table_len(s : GeobufferlineTable) -> Int { s.size }

pub fn geo_buffer_line_table_get(s : GeobufferlineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_table_set(s : GeobufferlineTable, i : Int, v : Double) -> GeobufferlineTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_table_sum(s : GeobufferlineTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_table_mean(s : GeobufferlineTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_table_scale(s : GeobufferlineTable, f : Double) -> GeobufferlineTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_table_add(a : GeobufferlineTable, b : GeobufferlineTable) -> GeobufferlineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_table_copy(s : GeobufferlineTable) -> GeobufferlineTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_table_fill(s : GeobufferlineTable, v : Double) -> GeobufferlineTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_table_min(s : GeobufferlineTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_table_max(s : GeobufferlineTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_table_to_string(s : GeobufferlineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_graphn_make(size : Int) -> GeobufferlineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_graphn_len(s : GeobufferlineGraphN) -> Int { s.size }

pub fn geo_buffer_line_graphn_get(s : GeobufferlineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_graphn_set(s : GeobufferlineGraphN, i : Int, v : Double) -> GeobufferlineGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_graphn_sum(s : GeobufferlineGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_graphn_mean(s : GeobufferlineGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_graphn_scale(s : GeobufferlineGraphN, f : Double) -> GeobufferlineGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_graphn_add(a : GeobufferlineGraphN, b : GeobufferlineGraphN) -> GeobufferlineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_graphn_copy(s : GeobufferlineGraphN) -> GeobufferlineGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_graphn_fill(s : GeobufferlineGraphN, v : Double) -> GeobufferlineGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_graphn_min(s : GeobufferlineGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_graphn_max(s : GeobufferlineGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_graphn_to_string(s : GeobufferlineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_node_make(size : Int) -> GeobufferlineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_node_len(s : GeobufferlineNode) -> Int { s.size }

pub fn geo_buffer_line_node_get(s : GeobufferlineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_node_set(s : GeobufferlineNode, i : Int, v : Double) -> GeobufferlineNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_node_sum(s : GeobufferlineNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_node_mean(s : GeobufferlineNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_node_scale(s : GeobufferlineNode, f : Double) -> GeobufferlineNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_node_add(a : GeobufferlineNode, b : GeobufferlineNode) -> GeobufferlineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_node_copy(s : GeobufferlineNode) -> GeobufferlineNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_node_fill(s : GeobufferlineNode, v : Double) -> GeobufferlineNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_node_min(s : GeobufferlineNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_node_max(s : GeobufferlineNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_node_to_string(s : GeobufferlineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_edge_make(size : Int) -> GeobufferlineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_edge_len(s : GeobufferlineEdge) -> Int { s.size }

pub fn geo_buffer_line_edge_get(s : GeobufferlineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_edge_set(s : GeobufferlineEdge, i : Int, v : Double) -> GeobufferlineEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_edge_sum(s : GeobufferlineEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_edge_mean(s : GeobufferlineEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_edge_scale(s : GeobufferlineEdge, f : Double) -> GeobufferlineEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_edge_add(a : GeobufferlineEdge, b : GeobufferlineEdge) -> GeobufferlineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_edge_copy(s : GeobufferlineEdge) -> GeobufferlineEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_edge_fill(s : GeobufferlineEdge, v : Double) -> GeobufferlineEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_edge_min(s : GeobufferlineEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_edge_max(s : GeobufferlineEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_edge_to_string(s : GeobufferlineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_path_make(size : Int) -> GeobufferlinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_path_len(s : GeobufferlinePath) -> Int { s.size }

pub fn geo_buffer_line_path_get(s : GeobufferlinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_path_set(s : GeobufferlinePath, i : Int, v : Double) -> GeobufferlinePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_path_sum(s : GeobufferlinePath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_path_mean(s : GeobufferlinePath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_path_scale(s : GeobufferlinePath, f : Double) -> GeobufferlinePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_path_add(a : GeobufferlinePath, b : GeobufferlinePath) -> GeobufferlinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_path_copy(s : GeobufferlinePath) -> GeobufferlinePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_path_fill(s : GeobufferlinePath, v : Double) -> GeobufferlinePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_path_min(s : GeobufferlinePath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_path_max(s : GeobufferlinePath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_path_to_string(s : GeobufferlinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_cluster_make(size : Int) -> GeobufferlineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_cluster_len(s : GeobufferlineCluster) -> Int { s.size }

pub fn geo_buffer_line_cluster_get(s : GeobufferlineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_cluster_set(s : GeobufferlineCluster, i : Int, v : Double) -> GeobufferlineCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cluster_sum(s : GeobufferlineCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_cluster_mean(s : GeobufferlineCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_cluster_scale(s : GeobufferlineCluster, f : Double) -> GeobufferlineCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cluster_add(a : GeobufferlineCluster, b : GeobufferlineCluster) -> GeobufferlineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_cluster_copy(s : GeobufferlineCluster) -> GeobufferlineCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cluster_fill(s : GeobufferlineCluster, v : Double) -> GeobufferlineCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cluster_min(s : GeobufferlineCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_cluster_max(s : GeobufferlineCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_cluster_to_string(s : GeobufferlineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_model_make(size : Int) -> GeobufferlineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_model_len(s : GeobufferlineModel) -> Int { s.size }

pub fn geo_buffer_line_model_get(s : GeobufferlineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_model_set(s : GeobufferlineModel, i : Int, v : Double) -> GeobufferlineModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_model_sum(s : GeobufferlineModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_model_mean(s : GeobufferlineModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_model_scale(s : GeobufferlineModel, f : Double) -> GeobufferlineModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_model_add(a : GeobufferlineModel, b : GeobufferlineModel) -> GeobufferlineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_model_copy(s : GeobufferlineModel) -> GeobufferlineModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_model_fill(s : GeobufferlineModel, v : Double) -> GeobufferlineModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_model_min(s : GeobufferlineModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_model_max(s : GeobufferlineModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_model_to_string(s : GeobufferlineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_layer_make(size : Int) -> GeobufferlineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_layer_len(s : GeobufferlineLayer) -> Int { s.size }

pub fn geo_buffer_line_layer_get(s : GeobufferlineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_layer_set(s : GeobufferlineLayer, i : Int, v : Double) -> GeobufferlineLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_layer_sum(s : GeobufferlineLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_layer_mean(s : GeobufferlineLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_layer_scale(s : GeobufferlineLayer, f : Double) -> GeobufferlineLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_layer_add(a : GeobufferlineLayer, b : GeobufferlineLayer) -> GeobufferlineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_layer_copy(s : GeobufferlineLayer) -> GeobufferlineLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_layer_fill(s : GeobufferlineLayer, v : Double) -> GeobufferlineLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_layer_min(s : GeobufferlineLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_layer_max(s : GeobufferlineLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_layer_to_string(s : GeobufferlineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_buffer_make(size : Int) -> GeobufferlineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_buffer_len(s : GeobufferlineBuffer) -> Int { s.size }

pub fn geo_buffer_line_buffer_get(s : GeobufferlineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_buffer_set(s : GeobufferlineBuffer, i : Int, v : Double) -> GeobufferlineBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_buffer_sum(s : GeobufferlineBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_buffer_mean(s : GeobufferlineBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_buffer_scale(s : GeobufferlineBuffer, f : Double) -> GeobufferlineBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_buffer_add(a : GeobufferlineBuffer, b : GeobufferlineBuffer) -> GeobufferlineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_buffer_copy(s : GeobufferlineBuffer) -> GeobufferlineBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_buffer_fill(s : GeobufferlineBuffer, v : Double) -> GeobufferlineBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_buffer_min(s : GeobufferlineBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_buffer_max(s : GeobufferlineBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_buffer_to_string(s : GeobufferlineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_cursor_make(size : Int) -> GeobufferlineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_cursor_len(s : GeobufferlineCursor) -> Int { s.size }

pub fn geo_buffer_line_cursor_get(s : GeobufferlineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_cursor_set(s : GeobufferlineCursor, i : Int, v : Double) -> GeobufferlineCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cursor_sum(s : GeobufferlineCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_cursor_mean(s : GeobufferlineCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_cursor_scale(s : GeobufferlineCursor, f : Double) -> GeobufferlineCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cursor_add(a : GeobufferlineCursor, b : GeobufferlineCursor) -> GeobufferlineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_cursor_copy(s : GeobufferlineCursor) -> GeobufferlineCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cursor_fill(s : GeobufferlineCursor, v : Double) -> GeobufferlineCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_cursor_min(s : GeobufferlineCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_cursor_max(s : GeobufferlineCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_cursor_to_string(s : GeobufferlineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_view_make(size : Int) -> GeobufferlineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_view_len(s : GeobufferlineView) -> Int { s.size }

pub fn geo_buffer_line_view_get(s : GeobufferlineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_view_set(s : GeobufferlineView, i : Int, v : Double) -> GeobufferlineView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_view_sum(s : GeobufferlineView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_view_mean(s : GeobufferlineView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_view_scale(s : GeobufferlineView, f : Double) -> GeobufferlineView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_view_add(a : GeobufferlineView, b : GeobufferlineView) -> GeobufferlineView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_view_copy(s : GeobufferlineView) -> GeobufferlineView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_view_fill(s : GeobufferlineView, v : Double) -> GeobufferlineView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_view_min(s : GeobufferlineView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_view_max(s : GeobufferlineView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_view_to_string(s : GeobufferlineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_range_make(size : Int) -> GeobufferlineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_range_len(s : GeobufferlineRange) -> Int { s.size }

pub fn geo_buffer_line_range_get(s : GeobufferlineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_range_set(s : GeobufferlineRange, i : Int, v : Double) -> GeobufferlineRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_range_sum(s : GeobufferlineRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_range_mean(s : GeobufferlineRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_range_scale(s : GeobufferlineRange, f : Double) -> GeobufferlineRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_range_add(a : GeobufferlineRange, b : GeobufferlineRange) -> GeobufferlineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_range_copy(s : GeobufferlineRange) -> GeobufferlineRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_range_fill(s : GeobufferlineRange, v : Double) -> GeobufferlineRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_range_min(s : GeobufferlineRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_range_max(s : GeobufferlineRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_range_to_string(s : GeobufferlineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferlineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_line_slice_make(size : Int) -> GeobufferlineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_line_slice_len(s : GeobufferlineSlice) -> Int { s.size }

pub fn geo_buffer_line_slice_get(s : GeobufferlineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_line_slice_set(s : GeobufferlineSlice, i : Int, v : Double) -> GeobufferlineSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_slice_sum(s : GeobufferlineSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_line_slice_mean(s : GeobufferlineSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_line_slice_scale(s : GeobufferlineSlice, f : Double) -> GeobufferlineSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_slice_add(a : GeobufferlineSlice, b : GeobufferlineSlice) -> GeobufferlineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_line_slice_copy(s : GeobufferlineSlice) -> GeobufferlineSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_slice_fill(s : GeobufferlineSlice, v : Double) -> GeobufferlineSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_line_slice_min(s : GeobufferlineSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_line_slice_max(s : GeobufferlineSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_line_slice_to_string(s : GeobufferlineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

