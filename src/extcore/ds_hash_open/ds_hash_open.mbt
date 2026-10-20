///===
/// extcore/ds_hash_open

pub(all) struct DshashopenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_open_make_point(x : Double, y : Double) -> DshashopenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_open_make_point3(x : Double, y : Double, z : Double) -> DshashopenPoint {
  { x, y, z, label: 0 }
}

pub fn DshashopenPoint::x(self : DshashopenPoint) -> Double { self.x }

pub fn DshashopenPoint::y(self : DshashopenPoint) -> Double { self.y }

pub fn DshashopenPoint::z(self : DshashopenPoint) -> Double { self.z }

pub fn DshashopenPoint::label(self : DshashopenPoint) -> Int { self.label }

pub fn DshashopenPoint::dist(self : DshashopenPoint, other : DshashopenPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashopenPoint::add(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashopenPoint::sub(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashopenPoint::scale(self : DshashopenPoint, s : Double) -> DshashopenPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashopenPoint::dot(self : DshashopenPoint, other : DshashopenPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashopenPoint::cross(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashopenPoint::norm(self : DshashopenPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashopenPoint::normalize(self : DshashopenPoint) -> DshashopenPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashopenPoint::negate(self : DshashopenPoint) -> DshashopenPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashopenPoint::mid(self : DshashopenPoint, other : DshashopenPoint) -> DshashopenPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashopenPoint::lerp(self : DshashopenPoint, other : DshashopenPoint, t : Double) -> DshashopenPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashopenPoint::to_string(self : DshashopenPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashopenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_open_make_series(vals : Array[Double], name : String) -> DshashopenSeries {
  { vals, name, meta: 0 }
}

pub fn DshashopenSeries::len(self : DshashopenSeries) -> Int { self.vals.length() }

pub fn DshashopenSeries::sum(self : DshashopenSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashopenSeries::mean(self : DshashopenSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashopenSeries::min(self : DshashopenSeries) -> Double { @_common.min(self.vals) }

pub fn DshashopenSeries::max(self : DshashopenSeries) -> Double { @_common.max(self.vals) }

pub fn DshashopenSeries::range(self : DshashopenSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashopenSeries::variance(self : DshashopenSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashopenSeries::std(self : DshashopenSeries) -> Double { @_common.std(self.vals) }

pub fn DshashopenSeries::median(self : DshashopenSeries) -> Double { @_common.median(self.vals) }

pub fn DshashopenSeries::scale(self : DshashopenSeries, f : Double) -> DshashopenSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashopenSeries::add(self : DshashopenSeries, other : DshashopenSeries) -> DshashopenSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashopenSeries::sub(self : DshashopenSeries, other : DshashopenSeries) -> DshashopenSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashopenSeries::normalize(self : DshashopenSeries) -> DshashopenSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashopenSeries::cumsum(self : DshashopenSeries) -> DshashopenSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashopenSeries::to_string(self : DshashopenSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashopenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_open_make_matrix(rows : Int, cols : Int, val : Double) -> DshashopenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_open_matrix_identity(n : Int) -> DshashopenMatrix {
  let m = ds_hash_open_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashopenMatrix::get(self : DshashopenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashopenMatrix::transpose(self : DshashopenMatrix) -> DshashopenMatrix {
  let result = ds_hash_open_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashopenMatrix::add(self : DshashopenMatrix, other : DshashopenMatrix) -> DshashopenMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashopenMatrix::scale(self : DshashopenMatrix, s : Double) -> DshashopenMatrix {
  let result = ds_hash_open_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashopenMatrix::multiply(self : DshashopenMatrix, other : DshashopenMatrix) -> DshashopenMatrix {
  if self.cols != other.rows { return ds_hash_open_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_open_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashopenMatrix::trace(self : DshashopenMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashopenMatrix::det(self : DshashopenMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashopenMatrix::norm(self : DshashopenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashopenMatrix::to_string(self : DshashopenMatrix) -> String {
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

pub(all) struct DshashopenVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_open_make_vector(comps : Array[Double]) -> DshashopenVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_open_vector_zero(dim : Int) -> DshashopenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashopenVector::add(self : DshashopenVector, other : DshashopenVector) -> DshashopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashopenVector::sub(self : DshashopenVector, other : DshashopenVector) -> DshashopenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashopenVector::scale(self : DshashopenVector, s : Double) -> DshashopenVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashopenVector::dot(self : DshashopenVector, other : DshashopenVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashopenVector::norm(self : DshashopenVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashopenVector::normalize(self : DshashopenVector) -> DshashopenVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashopenVector::dist(self : DshashopenVector, other : DshashopenVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashopenVector::to_string(self : DshashopenVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_open_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_open_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_open_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_open_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_open_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_open_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_open_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_open_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_open_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_open_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_open_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_open_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_open_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_open_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_open_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_open_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_open_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_open_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_open_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_open_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_open_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_open_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_open_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_open_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_open_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_open_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_open_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_open_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_open_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashopenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_frame_make(size : Int) -> DshashopenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_frame_len(s : DshashopenFrame) -> Int { s.size }

pub fn ds_hash_open_frame_get(s : DshashopenFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_frame_set(s : DshashopenFrame, i : Int, v : Double) -> DshashopenFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_frame_sum(s : DshashopenFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_frame_mean(s : DshashopenFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_frame_scale(s : DshashopenFrame, f : Double) -> DshashopenFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_frame_add(a : DshashopenFrame, b : DshashopenFrame) -> DshashopenFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_frame_copy(s : DshashopenFrame) -> DshashopenFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_frame_fill(s : DshashopenFrame, v : Double) -> DshashopenFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_frame_min(s : DshashopenFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_frame_max(s : DshashopenFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_frame_to_string(s : DshashopenFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_table_make(size : Int) -> DshashopenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_table_len(s : DshashopenTable) -> Int { s.size }

pub fn ds_hash_open_table_get(s : DshashopenTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_table_set(s : DshashopenTable, i : Int, v : Double) -> DshashopenTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_table_sum(s : DshashopenTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_table_mean(s : DshashopenTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_table_scale(s : DshashopenTable, f : Double) -> DshashopenTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_table_add(a : DshashopenTable, b : DshashopenTable) -> DshashopenTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_table_copy(s : DshashopenTable) -> DshashopenTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_table_fill(s : DshashopenTable, v : Double) -> DshashopenTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_table_min(s : DshashopenTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_table_max(s : DshashopenTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_table_to_string(s : DshashopenTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_graphn_make(size : Int) -> DshashopenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_graphn_len(s : DshashopenGraphN) -> Int { s.size }

pub fn ds_hash_open_graphn_get(s : DshashopenGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_graphn_set(s : DshashopenGraphN, i : Int, v : Double) -> DshashopenGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_graphn_sum(s : DshashopenGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_graphn_mean(s : DshashopenGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_graphn_scale(s : DshashopenGraphN, f : Double) -> DshashopenGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_graphn_add(a : DshashopenGraphN, b : DshashopenGraphN) -> DshashopenGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_graphn_copy(s : DshashopenGraphN) -> DshashopenGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_graphn_fill(s : DshashopenGraphN, v : Double) -> DshashopenGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_graphn_min(s : DshashopenGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_graphn_max(s : DshashopenGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_graphn_to_string(s : DshashopenGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_node_make(size : Int) -> DshashopenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_node_len(s : DshashopenNode) -> Int { s.size }

pub fn ds_hash_open_node_get(s : DshashopenNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_node_set(s : DshashopenNode, i : Int, v : Double) -> DshashopenNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_node_sum(s : DshashopenNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_node_mean(s : DshashopenNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_node_scale(s : DshashopenNode, f : Double) -> DshashopenNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_node_add(a : DshashopenNode, b : DshashopenNode) -> DshashopenNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_node_copy(s : DshashopenNode) -> DshashopenNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_node_fill(s : DshashopenNode, v : Double) -> DshashopenNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_node_min(s : DshashopenNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_node_max(s : DshashopenNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_node_to_string(s : DshashopenNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_edge_make(size : Int) -> DshashopenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_edge_len(s : DshashopenEdge) -> Int { s.size }

pub fn ds_hash_open_edge_get(s : DshashopenEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_edge_set(s : DshashopenEdge, i : Int, v : Double) -> DshashopenEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_edge_sum(s : DshashopenEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_edge_mean(s : DshashopenEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_edge_scale(s : DshashopenEdge, f : Double) -> DshashopenEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_edge_add(a : DshashopenEdge, b : DshashopenEdge) -> DshashopenEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_edge_copy(s : DshashopenEdge) -> DshashopenEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_edge_fill(s : DshashopenEdge, v : Double) -> DshashopenEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_edge_min(s : DshashopenEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_edge_max(s : DshashopenEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_edge_to_string(s : DshashopenEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_path_make(size : Int) -> DshashopenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_path_len(s : DshashopenPath) -> Int { s.size }

pub fn ds_hash_open_path_get(s : DshashopenPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_path_set(s : DshashopenPath, i : Int, v : Double) -> DshashopenPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_path_sum(s : DshashopenPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_path_mean(s : DshashopenPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_path_scale(s : DshashopenPath, f : Double) -> DshashopenPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_path_add(a : DshashopenPath, b : DshashopenPath) -> DshashopenPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_path_copy(s : DshashopenPath) -> DshashopenPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_path_fill(s : DshashopenPath, v : Double) -> DshashopenPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_path_min(s : DshashopenPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_path_max(s : DshashopenPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_path_to_string(s : DshashopenPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_cluster_make(size : Int) -> DshashopenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_cluster_len(s : DshashopenCluster) -> Int { s.size }

pub fn ds_hash_open_cluster_get(s : DshashopenCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_cluster_set(s : DshashopenCluster, i : Int, v : Double) -> DshashopenCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cluster_sum(s : DshashopenCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_cluster_mean(s : DshashopenCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_cluster_scale(s : DshashopenCluster, f : Double) -> DshashopenCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cluster_add(a : DshashopenCluster, b : DshashopenCluster) -> DshashopenCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_cluster_copy(s : DshashopenCluster) -> DshashopenCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cluster_fill(s : DshashopenCluster, v : Double) -> DshashopenCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cluster_min(s : DshashopenCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_cluster_max(s : DshashopenCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_cluster_to_string(s : DshashopenCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_model_make(size : Int) -> DshashopenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_model_len(s : DshashopenModel) -> Int { s.size }

pub fn ds_hash_open_model_get(s : DshashopenModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_model_set(s : DshashopenModel, i : Int, v : Double) -> DshashopenModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_model_sum(s : DshashopenModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_model_mean(s : DshashopenModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_model_scale(s : DshashopenModel, f : Double) -> DshashopenModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_model_add(a : DshashopenModel, b : DshashopenModel) -> DshashopenModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_model_copy(s : DshashopenModel) -> DshashopenModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_model_fill(s : DshashopenModel, v : Double) -> DshashopenModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_model_min(s : DshashopenModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_model_max(s : DshashopenModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_model_to_string(s : DshashopenModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_layer_make(size : Int) -> DshashopenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_layer_len(s : DshashopenLayer) -> Int { s.size }

pub fn ds_hash_open_layer_get(s : DshashopenLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_layer_set(s : DshashopenLayer, i : Int, v : Double) -> DshashopenLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_layer_sum(s : DshashopenLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_layer_mean(s : DshashopenLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_layer_scale(s : DshashopenLayer, f : Double) -> DshashopenLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_layer_add(a : DshashopenLayer, b : DshashopenLayer) -> DshashopenLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_layer_copy(s : DshashopenLayer) -> DshashopenLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_layer_fill(s : DshashopenLayer, v : Double) -> DshashopenLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_layer_min(s : DshashopenLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_layer_max(s : DshashopenLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_layer_to_string(s : DshashopenLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_buffer_make(size : Int) -> DshashopenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_buffer_len(s : DshashopenBuffer) -> Int { s.size }

pub fn ds_hash_open_buffer_get(s : DshashopenBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_buffer_set(s : DshashopenBuffer, i : Int, v : Double) -> DshashopenBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_buffer_sum(s : DshashopenBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_buffer_mean(s : DshashopenBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_buffer_scale(s : DshashopenBuffer, f : Double) -> DshashopenBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_buffer_add(a : DshashopenBuffer, b : DshashopenBuffer) -> DshashopenBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_buffer_copy(s : DshashopenBuffer) -> DshashopenBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_buffer_fill(s : DshashopenBuffer, v : Double) -> DshashopenBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_buffer_min(s : DshashopenBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_buffer_max(s : DshashopenBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_buffer_to_string(s : DshashopenBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_cursor_make(size : Int) -> DshashopenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_cursor_len(s : DshashopenCursor) -> Int { s.size }

pub fn ds_hash_open_cursor_get(s : DshashopenCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_cursor_set(s : DshashopenCursor, i : Int, v : Double) -> DshashopenCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cursor_sum(s : DshashopenCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_cursor_mean(s : DshashopenCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_cursor_scale(s : DshashopenCursor, f : Double) -> DshashopenCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cursor_add(a : DshashopenCursor, b : DshashopenCursor) -> DshashopenCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_cursor_copy(s : DshashopenCursor) -> DshashopenCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cursor_fill(s : DshashopenCursor, v : Double) -> DshashopenCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_cursor_min(s : DshashopenCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_cursor_max(s : DshashopenCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_cursor_to_string(s : DshashopenCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_view_make(size : Int) -> DshashopenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_view_len(s : DshashopenView) -> Int { s.size }

pub fn ds_hash_open_view_get(s : DshashopenView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_view_set(s : DshashopenView, i : Int, v : Double) -> DshashopenView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_view_sum(s : DshashopenView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_view_mean(s : DshashopenView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_view_scale(s : DshashopenView, f : Double) -> DshashopenView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_view_add(a : DshashopenView, b : DshashopenView) -> DshashopenView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_view_copy(s : DshashopenView) -> DshashopenView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_view_fill(s : DshashopenView, v : Double) -> DshashopenView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_view_min(s : DshashopenView) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_view_max(s : DshashopenView) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_view_to_string(s : DshashopenView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_range_make(size : Int) -> DshashopenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_range_len(s : DshashopenRange) -> Int { s.size }

pub fn ds_hash_open_range_get(s : DshashopenRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_range_set(s : DshashopenRange, i : Int, v : Double) -> DshashopenRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_range_sum(s : DshashopenRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_range_mean(s : DshashopenRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_range_scale(s : DshashopenRange, f : Double) -> DshashopenRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_range_add(a : DshashopenRange, b : DshashopenRange) -> DshashopenRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_range_copy(s : DshashopenRange) -> DshashopenRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_range_fill(s : DshashopenRange, v : Double) -> DshashopenRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_range_min(s : DshashopenRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_range_max(s : DshashopenRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_range_to_string(s : DshashopenRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashopenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_open_slice_make(size : Int) -> DshashopenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_open_slice_len(s : DshashopenSlice) -> Int { s.size }

pub fn ds_hash_open_slice_get(s : DshashopenSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_open_slice_set(s : DshashopenSlice, i : Int, v : Double) -> DshashopenSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_open_slice_sum(s : DshashopenSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_open_slice_mean(s : DshashopenSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_open_slice_scale(s : DshashopenSlice, f : Double) -> DshashopenSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_slice_add(a : DshashopenSlice, b : DshashopenSlice) -> DshashopenSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_open_slice_copy(s : DshashopenSlice) -> DshashopenSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_slice_fill(s : DshashopenSlice, v : Double) -> DshashopenSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_open_slice_min(s : DshashopenSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_open_slice_max(s : DshashopenSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_open_slice_to_string(s : DshashopenSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

