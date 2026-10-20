///===
/// extcore/graph_connect_biconnect

pub(all) struct GraphconnectbiconnectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_biconnect_make_point(x : Double, y : Double) -> GraphconnectbiconnectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_biconnect_make_point3(x : Double, y : Double, z : Double) -> GraphconnectbiconnectPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectbiconnectPoint::x(self : GraphconnectbiconnectPoint) -> Double { self.x }

pub fn GraphconnectbiconnectPoint::y(self : GraphconnectbiconnectPoint) -> Double { self.y }

pub fn GraphconnectbiconnectPoint::z(self : GraphconnectbiconnectPoint) -> Double { self.z }

pub fn GraphconnectbiconnectPoint::label(self : GraphconnectbiconnectPoint) -> Int { self.label }

pub fn GraphconnectbiconnectPoint::dist(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectbiconnectPoint::add(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectbiconnectPoint::sub(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectbiconnectPoint::scale(self : GraphconnectbiconnectPoint, s : Double) -> GraphconnectbiconnectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectbiconnectPoint::dot(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectbiconnectPoint::cross(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectbiconnectPoint::norm(self : GraphconnectbiconnectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectbiconnectPoint::normalize(self : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectbiconnectPoint::negate(self : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectbiconnectPoint::mid(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectbiconnectPoint::lerp(self : GraphconnectbiconnectPoint, other : GraphconnectbiconnectPoint, t : Double) -> GraphconnectbiconnectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectbiconnectPoint::to_string(self : GraphconnectbiconnectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_biconnect_make_series(vals : Array[Double], name : String) -> GraphconnectbiconnectSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectbiconnectSeries::len(self : GraphconnectbiconnectSeries) -> Int { self.vals.length() }

pub fn GraphconnectbiconnectSeries::sum(self : GraphconnectbiconnectSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectbiconnectSeries::mean(self : GraphconnectbiconnectSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectbiconnectSeries::min(self : GraphconnectbiconnectSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectbiconnectSeries::max(self : GraphconnectbiconnectSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectbiconnectSeries::range(self : GraphconnectbiconnectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectbiconnectSeries::variance(self : GraphconnectbiconnectSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectbiconnectSeries::std(self : GraphconnectbiconnectSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectbiconnectSeries::median(self : GraphconnectbiconnectSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectbiconnectSeries::scale(self : GraphconnectbiconnectSeries, f : Double) -> GraphconnectbiconnectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectbiconnectSeries::add(self : GraphconnectbiconnectSeries, other : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectbiconnectSeries::sub(self : GraphconnectbiconnectSeries, other : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectbiconnectSeries::normalize(self : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectbiconnectSeries::cumsum(self : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectbiconnectSeries::to_string(self : GraphconnectbiconnectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectbiconnectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_biconnect_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectbiconnectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_biconnect_matrix_identity(n : Int) -> GraphconnectbiconnectMatrix {
  let m = graph_connect_biconnect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectbiconnectMatrix::get(self : GraphconnectbiconnectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectbiconnectMatrix::transpose(self : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectbiconnectMatrix::add(self : GraphconnectbiconnectMatrix, other : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_biconnect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectbiconnectMatrix::scale(self : GraphconnectbiconnectMatrix, s : Double) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectbiconnectMatrix::multiply(self : GraphconnectbiconnectMatrix, other : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  if self.cols != other.rows { return graph_connect_biconnect_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_biconnect_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectbiconnectMatrix::trace(self : GraphconnectbiconnectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectbiconnectMatrix::det(self : GraphconnectbiconnectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectbiconnectMatrix::norm(self : GraphconnectbiconnectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectbiconnectMatrix::to_string(self : GraphconnectbiconnectMatrix) -> String {
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

pub(all) struct GraphconnectbiconnectVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_biconnect_make_vector(comps : Array[Double]) -> GraphconnectbiconnectVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_biconnect_vector_zero(dim : Int) -> GraphconnectbiconnectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectbiconnectVector::add(self : GraphconnectbiconnectVector, other : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectbiconnectVector::sub(self : GraphconnectbiconnectVector, other : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectbiconnectVector::scale(self : GraphconnectbiconnectVector, s : Double) -> GraphconnectbiconnectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectbiconnectVector::dot(self : GraphconnectbiconnectVector, other : GraphconnectbiconnectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectbiconnectVector::norm(self : GraphconnectbiconnectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectbiconnectVector::normalize(self : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectbiconnectVector::dist(self : GraphconnectbiconnectVector, other : GraphconnectbiconnectVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectbiconnectVector::to_string(self : GraphconnectbiconnectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_biconnect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_biconnect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_biconnect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_biconnect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_biconnect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_biconnect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_biconnect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_biconnect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_biconnect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_biconnect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_biconnect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_biconnect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_biconnect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_biconnect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_biconnect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_biconnect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_biconnect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_biconnect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_biconnect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_biconnect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_biconnect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_biconnect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_biconnect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_biconnect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_biconnect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_biconnect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_biconnect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_biconnect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_biconnect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectbiconnectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_frame_make(size : Int) -> GraphconnectbiconnectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_frame_len(s : GraphconnectbiconnectFrame) -> Int { s.size }

pub fn graph_connect_biconnect_frame_get(s : GraphconnectbiconnectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_frame_set(s : GraphconnectbiconnectFrame, i : Int, v : Double) -> GraphconnectbiconnectFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_sum(s : GraphconnectbiconnectFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_frame_mean(s : GraphconnectbiconnectFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_frame_scale(s : GraphconnectbiconnectFrame, f : Double) -> GraphconnectbiconnectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_add(a : GraphconnectbiconnectFrame, b : GraphconnectbiconnectFrame) -> GraphconnectbiconnectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_frame_copy(s : GraphconnectbiconnectFrame) -> GraphconnectbiconnectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_fill(s : GraphconnectbiconnectFrame, v : Double) -> GraphconnectbiconnectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_min(s : GraphconnectbiconnectFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_frame_max(s : GraphconnectbiconnectFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_frame_to_string(s : GraphconnectbiconnectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_table_make(size : Int) -> GraphconnectbiconnectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_table_len(s : GraphconnectbiconnectTable) -> Int { s.size }

pub fn graph_connect_biconnect_table_get(s : GraphconnectbiconnectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_table_set(s : GraphconnectbiconnectTable, i : Int, v : Double) -> GraphconnectbiconnectTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_sum(s : GraphconnectbiconnectTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_table_mean(s : GraphconnectbiconnectTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_table_scale(s : GraphconnectbiconnectTable, f : Double) -> GraphconnectbiconnectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_add(a : GraphconnectbiconnectTable, b : GraphconnectbiconnectTable) -> GraphconnectbiconnectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_table_copy(s : GraphconnectbiconnectTable) -> GraphconnectbiconnectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_fill(s : GraphconnectbiconnectTable, v : Double) -> GraphconnectbiconnectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_min(s : GraphconnectbiconnectTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_table_max(s : GraphconnectbiconnectTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_table_to_string(s : GraphconnectbiconnectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_graphn_make(size : Int) -> GraphconnectbiconnectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_graphn_len(s : GraphconnectbiconnectGraphN) -> Int { s.size }

pub fn graph_connect_biconnect_graphn_get(s : GraphconnectbiconnectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_graphn_set(s : GraphconnectbiconnectGraphN, i : Int, v : Double) -> GraphconnectbiconnectGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_sum(s : GraphconnectbiconnectGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_graphn_mean(s : GraphconnectbiconnectGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_graphn_scale(s : GraphconnectbiconnectGraphN, f : Double) -> GraphconnectbiconnectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_add(a : GraphconnectbiconnectGraphN, b : GraphconnectbiconnectGraphN) -> GraphconnectbiconnectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_graphn_copy(s : GraphconnectbiconnectGraphN) -> GraphconnectbiconnectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_fill(s : GraphconnectbiconnectGraphN, v : Double) -> GraphconnectbiconnectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_min(s : GraphconnectbiconnectGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_graphn_max(s : GraphconnectbiconnectGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_graphn_to_string(s : GraphconnectbiconnectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_node_make(size : Int) -> GraphconnectbiconnectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_node_len(s : GraphconnectbiconnectNode) -> Int { s.size }

pub fn graph_connect_biconnect_node_get(s : GraphconnectbiconnectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_node_set(s : GraphconnectbiconnectNode, i : Int, v : Double) -> GraphconnectbiconnectNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_sum(s : GraphconnectbiconnectNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_node_mean(s : GraphconnectbiconnectNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_node_scale(s : GraphconnectbiconnectNode, f : Double) -> GraphconnectbiconnectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_add(a : GraphconnectbiconnectNode, b : GraphconnectbiconnectNode) -> GraphconnectbiconnectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_node_copy(s : GraphconnectbiconnectNode) -> GraphconnectbiconnectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_fill(s : GraphconnectbiconnectNode, v : Double) -> GraphconnectbiconnectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_min(s : GraphconnectbiconnectNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_node_max(s : GraphconnectbiconnectNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_node_to_string(s : GraphconnectbiconnectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_edge_make(size : Int) -> GraphconnectbiconnectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_edge_len(s : GraphconnectbiconnectEdge) -> Int { s.size }

pub fn graph_connect_biconnect_edge_get(s : GraphconnectbiconnectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_edge_set(s : GraphconnectbiconnectEdge, i : Int, v : Double) -> GraphconnectbiconnectEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_sum(s : GraphconnectbiconnectEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_edge_mean(s : GraphconnectbiconnectEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_edge_scale(s : GraphconnectbiconnectEdge, f : Double) -> GraphconnectbiconnectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_add(a : GraphconnectbiconnectEdge, b : GraphconnectbiconnectEdge) -> GraphconnectbiconnectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_edge_copy(s : GraphconnectbiconnectEdge) -> GraphconnectbiconnectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_fill(s : GraphconnectbiconnectEdge, v : Double) -> GraphconnectbiconnectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_min(s : GraphconnectbiconnectEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_edge_max(s : GraphconnectbiconnectEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_edge_to_string(s : GraphconnectbiconnectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_path_make(size : Int) -> GraphconnectbiconnectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_path_len(s : GraphconnectbiconnectPath) -> Int { s.size }

pub fn graph_connect_biconnect_path_get(s : GraphconnectbiconnectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_path_set(s : GraphconnectbiconnectPath, i : Int, v : Double) -> GraphconnectbiconnectPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_sum(s : GraphconnectbiconnectPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_path_mean(s : GraphconnectbiconnectPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_path_scale(s : GraphconnectbiconnectPath, f : Double) -> GraphconnectbiconnectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_add(a : GraphconnectbiconnectPath, b : GraphconnectbiconnectPath) -> GraphconnectbiconnectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_path_copy(s : GraphconnectbiconnectPath) -> GraphconnectbiconnectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_fill(s : GraphconnectbiconnectPath, v : Double) -> GraphconnectbiconnectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_min(s : GraphconnectbiconnectPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_path_max(s : GraphconnectbiconnectPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_path_to_string(s : GraphconnectbiconnectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_cluster_make(size : Int) -> GraphconnectbiconnectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_cluster_len(s : GraphconnectbiconnectCluster) -> Int { s.size }

pub fn graph_connect_biconnect_cluster_get(s : GraphconnectbiconnectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_cluster_set(s : GraphconnectbiconnectCluster, i : Int, v : Double) -> GraphconnectbiconnectCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_sum(s : GraphconnectbiconnectCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_cluster_mean(s : GraphconnectbiconnectCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_cluster_scale(s : GraphconnectbiconnectCluster, f : Double) -> GraphconnectbiconnectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_add(a : GraphconnectbiconnectCluster, b : GraphconnectbiconnectCluster) -> GraphconnectbiconnectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_cluster_copy(s : GraphconnectbiconnectCluster) -> GraphconnectbiconnectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_fill(s : GraphconnectbiconnectCluster, v : Double) -> GraphconnectbiconnectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_min(s : GraphconnectbiconnectCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_cluster_max(s : GraphconnectbiconnectCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_cluster_to_string(s : GraphconnectbiconnectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_model_make(size : Int) -> GraphconnectbiconnectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_model_len(s : GraphconnectbiconnectModel) -> Int { s.size }

pub fn graph_connect_biconnect_model_get(s : GraphconnectbiconnectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_model_set(s : GraphconnectbiconnectModel, i : Int, v : Double) -> GraphconnectbiconnectModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_sum(s : GraphconnectbiconnectModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_model_mean(s : GraphconnectbiconnectModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_model_scale(s : GraphconnectbiconnectModel, f : Double) -> GraphconnectbiconnectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_add(a : GraphconnectbiconnectModel, b : GraphconnectbiconnectModel) -> GraphconnectbiconnectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_model_copy(s : GraphconnectbiconnectModel) -> GraphconnectbiconnectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_fill(s : GraphconnectbiconnectModel, v : Double) -> GraphconnectbiconnectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_min(s : GraphconnectbiconnectModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_model_max(s : GraphconnectbiconnectModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_model_to_string(s : GraphconnectbiconnectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_layer_make(size : Int) -> GraphconnectbiconnectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_layer_len(s : GraphconnectbiconnectLayer) -> Int { s.size }

pub fn graph_connect_biconnect_layer_get(s : GraphconnectbiconnectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_layer_set(s : GraphconnectbiconnectLayer, i : Int, v : Double) -> GraphconnectbiconnectLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_sum(s : GraphconnectbiconnectLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_layer_mean(s : GraphconnectbiconnectLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_layer_scale(s : GraphconnectbiconnectLayer, f : Double) -> GraphconnectbiconnectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_add(a : GraphconnectbiconnectLayer, b : GraphconnectbiconnectLayer) -> GraphconnectbiconnectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_layer_copy(s : GraphconnectbiconnectLayer) -> GraphconnectbiconnectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_fill(s : GraphconnectbiconnectLayer, v : Double) -> GraphconnectbiconnectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_min(s : GraphconnectbiconnectLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_layer_max(s : GraphconnectbiconnectLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_layer_to_string(s : GraphconnectbiconnectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_buffer_make(size : Int) -> GraphconnectbiconnectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_buffer_len(s : GraphconnectbiconnectBuffer) -> Int { s.size }

pub fn graph_connect_biconnect_buffer_get(s : GraphconnectbiconnectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_buffer_set(s : GraphconnectbiconnectBuffer, i : Int, v : Double) -> GraphconnectbiconnectBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_sum(s : GraphconnectbiconnectBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_buffer_mean(s : GraphconnectbiconnectBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_buffer_scale(s : GraphconnectbiconnectBuffer, f : Double) -> GraphconnectbiconnectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_add(a : GraphconnectbiconnectBuffer, b : GraphconnectbiconnectBuffer) -> GraphconnectbiconnectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_buffer_copy(s : GraphconnectbiconnectBuffer) -> GraphconnectbiconnectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_fill(s : GraphconnectbiconnectBuffer, v : Double) -> GraphconnectbiconnectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_min(s : GraphconnectbiconnectBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_buffer_max(s : GraphconnectbiconnectBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_buffer_to_string(s : GraphconnectbiconnectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_cursor_make(size : Int) -> GraphconnectbiconnectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_cursor_len(s : GraphconnectbiconnectCursor) -> Int { s.size }

pub fn graph_connect_biconnect_cursor_get(s : GraphconnectbiconnectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_cursor_set(s : GraphconnectbiconnectCursor, i : Int, v : Double) -> GraphconnectbiconnectCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_sum(s : GraphconnectbiconnectCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_cursor_mean(s : GraphconnectbiconnectCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_cursor_scale(s : GraphconnectbiconnectCursor, f : Double) -> GraphconnectbiconnectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_add(a : GraphconnectbiconnectCursor, b : GraphconnectbiconnectCursor) -> GraphconnectbiconnectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_cursor_copy(s : GraphconnectbiconnectCursor) -> GraphconnectbiconnectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_fill(s : GraphconnectbiconnectCursor, v : Double) -> GraphconnectbiconnectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_min(s : GraphconnectbiconnectCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_cursor_max(s : GraphconnectbiconnectCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_cursor_to_string(s : GraphconnectbiconnectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_view_make(size : Int) -> GraphconnectbiconnectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_view_len(s : GraphconnectbiconnectView) -> Int { s.size }

pub fn graph_connect_biconnect_view_get(s : GraphconnectbiconnectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_view_set(s : GraphconnectbiconnectView, i : Int, v : Double) -> GraphconnectbiconnectView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_sum(s : GraphconnectbiconnectView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_view_mean(s : GraphconnectbiconnectView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_view_scale(s : GraphconnectbiconnectView, f : Double) -> GraphconnectbiconnectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_add(a : GraphconnectbiconnectView, b : GraphconnectbiconnectView) -> GraphconnectbiconnectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_view_copy(s : GraphconnectbiconnectView) -> GraphconnectbiconnectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_fill(s : GraphconnectbiconnectView, v : Double) -> GraphconnectbiconnectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_min(s : GraphconnectbiconnectView) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_view_max(s : GraphconnectbiconnectView) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_view_to_string(s : GraphconnectbiconnectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_range_make(size : Int) -> GraphconnectbiconnectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_range_len(s : GraphconnectbiconnectRange) -> Int { s.size }

pub fn graph_connect_biconnect_range_get(s : GraphconnectbiconnectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_range_set(s : GraphconnectbiconnectRange, i : Int, v : Double) -> GraphconnectbiconnectRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_sum(s : GraphconnectbiconnectRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_range_mean(s : GraphconnectbiconnectRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_range_scale(s : GraphconnectbiconnectRange, f : Double) -> GraphconnectbiconnectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_add(a : GraphconnectbiconnectRange, b : GraphconnectbiconnectRange) -> GraphconnectbiconnectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_range_copy(s : GraphconnectbiconnectRange) -> GraphconnectbiconnectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_fill(s : GraphconnectbiconnectRange, v : Double) -> GraphconnectbiconnectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_min(s : GraphconnectbiconnectRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_range_max(s : GraphconnectbiconnectRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_range_to_string(s : GraphconnectbiconnectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_slice_make(size : Int) -> GraphconnectbiconnectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_slice_len(s : GraphconnectbiconnectSlice) -> Int { s.size }

pub fn graph_connect_biconnect_slice_get(s : GraphconnectbiconnectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_slice_set(s : GraphconnectbiconnectSlice, i : Int, v : Double) -> GraphconnectbiconnectSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_sum(s : GraphconnectbiconnectSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_slice_mean(s : GraphconnectbiconnectSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_slice_scale(s : GraphconnectbiconnectSlice, f : Double) -> GraphconnectbiconnectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_add(a : GraphconnectbiconnectSlice, b : GraphconnectbiconnectSlice) -> GraphconnectbiconnectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_slice_copy(s : GraphconnectbiconnectSlice) -> GraphconnectbiconnectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_fill(s : GraphconnectbiconnectSlice, v : Double) -> GraphconnectbiconnectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_min(s : GraphconnectbiconnectSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_slice_max(s : GraphconnectbiconnectSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_slice_to_string(s : GraphconnectbiconnectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

