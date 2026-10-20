///===
/// extcore/net_route_dijkstra

pub(all) struct NetroutedijkstraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_dijkstra_make_point(x : Double, y : Double) -> NetroutedijkstraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_dijkstra_make_point3(x : Double, y : Double, z : Double) -> NetroutedijkstraPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutedijkstraPoint::x(self : NetroutedijkstraPoint) -> Double { self.x }

pub fn NetroutedijkstraPoint::y(self : NetroutedijkstraPoint) -> Double { self.y }

pub fn NetroutedijkstraPoint::z(self : NetroutedijkstraPoint) -> Double { self.z }

pub fn NetroutedijkstraPoint::label(self : NetroutedijkstraPoint) -> Int { self.label }

pub fn NetroutedijkstraPoint::dist(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutedijkstraPoint::add(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutedijkstraPoint::sub(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutedijkstraPoint::scale(self : NetroutedijkstraPoint, s : Double) -> NetroutedijkstraPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutedijkstraPoint::dot(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutedijkstraPoint::cross(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutedijkstraPoint::norm(self : NetroutedijkstraPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutedijkstraPoint::normalize(self : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutedijkstraPoint::negate(self : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutedijkstraPoint::mid(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutedijkstraPoint::lerp(self : NetroutedijkstraPoint, other : NetroutedijkstraPoint, t : Double) -> NetroutedijkstraPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutedijkstraPoint::to_string(self : NetroutedijkstraPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutedijkstraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_dijkstra_make_series(vals : Array[Double], name : String) -> NetroutedijkstraSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutedijkstraSeries::len(self : NetroutedijkstraSeries) -> Int { self.vals.length() }

pub fn NetroutedijkstraSeries::sum(self : NetroutedijkstraSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutedijkstraSeries::mean(self : NetroutedijkstraSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutedijkstraSeries::min(self : NetroutedijkstraSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutedijkstraSeries::max(self : NetroutedijkstraSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutedijkstraSeries::range(self : NetroutedijkstraSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutedijkstraSeries::variance(self : NetroutedijkstraSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutedijkstraSeries::std(self : NetroutedijkstraSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutedijkstraSeries::median(self : NetroutedijkstraSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutedijkstraSeries::scale(self : NetroutedijkstraSeries, f : Double) -> NetroutedijkstraSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutedijkstraSeries::add(self : NetroutedijkstraSeries, other : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutedijkstraSeries::sub(self : NetroutedijkstraSeries, other : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutedijkstraSeries::normalize(self : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutedijkstraSeries::cumsum(self : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutedijkstraSeries::to_string(self : NetroutedijkstraSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutedijkstraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_dijkstra_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutedijkstraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_dijkstra_matrix_identity(n : Int) -> NetroutedijkstraMatrix {
  let m = net_route_dijkstra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutedijkstraMatrix::get(self : NetroutedijkstraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutedijkstraMatrix::transpose(self : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  let result = net_route_dijkstra_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutedijkstraMatrix::add(self : NetroutedijkstraMatrix, other : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutedijkstraMatrix::scale(self : NetroutedijkstraMatrix, s : Double) -> NetroutedijkstraMatrix {
  let result = net_route_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutedijkstraMatrix::multiply(self : NetroutedijkstraMatrix, other : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  if self.cols != other.rows { return net_route_dijkstra_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_dijkstra_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutedijkstraMatrix::trace(self : NetroutedijkstraMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutedijkstraMatrix::det(self : NetroutedijkstraMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutedijkstraMatrix::norm(self : NetroutedijkstraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutedijkstraMatrix::to_string(self : NetroutedijkstraMatrix) -> String {
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

pub(all) struct NetroutedijkstraVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_dijkstra_make_vector(comps : Array[Double]) -> NetroutedijkstraVector {
  { comps, dim: comps.length() }
}

pub fn net_route_dijkstra_vector_zero(dim : Int) -> NetroutedijkstraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutedijkstraVector::add(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutedijkstraVector::sub(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutedijkstraVector::scale(self : NetroutedijkstraVector, s : Double) -> NetroutedijkstraVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutedijkstraVector::dot(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutedijkstraVector::norm(self : NetroutedijkstraVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutedijkstraVector::normalize(self : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutedijkstraVector::dist(self : NetroutedijkstraVector, other : NetroutedijkstraVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutedijkstraVector::to_string(self : NetroutedijkstraVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_dijkstra_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_dijkstra_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_dijkstra_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_dijkstra_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_dijkstra_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_dijkstra_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_dijkstra_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_dijkstra_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_dijkstra_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_dijkstra_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_dijkstra_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_dijkstra_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_dijkstra_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_dijkstra_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_dijkstra_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_dijkstra_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_dijkstra_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_dijkstra_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_dijkstra_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_dijkstra_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_dijkstra_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_dijkstra_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_dijkstra_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_dijkstra_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_dijkstra_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_dijkstra_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_dijkstra_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_dijkstra_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_dijkstra_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutedijkstraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_frame_make(size : Int) -> NetroutedijkstraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_frame_len(s : NetroutedijkstraFrame) -> Int { s.size }

pub fn net_route_dijkstra_frame_get(s : NetroutedijkstraFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_frame_set(s : NetroutedijkstraFrame, i : Int, v : Double) -> NetroutedijkstraFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_frame_sum(s : NetroutedijkstraFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_frame_mean(s : NetroutedijkstraFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_frame_scale(s : NetroutedijkstraFrame, f : Double) -> NetroutedijkstraFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_frame_add(a : NetroutedijkstraFrame, b : NetroutedijkstraFrame) -> NetroutedijkstraFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_frame_copy(s : NetroutedijkstraFrame) -> NetroutedijkstraFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_frame_fill(s : NetroutedijkstraFrame, v : Double) -> NetroutedijkstraFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_frame_min(s : NetroutedijkstraFrame) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_frame_max(s : NetroutedijkstraFrame) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_frame_to_string(s : NetroutedijkstraFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_table_make(size : Int) -> NetroutedijkstraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_table_len(s : NetroutedijkstraTable) -> Int { s.size }

pub fn net_route_dijkstra_table_get(s : NetroutedijkstraTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_table_set(s : NetroutedijkstraTable, i : Int, v : Double) -> NetroutedijkstraTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_table_sum(s : NetroutedijkstraTable) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_table_mean(s : NetroutedijkstraTable) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_table_scale(s : NetroutedijkstraTable, f : Double) -> NetroutedijkstraTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_table_add(a : NetroutedijkstraTable, b : NetroutedijkstraTable) -> NetroutedijkstraTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_table_copy(s : NetroutedijkstraTable) -> NetroutedijkstraTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_table_fill(s : NetroutedijkstraTable, v : Double) -> NetroutedijkstraTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_table_min(s : NetroutedijkstraTable) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_table_max(s : NetroutedijkstraTable) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_table_to_string(s : NetroutedijkstraTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_graphn_make(size : Int) -> NetroutedijkstraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_graphn_len(s : NetroutedijkstraGraphN) -> Int { s.size }

pub fn net_route_dijkstra_graphn_get(s : NetroutedijkstraGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_graphn_set(s : NetroutedijkstraGraphN, i : Int, v : Double) -> NetroutedijkstraGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_graphn_sum(s : NetroutedijkstraGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_graphn_mean(s : NetroutedijkstraGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_graphn_scale(s : NetroutedijkstraGraphN, f : Double) -> NetroutedijkstraGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_graphn_add(a : NetroutedijkstraGraphN, b : NetroutedijkstraGraphN) -> NetroutedijkstraGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_graphn_copy(s : NetroutedijkstraGraphN) -> NetroutedijkstraGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_graphn_fill(s : NetroutedijkstraGraphN, v : Double) -> NetroutedijkstraGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_graphn_min(s : NetroutedijkstraGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_graphn_max(s : NetroutedijkstraGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_graphn_to_string(s : NetroutedijkstraGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_node_make(size : Int) -> NetroutedijkstraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_node_len(s : NetroutedijkstraNode) -> Int { s.size }

pub fn net_route_dijkstra_node_get(s : NetroutedijkstraNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_node_set(s : NetroutedijkstraNode, i : Int, v : Double) -> NetroutedijkstraNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_node_sum(s : NetroutedijkstraNode) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_node_mean(s : NetroutedijkstraNode) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_node_scale(s : NetroutedijkstraNode, f : Double) -> NetroutedijkstraNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_node_add(a : NetroutedijkstraNode, b : NetroutedijkstraNode) -> NetroutedijkstraNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_node_copy(s : NetroutedijkstraNode) -> NetroutedijkstraNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_node_fill(s : NetroutedijkstraNode, v : Double) -> NetroutedijkstraNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_node_min(s : NetroutedijkstraNode) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_node_max(s : NetroutedijkstraNode) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_node_to_string(s : NetroutedijkstraNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_edge_make(size : Int) -> NetroutedijkstraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_edge_len(s : NetroutedijkstraEdge) -> Int { s.size }

pub fn net_route_dijkstra_edge_get(s : NetroutedijkstraEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_edge_set(s : NetroutedijkstraEdge, i : Int, v : Double) -> NetroutedijkstraEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_edge_sum(s : NetroutedijkstraEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_edge_mean(s : NetroutedijkstraEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_edge_scale(s : NetroutedijkstraEdge, f : Double) -> NetroutedijkstraEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_edge_add(a : NetroutedijkstraEdge, b : NetroutedijkstraEdge) -> NetroutedijkstraEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_edge_copy(s : NetroutedijkstraEdge) -> NetroutedijkstraEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_edge_fill(s : NetroutedijkstraEdge, v : Double) -> NetroutedijkstraEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_edge_min(s : NetroutedijkstraEdge) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_edge_max(s : NetroutedijkstraEdge) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_edge_to_string(s : NetroutedijkstraEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_path_make(size : Int) -> NetroutedijkstraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_path_len(s : NetroutedijkstraPath) -> Int { s.size }

pub fn net_route_dijkstra_path_get(s : NetroutedijkstraPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_path_set(s : NetroutedijkstraPath, i : Int, v : Double) -> NetroutedijkstraPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_path_sum(s : NetroutedijkstraPath) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_path_mean(s : NetroutedijkstraPath) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_path_scale(s : NetroutedijkstraPath, f : Double) -> NetroutedijkstraPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_path_add(a : NetroutedijkstraPath, b : NetroutedijkstraPath) -> NetroutedijkstraPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_path_copy(s : NetroutedijkstraPath) -> NetroutedijkstraPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_path_fill(s : NetroutedijkstraPath, v : Double) -> NetroutedijkstraPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_path_min(s : NetroutedijkstraPath) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_path_max(s : NetroutedijkstraPath) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_path_to_string(s : NetroutedijkstraPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_cluster_make(size : Int) -> NetroutedijkstraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_cluster_len(s : NetroutedijkstraCluster) -> Int { s.size }

pub fn net_route_dijkstra_cluster_get(s : NetroutedijkstraCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_cluster_set(s : NetroutedijkstraCluster, i : Int, v : Double) -> NetroutedijkstraCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cluster_sum(s : NetroutedijkstraCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_cluster_mean(s : NetroutedijkstraCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_cluster_scale(s : NetroutedijkstraCluster, f : Double) -> NetroutedijkstraCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cluster_add(a : NetroutedijkstraCluster, b : NetroutedijkstraCluster) -> NetroutedijkstraCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_cluster_copy(s : NetroutedijkstraCluster) -> NetroutedijkstraCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cluster_fill(s : NetroutedijkstraCluster, v : Double) -> NetroutedijkstraCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cluster_min(s : NetroutedijkstraCluster) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_cluster_max(s : NetroutedijkstraCluster) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_cluster_to_string(s : NetroutedijkstraCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_model_make(size : Int) -> NetroutedijkstraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_model_len(s : NetroutedijkstraModel) -> Int { s.size }

pub fn net_route_dijkstra_model_get(s : NetroutedijkstraModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_model_set(s : NetroutedijkstraModel, i : Int, v : Double) -> NetroutedijkstraModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_model_sum(s : NetroutedijkstraModel) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_model_mean(s : NetroutedijkstraModel) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_model_scale(s : NetroutedijkstraModel, f : Double) -> NetroutedijkstraModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_model_add(a : NetroutedijkstraModel, b : NetroutedijkstraModel) -> NetroutedijkstraModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_model_copy(s : NetroutedijkstraModel) -> NetroutedijkstraModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_model_fill(s : NetroutedijkstraModel, v : Double) -> NetroutedijkstraModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_model_min(s : NetroutedijkstraModel) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_model_max(s : NetroutedijkstraModel) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_model_to_string(s : NetroutedijkstraModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_layer_make(size : Int) -> NetroutedijkstraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_layer_len(s : NetroutedijkstraLayer) -> Int { s.size }

pub fn net_route_dijkstra_layer_get(s : NetroutedijkstraLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_layer_set(s : NetroutedijkstraLayer, i : Int, v : Double) -> NetroutedijkstraLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_layer_sum(s : NetroutedijkstraLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_layer_mean(s : NetroutedijkstraLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_layer_scale(s : NetroutedijkstraLayer, f : Double) -> NetroutedijkstraLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_layer_add(a : NetroutedijkstraLayer, b : NetroutedijkstraLayer) -> NetroutedijkstraLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_layer_copy(s : NetroutedijkstraLayer) -> NetroutedijkstraLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_layer_fill(s : NetroutedijkstraLayer, v : Double) -> NetroutedijkstraLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_layer_min(s : NetroutedijkstraLayer) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_layer_max(s : NetroutedijkstraLayer) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_layer_to_string(s : NetroutedijkstraLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_buffer_make(size : Int) -> NetroutedijkstraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_buffer_len(s : NetroutedijkstraBuffer) -> Int { s.size }

pub fn net_route_dijkstra_buffer_get(s : NetroutedijkstraBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_buffer_set(s : NetroutedijkstraBuffer, i : Int, v : Double) -> NetroutedijkstraBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_buffer_sum(s : NetroutedijkstraBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_buffer_mean(s : NetroutedijkstraBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_buffer_scale(s : NetroutedijkstraBuffer, f : Double) -> NetroutedijkstraBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_buffer_add(a : NetroutedijkstraBuffer, b : NetroutedijkstraBuffer) -> NetroutedijkstraBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_buffer_copy(s : NetroutedijkstraBuffer) -> NetroutedijkstraBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_buffer_fill(s : NetroutedijkstraBuffer, v : Double) -> NetroutedijkstraBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_buffer_min(s : NetroutedijkstraBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_buffer_max(s : NetroutedijkstraBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_buffer_to_string(s : NetroutedijkstraBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_cursor_make(size : Int) -> NetroutedijkstraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_cursor_len(s : NetroutedijkstraCursor) -> Int { s.size }

pub fn net_route_dijkstra_cursor_get(s : NetroutedijkstraCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_cursor_set(s : NetroutedijkstraCursor, i : Int, v : Double) -> NetroutedijkstraCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cursor_sum(s : NetroutedijkstraCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_cursor_mean(s : NetroutedijkstraCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_cursor_scale(s : NetroutedijkstraCursor, f : Double) -> NetroutedijkstraCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cursor_add(a : NetroutedijkstraCursor, b : NetroutedijkstraCursor) -> NetroutedijkstraCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_cursor_copy(s : NetroutedijkstraCursor) -> NetroutedijkstraCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cursor_fill(s : NetroutedijkstraCursor, v : Double) -> NetroutedijkstraCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_cursor_min(s : NetroutedijkstraCursor) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_cursor_max(s : NetroutedijkstraCursor) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_cursor_to_string(s : NetroutedijkstraCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_view_make(size : Int) -> NetroutedijkstraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_view_len(s : NetroutedijkstraView) -> Int { s.size }

pub fn net_route_dijkstra_view_get(s : NetroutedijkstraView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_view_set(s : NetroutedijkstraView, i : Int, v : Double) -> NetroutedijkstraView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_view_sum(s : NetroutedijkstraView) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_view_mean(s : NetroutedijkstraView) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_view_scale(s : NetroutedijkstraView, f : Double) -> NetroutedijkstraView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_view_add(a : NetroutedijkstraView, b : NetroutedijkstraView) -> NetroutedijkstraView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_view_copy(s : NetroutedijkstraView) -> NetroutedijkstraView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_view_fill(s : NetroutedijkstraView, v : Double) -> NetroutedijkstraView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_view_min(s : NetroutedijkstraView) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_view_max(s : NetroutedijkstraView) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_view_to_string(s : NetroutedijkstraView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_range_make(size : Int) -> NetroutedijkstraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_range_len(s : NetroutedijkstraRange) -> Int { s.size }

pub fn net_route_dijkstra_range_get(s : NetroutedijkstraRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_range_set(s : NetroutedijkstraRange, i : Int, v : Double) -> NetroutedijkstraRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_range_sum(s : NetroutedijkstraRange) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_range_mean(s : NetroutedijkstraRange) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_range_scale(s : NetroutedijkstraRange, f : Double) -> NetroutedijkstraRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_range_add(a : NetroutedijkstraRange, b : NetroutedijkstraRange) -> NetroutedijkstraRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_range_copy(s : NetroutedijkstraRange) -> NetroutedijkstraRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_range_fill(s : NetroutedijkstraRange, v : Double) -> NetroutedijkstraRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_range_min(s : NetroutedijkstraRange) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_range_max(s : NetroutedijkstraRange) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_range_to_string(s : NetroutedijkstraRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_slice_make(size : Int) -> NetroutedijkstraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_slice_len(s : NetroutedijkstraSlice) -> Int { s.size }

pub fn net_route_dijkstra_slice_get(s : NetroutedijkstraSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_slice_set(s : NetroutedijkstraSlice, i : Int, v : Double) -> NetroutedijkstraSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_slice_sum(s : NetroutedijkstraSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_slice_mean(s : NetroutedijkstraSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_slice_scale(s : NetroutedijkstraSlice, f : Double) -> NetroutedijkstraSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_slice_add(a : NetroutedijkstraSlice, b : NetroutedijkstraSlice) -> NetroutedijkstraSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_dijkstra_slice_copy(s : NetroutedijkstraSlice) -> NetroutedijkstraSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_slice_fill(s : NetroutedijkstraSlice, v : Double) -> NetroutedijkstraSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_dijkstra_slice_min(s : NetroutedijkstraSlice) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_slice_max(s : NetroutedijkstraSlice) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_slice_to_string(s : NetroutedijkstraSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

