///===
/// extcore/net_route_isis

pub(all) struct NetrouteisisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_isis_make_point(x : Double, y : Double) -> NetrouteisisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_isis_make_point3(x : Double, y : Double, z : Double) -> NetrouteisisPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteisisPoint::x(self : NetrouteisisPoint) -> Double { self.x }

pub fn NetrouteisisPoint::y(self : NetrouteisisPoint) -> Double { self.y }

pub fn NetrouteisisPoint::z(self : NetrouteisisPoint) -> Double { self.z }

pub fn NetrouteisisPoint::label(self : NetrouteisisPoint) -> Int { self.label }

pub fn NetrouteisisPoint::dist(self : NetrouteisisPoint, other : NetrouteisisPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteisisPoint::add(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteisisPoint::sub(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteisisPoint::scale(self : NetrouteisisPoint, s : Double) -> NetrouteisisPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteisisPoint::dot(self : NetrouteisisPoint, other : NetrouteisisPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteisisPoint::cross(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteisisPoint::norm(self : NetrouteisisPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteisisPoint::normalize(self : NetrouteisisPoint) -> NetrouteisisPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteisisPoint::negate(self : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteisisPoint::mid(self : NetrouteisisPoint, other : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteisisPoint::lerp(self : NetrouteisisPoint, other : NetrouteisisPoint, t : Double) -> NetrouteisisPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteisisPoint::to_string(self : NetrouteisisPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteisisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_isis_make_series(vals : Array[Double], name : String) -> NetrouteisisSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteisisSeries::len(self : NetrouteisisSeries) -> Int { self.vals.length() }

pub fn NetrouteisisSeries::sum(self : NetrouteisisSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteisisSeries::mean(self : NetrouteisisSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteisisSeries::min(self : NetrouteisisSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteisisSeries::max(self : NetrouteisisSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteisisSeries::range(self : NetrouteisisSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteisisSeries::variance(self : NetrouteisisSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteisisSeries::std(self : NetrouteisisSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteisisSeries::median(self : NetrouteisisSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteisisSeries::scale(self : NetrouteisisSeries, f : Double) -> NetrouteisisSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteisisSeries::add(self : NetrouteisisSeries, other : NetrouteisisSeries) -> NetrouteisisSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteisisSeries::sub(self : NetrouteisisSeries, other : NetrouteisisSeries) -> NetrouteisisSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteisisSeries::normalize(self : NetrouteisisSeries) -> NetrouteisisSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteisisSeries::cumsum(self : NetrouteisisSeries) -> NetrouteisisSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteisisSeries::to_string(self : NetrouteisisSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteisisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_isis_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteisisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_isis_matrix_identity(n : Int) -> NetrouteisisMatrix {
  let m = net_route_isis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteisisMatrix::get(self : NetrouteisisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteisisMatrix::transpose(self : NetrouteisisMatrix) -> NetrouteisisMatrix {
  let result = net_route_isis_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteisisMatrix::add(self : NetrouteisisMatrix, other : NetrouteisisMatrix) -> NetrouteisisMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_isis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteisisMatrix::scale(self : NetrouteisisMatrix, s : Double) -> NetrouteisisMatrix {
  let result = net_route_isis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteisisMatrix::multiply(self : NetrouteisisMatrix, other : NetrouteisisMatrix) -> NetrouteisisMatrix {
  if self.cols != other.rows { return net_route_isis_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_isis_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetrouteisisMatrix::trace(self : NetrouteisisMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteisisMatrix::det(self : NetrouteisisMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteisisMatrix::norm(self : NetrouteisisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteisisMatrix::to_string(self : NetrouteisisMatrix) -> String {
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

pub(all) struct NetrouteisisVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_isis_make_vector(comps : Array[Double]) -> NetrouteisisVector {
  { comps, dim: comps.length() }
}

pub fn net_route_isis_vector_zero(dim : Int) -> NetrouteisisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteisisVector::add(self : NetrouteisisVector, other : NetrouteisisVector) -> NetrouteisisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteisisVector::sub(self : NetrouteisisVector, other : NetrouteisisVector) -> NetrouteisisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteisisVector::scale(self : NetrouteisisVector, s : Double) -> NetrouteisisVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteisisVector::dot(self : NetrouteisisVector, other : NetrouteisisVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteisisVector::norm(self : NetrouteisisVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteisisVector::normalize(self : NetrouteisisVector) -> NetrouteisisVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteisisVector::dist(self : NetrouteisisVector, other : NetrouteisisVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteisisVector::to_string(self : NetrouteisisVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_isis_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_isis_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_isis_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_isis_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_isis_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_isis_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_isis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_isis_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_isis_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_isis_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_isis_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_isis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_isis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_isis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_isis_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_isis_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_isis_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_isis_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_isis_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_isis_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_isis_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_isis_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_isis_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_isis_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_isis_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_isis_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_isis_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_isis_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_isis_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetrouteisisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_frame_make(size : Int) -> NetrouteisisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_frame_len(s : NetrouteisisFrame) -> Int { s.size }

pub fn net_route_isis_frame_get(s : NetrouteisisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_frame_set(s : NetrouteisisFrame, i : Int, v : Double) -> NetrouteisisFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_frame_sum(s : NetrouteisisFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_frame_mean(s : NetrouteisisFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_frame_scale(s : NetrouteisisFrame, f : Double) -> NetrouteisisFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_frame_add(a : NetrouteisisFrame, b : NetrouteisisFrame) -> NetrouteisisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_frame_copy(s : NetrouteisisFrame) -> NetrouteisisFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_frame_fill(s : NetrouteisisFrame, v : Double) -> NetrouteisisFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_frame_min(s : NetrouteisisFrame) -> Double { @_common.min(s.data) }

pub fn net_route_isis_frame_max(s : NetrouteisisFrame) -> Double { @_common.max(s.data) }

pub fn net_route_isis_frame_to_string(s : NetrouteisisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_table_make(size : Int) -> NetrouteisisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_table_len(s : NetrouteisisTable) -> Int { s.size }

pub fn net_route_isis_table_get(s : NetrouteisisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_table_set(s : NetrouteisisTable, i : Int, v : Double) -> NetrouteisisTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_table_sum(s : NetrouteisisTable) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_table_mean(s : NetrouteisisTable) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_table_scale(s : NetrouteisisTable, f : Double) -> NetrouteisisTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_table_add(a : NetrouteisisTable, b : NetrouteisisTable) -> NetrouteisisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_table_copy(s : NetrouteisisTable) -> NetrouteisisTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_table_fill(s : NetrouteisisTable, v : Double) -> NetrouteisisTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_table_min(s : NetrouteisisTable) -> Double { @_common.min(s.data) }

pub fn net_route_isis_table_max(s : NetrouteisisTable) -> Double { @_common.max(s.data) }

pub fn net_route_isis_table_to_string(s : NetrouteisisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_graphn_make(size : Int) -> NetrouteisisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_graphn_len(s : NetrouteisisGraphN) -> Int { s.size }

pub fn net_route_isis_graphn_get(s : NetrouteisisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_graphn_set(s : NetrouteisisGraphN, i : Int, v : Double) -> NetrouteisisGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_graphn_sum(s : NetrouteisisGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_graphn_mean(s : NetrouteisisGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_graphn_scale(s : NetrouteisisGraphN, f : Double) -> NetrouteisisGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_graphn_add(a : NetrouteisisGraphN, b : NetrouteisisGraphN) -> NetrouteisisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_graphn_copy(s : NetrouteisisGraphN) -> NetrouteisisGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_graphn_fill(s : NetrouteisisGraphN, v : Double) -> NetrouteisisGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_graphn_min(s : NetrouteisisGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_isis_graphn_max(s : NetrouteisisGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_isis_graphn_to_string(s : NetrouteisisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_node_make(size : Int) -> NetrouteisisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_node_len(s : NetrouteisisNode) -> Int { s.size }

pub fn net_route_isis_node_get(s : NetrouteisisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_node_set(s : NetrouteisisNode, i : Int, v : Double) -> NetrouteisisNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_node_sum(s : NetrouteisisNode) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_node_mean(s : NetrouteisisNode) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_node_scale(s : NetrouteisisNode, f : Double) -> NetrouteisisNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_node_add(a : NetrouteisisNode, b : NetrouteisisNode) -> NetrouteisisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_node_copy(s : NetrouteisisNode) -> NetrouteisisNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_node_fill(s : NetrouteisisNode, v : Double) -> NetrouteisisNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_node_min(s : NetrouteisisNode) -> Double { @_common.min(s.data) }

pub fn net_route_isis_node_max(s : NetrouteisisNode) -> Double { @_common.max(s.data) }

pub fn net_route_isis_node_to_string(s : NetrouteisisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_edge_make(size : Int) -> NetrouteisisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_edge_len(s : NetrouteisisEdge) -> Int { s.size }

pub fn net_route_isis_edge_get(s : NetrouteisisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_edge_set(s : NetrouteisisEdge, i : Int, v : Double) -> NetrouteisisEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_edge_sum(s : NetrouteisisEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_edge_mean(s : NetrouteisisEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_edge_scale(s : NetrouteisisEdge, f : Double) -> NetrouteisisEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_edge_add(a : NetrouteisisEdge, b : NetrouteisisEdge) -> NetrouteisisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_edge_copy(s : NetrouteisisEdge) -> NetrouteisisEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_edge_fill(s : NetrouteisisEdge, v : Double) -> NetrouteisisEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_edge_min(s : NetrouteisisEdge) -> Double { @_common.min(s.data) }

pub fn net_route_isis_edge_max(s : NetrouteisisEdge) -> Double { @_common.max(s.data) }

pub fn net_route_isis_edge_to_string(s : NetrouteisisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_path_make(size : Int) -> NetrouteisisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_path_len(s : NetrouteisisPath) -> Int { s.size }

pub fn net_route_isis_path_get(s : NetrouteisisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_path_set(s : NetrouteisisPath, i : Int, v : Double) -> NetrouteisisPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_path_sum(s : NetrouteisisPath) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_path_mean(s : NetrouteisisPath) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_path_scale(s : NetrouteisisPath, f : Double) -> NetrouteisisPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_path_add(a : NetrouteisisPath, b : NetrouteisisPath) -> NetrouteisisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_path_copy(s : NetrouteisisPath) -> NetrouteisisPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_path_fill(s : NetrouteisisPath, v : Double) -> NetrouteisisPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_path_min(s : NetrouteisisPath) -> Double { @_common.min(s.data) }

pub fn net_route_isis_path_max(s : NetrouteisisPath) -> Double { @_common.max(s.data) }

pub fn net_route_isis_path_to_string(s : NetrouteisisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_cluster_make(size : Int) -> NetrouteisisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_cluster_len(s : NetrouteisisCluster) -> Int { s.size }

pub fn net_route_isis_cluster_get(s : NetrouteisisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_cluster_set(s : NetrouteisisCluster, i : Int, v : Double) -> NetrouteisisCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_cluster_sum(s : NetrouteisisCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_cluster_mean(s : NetrouteisisCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_cluster_scale(s : NetrouteisisCluster, f : Double) -> NetrouteisisCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_cluster_add(a : NetrouteisisCluster, b : NetrouteisisCluster) -> NetrouteisisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_cluster_copy(s : NetrouteisisCluster) -> NetrouteisisCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_cluster_fill(s : NetrouteisisCluster, v : Double) -> NetrouteisisCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_cluster_min(s : NetrouteisisCluster) -> Double { @_common.min(s.data) }

pub fn net_route_isis_cluster_max(s : NetrouteisisCluster) -> Double { @_common.max(s.data) }

pub fn net_route_isis_cluster_to_string(s : NetrouteisisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_model_make(size : Int) -> NetrouteisisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_model_len(s : NetrouteisisModel) -> Int { s.size }

pub fn net_route_isis_model_get(s : NetrouteisisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_model_set(s : NetrouteisisModel, i : Int, v : Double) -> NetrouteisisModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_model_sum(s : NetrouteisisModel) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_model_mean(s : NetrouteisisModel) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_model_scale(s : NetrouteisisModel, f : Double) -> NetrouteisisModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_model_add(a : NetrouteisisModel, b : NetrouteisisModel) -> NetrouteisisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_model_copy(s : NetrouteisisModel) -> NetrouteisisModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_model_fill(s : NetrouteisisModel, v : Double) -> NetrouteisisModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_model_min(s : NetrouteisisModel) -> Double { @_common.min(s.data) }

pub fn net_route_isis_model_max(s : NetrouteisisModel) -> Double { @_common.max(s.data) }

pub fn net_route_isis_model_to_string(s : NetrouteisisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_layer_make(size : Int) -> NetrouteisisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_layer_len(s : NetrouteisisLayer) -> Int { s.size }

pub fn net_route_isis_layer_get(s : NetrouteisisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_layer_set(s : NetrouteisisLayer, i : Int, v : Double) -> NetrouteisisLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_layer_sum(s : NetrouteisisLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_layer_mean(s : NetrouteisisLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_layer_scale(s : NetrouteisisLayer, f : Double) -> NetrouteisisLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_layer_add(a : NetrouteisisLayer, b : NetrouteisisLayer) -> NetrouteisisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_layer_copy(s : NetrouteisisLayer) -> NetrouteisisLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_layer_fill(s : NetrouteisisLayer, v : Double) -> NetrouteisisLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_layer_min(s : NetrouteisisLayer) -> Double { @_common.min(s.data) }

pub fn net_route_isis_layer_max(s : NetrouteisisLayer) -> Double { @_common.max(s.data) }

pub fn net_route_isis_layer_to_string(s : NetrouteisisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_buffer_make(size : Int) -> NetrouteisisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_buffer_len(s : NetrouteisisBuffer) -> Int { s.size }

pub fn net_route_isis_buffer_get(s : NetrouteisisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_buffer_set(s : NetrouteisisBuffer, i : Int, v : Double) -> NetrouteisisBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_buffer_sum(s : NetrouteisisBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_buffer_mean(s : NetrouteisisBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_buffer_scale(s : NetrouteisisBuffer, f : Double) -> NetrouteisisBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_buffer_add(a : NetrouteisisBuffer, b : NetrouteisisBuffer) -> NetrouteisisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_buffer_copy(s : NetrouteisisBuffer) -> NetrouteisisBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_buffer_fill(s : NetrouteisisBuffer, v : Double) -> NetrouteisisBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_buffer_min(s : NetrouteisisBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_isis_buffer_max(s : NetrouteisisBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_isis_buffer_to_string(s : NetrouteisisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_cursor_make(size : Int) -> NetrouteisisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_cursor_len(s : NetrouteisisCursor) -> Int { s.size }

pub fn net_route_isis_cursor_get(s : NetrouteisisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_cursor_set(s : NetrouteisisCursor, i : Int, v : Double) -> NetrouteisisCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_cursor_sum(s : NetrouteisisCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_cursor_mean(s : NetrouteisisCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_cursor_scale(s : NetrouteisisCursor, f : Double) -> NetrouteisisCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_cursor_add(a : NetrouteisisCursor, b : NetrouteisisCursor) -> NetrouteisisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_cursor_copy(s : NetrouteisisCursor) -> NetrouteisisCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_cursor_fill(s : NetrouteisisCursor, v : Double) -> NetrouteisisCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_cursor_min(s : NetrouteisisCursor) -> Double { @_common.min(s.data) }

pub fn net_route_isis_cursor_max(s : NetrouteisisCursor) -> Double { @_common.max(s.data) }

pub fn net_route_isis_cursor_to_string(s : NetrouteisisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_view_make(size : Int) -> NetrouteisisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_view_len(s : NetrouteisisView) -> Int { s.size }

pub fn net_route_isis_view_get(s : NetrouteisisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_view_set(s : NetrouteisisView, i : Int, v : Double) -> NetrouteisisView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_view_sum(s : NetrouteisisView) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_view_mean(s : NetrouteisisView) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_view_scale(s : NetrouteisisView, f : Double) -> NetrouteisisView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_view_add(a : NetrouteisisView, b : NetrouteisisView) -> NetrouteisisView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_view_copy(s : NetrouteisisView) -> NetrouteisisView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_view_fill(s : NetrouteisisView, v : Double) -> NetrouteisisView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_view_min(s : NetrouteisisView) -> Double { @_common.min(s.data) }

pub fn net_route_isis_view_max(s : NetrouteisisView) -> Double { @_common.max(s.data) }

pub fn net_route_isis_view_to_string(s : NetrouteisisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_range_make(size : Int) -> NetrouteisisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_range_len(s : NetrouteisisRange) -> Int { s.size }

pub fn net_route_isis_range_get(s : NetrouteisisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_range_set(s : NetrouteisisRange, i : Int, v : Double) -> NetrouteisisRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_range_sum(s : NetrouteisisRange) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_range_mean(s : NetrouteisisRange) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_range_scale(s : NetrouteisisRange, f : Double) -> NetrouteisisRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_range_add(a : NetrouteisisRange, b : NetrouteisisRange) -> NetrouteisisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_range_copy(s : NetrouteisisRange) -> NetrouteisisRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_range_fill(s : NetrouteisisRange, v : Double) -> NetrouteisisRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_range_min(s : NetrouteisisRange) -> Double { @_common.min(s.data) }

pub fn net_route_isis_range_max(s : NetrouteisisRange) -> Double { @_common.max(s.data) }

pub fn net_route_isis_range_to_string(s : NetrouteisisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_slice_make(size : Int) -> NetrouteisisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_slice_len(s : NetrouteisisSlice) -> Int { s.size }

pub fn net_route_isis_slice_get(s : NetrouteisisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_slice_set(s : NetrouteisisSlice, i : Int, v : Double) -> NetrouteisisSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_isis_slice_sum(s : NetrouteisisSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_isis_slice_mean(s : NetrouteisisSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_isis_slice_scale(s : NetrouteisisSlice, f : Double) -> NetrouteisisSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_isis_slice_add(a : NetrouteisisSlice, b : NetrouteisisSlice) -> NetrouteisisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_isis_slice_copy(s : NetrouteisisSlice) -> NetrouteisisSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_isis_slice_fill(s : NetrouteisisSlice, v : Double) -> NetrouteisisSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_isis_slice_min(s : NetrouteisisSlice) -> Double { @_common.min(s.data) }

pub fn net_route_isis_slice_max(s : NetrouteisisSlice) -> Double { @_common.max(s.data) }

pub fn net_route_isis_slice_to_string(s : NetrouteisisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

