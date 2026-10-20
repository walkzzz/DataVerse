///===
/// extcore/ds_list_xor

pub(all) struct DslistxorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_xor_make_point(x : Double, y : Double) -> DslistxorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_xor_make_point3(x : Double, y : Double, z : Double) -> DslistxorPoint {
  { x, y, z, label: 0 }
}

pub fn DslistxorPoint::x(self : DslistxorPoint) -> Double { self.x }

pub fn DslistxorPoint::y(self : DslistxorPoint) -> Double { self.y }

pub fn DslistxorPoint::z(self : DslistxorPoint) -> Double { self.z }

pub fn DslistxorPoint::label(self : DslistxorPoint) -> Int { self.label }

pub fn DslistxorPoint::dist(self : DslistxorPoint, other : DslistxorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistxorPoint::add(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistxorPoint::sub(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistxorPoint::scale(self : DslistxorPoint, s : Double) -> DslistxorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistxorPoint::dot(self : DslistxorPoint, other : DslistxorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistxorPoint::cross(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistxorPoint::norm(self : DslistxorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistxorPoint::normalize(self : DslistxorPoint) -> DslistxorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistxorPoint::negate(self : DslistxorPoint) -> DslistxorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistxorPoint::mid(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistxorPoint::lerp(self : DslistxorPoint, other : DslistxorPoint, t : Double) -> DslistxorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistxorPoint::to_string(self : DslistxorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistxorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_xor_make_series(vals : Array[Double], name : String) -> DslistxorSeries {
  { vals, name, meta: 0 }
}

pub fn DslistxorSeries::len(self : DslistxorSeries) -> Int { self.vals.length() }

pub fn DslistxorSeries::sum(self : DslistxorSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistxorSeries::mean(self : DslistxorSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistxorSeries::min(self : DslistxorSeries) -> Double { @_common.min(self.vals) }

pub fn DslistxorSeries::max(self : DslistxorSeries) -> Double { @_common.max(self.vals) }

pub fn DslistxorSeries::range(self : DslistxorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistxorSeries::variance(self : DslistxorSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistxorSeries::std(self : DslistxorSeries) -> Double { @_common.std(self.vals) }

pub fn DslistxorSeries::median(self : DslistxorSeries) -> Double { @_common.median(self.vals) }

pub fn DslistxorSeries::scale(self : DslistxorSeries, f : Double) -> DslistxorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistxorSeries::add(self : DslistxorSeries, other : DslistxorSeries) -> DslistxorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistxorSeries::sub(self : DslistxorSeries, other : DslistxorSeries) -> DslistxorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistxorSeries::normalize(self : DslistxorSeries) -> DslistxorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistxorSeries::cumsum(self : DslistxorSeries) -> DslistxorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistxorSeries::to_string(self : DslistxorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistxorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_xor_make_matrix(rows : Int, cols : Int, val : Double) -> DslistxorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_xor_matrix_identity(n : Int) -> DslistxorMatrix {
  let m = ds_list_xor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistxorMatrix::get(self : DslistxorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistxorMatrix::transpose(self : DslistxorMatrix) -> DslistxorMatrix {
  let result = ds_list_xor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistxorMatrix::add(self : DslistxorMatrix, other : DslistxorMatrix) -> DslistxorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_xor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistxorMatrix::scale(self : DslistxorMatrix, s : Double) -> DslistxorMatrix {
  let result = ds_list_xor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistxorMatrix::multiply(self : DslistxorMatrix, other : DslistxorMatrix) -> DslistxorMatrix {
  if self.cols != other.rows { return ds_list_xor_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_xor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistxorMatrix::trace(self : DslistxorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistxorMatrix::det(self : DslistxorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistxorMatrix::norm(self : DslistxorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistxorMatrix::to_string(self : DslistxorMatrix) -> String {
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

pub(all) struct DslistxorVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_xor_make_vector(comps : Array[Double]) -> DslistxorVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_xor_vector_zero(dim : Int) -> DslistxorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistxorVector::add(self : DslistxorVector, other : DslistxorVector) -> DslistxorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistxorVector::sub(self : DslistxorVector, other : DslistxorVector) -> DslistxorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistxorVector::scale(self : DslistxorVector, s : Double) -> DslistxorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistxorVector::dot(self : DslistxorVector, other : DslistxorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistxorVector::norm(self : DslistxorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistxorVector::normalize(self : DslistxorVector) -> DslistxorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistxorVector::dist(self : DslistxorVector, other : DslistxorVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistxorVector::to_string(self : DslistxorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_xor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_xor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_xor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_xor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_xor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_xor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_xor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_xor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_xor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_xor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_xor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_xor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_xor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_xor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_xor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_xor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_xor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_xor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_xor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_xor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_xor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_xor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_xor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_xor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_xor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_xor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_xor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_xor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_xor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistxorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_frame_make(size : Int) -> DslistxorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_frame_len(s : DslistxorFrame) -> Int { s.size }

pub fn ds_list_xor_frame_get(s : DslistxorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_frame_set(s : DslistxorFrame, i : Int, v : Double) -> DslistxorFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_frame_sum(s : DslistxorFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_frame_mean(s : DslistxorFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_frame_scale(s : DslistxorFrame, f : Double) -> DslistxorFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_frame_add(a : DslistxorFrame, b : DslistxorFrame) -> DslistxorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_frame_copy(s : DslistxorFrame) -> DslistxorFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_frame_fill(s : DslistxorFrame, v : Double) -> DslistxorFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_frame_min(s : DslistxorFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_frame_max(s : DslistxorFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_frame_to_string(s : DslistxorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_table_make(size : Int) -> DslistxorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_table_len(s : DslistxorTable) -> Int { s.size }

pub fn ds_list_xor_table_get(s : DslistxorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_table_set(s : DslistxorTable, i : Int, v : Double) -> DslistxorTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_table_sum(s : DslistxorTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_table_mean(s : DslistxorTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_table_scale(s : DslistxorTable, f : Double) -> DslistxorTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_table_add(a : DslistxorTable, b : DslistxorTable) -> DslistxorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_table_copy(s : DslistxorTable) -> DslistxorTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_table_fill(s : DslistxorTable, v : Double) -> DslistxorTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_table_min(s : DslistxorTable) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_table_max(s : DslistxorTable) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_table_to_string(s : DslistxorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_graphn_make(size : Int) -> DslistxorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_graphn_len(s : DslistxorGraphN) -> Int { s.size }

pub fn ds_list_xor_graphn_get(s : DslistxorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_graphn_set(s : DslistxorGraphN, i : Int, v : Double) -> DslistxorGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_graphn_sum(s : DslistxorGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_graphn_mean(s : DslistxorGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_graphn_scale(s : DslistxorGraphN, f : Double) -> DslistxorGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_graphn_add(a : DslistxorGraphN, b : DslistxorGraphN) -> DslistxorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_graphn_copy(s : DslistxorGraphN) -> DslistxorGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_graphn_fill(s : DslistxorGraphN, v : Double) -> DslistxorGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_graphn_min(s : DslistxorGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_graphn_max(s : DslistxorGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_graphn_to_string(s : DslistxorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_node_make(size : Int) -> DslistxorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_node_len(s : DslistxorNode) -> Int { s.size }

pub fn ds_list_xor_node_get(s : DslistxorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_node_set(s : DslistxorNode, i : Int, v : Double) -> DslistxorNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_node_sum(s : DslistxorNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_node_mean(s : DslistxorNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_node_scale(s : DslistxorNode, f : Double) -> DslistxorNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_node_add(a : DslistxorNode, b : DslistxorNode) -> DslistxorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_node_copy(s : DslistxorNode) -> DslistxorNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_node_fill(s : DslistxorNode, v : Double) -> DslistxorNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_node_min(s : DslistxorNode) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_node_max(s : DslistxorNode) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_node_to_string(s : DslistxorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_edge_make(size : Int) -> DslistxorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_edge_len(s : DslistxorEdge) -> Int { s.size }

pub fn ds_list_xor_edge_get(s : DslistxorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_edge_set(s : DslistxorEdge, i : Int, v : Double) -> DslistxorEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_edge_sum(s : DslistxorEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_edge_mean(s : DslistxorEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_edge_scale(s : DslistxorEdge, f : Double) -> DslistxorEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_edge_add(a : DslistxorEdge, b : DslistxorEdge) -> DslistxorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_edge_copy(s : DslistxorEdge) -> DslistxorEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_edge_fill(s : DslistxorEdge, v : Double) -> DslistxorEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_edge_min(s : DslistxorEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_edge_max(s : DslistxorEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_edge_to_string(s : DslistxorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_path_make(size : Int) -> DslistxorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_path_len(s : DslistxorPath) -> Int { s.size }

pub fn ds_list_xor_path_get(s : DslistxorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_path_set(s : DslistxorPath, i : Int, v : Double) -> DslistxorPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_path_sum(s : DslistxorPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_path_mean(s : DslistxorPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_path_scale(s : DslistxorPath, f : Double) -> DslistxorPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_path_add(a : DslistxorPath, b : DslistxorPath) -> DslistxorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_path_copy(s : DslistxorPath) -> DslistxorPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_path_fill(s : DslistxorPath, v : Double) -> DslistxorPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_path_min(s : DslistxorPath) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_path_max(s : DslistxorPath) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_path_to_string(s : DslistxorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_cluster_make(size : Int) -> DslistxorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_cluster_len(s : DslistxorCluster) -> Int { s.size }

pub fn ds_list_xor_cluster_get(s : DslistxorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_cluster_set(s : DslistxorCluster, i : Int, v : Double) -> DslistxorCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cluster_sum(s : DslistxorCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_cluster_mean(s : DslistxorCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_cluster_scale(s : DslistxorCluster, f : Double) -> DslistxorCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cluster_add(a : DslistxorCluster, b : DslistxorCluster) -> DslistxorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_cluster_copy(s : DslistxorCluster) -> DslistxorCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cluster_fill(s : DslistxorCluster, v : Double) -> DslistxorCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cluster_min(s : DslistxorCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_cluster_max(s : DslistxorCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_cluster_to_string(s : DslistxorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_model_make(size : Int) -> DslistxorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_model_len(s : DslistxorModel) -> Int { s.size }

pub fn ds_list_xor_model_get(s : DslistxorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_model_set(s : DslistxorModel, i : Int, v : Double) -> DslistxorModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_model_sum(s : DslistxorModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_model_mean(s : DslistxorModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_model_scale(s : DslistxorModel, f : Double) -> DslistxorModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_model_add(a : DslistxorModel, b : DslistxorModel) -> DslistxorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_model_copy(s : DslistxorModel) -> DslistxorModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_model_fill(s : DslistxorModel, v : Double) -> DslistxorModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_model_min(s : DslistxorModel) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_model_max(s : DslistxorModel) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_model_to_string(s : DslistxorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_layer_make(size : Int) -> DslistxorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_layer_len(s : DslistxorLayer) -> Int { s.size }

pub fn ds_list_xor_layer_get(s : DslistxorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_layer_set(s : DslistxorLayer, i : Int, v : Double) -> DslistxorLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_layer_sum(s : DslistxorLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_layer_mean(s : DslistxorLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_layer_scale(s : DslistxorLayer, f : Double) -> DslistxorLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_layer_add(a : DslistxorLayer, b : DslistxorLayer) -> DslistxorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_layer_copy(s : DslistxorLayer) -> DslistxorLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_layer_fill(s : DslistxorLayer, v : Double) -> DslistxorLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_layer_min(s : DslistxorLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_layer_max(s : DslistxorLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_layer_to_string(s : DslistxorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_buffer_make(size : Int) -> DslistxorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_buffer_len(s : DslistxorBuffer) -> Int { s.size }

pub fn ds_list_xor_buffer_get(s : DslistxorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_buffer_set(s : DslistxorBuffer, i : Int, v : Double) -> DslistxorBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_buffer_sum(s : DslistxorBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_buffer_mean(s : DslistxorBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_buffer_scale(s : DslistxorBuffer, f : Double) -> DslistxorBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_buffer_add(a : DslistxorBuffer, b : DslistxorBuffer) -> DslistxorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_buffer_copy(s : DslistxorBuffer) -> DslistxorBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_buffer_fill(s : DslistxorBuffer, v : Double) -> DslistxorBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_buffer_min(s : DslistxorBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_buffer_max(s : DslistxorBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_buffer_to_string(s : DslistxorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_cursor_make(size : Int) -> DslistxorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_cursor_len(s : DslistxorCursor) -> Int { s.size }

pub fn ds_list_xor_cursor_get(s : DslistxorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_cursor_set(s : DslistxorCursor, i : Int, v : Double) -> DslistxorCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cursor_sum(s : DslistxorCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_cursor_mean(s : DslistxorCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_cursor_scale(s : DslistxorCursor, f : Double) -> DslistxorCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cursor_add(a : DslistxorCursor, b : DslistxorCursor) -> DslistxorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_cursor_copy(s : DslistxorCursor) -> DslistxorCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cursor_fill(s : DslistxorCursor, v : Double) -> DslistxorCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_cursor_min(s : DslistxorCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_cursor_max(s : DslistxorCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_cursor_to_string(s : DslistxorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_view_make(size : Int) -> DslistxorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_view_len(s : DslistxorView) -> Int { s.size }

pub fn ds_list_xor_view_get(s : DslistxorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_view_set(s : DslistxorView, i : Int, v : Double) -> DslistxorView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_view_sum(s : DslistxorView) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_view_mean(s : DslistxorView) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_view_scale(s : DslistxorView, f : Double) -> DslistxorView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_view_add(a : DslistxorView, b : DslistxorView) -> DslistxorView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_view_copy(s : DslistxorView) -> DslistxorView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_view_fill(s : DslistxorView, v : Double) -> DslistxorView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_view_min(s : DslistxorView) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_view_max(s : DslistxorView) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_view_to_string(s : DslistxorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_range_make(size : Int) -> DslistxorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_range_len(s : DslistxorRange) -> Int { s.size }

pub fn ds_list_xor_range_get(s : DslistxorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_range_set(s : DslistxorRange, i : Int, v : Double) -> DslistxorRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_range_sum(s : DslistxorRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_range_mean(s : DslistxorRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_range_scale(s : DslistxorRange, f : Double) -> DslistxorRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_range_add(a : DslistxorRange, b : DslistxorRange) -> DslistxorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_range_copy(s : DslistxorRange) -> DslistxorRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_range_fill(s : DslistxorRange, v : Double) -> DslistxorRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_range_min(s : DslistxorRange) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_range_max(s : DslistxorRange) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_range_to_string(s : DslistxorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_slice_make(size : Int) -> DslistxorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_slice_len(s : DslistxorSlice) -> Int { s.size }

pub fn ds_list_xor_slice_get(s : DslistxorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_slice_set(s : DslistxorSlice, i : Int, v : Double) -> DslistxorSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_xor_slice_sum(s : DslistxorSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_xor_slice_mean(s : DslistxorSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_xor_slice_scale(s : DslistxorSlice, f : Double) -> DslistxorSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_slice_add(a : DslistxorSlice, b : DslistxorSlice) -> DslistxorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_xor_slice_copy(s : DslistxorSlice) -> DslistxorSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_slice_fill(s : DslistxorSlice, v : Double) -> DslistxorSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_xor_slice_min(s : DslistxorSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_xor_slice_max(s : DslistxorSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_xor_slice_to_string(s : DslistxorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

