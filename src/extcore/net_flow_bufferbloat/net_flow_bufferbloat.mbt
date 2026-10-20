///===
/// extcore/net_flow_bufferbloat

pub(all) struct NetflowbufferbloatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_bufferbloat_make_point(x : Double, y : Double) -> NetflowbufferbloatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_bufferbloat_make_point3(x : Double, y : Double, z : Double) -> NetflowbufferbloatPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowbufferbloatPoint::x(self : NetflowbufferbloatPoint) -> Double { self.x }

pub fn NetflowbufferbloatPoint::y(self : NetflowbufferbloatPoint) -> Double { self.y }

pub fn NetflowbufferbloatPoint::z(self : NetflowbufferbloatPoint) -> Double { self.z }

pub fn NetflowbufferbloatPoint::label(self : NetflowbufferbloatPoint) -> Int { self.label }

pub fn NetflowbufferbloatPoint::dist(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowbufferbloatPoint::add(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowbufferbloatPoint::sub(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowbufferbloatPoint::scale(self : NetflowbufferbloatPoint, s : Double) -> NetflowbufferbloatPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowbufferbloatPoint::dot(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowbufferbloatPoint::cross(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowbufferbloatPoint::norm(self : NetflowbufferbloatPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowbufferbloatPoint::normalize(self : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbufferbloatPoint::negate(self : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowbufferbloatPoint::mid(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint) -> NetflowbufferbloatPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowbufferbloatPoint::lerp(self : NetflowbufferbloatPoint, other : NetflowbufferbloatPoint, t : Double) -> NetflowbufferbloatPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowbufferbloatPoint::to_string(self : NetflowbufferbloatPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowbufferbloatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_bufferbloat_make_series(vals : Array[Double], name : String) -> NetflowbufferbloatSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowbufferbloatSeries::len(self : NetflowbufferbloatSeries) -> Int { self.vals.length() }

pub fn NetflowbufferbloatSeries::sum(self : NetflowbufferbloatSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowbufferbloatSeries::mean(self : NetflowbufferbloatSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowbufferbloatSeries::min(self : NetflowbufferbloatSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowbufferbloatSeries::max(self : NetflowbufferbloatSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowbufferbloatSeries::range(self : NetflowbufferbloatSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowbufferbloatSeries::variance(self : NetflowbufferbloatSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowbufferbloatSeries::std(self : NetflowbufferbloatSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowbufferbloatSeries::median(self : NetflowbufferbloatSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowbufferbloatSeries::scale(self : NetflowbufferbloatSeries, f : Double) -> NetflowbufferbloatSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowbufferbloatSeries::add(self : NetflowbufferbloatSeries, other : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowbufferbloatSeries::sub(self : NetflowbufferbloatSeries, other : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowbufferbloatSeries::normalize(self : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowbufferbloatSeries::cumsum(self : NetflowbufferbloatSeries) -> NetflowbufferbloatSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowbufferbloatSeries::to_string(self : NetflowbufferbloatSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbufferbloatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_bufferbloat_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowbufferbloatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_bufferbloat_matrix_identity(n : Int) -> NetflowbufferbloatMatrix {
  let m = net_flow_bufferbloat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowbufferbloatMatrix::get(self : NetflowbufferbloatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowbufferbloatMatrix::transpose(self : NetflowbufferbloatMatrix) -> NetflowbufferbloatMatrix {
  let result = net_flow_bufferbloat_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowbufferbloatMatrix::add(self : NetflowbufferbloatMatrix, other : NetflowbufferbloatMatrix) -> NetflowbufferbloatMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_bufferbloat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowbufferbloatMatrix::scale(self : NetflowbufferbloatMatrix, s : Double) -> NetflowbufferbloatMatrix {
  let result = net_flow_bufferbloat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowbufferbloatMatrix::multiply(self : NetflowbufferbloatMatrix, other : NetflowbufferbloatMatrix) -> NetflowbufferbloatMatrix {
  if self.cols != other.rows { return net_flow_bufferbloat_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_bufferbloat_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowbufferbloatMatrix::trace(self : NetflowbufferbloatMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowbufferbloatMatrix::det(self : NetflowbufferbloatMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowbufferbloatMatrix::norm(self : NetflowbufferbloatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowbufferbloatMatrix::to_string(self : NetflowbufferbloatMatrix) -> String {
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

pub(all) struct NetflowbufferbloatVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_bufferbloat_make_vector(comps : Array[Double]) -> NetflowbufferbloatVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_bufferbloat_vector_zero(dim : Int) -> NetflowbufferbloatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowbufferbloatVector::add(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> NetflowbufferbloatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbufferbloatVector::sub(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> NetflowbufferbloatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbufferbloatVector::scale(self : NetflowbufferbloatVector, s : Double) -> NetflowbufferbloatVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowbufferbloatVector::dot(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowbufferbloatVector::norm(self : NetflowbufferbloatVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowbufferbloatVector::normalize(self : NetflowbufferbloatVector) -> NetflowbufferbloatVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbufferbloatVector::dist(self : NetflowbufferbloatVector, other : NetflowbufferbloatVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowbufferbloatVector::to_string(self : NetflowbufferbloatVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_bufferbloat_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_bufferbloat_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_bufferbloat_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_bufferbloat_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_bufferbloat_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_bufferbloat_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_bufferbloat_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_bufferbloat_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_bufferbloat_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_bufferbloat_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_bufferbloat_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_bufferbloat_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_bufferbloat_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_bufferbloat_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_bufferbloat_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_bufferbloat_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_bufferbloat_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_bufferbloat_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_bufferbloat_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_bufferbloat_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_bufferbloat_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_bufferbloat_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_bufferbloat_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_bufferbloat_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_bufferbloat_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_bufferbloat_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_bufferbloat_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_bufferbloat_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_bufferbloat_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowbufferbloatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_frame_make(size : Int) -> NetflowbufferbloatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_frame_len(s : NetflowbufferbloatFrame) -> Int { s.size }

pub fn net_flow_bufferbloat_frame_get(s : NetflowbufferbloatFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_frame_set(s : NetflowbufferbloatFrame, i : Int, v : Double) -> NetflowbufferbloatFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_frame_sum(s : NetflowbufferbloatFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_frame_mean(s : NetflowbufferbloatFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_frame_scale(s : NetflowbufferbloatFrame, f : Double) -> NetflowbufferbloatFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_frame_add(a : NetflowbufferbloatFrame, b : NetflowbufferbloatFrame) -> NetflowbufferbloatFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_frame_copy(s : NetflowbufferbloatFrame) -> NetflowbufferbloatFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_frame_fill(s : NetflowbufferbloatFrame, v : Double) -> NetflowbufferbloatFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_frame_min(s : NetflowbufferbloatFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_frame_max(s : NetflowbufferbloatFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_frame_to_string(s : NetflowbufferbloatFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_table_make(size : Int) -> NetflowbufferbloatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_table_len(s : NetflowbufferbloatTable) -> Int { s.size }

pub fn net_flow_bufferbloat_table_get(s : NetflowbufferbloatTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_table_set(s : NetflowbufferbloatTable, i : Int, v : Double) -> NetflowbufferbloatTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_table_sum(s : NetflowbufferbloatTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_table_mean(s : NetflowbufferbloatTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_table_scale(s : NetflowbufferbloatTable, f : Double) -> NetflowbufferbloatTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_table_add(a : NetflowbufferbloatTable, b : NetflowbufferbloatTable) -> NetflowbufferbloatTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_table_copy(s : NetflowbufferbloatTable) -> NetflowbufferbloatTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_table_fill(s : NetflowbufferbloatTable, v : Double) -> NetflowbufferbloatTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_table_min(s : NetflowbufferbloatTable) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_table_max(s : NetflowbufferbloatTable) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_table_to_string(s : NetflowbufferbloatTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_graphn_make(size : Int) -> NetflowbufferbloatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_graphn_len(s : NetflowbufferbloatGraphN) -> Int { s.size }

pub fn net_flow_bufferbloat_graphn_get(s : NetflowbufferbloatGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_graphn_set(s : NetflowbufferbloatGraphN, i : Int, v : Double) -> NetflowbufferbloatGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_graphn_sum(s : NetflowbufferbloatGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_graphn_mean(s : NetflowbufferbloatGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_graphn_scale(s : NetflowbufferbloatGraphN, f : Double) -> NetflowbufferbloatGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_graphn_add(a : NetflowbufferbloatGraphN, b : NetflowbufferbloatGraphN) -> NetflowbufferbloatGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_graphn_copy(s : NetflowbufferbloatGraphN) -> NetflowbufferbloatGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_graphn_fill(s : NetflowbufferbloatGraphN, v : Double) -> NetflowbufferbloatGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_graphn_min(s : NetflowbufferbloatGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_graphn_max(s : NetflowbufferbloatGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_graphn_to_string(s : NetflowbufferbloatGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_node_make(size : Int) -> NetflowbufferbloatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_node_len(s : NetflowbufferbloatNode) -> Int { s.size }

pub fn net_flow_bufferbloat_node_get(s : NetflowbufferbloatNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_node_set(s : NetflowbufferbloatNode, i : Int, v : Double) -> NetflowbufferbloatNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_node_sum(s : NetflowbufferbloatNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_node_mean(s : NetflowbufferbloatNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_node_scale(s : NetflowbufferbloatNode, f : Double) -> NetflowbufferbloatNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_node_add(a : NetflowbufferbloatNode, b : NetflowbufferbloatNode) -> NetflowbufferbloatNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_node_copy(s : NetflowbufferbloatNode) -> NetflowbufferbloatNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_node_fill(s : NetflowbufferbloatNode, v : Double) -> NetflowbufferbloatNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_node_min(s : NetflowbufferbloatNode) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_node_max(s : NetflowbufferbloatNode) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_node_to_string(s : NetflowbufferbloatNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_edge_make(size : Int) -> NetflowbufferbloatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_edge_len(s : NetflowbufferbloatEdge) -> Int { s.size }

pub fn net_flow_bufferbloat_edge_get(s : NetflowbufferbloatEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_edge_set(s : NetflowbufferbloatEdge, i : Int, v : Double) -> NetflowbufferbloatEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_edge_sum(s : NetflowbufferbloatEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_edge_mean(s : NetflowbufferbloatEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_edge_scale(s : NetflowbufferbloatEdge, f : Double) -> NetflowbufferbloatEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_edge_add(a : NetflowbufferbloatEdge, b : NetflowbufferbloatEdge) -> NetflowbufferbloatEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_edge_copy(s : NetflowbufferbloatEdge) -> NetflowbufferbloatEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_edge_fill(s : NetflowbufferbloatEdge, v : Double) -> NetflowbufferbloatEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_edge_min(s : NetflowbufferbloatEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_edge_max(s : NetflowbufferbloatEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_edge_to_string(s : NetflowbufferbloatEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_path_make(size : Int) -> NetflowbufferbloatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_path_len(s : NetflowbufferbloatPath) -> Int { s.size }

pub fn net_flow_bufferbloat_path_get(s : NetflowbufferbloatPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_path_set(s : NetflowbufferbloatPath, i : Int, v : Double) -> NetflowbufferbloatPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_path_sum(s : NetflowbufferbloatPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_path_mean(s : NetflowbufferbloatPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_path_scale(s : NetflowbufferbloatPath, f : Double) -> NetflowbufferbloatPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_path_add(a : NetflowbufferbloatPath, b : NetflowbufferbloatPath) -> NetflowbufferbloatPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_path_copy(s : NetflowbufferbloatPath) -> NetflowbufferbloatPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_path_fill(s : NetflowbufferbloatPath, v : Double) -> NetflowbufferbloatPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_path_min(s : NetflowbufferbloatPath) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_path_max(s : NetflowbufferbloatPath) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_path_to_string(s : NetflowbufferbloatPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_cluster_make(size : Int) -> NetflowbufferbloatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_cluster_len(s : NetflowbufferbloatCluster) -> Int { s.size }

pub fn net_flow_bufferbloat_cluster_get(s : NetflowbufferbloatCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_cluster_set(s : NetflowbufferbloatCluster, i : Int, v : Double) -> NetflowbufferbloatCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cluster_sum(s : NetflowbufferbloatCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_cluster_mean(s : NetflowbufferbloatCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_cluster_scale(s : NetflowbufferbloatCluster, f : Double) -> NetflowbufferbloatCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cluster_add(a : NetflowbufferbloatCluster, b : NetflowbufferbloatCluster) -> NetflowbufferbloatCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_cluster_copy(s : NetflowbufferbloatCluster) -> NetflowbufferbloatCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cluster_fill(s : NetflowbufferbloatCluster, v : Double) -> NetflowbufferbloatCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cluster_min(s : NetflowbufferbloatCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_cluster_max(s : NetflowbufferbloatCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_cluster_to_string(s : NetflowbufferbloatCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_model_make(size : Int) -> NetflowbufferbloatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_model_len(s : NetflowbufferbloatModel) -> Int { s.size }

pub fn net_flow_bufferbloat_model_get(s : NetflowbufferbloatModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_model_set(s : NetflowbufferbloatModel, i : Int, v : Double) -> NetflowbufferbloatModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_model_sum(s : NetflowbufferbloatModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_model_mean(s : NetflowbufferbloatModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_model_scale(s : NetflowbufferbloatModel, f : Double) -> NetflowbufferbloatModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_model_add(a : NetflowbufferbloatModel, b : NetflowbufferbloatModel) -> NetflowbufferbloatModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_model_copy(s : NetflowbufferbloatModel) -> NetflowbufferbloatModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_model_fill(s : NetflowbufferbloatModel, v : Double) -> NetflowbufferbloatModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_model_min(s : NetflowbufferbloatModel) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_model_max(s : NetflowbufferbloatModel) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_model_to_string(s : NetflowbufferbloatModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_layer_make(size : Int) -> NetflowbufferbloatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_layer_len(s : NetflowbufferbloatLayer) -> Int { s.size }

pub fn net_flow_bufferbloat_layer_get(s : NetflowbufferbloatLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_layer_set(s : NetflowbufferbloatLayer, i : Int, v : Double) -> NetflowbufferbloatLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_layer_sum(s : NetflowbufferbloatLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_layer_mean(s : NetflowbufferbloatLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_layer_scale(s : NetflowbufferbloatLayer, f : Double) -> NetflowbufferbloatLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_layer_add(a : NetflowbufferbloatLayer, b : NetflowbufferbloatLayer) -> NetflowbufferbloatLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_layer_copy(s : NetflowbufferbloatLayer) -> NetflowbufferbloatLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_layer_fill(s : NetflowbufferbloatLayer, v : Double) -> NetflowbufferbloatLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_layer_min(s : NetflowbufferbloatLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_layer_max(s : NetflowbufferbloatLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_layer_to_string(s : NetflowbufferbloatLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_buffer_make(size : Int) -> NetflowbufferbloatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_buffer_len(s : NetflowbufferbloatBuffer) -> Int { s.size }

pub fn net_flow_bufferbloat_buffer_get(s : NetflowbufferbloatBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_buffer_set(s : NetflowbufferbloatBuffer, i : Int, v : Double) -> NetflowbufferbloatBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_buffer_sum(s : NetflowbufferbloatBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_buffer_mean(s : NetflowbufferbloatBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_buffer_scale(s : NetflowbufferbloatBuffer, f : Double) -> NetflowbufferbloatBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_buffer_add(a : NetflowbufferbloatBuffer, b : NetflowbufferbloatBuffer) -> NetflowbufferbloatBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_buffer_copy(s : NetflowbufferbloatBuffer) -> NetflowbufferbloatBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_buffer_fill(s : NetflowbufferbloatBuffer, v : Double) -> NetflowbufferbloatBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_buffer_min(s : NetflowbufferbloatBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_buffer_max(s : NetflowbufferbloatBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_buffer_to_string(s : NetflowbufferbloatBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_cursor_make(size : Int) -> NetflowbufferbloatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_cursor_len(s : NetflowbufferbloatCursor) -> Int { s.size }

pub fn net_flow_bufferbloat_cursor_get(s : NetflowbufferbloatCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_cursor_set(s : NetflowbufferbloatCursor, i : Int, v : Double) -> NetflowbufferbloatCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cursor_sum(s : NetflowbufferbloatCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_cursor_mean(s : NetflowbufferbloatCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_cursor_scale(s : NetflowbufferbloatCursor, f : Double) -> NetflowbufferbloatCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cursor_add(a : NetflowbufferbloatCursor, b : NetflowbufferbloatCursor) -> NetflowbufferbloatCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_cursor_copy(s : NetflowbufferbloatCursor) -> NetflowbufferbloatCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cursor_fill(s : NetflowbufferbloatCursor, v : Double) -> NetflowbufferbloatCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_cursor_min(s : NetflowbufferbloatCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_cursor_max(s : NetflowbufferbloatCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_cursor_to_string(s : NetflowbufferbloatCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_view_make(size : Int) -> NetflowbufferbloatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_view_len(s : NetflowbufferbloatView) -> Int { s.size }

pub fn net_flow_bufferbloat_view_get(s : NetflowbufferbloatView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_view_set(s : NetflowbufferbloatView, i : Int, v : Double) -> NetflowbufferbloatView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_view_sum(s : NetflowbufferbloatView) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_view_mean(s : NetflowbufferbloatView) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_view_scale(s : NetflowbufferbloatView, f : Double) -> NetflowbufferbloatView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_view_add(a : NetflowbufferbloatView, b : NetflowbufferbloatView) -> NetflowbufferbloatView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_view_copy(s : NetflowbufferbloatView) -> NetflowbufferbloatView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_view_fill(s : NetflowbufferbloatView, v : Double) -> NetflowbufferbloatView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_view_min(s : NetflowbufferbloatView) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_view_max(s : NetflowbufferbloatView) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_view_to_string(s : NetflowbufferbloatView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_range_make(size : Int) -> NetflowbufferbloatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_range_len(s : NetflowbufferbloatRange) -> Int { s.size }

pub fn net_flow_bufferbloat_range_get(s : NetflowbufferbloatRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_range_set(s : NetflowbufferbloatRange, i : Int, v : Double) -> NetflowbufferbloatRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_range_sum(s : NetflowbufferbloatRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_range_mean(s : NetflowbufferbloatRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_range_scale(s : NetflowbufferbloatRange, f : Double) -> NetflowbufferbloatRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_range_add(a : NetflowbufferbloatRange, b : NetflowbufferbloatRange) -> NetflowbufferbloatRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_range_copy(s : NetflowbufferbloatRange) -> NetflowbufferbloatRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_range_fill(s : NetflowbufferbloatRange, v : Double) -> NetflowbufferbloatRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_range_min(s : NetflowbufferbloatRange) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_range_max(s : NetflowbufferbloatRange) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_range_to_string(s : NetflowbufferbloatRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbufferbloatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_bufferbloat_slice_make(size : Int) -> NetflowbufferbloatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_bufferbloat_slice_len(s : NetflowbufferbloatSlice) -> Int { s.size }

pub fn net_flow_bufferbloat_slice_get(s : NetflowbufferbloatSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_bufferbloat_slice_set(s : NetflowbufferbloatSlice, i : Int, v : Double) -> NetflowbufferbloatSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_slice_sum(s : NetflowbufferbloatSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_bufferbloat_slice_mean(s : NetflowbufferbloatSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_bufferbloat_slice_scale(s : NetflowbufferbloatSlice, f : Double) -> NetflowbufferbloatSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_slice_add(a : NetflowbufferbloatSlice, b : NetflowbufferbloatSlice) -> NetflowbufferbloatSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_bufferbloat_slice_copy(s : NetflowbufferbloatSlice) -> NetflowbufferbloatSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_slice_fill(s : NetflowbufferbloatSlice, v : Double) -> NetflowbufferbloatSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_bufferbloat_slice_min(s : NetflowbufferbloatSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_bufferbloat_slice_max(s : NetflowbufferbloatSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_bufferbloat_slice_to_string(s : NetflowbufferbloatSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

