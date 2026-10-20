///===
/// extcore/ds_graph_edge_list

pub(all) struct DsgraphedgelistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_edge_list_make_point(x : Double, y : Double) -> DsgraphedgelistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_edge_list_make_point3(x : Double, y : Double, z : Double) -> DsgraphedgelistPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphedgelistPoint::x(self : DsgraphedgelistPoint) -> Double { self.x }

pub fn DsgraphedgelistPoint::y(self : DsgraphedgelistPoint) -> Double { self.y }

pub fn DsgraphedgelistPoint::z(self : DsgraphedgelistPoint) -> Double { self.z }

pub fn DsgraphedgelistPoint::label(self : DsgraphedgelistPoint) -> Int { self.label }

pub fn DsgraphedgelistPoint::dist(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphedgelistPoint::add(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphedgelistPoint::sub(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphedgelistPoint::scale(self : DsgraphedgelistPoint, s : Double) -> DsgraphedgelistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphedgelistPoint::dot(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphedgelistPoint::cross(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphedgelistPoint::norm(self : DsgraphedgelistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphedgelistPoint::normalize(self : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphedgelistPoint::negate(self : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphedgelistPoint::mid(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphedgelistPoint::lerp(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint, t : Double) -> DsgraphedgelistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphedgelistPoint::to_string(self : DsgraphedgelistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphedgelistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_edge_list_make_series(vals : Array[Double], name : String) -> DsgraphedgelistSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphedgelistSeries::len(self : DsgraphedgelistSeries) -> Int { self.vals.length() }

pub fn DsgraphedgelistSeries::sum(self : DsgraphedgelistSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphedgelistSeries::mean(self : DsgraphedgelistSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphedgelistSeries::min(self : DsgraphedgelistSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphedgelistSeries::max(self : DsgraphedgelistSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphedgelistSeries::range(self : DsgraphedgelistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphedgelistSeries::variance(self : DsgraphedgelistSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphedgelistSeries::std(self : DsgraphedgelistSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphedgelistSeries::median(self : DsgraphedgelistSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphedgelistSeries::scale(self : DsgraphedgelistSeries, f : Double) -> DsgraphedgelistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphedgelistSeries::add(self : DsgraphedgelistSeries, other : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphedgelistSeries::sub(self : DsgraphedgelistSeries, other : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphedgelistSeries::normalize(self : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphedgelistSeries::cumsum(self : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphedgelistSeries::to_string(self : DsgraphedgelistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphedgelistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_edge_list_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphedgelistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_edge_list_matrix_identity(n : Int) -> DsgraphedgelistMatrix {
  let m = ds_graph_edge_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphedgelistMatrix::get(self : DsgraphedgelistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphedgelistMatrix::transpose(self : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  let result = ds_graph_edge_list_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphedgelistMatrix::add(self : DsgraphedgelistMatrix, other : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_edge_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphedgelistMatrix::scale(self : DsgraphedgelistMatrix, s : Double) -> DsgraphedgelistMatrix {
  let result = ds_graph_edge_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphedgelistMatrix::multiply(self : DsgraphedgelistMatrix, other : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  if self.cols != other.rows { return ds_graph_edge_list_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_edge_list_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphedgelistMatrix::trace(self : DsgraphedgelistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphedgelistMatrix::det(self : DsgraphedgelistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphedgelistMatrix::norm(self : DsgraphedgelistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphedgelistMatrix::to_string(self : DsgraphedgelistMatrix) -> String {
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

pub(all) struct DsgraphedgelistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_edge_list_make_vector(comps : Array[Double]) -> DsgraphedgelistVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_edge_list_vector_zero(dim : Int) -> DsgraphedgelistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphedgelistVector::add(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphedgelistVector::sub(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphedgelistVector::scale(self : DsgraphedgelistVector, s : Double) -> DsgraphedgelistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphedgelistVector::dot(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphedgelistVector::norm(self : DsgraphedgelistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphedgelistVector::normalize(self : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphedgelistVector::dist(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphedgelistVector::to_string(self : DsgraphedgelistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_edge_list_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_edge_list_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_edge_list_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_edge_list_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_edge_list_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_edge_list_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_edge_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_edge_list_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_edge_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_edge_list_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_edge_list_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_edge_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_edge_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_edge_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_edge_list_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_edge_list_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_edge_list_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_edge_list_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_edge_list_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_edge_list_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_edge_list_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_edge_list_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_edge_list_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_edge_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_edge_list_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_edge_list_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_edge_list_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_edge_list_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_edge_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphedgelistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_frame_make(size : Int) -> DsgraphedgelistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_frame_len(s : DsgraphedgelistFrame) -> Int { s.size }

pub fn ds_graph_edge_list_frame_get(s : DsgraphedgelistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_frame_set(s : DsgraphedgelistFrame, i : Int, v : Double) -> DsgraphedgelistFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_frame_sum(s : DsgraphedgelistFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_frame_mean(s : DsgraphedgelistFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_frame_scale(s : DsgraphedgelistFrame, f : Double) -> DsgraphedgelistFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_frame_add(a : DsgraphedgelistFrame, b : DsgraphedgelistFrame) -> DsgraphedgelistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_frame_copy(s : DsgraphedgelistFrame) -> DsgraphedgelistFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_frame_fill(s : DsgraphedgelistFrame, v : Double) -> DsgraphedgelistFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_frame_min(s : DsgraphedgelistFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_frame_max(s : DsgraphedgelistFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_frame_to_string(s : DsgraphedgelistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_table_make(size : Int) -> DsgraphedgelistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_table_len(s : DsgraphedgelistTable) -> Int { s.size }

pub fn ds_graph_edge_list_table_get(s : DsgraphedgelistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_table_set(s : DsgraphedgelistTable, i : Int, v : Double) -> DsgraphedgelistTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_table_sum(s : DsgraphedgelistTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_table_mean(s : DsgraphedgelistTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_table_scale(s : DsgraphedgelistTable, f : Double) -> DsgraphedgelistTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_table_add(a : DsgraphedgelistTable, b : DsgraphedgelistTable) -> DsgraphedgelistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_table_copy(s : DsgraphedgelistTable) -> DsgraphedgelistTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_table_fill(s : DsgraphedgelistTable, v : Double) -> DsgraphedgelistTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_table_min(s : DsgraphedgelistTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_table_max(s : DsgraphedgelistTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_table_to_string(s : DsgraphedgelistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_graphn_make(size : Int) -> DsgraphedgelistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_graphn_len(s : DsgraphedgelistGraphN) -> Int { s.size }

pub fn ds_graph_edge_list_graphn_get(s : DsgraphedgelistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_graphn_set(s : DsgraphedgelistGraphN, i : Int, v : Double) -> DsgraphedgelistGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_graphn_sum(s : DsgraphedgelistGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_graphn_mean(s : DsgraphedgelistGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_graphn_scale(s : DsgraphedgelistGraphN, f : Double) -> DsgraphedgelistGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_graphn_add(a : DsgraphedgelistGraphN, b : DsgraphedgelistGraphN) -> DsgraphedgelistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_graphn_copy(s : DsgraphedgelistGraphN) -> DsgraphedgelistGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_graphn_fill(s : DsgraphedgelistGraphN, v : Double) -> DsgraphedgelistGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_graphn_min(s : DsgraphedgelistGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_graphn_max(s : DsgraphedgelistGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_graphn_to_string(s : DsgraphedgelistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_node_make(size : Int) -> DsgraphedgelistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_node_len(s : DsgraphedgelistNode) -> Int { s.size }

pub fn ds_graph_edge_list_node_get(s : DsgraphedgelistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_node_set(s : DsgraphedgelistNode, i : Int, v : Double) -> DsgraphedgelistNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_node_sum(s : DsgraphedgelistNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_node_mean(s : DsgraphedgelistNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_node_scale(s : DsgraphedgelistNode, f : Double) -> DsgraphedgelistNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_node_add(a : DsgraphedgelistNode, b : DsgraphedgelistNode) -> DsgraphedgelistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_node_copy(s : DsgraphedgelistNode) -> DsgraphedgelistNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_node_fill(s : DsgraphedgelistNode, v : Double) -> DsgraphedgelistNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_node_min(s : DsgraphedgelistNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_node_max(s : DsgraphedgelistNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_node_to_string(s : DsgraphedgelistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_edge_make(size : Int) -> DsgraphedgelistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_edge_len(s : DsgraphedgelistEdge) -> Int { s.size }

pub fn ds_graph_edge_list_edge_get(s : DsgraphedgelistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_edge_set(s : DsgraphedgelistEdge, i : Int, v : Double) -> DsgraphedgelistEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_edge_sum(s : DsgraphedgelistEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_edge_mean(s : DsgraphedgelistEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_edge_scale(s : DsgraphedgelistEdge, f : Double) -> DsgraphedgelistEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_edge_add(a : DsgraphedgelistEdge, b : DsgraphedgelistEdge) -> DsgraphedgelistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_edge_copy(s : DsgraphedgelistEdge) -> DsgraphedgelistEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_edge_fill(s : DsgraphedgelistEdge, v : Double) -> DsgraphedgelistEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_edge_min(s : DsgraphedgelistEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_edge_max(s : DsgraphedgelistEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_edge_to_string(s : DsgraphedgelistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_path_make(size : Int) -> DsgraphedgelistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_path_len(s : DsgraphedgelistPath) -> Int { s.size }

pub fn ds_graph_edge_list_path_get(s : DsgraphedgelistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_path_set(s : DsgraphedgelistPath, i : Int, v : Double) -> DsgraphedgelistPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_path_sum(s : DsgraphedgelistPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_path_mean(s : DsgraphedgelistPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_path_scale(s : DsgraphedgelistPath, f : Double) -> DsgraphedgelistPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_path_add(a : DsgraphedgelistPath, b : DsgraphedgelistPath) -> DsgraphedgelistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_path_copy(s : DsgraphedgelistPath) -> DsgraphedgelistPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_path_fill(s : DsgraphedgelistPath, v : Double) -> DsgraphedgelistPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_path_min(s : DsgraphedgelistPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_path_max(s : DsgraphedgelistPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_path_to_string(s : DsgraphedgelistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_cluster_make(size : Int) -> DsgraphedgelistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_cluster_len(s : DsgraphedgelistCluster) -> Int { s.size }

pub fn ds_graph_edge_list_cluster_get(s : DsgraphedgelistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_cluster_set(s : DsgraphedgelistCluster, i : Int, v : Double) -> DsgraphedgelistCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cluster_sum(s : DsgraphedgelistCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_cluster_mean(s : DsgraphedgelistCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_cluster_scale(s : DsgraphedgelistCluster, f : Double) -> DsgraphedgelistCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cluster_add(a : DsgraphedgelistCluster, b : DsgraphedgelistCluster) -> DsgraphedgelistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_cluster_copy(s : DsgraphedgelistCluster) -> DsgraphedgelistCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cluster_fill(s : DsgraphedgelistCluster, v : Double) -> DsgraphedgelistCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cluster_min(s : DsgraphedgelistCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_cluster_max(s : DsgraphedgelistCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_cluster_to_string(s : DsgraphedgelistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_model_make(size : Int) -> DsgraphedgelistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_model_len(s : DsgraphedgelistModel) -> Int { s.size }

pub fn ds_graph_edge_list_model_get(s : DsgraphedgelistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_model_set(s : DsgraphedgelistModel, i : Int, v : Double) -> DsgraphedgelistModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_model_sum(s : DsgraphedgelistModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_model_mean(s : DsgraphedgelistModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_model_scale(s : DsgraphedgelistModel, f : Double) -> DsgraphedgelistModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_model_add(a : DsgraphedgelistModel, b : DsgraphedgelistModel) -> DsgraphedgelistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_model_copy(s : DsgraphedgelistModel) -> DsgraphedgelistModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_model_fill(s : DsgraphedgelistModel, v : Double) -> DsgraphedgelistModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_model_min(s : DsgraphedgelistModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_model_max(s : DsgraphedgelistModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_model_to_string(s : DsgraphedgelistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_layer_make(size : Int) -> DsgraphedgelistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_layer_len(s : DsgraphedgelistLayer) -> Int { s.size }

pub fn ds_graph_edge_list_layer_get(s : DsgraphedgelistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_layer_set(s : DsgraphedgelistLayer, i : Int, v : Double) -> DsgraphedgelistLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_layer_sum(s : DsgraphedgelistLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_layer_mean(s : DsgraphedgelistLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_layer_scale(s : DsgraphedgelistLayer, f : Double) -> DsgraphedgelistLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_layer_add(a : DsgraphedgelistLayer, b : DsgraphedgelistLayer) -> DsgraphedgelistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_layer_copy(s : DsgraphedgelistLayer) -> DsgraphedgelistLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_layer_fill(s : DsgraphedgelistLayer, v : Double) -> DsgraphedgelistLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_layer_min(s : DsgraphedgelistLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_layer_max(s : DsgraphedgelistLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_layer_to_string(s : DsgraphedgelistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_buffer_make(size : Int) -> DsgraphedgelistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_buffer_len(s : DsgraphedgelistBuffer) -> Int { s.size }

pub fn ds_graph_edge_list_buffer_get(s : DsgraphedgelistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_buffer_set(s : DsgraphedgelistBuffer, i : Int, v : Double) -> DsgraphedgelistBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_buffer_sum(s : DsgraphedgelistBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_buffer_mean(s : DsgraphedgelistBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_buffer_scale(s : DsgraphedgelistBuffer, f : Double) -> DsgraphedgelistBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_buffer_add(a : DsgraphedgelistBuffer, b : DsgraphedgelistBuffer) -> DsgraphedgelistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_buffer_copy(s : DsgraphedgelistBuffer) -> DsgraphedgelistBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_buffer_fill(s : DsgraphedgelistBuffer, v : Double) -> DsgraphedgelistBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_buffer_min(s : DsgraphedgelistBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_buffer_max(s : DsgraphedgelistBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_buffer_to_string(s : DsgraphedgelistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_cursor_make(size : Int) -> DsgraphedgelistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_cursor_len(s : DsgraphedgelistCursor) -> Int { s.size }

pub fn ds_graph_edge_list_cursor_get(s : DsgraphedgelistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_cursor_set(s : DsgraphedgelistCursor, i : Int, v : Double) -> DsgraphedgelistCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cursor_sum(s : DsgraphedgelistCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_cursor_mean(s : DsgraphedgelistCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_cursor_scale(s : DsgraphedgelistCursor, f : Double) -> DsgraphedgelistCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cursor_add(a : DsgraphedgelistCursor, b : DsgraphedgelistCursor) -> DsgraphedgelistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_cursor_copy(s : DsgraphedgelistCursor) -> DsgraphedgelistCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cursor_fill(s : DsgraphedgelistCursor, v : Double) -> DsgraphedgelistCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_cursor_min(s : DsgraphedgelistCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_cursor_max(s : DsgraphedgelistCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_cursor_to_string(s : DsgraphedgelistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_view_make(size : Int) -> DsgraphedgelistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_view_len(s : DsgraphedgelistView) -> Int { s.size }

pub fn ds_graph_edge_list_view_get(s : DsgraphedgelistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_view_set(s : DsgraphedgelistView, i : Int, v : Double) -> DsgraphedgelistView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_view_sum(s : DsgraphedgelistView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_view_mean(s : DsgraphedgelistView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_view_scale(s : DsgraphedgelistView, f : Double) -> DsgraphedgelistView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_view_add(a : DsgraphedgelistView, b : DsgraphedgelistView) -> DsgraphedgelistView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_view_copy(s : DsgraphedgelistView) -> DsgraphedgelistView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_view_fill(s : DsgraphedgelistView, v : Double) -> DsgraphedgelistView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_view_min(s : DsgraphedgelistView) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_view_max(s : DsgraphedgelistView) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_view_to_string(s : DsgraphedgelistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_range_make(size : Int) -> DsgraphedgelistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_range_len(s : DsgraphedgelistRange) -> Int { s.size }

pub fn ds_graph_edge_list_range_get(s : DsgraphedgelistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_range_set(s : DsgraphedgelistRange, i : Int, v : Double) -> DsgraphedgelistRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_range_sum(s : DsgraphedgelistRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_range_mean(s : DsgraphedgelistRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_range_scale(s : DsgraphedgelistRange, f : Double) -> DsgraphedgelistRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_range_add(a : DsgraphedgelistRange, b : DsgraphedgelistRange) -> DsgraphedgelistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_range_copy(s : DsgraphedgelistRange) -> DsgraphedgelistRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_range_fill(s : DsgraphedgelistRange, v : Double) -> DsgraphedgelistRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_range_min(s : DsgraphedgelistRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_range_max(s : DsgraphedgelistRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_range_to_string(s : DsgraphedgelistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_slice_make(size : Int) -> DsgraphedgelistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_slice_len(s : DsgraphedgelistSlice) -> Int { s.size }

pub fn ds_graph_edge_list_slice_get(s : DsgraphedgelistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_slice_set(s : DsgraphedgelistSlice, i : Int, v : Double) -> DsgraphedgelistSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_slice_sum(s : DsgraphedgelistSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_edge_list_slice_mean(s : DsgraphedgelistSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_edge_list_slice_scale(s : DsgraphedgelistSlice, f : Double) -> DsgraphedgelistSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_slice_add(a : DsgraphedgelistSlice, b : DsgraphedgelistSlice) -> DsgraphedgelistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_edge_list_slice_copy(s : DsgraphedgelistSlice) -> DsgraphedgelistSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_slice_fill(s : DsgraphedgelistSlice, v : Double) -> DsgraphedgelistSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_edge_list_slice_min(s : DsgraphedgelistSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_edge_list_slice_max(s : DsgraphedgelistSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_edge_list_slice_to_string(s : DsgraphedgelistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

