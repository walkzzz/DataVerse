///===
/// extcore/net_route_multipath

pub(all) struct NetroutemultipathPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_multipath_make_point(x : Double, y : Double) -> NetroutemultipathPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_multipath_make_point3(x : Double, y : Double, z : Double) -> NetroutemultipathPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutemultipathPoint::x(self : NetroutemultipathPoint) -> Double { self.x }

pub fn NetroutemultipathPoint::y(self : NetroutemultipathPoint) -> Double { self.y }

pub fn NetroutemultipathPoint::z(self : NetroutemultipathPoint) -> Double { self.z }

pub fn NetroutemultipathPoint::label(self : NetroutemultipathPoint) -> Int { self.label }

pub fn NetroutemultipathPoint::dist(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutemultipathPoint::add(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutemultipathPoint::sub(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutemultipathPoint::scale(self : NetroutemultipathPoint, s : Double) -> NetroutemultipathPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutemultipathPoint::dot(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutemultipathPoint::cross(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutemultipathPoint::norm(self : NetroutemultipathPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutemultipathPoint::normalize(self : NetroutemultipathPoint) -> NetroutemultipathPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutemultipathPoint::negate(self : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutemultipathPoint::mid(self : NetroutemultipathPoint, other : NetroutemultipathPoint) -> NetroutemultipathPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutemultipathPoint::lerp(self : NetroutemultipathPoint, other : NetroutemultipathPoint, t : Double) -> NetroutemultipathPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutemultipathPoint::to_string(self : NetroutemultipathPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutemultipathSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_multipath_make_series(vals : Array[Double], name : String) -> NetroutemultipathSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutemultipathSeries::len(self : NetroutemultipathSeries) -> Int { self.vals.length() }

pub fn NetroutemultipathSeries::sum(self : NetroutemultipathSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutemultipathSeries::mean(self : NetroutemultipathSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutemultipathSeries::min(self : NetroutemultipathSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutemultipathSeries::max(self : NetroutemultipathSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutemultipathSeries::range(self : NetroutemultipathSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutemultipathSeries::variance(self : NetroutemultipathSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutemultipathSeries::std(self : NetroutemultipathSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutemultipathSeries::median(self : NetroutemultipathSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutemultipathSeries::scale(self : NetroutemultipathSeries, f : Double) -> NetroutemultipathSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutemultipathSeries::add(self : NetroutemultipathSeries, other : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutemultipathSeries::sub(self : NetroutemultipathSeries, other : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutemultipathSeries::normalize(self : NetroutemultipathSeries) -> NetroutemultipathSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutemultipathSeries::cumsum(self : NetroutemultipathSeries) -> NetroutemultipathSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutemultipathSeries::to_string(self : NetroutemultipathSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutemultipathMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_multipath_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutemultipathMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_multipath_matrix_identity(n : Int) -> NetroutemultipathMatrix {
  let m = net_route_multipath_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutemultipathMatrix::get(self : NetroutemultipathMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutemultipathMatrix::transpose(self : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  let result = net_route_multipath_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutemultipathMatrix::add(self : NetroutemultipathMatrix, other : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_multipath_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutemultipathMatrix::scale(self : NetroutemultipathMatrix, s : Double) -> NetroutemultipathMatrix {
  let result = net_route_multipath_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutemultipathMatrix::multiply(self : NetroutemultipathMatrix, other : NetroutemultipathMatrix) -> NetroutemultipathMatrix {
  if self.cols != other.rows { return net_route_multipath_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_multipath_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutemultipathMatrix::trace(self : NetroutemultipathMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutemultipathMatrix::det(self : NetroutemultipathMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutemultipathMatrix::norm(self : NetroutemultipathMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutemultipathMatrix::to_string(self : NetroutemultipathMatrix) -> String {
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

pub(all) struct NetroutemultipathVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_multipath_make_vector(comps : Array[Double]) -> NetroutemultipathVector {
  { comps, dim: comps.length() }
}

pub fn net_route_multipath_vector_zero(dim : Int) -> NetroutemultipathVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutemultipathVector::add(self : NetroutemultipathVector, other : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutemultipathVector::sub(self : NetroutemultipathVector, other : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutemultipathVector::scale(self : NetroutemultipathVector, s : Double) -> NetroutemultipathVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutemultipathVector::dot(self : NetroutemultipathVector, other : NetroutemultipathVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutemultipathVector::norm(self : NetroutemultipathVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutemultipathVector::normalize(self : NetroutemultipathVector) -> NetroutemultipathVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutemultipathVector::dist(self : NetroutemultipathVector, other : NetroutemultipathVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutemultipathVector::to_string(self : NetroutemultipathVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_multipath_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_multipath_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_multipath_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_multipath_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_multipath_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_multipath_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_multipath_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_multipath_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_multipath_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_multipath_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_multipath_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_multipath_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_multipath_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_multipath_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_multipath_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_multipath_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_multipath_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_multipath_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_multipath_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_multipath_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_multipath_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_multipath_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_multipath_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_multipath_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_multipath_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_multipath_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_multipath_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_multipath_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_multipath_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutemultipathFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_frame_make(size : Int) -> NetroutemultipathFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_frame_len(s : NetroutemultipathFrame) -> Int { s.size }

pub fn net_route_multipath_frame_get(s : NetroutemultipathFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_frame_set(s : NetroutemultipathFrame, i : Int, v : Double) -> NetroutemultipathFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_frame_sum(s : NetroutemultipathFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_frame_mean(s : NetroutemultipathFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_frame_scale(s : NetroutemultipathFrame, f : Double) -> NetroutemultipathFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_frame_add(a : NetroutemultipathFrame, b : NetroutemultipathFrame) -> NetroutemultipathFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_frame_copy(s : NetroutemultipathFrame) -> NetroutemultipathFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_frame_fill(s : NetroutemultipathFrame, v : Double) -> NetroutemultipathFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_frame_min(s : NetroutemultipathFrame) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_frame_max(s : NetroutemultipathFrame) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_frame_to_string(s : NetroutemultipathFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_table_make(size : Int) -> NetroutemultipathTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_table_len(s : NetroutemultipathTable) -> Int { s.size }

pub fn net_route_multipath_table_get(s : NetroutemultipathTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_table_set(s : NetroutemultipathTable, i : Int, v : Double) -> NetroutemultipathTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_table_sum(s : NetroutemultipathTable) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_table_mean(s : NetroutemultipathTable) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_table_scale(s : NetroutemultipathTable, f : Double) -> NetroutemultipathTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_table_add(a : NetroutemultipathTable, b : NetroutemultipathTable) -> NetroutemultipathTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_table_copy(s : NetroutemultipathTable) -> NetroutemultipathTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_table_fill(s : NetroutemultipathTable, v : Double) -> NetroutemultipathTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_table_min(s : NetroutemultipathTable) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_table_max(s : NetroutemultipathTable) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_table_to_string(s : NetroutemultipathTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_graphn_make(size : Int) -> NetroutemultipathGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_graphn_len(s : NetroutemultipathGraphN) -> Int { s.size }

pub fn net_route_multipath_graphn_get(s : NetroutemultipathGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_graphn_set(s : NetroutemultipathGraphN, i : Int, v : Double) -> NetroutemultipathGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_graphn_sum(s : NetroutemultipathGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_graphn_mean(s : NetroutemultipathGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_graphn_scale(s : NetroutemultipathGraphN, f : Double) -> NetroutemultipathGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_graphn_add(a : NetroutemultipathGraphN, b : NetroutemultipathGraphN) -> NetroutemultipathGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_graphn_copy(s : NetroutemultipathGraphN) -> NetroutemultipathGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_graphn_fill(s : NetroutemultipathGraphN, v : Double) -> NetroutemultipathGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_graphn_min(s : NetroutemultipathGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_graphn_max(s : NetroutemultipathGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_graphn_to_string(s : NetroutemultipathGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_node_make(size : Int) -> NetroutemultipathNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_node_len(s : NetroutemultipathNode) -> Int { s.size }

pub fn net_route_multipath_node_get(s : NetroutemultipathNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_node_set(s : NetroutemultipathNode, i : Int, v : Double) -> NetroutemultipathNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_node_sum(s : NetroutemultipathNode) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_node_mean(s : NetroutemultipathNode) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_node_scale(s : NetroutemultipathNode, f : Double) -> NetroutemultipathNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_node_add(a : NetroutemultipathNode, b : NetroutemultipathNode) -> NetroutemultipathNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_node_copy(s : NetroutemultipathNode) -> NetroutemultipathNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_node_fill(s : NetroutemultipathNode, v : Double) -> NetroutemultipathNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_node_min(s : NetroutemultipathNode) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_node_max(s : NetroutemultipathNode) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_node_to_string(s : NetroutemultipathNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_edge_make(size : Int) -> NetroutemultipathEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_edge_len(s : NetroutemultipathEdge) -> Int { s.size }

pub fn net_route_multipath_edge_get(s : NetroutemultipathEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_edge_set(s : NetroutemultipathEdge, i : Int, v : Double) -> NetroutemultipathEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_edge_sum(s : NetroutemultipathEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_edge_mean(s : NetroutemultipathEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_edge_scale(s : NetroutemultipathEdge, f : Double) -> NetroutemultipathEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_edge_add(a : NetroutemultipathEdge, b : NetroutemultipathEdge) -> NetroutemultipathEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_edge_copy(s : NetroutemultipathEdge) -> NetroutemultipathEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_edge_fill(s : NetroutemultipathEdge, v : Double) -> NetroutemultipathEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_edge_min(s : NetroutemultipathEdge) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_edge_max(s : NetroutemultipathEdge) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_edge_to_string(s : NetroutemultipathEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_path_make(size : Int) -> NetroutemultipathPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_path_len(s : NetroutemultipathPath) -> Int { s.size }

pub fn net_route_multipath_path_get(s : NetroutemultipathPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_path_set(s : NetroutemultipathPath, i : Int, v : Double) -> NetroutemultipathPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_path_sum(s : NetroutemultipathPath) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_path_mean(s : NetroutemultipathPath) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_path_scale(s : NetroutemultipathPath, f : Double) -> NetroutemultipathPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_path_add(a : NetroutemultipathPath, b : NetroutemultipathPath) -> NetroutemultipathPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_path_copy(s : NetroutemultipathPath) -> NetroutemultipathPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_path_fill(s : NetroutemultipathPath, v : Double) -> NetroutemultipathPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_path_min(s : NetroutemultipathPath) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_path_max(s : NetroutemultipathPath) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_path_to_string(s : NetroutemultipathPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_cluster_make(size : Int) -> NetroutemultipathCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_cluster_len(s : NetroutemultipathCluster) -> Int { s.size }

pub fn net_route_multipath_cluster_get(s : NetroutemultipathCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_cluster_set(s : NetroutemultipathCluster, i : Int, v : Double) -> NetroutemultipathCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cluster_sum(s : NetroutemultipathCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_cluster_mean(s : NetroutemultipathCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_cluster_scale(s : NetroutemultipathCluster, f : Double) -> NetroutemultipathCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cluster_add(a : NetroutemultipathCluster, b : NetroutemultipathCluster) -> NetroutemultipathCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_cluster_copy(s : NetroutemultipathCluster) -> NetroutemultipathCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cluster_fill(s : NetroutemultipathCluster, v : Double) -> NetroutemultipathCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cluster_min(s : NetroutemultipathCluster) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_cluster_max(s : NetroutemultipathCluster) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_cluster_to_string(s : NetroutemultipathCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_model_make(size : Int) -> NetroutemultipathModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_model_len(s : NetroutemultipathModel) -> Int { s.size }

pub fn net_route_multipath_model_get(s : NetroutemultipathModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_model_set(s : NetroutemultipathModel, i : Int, v : Double) -> NetroutemultipathModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_model_sum(s : NetroutemultipathModel) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_model_mean(s : NetroutemultipathModel) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_model_scale(s : NetroutemultipathModel, f : Double) -> NetroutemultipathModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_model_add(a : NetroutemultipathModel, b : NetroutemultipathModel) -> NetroutemultipathModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_model_copy(s : NetroutemultipathModel) -> NetroutemultipathModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_model_fill(s : NetroutemultipathModel, v : Double) -> NetroutemultipathModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_model_min(s : NetroutemultipathModel) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_model_max(s : NetroutemultipathModel) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_model_to_string(s : NetroutemultipathModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_layer_make(size : Int) -> NetroutemultipathLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_layer_len(s : NetroutemultipathLayer) -> Int { s.size }

pub fn net_route_multipath_layer_get(s : NetroutemultipathLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_layer_set(s : NetroutemultipathLayer, i : Int, v : Double) -> NetroutemultipathLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_layer_sum(s : NetroutemultipathLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_layer_mean(s : NetroutemultipathLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_layer_scale(s : NetroutemultipathLayer, f : Double) -> NetroutemultipathLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_layer_add(a : NetroutemultipathLayer, b : NetroutemultipathLayer) -> NetroutemultipathLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_layer_copy(s : NetroutemultipathLayer) -> NetroutemultipathLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_layer_fill(s : NetroutemultipathLayer, v : Double) -> NetroutemultipathLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_layer_min(s : NetroutemultipathLayer) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_layer_max(s : NetroutemultipathLayer) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_layer_to_string(s : NetroutemultipathLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_buffer_make(size : Int) -> NetroutemultipathBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_buffer_len(s : NetroutemultipathBuffer) -> Int { s.size }

pub fn net_route_multipath_buffer_get(s : NetroutemultipathBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_buffer_set(s : NetroutemultipathBuffer, i : Int, v : Double) -> NetroutemultipathBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_buffer_sum(s : NetroutemultipathBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_buffer_mean(s : NetroutemultipathBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_buffer_scale(s : NetroutemultipathBuffer, f : Double) -> NetroutemultipathBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_buffer_add(a : NetroutemultipathBuffer, b : NetroutemultipathBuffer) -> NetroutemultipathBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_buffer_copy(s : NetroutemultipathBuffer) -> NetroutemultipathBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_buffer_fill(s : NetroutemultipathBuffer, v : Double) -> NetroutemultipathBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_buffer_min(s : NetroutemultipathBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_buffer_max(s : NetroutemultipathBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_buffer_to_string(s : NetroutemultipathBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_cursor_make(size : Int) -> NetroutemultipathCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_cursor_len(s : NetroutemultipathCursor) -> Int { s.size }

pub fn net_route_multipath_cursor_get(s : NetroutemultipathCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_cursor_set(s : NetroutemultipathCursor, i : Int, v : Double) -> NetroutemultipathCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cursor_sum(s : NetroutemultipathCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_cursor_mean(s : NetroutemultipathCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_cursor_scale(s : NetroutemultipathCursor, f : Double) -> NetroutemultipathCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cursor_add(a : NetroutemultipathCursor, b : NetroutemultipathCursor) -> NetroutemultipathCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_cursor_copy(s : NetroutemultipathCursor) -> NetroutemultipathCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cursor_fill(s : NetroutemultipathCursor, v : Double) -> NetroutemultipathCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_cursor_min(s : NetroutemultipathCursor) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_cursor_max(s : NetroutemultipathCursor) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_cursor_to_string(s : NetroutemultipathCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_view_make(size : Int) -> NetroutemultipathView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_view_len(s : NetroutemultipathView) -> Int { s.size }

pub fn net_route_multipath_view_get(s : NetroutemultipathView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_view_set(s : NetroutemultipathView, i : Int, v : Double) -> NetroutemultipathView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_view_sum(s : NetroutemultipathView) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_view_mean(s : NetroutemultipathView) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_view_scale(s : NetroutemultipathView, f : Double) -> NetroutemultipathView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_view_add(a : NetroutemultipathView, b : NetroutemultipathView) -> NetroutemultipathView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_view_copy(s : NetroutemultipathView) -> NetroutemultipathView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_view_fill(s : NetroutemultipathView, v : Double) -> NetroutemultipathView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_view_min(s : NetroutemultipathView) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_view_max(s : NetroutemultipathView) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_view_to_string(s : NetroutemultipathView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_range_make(size : Int) -> NetroutemultipathRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_range_len(s : NetroutemultipathRange) -> Int { s.size }

pub fn net_route_multipath_range_get(s : NetroutemultipathRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_range_set(s : NetroutemultipathRange, i : Int, v : Double) -> NetroutemultipathRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_range_sum(s : NetroutemultipathRange) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_range_mean(s : NetroutemultipathRange) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_range_scale(s : NetroutemultipathRange, f : Double) -> NetroutemultipathRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_range_add(a : NetroutemultipathRange, b : NetroutemultipathRange) -> NetroutemultipathRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_range_copy(s : NetroutemultipathRange) -> NetroutemultipathRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_range_fill(s : NetroutemultipathRange, v : Double) -> NetroutemultipathRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_range_min(s : NetroutemultipathRange) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_range_max(s : NetroutemultipathRange) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_range_to_string(s : NetroutemultipathRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutemultipathSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_multipath_slice_make(size : Int) -> NetroutemultipathSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_multipath_slice_len(s : NetroutemultipathSlice) -> Int { s.size }

pub fn net_route_multipath_slice_get(s : NetroutemultipathSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_multipath_slice_set(s : NetroutemultipathSlice, i : Int, v : Double) -> NetroutemultipathSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_multipath_slice_sum(s : NetroutemultipathSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_multipath_slice_mean(s : NetroutemultipathSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_multipath_slice_scale(s : NetroutemultipathSlice, f : Double) -> NetroutemultipathSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_slice_add(a : NetroutemultipathSlice, b : NetroutemultipathSlice) -> NetroutemultipathSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_multipath_slice_copy(s : NetroutemultipathSlice) -> NetroutemultipathSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_slice_fill(s : NetroutemultipathSlice, v : Double) -> NetroutemultipathSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_multipath_slice_min(s : NetroutemultipathSlice) -> Double { @_common.min(s.data) }

pub fn net_route_multipath_slice_max(s : NetroutemultipathSlice) -> Double { @_common.max(s.data) }

pub fn net_route_multipath_slice_to_string(s : NetroutemultipathSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

