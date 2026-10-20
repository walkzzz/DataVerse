///===
/// extcore/net_route_eigrp

pub(all) struct NetrouteeigrpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_eigrp_make_point(x : Double, y : Double) -> NetrouteeigrpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_eigrp_make_point3(x : Double, y : Double, z : Double) -> NetrouteeigrpPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteeigrpPoint::x(self : NetrouteeigrpPoint) -> Double { self.x }

pub fn NetrouteeigrpPoint::y(self : NetrouteeigrpPoint) -> Double { self.y }

pub fn NetrouteeigrpPoint::z(self : NetrouteeigrpPoint) -> Double { self.z }

pub fn NetrouteeigrpPoint::label(self : NetrouteeigrpPoint) -> Int { self.label }

pub fn NetrouteeigrpPoint::dist(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteeigrpPoint::add(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteeigrpPoint::sub(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteeigrpPoint::scale(self : NetrouteeigrpPoint, s : Double) -> NetrouteeigrpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteeigrpPoint::dot(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteeigrpPoint::cross(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteeigrpPoint::norm(self : NetrouteeigrpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteeigrpPoint::normalize(self : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteeigrpPoint::negate(self : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteeigrpPoint::mid(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint) -> NetrouteeigrpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteeigrpPoint::lerp(self : NetrouteeigrpPoint, other : NetrouteeigrpPoint, t : Double) -> NetrouteeigrpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteeigrpPoint::to_string(self : NetrouteeigrpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteeigrpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_eigrp_make_series(vals : Array[Double], name : String) -> NetrouteeigrpSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteeigrpSeries::len(self : NetrouteeigrpSeries) -> Int { self.vals.length() }

pub fn NetrouteeigrpSeries::sum(self : NetrouteeigrpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteeigrpSeries::mean(self : NetrouteeigrpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteeigrpSeries::min(self : NetrouteeigrpSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteeigrpSeries::max(self : NetrouteeigrpSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteeigrpSeries::range(self : NetrouteeigrpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteeigrpSeries::variance(self : NetrouteeigrpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteeigrpSeries::std(self : NetrouteeigrpSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteeigrpSeries::median(self : NetrouteeigrpSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteeigrpSeries::scale(self : NetrouteeigrpSeries, f : Double) -> NetrouteeigrpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteeigrpSeries::add(self : NetrouteeigrpSeries, other : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteeigrpSeries::sub(self : NetrouteeigrpSeries, other : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteeigrpSeries::normalize(self : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteeigrpSeries::cumsum(self : NetrouteeigrpSeries) -> NetrouteeigrpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteeigrpSeries::to_string(self : NetrouteeigrpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteeigrpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_eigrp_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteeigrpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_eigrp_matrix_identity(n : Int) -> NetrouteeigrpMatrix {
  let m = net_route_eigrp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteeigrpMatrix::get(self : NetrouteeigrpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteeigrpMatrix::transpose(self : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  let result = net_route_eigrp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteeigrpMatrix::add(self : NetrouteeigrpMatrix, other : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_eigrp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteeigrpMatrix::scale(self : NetrouteeigrpMatrix, s : Double) -> NetrouteeigrpMatrix {
  let result = net_route_eigrp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteeigrpMatrix::multiply(self : NetrouteeigrpMatrix, other : NetrouteeigrpMatrix) -> NetrouteeigrpMatrix {
  if self.cols != other.rows { return net_route_eigrp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_eigrp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetrouteeigrpMatrix::trace(self : NetrouteeigrpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteeigrpMatrix::det(self : NetrouteeigrpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteeigrpMatrix::norm(self : NetrouteeigrpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteeigrpMatrix::to_string(self : NetrouteeigrpMatrix) -> String {
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

pub(all) struct NetrouteeigrpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_eigrp_make_vector(comps : Array[Double]) -> NetrouteeigrpVector {
  { comps, dim: comps.length() }
}

pub fn net_route_eigrp_vector_zero(dim : Int) -> NetrouteeigrpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteeigrpVector::add(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteeigrpVector::sub(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteeigrpVector::scale(self : NetrouteeigrpVector, s : Double) -> NetrouteeigrpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteeigrpVector::dot(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteeigrpVector::norm(self : NetrouteeigrpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteeigrpVector::normalize(self : NetrouteeigrpVector) -> NetrouteeigrpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteeigrpVector::dist(self : NetrouteeigrpVector, other : NetrouteeigrpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteeigrpVector::to_string(self : NetrouteeigrpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_eigrp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_eigrp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_eigrp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_eigrp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_eigrp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_eigrp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_eigrp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_eigrp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_eigrp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_eigrp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_eigrp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_eigrp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_eigrp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_eigrp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_eigrp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_eigrp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_eigrp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_eigrp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_eigrp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_eigrp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_eigrp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_eigrp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_eigrp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_eigrp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_eigrp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_eigrp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_eigrp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_eigrp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_eigrp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetrouteeigrpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_frame_make(size : Int) -> NetrouteeigrpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_frame_len(s : NetrouteeigrpFrame) -> Int { s.size }

pub fn net_route_eigrp_frame_get(s : NetrouteeigrpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_frame_set(s : NetrouteeigrpFrame, i : Int, v : Double) -> NetrouteeigrpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_frame_sum(s : NetrouteeigrpFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_frame_mean(s : NetrouteeigrpFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_frame_scale(s : NetrouteeigrpFrame, f : Double) -> NetrouteeigrpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_frame_add(a : NetrouteeigrpFrame, b : NetrouteeigrpFrame) -> NetrouteeigrpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_frame_copy(s : NetrouteeigrpFrame) -> NetrouteeigrpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_frame_fill(s : NetrouteeigrpFrame, v : Double) -> NetrouteeigrpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_frame_min(s : NetrouteeigrpFrame) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_frame_max(s : NetrouteeigrpFrame) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_frame_to_string(s : NetrouteeigrpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_table_make(size : Int) -> NetrouteeigrpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_table_len(s : NetrouteeigrpTable) -> Int { s.size }

pub fn net_route_eigrp_table_get(s : NetrouteeigrpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_table_set(s : NetrouteeigrpTable, i : Int, v : Double) -> NetrouteeigrpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_table_sum(s : NetrouteeigrpTable) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_table_mean(s : NetrouteeigrpTable) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_table_scale(s : NetrouteeigrpTable, f : Double) -> NetrouteeigrpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_table_add(a : NetrouteeigrpTable, b : NetrouteeigrpTable) -> NetrouteeigrpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_table_copy(s : NetrouteeigrpTable) -> NetrouteeigrpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_table_fill(s : NetrouteeigrpTable, v : Double) -> NetrouteeigrpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_table_min(s : NetrouteeigrpTable) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_table_max(s : NetrouteeigrpTable) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_table_to_string(s : NetrouteeigrpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_graphn_make(size : Int) -> NetrouteeigrpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_graphn_len(s : NetrouteeigrpGraphN) -> Int { s.size }

pub fn net_route_eigrp_graphn_get(s : NetrouteeigrpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_graphn_set(s : NetrouteeigrpGraphN, i : Int, v : Double) -> NetrouteeigrpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_graphn_sum(s : NetrouteeigrpGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_graphn_mean(s : NetrouteeigrpGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_graphn_scale(s : NetrouteeigrpGraphN, f : Double) -> NetrouteeigrpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_graphn_add(a : NetrouteeigrpGraphN, b : NetrouteeigrpGraphN) -> NetrouteeigrpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_graphn_copy(s : NetrouteeigrpGraphN) -> NetrouteeigrpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_graphn_fill(s : NetrouteeigrpGraphN, v : Double) -> NetrouteeigrpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_graphn_min(s : NetrouteeigrpGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_graphn_max(s : NetrouteeigrpGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_graphn_to_string(s : NetrouteeigrpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_node_make(size : Int) -> NetrouteeigrpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_node_len(s : NetrouteeigrpNode) -> Int { s.size }

pub fn net_route_eigrp_node_get(s : NetrouteeigrpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_node_set(s : NetrouteeigrpNode, i : Int, v : Double) -> NetrouteeigrpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_node_sum(s : NetrouteeigrpNode) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_node_mean(s : NetrouteeigrpNode) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_node_scale(s : NetrouteeigrpNode, f : Double) -> NetrouteeigrpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_node_add(a : NetrouteeigrpNode, b : NetrouteeigrpNode) -> NetrouteeigrpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_node_copy(s : NetrouteeigrpNode) -> NetrouteeigrpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_node_fill(s : NetrouteeigrpNode, v : Double) -> NetrouteeigrpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_node_min(s : NetrouteeigrpNode) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_node_max(s : NetrouteeigrpNode) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_node_to_string(s : NetrouteeigrpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_edge_make(size : Int) -> NetrouteeigrpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_edge_len(s : NetrouteeigrpEdge) -> Int { s.size }

pub fn net_route_eigrp_edge_get(s : NetrouteeigrpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_edge_set(s : NetrouteeigrpEdge, i : Int, v : Double) -> NetrouteeigrpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_edge_sum(s : NetrouteeigrpEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_edge_mean(s : NetrouteeigrpEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_edge_scale(s : NetrouteeigrpEdge, f : Double) -> NetrouteeigrpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_edge_add(a : NetrouteeigrpEdge, b : NetrouteeigrpEdge) -> NetrouteeigrpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_edge_copy(s : NetrouteeigrpEdge) -> NetrouteeigrpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_edge_fill(s : NetrouteeigrpEdge, v : Double) -> NetrouteeigrpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_edge_min(s : NetrouteeigrpEdge) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_edge_max(s : NetrouteeigrpEdge) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_edge_to_string(s : NetrouteeigrpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_path_make(size : Int) -> NetrouteeigrpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_path_len(s : NetrouteeigrpPath) -> Int { s.size }

pub fn net_route_eigrp_path_get(s : NetrouteeigrpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_path_set(s : NetrouteeigrpPath, i : Int, v : Double) -> NetrouteeigrpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_path_sum(s : NetrouteeigrpPath) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_path_mean(s : NetrouteeigrpPath) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_path_scale(s : NetrouteeigrpPath, f : Double) -> NetrouteeigrpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_path_add(a : NetrouteeigrpPath, b : NetrouteeigrpPath) -> NetrouteeigrpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_path_copy(s : NetrouteeigrpPath) -> NetrouteeigrpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_path_fill(s : NetrouteeigrpPath, v : Double) -> NetrouteeigrpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_path_min(s : NetrouteeigrpPath) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_path_max(s : NetrouteeigrpPath) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_path_to_string(s : NetrouteeigrpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_cluster_make(size : Int) -> NetrouteeigrpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_cluster_len(s : NetrouteeigrpCluster) -> Int { s.size }

pub fn net_route_eigrp_cluster_get(s : NetrouteeigrpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_cluster_set(s : NetrouteeigrpCluster, i : Int, v : Double) -> NetrouteeigrpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cluster_sum(s : NetrouteeigrpCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_cluster_mean(s : NetrouteeigrpCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_cluster_scale(s : NetrouteeigrpCluster, f : Double) -> NetrouteeigrpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cluster_add(a : NetrouteeigrpCluster, b : NetrouteeigrpCluster) -> NetrouteeigrpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_cluster_copy(s : NetrouteeigrpCluster) -> NetrouteeigrpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cluster_fill(s : NetrouteeigrpCluster, v : Double) -> NetrouteeigrpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cluster_min(s : NetrouteeigrpCluster) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_cluster_max(s : NetrouteeigrpCluster) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_cluster_to_string(s : NetrouteeigrpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_model_make(size : Int) -> NetrouteeigrpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_model_len(s : NetrouteeigrpModel) -> Int { s.size }

pub fn net_route_eigrp_model_get(s : NetrouteeigrpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_model_set(s : NetrouteeigrpModel, i : Int, v : Double) -> NetrouteeigrpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_model_sum(s : NetrouteeigrpModel) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_model_mean(s : NetrouteeigrpModel) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_model_scale(s : NetrouteeigrpModel, f : Double) -> NetrouteeigrpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_model_add(a : NetrouteeigrpModel, b : NetrouteeigrpModel) -> NetrouteeigrpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_model_copy(s : NetrouteeigrpModel) -> NetrouteeigrpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_model_fill(s : NetrouteeigrpModel, v : Double) -> NetrouteeigrpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_model_min(s : NetrouteeigrpModel) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_model_max(s : NetrouteeigrpModel) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_model_to_string(s : NetrouteeigrpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_layer_make(size : Int) -> NetrouteeigrpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_layer_len(s : NetrouteeigrpLayer) -> Int { s.size }

pub fn net_route_eigrp_layer_get(s : NetrouteeigrpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_layer_set(s : NetrouteeigrpLayer, i : Int, v : Double) -> NetrouteeigrpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_layer_sum(s : NetrouteeigrpLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_layer_mean(s : NetrouteeigrpLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_layer_scale(s : NetrouteeigrpLayer, f : Double) -> NetrouteeigrpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_layer_add(a : NetrouteeigrpLayer, b : NetrouteeigrpLayer) -> NetrouteeigrpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_layer_copy(s : NetrouteeigrpLayer) -> NetrouteeigrpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_layer_fill(s : NetrouteeigrpLayer, v : Double) -> NetrouteeigrpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_layer_min(s : NetrouteeigrpLayer) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_layer_max(s : NetrouteeigrpLayer) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_layer_to_string(s : NetrouteeigrpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_buffer_make(size : Int) -> NetrouteeigrpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_buffer_len(s : NetrouteeigrpBuffer) -> Int { s.size }

pub fn net_route_eigrp_buffer_get(s : NetrouteeigrpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_buffer_set(s : NetrouteeigrpBuffer, i : Int, v : Double) -> NetrouteeigrpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_buffer_sum(s : NetrouteeigrpBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_buffer_mean(s : NetrouteeigrpBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_buffer_scale(s : NetrouteeigrpBuffer, f : Double) -> NetrouteeigrpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_buffer_add(a : NetrouteeigrpBuffer, b : NetrouteeigrpBuffer) -> NetrouteeigrpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_buffer_copy(s : NetrouteeigrpBuffer) -> NetrouteeigrpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_buffer_fill(s : NetrouteeigrpBuffer, v : Double) -> NetrouteeigrpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_buffer_min(s : NetrouteeigrpBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_buffer_max(s : NetrouteeigrpBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_buffer_to_string(s : NetrouteeigrpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_cursor_make(size : Int) -> NetrouteeigrpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_cursor_len(s : NetrouteeigrpCursor) -> Int { s.size }

pub fn net_route_eigrp_cursor_get(s : NetrouteeigrpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_cursor_set(s : NetrouteeigrpCursor, i : Int, v : Double) -> NetrouteeigrpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cursor_sum(s : NetrouteeigrpCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_cursor_mean(s : NetrouteeigrpCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_cursor_scale(s : NetrouteeigrpCursor, f : Double) -> NetrouteeigrpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cursor_add(a : NetrouteeigrpCursor, b : NetrouteeigrpCursor) -> NetrouteeigrpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_cursor_copy(s : NetrouteeigrpCursor) -> NetrouteeigrpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cursor_fill(s : NetrouteeigrpCursor, v : Double) -> NetrouteeigrpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_cursor_min(s : NetrouteeigrpCursor) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_cursor_max(s : NetrouteeigrpCursor) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_cursor_to_string(s : NetrouteeigrpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_view_make(size : Int) -> NetrouteeigrpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_view_len(s : NetrouteeigrpView) -> Int { s.size }

pub fn net_route_eigrp_view_get(s : NetrouteeigrpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_view_set(s : NetrouteeigrpView, i : Int, v : Double) -> NetrouteeigrpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_view_sum(s : NetrouteeigrpView) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_view_mean(s : NetrouteeigrpView) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_view_scale(s : NetrouteeigrpView, f : Double) -> NetrouteeigrpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_view_add(a : NetrouteeigrpView, b : NetrouteeigrpView) -> NetrouteeigrpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_view_copy(s : NetrouteeigrpView) -> NetrouteeigrpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_view_fill(s : NetrouteeigrpView, v : Double) -> NetrouteeigrpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_view_min(s : NetrouteeigrpView) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_view_max(s : NetrouteeigrpView) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_view_to_string(s : NetrouteeigrpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_range_make(size : Int) -> NetrouteeigrpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_range_len(s : NetrouteeigrpRange) -> Int { s.size }

pub fn net_route_eigrp_range_get(s : NetrouteeigrpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_range_set(s : NetrouteeigrpRange, i : Int, v : Double) -> NetrouteeigrpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_range_sum(s : NetrouteeigrpRange) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_range_mean(s : NetrouteeigrpRange) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_range_scale(s : NetrouteeigrpRange, f : Double) -> NetrouteeigrpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_range_add(a : NetrouteeigrpRange, b : NetrouteeigrpRange) -> NetrouteeigrpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_range_copy(s : NetrouteeigrpRange) -> NetrouteeigrpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_range_fill(s : NetrouteeigrpRange, v : Double) -> NetrouteeigrpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_range_min(s : NetrouteeigrpRange) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_range_max(s : NetrouteeigrpRange) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_range_to_string(s : NetrouteeigrpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteeigrpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_eigrp_slice_make(size : Int) -> NetrouteeigrpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_eigrp_slice_len(s : NetrouteeigrpSlice) -> Int { s.size }

pub fn net_route_eigrp_slice_get(s : NetrouteeigrpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_eigrp_slice_set(s : NetrouteeigrpSlice, i : Int, v : Double) -> NetrouteeigrpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_slice_sum(s : NetrouteeigrpSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_eigrp_slice_mean(s : NetrouteeigrpSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_eigrp_slice_scale(s : NetrouteeigrpSlice, f : Double) -> NetrouteeigrpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_slice_add(a : NetrouteeigrpSlice, b : NetrouteeigrpSlice) -> NetrouteeigrpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_eigrp_slice_copy(s : NetrouteeigrpSlice) -> NetrouteeigrpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_slice_fill(s : NetrouteeigrpSlice, v : Double) -> NetrouteeigrpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_eigrp_slice_min(s : NetrouteeigrpSlice) -> Double { @_common.min(s.data) }

pub fn net_route_eigrp_slice_max(s : NetrouteeigrpSlice) -> Double { @_common.max(s.data) }

pub fn net_route_eigrp_slice_to_string(s : NetrouteeigrpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

