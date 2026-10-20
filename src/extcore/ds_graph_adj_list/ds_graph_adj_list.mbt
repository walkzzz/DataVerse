///===
/// extcore/ds_graph_adj_list

pub(all) struct DsgraphadjlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_adj_list_make_point(x : Double, y : Double) -> DsgraphadjlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_adj_list_make_point3(x : Double, y : Double, z : Double) -> DsgraphadjlistPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphadjlistPoint::x(self : DsgraphadjlistPoint) -> Double { self.x }

pub fn DsgraphadjlistPoint::y(self : DsgraphadjlistPoint) -> Double { self.y }

pub fn DsgraphadjlistPoint::z(self : DsgraphadjlistPoint) -> Double { self.z }

pub fn DsgraphadjlistPoint::label(self : DsgraphadjlistPoint) -> Int { self.label }

pub fn DsgraphadjlistPoint::dist(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphadjlistPoint::add(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphadjlistPoint::sub(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphadjlistPoint::scale(self : DsgraphadjlistPoint, s : Double) -> DsgraphadjlistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphadjlistPoint::dot(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphadjlistPoint::cross(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphadjlistPoint::norm(self : DsgraphadjlistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphadjlistPoint::normalize(self : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjlistPoint::negate(self : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphadjlistPoint::mid(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphadjlistPoint::lerp(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint, t : Double) -> DsgraphadjlistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphadjlistPoint::to_string(self : DsgraphadjlistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphadjlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_adj_list_make_series(vals : Array[Double], name : String) -> DsgraphadjlistSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphadjlistSeries::len(self : DsgraphadjlistSeries) -> Int { self.vals.length() }

pub fn DsgraphadjlistSeries::sum(self : DsgraphadjlistSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphadjlistSeries::mean(self : DsgraphadjlistSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphadjlistSeries::min(self : DsgraphadjlistSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphadjlistSeries::max(self : DsgraphadjlistSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphadjlistSeries::range(self : DsgraphadjlistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphadjlistSeries::variance(self : DsgraphadjlistSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphadjlistSeries::std(self : DsgraphadjlistSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphadjlistSeries::median(self : DsgraphadjlistSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphadjlistSeries::scale(self : DsgraphadjlistSeries, f : Double) -> DsgraphadjlistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphadjlistSeries::add(self : DsgraphadjlistSeries, other : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphadjlistSeries::sub(self : DsgraphadjlistSeries, other : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphadjlistSeries::normalize(self : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphadjlistSeries::cumsum(self : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphadjlistSeries::to_string(self : DsgraphadjlistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_adj_list_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphadjlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_adj_list_matrix_identity(n : Int) -> DsgraphadjlistMatrix {
  let m = ds_graph_adj_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphadjlistMatrix::get(self : DsgraphadjlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphadjlistMatrix::transpose(self : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  let result = ds_graph_adj_list_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphadjlistMatrix::add(self : DsgraphadjlistMatrix, other : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_adj_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphadjlistMatrix::scale(self : DsgraphadjlistMatrix, s : Double) -> DsgraphadjlistMatrix {
  let result = ds_graph_adj_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphadjlistMatrix::multiply(self : DsgraphadjlistMatrix, other : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  if self.cols != other.rows { return ds_graph_adj_list_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_adj_list_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphadjlistMatrix::trace(self : DsgraphadjlistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphadjlistMatrix::det(self : DsgraphadjlistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphadjlistMatrix::norm(self : DsgraphadjlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphadjlistMatrix::to_string(self : DsgraphadjlistMatrix) -> String {
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

pub(all) struct DsgraphadjlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_adj_list_make_vector(comps : Array[Double]) -> DsgraphadjlistVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_adj_list_vector_zero(dim : Int) -> DsgraphadjlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphadjlistVector::add(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjlistVector::sub(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjlistVector::scale(self : DsgraphadjlistVector, s : Double) -> DsgraphadjlistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphadjlistVector::dot(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphadjlistVector::norm(self : DsgraphadjlistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphadjlistVector::normalize(self : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjlistVector::dist(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphadjlistVector::to_string(self : DsgraphadjlistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_adj_list_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_adj_list_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_adj_list_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_adj_list_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_adj_list_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_adj_list_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_adj_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_adj_list_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_adj_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_adj_list_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_adj_list_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_adj_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_adj_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_adj_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_adj_list_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_adj_list_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_adj_list_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_adj_list_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_adj_list_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_adj_list_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_adj_list_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_adj_list_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_adj_list_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_adj_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_adj_list_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_adj_list_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_adj_list_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_adj_list_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_adj_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphadjlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_frame_make(size : Int) -> DsgraphadjlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_frame_len(s : DsgraphadjlistFrame) -> Int { s.size }

pub fn ds_graph_adj_list_frame_get(s : DsgraphadjlistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_frame_set(s : DsgraphadjlistFrame, i : Int, v : Double) -> DsgraphadjlistFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_frame_sum(s : DsgraphadjlistFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_frame_mean(s : DsgraphadjlistFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_frame_scale(s : DsgraphadjlistFrame, f : Double) -> DsgraphadjlistFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_frame_add(a : DsgraphadjlistFrame, b : DsgraphadjlistFrame) -> DsgraphadjlistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_frame_copy(s : DsgraphadjlistFrame) -> DsgraphadjlistFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_frame_fill(s : DsgraphadjlistFrame, v : Double) -> DsgraphadjlistFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_frame_min(s : DsgraphadjlistFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_frame_max(s : DsgraphadjlistFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_frame_to_string(s : DsgraphadjlistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_table_make(size : Int) -> DsgraphadjlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_table_len(s : DsgraphadjlistTable) -> Int { s.size }

pub fn ds_graph_adj_list_table_get(s : DsgraphadjlistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_table_set(s : DsgraphadjlistTable, i : Int, v : Double) -> DsgraphadjlistTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_table_sum(s : DsgraphadjlistTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_table_mean(s : DsgraphadjlistTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_table_scale(s : DsgraphadjlistTable, f : Double) -> DsgraphadjlistTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_table_add(a : DsgraphadjlistTable, b : DsgraphadjlistTable) -> DsgraphadjlistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_table_copy(s : DsgraphadjlistTable) -> DsgraphadjlistTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_table_fill(s : DsgraphadjlistTable, v : Double) -> DsgraphadjlistTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_table_min(s : DsgraphadjlistTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_table_max(s : DsgraphadjlistTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_table_to_string(s : DsgraphadjlistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_graphn_make(size : Int) -> DsgraphadjlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_graphn_len(s : DsgraphadjlistGraphN) -> Int { s.size }

pub fn ds_graph_adj_list_graphn_get(s : DsgraphadjlistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_graphn_set(s : DsgraphadjlistGraphN, i : Int, v : Double) -> DsgraphadjlistGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_graphn_sum(s : DsgraphadjlistGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_graphn_mean(s : DsgraphadjlistGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_graphn_scale(s : DsgraphadjlistGraphN, f : Double) -> DsgraphadjlistGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_graphn_add(a : DsgraphadjlistGraphN, b : DsgraphadjlistGraphN) -> DsgraphadjlistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_graphn_copy(s : DsgraphadjlistGraphN) -> DsgraphadjlistGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_graphn_fill(s : DsgraphadjlistGraphN, v : Double) -> DsgraphadjlistGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_graphn_min(s : DsgraphadjlistGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_graphn_max(s : DsgraphadjlistGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_graphn_to_string(s : DsgraphadjlistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_node_make(size : Int) -> DsgraphadjlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_node_len(s : DsgraphadjlistNode) -> Int { s.size }

pub fn ds_graph_adj_list_node_get(s : DsgraphadjlistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_node_set(s : DsgraphadjlistNode, i : Int, v : Double) -> DsgraphadjlistNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_node_sum(s : DsgraphadjlistNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_node_mean(s : DsgraphadjlistNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_node_scale(s : DsgraphadjlistNode, f : Double) -> DsgraphadjlistNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_node_add(a : DsgraphadjlistNode, b : DsgraphadjlistNode) -> DsgraphadjlistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_node_copy(s : DsgraphadjlistNode) -> DsgraphadjlistNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_node_fill(s : DsgraphadjlistNode, v : Double) -> DsgraphadjlistNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_node_min(s : DsgraphadjlistNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_node_max(s : DsgraphadjlistNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_node_to_string(s : DsgraphadjlistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_edge_make(size : Int) -> DsgraphadjlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_edge_len(s : DsgraphadjlistEdge) -> Int { s.size }

pub fn ds_graph_adj_list_edge_get(s : DsgraphadjlistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_edge_set(s : DsgraphadjlistEdge, i : Int, v : Double) -> DsgraphadjlistEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_edge_sum(s : DsgraphadjlistEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_edge_mean(s : DsgraphadjlistEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_edge_scale(s : DsgraphadjlistEdge, f : Double) -> DsgraphadjlistEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_edge_add(a : DsgraphadjlistEdge, b : DsgraphadjlistEdge) -> DsgraphadjlistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_edge_copy(s : DsgraphadjlistEdge) -> DsgraphadjlistEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_edge_fill(s : DsgraphadjlistEdge, v : Double) -> DsgraphadjlistEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_edge_min(s : DsgraphadjlistEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_edge_max(s : DsgraphadjlistEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_edge_to_string(s : DsgraphadjlistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_path_make(size : Int) -> DsgraphadjlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_path_len(s : DsgraphadjlistPath) -> Int { s.size }

pub fn ds_graph_adj_list_path_get(s : DsgraphadjlistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_path_set(s : DsgraphadjlistPath, i : Int, v : Double) -> DsgraphadjlistPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_path_sum(s : DsgraphadjlistPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_path_mean(s : DsgraphadjlistPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_path_scale(s : DsgraphadjlistPath, f : Double) -> DsgraphadjlistPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_path_add(a : DsgraphadjlistPath, b : DsgraphadjlistPath) -> DsgraphadjlistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_path_copy(s : DsgraphadjlistPath) -> DsgraphadjlistPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_path_fill(s : DsgraphadjlistPath, v : Double) -> DsgraphadjlistPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_path_min(s : DsgraphadjlistPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_path_max(s : DsgraphadjlistPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_path_to_string(s : DsgraphadjlistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_cluster_make(size : Int) -> DsgraphadjlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_cluster_len(s : DsgraphadjlistCluster) -> Int { s.size }

pub fn ds_graph_adj_list_cluster_get(s : DsgraphadjlistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_cluster_set(s : DsgraphadjlistCluster, i : Int, v : Double) -> DsgraphadjlistCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cluster_sum(s : DsgraphadjlistCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_cluster_mean(s : DsgraphadjlistCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_cluster_scale(s : DsgraphadjlistCluster, f : Double) -> DsgraphadjlistCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cluster_add(a : DsgraphadjlistCluster, b : DsgraphadjlistCluster) -> DsgraphadjlistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_cluster_copy(s : DsgraphadjlistCluster) -> DsgraphadjlistCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cluster_fill(s : DsgraphadjlistCluster, v : Double) -> DsgraphadjlistCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cluster_min(s : DsgraphadjlistCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_cluster_max(s : DsgraphadjlistCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_cluster_to_string(s : DsgraphadjlistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_model_make(size : Int) -> DsgraphadjlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_model_len(s : DsgraphadjlistModel) -> Int { s.size }

pub fn ds_graph_adj_list_model_get(s : DsgraphadjlistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_model_set(s : DsgraphadjlistModel, i : Int, v : Double) -> DsgraphadjlistModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_model_sum(s : DsgraphadjlistModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_model_mean(s : DsgraphadjlistModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_model_scale(s : DsgraphadjlistModel, f : Double) -> DsgraphadjlistModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_model_add(a : DsgraphadjlistModel, b : DsgraphadjlistModel) -> DsgraphadjlistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_model_copy(s : DsgraphadjlistModel) -> DsgraphadjlistModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_model_fill(s : DsgraphadjlistModel, v : Double) -> DsgraphadjlistModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_model_min(s : DsgraphadjlistModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_model_max(s : DsgraphadjlistModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_model_to_string(s : DsgraphadjlistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_layer_make(size : Int) -> DsgraphadjlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_layer_len(s : DsgraphadjlistLayer) -> Int { s.size }

pub fn ds_graph_adj_list_layer_get(s : DsgraphadjlistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_layer_set(s : DsgraphadjlistLayer, i : Int, v : Double) -> DsgraphadjlistLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_layer_sum(s : DsgraphadjlistLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_layer_mean(s : DsgraphadjlistLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_layer_scale(s : DsgraphadjlistLayer, f : Double) -> DsgraphadjlistLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_layer_add(a : DsgraphadjlistLayer, b : DsgraphadjlistLayer) -> DsgraphadjlistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_layer_copy(s : DsgraphadjlistLayer) -> DsgraphadjlistLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_layer_fill(s : DsgraphadjlistLayer, v : Double) -> DsgraphadjlistLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_layer_min(s : DsgraphadjlistLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_layer_max(s : DsgraphadjlistLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_layer_to_string(s : DsgraphadjlistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_buffer_make(size : Int) -> DsgraphadjlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_buffer_len(s : DsgraphadjlistBuffer) -> Int { s.size }

pub fn ds_graph_adj_list_buffer_get(s : DsgraphadjlistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_buffer_set(s : DsgraphadjlistBuffer, i : Int, v : Double) -> DsgraphadjlistBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_buffer_sum(s : DsgraphadjlistBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_buffer_mean(s : DsgraphadjlistBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_buffer_scale(s : DsgraphadjlistBuffer, f : Double) -> DsgraphadjlistBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_buffer_add(a : DsgraphadjlistBuffer, b : DsgraphadjlistBuffer) -> DsgraphadjlistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_buffer_copy(s : DsgraphadjlistBuffer) -> DsgraphadjlistBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_buffer_fill(s : DsgraphadjlistBuffer, v : Double) -> DsgraphadjlistBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_buffer_min(s : DsgraphadjlistBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_buffer_max(s : DsgraphadjlistBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_buffer_to_string(s : DsgraphadjlistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_cursor_make(size : Int) -> DsgraphadjlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_cursor_len(s : DsgraphadjlistCursor) -> Int { s.size }

pub fn ds_graph_adj_list_cursor_get(s : DsgraphadjlistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_cursor_set(s : DsgraphadjlistCursor, i : Int, v : Double) -> DsgraphadjlistCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cursor_sum(s : DsgraphadjlistCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_cursor_mean(s : DsgraphadjlistCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_cursor_scale(s : DsgraphadjlistCursor, f : Double) -> DsgraphadjlistCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cursor_add(a : DsgraphadjlistCursor, b : DsgraphadjlistCursor) -> DsgraphadjlistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_cursor_copy(s : DsgraphadjlistCursor) -> DsgraphadjlistCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cursor_fill(s : DsgraphadjlistCursor, v : Double) -> DsgraphadjlistCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_cursor_min(s : DsgraphadjlistCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_cursor_max(s : DsgraphadjlistCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_cursor_to_string(s : DsgraphadjlistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_view_make(size : Int) -> DsgraphadjlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_view_len(s : DsgraphadjlistView) -> Int { s.size }

pub fn ds_graph_adj_list_view_get(s : DsgraphadjlistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_view_set(s : DsgraphadjlistView, i : Int, v : Double) -> DsgraphadjlistView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_view_sum(s : DsgraphadjlistView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_view_mean(s : DsgraphadjlistView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_view_scale(s : DsgraphadjlistView, f : Double) -> DsgraphadjlistView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_view_add(a : DsgraphadjlistView, b : DsgraphadjlistView) -> DsgraphadjlistView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_view_copy(s : DsgraphadjlistView) -> DsgraphadjlistView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_view_fill(s : DsgraphadjlistView, v : Double) -> DsgraphadjlistView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_view_min(s : DsgraphadjlistView) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_view_max(s : DsgraphadjlistView) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_view_to_string(s : DsgraphadjlistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_range_make(size : Int) -> DsgraphadjlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_range_len(s : DsgraphadjlistRange) -> Int { s.size }

pub fn ds_graph_adj_list_range_get(s : DsgraphadjlistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_range_set(s : DsgraphadjlistRange, i : Int, v : Double) -> DsgraphadjlistRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_range_sum(s : DsgraphadjlistRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_range_mean(s : DsgraphadjlistRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_range_scale(s : DsgraphadjlistRange, f : Double) -> DsgraphadjlistRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_range_add(a : DsgraphadjlistRange, b : DsgraphadjlistRange) -> DsgraphadjlistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_range_copy(s : DsgraphadjlistRange) -> DsgraphadjlistRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_range_fill(s : DsgraphadjlistRange, v : Double) -> DsgraphadjlistRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_range_min(s : DsgraphadjlistRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_range_max(s : DsgraphadjlistRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_range_to_string(s : DsgraphadjlistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_slice_make(size : Int) -> DsgraphadjlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_list_slice_len(s : DsgraphadjlistSlice) -> Int { s.size }

pub fn ds_graph_adj_list_slice_get(s : DsgraphadjlistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_list_slice_set(s : DsgraphadjlistSlice, i : Int, v : Double) -> DsgraphadjlistSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_slice_sum(s : DsgraphadjlistSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_list_slice_mean(s : DsgraphadjlistSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_list_slice_scale(s : DsgraphadjlistSlice, f : Double) -> DsgraphadjlistSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_slice_add(a : DsgraphadjlistSlice, b : DsgraphadjlistSlice) -> DsgraphadjlistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_list_slice_copy(s : DsgraphadjlistSlice) -> DsgraphadjlistSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_slice_fill(s : DsgraphadjlistSlice, v : Double) -> DsgraphadjlistSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_list_slice_min(s : DsgraphadjlistSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_list_slice_max(s : DsgraphadjlistSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_list_slice_to_string(s : DsgraphadjlistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

