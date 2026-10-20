///===
/// extcore/ds_list_singly

pub(all) struct DslistsinglyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_singly_make_point(x : Double, y : Double) -> DslistsinglyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_singly_make_point3(x : Double, y : Double, z : Double) -> DslistsinglyPoint {
  { x, y, z, label: 0 }
}

pub fn DslistsinglyPoint::x(self : DslistsinglyPoint) -> Double { self.x }

pub fn DslistsinglyPoint::y(self : DslistsinglyPoint) -> Double { self.y }

pub fn DslistsinglyPoint::z(self : DslistsinglyPoint) -> Double { self.z }

pub fn DslistsinglyPoint::label(self : DslistsinglyPoint) -> Int { self.label }

pub fn DslistsinglyPoint::dist(self : DslistsinglyPoint, other : DslistsinglyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistsinglyPoint::add(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistsinglyPoint::sub(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistsinglyPoint::scale(self : DslistsinglyPoint, s : Double) -> DslistsinglyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistsinglyPoint::dot(self : DslistsinglyPoint, other : DslistsinglyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistsinglyPoint::cross(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistsinglyPoint::norm(self : DslistsinglyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistsinglyPoint::normalize(self : DslistsinglyPoint) -> DslistsinglyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistsinglyPoint::negate(self : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistsinglyPoint::mid(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistsinglyPoint::lerp(self : DslistsinglyPoint, other : DslistsinglyPoint, t : Double) -> DslistsinglyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistsinglyPoint::to_string(self : DslistsinglyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistsinglySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_singly_make_series(vals : Array[Double], name : String) -> DslistsinglySeries {
  { vals, name, meta: 0 }
}

pub fn DslistsinglySeries::len(self : DslistsinglySeries) -> Int { self.vals.length() }

pub fn DslistsinglySeries::sum(self : DslistsinglySeries) -> Double { @_common.sum(self.vals) }

pub fn DslistsinglySeries::mean(self : DslistsinglySeries) -> Double { @_common.mean(self.vals) }

pub fn DslistsinglySeries::min(self : DslistsinglySeries) -> Double { @_common.min(self.vals) }

pub fn DslistsinglySeries::max(self : DslistsinglySeries) -> Double { @_common.max(self.vals) }

pub fn DslistsinglySeries::range(self : DslistsinglySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistsinglySeries::variance(self : DslistsinglySeries) -> Double { @_common.variance(self.vals) }

pub fn DslistsinglySeries::std(self : DslistsinglySeries) -> Double { @_common.std(self.vals) }

pub fn DslistsinglySeries::median(self : DslistsinglySeries) -> Double { @_common.median(self.vals) }

pub fn DslistsinglySeries::scale(self : DslistsinglySeries, f : Double) -> DslistsinglySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistsinglySeries::add(self : DslistsinglySeries, other : DslistsinglySeries) -> DslistsinglySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistsinglySeries::sub(self : DslistsinglySeries, other : DslistsinglySeries) -> DslistsinglySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistsinglySeries::normalize(self : DslistsinglySeries) -> DslistsinglySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistsinglySeries::cumsum(self : DslistsinglySeries) -> DslistsinglySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistsinglySeries::to_string(self : DslistsinglySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistsinglyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_singly_make_matrix(rows : Int, cols : Int, val : Double) -> DslistsinglyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_singly_matrix_identity(n : Int) -> DslistsinglyMatrix {
  let m = ds_list_singly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistsinglyMatrix::get(self : DslistsinglyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistsinglyMatrix::transpose(self : DslistsinglyMatrix) -> DslistsinglyMatrix {
  let result = ds_list_singly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistsinglyMatrix::add(self : DslistsinglyMatrix, other : DslistsinglyMatrix) -> DslistsinglyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_singly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistsinglyMatrix::scale(self : DslistsinglyMatrix, s : Double) -> DslistsinglyMatrix {
  let result = ds_list_singly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistsinglyMatrix::multiply(self : DslistsinglyMatrix, other : DslistsinglyMatrix) -> DslistsinglyMatrix {
  if self.cols != other.rows { return ds_list_singly_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_singly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistsinglyMatrix::trace(self : DslistsinglyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistsinglyMatrix::det(self : DslistsinglyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistsinglyMatrix::norm(self : DslistsinglyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistsinglyMatrix::to_string(self : DslistsinglyMatrix) -> String {
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

pub(all) struct DslistsinglyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_singly_make_vector(comps : Array[Double]) -> DslistsinglyVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_singly_vector_zero(dim : Int) -> DslistsinglyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistsinglyVector::add(self : DslistsinglyVector, other : DslistsinglyVector) -> DslistsinglyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistsinglyVector::sub(self : DslistsinglyVector, other : DslistsinglyVector) -> DslistsinglyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistsinglyVector::scale(self : DslistsinglyVector, s : Double) -> DslistsinglyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistsinglyVector::dot(self : DslistsinglyVector, other : DslistsinglyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistsinglyVector::norm(self : DslistsinglyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistsinglyVector::normalize(self : DslistsinglyVector) -> DslistsinglyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistsinglyVector::dist(self : DslistsinglyVector, other : DslistsinglyVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistsinglyVector::to_string(self : DslistsinglyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_singly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_singly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_singly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_singly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_singly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_singly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_singly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_singly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_singly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_singly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_singly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_singly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_singly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_singly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_singly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_singly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_singly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_singly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_singly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_singly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_singly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_singly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_singly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_singly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_singly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_singly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_singly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_singly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_singly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistsinglyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_frame_make(size : Int) -> DslistsinglyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_frame_len(s : DslistsinglyFrame) -> Int { s.size }

pub fn ds_list_singly_frame_get(s : DslistsinglyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_frame_set(s : DslistsinglyFrame, i : Int, v : Double) -> DslistsinglyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_frame_sum(s : DslistsinglyFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_frame_mean(s : DslistsinglyFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_frame_scale(s : DslistsinglyFrame, f : Double) -> DslistsinglyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_frame_add(a : DslistsinglyFrame, b : DslistsinglyFrame) -> DslistsinglyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_frame_copy(s : DslistsinglyFrame) -> DslistsinglyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_frame_fill(s : DslistsinglyFrame, v : Double) -> DslistsinglyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_frame_min(s : DslistsinglyFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_frame_max(s : DslistsinglyFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_frame_to_string(s : DslistsinglyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_table_make(size : Int) -> DslistsinglyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_table_len(s : DslistsinglyTable) -> Int { s.size }

pub fn ds_list_singly_table_get(s : DslistsinglyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_table_set(s : DslistsinglyTable, i : Int, v : Double) -> DslistsinglyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_table_sum(s : DslistsinglyTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_table_mean(s : DslistsinglyTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_table_scale(s : DslistsinglyTable, f : Double) -> DslistsinglyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_table_add(a : DslistsinglyTable, b : DslistsinglyTable) -> DslistsinglyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_table_copy(s : DslistsinglyTable) -> DslistsinglyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_table_fill(s : DslistsinglyTable, v : Double) -> DslistsinglyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_table_min(s : DslistsinglyTable) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_table_max(s : DslistsinglyTable) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_table_to_string(s : DslistsinglyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_graphn_make(size : Int) -> DslistsinglyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_graphn_len(s : DslistsinglyGraphN) -> Int { s.size }

pub fn ds_list_singly_graphn_get(s : DslistsinglyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_graphn_set(s : DslistsinglyGraphN, i : Int, v : Double) -> DslistsinglyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_graphn_sum(s : DslistsinglyGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_graphn_mean(s : DslistsinglyGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_graphn_scale(s : DslistsinglyGraphN, f : Double) -> DslistsinglyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_graphn_add(a : DslistsinglyGraphN, b : DslistsinglyGraphN) -> DslistsinglyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_graphn_copy(s : DslistsinglyGraphN) -> DslistsinglyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_graphn_fill(s : DslistsinglyGraphN, v : Double) -> DslistsinglyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_graphn_min(s : DslistsinglyGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_graphn_max(s : DslistsinglyGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_graphn_to_string(s : DslistsinglyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_node_make(size : Int) -> DslistsinglyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_node_len(s : DslistsinglyNode) -> Int { s.size }

pub fn ds_list_singly_node_get(s : DslistsinglyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_node_set(s : DslistsinglyNode, i : Int, v : Double) -> DslistsinglyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_node_sum(s : DslistsinglyNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_node_mean(s : DslistsinglyNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_node_scale(s : DslistsinglyNode, f : Double) -> DslistsinglyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_node_add(a : DslistsinglyNode, b : DslistsinglyNode) -> DslistsinglyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_node_copy(s : DslistsinglyNode) -> DslistsinglyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_node_fill(s : DslistsinglyNode, v : Double) -> DslistsinglyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_node_min(s : DslistsinglyNode) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_node_max(s : DslistsinglyNode) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_node_to_string(s : DslistsinglyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_edge_make(size : Int) -> DslistsinglyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_edge_len(s : DslistsinglyEdge) -> Int { s.size }

pub fn ds_list_singly_edge_get(s : DslistsinglyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_edge_set(s : DslistsinglyEdge, i : Int, v : Double) -> DslistsinglyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_edge_sum(s : DslistsinglyEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_edge_mean(s : DslistsinglyEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_edge_scale(s : DslistsinglyEdge, f : Double) -> DslistsinglyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_edge_add(a : DslistsinglyEdge, b : DslistsinglyEdge) -> DslistsinglyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_edge_copy(s : DslistsinglyEdge) -> DslistsinglyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_edge_fill(s : DslistsinglyEdge, v : Double) -> DslistsinglyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_edge_min(s : DslistsinglyEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_edge_max(s : DslistsinglyEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_edge_to_string(s : DslistsinglyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_path_make(size : Int) -> DslistsinglyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_path_len(s : DslistsinglyPath) -> Int { s.size }

pub fn ds_list_singly_path_get(s : DslistsinglyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_path_set(s : DslistsinglyPath, i : Int, v : Double) -> DslistsinglyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_path_sum(s : DslistsinglyPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_path_mean(s : DslistsinglyPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_path_scale(s : DslistsinglyPath, f : Double) -> DslistsinglyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_path_add(a : DslistsinglyPath, b : DslistsinglyPath) -> DslistsinglyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_path_copy(s : DslistsinglyPath) -> DslistsinglyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_path_fill(s : DslistsinglyPath, v : Double) -> DslistsinglyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_path_min(s : DslistsinglyPath) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_path_max(s : DslistsinglyPath) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_path_to_string(s : DslistsinglyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_cluster_make(size : Int) -> DslistsinglyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_cluster_len(s : DslistsinglyCluster) -> Int { s.size }

pub fn ds_list_singly_cluster_get(s : DslistsinglyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_cluster_set(s : DslistsinglyCluster, i : Int, v : Double) -> DslistsinglyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cluster_sum(s : DslistsinglyCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_cluster_mean(s : DslistsinglyCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_cluster_scale(s : DslistsinglyCluster, f : Double) -> DslistsinglyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cluster_add(a : DslistsinglyCluster, b : DslistsinglyCluster) -> DslistsinglyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_cluster_copy(s : DslistsinglyCluster) -> DslistsinglyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cluster_fill(s : DslistsinglyCluster, v : Double) -> DslistsinglyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cluster_min(s : DslistsinglyCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_cluster_max(s : DslistsinglyCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_cluster_to_string(s : DslistsinglyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_model_make(size : Int) -> DslistsinglyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_model_len(s : DslistsinglyModel) -> Int { s.size }

pub fn ds_list_singly_model_get(s : DslistsinglyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_model_set(s : DslistsinglyModel, i : Int, v : Double) -> DslistsinglyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_model_sum(s : DslistsinglyModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_model_mean(s : DslistsinglyModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_model_scale(s : DslistsinglyModel, f : Double) -> DslistsinglyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_model_add(a : DslistsinglyModel, b : DslistsinglyModel) -> DslistsinglyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_model_copy(s : DslistsinglyModel) -> DslistsinglyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_model_fill(s : DslistsinglyModel, v : Double) -> DslistsinglyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_model_min(s : DslistsinglyModel) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_model_max(s : DslistsinglyModel) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_model_to_string(s : DslistsinglyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_layer_make(size : Int) -> DslistsinglyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_layer_len(s : DslistsinglyLayer) -> Int { s.size }

pub fn ds_list_singly_layer_get(s : DslistsinglyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_layer_set(s : DslistsinglyLayer, i : Int, v : Double) -> DslistsinglyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_layer_sum(s : DslistsinglyLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_layer_mean(s : DslistsinglyLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_layer_scale(s : DslistsinglyLayer, f : Double) -> DslistsinglyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_layer_add(a : DslistsinglyLayer, b : DslistsinglyLayer) -> DslistsinglyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_layer_copy(s : DslistsinglyLayer) -> DslistsinglyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_layer_fill(s : DslistsinglyLayer, v : Double) -> DslistsinglyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_layer_min(s : DslistsinglyLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_layer_max(s : DslistsinglyLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_layer_to_string(s : DslistsinglyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_buffer_make(size : Int) -> DslistsinglyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_buffer_len(s : DslistsinglyBuffer) -> Int { s.size }

pub fn ds_list_singly_buffer_get(s : DslistsinglyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_buffer_set(s : DslistsinglyBuffer, i : Int, v : Double) -> DslistsinglyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_buffer_sum(s : DslistsinglyBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_buffer_mean(s : DslistsinglyBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_buffer_scale(s : DslistsinglyBuffer, f : Double) -> DslistsinglyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_buffer_add(a : DslistsinglyBuffer, b : DslistsinglyBuffer) -> DslistsinglyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_buffer_copy(s : DslistsinglyBuffer) -> DslistsinglyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_buffer_fill(s : DslistsinglyBuffer, v : Double) -> DslistsinglyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_buffer_min(s : DslistsinglyBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_buffer_max(s : DslistsinglyBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_buffer_to_string(s : DslistsinglyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_cursor_make(size : Int) -> DslistsinglyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_cursor_len(s : DslistsinglyCursor) -> Int { s.size }

pub fn ds_list_singly_cursor_get(s : DslistsinglyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_cursor_set(s : DslistsinglyCursor, i : Int, v : Double) -> DslistsinglyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cursor_sum(s : DslistsinglyCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_cursor_mean(s : DslistsinglyCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_cursor_scale(s : DslistsinglyCursor, f : Double) -> DslistsinglyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cursor_add(a : DslistsinglyCursor, b : DslistsinglyCursor) -> DslistsinglyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_cursor_copy(s : DslistsinglyCursor) -> DslistsinglyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cursor_fill(s : DslistsinglyCursor, v : Double) -> DslistsinglyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_cursor_min(s : DslistsinglyCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_cursor_max(s : DslistsinglyCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_cursor_to_string(s : DslistsinglyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_view_make(size : Int) -> DslistsinglyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_view_len(s : DslistsinglyView) -> Int { s.size }

pub fn ds_list_singly_view_get(s : DslistsinglyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_view_set(s : DslistsinglyView, i : Int, v : Double) -> DslistsinglyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_view_sum(s : DslistsinglyView) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_view_mean(s : DslistsinglyView) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_view_scale(s : DslistsinglyView, f : Double) -> DslistsinglyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_view_add(a : DslistsinglyView, b : DslistsinglyView) -> DslistsinglyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_view_copy(s : DslistsinglyView) -> DslistsinglyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_view_fill(s : DslistsinglyView, v : Double) -> DslistsinglyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_view_min(s : DslistsinglyView) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_view_max(s : DslistsinglyView) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_view_to_string(s : DslistsinglyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_range_make(size : Int) -> DslistsinglyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_range_len(s : DslistsinglyRange) -> Int { s.size }

pub fn ds_list_singly_range_get(s : DslistsinglyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_range_set(s : DslistsinglyRange, i : Int, v : Double) -> DslistsinglyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_range_sum(s : DslistsinglyRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_range_mean(s : DslistsinglyRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_range_scale(s : DslistsinglyRange, f : Double) -> DslistsinglyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_range_add(a : DslistsinglyRange, b : DslistsinglyRange) -> DslistsinglyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_range_copy(s : DslistsinglyRange) -> DslistsinglyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_range_fill(s : DslistsinglyRange, v : Double) -> DslistsinglyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_range_min(s : DslistsinglyRange) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_range_max(s : DslistsinglyRange) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_range_to_string(s : DslistsinglyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_slice_make(size : Int) -> DslistsinglySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_slice_len(s : DslistsinglySlice) -> Int { s.size }

pub fn ds_list_singly_slice_get(s : DslistsinglySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_slice_set(s : DslistsinglySlice, i : Int, v : Double) -> DslistsinglySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_singly_slice_sum(s : DslistsinglySlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_singly_slice_mean(s : DslistsinglySlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_singly_slice_scale(s : DslistsinglySlice, f : Double) -> DslistsinglySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_slice_add(a : DslistsinglySlice, b : DslistsinglySlice) -> DslistsinglySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_singly_slice_copy(s : DslistsinglySlice) -> DslistsinglySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_slice_fill(s : DslistsinglySlice, v : Double) -> DslistsinglySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_singly_slice_min(s : DslistsinglySlice) -> Double { @_common.min(s.data) }

pub fn ds_list_singly_slice_max(s : DslistsinglySlice) -> Double { @_common.max(s.data) }

pub fn ds_list_singly_slice_to_string(s : DslistsinglySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

