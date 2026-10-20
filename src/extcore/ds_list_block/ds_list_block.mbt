///===
/// extcore/ds_list_block

pub(all) struct DslistblockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_block_make_point(x : Double, y : Double) -> DslistblockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_block_make_point3(x : Double, y : Double, z : Double) -> DslistblockPoint {
  { x, y, z, label: 0 }
}

pub fn DslistblockPoint::x(self : DslistblockPoint) -> Double { self.x }

pub fn DslistblockPoint::y(self : DslistblockPoint) -> Double { self.y }

pub fn DslistblockPoint::z(self : DslistblockPoint) -> Double { self.z }

pub fn DslistblockPoint::label(self : DslistblockPoint) -> Int { self.label }

pub fn DslistblockPoint::dist(self : DslistblockPoint, other : DslistblockPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistblockPoint::add(self : DslistblockPoint, other : DslistblockPoint) -> DslistblockPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistblockPoint::sub(self : DslistblockPoint, other : DslistblockPoint) -> DslistblockPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistblockPoint::scale(self : DslistblockPoint, s : Double) -> DslistblockPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistblockPoint::dot(self : DslistblockPoint, other : DslistblockPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistblockPoint::cross(self : DslistblockPoint, other : DslistblockPoint) -> DslistblockPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistblockPoint::norm(self : DslistblockPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistblockPoint::normalize(self : DslistblockPoint) -> DslistblockPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistblockPoint::negate(self : DslistblockPoint) -> DslistblockPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistblockPoint::mid(self : DslistblockPoint, other : DslistblockPoint) -> DslistblockPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistblockPoint::lerp(self : DslistblockPoint, other : DslistblockPoint, t : Double) -> DslistblockPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistblockPoint::to_string(self : DslistblockPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistblockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_block_make_series(vals : Array[Double], name : String) -> DslistblockSeries {
  { vals, name, meta: 0 }
}

pub fn DslistblockSeries::len(self : DslistblockSeries) -> Int { self.vals.length() }

pub fn DslistblockSeries::sum(self : DslistblockSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistblockSeries::mean(self : DslistblockSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistblockSeries::min(self : DslistblockSeries) -> Double { @_common.min(self.vals) }

pub fn DslistblockSeries::max(self : DslistblockSeries) -> Double { @_common.max(self.vals) }

pub fn DslistblockSeries::range(self : DslistblockSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistblockSeries::variance(self : DslistblockSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistblockSeries::std(self : DslistblockSeries) -> Double { @_common.std(self.vals) }

pub fn DslistblockSeries::median(self : DslistblockSeries) -> Double { @_common.median(self.vals) }

pub fn DslistblockSeries::scale(self : DslistblockSeries, f : Double) -> DslistblockSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistblockSeries::add(self : DslistblockSeries, other : DslistblockSeries) -> DslistblockSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistblockSeries::sub(self : DslistblockSeries, other : DslistblockSeries) -> DslistblockSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistblockSeries::normalize(self : DslistblockSeries) -> DslistblockSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistblockSeries::cumsum(self : DslistblockSeries) -> DslistblockSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistblockSeries::to_string(self : DslistblockSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistblockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_block_make_matrix(rows : Int, cols : Int, val : Double) -> DslistblockMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_block_matrix_identity(n : Int) -> DslistblockMatrix {
  let m = ds_list_block_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistblockMatrix::get(self : DslistblockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistblockMatrix::transpose(self : DslistblockMatrix) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistblockMatrix::add(self : DslistblockMatrix, other : DslistblockMatrix) -> DslistblockMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_block_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistblockMatrix::scale(self : DslistblockMatrix, s : Double) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistblockMatrix::multiply(self : DslistblockMatrix, other : DslistblockMatrix) -> DslistblockMatrix {
  if self.cols != other.rows { return ds_list_block_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_block_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistblockMatrix::trace(self : DslistblockMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistblockMatrix::det(self : DslistblockMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistblockMatrix::norm(self : DslistblockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistblockMatrix::to_string(self : DslistblockMatrix) -> String {
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

pub(all) struct DslistblockVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_block_make_vector(comps : Array[Double]) -> DslistblockVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_block_vector_zero(dim : Int) -> DslistblockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistblockVector::add(self : DslistblockVector, other : DslistblockVector) -> DslistblockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistblockVector::sub(self : DslistblockVector, other : DslistblockVector) -> DslistblockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistblockVector::scale(self : DslistblockVector, s : Double) -> DslistblockVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistblockVector::dot(self : DslistblockVector, other : DslistblockVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistblockVector::norm(self : DslistblockVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistblockVector::normalize(self : DslistblockVector) -> DslistblockVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistblockVector::dist(self : DslistblockVector, other : DslistblockVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistblockVector::to_string(self : DslistblockVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_block_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_block_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_block_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_block_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_block_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_block_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_block_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_block_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_block_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_block_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_block_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_block_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_block_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_block_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_block_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_block_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_block_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_block_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_block_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_block_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_block_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_block_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_block_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_block_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_block_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_block_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_block_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_block_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_block_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistblockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_frame_make(size : Int) -> DslistblockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_frame_len(s : DslistblockFrame) -> Int { s.size }

pub fn ds_list_block_frame_get(s : DslistblockFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_frame_set(s : DslistblockFrame, i : Int, v : Double) -> DslistblockFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_sum(s : DslistblockFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_frame_mean(s : DslistblockFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_frame_scale(s : DslistblockFrame, f : Double) -> DslistblockFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_add(a : DslistblockFrame, b : DslistblockFrame) -> DslistblockFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_frame_copy(s : DslistblockFrame) -> DslistblockFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_fill(s : DslistblockFrame, v : Double) -> DslistblockFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_frame_min(s : DslistblockFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_block_frame_max(s : DslistblockFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_block_frame_to_string(s : DslistblockFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_table_make(size : Int) -> DslistblockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_table_len(s : DslistblockTable) -> Int { s.size }

pub fn ds_list_block_table_get(s : DslistblockTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_table_set(s : DslistblockTable, i : Int, v : Double) -> DslistblockTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_sum(s : DslistblockTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_table_mean(s : DslistblockTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_table_scale(s : DslistblockTable, f : Double) -> DslistblockTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_add(a : DslistblockTable, b : DslistblockTable) -> DslistblockTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_table_copy(s : DslistblockTable) -> DslistblockTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_fill(s : DslistblockTable, v : Double) -> DslistblockTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_table_min(s : DslistblockTable) -> Double { @_common.min(s.data) }

pub fn ds_list_block_table_max(s : DslistblockTable) -> Double { @_common.max(s.data) }

pub fn ds_list_block_table_to_string(s : DslistblockTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_graphn_make(size : Int) -> DslistblockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_graphn_len(s : DslistblockGraphN) -> Int { s.size }

pub fn ds_list_block_graphn_get(s : DslistblockGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_graphn_set(s : DslistblockGraphN, i : Int, v : Double) -> DslistblockGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_sum(s : DslistblockGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_graphn_mean(s : DslistblockGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_graphn_scale(s : DslistblockGraphN, f : Double) -> DslistblockGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_add(a : DslistblockGraphN, b : DslistblockGraphN) -> DslistblockGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_graphn_copy(s : DslistblockGraphN) -> DslistblockGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_fill(s : DslistblockGraphN, v : Double) -> DslistblockGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_graphn_min(s : DslistblockGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_block_graphn_max(s : DslistblockGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_block_graphn_to_string(s : DslistblockGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_node_make(size : Int) -> DslistblockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_node_len(s : DslistblockNode) -> Int { s.size }

pub fn ds_list_block_node_get(s : DslistblockNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_node_set(s : DslistblockNode, i : Int, v : Double) -> DslistblockNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_sum(s : DslistblockNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_node_mean(s : DslistblockNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_node_scale(s : DslistblockNode, f : Double) -> DslistblockNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_add(a : DslistblockNode, b : DslistblockNode) -> DslistblockNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_node_copy(s : DslistblockNode) -> DslistblockNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_fill(s : DslistblockNode, v : Double) -> DslistblockNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_node_min(s : DslistblockNode) -> Double { @_common.min(s.data) }

pub fn ds_list_block_node_max(s : DslistblockNode) -> Double { @_common.max(s.data) }

pub fn ds_list_block_node_to_string(s : DslistblockNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_edge_make(size : Int) -> DslistblockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_edge_len(s : DslistblockEdge) -> Int { s.size }

pub fn ds_list_block_edge_get(s : DslistblockEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_edge_set(s : DslistblockEdge, i : Int, v : Double) -> DslistblockEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_sum(s : DslistblockEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_edge_mean(s : DslistblockEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_edge_scale(s : DslistblockEdge, f : Double) -> DslistblockEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_add(a : DslistblockEdge, b : DslistblockEdge) -> DslistblockEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_edge_copy(s : DslistblockEdge) -> DslistblockEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_fill(s : DslistblockEdge, v : Double) -> DslistblockEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_edge_min(s : DslistblockEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_block_edge_max(s : DslistblockEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_block_edge_to_string(s : DslistblockEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_path_make(size : Int) -> DslistblockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_path_len(s : DslistblockPath) -> Int { s.size }

pub fn ds_list_block_path_get(s : DslistblockPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_path_set(s : DslistblockPath, i : Int, v : Double) -> DslistblockPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_sum(s : DslistblockPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_path_mean(s : DslistblockPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_path_scale(s : DslistblockPath, f : Double) -> DslistblockPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_add(a : DslistblockPath, b : DslistblockPath) -> DslistblockPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_path_copy(s : DslistblockPath) -> DslistblockPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_fill(s : DslistblockPath, v : Double) -> DslistblockPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_path_min(s : DslistblockPath) -> Double { @_common.min(s.data) }

pub fn ds_list_block_path_max(s : DslistblockPath) -> Double { @_common.max(s.data) }

pub fn ds_list_block_path_to_string(s : DslistblockPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_cluster_make(size : Int) -> DslistblockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_cluster_len(s : DslistblockCluster) -> Int { s.size }

pub fn ds_list_block_cluster_get(s : DslistblockCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_cluster_set(s : DslistblockCluster, i : Int, v : Double) -> DslistblockCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_sum(s : DslistblockCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_cluster_mean(s : DslistblockCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_cluster_scale(s : DslistblockCluster, f : Double) -> DslistblockCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_add(a : DslistblockCluster, b : DslistblockCluster) -> DslistblockCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_cluster_copy(s : DslistblockCluster) -> DslistblockCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_fill(s : DslistblockCluster, v : Double) -> DslistblockCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cluster_min(s : DslistblockCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_block_cluster_max(s : DslistblockCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_block_cluster_to_string(s : DslistblockCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_model_make(size : Int) -> DslistblockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_model_len(s : DslistblockModel) -> Int { s.size }

pub fn ds_list_block_model_get(s : DslistblockModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_model_set(s : DslistblockModel, i : Int, v : Double) -> DslistblockModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_sum(s : DslistblockModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_model_mean(s : DslistblockModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_model_scale(s : DslistblockModel, f : Double) -> DslistblockModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_add(a : DslistblockModel, b : DslistblockModel) -> DslistblockModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_model_copy(s : DslistblockModel) -> DslistblockModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_fill(s : DslistblockModel, v : Double) -> DslistblockModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_model_min(s : DslistblockModel) -> Double { @_common.min(s.data) }

pub fn ds_list_block_model_max(s : DslistblockModel) -> Double { @_common.max(s.data) }

pub fn ds_list_block_model_to_string(s : DslistblockModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_layer_make(size : Int) -> DslistblockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_layer_len(s : DslistblockLayer) -> Int { s.size }

pub fn ds_list_block_layer_get(s : DslistblockLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_layer_set(s : DslistblockLayer, i : Int, v : Double) -> DslistblockLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_sum(s : DslistblockLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_layer_mean(s : DslistblockLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_layer_scale(s : DslistblockLayer, f : Double) -> DslistblockLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_add(a : DslistblockLayer, b : DslistblockLayer) -> DslistblockLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_layer_copy(s : DslistblockLayer) -> DslistblockLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_fill(s : DslistblockLayer, v : Double) -> DslistblockLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_layer_min(s : DslistblockLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_block_layer_max(s : DslistblockLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_block_layer_to_string(s : DslistblockLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_buffer_make(size : Int) -> DslistblockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_buffer_len(s : DslistblockBuffer) -> Int { s.size }

pub fn ds_list_block_buffer_get(s : DslistblockBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_buffer_set(s : DslistblockBuffer, i : Int, v : Double) -> DslistblockBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_sum(s : DslistblockBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_buffer_mean(s : DslistblockBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_buffer_scale(s : DslistblockBuffer, f : Double) -> DslistblockBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_add(a : DslistblockBuffer, b : DslistblockBuffer) -> DslistblockBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_buffer_copy(s : DslistblockBuffer) -> DslistblockBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_fill(s : DslistblockBuffer, v : Double) -> DslistblockBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_buffer_min(s : DslistblockBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_block_buffer_max(s : DslistblockBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_block_buffer_to_string(s : DslistblockBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_cursor_make(size : Int) -> DslistblockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_cursor_len(s : DslistblockCursor) -> Int { s.size }

pub fn ds_list_block_cursor_get(s : DslistblockCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_cursor_set(s : DslistblockCursor, i : Int, v : Double) -> DslistblockCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_sum(s : DslistblockCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_cursor_mean(s : DslistblockCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_cursor_scale(s : DslistblockCursor, f : Double) -> DslistblockCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_add(a : DslistblockCursor, b : DslistblockCursor) -> DslistblockCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_cursor_copy(s : DslistblockCursor) -> DslistblockCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_fill(s : DslistblockCursor, v : Double) -> DslistblockCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_cursor_min(s : DslistblockCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_block_cursor_max(s : DslistblockCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_block_cursor_to_string(s : DslistblockCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_view_make(size : Int) -> DslistblockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_view_len(s : DslistblockView) -> Int { s.size }

pub fn ds_list_block_view_get(s : DslistblockView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_view_set(s : DslistblockView, i : Int, v : Double) -> DslistblockView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_sum(s : DslistblockView) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_view_mean(s : DslistblockView) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_view_scale(s : DslistblockView, f : Double) -> DslistblockView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_add(a : DslistblockView, b : DslistblockView) -> DslistblockView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_view_copy(s : DslistblockView) -> DslistblockView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_fill(s : DslistblockView, v : Double) -> DslistblockView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_view_min(s : DslistblockView) -> Double { @_common.min(s.data) }

pub fn ds_list_block_view_max(s : DslistblockView) -> Double { @_common.max(s.data) }

pub fn ds_list_block_view_to_string(s : DslistblockView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_range_make(size : Int) -> DslistblockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_range_len(s : DslistblockRange) -> Int { s.size }

pub fn ds_list_block_range_get(s : DslistblockRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_range_set(s : DslistblockRange, i : Int, v : Double) -> DslistblockRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_sum(s : DslistblockRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_range_mean(s : DslistblockRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_range_scale(s : DslistblockRange, f : Double) -> DslistblockRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_add(a : DslistblockRange, b : DslistblockRange) -> DslistblockRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_range_copy(s : DslistblockRange) -> DslistblockRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_fill(s : DslistblockRange, v : Double) -> DslistblockRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_range_min(s : DslistblockRange) -> Double { @_common.min(s.data) }

pub fn ds_list_block_range_max(s : DslistblockRange) -> Double { @_common.max(s.data) }

pub fn ds_list_block_range_to_string(s : DslistblockRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_slice_make(size : Int) -> DslistblockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_slice_len(s : DslistblockSlice) -> Int { s.size }

pub fn ds_list_block_slice_get(s : DslistblockSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_slice_set(s : DslistblockSlice, i : Int, v : Double) -> DslistblockSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_sum(s : DslistblockSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_block_slice_mean(s : DslistblockSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_block_slice_scale(s : DslistblockSlice, f : Double) -> DslistblockSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_add(a : DslistblockSlice, b : DslistblockSlice) -> DslistblockSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_block_slice_copy(s : DslistblockSlice) -> DslistblockSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_fill(s : DslistblockSlice, v : Double) -> DslistblockSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_block_slice_min(s : DslistblockSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_block_slice_max(s : DslistblockSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_block_slice_to_string(s : DslistblockSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

