///===
/// extcore/ds_graph_multi

pub(all) struct DsgraphmultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_multi_make_point(x : Double, y : Double) -> DsgraphmultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_multi_make_point3(x : Double, y : Double, z : Double) -> DsgraphmultiPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphmultiPoint::x(self : DsgraphmultiPoint) -> Double { self.x }

pub fn DsgraphmultiPoint::y(self : DsgraphmultiPoint) -> Double { self.y }

pub fn DsgraphmultiPoint::z(self : DsgraphmultiPoint) -> Double { self.z }

pub fn DsgraphmultiPoint::label(self : DsgraphmultiPoint) -> Int { self.label }

pub fn DsgraphmultiPoint::dist(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphmultiPoint::add(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphmultiPoint::sub(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphmultiPoint::scale(self : DsgraphmultiPoint, s : Double) -> DsgraphmultiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphmultiPoint::dot(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphmultiPoint::cross(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphmultiPoint::norm(self : DsgraphmultiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphmultiPoint::normalize(self : DsgraphmultiPoint) -> DsgraphmultiPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphmultiPoint::negate(self : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphmultiPoint::mid(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphmultiPoint::lerp(self : DsgraphmultiPoint, other : DsgraphmultiPoint, t : Double) -> DsgraphmultiPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphmultiPoint::to_string(self : DsgraphmultiPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphmultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_multi_make_series(vals : Array[Double], name : String) -> DsgraphmultiSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphmultiSeries::len(self : DsgraphmultiSeries) -> Int { self.vals.length() }

pub fn DsgraphmultiSeries::sum(self : DsgraphmultiSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphmultiSeries::mean(self : DsgraphmultiSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphmultiSeries::min(self : DsgraphmultiSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphmultiSeries::max(self : DsgraphmultiSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphmultiSeries::range(self : DsgraphmultiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphmultiSeries::variance(self : DsgraphmultiSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphmultiSeries::std(self : DsgraphmultiSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphmultiSeries::median(self : DsgraphmultiSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphmultiSeries::scale(self : DsgraphmultiSeries, f : Double) -> DsgraphmultiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphmultiSeries::add(self : DsgraphmultiSeries, other : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphmultiSeries::sub(self : DsgraphmultiSeries, other : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphmultiSeries::normalize(self : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphmultiSeries::cumsum(self : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphmultiSeries::to_string(self : DsgraphmultiSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphmultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_multi_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphmultiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_multi_matrix_identity(n : Int) -> DsgraphmultiMatrix {
  let m = ds_graph_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphmultiMatrix::get(self : DsgraphmultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphmultiMatrix::transpose(self : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphmultiMatrix::add(self : DsgraphmultiMatrix, other : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphmultiMatrix::scale(self : DsgraphmultiMatrix, s : Double) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphmultiMatrix::multiply(self : DsgraphmultiMatrix, other : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if self.cols != other.rows { return ds_graph_multi_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_multi_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphmultiMatrix::trace(self : DsgraphmultiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphmultiMatrix::det(self : DsgraphmultiMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphmultiMatrix::norm(self : DsgraphmultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphmultiMatrix::to_string(self : DsgraphmultiMatrix) -> String {
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

pub(all) struct DsgraphmultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_multi_make_vector(comps : Array[Double]) -> DsgraphmultiVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_multi_vector_zero(dim : Int) -> DsgraphmultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphmultiVector::add(self : DsgraphmultiVector, other : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphmultiVector::sub(self : DsgraphmultiVector, other : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphmultiVector::scale(self : DsgraphmultiVector, s : Double) -> DsgraphmultiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphmultiVector::dot(self : DsgraphmultiVector, other : DsgraphmultiVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphmultiVector::norm(self : DsgraphmultiVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphmultiVector::normalize(self : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphmultiVector::dist(self : DsgraphmultiVector, other : DsgraphmultiVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphmultiVector::to_string(self : DsgraphmultiVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_multi_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_multi_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_multi_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_multi_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_multi_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_multi_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_multi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_multi_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_multi_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_multi_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_multi_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_multi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_multi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_multi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_multi_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_multi_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_multi_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_multi_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_multi_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_multi_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_multi_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_multi_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_multi_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_multi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_multi_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_multi_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_multi_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_multi_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_multi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphmultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_frame_make(size : Int) -> DsgraphmultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_frame_len(s : DsgraphmultiFrame) -> Int { s.size }

pub fn ds_graph_multi_frame_get(s : DsgraphmultiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_frame_set(s : DsgraphmultiFrame, i : Int, v : Double) -> DsgraphmultiFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_frame_sum(s : DsgraphmultiFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_frame_mean(s : DsgraphmultiFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_frame_scale(s : DsgraphmultiFrame, f : Double) -> DsgraphmultiFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_frame_add(a : DsgraphmultiFrame, b : DsgraphmultiFrame) -> DsgraphmultiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_frame_copy(s : DsgraphmultiFrame) -> DsgraphmultiFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_frame_fill(s : DsgraphmultiFrame, v : Double) -> DsgraphmultiFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_frame_min(s : DsgraphmultiFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_frame_max(s : DsgraphmultiFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_frame_to_string(s : DsgraphmultiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_table_make(size : Int) -> DsgraphmultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_table_len(s : DsgraphmultiTable) -> Int { s.size }

pub fn ds_graph_multi_table_get(s : DsgraphmultiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_table_set(s : DsgraphmultiTable, i : Int, v : Double) -> DsgraphmultiTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_table_sum(s : DsgraphmultiTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_table_mean(s : DsgraphmultiTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_table_scale(s : DsgraphmultiTable, f : Double) -> DsgraphmultiTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_table_add(a : DsgraphmultiTable, b : DsgraphmultiTable) -> DsgraphmultiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_table_copy(s : DsgraphmultiTable) -> DsgraphmultiTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_table_fill(s : DsgraphmultiTable, v : Double) -> DsgraphmultiTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_table_min(s : DsgraphmultiTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_table_max(s : DsgraphmultiTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_table_to_string(s : DsgraphmultiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_graphn_make(size : Int) -> DsgraphmultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_graphn_len(s : DsgraphmultiGraphN) -> Int { s.size }

pub fn ds_graph_multi_graphn_get(s : DsgraphmultiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_graphn_set(s : DsgraphmultiGraphN, i : Int, v : Double) -> DsgraphmultiGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_graphn_sum(s : DsgraphmultiGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_graphn_mean(s : DsgraphmultiGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_graphn_scale(s : DsgraphmultiGraphN, f : Double) -> DsgraphmultiGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_graphn_add(a : DsgraphmultiGraphN, b : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_graphn_copy(s : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_graphn_fill(s : DsgraphmultiGraphN, v : Double) -> DsgraphmultiGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_graphn_min(s : DsgraphmultiGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_graphn_max(s : DsgraphmultiGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_graphn_to_string(s : DsgraphmultiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_node_make(size : Int) -> DsgraphmultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_node_len(s : DsgraphmultiNode) -> Int { s.size }

pub fn ds_graph_multi_node_get(s : DsgraphmultiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_node_set(s : DsgraphmultiNode, i : Int, v : Double) -> DsgraphmultiNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_node_sum(s : DsgraphmultiNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_node_mean(s : DsgraphmultiNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_node_scale(s : DsgraphmultiNode, f : Double) -> DsgraphmultiNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_node_add(a : DsgraphmultiNode, b : DsgraphmultiNode) -> DsgraphmultiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_node_copy(s : DsgraphmultiNode) -> DsgraphmultiNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_node_fill(s : DsgraphmultiNode, v : Double) -> DsgraphmultiNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_node_min(s : DsgraphmultiNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_node_max(s : DsgraphmultiNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_node_to_string(s : DsgraphmultiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_edge_make(size : Int) -> DsgraphmultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_edge_len(s : DsgraphmultiEdge) -> Int { s.size }

pub fn ds_graph_multi_edge_get(s : DsgraphmultiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_edge_set(s : DsgraphmultiEdge, i : Int, v : Double) -> DsgraphmultiEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_edge_sum(s : DsgraphmultiEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_edge_mean(s : DsgraphmultiEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_edge_scale(s : DsgraphmultiEdge, f : Double) -> DsgraphmultiEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_edge_add(a : DsgraphmultiEdge, b : DsgraphmultiEdge) -> DsgraphmultiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_edge_copy(s : DsgraphmultiEdge) -> DsgraphmultiEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_edge_fill(s : DsgraphmultiEdge, v : Double) -> DsgraphmultiEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_edge_min(s : DsgraphmultiEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_edge_max(s : DsgraphmultiEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_edge_to_string(s : DsgraphmultiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_path_make(size : Int) -> DsgraphmultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_path_len(s : DsgraphmultiPath) -> Int { s.size }

pub fn ds_graph_multi_path_get(s : DsgraphmultiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_path_set(s : DsgraphmultiPath, i : Int, v : Double) -> DsgraphmultiPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_path_sum(s : DsgraphmultiPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_path_mean(s : DsgraphmultiPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_path_scale(s : DsgraphmultiPath, f : Double) -> DsgraphmultiPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_path_add(a : DsgraphmultiPath, b : DsgraphmultiPath) -> DsgraphmultiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_path_copy(s : DsgraphmultiPath) -> DsgraphmultiPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_path_fill(s : DsgraphmultiPath, v : Double) -> DsgraphmultiPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_path_min(s : DsgraphmultiPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_path_max(s : DsgraphmultiPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_path_to_string(s : DsgraphmultiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cluster_make(size : Int) -> DsgraphmultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_cluster_len(s : DsgraphmultiCluster) -> Int { s.size }

pub fn ds_graph_multi_cluster_get(s : DsgraphmultiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_cluster_set(s : DsgraphmultiCluster, i : Int, v : Double) -> DsgraphmultiCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cluster_sum(s : DsgraphmultiCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_cluster_mean(s : DsgraphmultiCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_cluster_scale(s : DsgraphmultiCluster, f : Double) -> DsgraphmultiCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cluster_add(a : DsgraphmultiCluster, b : DsgraphmultiCluster) -> DsgraphmultiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_cluster_copy(s : DsgraphmultiCluster) -> DsgraphmultiCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cluster_fill(s : DsgraphmultiCluster, v : Double) -> DsgraphmultiCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cluster_min(s : DsgraphmultiCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_cluster_max(s : DsgraphmultiCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_cluster_to_string(s : DsgraphmultiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_model_make(size : Int) -> DsgraphmultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_model_len(s : DsgraphmultiModel) -> Int { s.size }

pub fn ds_graph_multi_model_get(s : DsgraphmultiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_model_set(s : DsgraphmultiModel, i : Int, v : Double) -> DsgraphmultiModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_model_sum(s : DsgraphmultiModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_model_mean(s : DsgraphmultiModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_model_scale(s : DsgraphmultiModel, f : Double) -> DsgraphmultiModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_model_add(a : DsgraphmultiModel, b : DsgraphmultiModel) -> DsgraphmultiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_model_copy(s : DsgraphmultiModel) -> DsgraphmultiModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_model_fill(s : DsgraphmultiModel, v : Double) -> DsgraphmultiModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_model_min(s : DsgraphmultiModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_model_max(s : DsgraphmultiModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_model_to_string(s : DsgraphmultiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_layer_make(size : Int) -> DsgraphmultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_layer_len(s : DsgraphmultiLayer) -> Int { s.size }

pub fn ds_graph_multi_layer_get(s : DsgraphmultiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_layer_set(s : DsgraphmultiLayer, i : Int, v : Double) -> DsgraphmultiLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_layer_sum(s : DsgraphmultiLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_layer_mean(s : DsgraphmultiLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_layer_scale(s : DsgraphmultiLayer, f : Double) -> DsgraphmultiLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_layer_add(a : DsgraphmultiLayer, b : DsgraphmultiLayer) -> DsgraphmultiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_layer_copy(s : DsgraphmultiLayer) -> DsgraphmultiLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_layer_fill(s : DsgraphmultiLayer, v : Double) -> DsgraphmultiLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_layer_min(s : DsgraphmultiLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_layer_max(s : DsgraphmultiLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_layer_to_string(s : DsgraphmultiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_buffer_make(size : Int) -> DsgraphmultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_buffer_len(s : DsgraphmultiBuffer) -> Int { s.size }

pub fn ds_graph_multi_buffer_get(s : DsgraphmultiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_buffer_set(s : DsgraphmultiBuffer, i : Int, v : Double) -> DsgraphmultiBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_buffer_sum(s : DsgraphmultiBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_buffer_mean(s : DsgraphmultiBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_buffer_scale(s : DsgraphmultiBuffer, f : Double) -> DsgraphmultiBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_buffer_add(a : DsgraphmultiBuffer, b : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_buffer_copy(s : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_buffer_fill(s : DsgraphmultiBuffer, v : Double) -> DsgraphmultiBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_buffer_min(s : DsgraphmultiBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_buffer_max(s : DsgraphmultiBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_buffer_to_string(s : DsgraphmultiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cursor_make(size : Int) -> DsgraphmultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_cursor_len(s : DsgraphmultiCursor) -> Int { s.size }

pub fn ds_graph_multi_cursor_get(s : DsgraphmultiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_cursor_set(s : DsgraphmultiCursor, i : Int, v : Double) -> DsgraphmultiCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cursor_sum(s : DsgraphmultiCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_cursor_mean(s : DsgraphmultiCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_cursor_scale(s : DsgraphmultiCursor, f : Double) -> DsgraphmultiCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cursor_add(a : DsgraphmultiCursor, b : DsgraphmultiCursor) -> DsgraphmultiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_cursor_copy(s : DsgraphmultiCursor) -> DsgraphmultiCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cursor_fill(s : DsgraphmultiCursor, v : Double) -> DsgraphmultiCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_cursor_min(s : DsgraphmultiCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_cursor_max(s : DsgraphmultiCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_cursor_to_string(s : DsgraphmultiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_view_make(size : Int) -> DsgraphmultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_view_len(s : DsgraphmultiView) -> Int { s.size }

pub fn ds_graph_multi_view_get(s : DsgraphmultiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_view_set(s : DsgraphmultiView, i : Int, v : Double) -> DsgraphmultiView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_view_sum(s : DsgraphmultiView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_view_mean(s : DsgraphmultiView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_view_scale(s : DsgraphmultiView, f : Double) -> DsgraphmultiView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_view_add(a : DsgraphmultiView, b : DsgraphmultiView) -> DsgraphmultiView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_view_copy(s : DsgraphmultiView) -> DsgraphmultiView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_view_fill(s : DsgraphmultiView, v : Double) -> DsgraphmultiView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_view_min(s : DsgraphmultiView) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_view_max(s : DsgraphmultiView) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_view_to_string(s : DsgraphmultiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_range_make(size : Int) -> DsgraphmultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_range_len(s : DsgraphmultiRange) -> Int { s.size }

pub fn ds_graph_multi_range_get(s : DsgraphmultiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_range_set(s : DsgraphmultiRange, i : Int, v : Double) -> DsgraphmultiRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_range_sum(s : DsgraphmultiRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_range_mean(s : DsgraphmultiRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_range_scale(s : DsgraphmultiRange, f : Double) -> DsgraphmultiRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_range_add(a : DsgraphmultiRange, b : DsgraphmultiRange) -> DsgraphmultiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_range_copy(s : DsgraphmultiRange) -> DsgraphmultiRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_range_fill(s : DsgraphmultiRange, v : Double) -> DsgraphmultiRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_range_min(s : DsgraphmultiRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_range_max(s : DsgraphmultiRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_range_to_string(s : DsgraphmultiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_slice_make(size : Int) -> DsgraphmultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_slice_len(s : DsgraphmultiSlice) -> Int { s.size }

pub fn ds_graph_multi_slice_get(s : DsgraphmultiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_slice_set(s : DsgraphmultiSlice, i : Int, v : Double) -> DsgraphmultiSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_slice_sum(s : DsgraphmultiSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_multi_slice_mean(s : DsgraphmultiSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_multi_slice_scale(s : DsgraphmultiSlice, f : Double) -> DsgraphmultiSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_slice_add(a : DsgraphmultiSlice, b : DsgraphmultiSlice) -> DsgraphmultiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_multi_slice_copy(s : DsgraphmultiSlice) -> DsgraphmultiSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_slice_fill(s : DsgraphmultiSlice, v : Double) -> DsgraphmultiSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_multi_slice_min(s : DsgraphmultiSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_multi_slice_max(s : DsgraphmultiSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_multi_slice_to_string(s : DsgraphmultiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

