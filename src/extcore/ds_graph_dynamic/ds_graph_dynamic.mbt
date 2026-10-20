///===
/// extcore/ds_graph_dynamic

pub(all) struct DsgraphdynamicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_dynamic_make_point(x : Double, y : Double) -> DsgraphdynamicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_dynamic_make_point3(x : Double, y : Double, z : Double) -> DsgraphdynamicPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphdynamicPoint::x(self : DsgraphdynamicPoint) -> Double { self.x }

pub fn DsgraphdynamicPoint::y(self : DsgraphdynamicPoint) -> Double { self.y }

pub fn DsgraphdynamicPoint::z(self : DsgraphdynamicPoint) -> Double { self.z }

pub fn DsgraphdynamicPoint::label(self : DsgraphdynamicPoint) -> Int { self.label }

pub fn DsgraphdynamicPoint::dist(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphdynamicPoint::add(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphdynamicPoint::sub(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphdynamicPoint::scale(self : DsgraphdynamicPoint, s : Double) -> DsgraphdynamicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphdynamicPoint::dot(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphdynamicPoint::cross(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphdynamicPoint::norm(self : DsgraphdynamicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphdynamicPoint::normalize(self : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphdynamicPoint::negate(self : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphdynamicPoint::mid(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphdynamicPoint::lerp(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint, t : Double) -> DsgraphdynamicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphdynamicPoint::to_string(self : DsgraphdynamicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphdynamicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_dynamic_make_series(vals : Array[Double], name : String) -> DsgraphdynamicSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphdynamicSeries::len(self : DsgraphdynamicSeries) -> Int { self.vals.length() }

pub fn DsgraphdynamicSeries::sum(self : DsgraphdynamicSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphdynamicSeries::mean(self : DsgraphdynamicSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphdynamicSeries::min(self : DsgraphdynamicSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphdynamicSeries::max(self : DsgraphdynamicSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphdynamicSeries::range(self : DsgraphdynamicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphdynamicSeries::variance(self : DsgraphdynamicSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphdynamicSeries::std(self : DsgraphdynamicSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphdynamicSeries::median(self : DsgraphdynamicSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphdynamicSeries::scale(self : DsgraphdynamicSeries, f : Double) -> DsgraphdynamicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphdynamicSeries::add(self : DsgraphdynamicSeries, other : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphdynamicSeries::sub(self : DsgraphdynamicSeries, other : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphdynamicSeries::normalize(self : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphdynamicSeries::cumsum(self : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphdynamicSeries::to_string(self : DsgraphdynamicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdynamicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_dynamic_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphdynamicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_dynamic_matrix_identity(n : Int) -> DsgraphdynamicMatrix {
  let m = ds_graph_dynamic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphdynamicMatrix::get(self : DsgraphdynamicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphdynamicMatrix::transpose(self : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  let result = ds_graph_dynamic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphdynamicMatrix::add(self : DsgraphdynamicMatrix, other : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphdynamicMatrix::scale(self : DsgraphdynamicMatrix, s : Double) -> DsgraphdynamicMatrix {
  let result = ds_graph_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphdynamicMatrix::multiply(self : DsgraphdynamicMatrix, other : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  if self.cols != other.rows { return ds_graph_dynamic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_dynamic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphdynamicMatrix::trace(self : DsgraphdynamicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphdynamicMatrix::det(self : DsgraphdynamicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphdynamicMatrix::norm(self : DsgraphdynamicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphdynamicMatrix::to_string(self : DsgraphdynamicMatrix) -> String {
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

pub(all) struct DsgraphdynamicVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_dynamic_make_vector(comps : Array[Double]) -> DsgraphdynamicVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_dynamic_vector_zero(dim : Int) -> DsgraphdynamicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphdynamicVector::add(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphdynamicVector::sub(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphdynamicVector::scale(self : DsgraphdynamicVector, s : Double) -> DsgraphdynamicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphdynamicVector::dot(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphdynamicVector::norm(self : DsgraphdynamicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphdynamicVector::normalize(self : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphdynamicVector::dist(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphdynamicVector::to_string(self : DsgraphdynamicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_dynamic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_dynamic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_dynamic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_dynamic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_dynamic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_dynamic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_dynamic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_dynamic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_dynamic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_dynamic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_dynamic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_dynamic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_dynamic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_dynamic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_dynamic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_dynamic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_dynamic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_dynamic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_dynamic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_dynamic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_dynamic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_dynamic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_dynamic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_dynamic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_dynamic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_dynamic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_dynamic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_dynamic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_dynamic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphdynamicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_frame_make(size : Int) -> DsgraphdynamicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_frame_len(s : DsgraphdynamicFrame) -> Int { s.size }

pub fn ds_graph_dynamic_frame_get(s : DsgraphdynamicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_frame_set(s : DsgraphdynamicFrame, i : Int, v : Double) -> DsgraphdynamicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_frame_sum(s : DsgraphdynamicFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_frame_mean(s : DsgraphdynamicFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_frame_scale(s : DsgraphdynamicFrame, f : Double) -> DsgraphdynamicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_frame_add(a : DsgraphdynamicFrame, b : DsgraphdynamicFrame) -> DsgraphdynamicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_frame_copy(s : DsgraphdynamicFrame) -> DsgraphdynamicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_frame_fill(s : DsgraphdynamicFrame, v : Double) -> DsgraphdynamicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_frame_min(s : DsgraphdynamicFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_frame_max(s : DsgraphdynamicFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_frame_to_string(s : DsgraphdynamicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_table_make(size : Int) -> DsgraphdynamicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_table_len(s : DsgraphdynamicTable) -> Int { s.size }

pub fn ds_graph_dynamic_table_get(s : DsgraphdynamicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_table_set(s : DsgraphdynamicTable, i : Int, v : Double) -> DsgraphdynamicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_table_sum(s : DsgraphdynamicTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_table_mean(s : DsgraphdynamicTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_table_scale(s : DsgraphdynamicTable, f : Double) -> DsgraphdynamicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_table_add(a : DsgraphdynamicTable, b : DsgraphdynamicTable) -> DsgraphdynamicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_table_copy(s : DsgraphdynamicTable) -> DsgraphdynamicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_table_fill(s : DsgraphdynamicTable, v : Double) -> DsgraphdynamicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_table_min(s : DsgraphdynamicTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_table_max(s : DsgraphdynamicTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_table_to_string(s : DsgraphdynamicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_graphn_make(size : Int) -> DsgraphdynamicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_graphn_len(s : DsgraphdynamicGraphN) -> Int { s.size }

pub fn ds_graph_dynamic_graphn_get(s : DsgraphdynamicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_graphn_set(s : DsgraphdynamicGraphN, i : Int, v : Double) -> DsgraphdynamicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_graphn_sum(s : DsgraphdynamicGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_graphn_mean(s : DsgraphdynamicGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_graphn_scale(s : DsgraphdynamicGraphN, f : Double) -> DsgraphdynamicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_graphn_add(a : DsgraphdynamicGraphN, b : DsgraphdynamicGraphN) -> DsgraphdynamicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_graphn_copy(s : DsgraphdynamicGraphN) -> DsgraphdynamicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_graphn_fill(s : DsgraphdynamicGraphN, v : Double) -> DsgraphdynamicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_graphn_min(s : DsgraphdynamicGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_graphn_max(s : DsgraphdynamicGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_graphn_to_string(s : DsgraphdynamicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_node_make(size : Int) -> DsgraphdynamicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_node_len(s : DsgraphdynamicNode) -> Int { s.size }

pub fn ds_graph_dynamic_node_get(s : DsgraphdynamicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_node_set(s : DsgraphdynamicNode, i : Int, v : Double) -> DsgraphdynamicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_node_sum(s : DsgraphdynamicNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_node_mean(s : DsgraphdynamicNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_node_scale(s : DsgraphdynamicNode, f : Double) -> DsgraphdynamicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_node_add(a : DsgraphdynamicNode, b : DsgraphdynamicNode) -> DsgraphdynamicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_node_copy(s : DsgraphdynamicNode) -> DsgraphdynamicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_node_fill(s : DsgraphdynamicNode, v : Double) -> DsgraphdynamicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_node_min(s : DsgraphdynamicNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_node_max(s : DsgraphdynamicNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_node_to_string(s : DsgraphdynamicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_edge_make(size : Int) -> DsgraphdynamicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_edge_len(s : DsgraphdynamicEdge) -> Int { s.size }

pub fn ds_graph_dynamic_edge_get(s : DsgraphdynamicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_edge_set(s : DsgraphdynamicEdge, i : Int, v : Double) -> DsgraphdynamicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_edge_sum(s : DsgraphdynamicEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_edge_mean(s : DsgraphdynamicEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_edge_scale(s : DsgraphdynamicEdge, f : Double) -> DsgraphdynamicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_edge_add(a : DsgraphdynamicEdge, b : DsgraphdynamicEdge) -> DsgraphdynamicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_edge_copy(s : DsgraphdynamicEdge) -> DsgraphdynamicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_edge_fill(s : DsgraphdynamicEdge, v : Double) -> DsgraphdynamicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_edge_min(s : DsgraphdynamicEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_edge_max(s : DsgraphdynamicEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_edge_to_string(s : DsgraphdynamicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_path_make(size : Int) -> DsgraphdynamicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_path_len(s : DsgraphdynamicPath) -> Int { s.size }

pub fn ds_graph_dynamic_path_get(s : DsgraphdynamicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_path_set(s : DsgraphdynamicPath, i : Int, v : Double) -> DsgraphdynamicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_path_sum(s : DsgraphdynamicPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_path_mean(s : DsgraphdynamicPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_path_scale(s : DsgraphdynamicPath, f : Double) -> DsgraphdynamicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_path_add(a : DsgraphdynamicPath, b : DsgraphdynamicPath) -> DsgraphdynamicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_path_copy(s : DsgraphdynamicPath) -> DsgraphdynamicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_path_fill(s : DsgraphdynamicPath, v : Double) -> DsgraphdynamicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_path_min(s : DsgraphdynamicPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_path_max(s : DsgraphdynamicPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_path_to_string(s : DsgraphdynamicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_cluster_make(size : Int) -> DsgraphdynamicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_cluster_len(s : DsgraphdynamicCluster) -> Int { s.size }

pub fn ds_graph_dynamic_cluster_get(s : DsgraphdynamicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_cluster_set(s : DsgraphdynamicCluster, i : Int, v : Double) -> DsgraphdynamicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cluster_sum(s : DsgraphdynamicCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_cluster_mean(s : DsgraphdynamicCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_cluster_scale(s : DsgraphdynamicCluster, f : Double) -> DsgraphdynamicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cluster_add(a : DsgraphdynamicCluster, b : DsgraphdynamicCluster) -> DsgraphdynamicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_cluster_copy(s : DsgraphdynamicCluster) -> DsgraphdynamicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cluster_fill(s : DsgraphdynamicCluster, v : Double) -> DsgraphdynamicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cluster_min(s : DsgraphdynamicCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_cluster_max(s : DsgraphdynamicCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_cluster_to_string(s : DsgraphdynamicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_model_make(size : Int) -> DsgraphdynamicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_model_len(s : DsgraphdynamicModel) -> Int { s.size }

pub fn ds_graph_dynamic_model_get(s : DsgraphdynamicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_model_set(s : DsgraphdynamicModel, i : Int, v : Double) -> DsgraphdynamicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_model_sum(s : DsgraphdynamicModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_model_mean(s : DsgraphdynamicModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_model_scale(s : DsgraphdynamicModel, f : Double) -> DsgraphdynamicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_model_add(a : DsgraphdynamicModel, b : DsgraphdynamicModel) -> DsgraphdynamicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_model_copy(s : DsgraphdynamicModel) -> DsgraphdynamicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_model_fill(s : DsgraphdynamicModel, v : Double) -> DsgraphdynamicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_model_min(s : DsgraphdynamicModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_model_max(s : DsgraphdynamicModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_model_to_string(s : DsgraphdynamicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_layer_make(size : Int) -> DsgraphdynamicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_layer_len(s : DsgraphdynamicLayer) -> Int { s.size }

pub fn ds_graph_dynamic_layer_get(s : DsgraphdynamicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_layer_set(s : DsgraphdynamicLayer, i : Int, v : Double) -> DsgraphdynamicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_layer_sum(s : DsgraphdynamicLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_layer_mean(s : DsgraphdynamicLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_layer_scale(s : DsgraphdynamicLayer, f : Double) -> DsgraphdynamicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_layer_add(a : DsgraphdynamicLayer, b : DsgraphdynamicLayer) -> DsgraphdynamicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_layer_copy(s : DsgraphdynamicLayer) -> DsgraphdynamicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_layer_fill(s : DsgraphdynamicLayer, v : Double) -> DsgraphdynamicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_layer_min(s : DsgraphdynamicLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_layer_max(s : DsgraphdynamicLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_layer_to_string(s : DsgraphdynamicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_buffer_make(size : Int) -> DsgraphdynamicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_buffer_len(s : DsgraphdynamicBuffer) -> Int { s.size }

pub fn ds_graph_dynamic_buffer_get(s : DsgraphdynamicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_buffer_set(s : DsgraphdynamicBuffer, i : Int, v : Double) -> DsgraphdynamicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_buffer_sum(s : DsgraphdynamicBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_buffer_mean(s : DsgraphdynamicBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_buffer_scale(s : DsgraphdynamicBuffer, f : Double) -> DsgraphdynamicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_buffer_add(a : DsgraphdynamicBuffer, b : DsgraphdynamicBuffer) -> DsgraphdynamicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_buffer_copy(s : DsgraphdynamicBuffer) -> DsgraphdynamicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_buffer_fill(s : DsgraphdynamicBuffer, v : Double) -> DsgraphdynamicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_buffer_min(s : DsgraphdynamicBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_buffer_max(s : DsgraphdynamicBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_buffer_to_string(s : DsgraphdynamicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_cursor_make(size : Int) -> DsgraphdynamicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_cursor_len(s : DsgraphdynamicCursor) -> Int { s.size }

pub fn ds_graph_dynamic_cursor_get(s : DsgraphdynamicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_cursor_set(s : DsgraphdynamicCursor, i : Int, v : Double) -> DsgraphdynamicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cursor_sum(s : DsgraphdynamicCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_cursor_mean(s : DsgraphdynamicCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_cursor_scale(s : DsgraphdynamicCursor, f : Double) -> DsgraphdynamicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cursor_add(a : DsgraphdynamicCursor, b : DsgraphdynamicCursor) -> DsgraphdynamicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_cursor_copy(s : DsgraphdynamicCursor) -> DsgraphdynamicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cursor_fill(s : DsgraphdynamicCursor, v : Double) -> DsgraphdynamicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_cursor_min(s : DsgraphdynamicCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_cursor_max(s : DsgraphdynamicCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_cursor_to_string(s : DsgraphdynamicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_view_make(size : Int) -> DsgraphdynamicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_view_len(s : DsgraphdynamicView) -> Int { s.size }

pub fn ds_graph_dynamic_view_get(s : DsgraphdynamicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_view_set(s : DsgraphdynamicView, i : Int, v : Double) -> DsgraphdynamicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_view_sum(s : DsgraphdynamicView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_view_mean(s : DsgraphdynamicView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_view_scale(s : DsgraphdynamicView, f : Double) -> DsgraphdynamicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_view_add(a : DsgraphdynamicView, b : DsgraphdynamicView) -> DsgraphdynamicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_view_copy(s : DsgraphdynamicView) -> DsgraphdynamicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_view_fill(s : DsgraphdynamicView, v : Double) -> DsgraphdynamicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_view_min(s : DsgraphdynamicView) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_view_max(s : DsgraphdynamicView) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_view_to_string(s : DsgraphdynamicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_range_make(size : Int) -> DsgraphdynamicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_range_len(s : DsgraphdynamicRange) -> Int { s.size }

pub fn ds_graph_dynamic_range_get(s : DsgraphdynamicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_range_set(s : DsgraphdynamicRange, i : Int, v : Double) -> DsgraphdynamicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_range_sum(s : DsgraphdynamicRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_range_mean(s : DsgraphdynamicRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_range_scale(s : DsgraphdynamicRange, f : Double) -> DsgraphdynamicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_range_add(a : DsgraphdynamicRange, b : DsgraphdynamicRange) -> DsgraphdynamicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_range_copy(s : DsgraphdynamicRange) -> DsgraphdynamicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_range_fill(s : DsgraphdynamicRange, v : Double) -> DsgraphdynamicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_range_min(s : DsgraphdynamicRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_range_max(s : DsgraphdynamicRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_range_to_string(s : DsgraphdynamicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_slice_make(size : Int) -> DsgraphdynamicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_slice_len(s : DsgraphdynamicSlice) -> Int { s.size }

pub fn ds_graph_dynamic_slice_get(s : DsgraphdynamicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_slice_set(s : DsgraphdynamicSlice, i : Int, v : Double) -> DsgraphdynamicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_slice_sum(s : DsgraphdynamicSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_dynamic_slice_mean(s : DsgraphdynamicSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_dynamic_slice_scale(s : DsgraphdynamicSlice, f : Double) -> DsgraphdynamicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_slice_add(a : DsgraphdynamicSlice, b : DsgraphdynamicSlice) -> DsgraphdynamicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_dynamic_slice_copy(s : DsgraphdynamicSlice) -> DsgraphdynamicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_slice_fill(s : DsgraphdynamicSlice, v : Double) -> DsgraphdynamicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_dynamic_slice_min(s : DsgraphdynamicSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_dynamic_slice_max(s : DsgraphdynamicSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_dynamic_slice_to_string(s : DsgraphdynamicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

