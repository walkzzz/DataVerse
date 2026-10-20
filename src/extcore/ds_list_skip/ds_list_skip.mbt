///===
/// extcore/ds_list_skip

pub(all) struct DslistskipPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_skip_make_point(x : Double, y : Double) -> DslistskipPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_skip_make_point3(x : Double, y : Double, z : Double) -> DslistskipPoint {
  { x, y, z, label: 0 }
}

pub fn DslistskipPoint::x(self : DslistskipPoint) -> Double { self.x }

pub fn DslistskipPoint::y(self : DslistskipPoint) -> Double { self.y }

pub fn DslistskipPoint::z(self : DslistskipPoint) -> Double { self.z }

pub fn DslistskipPoint::label(self : DslistskipPoint) -> Int { self.label }

pub fn DslistskipPoint::dist(self : DslistskipPoint, other : DslistskipPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistskipPoint::add(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistskipPoint::sub(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistskipPoint::scale(self : DslistskipPoint, s : Double) -> DslistskipPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistskipPoint::dot(self : DslistskipPoint, other : DslistskipPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistskipPoint::cross(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistskipPoint::norm(self : DslistskipPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistskipPoint::normalize(self : DslistskipPoint) -> DslistskipPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistskipPoint::negate(self : DslistskipPoint) -> DslistskipPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistskipPoint::mid(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistskipPoint::lerp(self : DslistskipPoint, other : DslistskipPoint, t : Double) -> DslistskipPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistskipPoint::to_string(self : DslistskipPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistskipSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_skip_make_series(vals : Array[Double], name : String) -> DslistskipSeries {
  { vals, name, meta: 0 }
}

pub fn DslistskipSeries::len(self : DslistskipSeries) -> Int { self.vals.length() }

pub fn DslistskipSeries::sum(self : DslistskipSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistskipSeries::mean(self : DslistskipSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistskipSeries::min(self : DslistskipSeries) -> Double { @_common.min(self.vals) }

pub fn DslistskipSeries::max(self : DslistskipSeries) -> Double { @_common.max(self.vals) }

pub fn DslistskipSeries::range(self : DslistskipSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistskipSeries::variance(self : DslistskipSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistskipSeries::std(self : DslistskipSeries) -> Double { @_common.std(self.vals) }

pub fn DslistskipSeries::median(self : DslistskipSeries) -> Double { @_common.median(self.vals) }

pub fn DslistskipSeries::scale(self : DslistskipSeries, f : Double) -> DslistskipSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistskipSeries::add(self : DslistskipSeries, other : DslistskipSeries) -> DslistskipSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistskipSeries::sub(self : DslistskipSeries, other : DslistskipSeries) -> DslistskipSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistskipSeries::normalize(self : DslistskipSeries) -> DslistskipSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistskipSeries::cumsum(self : DslistskipSeries) -> DslistskipSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistskipSeries::to_string(self : DslistskipSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistskipMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_skip_make_matrix(rows : Int, cols : Int, val : Double) -> DslistskipMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_skip_matrix_identity(n : Int) -> DslistskipMatrix {
  let m = ds_list_skip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistskipMatrix::get(self : DslistskipMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistskipMatrix::transpose(self : DslistskipMatrix) -> DslistskipMatrix {
  let result = ds_list_skip_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistskipMatrix::add(self : DslistskipMatrix, other : DslistskipMatrix) -> DslistskipMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_skip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistskipMatrix::scale(self : DslistskipMatrix, s : Double) -> DslistskipMatrix {
  let result = ds_list_skip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistskipMatrix::multiply(self : DslistskipMatrix, other : DslistskipMatrix) -> DslistskipMatrix {
  if self.cols != other.rows { return ds_list_skip_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_skip_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistskipMatrix::trace(self : DslistskipMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistskipMatrix::det(self : DslistskipMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistskipMatrix::norm(self : DslistskipMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistskipMatrix::to_string(self : DslistskipMatrix) -> String {
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

pub(all) struct DslistskipVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_skip_make_vector(comps : Array[Double]) -> DslistskipVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_skip_vector_zero(dim : Int) -> DslistskipVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistskipVector::add(self : DslistskipVector, other : DslistskipVector) -> DslistskipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistskipVector::sub(self : DslistskipVector, other : DslistskipVector) -> DslistskipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistskipVector::scale(self : DslistskipVector, s : Double) -> DslistskipVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistskipVector::dot(self : DslistskipVector, other : DslistskipVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistskipVector::norm(self : DslistskipVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistskipVector::normalize(self : DslistskipVector) -> DslistskipVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistskipVector::dist(self : DslistskipVector, other : DslistskipVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistskipVector::to_string(self : DslistskipVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_skip_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_skip_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_skip_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_skip_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_skip_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_skip_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_skip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_skip_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_skip_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_skip_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_skip_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_skip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_skip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_skip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_skip_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_skip_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_skip_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_skip_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_skip_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_skip_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_skip_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_skip_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_skip_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_skip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_skip_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_skip_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_skip_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_skip_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_skip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistskipFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_frame_make(size : Int) -> DslistskipFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_frame_len(s : DslistskipFrame) -> Int { s.size }

pub fn ds_list_skip_frame_get(s : DslistskipFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_frame_set(s : DslistskipFrame, i : Int, v : Double) -> DslistskipFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_frame_sum(s : DslistskipFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_frame_mean(s : DslistskipFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_frame_scale(s : DslistskipFrame, f : Double) -> DslistskipFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_frame_add(a : DslistskipFrame, b : DslistskipFrame) -> DslistskipFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_frame_copy(s : DslistskipFrame) -> DslistskipFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_frame_fill(s : DslistskipFrame, v : Double) -> DslistskipFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_frame_min(s : DslistskipFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_frame_max(s : DslistskipFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_frame_to_string(s : DslistskipFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_table_make(size : Int) -> DslistskipTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_table_len(s : DslistskipTable) -> Int { s.size }

pub fn ds_list_skip_table_get(s : DslistskipTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_table_set(s : DslistskipTable, i : Int, v : Double) -> DslistskipTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_table_sum(s : DslistskipTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_table_mean(s : DslistskipTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_table_scale(s : DslistskipTable, f : Double) -> DslistskipTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_table_add(a : DslistskipTable, b : DslistskipTable) -> DslistskipTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_table_copy(s : DslistskipTable) -> DslistskipTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_table_fill(s : DslistskipTable, v : Double) -> DslistskipTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_table_min(s : DslistskipTable) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_table_max(s : DslistskipTable) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_table_to_string(s : DslistskipTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_graphn_make(size : Int) -> DslistskipGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_graphn_len(s : DslistskipGraphN) -> Int { s.size }

pub fn ds_list_skip_graphn_get(s : DslistskipGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_graphn_set(s : DslistskipGraphN, i : Int, v : Double) -> DslistskipGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_graphn_sum(s : DslistskipGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_graphn_mean(s : DslistskipGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_graphn_scale(s : DslistskipGraphN, f : Double) -> DslistskipGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_graphn_add(a : DslistskipGraphN, b : DslistskipGraphN) -> DslistskipGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_graphn_copy(s : DslistskipGraphN) -> DslistskipGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_graphn_fill(s : DslistskipGraphN, v : Double) -> DslistskipGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_graphn_min(s : DslistskipGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_graphn_max(s : DslistskipGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_graphn_to_string(s : DslistskipGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_node_make(size : Int) -> DslistskipNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_node_len(s : DslistskipNode) -> Int { s.size }

pub fn ds_list_skip_node_get(s : DslistskipNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_node_set(s : DslistskipNode, i : Int, v : Double) -> DslistskipNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_node_sum(s : DslistskipNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_node_mean(s : DslistskipNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_node_scale(s : DslistskipNode, f : Double) -> DslistskipNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_node_add(a : DslistskipNode, b : DslistskipNode) -> DslistskipNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_node_copy(s : DslistskipNode) -> DslistskipNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_node_fill(s : DslistskipNode, v : Double) -> DslistskipNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_node_min(s : DslistskipNode) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_node_max(s : DslistskipNode) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_node_to_string(s : DslistskipNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_edge_make(size : Int) -> DslistskipEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_edge_len(s : DslistskipEdge) -> Int { s.size }

pub fn ds_list_skip_edge_get(s : DslistskipEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_edge_set(s : DslistskipEdge, i : Int, v : Double) -> DslistskipEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_edge_sum(s : DslistskipEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_edge_mean(s : DslistskipEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_edge_scale(s : DslistskipEdge, f : Double) -> DslistskipEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_edge_add(a : DslistskipEdge, b : DslistskipEdge) -> DslistskipEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_edge_copy(s : DslistskipEdge) -> DslistskipEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_edge_fill(s : DslistskipEdge, v : Double) -> DslistskipEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_edge_min(s : DslistskipEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_edge_max(s : DslistskipEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_edge_to_string(s : DslistskipEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_path_make(size : Int) -> DslistskipPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_path_len(s : DslistskipPath) -> Int { s.size }

pub fn ds_list_skip_path_get(s : DslistskipPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_path_set(s : DslistskipPath, i : Int, v : Double) -> DslistskipPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_path_sum(s : DslistskipPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_path_mean(s : DslistskipPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_path_scale(s : DslistskipPath, f : Double) -> DslistskipPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_path_add(a : DslistskipPath, b : DslistskipPath) -> DslistskipPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_path_copy(s : DslistskipPath) -> DslistskipPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_path_fill(s : DslistskipPath, v : Double) -> DslistskipPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_path_min(s : DslistskipPath) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_path_max(s : DslistskipPath) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_path_to_string(s : DslistskipPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_cluster_make(size : Int) -> DslistskipCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_cluster_len(s : DslistskipCluster) -> Int { s.size }

pub fn ds_list_skip_cluster_get(s : DslistskipCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_cluster_set(s : DslistskipCluster, i : Int, v : Double) -> DslistskipCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cluster_sum(s : DslistskipCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_cluster_mean(s : DslistskipCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_cluster_scale(s : DslistskipCluster, f : Double) -> DslistskipCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cluster_add(a : DslistskipCluster, b : DslistskipCluster) -> DslistskipCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_cluster_copy(s : DslistskipCluster) -> DslistskipCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cluster_fill(s : DslistskipCluster, v : Double) -> DslistskipCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cluster_min(s : DslistskipCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_cluster_max(s : DslistskipCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_cluster_to_string(s : DslistskipCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_model_make(size : Int) -> DslistskipModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_model_len(s : DslistskipModel) -> Int { s.size }

pub fn ds_list_skip_model_get(s : DslistskipModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_model_set(s : DslistskipModel, i : Int, v : Double) -> DslistskipModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_model_sum(s : DslistskipModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_model_mean(s : DslistskipModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_model_scale(s : DslistskipModel, f : Double) -> DslistskipModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_model_add(a : DslistskipModel, b : DslistskipModel) -> DslistskipModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_model_copy(s : DslistskipModel) -> DslistskipModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_model_fill(s : DslistskipModel, v : Double) -> DslistskipModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_model_min(s : DslistskipModel) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_model_max(s : DslistskipModel) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_model_to_string(s : DslistskipModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_layer_make(size : Int) -> DslistskipLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_layer_len(s : DslistskipLayer) -> Int { s.size }

pub fn ds_list_skip_layer_get(s : DslistskipLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_layer_set(s : DslistskipLayer, i : Int, v : Double) -> DslistskipLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_layer_sum(s : DslistskipLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_layer_mean(s : DslistskipLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_layer_scale(s : DslistskipLayer, f : Double) -> DslistskipLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_layer_add(a : DslistskipLayer, b : DslistskipLayer) -> DslistskipLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_layer_copy(s : DslistskipLayer) -> DslistskipLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_layer_fill(s : DslistskipLayer, v : Double) -> DslistskipLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_layer_min(s : DslistskipLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_layer_max(s : DslistskipLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_layer_to_string(s : DslistskipLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_buffer_make(size : Int) -> DslistskipBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_buffer_len(s : DslistskipBuffer) -> Int { s.size }

pub fn ds_list_skip_buffer_get(s : DslistskipBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_buffer_set(s : DslistskipBuffer, i : Int, v : Double) -> DslistskipBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_buffer_sum(s : DslistskipBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_buffer_mean(s : DslistskipBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_buffer_scale(s : DslistskipBuffer, f : Double) -> DslistskipBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_buffer_add(a : DslistskipBuffer, b : DslistskipBuffer) -> DslistskipBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_buffer_copy(s : DslistskipBuffer) -> DslistskipBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_buffer_fill(s : DslistskipBuffer, v : Double) -> DslistskipBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_buffer_min(s : DslistskipBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_buffer_max(s : DslistskipBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_buffer_to_string(s : DslistskipBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_cursor_make(size : Int) -> DslistskipCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_cursor_len(s : DslistskipCursor) -> Int { s.size }

pub fn ds_list_skip_cursor_get(s : DslistskipCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_cursor_set(s : DslistskipCursor, i : Int, v : Double) -> DslistskipCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cursor_sum(s : DslistskipCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_cursor_mean(s : DslistskipCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_cursor_scale(s : DslistskipCursor, f : Double) -> DslistskipCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cursor_add(a : DslistskipCursor, b : DslistskipCursor) -> DslistskipCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_cursor_copy(s : DslistskipCursor) -> DslistskipCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cursor_fill(s : DslistskipCursor, v : Double) -> DslistskipCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_cursor_min(s : DslistskipCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_cursor_max(s : DslistskipCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_cursor_to_string(s : DslistskipCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_view_make(size : Int) -> DslistskipView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_view_len(s : DslistskipView) -> Int { s.size }

pub fn ds_list_skip_view_get(s : DslistskipView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_view_set(s : DslistskipView, i : Int, v : Double) -> DslistskipView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_view_sum(s : DslistskipView) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_view_mean(s : DslistskipView) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_view_scale(s : DslistskipView, f : Double) -> DslistskipView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_view_add(a : DslistskipView, b : DslistskipView) -> DslistskipView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_view_copy(s : DslistskipView) -> DslistskipView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_view_fill(s : DslistskipView, v : Double) -> DslistskipView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_view_min(s : DslistskipView) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_view_max(s : DslistskipView) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_view_to_string(s : DslistskipView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_range_make(size : Int) -> DslistskipRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_range_len(s : DslistskipRange) -> Int { s.size }

pub fn ds_list_skip_range_get(s : DslistskipRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_range_set(s : DslistskipRange, i : Int, v : Double) -> DslistskipRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_range_sum(s : DslistskipRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_range_mean(s : DslistskipRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_range_scale(s : DslistskipRange, f : Double) -> DslistskipRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_range_add(a : DslistskipRange, b : DslistskipRange) -> DslistskipRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_range_copy(s : DslistskipRange) -> DslistskipRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_range_fill(s : DslistskipRange, v : Double) -> DslistskipRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_range_min(s : DslistskipRange) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_range_max(s : DslistskipRange) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_range_to_string(s : DslistskipRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_slice_make(size : Int) -> DslistskipSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_slice_len(s : DslistskipSlice) -> Int { s.size }

pub fn ds_list_skip_slice_get(s : DslistskipSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_slice_set(s : DslistskipSlice, i : Int, v : Double) -> DslistskipSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_skip_slice_sum(s : DslistskipSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_skip_slice_mean(s : DslistskipSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_skip_slice_scale(s : DslistskipSlice, f : Double) -> DslistskipSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_slice_add(a : DslistskipSlice, b : DslistskipSlice) -> DslistskipSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_skip_slice_copy(s : DslistskipSlice) -> DslistskipSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_slice_fill(s : DslistskipSlice, v : Double) -> DslistskipSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_skip_slice_min(s : DslistskipSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_skip_slice_max(s : DslistskipSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_skip_slice_to_string(s : DslistskipSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

