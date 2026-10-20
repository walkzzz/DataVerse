///===
/// extcore/ds_graph_weighted

pub(all) struct DsgraphweightedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_weighted_make_point(x : Double, y : Double) -> DsgraphweightedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_weighted_make_point3(x : Double, y : Double, z : Double) -> DsgraphweightedPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphweightedPoint::x(self : DsgraphweightedPoint) -> Double { self.x }

pub fn DsgraphweightedPoint::y(self : DsgraphweightedPoint) -> Double { self.y }

pub fn DsgraphweightedPoint::z(self : DsgraphweightedPoint) -> Double { self.z }

pub fn DsgraphweightedPoint::label(self : DsgraphweightedPoint) -> Int { self.label }

pub fn DsgraphweightedPoint::dist(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphweightedPoint::add(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphweightedPoint::sub(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphweightedPoint::scale(self : DsgraphweightedPoint, s : Double) -> DsgraphweightedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphweightedPoint::dot(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphweightedPoint::cross(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphweightedPoint::norm(self : DsgraphweightedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphweightedPoint::normalize(self : DsgraphweightedPoint) -> DsgraphweightedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphweightedPoint::negate(self : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphweightedPoint::mid(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphweightedPoint::lerp(self : DsgraphweightedPoint, other : DsgraphweightedPoint, t : Double) -> DsgraphweightedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphweightedPoint::to_string(self : DsgraphweightedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphweightedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_weighted_make_series(vals : Array[Double], name : String) -> DsgraphweightedSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphweightedSeries::len(self : DsgraphweightedSeries) -> Int { self.vals.length() }

pub fn DsgraphweightedSeries::sum(self : DsgraphweightedSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphweightedSeries::mean(self : DsgraphweightedSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphweightedSeries::min(self : DsgraphweightedSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphweightedSeries::max(self : DsgraphweightedSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphweightedSeries::range(self : DsgraphweightedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphweightedSeries::variance(self : DsgraphweightedSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphweightedSeries::std(self : DsgraphweightedSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphweightedSeries::median(self : DsgraphweightedSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphweightedSeries::scale(self : DsgraphweightedSeries, f : Double) -> DsgraphweightedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphweightedSeries::add(self : DsgraphweightedSeries, other : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphweightedSeries::sub(self : DsgraphweightedSeries, other : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphweightedSeries::normalize(self : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphweightedSeries::cumsum(self : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphweightedSeries::to_string(self : DsgraphweightedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphweightedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_weighted_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphweightedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_weighted_matrix_identity(n : Int) -> DsgraphweightedMatrix {
  let m = ds_graph_weighted_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphweightedMatrix::get(self : DsgraphweightedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphweightedMatrix::transpose(self : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphweightedMatrix::add(self : DsgraphweightedMatrix, other : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_weighted_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphweightedMatrix::scale(self : DsgraphweightedMatrix, s : Double) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphweightedMatrix::multiply(self : DsgraphweightedMatrix, other : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if self.cols != other.rows { return ds_graph_weighted_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_weighted_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphweightedMatrix::trace(self : DsgraphweightedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphweightedMatrix::det(self : DsgraphweightedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphweightedMatrix::norm(self : DsgraphweightedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphweightedMatrix::to_string(self : DsgraphweightedMatrix) -> String {
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

pub(all) struct DsgraphweightedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_weighted_make_vector(comps : Array[Double]) -> DsgraphweightedVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_weighted_vector_zero(dim : Int) -> DsgraphweightedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphweightedVector::add(self : DsgraphweightedVector, other : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphweightedVector::sub(self : DsgraphweightedVector, other : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphweightedVector::scale(self : DsgraphweightedVector, s : Double) -> DsgraphweightedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphweightedVector::dot(self : DsgraphweightedVector, other : DsgraphweightedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphweightedVector::norm(self : DsgraphweightedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphweightedVector::normalize(self : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphweightedVector::dist(self : DsgraphweightedVector, other : DsgraphweightedVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphweightedVector::to_string(self : DsgraphweightedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_weighted_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_weighted_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_weighted_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_weighted_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_weighted_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_weighted_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_weighted_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_weighted_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_weighted_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_weighted_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_weighted_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_weighted_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_weighted_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_weighted_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_weighted_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_weighted_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_weighted_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_weighted_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_weighted_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_weighted_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_weighted_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_weighted_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_weighted_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_weighted_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_weighted_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_weighted_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_weighted_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_weighted_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_weighted_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphweightedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_frame_make(size : Int) -> DsgraphweightedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_frame_len(s : DsgraphweightedFrame) -> Int { s.size }

pub fn ds_graph_weighted_frame_get(s : DsgraphweightedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_frame_set(s : DsgraphweightedFrame, i : Int, v : Double) -> DsgraphweightedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_sum(s : DsgraphweightedFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_frame_mean(s : DsgraphweightedFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_frame_scale(s : DsgraphweightedFrame, f : Double) -> DsgraphweightedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_add(a : DsgraphweightedFrame, b : DsgraphweightedFrame) -> DsgraphweightedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_frame_copy(s : DsgraphweightedFrame) -> DsgraphweightedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_fill(s : DsgraphweightedFrame, v : Double) -> DsgraphweightedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_min(s : DsgraphweightedFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_frame_max(s : DsgraphweightedFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_frame_to_string(s : DsgraphweightedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_table_make(size : Int) -> DsgraphweightedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_table_len(s : DsgraphweightedTable) -> Int { s.size }

pub fn ds_graph_weighted_table_get(s : DsgraphweightedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_table_set(s : DsgraphweightedTable, i : Int, v : Double) -> DsgraphweightedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_sum(s : DsgraphweightedTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_table_mean(s : DsgraphweightedTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_table_scale(s : DsgraphweightedTable, f : Double) -> DsgraphweightedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_add(a : DsgraphweightedTable, b : DsgraphweightedTable) -> DsgraphweightedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_table_copy(s : DsgraphweightedTable) -> DsgraphweightedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_fill(s : DsgraphweightedTable, v : Double) -> DsgraphweightedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_min(s : DsgraphweightedTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_table_max(s : DsgraphweightedTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_table_to_string(s : DsgraphweightedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_graphn_make(size : Int) -> DsgraphweightedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_graphn_len(s : DsgraphweightedGraphN) -> Int { s.size }

pub fn ds_graph_weighted_graphn_get(s : DsgraphweightedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_graphn_set(s : DsgraphweightedGraphN, i : Int, v : Double) -> DsgraphweightedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_sum(s : DsgraphweightedGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_graphn_mean(s : DsgraphweightedGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_graphn_scale(s : DsgraphweightedGraphN, f : Double) -> DsgraphweightedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_add(a : DsgraphweightedGraphN, b : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_graphn_copy(s : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_fill(s : DsgraphweightedGraphN, v : Double) -> DsgraphweightedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_min(s : DsgraphweightedGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_graphn_max(s : DsgraphweightedGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_graphn_to_string(s : DsgraphweightedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_node_make(size : Int) -> DsgraphweightedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_node_len(s : DsgraphweightedNode) -> Int { s.size }

pub fn ds_graph_weighted_node_get(s : DsgraphweightedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_node_set(s : DsgraphweightedNode, i : Int, v : Double) -> DsgraphweightedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_sum(s : DsgraphweightedNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_node_mean(s : DsgraphweightedNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_node_scale(s : DsgraphweightedNode, f : Double) -> DsgraphweightedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_add(a : DsgraphweightedNode, b : DsgraphweightedNode) -> DsgraphweightedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_node_copy(s : DsgraphweightedNode) -> DsgraphweightedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_fill(s : DsgraphweightedNode, v : Double) -> DsgraphweightedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_min(s : DsgraphweightedNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_node_max(s : DsgraphweightedNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_node_to_string(s : DsgraphweightedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_edge_make(size : Int) -> DsgraphweightedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_edge_len(s : DsgraphweightedEdge) -> Int { s.size }

pub fn ds_graph_weighted_edge_get(s : DsgraphweightedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_edge_set(s : DsgraphweightedEdge, i : Int, v : Double) -> DsgraphweightedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_sum(s : DsgraphweightedEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_edge_mean(s : DsgraphweightedEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_edge_scale(s : DsgraphweightedEdge, f : Double) -> DsgraphweightedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_add(a : DsgraphweightedEdge, b : DsgraphweightedEdge) -> DsgraphweightedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_edge_copy(s : DsgraphweightedEdge) -> DsgraphweightedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_fill(s : DsgraphweightedEdge, v : Double) -> DsgraphweightedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_min(s : DsgraphweightedEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_edge_max(s : DsgraphweightedEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_edge_to_string(s : DsgraphweightedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_path_make(size : Int) -> DsgraphweightedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_path_len(s : DsgraphweightedPath) -> Int { s.size }

pub fn ds_graph_weighted_path_get(s : DsgraphweightedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_path_set(s : DsgraphweightedPath, i : Int, v : Double) -> DsgraphweightedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_sum(s : DsgraphweightedPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_path_mean(s : DsgraphweightedPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_path_scale(s : DsgraphweightedPath, f : Double) -> DsgraphweightedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_add(a : DsgraphweightedPath, b : DsgraphweightedPath) -> DsgraphweightedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_path_copy(s : DsgraphweightedPath) -> DsgraphweightedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_fill(s : DsgraphweightedPath, v : Double) -> DsgraphweightedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_min(s : DsgraphweightedPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_path_max(s : DsgraphweightedPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_path_to_string(s : DsgraphweightedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cluster_make(size : Int) -> DsgraphweightedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_cluster_len(s : DsgraphweightedCluster) -> Int { s.size }

pub fn ds_graph_weighted_cluster_get(s : DsgraphweightedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_cluster_set(s : DsgraphweightedCluster, i : Int, v : Double) -> DsgraphweightedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_sum(s : DsgraphweightedCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_cluster_mean(s : DsgraphweightedCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_cluster_scale(s : DsgraphweightedCluster, f : Double) -> DsgraphweightedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_add(a : DsgraphweightedCluster, b : DsgraphweightedCluster) -> DsgraphweightedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_cluster_copy(s : DsgraphweightedCluster) -> DsgraphweightedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_fill(s : DsgraphweightedCluster, v : Double) -> DsgraphweightedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_min(s : DsgraphweightedCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_cluster_max(s : DsgraphweightedCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_cluster_to_string(s : DsgraphweightedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_model_make(size : Int) -> DsgraphweightedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_model_len(s : DsgraphweightedModel) -> Int { s.size }

pub fn ds_graph_weighted_model_get(s : DsgraphweightedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_model_set(s : DsgraphweightedModel, i : Int, v : Double) -> DsgraphweightedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_sum(s : DsgraphweightedModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_model_mean(s : DsgraphweightedModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_model_scale(s : DsgraphweightedModel, f : Double) -> DsgraphweightedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_add(a : DsgraphweightedModel, b : DsgraphweightedModel) -> DsgraphweightedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_model_copy(s : DsgraphweightedModel) -> DsgraphweightedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_fill(s : DsgraphweightedModel, v : Double) -> DsgraphweightedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_min(s : DsgraphweightedModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_model_max(s : DsgraphweightedModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_model_to_string(s : DsgraphweightedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_layer_make(size : Int) -> DsgraphweightedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_layer_len(s : DsgraphweightedLayer) -> Int { s.size }

pub fn ds_graph_weighted_layer_get(s : DsgraphweightedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_layer_set(s : DsgraphweightedLayer, i : Int, v : Double) -> DsgraphweightedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_sum(s : DsgraphweightedLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_layer_mean(s : DsgraphweightedLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_layer_scale(s : DsgraphweightedLayer, f : Double) -> DsgraphweightedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_add(a : DsgraphweightedLayer, b : DsgraphweightedLayer) -> DsgraphweightedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_layer_copy(s : DsgraphweightedLayer) -> DsgraphweightedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_fill(s : DsgraphweightedLayer, v : Double) -> DsgraphweightedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_min(s : DsgraphweightedLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_layer_max(s : DsgraphweightedLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_layer_to_string(s : DsgraphweightedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_buffer_make(size : Int) -> DsgraphweightedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_buffer_len(s : DsgraphweightedBuffer) -> Int { s.size }

pub fn ds_graph_weighted_buffer_get(s : DsgraphweightedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_buffer_set(s : DsgraphweightedBuffer, i : Int, v : Double) -> DsgraphweightedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_sum(s : DsgraphweightedBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_buffer_mean(s : DsgraphweightedBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_buffer_scale(s : DsgraphweightedBuffer, f : Double) -> DsgraphweightedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_add(a : DsgraphweightedBuffer, b : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_buffer_copy(s : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_fill(s : DsgraphweightedBuffer, v : Double) -> DsgraphweightedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_min(s : DsgraphweightedBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_buffer_max(s : DsgraphweightedBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_buffer_to_string(s : DsgraphweightedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cursor_make(size : Int) -> DsgraphweightedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_cursor_len(s : DsgraphweightedCursor) -> Int { s.size }

pub fn ds_graph_weighted_cursor_get(s : DsgraphweightedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_cursor_set(s : DsgraphweightedCursor, i : Int, v : Double) -> DsgraphweightedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_sum(s : DsgraphweightedCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_cursor_mean(s : DsgraphweightedCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_cursor_scale(s : DsgraphweightedCursor, f : Double) -> DsgraphweightedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_add(a : DsgraphweightedCursor, b : DsgraphweightedCursor) -> DsgraphweightedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_cursor_copy(s : DsgraphweightedCursor) -> DsgraphweightedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_fill(s : DsgraphweightedCursor, v : Double) -> DsgraphweightedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_min(s : DsgraphweightedCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_cursor_max(s : DsgraphweightedCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_cursor_to_string(s : DsgraphweightedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_view_make(size : Int) -> DsgraphweightedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_view_len(s : DsgraphweightedView) -> Int { s.size }

pub fn ds_graph_weighted_view_get(s : DsgraphweightedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_view_set(s : DsgraphweightedView, i : Int, v : Double) -> DsgraphweightedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_sum(s : DsgraphweightedView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_view_mean(s : DsgraphweightedView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_view_scale(s : DsgraphweightedView, f : Double) -> DsgraphweightedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_add(a : DsgraphweightedView, b : DsgraphweightedView) -> DsgraphweightedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_view_copy(s : DsgraphweightedView) -> DsgraphweightedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_fill(s : DsgraphweightedView, v : Double) -> DsgraphweightedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_min(s : DsgraphweightedView) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_view_max(s : DsgraphweightedView) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_view_to_string(s : DsgraphweightedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_range_make(size : Int) -> DsgraphweightedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_range_len(s : DsgraphweightedRange) -> Int { s.size }

pub fn ds_graph_weighted_range_get(s : DsgraphweightedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_range_set(s : DsgraphweightedRange, i : Int, v : Double) -> DsgraphweightedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_sum(s : DsgraphweightedRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_range_mean(s : DsgraphweightedRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_range_scale(s : DsgraphweightedRange, f : Double) -> DsgraphweightedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_add(a : DsgraphweightedRange, b : DsgraphweightedRange) -> DsgraphweightedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_range_copy(s : DsgraphweightedRange) -> DsgraphweightedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_fill(s : DsgraphweightedRange, v : Double) -> DsgraphweightedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_min(s : DsgraphweightedRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_range_max(s : DsgraphweightedRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_range_to_string(s : DsgraphweightedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_slice_make(size : Int) -> DsgraphweightedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_slice_len(s : DsgraphweightedSlice) -> Int { s.size }

pub fn ds_graph_weighted_slice_get(s : DsgraphweightedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_slice_set(s : DsgraphweightedSlice, i : Int, v : Double) -> DsgraphweightedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_sum(s : DsgraphweightedSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_slice_mean(s : DsgraphweightedSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_slice_scale(s : DsgraphweightedSlice, f : Double) -> DsgraphweightedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_add(a : DsgraphweightedSlice, b : DsgraphweightedSlice) -> DsgraphweightedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_slice_copy(s : DsgraphweightedSlice) -> DsgraphweightedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_fill(s : DsgraphweightedSlice, v : Double) -> DsgraphweightedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_min(s : DsgraphweightedSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_slice_max(s : DsgraphweightedSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_slice_to_string(s : DsgraphweightedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

