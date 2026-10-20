///===
/// extcore/ds_graph_adj_matrix

pub(all) struct DsgraphadjmatrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_adj_matrix_make_point(x : Double, y : Double) -> DsgraphadjmatrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_adj_matrix_make_point3(x : Double, y : Double, z : Double) -> DsgraphadjmatrixPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphadjmatrixPoint::x(self : DsgraphadjmatrixPoint) -> Double { self.x }

pub fn DsgraphadjmatrixPoint::y(self : DsgraphadjmatrixPoint) -> Double { self.y }

pub fn DsgraphadjmatrixPoint::z(self : DsgraphadjmatrixPoint) -> Double { self.z }

pub fn DsgraphadjmatrixPoint::label(self : DsgraphadjmatrixPoint) -> Int { self.label }

pub fn DsgraphadjmatrixPoint::dist(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphadjmatrixPoint::add(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphadjmatrixPoint::sub(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphadjmatrixPoint::scale(self : DsgraphadjmatrixPoint, s : Double) -> DsgraphadjmatrixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphadjmatrixPoint::dot(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphadjmatrixPoint::cross(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphadjmatrixPoint::norm(self : DsgraphadjmatrixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphadjmatrixPoint::normalize(self : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjmatrixPoint::negate(self : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphadjmatrixPoint::mid(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphadjmatrixPoint::lerp(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint, t : Double) -> DsgraphadjmatrixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphadjmatrixPoint::to_string(self : DsgraphadjmatrixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_adj_matrix_make_series(vals : Array[Double], name : String) -> DsgraphadjmatrixSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphadjmatrixSeries::len(self : DsgraphadjmatrixSeries) -> Int { self.vals.length() }

pub fn DsgraphadjmatrixSeries::sum(self : DsgraphadjmatrixSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphadjmatrixSeries::mean(self : DsgraphadjmatrixSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphadjmatrixSeries::min(self : DsgraphadjmatrixSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphadjmatrixSeries::max(self : DsgraphadjmatrixSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphadjmatrixSeries::range(self : DsgraphadjmatrixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphadjmatrixSeries::variance(self : DsgraphadjmatrixSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphadjmatrixSeries::std(self : DsgraphadjmatrixSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphadjmatrixSeries::median(self : DsgraphadjmatrixSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphadjmatrixSeries::scale(self : DsgraphadjmatrixSeries, f : Double) -> DsgraphadjmatrixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::add(self : DsgraphadjmatrixSeries, other : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::sub(self : DsgraphadjmatrixSeries, other : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::normalize(self : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphadjmatrixSeries::cumsum(self : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::to_string(self : DsgraphadjmatrixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjmatrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_adj_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphadjmatrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_adj_matrix_matrix_identity(n : Int) -> DsgraphadjmatrixMatrix {
  let m = ds_graph_adj_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphadjmatrixMatrix::get(self : DsgraphadjmatrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphadjmatrixMatrix::transpose(self : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  let result = ds_graph_adj_matrix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphadjmatrixMatrix::add(self : DsgraphadjmatrixMatrix, other : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_adj_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphadjmatrixMatrix::scale(self : DsgraphadjmatrixMatrix, s : Double) -> DsgraphadjmatrixMatrix {
  let result = ds_graph_adj_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphadjmatrixMatrix::multiply(self : DsgraphadjmatrixMatrix, other : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  if self.cols != other.rows { return ds_graph_adj_matrix_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_adj_matrix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphadjmatrixMatrix::trace(self : DsgraphadjmatrixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphadjmatrixMatrix::det(self : DsgraphadjmatrixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphadjmatrixMatrix::norm(self : DsgraphadjmatrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphadjmatrixMatrix::to_string(self : DsgraphadjmatrixMatrix) -> String {
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

pub(all) struct DsgraphadjmatrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_adj_matrix_make_vector(comps : Array[Double]) -> DsgraphadjmatrixVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_adj_matrix_vector_zero(dim : Int) -> DsgraphadjmatrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphadjmatrixVector::add(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjmatrixVector::sub(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjmatrixVector::scale(self : DsgraphadjmatrixVector, s : Double) -> DsgraphadjmatrixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphadjmatrixVector::dot(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphadjmatrixVector::norm(self : DsgraphadjmatrixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphadjmatrixVector::normalize(self : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjmatrixVector::dist(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphadjmatrixVector::to_string(self : DsgraphadjmatrixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_adj_matrix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_adj_matrix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_adj_matrix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_adj_matrix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_adj_matrix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_adj_matrix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_adj_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_adj_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_adj_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_adj_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_adj_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_adj_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_adj_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_adj_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_adj_matrix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_adj_matrix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_adj_matrix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_adj_matrix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_adj_matrix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_adj_matrix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_adj_matrix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_adj_matrix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_adj_matrix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_adj_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_adj_matrix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_adj_matrix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_adj_matrix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_adj_matrix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_adj_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphadjmatrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_frame_make(size : Int) -> DsgraphadjmatrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_frame_len(s : DsgraphadjmatrixFrame) -> Int { s.size }

pub fn ds_graph_adj_matrix_frame_get(s : DsgraphadjmatrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_frame_set(s : DsgraphadjmatrixFrame, i : Int, v : Double) -> DsgraphadjmatrixFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_frame_sum(s : DsgraphadjmatrixFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_frame_mean(s : DsgraphadjmatrixFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_frame_scale(s : DsgraphadjmatrixFrame, f : Double) -> DsgraphadjmatrixFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_frame_add(a : DsgraphadjmatrixFrame, b : DsgraphadjmatrixFrame) -> DsgraphadjmatrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_frame_copy(s : DsgraphadjmatrixFrame) -> DsgraphadjmatrixFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_frame_fill(s : DsgraphadjmatrixFrame, v : Double) -> DsgraphadjmatrixFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_frame_min(s : DsgraphadjmatrixFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_frame_max(s : DsgraphadjmatrixFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_frame_to_string(s : DsgraphadjmatrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_table_make(size : Int) -> DsgraphadjmatrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_table_len(s : DsgraphadjmatrixTable) -> Int { s.size }

pub fn ds_graph_adj_matrix_table_get(s : DsgraphadjmatrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_table_set(s : DsgraphadjmatrixTable, i : Int, v : Double) -> DsgraphadjmatrixTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_table_sum(s : DsgraphadjmatrixTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_table_mean(s : DsgraphadjmatrixTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_table_scale(s : DsgraphadjmatrixTable, f : Double) -> DsgraphadjmatrixTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_table_add(a : DsgraphadjmatrixTable, b : DsgraphadjmatrixTable) -> DsgraphadjmatrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_table_copy(s : DsgraphadjmatrixTable) -> DsgraphadjmatrixTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_table_fill(s : DsgraphadjmatrixTable, v : Double) -> DsgraphadjmatrixTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_table_min(s : DsgraphadjmatrixTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_table_max(s : DsgraphadjmatrixTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_table_to_string(s : DsgraphadjmatrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_graphn_make(size : Int) -> DsgraphadjmatrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_graphn_len(s : DsgraphadjmatrixGraphN) -> Int { s.size }

pub fn ds_graph_adj_matrix_graphn_get(s : DsgraphadjmatrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_graphn_set(s : DsgraphadjmatrixGraphN, i : Int, v : Double) -> DsgraphadjmatrixGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_graphn_sum(s : DsgraphadjmatrixGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_graphn_mean(s : DsgraphadjmatrixGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_graphn_scale(s : DsgraphadjmatrixGraphN, f : Double) -> DsgraphadjmatrixGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_graphn_add(a : DsgraphadjmatrixGraphN, b : DsgraphadjmatrixGraphN) -> DsgraphadjmatrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_graphn_copy(s : DsgraphadjmatrixGraphN) -> DsgraphadjmatrixGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_graphn_fill(s : DsgraphadjmatrixGraphN, v : Double) -> DsgraphadjmatrixGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_graphn_min(s : DsgraphadjmatrixGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_graphn_max(s : DsgraphadjmatrixGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_graphn_to_string(s : DsgraphadjmatrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_node_make(size : Int) -> DsgraphadjmatrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_node_len(s : DsgraphadjmatrixNode) -> Int { s.size }

pub fn ds_graph_adj_matrix_node_get(s : DsgraphadjmatrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_node_set(s : DsgraphadjmatrixNode, i : Int, v : Double) -> DsgraphadjmatrixNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_node_sum(s : DsgraphadjmatrixNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_node_mean(s : DsgraphadjmatrixNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_node_scale(s : DsgraphadjmatrixNode, f : Double) -> DsgraphadjmatrixNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_node_add(a : DsgraphadjmatrixNode, b : DsgraphadjmatrixNode) -> DsgraphadjmatrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_node_copy(s : DsgraphadjmatrixNode) -> DsgraphadjmatrixNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_node_fill(s : DsgraphadjmatrixNode, v : Double) -> DsgraphadjmatrixNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_node_min(s : DsgraphadjmatrixNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_node_max(s : DsgraphadjmatrixNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_node_to_string(s : DsgraphadjmatrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_edge_make(size : Int) -> DsgraphadjmatrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_edge_len(s : DsgraphadjmatrixEdge) -> Int { s.size }

pub fn ds_graph_adj_matrix_edge_get(s : DsgraphadjmatrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_edge_set(s : DsgraphadjmatrixEdge, i : Int, v : Double) -> DsgraphadjmatrixEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_edge_sum(s : DsgraphadjmatrixEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_edge_mean(s : DsgraphadjmatrixEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_edge_scale(s : DsgraphadjmatrixEdge, f : Double) -> DsgraphadjmatrixEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_edge_add(a : DsgraphadjmatrixEdge, b : DsgraphadjmatrixEdge) -> DsgraphadjmatrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_edge_copy(s : DsgraphadjmatrixEdge) -> DsgraphadjmatrixEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_edge_fill(s : DsgraphadjmatrixEdge, v : Double) -> DsgraphadjmatrixEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_edge_min(s : DsgraphadjmatrixEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_edge_max(s : DsgraphadjmatrixEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_edge_to_string(s : DsgraphadjmatrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_path_make(size : Int) -> DsgraphadjmatrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_path_len(s : DsgraphadjmatrixPath) -> Int { s.size }

pub fn ds_graph_adj_matrix_path_get(s : DsgraphadjmatrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_path_set(s : DsgraphadjmatrixPath, i : Int, v : Double) -> DsgraphadjmatrixPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_path_sum(s : DsgraphadjmatrixPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_path_mean(s : DsgraphadjmatrixPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_path_scale(s : DsgraphadjmatrixPath, f : Double) -> DsgraphadjmatrixPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_path_add(a : DsgraphadjmatrixPath, b : DsgraphadjmatrixPath) -> DsgraphadjmatrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_path_copy(s : DsgraphadjmatrixPath) -> DsgraphadjmatrixPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_path_fill(s : DsgraphadjmatrixPath, v : Double) -> DsgraphadjmatrixPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_path_min(s : DsgraphadjmatrixPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_path_max(s : DsgraphadjmatrixPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_path_to_string(s : DsgraphadjmatrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_cluster_make(size : Int) -> DsgraphadjmatrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_cluster_len(s : DsgraphadjmatrixCluster) -> Int { s.size }

pub fn ds_graph_adj_matrix_cluster_get(s : DsgraphadjmatrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_cluster_set(s : DsgraphadjmatrixCluster, i : Int, v : Double) -> DsgraphadjmatrixCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cluster_sum(s : DsgraphadjmatrixCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_cluster_mean(s : DsgraphadjmatrixCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_cluster_scale(s : DsgraphadjmatrixCluster, f : Double) -> DsgraphadjmatrixCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cluster_add(a : DsgraphadjmatrixCluster, b : DsgraphadjmatrixCluster) -> DsgraphadjmatrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_cluster_copy(s : DsgraphadjmatrixCluster) -> DsgraphadjmatrixCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cluster_fill(s : DsgraphadjmatrixCluster, v : Double) -> DsgraphadjmatrixCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cluster_min(s : DsgraphadjmatrixCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_cluster_max(s : DsgraphadjmatrixCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_cluster_to_string(s : DsgraphadjmatrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_model_make(size : Int) -> DsgraphadjmatrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_model_len(s : DsgraphadjmatrixModel) -> Int { s.size }

pub fn ds_graph_adj_matrix_model_get(s : DsgraphadjmatrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_model_set(s : DsgraphadjmatrixModel, i : Int, v : Double) -> DsgraphadjmatrixModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_model_sum(s : DsgraphadjmatrixModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_model_mean(s : DsgraphadjmatrixModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_model_scale(s : DsgraphadjmatrixModel, f : Double) -> DsgraphadjmatrixModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_model_add(a : DsgraphadjmatrixModel, b : DsgraphadjmatrixModel) -> DsgraphadjmatrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_model_copy(s : DsgraphadjmatrixModel) -> DsgraphadjmatrixModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_model_fill(s : DsgraphadjmatrixModel, v : Double) -> DsgraphadjmatrixModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_model_min(s : DsgraphadjmatrixModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_model_max(s : DsgraphadjmatrixModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_model_to_string(s : DsgraphadjmatrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_layer_make(size : Int) -> DsgraphadjmatrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_layer_len(s : DsgraphadjmatrixLayer) -> Int { s.size }

pub fn ds_graph_adj_matrix_layer_get(s : DsgraphadjmatrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_layer_set(s : DsgraphadjmatrixLayer, i : Int, v : Double) -> DsgraphadjmatrixLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_layer_sum(s : DsgraphadjmatrixLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_layer_mean(s : DsgraphadjmatrixLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_layer_scale(s : DsgraphadjmatrixLayer, f : Double) -> DsgraphadjmatrixLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_layer_add(a : DsgraphadjmatrixLayer, b : DsgraphadjmatrixLayer) -> DsgraphadjmatrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_layer_copy(s : DsgraphadjmatrixLayer) -> DsgraphadjmatrixLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_layer_fill(s : DsgraphadjmatrixLayer, v : Double) -> DsgraphadjmatrixLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_layer_min(s : DsgraphadjmatrixLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_layer_max(s : DsgraphadjmatrixLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_layer_to_string(s : DsgraphadjmatrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_buffer_make(size : Int) -> DsgraphadjmatrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_buffer_len(s : DsgraphadjmatrixBuffer) -> Int { s.size }

pub fn ds_graph_adj_matrix_buffer_get(s : DsgraphadjmatrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_buffer_set(s : DsgraphadjmatrixBuffer, i : Int, v : Double) -> DsgraphadjmatrixBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_buffer_sum(s : DsgraphadjmatrixBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_buffer_mean(s : DsgraphadjmatrixBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_buffer_scale(s : DsgraphadjmatrixBuffer, f : Double) -> DsgraphadjmatrixBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_buffer_add(a : DsgraphadjmatrixBuffer, b : DsgraphadjmatrixBuffer) -> DsgraphadjmatrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_buffer_copy(s : DsgraphadjmatrixBuffer) -> DsgraphadjmatrixBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_buffer_fill(s : DsgraphadjmatrixBuffer, v : Double) -> DsgraphadjmatrixBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_buffer_min(s : DsgraphadjmatrixBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_buffer_max(s : DsgraphadjmatrixBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_buffer_to_string(s : DsgraphadjmatrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_cursor_make(size : Int) -> DsgraphadjmatrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_cursor_len(s : DsgraphadjmatrixCursor) -> Int { s.size }

pub fn ds_graph_adj_matrix_cursor_get(s : DsgraphadjmatrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_cursor_set(s : DsgraphadjmatrixCursor, i : Int, v : Double) -> DsgraphadjmatrixCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cursor_sum(s : DsgraphadjmatrixCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_cursor_mean(s : DsgraphadjmatrixCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_cursor_scale(s : DsgraphadjmatrixCursor, f : Double) -> DsgraphadjmatrixCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cursor_add(a : DsgraphadjmatrixCursor, b : DsgraphadjmatrixCursor) -> DsgraphadjmatrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_cursor_copy(s : DsgraphadjmatrixCursor) -> DsgraphadjmatrixCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cursor_fill(s : DsgraphadjmatrixCursor, v : Double) -> DsgraphadjmatrixCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_cursor_min(s : DsgraphadjmatrixCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_cursor_max(s : DsgraphadjmatrixCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_cursor_to_string(s : DsgraphadjmatrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_view_make(size : Int) -> DsgraphadjmatrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_view_len(s : DsgraphadjmatrixView) -> Int { s.size }

pub fn ds_graph_adj_matrix_view_get(s : DsgraphadjmatrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_view_set(s : DsgraphadjmatrixView, i : Int, v : Double) -> DsgraphadjmatrixView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_view_sum(s : DsgraphadjmatrixView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_view_mean(s : DsgraphadjmatrixView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_view_scale(s : DsgraphadjmatrixView, f : Double) -> DsgraphadjmatrixView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_view_add(a : DsgraphadjmatrixView, b : DsgraphadjmatrixView) -> DsgraphadjmatrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_view_copy(s : DsgraphadjmatrixView) -> DsgraphadjmatrixView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_view_fill(s : DsgraphadjmatrixView, v : Double) -> DsgraphadjmatrixView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_view_min(s : DsgraphadjmatrixView) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_view_max(s : DsgraphadjmatrixView) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_view_to_string(s : DsgraphadjmatrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_range_make(size : Int) -> DsgraphadjmatrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_range_len(s : DsgraphadjmatrixRange) -> Int { s.size }

pub fn ds_graph_adj_matrix_range_get(s : DsgraphadjmatrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_range_set(s : DsgraphadjmatrixRange, i : Int, v : Double) -> DsgraphadjmatrixRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_range_sum(s : DsgraphadjmatrixRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_range_mean(s : DsgraphadjmatrixRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_range_scale(s : DsgraphadjmatrixRange, f : Double) -> DsgraphadjmatrixRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_range_add(a : DsgraphadjmatrixRange, b : DsgraphadjmatrixRange) -> DsgraphadjmatrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_range_copy(s : DsgraphadjmatrixRange) -> DsgraphadjmatrixRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_range_fill(s : DsgraphadjmatrixRange, v : Double) -> DsgraphadjmatrixRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_range_min(s : DsgraphadjmatrixRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_range_max(s : DsgraphadjmatrixRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_range_to_string(s : DsgraphadjmatrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_slice_make(size : Int) -> DsgraphadjmatrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_slice_len(s : DsgraphadjmatrixSlice) -> Int { s.size }

pub fn ds_graph_adj_matrix_slice_get(s : DsgraphadjmatrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_slice_set(s : DsgraphadjmatrixSlice, i : Int, v : Double) -> DsgraphadjmatrixSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_slice_sum(s : DsgraphadjmatrixSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_adj_matrix_slice_mean(s : DsgraphadjmatrixSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_adj_matrix_slice_scale(s : DsgraphadjmatrixSlice, f : Double) -> DsgraphadjmatrixSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_slice_add(a : DsgraphadjmatrixSlice, b : DsgraphadjmatrixSlice) -> DsgraphadjmatrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_adj_matrix_slice_copy(s : DsgraphadjmatrixSlice) -> DsgraphadjmatrixSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_slice_fill(s : DsgraphadjmatrixSlice, v : Double) -> DsgraphadjmatrixSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_adj_matrix_slice_min(s : DsgraphadjmatrixSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_adj_matrix_slice_max(s : DsgraphadjmatrixSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_adj_matrix_slice_to_string(s : DsgraphadjmatrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

