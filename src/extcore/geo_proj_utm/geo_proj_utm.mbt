///===
/// extcore/geo_proj_utm

pub(all) struct GeoprojutmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_utm_make_point(x : Double, y : Double) -> GeoprojutmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_utm_make_point3(x : Double, y : Double, z : Double) -> GeoprojutmPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojutmPoint::x(self : GeoprojutmPoint) -> Double { self.x }

pub fn GeoprojutmPoint::y(self : GeoprojutmPoint) -> Double { self.y }

pub fn GeoprojutmPoint::z(self : GeoprojutmPoint) -> Double { self.z }

pub fn GeoprojutmPoint::label(self : GeoprojutmPoint) -> Int { self.label }

pub fn GeoprojutmPoint::dist(self : GeoprojutmPoint, other : GeoprojutmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojutmPoint::add(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojutmPoint::sub(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojutmPoint::scale(self : GeoprojutmPoint, s : Double) -> GeoprojutmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojutmPoint::dot(self : GeoprojutmPoint, other : GeoprojutmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojutmPoint::cross(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojutmPoint::norm(self : GeoprojutmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojutmPoint::normalize(self : GeoprojutmPoint) -> GeoprojutmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojutmPoint::negate(self : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojutmPoint::mid(self : GeoprojutmPoint, other : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojutmPoint::lerp(self : GeoprojutmPoint, other : GeoprojutmPoint, t : Double) -> GeoprojutmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojutmPoint::to_string(self : GeoprojutmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojutmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_utm_make_series(vals : Array[Double], name : String) -> GeoprojutmSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojutmSeries::len(self : GeoprojutmSeries) -> Int { self.vals.length() }

pub fn GeoprojutmSeries::sum(self : GeoprojutmSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojutmSeries::mean(self : GeoprojutmSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojutmSeries::min(self : GeoprojutmSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojutmSeries::max(self : GeoprojutmSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojutmSeries::range(self : GeoprojutmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojutmSeries::variance(self : GeoprojutmSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojutmSeries::std(self : GeoprojutmSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojutmSeries::median(self : GeoprojutmSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojutmSeries::scale(self : GeoprojutmSeries, f : Double) -> GeoprojutmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojutmSeries::add(self : GeoprojutmSeries, other : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojutmSeries::sub(self : GeoprojutmSeries, other : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojutmSeries::normalize(self : GeoprojutmSeries) -> GeoprojutmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojutmSeries::cumsum(self : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojutmSeries::to_string(self : GeoprojutmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojutmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_utm_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojutmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_utm_matrix_identity(n : Int) -> GeoprojutmMatrix {
  let m = geo_proj_utm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojutmMatrix::get(self : GeoprojutmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojutmMatrix::transpose(self : GeoprojutmMatrix) -> GeoprojutmMatrix {
  let result = geo_proj_utm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojutmMatrix::add(self : GeoprojutmMatrix, other : GeoprojutmMatrix) -> GeoprojutmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_utm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojutmMatrix::scale(self : GeoprojutmMatrix, s : Double) -> GeoprojutmMatrix {
  let result = geo_proj_utm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojutmMatrix::multiply(self : GeoprojutmMatrix, other : GeoprojutmMatrix) -> GeoprojutmMatrix {
  if self.cols != other.rows { return geo_proj_utm_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_utm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojutmMatrix::trace(self : GeoprojutmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojutmMatrix::det(self : GeoprojutmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojutmMatrix::norm(self : GeoprojutmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojutmMatrix::to_string(self : GeoprojutmMatrix) -> String {
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

pub(all) struct GeoprojutmVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_utm_make_vector(comps : Array[Double]) -> GeoprojutmVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_utm_vector_zero(dim : Int) -> GeoprojutmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojutmVector::add(self : GeoprojutmVector, other : GeoprojutmVector) -> GeoprojutmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojutmVector::sub(self : GeoprojutmVector, other : GeoprojutmVector) -> GeoprojutmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojutmVector::scale(self : GeoprojutmVector, s : Double) -> GeoprojutmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojutmVector::dot(self : GeoprojutmVector, other : GeoprojutmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojutmVector::norm(self : GeoprojutmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojutmVector::normalize(self : GeoprojutmVector) -> GeoprojutmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojutmVector::dist(self : GeoprojutmVector, other : GeoprojutmVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojutmVector::to_string(self : GeoprojutmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_utm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_utm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_utm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_utm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_utm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_utm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_utm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_utm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_utm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_utm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_utm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_utm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_utm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_utm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_utm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_utm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_utm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_utm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_utm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_utm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_utm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_utm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_utm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_utm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_utm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_utm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_utm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_utm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_utm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojutmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_frame_make(size : Int) -> GeoprojutmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_frame_len(s : GeoprojutmFrame) -> Int { s.size }

pub fn geo_proj_utm_frame_get(s : GeoprojutmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_frame_set(s : GeoprojutmFrame, i : Int, v : Double) -> GeoprojutmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_sum(s : GeoprojutmFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_frame_mean(s : GeoprojutmFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_frame_scale(s : GeoprojutmFrame, f : Double) -> GeoprojutmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_add(a : GeoprojutmFrame, b : GeoprojutmFrame) -> GeoprojutmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_frame_copy(s : GeoprojutmFrame) -> GeoprojutmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_fill(s : GeoprojutmFrame, v : Double) -> GeoprojutmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_min(s : GeoprojutmFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_frame_max(s : GeoprojutmFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_frame_to_string(s : GeoprojutmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_table_make(size : Int) -> GeoprojutmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_table_len(s : GeoprojutmTable) -> Int { s.size }

pub fn geo_proj_utm_table_get(s : GeoprojutmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_table_set(s : GeoprojutmTable, i : Int, v : Double) -> GeoprojutmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_sum(s : GeoprojutmTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_table_mean(s : GeoprojutmTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_table_scale(s : GeoprojutmTable, f : Double) -> GeoprojutmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_add(a : GeoprojutmTable, b : GeoprojutmTable) -> GeoprojutmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_table_copy(s : GeoprojutmTable) -> GeoprojutmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_fill(s : GeoprojutmTable, v : Double) -> GeoprojutmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_min(s : GeoprojutmTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_table_max(s : GeoprojutmTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_table_to_string(s : GeoprojutmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_graphn_make(size : Int) -> GeoprojutmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_graphn_len(s : GeoprojutmGraphN) -> Int { s.size }

pub fn geo_proj_utm_graphn_get(s : GeoprojutmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_graphn_set(s : GeoprojutmGraphN, i : Int, v : Double) -> GeoprojutmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_sum(s : GeoprojutmGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_graphn_mean(s : GeoprojutmGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_graphn_scale(s : GeoprojutmGraphN, f : Double) -> GeoprojutmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_add(a : GeoprojutmGraphN, b : GeoprojutmGraphN) -> GeoprojutmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_graphn_copy(s : GeoprojutmGraphN) -> GeoprojutmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_fill(s : GeoprojutmGraphN, v : Double) -> GeoprojutmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_min(s : GeoprojutmGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_graphn_max(s : GeoprojutmGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_graphn_to_string(s : GeoprojutmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_node_make(size : Int) -> GeoprojutmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_node_len(s : GeoprojutmNode) -> Int { s.size }

pub fn geo_proj_utm_node_get(s : GeoprojutmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_node_set(s : GeoprojutmNode, i : Int, v : Double) -> GeoprojutmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_sum(s : GeoprojutmNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_node_mean(s : GeoprojutmNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_node_scale(s : GeoprojutmNode, f : Double) -> GeoprojutmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_add(a : GeoprojutmNode, b : GeoprojutmNode) -> GeoprojutmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_node_copy(s : GeoprojutmNode) -> GeoprojutmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_fill(s : GeoprojutmNode, v : Double) -> GeoprojutmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_min(s : GeoprojutmNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_node_max(s : GeoprojutmNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_node_to_string(s : GeoprojutmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_edge_make(size : Int) -> GeoprojutmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_edge_len(s : GeoprojutmEdge) -> Int { s.size }

pub fn geo_proj_utm_edge_get(s : GeoprojutmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_edge_set(s : GeoprojutmEdge, i : Int, v : Double) -> GeoprojutmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_sum(s : GeoprojutmEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_edge_mean(s : GeoprojutmEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_edge_scale(s : GeoprojutmEdge, f : Double) -> GeoprojutmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_add(a : GeoprojutmEdge, b : GeoprojutmEdge) -> GeoprojutmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_edge_copy(s : GeoprojutmEdge) -> GeoprojutmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_fill(s : GeoprojutmEdge, v : Double) -> GeoprojutmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_min(s : GeoprojutmEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_edge_max(s : GeoprojutmEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_edge_to_string(s : GeoprojutmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_path_make(size : Int) -> GeoprojutmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_path_len(s : GeoprojutmPath) -> Int { s.size }

pub fn geo_proj_utm_path_get(s : GeoprojutmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_path_set(s : GeoprojutmPath, i : Int, v : Double) -> GeoprojutmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_sum(s : GeoprojutmPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_path_mean(s : GeoprojutmPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_path_scale(s : GeoprojutmPath, f : Double) -> GeoprojutmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_add(a : GeoprojutmPath, b : GeoprojutmPath) -> GeoprojutmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_path_copy(s : GeoprojutmPath) -> GeoprojutmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_fill(s : GeoprojutmPath, v : Double) -> GeoprojutmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_min(s : GeoprojutmPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_path_max(s : GeoprojutmPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_path_to_string(s : GeoprojutmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_cluster_make(size : Int) -> GeoprojutmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_cluster_len(s : GeoprojutmCluster) -> Int { s.size }

pub fn geo_proj_utm_cluster_get(s : GeoprojutmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_cluster_set(s : GeoprojutmCluster, i : Int, v : Double) -> GeoprojutmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_sum(s : GeoprojutmCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_cluster_mean(s : GeoprojutmCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_cluster_scale(s : GeoprojutmCluster, f : Double) -> GeoprojutmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_add(a : GeoprojutmCluster, b : GeoprojutmCluster) -> GeoprojutmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_cluster_copy(s : GeoprojutmCluster) -> GeoprojutmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_fill(s : GeoprojutmCluster, v : Double) -> GeoprojutmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_min(s : GeoprojutmCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_cluster_max(s : GeoprojutmCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_cluster_to_string(s : GeoprojutmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_model_make(size : Int) -> GeoprojutmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_model_len(s : GeoprojutmModel) -> Int { s.size }

pub fn geo_proj_utm_model_get(s : GeoprojutmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_model_set(s : GeoprojutmModel, i : Int, v : Double) -> GeoprojutmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_sum(s : GeoprojutmModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_model_mean(s : GeoprojutmModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_model_scale(s : GeoprojutmModel, f : Double) -> GeoprojutmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_add(a : GeoprojutmModel, b : GeoprojutmModel) -> GeoprojutmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_model_copy(s : GeoprojutmModel) -> GeoprojutmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_fill(s : GeoprojutmModel, v : Double) -> GeoprojutmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_min(s : GeoprojutmModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_model_max(s : GeoprojutmModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_model_to_string(s : GeoprojutmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_layer_make(size : Int) -> GeoprojutmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_layer_len(s : GeoprojutmLayer) -> Int { s.size }

pub fn geo_proj_utm_layer_get(s : GeoprojutmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_layer_set(s : GeoprojutmLayer, i : Int, v : Double) -> GeoprojutmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_sum(s : GeoprojutmLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_layer_mean(s : GeoprojutmLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_layer_scale(s : GeoprojutmLayer, f : Double) -> GeoprojutmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_add(a : GeoprojutmLayer, b : GeoprojutmLayer) -> GeoprojutmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_layer_copy(s : GeoprojutmLayer) -> GeoprojutmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_fill(s : GeoprojutmLayer, v : Double) -> GeoprojutmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_min(s : GeoprojutmLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_layer_max(s : GeoprojutmLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_layer_to_string(s : GeoprojutmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_buffer_make(size : Int) -> GeoprojutmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_buffer_len(s : GeoprojutmBuffer) -> Int { s.size }

pub fn geo_proj_utm_buffer_get(s : GeoprojutmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_buffer_set(s : GeoprojutmBuffer, i : Int, v : Double) -> GeoprojutmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_sum(s : GeoprojutmBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_buffer_mean(s : GeoprojutmBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_buffer_scale(s : GeoprojutmBuffer, f : Double) -> GeoprojutmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_add(a : GeoprojutmBuffer, b : GeoprojutmBuffer) -> GeoprojutmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_buffer_copy(s : GeoprojutmBuffer) -> GeoprojutmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_fill(s : GeoprojutmBuffer, v : Double) -> GeoprojutmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_min(s : GeoprojutmBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_buffer_max(s : GeoprojutmBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_buffer_to_string(s : GeoprojutmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_cursor_make(size : Int) -> GeoprojutmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_cursor_len(s : GeoprojutmCursor) -> Int { s.size }

pub fn geo_proj_utm_cursor_get(s : GeoprojutmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_cursor_set(s : GeoprojutmCursor, i : Int, v : Double) -> GeoprojutmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_sum(s : GeoprojutmCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_cursor_mean(s : GeoprojutmCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_cursor_scale(s : GeoprojutmCursor, f : Double) -> GeoprojutmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_add(a : GeoprojutmCursor, b : GeoprojutmCursor) -> GeoprojutmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_cursor_copy(s : GeoprojutmCursor) -> GeoprojutmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_fill(s : GeoprojutmCursor, v : Double) -> GeoprojutmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_min(s : GeoprojutmCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_cursor_max(s : GeoprojutmCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_cursor_to_string(s : GeoprojutmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_view_make(size : Int) -> GeoprojutmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_view_len(s : GeoprojutmView) -> Int { s.size }

pub fn geo_proj_utm_view_get(s : GeoprojutmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_view_set(s : GeoprojutmView, i : Int, v : Double) -> GeoprojutmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_sum(s : GeoprojutmView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_view_mean(s : GeoprojutmView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_view_scale(s : GeoprojutmView, f : Double) -> GeoprojutmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_add(a : GeoprojutmView, b : GeoprojutmView) -> GeoprojutmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_view_copy(s : GeoprojutmView) -> GeoprojutmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_fill(s : GeoprojutmView, v : Double) -> GeoprojutmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_min(s : GeoprojutmView) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_view_max(s : GeoprojutmView) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_view_to_string(s : GeoprojutmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_range_make(size : Int) -> GeoprojutmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_range_len(s : GeoprojutmRange) -> Int { s.size }

pub fn geo_proj_utm_range_get(s : GeoprojutmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_range_set(s : GeoprojutmRange, i : Int, v : Double) -> GeoprojutmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_sum(s : GeoprojutmRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_range_mean(s : GeoprojutmRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_range_scale(s : GeoprojutmRange, f : Double) -> GeoprojutmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_add(a : GeoprojutmRange, b : GeoprojutmRange) -> GeoprojutmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_range_copy(s : GeoprojutmRange) -> GeoprojutmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_fill(s : GeoprojutmRange, v : Double) -> GeoprojutmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_min(s : GeoprojutmRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_range_max(s : GeoprojutmRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_range_to_string(s : GeoprojutmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_slice_make(size : Int) -> GeoprojutmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_slice_len(s : GeoprojutmSlice) -> Int { s.size }

pub fn geo_proj_utm_slice_get(s : GeoprojutmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_slice_set(s : GeoprojutmSlice, i : Int, v : Double) -> GeoprojutmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_sum(s : GeoprojutmSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_slice_mean(s : GeoprojutmSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_slice_scale(s : GeoprojutmSlice, f : Double) -> GeoprojutmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_add(a : GeoprojutmSlice, b : GeoprojutmSlice) -> GeoprojutmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_slice_copy(s : GeoprojutmSlice) -> GeoprojutmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_fill(s : GeoprojutmSlice, v : Double) -> GeoprojutmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_min(s : GeoprojutmSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_slice_max(s : GeoprojutmSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_slice_to_string(s : GeoprojutmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

