///===
/// extcore/ds_graph_hyper

pub(all) struct DsgraphhyperPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_hyper_make_point(x : Double, y : Double) -> DsgraphhyperPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_hyper_make_point3(x : Double, y : Double, z : Double) -> DsgraphhyperPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphhyperPoint::x(self : DsgraphhyperPoint) -> Double { self.x }

pub fn DsgraphhyperPoint::y(self : DsgraphhyperPoint) -> Double { self.y }

pub fn DsgraphhyperPoint::z(self : DsgraphhyperPoint) -> Double { self.z }

pub fn DsgraphhyperPoint::label(self : DsgraphhyperPoint) -> Int { self.label }

pub fn DsgraphhyperPoint::dist(self : DsgraphhyperPoint, other : DsgraphhyperPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphhyperPoint::add(self : DsgraphhyperPoint, other : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphhyperPoint::sub(self : DsgraphhyperPoint, other : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphhyperPoint::scale(self : DsgraphhyperPoint, s : Double) -> DsgraphhyperPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphhyperPoint::dot(self : DsgraphhyperPoint, other : DsgraphhyperPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphhyperPoint::cross(self : DsgraphhyperPoint, other : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphhyperPoint::norm(self : DsgraphhyperPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphhyperPoint::normalize(self : DsgraphhyperPoint) -> DsgraphhyperPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphhyperPoint::negate(self : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphhyperPoint::mid(self : DsgraphhyperPoint, other : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphhyperPoint::lerp(self : DsgraphhyperPoint, other : DsgraphhyperPoint, t : Double) -> DsgraphhyperPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphhyperPoint::to_string(self : DsgraphhyperPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphhyperSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_hyper_make_series(vals : Array[Double], name : String) -> DsgraphhyperSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphhyperSeries::len(self : DsgraphhyperSeries) -> Int { self.vals.length() }

pub fn DsgraphhyperSeries::sum(self : DsgraphhyperSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphhyperSeries::mean(self : DsgraphhyperSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphhyperSeries::min(self : DsgraphhyperSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphhyperSeries::max(self : DsgraphhyperSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphhyperSeries::range(self : DsgraphhyperSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphhyperSeries::variance(self : DsgraphhyperSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphhyperSeries::std(self : DsgraphhyperSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphhyperSeries::median(self : DsgraphhyperSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphhyperSeries::scale(self : DsgraphhyperSeries, f : Double) -> DsgraphhyperSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphhyperSeries::add(self : DsgraphhyperSeries, other : DsgraphhyperSeries) -> DsgraphhyperSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphhyperSeries::sub(self : DsgraphhyperSeries, other : DsgraphhyperSeries) -> DsgraphhyperSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphhyperSeries::normalize(self : DsgraphhyperSeries) -> DsgraphhyperSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphhyperSeries::cumsum(self : DsgraphhyperSeries) -> DsgraphhyperSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphhyperSeries::to_string(self : DsgraphhyperSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphhyperMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_hyper_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphhyperMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_hyper_matrix_identity(n : Int) -> DsgraphhyperMatrix {
  let m = ds_graph_hyper_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphhyperMatrix::get(self : DsgraphhyperMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphhyperMatrix::transpose(self : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphhyperMatrix::add(self : DsgraphhyperMatrix, other : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_hyper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphhyperMatrix::scale(self : DsgraphhyperMatrix, s : Double) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphhyperMatrix::multiply(self : DsgraphhyperMatrix, other : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  if self.cols != other.rows { return ds_graph_hyper_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_hyper_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphhyperMatrix::trace(self : DsgraphhyperMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphhyperMatrix::det(self : DsgraphhyperMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphhyperMatrix::norm(self : DsgraphhyperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphhyperMatrix::to_string(self : DsgraphhyperMatrix) -> String {
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

pub(all) struct DsgraphhyperVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_hyper_make_vector(comps : Array[Double]) -> DsgraphhyperVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_hyper_vector_zero(dim : Int) -> DsgraphhyperVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphhyperVector::add(self : DsgraphhyperVector, other : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphhyperVector::sub(self : DsgraphhyperVector, other : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphhyperVector::scale(self : DsgraphhyperVector, s : Double) -> DsgraphhyperVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphhyperVector::dot(self : DsgraphhyperVector, other : DsgraphhyperVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphhyperVector::norm(self : DsgraphhyperVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphhyperVector::normalize(self : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphhyperVector::dist(self : DsgraphhyperVector, other : DsgraphhyperVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphhyperVector::to_string(self : DsgraphhyperVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_hyper_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_hyper_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_hyper_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_hyper_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_hyper_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_hyper_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_hyper_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_hyper_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_hyper_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_hyper_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_hyper_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_hyper_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_hyper_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_hyper_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_hyper_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_hyper_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_hyper_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_hyper_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_hyper_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_hyper_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_hyper_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_hyper_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_hyper_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_hyper_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_hyper_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_hyper_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_hyper_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_hyper_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_hyper_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphhyperFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_frame_make(size : Int) -> DsgraphhyperFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_frame_len(s : DsgraphhyperFrame) -> Int { s.size }

pub fn ds_graph_hyper_frame_get(s : DsgraphhyperFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_frame_set(s : DsgraphhyperFrame, i : Int, v : Double) -> DsgraphhyperFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_sum(s : DsgraphhyperFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_frame_mean(s : DsgraphhyperFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_frame_scale(s : DsgraphhyperFrame, f : Double) -> DsgraphhyperFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_add(a : DsgraphhyperFrame, b : DsgraphhyperFrame) -> DsgraphhyperFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_frame_copy(s : DsgraphhyperFrame) -> DsgraphhyperFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_fill(s : DsgraphhyperFrame, v : Double) -> DsgraphhyperFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_frame_min(s : DsgraphhyperFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_frame_max(s : DsgraphhyperFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_frame_to_string(s : DsgraphhyperFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_table_make(size : Int) -> DsgraphhyperTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_table_len(s : DsgraphhyperTable) -> Int { s.size }

pub fn ds_graph_hyper_table_get(s : DsgraphhyperTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_table_set(s : DsgraphhyperTable, i : Int, v : Double) -> DsgraphhyperTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_sum(s : DsgraphhyperTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_table_mean(s : DsgraphhyperTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_table_scale(s : DsgraphhyperTable, f : Double) -> DsgraphhyperTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_add(a : DsgraphhyperTable, b : DsgraphhyperTable) -> DsgraphhyperTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_table_copy(s : DsgraphhyperTable) -> DsgraphhyperTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_fill(s : DsgraphhyperTable, v : Double) -> DsgraphhyperTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_table_min(s : DsgraphhyperTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_table_max(s : DsgraphhyperTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_table_to_string(s : DsgraphhyperTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_graphn_make(size : Int) -> DsgraphhyperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_graphn_len(s : DsgraphhyperGraphN) -> Int { s.size }

pub fn ds_graph_hyper_graphn_get(s : DsgraphhyperGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_graphn_set(s : DsgraphhyperGraphN, i : Int, v : Double) -> DsgraphhyperGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_sum(s : DsgraphhyperGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_graphn_mean(s : DsgraphhyperGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_graphn_scale(s : DsgraphhyperGraphN, f : Double) -> DsgraphhyperGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_add(a : DsgraphhyperGraphN, b : DsgraphhyperGraphN) -> DsgraphhyperGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_graphn_copy(s : DsgraphhyperGraphN) -> DsgraphhyperGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_fill(s : DsgraphhyperGraphN, v : Double) -> DsgraphhyperGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_graphn_min(s : DsgraphhyperGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_graphn_max(s : DsgraphhyperGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_graphn_to_string(s : DsgraphhyperGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_node_make(size : Int) -> DsgraphhyperNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_node_len(s : DsgraphhyperNode) -> Int { s.size }

pub fn ds_graph_hyper_node_get(s : DsgraphhyperNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_node_set(s : DsgraphhyperNode, i : Int, v : Double) -> DsgraphhyperNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_sum(s : DsgraphhyperNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_node_mean(s : DsgraphhyperNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_node_scale(s : DsgraphhyperNode, f : Double) -> DsgraphhyperNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_add(a : DsgraphhyperNode, b : DsgraphhyperNode) -> DsgraphhyperNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_node_copy(s : DsgraphhyperNode) -> DsgraphhyperNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_fill(s : DsgraphhyperNode, v : Double) -> DsgraphhyperNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_node_min(s : DsgraphhyperNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_node_max(s : DsgraphhyperNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_node_to_string(s : DsgraphhyperNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_edge_make(size : Int) -> DsgraphhyperEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_edge_len(s : DsgraphhyperEdge) -> Int { s.size }

pub fn ds_graph_hyper_edge_get(s : DsgraphhyperEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_edge_set(s : DsgraphhyperEdge, i : Int, v : Double) -> DsgraphhyperEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_sum(s : DsgraphhyperEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_edge_mean(s : DsgraphhyperEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_edge_scale(s : DsgraphhyperEdge, f : Double) -> DsgraphhyperEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_add(a : DsgraphhyperEdge, b : DsgraphhyperEdge) -> DsgraphhyperEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_edge_copy(s : DsgraphhyperEdge) -> DsgraphhyperEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_fill(s : DsgraphhyperEdge, v : Double) -> DsgraphhyperEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_edge_min(s : DsgraphhyperEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_edge_max(s : DsgraphhyperEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_edge_to_string(s : DsgraphhyperEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_path_make(size : Int) -> DsgraphhyperPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_path_len(s : DsgraphhyperPath) -> Int { s.size }

pub fn ds_graph_hyper_path_get(s : DsgraphhyperPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_path_set(s : DsgraphhyperPath, i : Int, v : Double) -> DsgraphhyperPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_sum(s : DsgraphhyperPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_path_mean(s : DsgraphhyperPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_path_scale(s : DsgraphhyperPath, f : Double) -> DsgraphhyperPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_add(a : DsgraphhyperPath, b : DsgraphhyperPath) -> DsgraphhyperPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_path_copy(s : DsgraphhyperPath) -> DsgraphhyperPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_fill(s : DsgraphhyperPath, v : Double) -> DsgraphhyperPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_path_min(s : DsgraphhyperPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_path_max(s : DsgraphhyperPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_path_to_string(s : DsgraphhyperPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_cluster_make(size : Int) -> DsgraphhyperCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_cluster_len(s : DsgraphhyperCluster) -> Int { s.size }

pub fn ds_graph_hyper_cluster_get(s : DsgraphhyperCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_cluster_set(s : DsgraphhyperCluster, i : Int, v : Double) -> DsgraphhyperCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_sum(s : DsgraphhyperCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_cluster_mean(s : DsgraphhyperCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_cluster_scale(s : DsgraphhyperCluster, f : Double) -> DsgraphhyperCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_add(a : DsgraphhyperCluster, b : DsgraphhyperCluster) -> DsgraphhyperCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_cluster_copy(s : DsgraphhyperCluster) -> DsgraphhyperCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_fill(s : DsgraphhyperCluster, v : Double) -> DsgraphhyperCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cluster_min(s : DsgraphhyperCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_cluster_max(s : DsgraphhyperCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_cluster_to_string(s : DsgraphhyperCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_model_make(size : Int) -> DsgraphhyperModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_model_len(s : DsgraphhyperModel) -> Int { s.size }

pub fn ds_graph_hyper_model_get(s : DsgraphhyperModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_model_set(s : DsgraphhyperModel, i : Int, v : Double) -> DsgraphhyperModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_sum(s : DsgraphhyperModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_model_mean(s : DsgraphhyperModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_model_scale(s : DsgraphhyperModel, f : Double) -> DsgraphhyperModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_add(a : DsgraphhyperModel, b : DsgraphhyperModel) -> DsgraphhyperModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_model_copy(s : DsgraphhyperModel) -> DsgraphhyperModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_fill(s : DsgraphhyperModel, v : Double) -> DsgraphhyperModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_model_min(s : DsgraphhyperModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_model_max(s : DsgraphhyperModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_model_to_string(s : DsgraphhyperModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_layer_make(size : Int) -> DsgraphhyperLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_layer_len(s : DsgraphhyperLayer) -> Int { s.size }

pub fn ds_graph_hyper_layer_get(s : DsgraphhyperLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_layer_set(s : DsgraphhyperLayer, i : Int, v : Double) -> DsgraphhyperLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_sum(s : DsgraphhyperLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_layer_mean(s : DsgraphhyperLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_layer_scale(s : DsgraphhyperLayer, f : Double) -> DsgraphhyperLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_add(a : DsgraphhyperLayer, b : DsgraphhyperLayer) -> DsgraphhyperLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_layer_copy(s : DsgraphhyperLayer) -> DsgraphhyperLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_fill(s : DsgraphhyperLayer, v : Double) -> DsgraphhyperLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_layer_min(s : DsgraphhyperLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_layer_max(s : DsgraphhyperLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_layer_to_string(s : DsgraphhyperLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_buffer_make(size : Int) -> DsgraphhyperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_buffer_len(s : DsgraphhyperBuffer) -> Int { s.size }

pub fn ds_graph_hyper_buffer_get(s : DsgraphhyperBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_buffer_set(s : DsgraphhyperBuffer, i : Int, v : Double) -> DsgraphhyperBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_sum(s : DsgraphhyperBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_buffer_mean(s : DsgraphhyperBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_buffer_scale(s : DsgraphhyperBuffer, f : Double) -> DsgraphhyperBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_add(a : DsgraphhyperBuffer, b : DsgraphhyperBuffer) -> DsgraphhyperBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_buffer_copy(s : DsgraphhyperBuffer) -> DsgraphhyperBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_fill(s : DsgraphhyperBuffer, v : Double) -> DsgraphhyperBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_buffer_min(s : DsgraphhyperBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_buffer_max(s : DsgraphhyperBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_buffer_to_string(s : DsgraphhyperBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_cursor_make(size : Int) -> DsgraphhyperCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_cursor_len(s : DsgraphhyperCursor) -> Int { s.size }

pub fn ds_graph_hyper_cursor_get(s : DsgraphhyperCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_cursor_set(s : DsgraphhyperCursor, i : Int, v : Double) -> DsgraphhyperCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_sum(s : DsgraphhyperCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_cursor_mean(s : DsgraphhyperCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_cursor_scale(s : DsgraphhyperCursor, f : Double) -> DsgraphhyperCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_add(a : DsgraphhyperCursor, b : DsgraphhyperCursor) -> DsgraphhyperCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_cursor_copy(s : DsgraphhyperCursor) -> DsgraphhyperCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_fill(s : DsgraphhyperCursor, v : Double) -> DsgraphhyperCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_cursor_min(s : DsgraphhyperCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_cursor_max(s : DsgraphhyperCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_cursor_to_string(s : DsgraphhyperCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_view_make(size : Int) -> DsgraphhyperView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_view_len(s : DsgraphhyperView) -> Int { s.size }

pub fn ds_graph_hyper_view_get(s : DsgraphhyperView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_view_set(s : DsgraphhyperView, i : Int, v : Double) -> DsgraphhyperView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_sum(s : DsgraphhyperView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_view_mean(s : DsgraphhyperView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_view_scale(s : DsgraphhyperView, f : Double) -> DsgraphhyperView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_add(a : DsgraphhyperView, b : DsgraphhyperView) -> DsgraphhyperView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_view_copy(s : DsgraphhyperView) -> DsgraphhyperView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_fill(s : DsgraphhyperView, v : Double) -> DsgraphhyperView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_view_min(s : DsgraphhyperView) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_view_max(s : DsgraphhyperView) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_view_to_string(s : DsgraphhyperView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_range_make(size : Int) -> DsgraphhyperRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_range_len(s : DsgraphhyperRange) -> Int { s.size }

pub fn ds_graph_hyper_range_get(s : DsgraphhyperRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_range_set(s : DsgraphhyperRange, i : Int, v : Double) -> DsgraphhyperRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_sum(s : DsgraphhyperRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_range_mean(s : DsgraphhyperRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_range_scale(s : DsgraphhyperRange, f : Double) -> DsgraphhyperRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_add(a : DsgraphhyperRange, b : DsgraphhyperRange) -> DsgraphhyperRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_range_copy(s : DsgraphhyperRange) -> DsgraphhyperRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_fill(s : DsgraphhyperRange, v : Double) -> DsgraphhyperRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_range_min(s : DsgraphhyperRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_range_max(s : DsgraphhyperRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_range_to_string(s : DsgraphhyperRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_slice_make(size : Int) -> DsgraphhyperSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_slice_len(s : DsgraphhyperSlice) -> Int { s.size }

pub fn ds_graph_hyper_slice_get(s : DsgraphhyperSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_slice_set(s : DsgraphhyperSlice, i : Int, v : Double) -> DsgraphhyperSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_sum(s : DsgraphhyperSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_hyper_slice_mean(s : DsgraphhyperSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_hyper_slice_scale(s : DsgraphhyperSlice, f : Double) -> DsgraphhyperSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_add(a : DsgraphhyperSlice, b : DsgraphhyperSlice) -> DsgraphhyperSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_hyper_slice_copy(s : DsgraphhyperSlice) -> DsgraphhyperSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_fill(s : DsgraphhyperSlice, v : Double) -> DsgraphhyperSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_hyper_slice_min(s : DsgraphhyperSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_hyper_slice_max(s : DsgraphhyperSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_hyper_slice_to_string(s : DsgraphhyperSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

