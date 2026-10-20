///===
/// extcore/net_route_static

pub(all) struct NetroutestaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_static_make_point(x : Double, y : Double) -> NetroutestaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_static_make_point3(x : Double, y : Double, z : Double) -> NetroutestaticPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutestaticPoint::x(self : NetroutestaticPoint) -> Double { self.x }

pub fn NetroutestaticPoint::y(self : NetroutestaticPoint) -> Double { self.y }

pub fn NetroutestaticPoint::z(self : NetroutestaticPoint) -> Double { self.z }

pub fn NetroutestaticPoint::label(self : NetroutestaticPoint) -> Int { self.label }

pub fn NetroutestaticPoint::dist(self : NetroutestaticPoint, other : NetroutestaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutestaticPoint::add(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutestaticPoint::sub(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutestaticPoint::scale(self : NetroutestaticPoint, s : Double) -> NetroutestaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutestaticPoint::dot(self : NetroutestaticPoint, other : NetroutestaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutestaticPoint::cross(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutestaticPoint::norm(self : NetroutestaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutestaticPoint::normalize(self : NetroutestaticPoint) -> NetroutestaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutestaticPoint::negate(self : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutestaticPoint::mid(self : NetroutestaticPoint, other : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutestaticPoint::lerp(self : NetroutestaticPoint, other : NetroutestaticPoint, t : Double) -> NetroutestaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutestaticPoint::to_string(self : NetroutestaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutestaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_static_make_series(vals : Array[Double], name : String) -> NetroutestaticSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutestaticSeries::len(self : NetroutestaticSeries) -> Int { self.vals.length() }

pub fn NetroutestaticSeries::sum(self : NetroutestaticSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutestaticSeries::mean(self : NetroutestaticSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutestaticSeries::min(self : NetroutestaticSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutestaticSeries::max(self : NetroutestaticSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutestaticSeries::range(self : NetroutestaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutestaticSeries::variance(self : NetroutestaticSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutestaticSeries::std(self : NetroutestaticSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutestaticSeries::median(self : NetroutestaticSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutestaticSeries::scale(self : NetroutestaticSeries, f : Double) -> NetroutestaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutestaticSeries::add(self : NetroutestaticSeries, other : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutestaticSeries::sub(self : NetroutestaticSeries, other : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutestaticSeries::normalize(self : NetroutestaticSeries) -> NetroutestaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutestaticSeries::cumsum(self : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutestaticSeries::to_string(self : NetroutestaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutestaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_static_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutestaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_static_matrix_identity(n : Int) -> NetroutestaticMatrix {
  let m = net_route_static_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutestaticMatrix::get(self : NetroutestaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutestaticMatrix::transpose(self : NetroutestaticMatrix) -> NetroutestaticMatrix {
  let result = net_route_static_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutestaticMatrix::add(self : NetroutestaticMatrix, other : NetroutestaticMatrix) -> NetroutestaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutestaticMatrix::scale(self : NetroutestaticMatrix, s : Double) -> NetroutestaticMatrix {
  let result = net_route_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutestaticMatrix::multiply(self : NetroutestaticMatrix, other : NetroutestaticMatrix) -> NetroutestaticMatrix {
  if self.cols != other.rows { return net_route_static_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_static_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutestaticMatrix::trace(self : NetroutestaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutestaticMatrix::det(self : NetroutestaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutestaticMatrix::norm(self : NetroutestaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutestaticMatrix::to_string(self : NetroutestaticMatrix) -> String {
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

pub(all) struct NetroutestaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_static_make_vector(comps : Array[Double]) -> NetroutestaticVector {
  { comps, dim: comps.length() }
}

pub fn net_route_static_vector_zero(dim : Int) -> NetroutestaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutestaticVector::add(self : NetroutestaticVector, other : NetroutestaticVector) -> NetroutestaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutestaticVector::sub(self : NetroutestaticVector, other : NetroutestaticVector) -> NetroutestaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutestaticVector::scale(self : NetroutestaticVector, s : Double) -> NetroutestaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutestaticVector::dot(self : NetroutestaticVector, other : NetroutestaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutestaticVector::norm(self : NetroutestaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutestaticVector::normalize(self : NetroutestaticVector) -> NetroutestaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutestaticVector::dist(self : NetroutestaticVector, other : NetroutestaticVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutestaticVector::to_string(self : NetroutestaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_static_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_static_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_static_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_static_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_static_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_static_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_static_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_static_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_static_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_static_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_static_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_static_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_static_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_static_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_static_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_static_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_static_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_static_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_static_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_static_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_static_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_static_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_static_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_static_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_static_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_static_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_static_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_static_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_static_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutestaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_frame_make(size : Int) -> NetroutestaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_frame_len(s : NetroutestaticFrame) -> Int { s.size }

pub fn net_route_static_frame_get(s : NetroutestaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_frame_set(s : NetroutestaticFrame, i : Int, v : Double) -> NetroutestaticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_frame_sum(s : NetroutestaticFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_static_frame_mean(s : NetroutestaticFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_static_frame_scale(s : NetroutestaticFrame, f : Double) -> NetroutestaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_frame_add(a : NetroutestaticFrame, b : NetroutestaticFrame) -> NetroutestaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_frame_copy(s : NetroutestaticFrame) -> NetroutestaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_frame_fill(s : NetroutestaticFrame, v : Double) -> NetroutestaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_frame_min(s : NetroutestaticFrame) -> Double { @_common.min(s.data) }

pub fn net_route_static_frame_max(s : NetroutestaticFrame) -> Double { @_common.max(s.data) }

pub fn net_route_static_frame_to_string(s : NetroutestaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_table_make(size : Int) -> NetroutestaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_table_len(s : NetroutestaticTable) -> Int { s.size }

pub fn net_route_static_table_get(s : NetroutestaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_table_set(s : NetroutestaticTable, i : Int, v : Double) -> NetroutestaticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_table_sum(s : NetroutestaticTable) -> Double { @_common.sum(s.data) }

pub fn net_route_static_table_mean(s : NetroutestaticTable) -> Double { @_common.mean(s.data) }

pub fn net_route_static_table_scale(s : NetroutestaticTable, f : Double) -> NetroutestaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_table_add(a : NetroutestaticTable, b : NetroutestaticTable) -> NetroutestaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_table_copy(s : NetroutestaticTable) -> NetroutestaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_table_fill(s : NetroutestaticTable, v : Double) -> NetroutestaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_table_min(s : NetroutestaticTable) -> Double { @_common.min(s.data) }

pub fn net_route_static_table_max(s : NetroutestaticTable) -> Double { @_common.max(s.data) }

pub fn net_route_static_table_to_string(s : NetroutestaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_graphn_make(size : Int) -> NetroutestaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_graphn_len(s : NetroutestaticGraphN) -> Int { s.size }

pub fn net_route_static_graphn_get(s : NetroutestaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_graphn_set(s : NetroutestaticGraphN, i : Int, v : Double) -> NetroutestaticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_graphn_sum(s : NetroutestaticGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_static_graphn_mean(s : NetroutestaticGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_static_graphn_scale(s : NetroutestaticGraphN, f : Double) -> NetroutestaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_graphn_add(a : NetroutestaticGraphN, b : NetroutestaticGraphN) -> NetroutestaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_graphn_copy(s : NetroutestaticGraphN) -> NetroutestaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_graphn_fill(s : NetroutestaticGraphN, v : Double) -> NetroutestaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_graphn_min(s : NetroutestaticGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_static_graphn_max(s : NetroutestaticGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_static_graphn_to_string(s : NetroutestaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_node_make(size : Int) -> NetroutestaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_node_len(s : NetroutestaticNode) -> Int { s.size }

pub fn net_route_static_node_get(s : NetroutestaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_node_set(s : NetroutestaticNode, i : Int, v : Double) -> NetroutestaticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_node_sum(s : NetroutestaticNode) -> Double { @_common.sum(s.data) }

pub fn net_route_static_node_mean(s : NetroutestaticNode) -> Double { @_common.mean(s.data) }

pub fn net_route_static_node_scale(s : NetroutestaticNode, f : Double) -> NetroutestaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_node_add(a : NetroutestaticNode, b : NetroutestaticNode) -> NetroutestaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_node_copy(s : NetroutestaticNode) -> NetroutestaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_node_fill(s : NetroutestaticNode, v : Double) -> NetroutestaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_node_min(s : NetroutestaticNode) -> Double { @_common.min(s.data) }

pub fn net_route_static_node_max(s : NetroutestaticNode) -> Double { @_common.max(s.data) }

pub fn net_route_static_node_to_string(s : NetroutestaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_edge_make(size : Int) -> NetroutestaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_edge_len(s : NetroutestaticEdge) -> Int { s.size }

pub fn net_route_static_edge_get(s : NetroutestaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_edge_set(s : NetroutestaticEdge, i : Int, v : Double) -> NetroutestaticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_edge_sum(s : NetroutestaticEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_static_edge_mean(s : NetroutestaticEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_static_edge_scale(s : NetroutestaticEdge, f : Double) -> NetroutestaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_edge_add(a : NetroutestaticEdge, b : NetroutestaticEdge) -> NetroutestaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_edge_copy(s : NetroutestaticEdge) -> NetroutestaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_edge_fill(s : NetroutestaticEdge, v : Double) -> NetroutestaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_edge_min(s : NetroutestaticEdge) -> Double { @_common.min(s.data) }

pub fn net_route_static_edge_max(s : NetroutestaticEdge) -> Double { @_common.max(s.data) }

pub fn net_route_static_edge_to_string(s : NetroutestaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_path_make(size : Int) -> NetroutestaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_path_len(s : NetroutestaticPath) -> Int { s.size }

pub fn net_route_static_path_get(s : NetroutestaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_path_set(s : NetroutestaticPath, i : Int, v : Double) -> NetroutestaticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_path_sum(s : NetroutestaticPath) -> Double { @_common.sum(s.data) }

pub fn net_route_static_path_mean(s : NetroutestaticPath) -> Double { @_common.mean(s.data) }

pub fn net_route_static_path_scale(s : NetroutestaticPath, f : Double) -> NetroutestaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_path_add(a : NetroutestaticPath, b : NetroutestaticPath) -> NetroutestaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_path_copy(s : NetroutestaticPath) -> NetroutestaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_path_fill(s : NetroutestaticPath, v : Double) -> NetroutestaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_path_min(s : NetroutestaticPath) -> Double { @_common.min(s.data) }

pub fn net_route_static_path_max(s : NetroutestaticPath) -> Double { @_common.max(s.data) }

pub fn net_route_static_path_to_string(s : NetroutestaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_cluster_make(size : Int) -> NetroutestaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_cluster_len(s : NetroutestaticCluster) -> Int { s.size }

pub fn net_route_static_cluster_get(s : NetroutestaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_cluster_set(s : NetroutestaticCluster, i : Int, v : Double) -> NetroutestaticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_cluster_sum(s : NetroutestaticCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_static_cluster_mean(s : NetroutestaticCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_static_cluster_scale(s : NetroutestaticCluster, f : Double) -> NetroutestaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_cluster_add(a : NetroutestaticCluster, b : NetroutestaticCluster) -> NetroutestaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_cluster_copy(s : NetroutestaticCluster) -> NetroutestaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_cluster_fill(s : NetroutestaticCluster, v : Double) -> NetroutestaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_cluster_min(s : NetroutestaticCluster) -> Double { @_common.min(s.data) }

pub fn net_route_static_cluster_max(s : NetroutestaticCluster) -> Double { @_common.max(s.data) }

pub fn net_route_static_cluster_to_string(s : NetroutestaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_model_make(size : Int) -> NetroutestaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_model_len(s : NetroutestaticModel) -> Int { s.size }

pub fn net_route_static_model_get(s : NetroutestaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_model_set(s : NetroutestaticModel, i : Int, v : Double) -> NetroutestaticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_model_sum(s : NetroutestaticModel) -> Double { @_common.sum(s.data) }

pub fn net_route_static_model_mean(s : NetroutestaticModel) -> Double { @_common.mean(s.data) }

pub fn net_route_static_model_scale(s : NetroutestaticModel, f : Double) -> NetroutestaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_model_add(a : NetroutestaticModel, b : NetroutestaticModel) -> NetroutestaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_model_copy(s : NetroutestaticModel) -> NetroutestaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_model_fill(s : NetroutestaticModel, v : Double) -> NetroutestaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_model_min(s : NetroutestaticModel) -> Double { @_common.min(s.data) }

pub fn net_route_static_model_max(s : NetroutestaticModel) -> Double { @_common.max(s.data) }

pub fn net_route_static_model_to_string(s : NetroutestaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_layer_make(size : Int) -> NetroutestaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_layer_len(s : NetroutestaticLayer) -> Int { s.size }

pub fn net_route_static_layer_get(s : NetroutestaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_layer_set(s : NetroutestaticLayer, i : Int, v : Double) -> NetroutestaticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_layer_sum(s : NetroutestaticLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_static_layer_mean(s : NetroutestaticLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_static_layer_scale(s : NetroutestaticLayer, f : Double) -> NetroutestaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_layer_add(a : NetroutestaticLayer, b : NetroutestaticLayer) -> NetroutestaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_layer_copy(s : NetroutestaticLayer) -> NetroutestaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_layer_fill(s : NetroutestaticLayer, v : Double) -> NetroutestaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_layer_min(s : NetroutestaticLayer) -> Double { @_common.min(s.data) }

pub fn net_route_static_layer_max(s : NetroutestaticLayer) -> Double { @_common.max(s.data) }

pub fn net_route_static_layer_to_string(s : NetroutestaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_buffer_make(size : Int) -> NetroutestaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_buffer_len(s : NetroutestaticBuffer) -> Int { s.size }

pub fn net_route_static_buffer_get(s : NetroutestaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_buffer_set(s : NetroutestaticBuffer, i : Int, v : Double) -> NetroutestaticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_buffer_sum(s : NetroutestaticBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_static_buffer_mean(s : NetroutestaticBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_static_buffer_scale(s : NetroutestaticBuffer, f : Double) -> NetroutestaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_buffer_add(a : NetroutestaticBuffer, b : NetroutestaticBuffer) -> NetroutestaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_buffer_copy(s : NetroutestaticBuffer) -> NetroutestaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_buffer_fill(s : NetroutestaticBuffer, v : Double) -> NetroutestaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_buffer_min(s : NetroutestaticBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_static_buffer_max(s : NetroutestaticBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_static_buffer_to_string(s : NetroutestaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_cursor_make(size : Int) -> NetroutestaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_cursor_len(s : NetroutestaticCursor) -> Int { s.size }

pub fn net_route_static_cursor_get(s : NetroutestaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_cursor_set(s : NetroutestaticCursor, i : Int, v : Double) -> NetroutestaticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_cursor_sum(s : NetroutestaticCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_static_cursor_mean(s : NetroutestaticCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_static_cursor_scale(s : NetroutestaticCursor, f : Double) -> NetroutestaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_cursor_add(a : NetroutestaticCursor, b : NetroutestaticCursor) -> NetroutestaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_cursor_copy(s : NetroutestaticCursor) -> NetroutestaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_cursor_fill(s : NetroutestaticCursor, v : Double) -> NetroutestaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_cursor_min(s : NetroutestaticCursor) -> Double { @_common.min(s.data) }

pub fn net_route_static_cursor_max(s : NetroutestaticCursor) -> Double { @_common.max(s.data) }

pub fn net_route_static_cursor_to_string(s : NetroutestaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_view_make(size : Int) -> NetroutestaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_view_len(s : NetroutestaticView) -> Int { s.size }

pub fn net_route_static_view_get(s : NetroutestaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_view_set(s : NetroutestaticView, i : Int, v : Double) -> NetroutestaticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_view_sum(s : NetroutestaticView) -> Double { @_common.sum(s.data) }

pub fn net_route_static_view_mean(s : NetroutestaticView) -> Double { @_common.mean(s.data) }

pub fn net_route_static_view_scale(s : NetroutestaticView, f : Double) -> NetroutestaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_view_add(a : NetroutestaticView, b : NetroutestaticView) -> NetroutestaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_view_copy(s : NetroutestaticView) -> NetroutestaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_view_fill(s : NetroutestaticView, v : Double) -> NetroutestaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_view_min(s : NetroutestaticView) -> Double { @_common.min(s.data) }

pub fn net_route_static_view_max(s : NetroutestaticView) -> Double { @_common.max(s.data) }

pub fn net_route_static_view_to_string(s : NetroutestaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_range_make(size : Int) -> NetroutestaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_range_len(s : NetroutestaticRange) -> Int { s.size }

pub fn net_route_static_range_get(s : NetroutestaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_range_set(s : NetroutestaticRange, i : Int, v : Double) -> NetroutestaticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_range_sum(s : NetroutestaticRange) -> Double { @_common.sum(s.data) }

pub fn net_route_static_range_mean(s : NetroutestaticRange) -> Double { @_common.mean(s.data) }

pub fn net_route_static_range_scale(s : NetroutestaticRange, f : Double) -> NetroutestaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_range_add(a : NetroutestaticRange, b : NetroutestaticRange) -> NetroutestaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_range_copy(s : NetroutestaticRange) -> NetroutestaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_range_fill(s : NetroutestaticRange, v : Double) -> NetroutestaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_range_min(s : NetroutestaticRange) -> Double { @_common.min(s.data) }

pub fn net_route_static_range_max(s : NetroutestaticRange) -> Double { @_common.max(s.data) }

pub fn net_route_static_range_to_string(s : NetroutestaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_slice_make(size : Int) -> NetroutestaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_slice_len(s : NetroutestaticSlice) -> Int { s.size }

pub fn net_route_static_slice_get(s : NetroutestaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_slice_set(s : NetroutestaticSlice, i : Int, v : Double) -> NetroutestaticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_static_slice_sum(s : NetroutestaticSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_static_slice_mean(s : NetroutestaticSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_static_slice_scale(s : NetroutestaticSlice, f : Double) -> NetroutestaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_static_slice_add(a : NetroutestaticSlice, b : NetroutestaticSlice) -> NetroutestaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_static_slice_copy(s : NetroutestaticSlice) -> NetroutestaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_static_slice_fill(s : NetroutestaticSlice, v : Double) -> NetroutestaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_static_slice_min(s : NetroutestaticSlice) -> Double { @_common.min(s.data) }

pub fn net_route_static_slice_max(s : NetroutestaticSlice) -> Double { @_common.max(s.data) }

pub fn net_route_static_slice_to_string(s : NetroutestaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

