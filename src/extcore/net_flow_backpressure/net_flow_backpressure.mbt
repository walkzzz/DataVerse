///===
/// extcore/net_flow_backpressure

pub(all) struct NetflowbackpressurePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_backpressure_make_point(x : Double, y : Double) -> NetflowbackpressurePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_backpressure_make_point3(x : Double, y : Double, z : Double) -> NetflowbackpressurePoint {
  { x, y, z, label: 0 }
}

pub fn NetflowbackpressurePoint::x(self : NetflowbackpressurePoint) -> Double { self.x }

pub fn NetflowbackpressurePoint::y(self : NetflowbackpressurePoint) -> Double { self.y }

pub fn NetflowbackpressurePoint::z(self : NetflowbackpressurePoint) -> Double { self.z }

pub fn NetflowbackpressurePoint::label(self : NetflowbackpressurePoint) -> Int { self.label }

pub fn NetflowbackpressurePoint::dist(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowbackpressurePoint::add(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowbackpressurePoint::sub(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowbackpressurePoint::scale(self : NetflowbackpressurePoint, s : Double) -> NetflowbackpressurePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowbackpressurePoint::dot(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowbackpressurePoint::cross(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowbackpressurePoint::norm(self : NetflowbackpressurePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowbackpressurePoint::normalize(self : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbackpressurePoint::negate(self : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowbackpressurePoint::mid(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint) -> NetflowbackpressurePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowbackpressurePoint::lerp(self : NetflowbackpressurePoint, other : NetflowbackpressurePoint, t : Double) -> NetflowbackpressurePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowbackpressurePoint::to_string(self : NetflowbackpressurePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowbackpressureSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_backpressure_make_series(vals : Array[Double], name : String) -> NetflowbackpressureSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowbackpressureSeries::len(self : NetflowbackpressureSeries) -> Int { self.vals.length() }

pub fn NetflowbackpressureSeries::sum(self : NetflowbackpressureSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowbackpressureSeries::mean(self : NetflowbackpressureSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowbackpressureSeries::min(self : NetflowbackpressureSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowbackpressureSeries::max(self : NetflowbackpressureSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowbackpressureSeries::range(self : NetflowbackpressureSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowbackpressureSeries::variance(self : NetflowbackpressureSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowbackpressureSeries::std(self : NetflowbackpressureSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowbackpressureSeries::median(self : NetflowbackpressureSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowbackpressureSeries::scale(self : NetflowbackpressureSeries, f : Double) -> NetflowbackpressureSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowbackpressureSeries::add(self : NetflowbackpressureSeries, other : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowbackpressureSeries::sub(self : NetflowbackpressureSeries, other : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowbackpressureSeries::normalize(self : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowbackpressureSeries::cumsum(self : NetflowbackpressureSeries) -> NetflowbackpressureSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowbackpressureSeries::to_string(self : NetflowbackpressureSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowbackpressureMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_backpressure_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowbackpressureMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_backpressure_matrix_identity(n : Int) -> NetflowbackpressureMatrix {
  let m = net_flow_backpressure_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowbackpressureMatrix::get(self : NetflowbackpressureMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowbackpressureMatrix::transpose(self : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  let result = net_flow_backpressure_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowbackpressureMatrix::add(self : NetflowbackpressureMatrix, other : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_backpressure_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowbackpressureMatrix::scale(self : NetflowbackpressureMatrix, s : Double) -> NetflowbackpressureMatrix {
  let result = net_flow_backpressure_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowbackpressureMatrix::multiply(self : NetflowbackpressureMatrix, other : NetflowbackpressureMatrix) -> NetflowbackpressureMatrix {
  if self.cols != other.rows { return net_flow_backpressure_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_backpressure_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowbackpressureMatrix::trace(self : NetflowbackpressureMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowbackpressureMatrix::det(self : NetflowbackpressureMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowbackpressureMatrix::norm(self : NetflowbackpressureMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowbackpressureMatrix::to_string(self : NetflowbackpressureMatrix) -> String {
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

pub(all) struct NetflowbackpressureVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_backpressure_make_vector(comps : Array[Double]) -> NetflowbackpressureVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_backpressure_vector_zero(dim : Int) -> NetflowbackpressureVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowbackpressureVector::add(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbackpressureVector::sub(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowbackpressureVector::scale(self : NetflowbackpressureVector, s : Double) -> NetflowbackpressureVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowbackpressureVector::dot(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowbackpressureVector::norm(self : NetflowbackpressureVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowbackpressureVector::normalize(self : NetflowbackpressureVector) -> NetflowbackpressureVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowbackpressureVector::dist(self : NetflowbackpressureVector, other : NetflowbackpressureVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowbackpressureVector::to_string(self : NetflowbackpressureVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_backpressure_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_backpressure_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_backpressure_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_backpressure_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_backpressure_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_backpressure_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_backpressure_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_backpressure_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_backpressure_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_backpressure_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_backpressure_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_backpressure_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_backpressure_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_backpressure_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_backpressure_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_backpressure_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_backpressure_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_backpressure_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_backpressure_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_backpressure_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_backpressure_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_backpressure_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_backpressure_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_backpressure_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_backpressure_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_backpressure_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_backpressure_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_backpressure_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_backpressure_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowbackpressureFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_frame_make(size : Int) -> NetflowbackpressureFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_frame_len(s : NetflowbackpressureFrame) -> Int { s.size }

pub fn net_flow_backpressure_frame_get(s : NetflowbackpressureFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_frame_set(s : NetflowbackpressureFrame, i : Int, v : Double) -> NetflowbackpressureFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_frame_sum(s : NetflowbackpressureFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_frame_mean(s : NetflowbackpressureFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_frame_scale(s : NetflowbackpressureFrame, f : Double) -> NetflowbackpressureFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_frame_add(a : NetflowbackpressureFrame, b : NetflowbackpressureFrame) -> NetflowbackpressureFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_frame_copy(s : NetflowbackpressureFrame) -> NetflowbackpressureFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_frame_fill(s : NetflowbackpressureFrame, v : Double) -> NetflowbackpressureFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_frame_min(s : NetflowbackpressureFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_frame_max(s : NetflowbackpressureFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_frame_to_string(s : NetflowbackpressureFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_table_make(size : Int) -> NetflowbackpressureTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_table_len(s : NetflowbackpressureTable) -> Int { s.size }

pub fn net_flow_backpressure_table_get(s : NetflowbackpressureTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_table_set(s : NetflowbackpressureTable, i : Int, v : Double) -> NetflowbackpressureTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_table_sum(s : NetflowbackpressureTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_table_mean(s : NetflowbackpressureTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_table_scale(s : NetflowbackpressureTable, f : Double) -> NetflowbackpressureTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_table_add(a : NetflowbackpressureTable, b : NetflowbackpressureTable) -> NetflowbackpressureTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_table_copy(s : NetflowbackpressureTable) -> NetflowbackpressureTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_table_fill(s : NetflowbackpressureTable, v : Double) -> NetflowbackpressureTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_table_min(s : NetflowbackpressureTable) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_table_max(s : NetflowbackpressureTable) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_table_to_string(s : NetflowbackpressureTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_graphn_make(size : Int) -> NetflowbackpressureGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_graphn_len(s : NetflowbackpressureGraphN) -> Int { s.size }

pub fn net_flow_backpressure_graphn_get(s : NetflowbackpressureGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_graphn_set(s : NetflowbackpressureGraphN, i : Int, v : Double) -> NetflowbackpressureGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_graphn_sum(s : NetflowbackpressureGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_graphn_mean(s : NetflowbackpressureGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_graphn_scale(s : NetflowbackpressureGraphN, f : Double) -> NetflowbackpressureGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_graphn_add(a : NetflowbackpressureGraphN, b : NetflowbackpressureGraphN) -> NetflowbackpressureGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_graphn_copy(s : NetflowbackpressureGraphN) -> NetflowbackpressureGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_graphn_fill(s : NetflowbackpressureGraphN, v : Double) -> NetflowbackpressureGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_graphn_min(s : NetflowbackpressureGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_graphn_max(s : NetflowbackpressureGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_graphn_to_string(s : NetflowbackpressureGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_node_make(size : Int) -> NetflowbackpressureNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_node_len(s : NetflowbackpressureNode) -> Int { s.size }

pub fn net_flow_backpressure_node_get(s : NetflowbackpressureNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_node_set(s : NetflowbackpressureNode, i : Int, v : Double) -> NetflowbackpressureNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_node_sum(s : NetflowbackpressureNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_node_mean(s : NetflowbackpressureNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_node_scale(s : NetflowbackpressureNode, f : Double) -> NetflowbackpressureNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_node_add(a : NetflowbackpressureNode, b : NetflowbackpressureNode) -> NetflowbackpressureNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_node_copy(s : NetflowbackpressureNode) -> NetflowbackpressureNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_node_fill(s : NetflowbackpressureNode, v : Double) -> NetflowbackpressureNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_node_min(s : NetflowbackpressureNode) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_node_max(s : NetflowbackpressureNode) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_node_to_string(s : NetflowbackpressureNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_edge_make(size : Int) -> NetflowbackpressureEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_edge_len(s : NetflowbackpressureEdge) -> Int { s.size }

pub fn net_flow_backpressure_edge_get(s : NetflowbackpressureEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_edge_set(s : NetflowbackpressureEdge, i : Int, v : Double) -> NetflowbackpressureEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_edge_sum(s : NetflowbackpressureEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_edge_mean(s : NetflowbackpressureEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_edge_scale(s : NetflowbackpressureEdge, f : Double) -> NetflowbackpressureEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_edge_add(a : NetflowbackpressureEdge, b : NetflowbackpressureEdge) -> NetflowbackpressureEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_edge_copy(s : NetflowbackpressureEdge) -> NetflowbackpressureEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_edge_fill(s : NetflowbackpressureEdge, v : Double) -> NetflowbackpressureEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_edge_min(s : NetflowbackpressureEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_edge_max(s : NetflowbackpressureEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_edge_to_string(s : NetflowbackpressureEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressurePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_path_make(size : Int) -> NetflowbackpressurePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_path_len(s : NetflowbackpressurePath) -> Int { s.size }

pub fn net_flow_backpressure_path_get(s : NetflowbackpressurePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_path_set(s : NetflowbackpressurePath, i : Int, v : Double) -> NetflowbackpressurePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_path_sum(s : NetflowbackpressurePath) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_path_mean(s : NetflowbackpressurePath) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_path_scale(s : NetflowbackpressurePath, f : Double) -> NetflowbackpressurePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_path_add(a : NetflowbackpressurePath, b : NetflowbackpressurePath) -> NetflowbackpressurePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_path_copy(s : NetflowbackpressurePath) -> NetflowbackpressurePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_path_fill(s : NetflowbackpressurePath, v : Double) -> NetflowbackpressurePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_path_min(s : NetflowbackpressurePath) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_path_max(s : NetflowbackpressurePath) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_path_to_string(s : NetflowbackpressurePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_cluster_make(size : Int) -> NetflowbackpressureCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_cluster_len(s : NetflowbackpressureCluster) -> Int { s.size }

pub fn net_flow_backpressure_cluster_get(s : NetflowbackpressureCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_cluster_set(s : NetflowbackpressureCluster, i : Int, v : Double) -> NetflowbackpressureCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cluster_sum(s : NetflowbackpressureCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_cluster_mean(s : NetflowbackpressureCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_cluster_scale(s : NetflowbackpressureCluster, f : Double) -> NetflowbackpressureCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cluster_add(a : NetflowbackpressureCluster, b : NetflowbackpressureCluster) -> NetflowbackpressureCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_cluster_copy(s : NetflowbackpressureCluster) -> NetflowbackpressureCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cluster_fill(s : NetflowbackpressureCluster, v : Double) -> NetflowbackpressureCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cluster_min(s : NetflowbackpressureCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_cluster_max(s : NetflowbackpressureCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_cluster_to_string(s : NetflowbackpressureCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_model_make(size : Int) -> NetflowbackpressureModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_model_len(s : NetflowbackpressureModel) -> Int { s.size }

pub fn net_flow_backpressure_model_get(s : NetflowbackpressureModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_model_set(s : NetflowbackpressureModel, i : Int, v : Double) -> NetflowbackpressureModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_model_sum(s : NetflowbackpressureModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_model_mean(s : NetflowbackpressureModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_model_scale(s : NetflowbackpressureModel, f : Double) -> NetflowbackpressureModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_model_add(a : NetflowbackpressureModel, b : NetflowbackpressureModel) -> NetflowbackpressureModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_model_copy(s : NetflowbackpressureModel) -> NetflowbackpressureModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_model_fill(s : NetflowbackpressureModel, v : Double) -> NetflowbackpressureModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_model_min(s : NetflowbackpressureModel) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_model_max(s : NetflowbackpressureModel) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_model_to_string(s : NetflowbackpressureModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_layer_make(size : Int) -> NetflowbackpressureLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_layer_len(s : NetflowbackpressureLayer) -> Int { s.size }

pub fn net_flow_backpressure_layer_get(s : NetflowbackpressureLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_layer_set(s : NetflowbackpressureLayer, i : Int, v : Double) -> NetflowbackpressureLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_layer_sum(s : NetflowbackpressureLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_layer_mean(s : NetflowbackpressureLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_layer_scale(s : NetflowbackpressureLayer, f : Double) -> NetflowbackpressureLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_layer_add(a : NetflowbackpressureLayer, b : NetflowbackpressureLayer) -> NetflowbackpressureLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_layer_copy(s : NetflowbackpressureLayer) -> NetflowbackpressureLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_layer_fill(s : NetflowbackpressureLayer, v : Double) -> NetflowbackpressureLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_layer_min(s : NetflowbackpressureLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_layer_max(s : NetflowbackpressureLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_layer_to_string(s : NetflowbackpressureLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_buffer_make(size : Int) -> NetflowbackpressureBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_buffer_len(s : NetflowbackpressureBuffer) -> Int { s.size }

pub fn net_flow_backpressure_buffer_get(s : NetflowbackpressureBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_buffer_set(s : NetflowbackpressureBuffer, i : Int, v : Double) -> NetflowbackpressureBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_buffer_sum(s : NetflowbackpressureBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_buffer_mean(s : NetflowbackpressureBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_buffer_scale(s : NetflowbackpressureBuffer, f : Double) -> NetflowbackpressureBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_buffer_add(a : NetflowbackpressureBuffer, b : NetflowbackpressureBuffer) -> NetflowbackpressureBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_buffer_copy(s : NetflowbackpressureBuffer) -> NetflowbackpressureBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_buffer_fill(s : NetflowbackpressureBuffer, v : Double) -> NetflowbackpressureBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_buffer_min(s : NetflowbackpressureBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_buffer_max(s : NetflowbackpressureBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_buffer_to_string(s : NetflowbackpressureBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_cursor_make(size : Int) -> NetflowbackpressureCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_cursor_len(s : NetflowbackpressureCursor) -> Int { s.size }

pub fn net_flow_backpressure_cursor_get(s : NetflowbackpressureCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_cursor_set(s : NetflowbackpressureCursor, i : Int, v : Double) -> NetflowbackpressureCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cursor_sum(s : NetflowbackpressureCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_cursor_mean(s : NetflowbackpressureCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_cursor_scale(s : NetflowbackpressureCursor, f : Double) -> NetflowbackpressureCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cursor_add(a : NetflowbackpressureCursor, b : NetflowbackpressureCursor) -> NetflowbackpressureCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_cursor_copy(s : NetflowbackpressureCursor) -> NetflowbackpressureCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cursor_fill(s : NetflowbackpressureCursor, v : Double) -> NetflowbackpressureCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_cursor_min(s : NetflowbackpressureCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_cursor_max(s : NetflowbackpressureCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_cursor_to_string(s : NetflowbackpressureCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_view_make(size : Int) -> NetflowbackpressureView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_view_len(s : NetflowbackpressureView) -> Int { s.size }

pub fn net_flow_backpressure_view_get(s : NetflowbackpressureView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_view_set(s : NetflowbackpressureView, i : Int, v : Double) -> NetflowbackpressureView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_view_sum(s : NetflowbackpressureView) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_view_mean(s : NetflowbackpressureView) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_view_scale(s : NetflowbackpressureView, f : Double) -> NetflowbackpressureView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_view_add(a : NetflowbackpressureView, b : NetflowbackpressureView) -> NetflowbackpressureView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_view_copy(s : NetflowbackpressureView) -> NetflowbackpressureView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_view_fill(s : NetflowbackpressureView, v : Double) -> NetflowbackpressureView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_view_min(s : NetflowbackpressureView) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_view_max(s : NetflowbackpressureView) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_view_to_string(s : NetflowbackpressureView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_range_make(size : Int) -> NetflowbackpressureRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_range_len(s : NetflowbackpressureRange) -> Int { s.size }

pub fn net_flow_backpressure_range_get(s : NetflowbackpressureRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_range_set(s : NetflowbackpressureRange, i : Int, v : Double) -> NetflowbackpressureRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_range_sum(s : NetflowbackpressureRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_range_mean(s : NetflowbackpressureRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_range_scale(s : NetflowbackpressureRange, f : Double) -> NetflowbackpressureRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_range_add(a : NetflowbackpressureRange, b : NetflowbackpressureRange) -> NetflowbackpressureRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_range_copy(s : NetflowbackpressureRange) -> NetflowbackpressureRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_range_fill(s : NetflowbackpressureRange, v : Double) -> NetflowbackpressureRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_range_min(s : NetflowbackpressureRange) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_range_max(s : NetflowbackpressureRange) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_range_to_string(s : NetflowbackpressureRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowbackpressureSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_backpressure_slice_make(size : Int) -> NetflowbackpressureSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_backpressure_slice_len(s : NetflowbackpressureSlice) -> Int { s.size }

pub fn net_flow_backpressure_slice_get(s : NetflowbackpressureSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_backpressure_slice_set(s : NetflowbackpressureSlice, i : Int, v : Double) -> NetflowbackpressureSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_slice_sum(s : NetflowbackpressureSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_backpressure_slice_mean(s : NetflowbackpressureSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_backpressure_slice_scale(s : NetflowbackpressureSlice, f : Double) -> NetflowbackpressureSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_slice_add(a : NetflowbackpressureSlice, b : NetflowbackpressureSlice) -> NetflowbackpressureSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_backpressure_slice_copy(s : NetflowbackpressureSlice) -> NetflowbackpressureSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_slice_fill(s : NetflowbackpressureSlice, v : Double) -> NetflowbackpressureSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_backpressure_slice_min(s : NetflowbackpressureSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_backpressure_slice_max(s : NetflowbackpressureSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_backpressure_slice_to_string(s : NetflowbackpressureSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

