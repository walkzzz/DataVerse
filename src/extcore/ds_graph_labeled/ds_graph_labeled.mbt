///===
/// extcore/ds_graph_labeled

pub(all) struct DsgraphlabeledPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_labeled_make_point(x : Double, y : Double) -> DsgraphlabeledPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_labeled_make_point3(x : Double, y : Double, z : Double) -> DsgraphlabeledPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphlabeledPoint::x(self : DsgraphlabeledPoint) -> Double { self.x }

pub fn DsgraphlabeledPoint::y(self : DsgraphlabeledPoint) -> Double { self.y }

pub fn DsgraphlabeledPoint::z(self : DsgraphlabeledPoint) -> Double { self.z }

pub fn DsgraphlabeledPoint::label(self : DsgraphlabeledPoint) -> Int { self.label }

pub fn DsgraphlabeledPoint::dist(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphlabeledPoint::add(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphlabeledPoint::sub(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphlabeledPoint::scale(self : DsgraphlabeledPoint, s : Double) -> DsgraphlabeledPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphlabeledPoint::dot(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphlabeledPoint::cross(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphlabeledPoint::norm(self : DsgraphlabeledPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphlabeledPoint::normalize(self : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphlabeledPoint::negate(self : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphlabeledPoint::mid(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphlabeledPoint::lerp(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint, t : Double) -> DsgraphlabeledPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphlabeledPoint::to_string(self : DsgraphlabeledPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphlabeledSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_labeled_make_series(vals : Array[Double], name : String) -> DsgraphlabeledSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphlabeledSeries::len(self : DsgraphlabeledSeries) -> Int { self.vals.length() }

pub fn DsgraphlabeledSeries::sum(self : DsgraphlabeledSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphlabeledSeries::mean(self : DsgraphlabeledSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphlabeledSeries::min(self : DsgraphlabeledSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphlabeledSeries::max(self : DsgraphlabeledSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphlabeledSeries::range(self : DsgraphlabeledSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphlabeledSeries::variance(self : DsgraphlabeledSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphlabeledSeries::std(self : DsgraphlabeledSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphlabeledSeries::median(self : DsgraphlabeledSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphlabeledSeries::scale(self : DsgraphlabeledSeries, f : Double) -> DsgraphlabeledSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphlabeledSeries::add(self : DsgraphlabeledSeries, other : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphlabeledSeries::sub(self : DsgraphlabeledSeries, other : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphlabeledSeries::normalize(self : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphlabeledSeries::cumsum(self : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphlabeledSeries::to_string(self : DsgraphlabeledSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphlabeledMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_labeled_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphlabeledMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_labeled_matrix_identity(n : Int) -> DsgraphlabeledMatrix {
  let m = ds_graph_labeled_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphlabeledMatrix::get(self : DsgraphlabeledMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphlabeledMatrix::transpose(self : DsgraphlabeledMatrix) -> DsgraphlabeledMatrix {
  let result = ds_graph_labeled_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphlabeledMatrix::add(self : DsgraphlabeledMatrix, other : DsgraphlabeledMatrix) -> DsgraphlabeledMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_labeled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphlabeledMatrix::scale(self : DsgraphlabeledMatrix, s : Double) -> DsgraphlabeledMatrix {
  let result = ds_graph_labeled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphlabeledMatrix::multiply(self : DsgraphlabeledMatrix, other : DsgraphlabeledMatrix) -> DsgraphlabeledMatrix {
  if self.cols != other.rows { return ds_graph_labeled_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_labeled_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphlabeledMatrix::trace(self : DsgraphlabeledMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphlabeledMatrix::det(self : DsgraphlabeledMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphlabeledMatrix::norm(self : DsgraphlabeledMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphlabeledMatrix::to_string(self : DsgraphlabeledMatrix) -> String {
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

pub(all) struct DsgraphlabeledVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_labeled_make_vector(comps : Array[Double]) -> DsgraphlabeledVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_labeled_vector_zero(dim : Int) -> DsgraphlabeledVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphlabeledVector::add(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> DsgraphlabeledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphlabeledVector::sub(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> DsgraphlabeledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphlabeledVector::scale(self : DsgraphlabeledVector, s : Double) -> DsgraphlabeledVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphlabeledVector::dot(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphlabeledVector::norm(self : DsgraphlabeledVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphlabeledVector::normalize(self : DsgraphlabeledVector) -> DsgraphlabeledVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphlabeledVector::dist(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphlabeledVector::to_string(self : DsgraphlabeledVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_labeled_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_labeled_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_labeled_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_labeled_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_labeled_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_labeled_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_labeled_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_labeled_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_labeled_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_labeled_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_labeled_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_labeled_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_labeled_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_labeled_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_labeled_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_labeled_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_labeled_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_labeled_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_labeled_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_labeled_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_labeled_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_labeled_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_labeled_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_labeled_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_labeled_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_labeled_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_labeled_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_labeled_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_labeled_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphlabeledFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_frame_make(size : Int) -> DsgraphlabeledFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_frame_len(s : DsgraphlabeledFrame) -> Int { s.size }

pub fn ds_graph_labeled_frame_get(s : DsgraphlabeledFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_frame_set(s : DsgraphlabeledFrame, i : Int, v : Double) -> DsgraphlabeledFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_frame_sum(s : DsgraphlabeledFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_frame_mean(s : DsgraphlabeledFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_frame_scale(s : DsgraphlabeledFrame, f : Double) -> DsgraphlabeledFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_frame_add(a : DsgraphlabeledFrame, b : DsgraphlabeledFrame) -> DsgraphlabeledFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_frame_copy(s : DsgraphlabeledFrame) -> DsgraphlabeledFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_frame_fill(s : DsgraphlabeledFrame, v : Double) -> DsgraphlabeledFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_frame_min(s : DsgraphlabeledFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_frame_max(s : DsgraphlabeledFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_frame_to_string(s : DsgraphlabeledFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_table_make(size : Int) -> DsgraphlabeledTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_table_len(s : DsgraphlabeledTable) -> Int { s.size }

pub fn ds_graph_labeled_table_get(s : DsgraphlabeledTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_table_set(s : DsgraphlabeledTable, i : Int, v : Double) -> DsgraphlabeledTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_table_sum(s : DsgraphlabeledTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_table_mean(s : DsgraphlabeledTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_table_scale(s : DsgraphlabeledTable, f : Double) -> DsgraphlabeledTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_table_add(a : DsgraphlabeledTable, b : DsgraphlabeledTable) -> DsgraphlabeledTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_table_copy(s : DsgraphlabeledTable) -> DsgraphlabeledTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_table_fill(s : DsgraphlabeledTable, v : Double) -> DsgraphlabeledTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_table_min(s : DsgraphlabeledTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_table_max(s : DsgraphlabeledTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_table_to_string(s : DsgraphlabeledTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_graphn_make(size : Int) -> DsgraphlabeledGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_graphn_len(s : DsgraphlabeledGraphN) -> Int { s.size }

pub fn ds_graph_labeled_graphn_get(s : DsgraphlabeledGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_graphn_set(s : DsgraphlabeledGraphN, i : Int, v : Double) -> DsgraphlabeledGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_graphn_sum(s : DsgraphlabeledGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_graphn_mean(s : DsgraphlabeledGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_graphn_scale(s : DsgraphlabeledGraphN, f : Double) -> DsgraphlabeledGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_graphn_add(a : DsgraphlabeledGraphN, b : DsgraphlabeledGraphN) -> DsgraphlabeledGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_graphn_copy(s : DsgraphlabeledGraphN) -> DsgraphlabeledGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_graphn_fill(s : DsgraphlabeledGraphN, v : Double) -> DsgraphlabeledGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_graphn_min(s : DsgraphlabeledGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_graphn_max(s : DsgraphlabeledGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_graphn_to_string(s : DsgraphlabeledGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_node_make(size : Int) -> DsgraphlabeledNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_node_len(s : DsgraphlabeledNode) -> Int { s.size }

pub fn ds_graph_labeled_node_get(s : DsgraphlabeledNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_node_set(s : DsgraphlabeledNode, i : Int, v : Double) -> DsgraphlabeledNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_node_sum(s : DsgraphlabeledNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_node_mean(s : DsgraphlabeledNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_node_scale(s : DsgraphlabeledNode, f : Double) -> DsgraphlabeledNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_node_add(a : DsgraphlabeledNode, b : DsgraphlabeledNode) -> DsgraphlabeledNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_node_copy(s : DsgraphlabeledNode) -> DsgraphlabeledNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_node_fill(s : DsgraphlabeledNode, v : Double) -> DsgraphlabeledNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_node_min(s : DsgraphlabeledNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_node_max(s : DsgraphlabeledNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_node_to_string(s : DsgraphlabeledNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_edge_make(size : Int) -> DsgraphlabeledEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_edge_len(s : DsgraphlabeledEdge) -> Int { s.size }

pub fn ds_graph_labeled_edge_get(s : DsgraphlabeledEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_edge_set(s : DsgraphlabeledEdge, i : Int, v : Double) -> DsgraphlabeledEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_edge_sum(s : DsgraphlabeledEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_edge_mean(s : DsgraphlabeledEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_edge_scale(s : DsgraphlabeledEdge, f : Double) -> DsgraphlabeledEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_edge_add(a : DsgraphlabeledEdge, b : DsgraphlabeledEdge) -> DsgraphlabeledEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_edge_copy(s : DsgraphlabeledEdge) -> DsgraphlabeledEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_edge_fill(s : DsgraphlabeledEdge, v : Double) -> DsgraphlabeledEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_edge_min(s : DsgraphlabeledEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_edge_max(s : DsgraphlabeledEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_edge_to_string(s : DsgraphlabeledEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_path_make(size : Int) -> DsgraphlabeledPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_path_len(s : DsgraphlabeledPath) -> Int { s.size }

pub fn ds_graph_labeled_path_get(s : DsgraphlabeledPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_path_set(s : DsgraphlabeledPath, i : Int, v : Double) -> DsgraphlabeledPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_path_sum(s : DsgraphlabeledPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_path_mean(s : DsgraphlabeledPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_path_scale(s : DsgraphlabeledPath, f : Double) -> DsgraphlabeledPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_path_add(a : DsgraphlabeledPath, b : DsgraphlabeledPath) -> DsgraphlabeledPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_path_copy(s : DsgraphlabeledPath) -> DsgraphlabeledPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_path_fill(s : DsgraphlabeledPath, v : Double) -> DsgraphlabeledPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_path_min(s : DsgraphlabeledPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_path_max(s : DsgraphlabeledPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_path_to_string(s : DsgraphlabeledPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_cluster_make(size : Int) -> DsgraphlabeledCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_cluster_len(s : DsgraphlabeledCluster) -> Int { s.size }

pub fn ds_graph_labeled_cluster_get(s : DsgraphlabeledCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_cluster_set(s : DsgraphlabeledCluster, i : Int, v : Double) -> DsgraphlabeledCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cluster_sum(s : DsgraphlabeledCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_cluster_mean(s : DsgraphlabeledCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_cluster_scale(s : DsgraphlabeledCluster, f : Double) -> DsgraphlabeledCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cluster_add(a : DsgraphlabeledCluster, b : DsgraphlabeledCluster) -> DsgraphlabeledCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_cluster_copy(s : DsgraphlabeledCluster) -> DsgraphlabeledCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cluster_fill(s : DsgraphlabeledCluster, v : Double) -> DsgraphlabeledCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cluster_min(s : DsgraphlabeledCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_cluster_max(s : DsgraphlabeledCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_cluster_to_string(s : DsgraphlabeledCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_model_make(size : Int) -> DsgraphlabeledModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_model_len(s : DsgraphlabeledModel) -> Int { s.size }

pub fn ds_graph_labeled_model_get(s : DsgraphlabeledModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_model_set(s : DsgraphlabeledModel, i : Int, v : Double) -> DsgraphlabeledModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_model_sum(s : DsgraphlabeledModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_model_mean(s : DsgraphlabeledModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_model_scale(s : DsgraphlabeledModel, f : Double) -> DsgraphlabeledModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_model_add(a : DsgraphlabeledModel, b : DsgraphlabeledModel) -> DsgraphlabeledModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_model_copy(s : DsgraphlabeledModel) -> DsgraphlabeledModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_model_fill(s : DsgraphlabeledModel, v : Double) -> DsgraphlabeledModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_model_min(s : DsgraphlabeledModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_model_max(s : DsgraphlabeledModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_model_to_string(s : DsgraphlabeledModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_layer_make(size : Int) -> DsgraphlabeledLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_layer_len(s : DsgraphlabeledLayer) -> Int { s.size }

pub fn ds_graph_labeled_layer_get(s : DsgraphlabeledLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_layer_set(s : DsgraphlabeledLayer, i : Int, v : Double) -> DsgraphlabeledLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_layer_sum(s : DsgraphlabeledLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_layer_mean(s : DsgraphlabeledLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_layer_scale(s : DsgraphlabeledLayer, f : Double) -> DsgraphlabeledLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_layer_add(a : DsgraphlabeledLayer, b : DsgraphlabeledLayer) -> DsgraphlabeledLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_layer_copy(s : DsgraphlabeledLayer) -> DsgraphlabeledLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_layer_fill(s : DsgraphlabeledLayer, v : Double) -> DsgraphlabeledLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_layer_min(s : DsgraphlabeledLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_layer_max(s : DsgraphlabeledLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_layer_to_string(s : DsgraphlabeledLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_buffer_make(size : Int) -> DsgraphlabeledBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_buffer_len(s : DsgraphlabeledBuffer) -> Int { s.size }

pub fn ds_graph_labeled_buffer_get(s : DsgraphlabeledBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_buffer_set(s : DsgraphlabeledBuffer, i : Int, v : Double) -> DsgraphlabeledBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_buffer_sum(s : DsgraphlabeledBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_buffer_mean(s : DsgraphlabeledBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_buffer_scale(s : DsgraphlabeledBuffer, f : Double) -> DsgraphlabeledBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_buffer_add(a : DsgraphlabeledBuffer, b : DsgraphlabeledBuffer) -> DsgraphlabeledBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_buffer_copy(s : DsgraphlabeledBuffer) -> DsgraphlabeledBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_buffer_fill(s : DsgraphlabeledBuffer, v : Double) -> DsgraphlabeledBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_buffer_min(s : DsgraphlabeledBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_buffer_max(s : DsgraphlabeledBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_buffer_to_string(s : DsgraphlabeledBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_cursor_make(size : Int) -> DsgraphlabeledCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_cursor_len(s : DsgraphlabeledCursor) -> Int { s.size }

pub fn ds_graph_labeled_cursor_get(s : DsgraphlabeledCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_cursor_set(s : DsgraphlabeledCursor, i : Int, v : Double) -> DsgraphlabeledCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cursor_sum(s : DsgraphlabeledCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_cursor_mean(s : DsgraphlabeledCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_cursor_scale(s : DsgraphlabeledCursor, f : Double) -> DsgraphlabeledCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cursor_add(a : DsgraphlabeledCursor, b : DsgraphlabeledCursor) -> DsgraphlabeledCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_cursor_copy(s : DsgraphlabeledCursor) -> DsgraphlabeledCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cursor_fill(s : DsgraphlabeledCursor, v : Double) -> DsgraphlabeledCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_cursor_min(s : DsgraphlabeledCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_cursor_max(s : DsgraphlabeledCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_cursor_to_string(s : DsgraphlabeledCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_view_make(size : Int) -> DsgraphlabeledView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_view_len(s : DsgraphlabeledView) -> Int { s.size }

pub fn ds_graph_labeled_view_get(s : DsgraphlabeledView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_view_set(s : DsgraphlabeledView, i : Int, v : Double) -> DsgraphlabeledView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_view_sum(s : DsgraphlabeledView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_view_mean(s : DsgraphlabeledView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_view_scale(s : DsgraphlabeledView, f : Double) -> DsgraphlabeledView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_view_add(a : DsgraphlabeledView, b : DsgraphlabeledView) -> DsgraphlabeledView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_view_copy(s : DsgraphlabeledView) -> DsgraphlabeledView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_view_fill(s : DsgraphlabeledView, v : Double) -> DsgraphlabeledView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_view_min(s : DsgraphlabeledView) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_view_max(s : DsgraphlabeledView) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_view_to_string(s : DsgraphlabeledView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_range_make(size : Int) -> DsgraphlabeledRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_range_len(s : DsgraphlabeledRange) -> Int { s.size }

pub fn ds_graph_labeled_range_get(s : DsgraphlabeledRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_range_set(s : DsgraphlabeledRange, i : Int, v : Double) -> DsgraphlabeledRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_range_sum(s : DsgraphlabeledRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_range_mean(s : DsgraphlabeledRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_range_scale(s : DsgraphlabeledRange, f : Double) -> DsgraphlabeledRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_range_add(a : DsgraphlabeledRange, b : DsgraphlabeledRange) -> DsgraphlabeledRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_range_copy(s : DsgraphlabeledRange) -> DsgraphlabeledRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_range_fill(s : DsgraphlabeledRange, v : Double) -> DsgraphlabeledRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_range_min(s : DsgraphlabeledRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_range_max(s : DsgraphlabeledRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_range_to_string(s : DsgraphlabeledRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_slice_make(size : Int) -> DsgraphlabeledSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_labeled_slice_len(s : DsgraphlabeledSlice) -> Int { s.size }

pub fn ds_graph_labeled_slice_get(s : DsgraphlabeledSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_labeled_slice_set(s : DsgraphlabeledSlice, i : Int, v : Double) -> DsgraphlabeledSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_slice_sum(s : DsgraphlabeledSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_labeled_slice_mean(s : DsgraphlabeledSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_labeled_slice_scale(s : DsgraphlabeledSlice, f : Double) -> DsgraphlabeledSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_slice_add(a : DsgraphlabeledSlice, b : DsgraphlabeledSlice) -> DsgraphlabeledSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_labeled_slice_copy(s : DsgraphlabeledSlice) -> DsgraphlabeledSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_slice_fill(s : DsgraphlabeledSlice, v : Double) -> DsgraphlabeledSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_labeled_slice_min(s : DsgraphlabeledSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_labeled_slice_max(s : DsgraphlabeledSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_labeled_slice_to_string(s : DsgraphlabeledSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

