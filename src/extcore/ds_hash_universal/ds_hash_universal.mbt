///===
/// extcore/ds_hash_universal

pub(all) struct DshashuniversalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_universal_make_point(x : Double, y : Double) -> DshashuniversalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_universal_make_point3(x : Double, y : Double, z : Double) -> DshashuniversalPoint {
  { x, y, z, label: 0 }
}

pub fn DshashuniversalPoint::x(self : DshashuniversalPoint) -> Double { self.x }

pub fn DshashuniversalPoint::y(self : DshashuniversalPoint) -> Double { self.y }

pub fn DshashuniversalPoint::z(self : DshashuniversalPoint) -> Double { self.z }

pub fn DshashuniversalPoint::label(self : DshashuniversalPoint) -> Int { self.label }

pub fn DshashuniversalPoint::dist(self : DshashuniversalPoint, other : DshashuniversalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashuniversalPoint::add(self : DshashuniversalPoint, other : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashuniversalPoint::sub(self : DshashuniversalPoint, other : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashuniversalPoint::scale(self : DshashuniversalPoint, s : Double) -> DshashuniversalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashuniversalPoint::dot(self : DshashuniversalPoint, other : DshashuniversalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashuniversalPoint::cross(self : DshashuniversalPoint, other : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashuniversalPoint::norm(self : DshashuniversalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashuniversalPoint::normalize(self : DshashuniversalPoint) -> DshashuniversalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashuniversalPoint::negate(self : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashuniversalPoint::mid(self : DshashuniversalPoint, other : DshashuniversalPoint) -> DshashuniversalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashuniversalPoint::lerp(self : DshashuniversalPoint, other : DshashuniversalPoint, t : Double) -> DshashuniversalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashuniversalPoint::to_string(self : DshashuniversalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashuniversalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_universal_make_series(vals : Array[Double], name : String) -> DshashuniversalSeries {
  { vals, name, meta: 0 }
}

pub fn DshashuniversalSeries::len(self : DshashuniversalSeries) -> Int { self.vals.length() }

pub fn DshashuniversalSeries::sum(self : DshashuniversalSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashuniversalSeries::mean(self : DshashuniversalSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashuniversalSeries::min(self : DshashuniversalSeries) -> Double { @_common.min(self.vals) }

pub fn DshashuniversalSeries::max(self : DshashuniversalSeries) -> Double { @_common.max(self.vals) }

pub fn DshashuniversalSeries::range(self : DshashuniversalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashuniversalSeries::variance(self : DshashuniversalSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashuniversalSeries::std(self : DshashuniversalSeries) -> Double { @_common.std(self.vals) }

pub fn DshashuniversalSeries::median(self : DshashuniversalSeries) -> Double { @_common.median(self.vals) }

pub fn DshashuniversalSeries::scale(self : DshashuniversalSeries, f : Double) -> DshashuniversalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashuniversalSeries::add(self : DshashuniversalSeries, other : DshashuniversalSeries) -> DshashuniversalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashuniversalSeries::sub(self : DshashuniversalSeries, other : DshashuniversalSeries) -> DshashuniversalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashuniversalSeries::normalize(self : DshashuniversalSeries) -> DshashuniversalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashuniversalSeries::cumsum(self : DshashuniversalSeries) -> DshashuniversalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashuniversalSeries::to_string(self : DshashuniversalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashuniversalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_universal_make_matrix(rows : Int, cols : Int, val : Double) -> DshashuniversalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_universal_matrix_identity(n : Int) -> DshashuniversalMatrix {
  let m = ds_hash_universal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashuniversalMatrix::get(self : DshashuniversalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashuniversalMatrix::transpose(self : DshashuniversalMatrix) -> DshashuniversalMatrix {
  let result = ds_hash_universal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashuniversalMatrix::add(self : DshashuniversalMatrix, other : DshashuniversalMatrix) -> DshashuniversalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashuniversalMatrix::scale(self : DshashuniversalMatrix, s : Double) -> DshashuniversalMatrix {
  let result = ds_hash_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashuniversalMatrix::multiply(self : DshashuniversalMatrix, other : DshashuniversalMatrix) -> DshashuniversalMatrix {
  if self.cols != other.rows { return ds_hash_universal_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_universal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashuniversalMatrix::trace(self : DshashuniversalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashuniversalMatrix::det(self : DshashuniversalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashuniversalMatrix::norm(self : DshashuniversalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashuniversalMatrix::to_string(self : DshashuniversalMatrix) -> String {
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

pub(all) struct DshashuniversalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_universal_make_vector(comps : Array[Double]) -> DshashuniversalVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_universal_vector_zero(dim : Int) -> DshashuniversalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashuniversalVector::add(self : DshashuniversalVector, other : DshashuniversalVector) -> DshashuniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashuniversalVector::sub(self : DshashuniversalVector, other : DshashuniversalVector) -> DshashuniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashuniversalVector::scale(self : DshashuniversalVector, s : Double) -> DshashuniversalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashuniversalVector::dot(self : DshashuniversalVector, other : DshashuniversalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashuniversalVector::norm(self : DshashuniversalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashuniversalVector::normalize(self : DshashuniversalVector) -> DshashuniversalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashuniversalVector::dist(self : DshashuniversalVector, other : DshashuniversalVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashuniversalVector::to_string(self : DshashuniversalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_universal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_universal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_universal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_universal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_universal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_universal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_universal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_universal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_universal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_universal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_universal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_universal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_universal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_universal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_universal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_universal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_universal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_universal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_universal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_universal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_universal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_universal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_universal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_universal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_universal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_universal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_universal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_universal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_universal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashuniversalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_frame_make(size : Int) -> DshashuniversalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_frame_len(s : DshashuniversalFrame) -> Int { s.size }

pub fn ds_hash_universal_frame_get(s : DshashuniversalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_frame_set(s : DshashuniversalFrame, i : Int, v : Double) -> DshashuniversalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_frame_sum(s : DshashuniversalFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_frame_mean(s : DshashuniversalFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_frame_scale(s : DshashuniversalFrame, f : Double) -> DshashuniversalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_frame_add(a : DshashuniversalFrame, b : DshashuniversalFrame) -> DshashuniversalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_frame_copy(s : DshashuniversalFrame) -> DshashuniversalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_frame_fill(s : DshashuniversalFrame, v : Double) -> DshashuniversalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_frame_min(s : DshashuniversalFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_frame_max(s : DshashuniversalFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_frame_to_string(s : DshashuniversalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_table_make(size : Int) -> DshashuniversalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_table_len(s : DshashuniversalTable) -> Int { s.size }

pub fn ds_hash_universal_table_get(s : DshashuniversalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_table_set(s : DshashuniversalTable, i : Int, v : Double) -> DshashuniversalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_table_sum(s : DshashuniversalTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_table_mean(s : DshashuniversalTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_table_scale(s : DshashuniversalTable, f : Double) -> DshashuniversalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_table_add(a : DshashuniversalTable, b : DshashuniversalTable) -> DshashuniversalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_table_copy(s : DshashuniversalTable) -> DshashuniversalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_table_fill(s : DshashuniversalTable, v : Double) -> DshashuniversalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_table_min(s : DshashuniversalTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_table_max(s : DshashuniversalTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_table_to_string(s : DshashuniversalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_graphn_make(size : Int) -> DshashuniversalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_graphn_len(s : DshashuniversalGraphN) -> Int { s.size }

pub fn ds_hash_universal_graphn_get(s : DshashuniversalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_graphn_set(s : DshashuniversalGraphN, i : Int, v : Double) -> DshashuniversalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_graphn_sum(s : DshashuniversalGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_graphn_mean(s : DshashuniversalGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_graphn_scale(s : DshashuniversalGraphN, f : Double) -> DshashuniversalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_graphn_add(a : DshashuniversalGraphN, b : DshashuniversalGraphN) -> DshashuniversalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_graphn_copy(s : DshashuniversalGraphN) -> DshashuniversalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_graphn_fill(s : DshashuniversalGraphN, v : Double) -> DshashuniversalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_graphn_min(s : DshashuniversalGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_graphn_max(s : DshashuniversalGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_graphn_to_string(s : DshashuniversalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_node_make(size : Int) -> DshashuniversalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_node_len(s : DshashuniversalNode) -> Int { s.size }

pub fn ds_hash_universal_node_get(s : DshashuniversalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_node_set(s : DshashuniversalNode, i : Int, v : Double) -> DshashuniversalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_node_sum(s : DshashuniversalNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_node_mean(s : DshashuniversalNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_node_scale(s : DshashuniversalNode, f : Double) -> DshashuniversalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_node_add(a : DshashuniversalNode, b : DshashuniversalNode) -> DshashuniversalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_node_copy(s : DshashuniversalNode) -> DshashuniversalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_node_fill(s : DshashuniversalNode, v : Double) -> DshashuniversalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_node_min(s : DshashuniversalNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_node_max(s : DshashuniversalNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_node_to_string(s : DshashuniversalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_edge_make(size : Int) -> DshashuniversalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_edge_len(s : DshashuniversalEdge) -> Int { s.size }

pub fn ds_hash_universal_edge_get(s : DshashuniversalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_edge_set(s : DshashuniversalEdge, i : Int, v : Double) -> DshashuniversalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_edge_sum(s : DshashuniversalEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_edge_mean(s : DshashuniversalEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_edge_scale(s : DshashuniversalEdge, f : Double) -> DshashuniversalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_edge_add(a : DshashuniversalEdge, b : DshashuniversalEdge) -> DshashuniversalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_edge_copy(s : DshashuniversalEdge) -> DshashuniversalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_edge_fill(s : DshashuniversalEdge, v : Double) -> DshashuniversalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_edge_min(s : DshashuniversalEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_edge_max(s : DshashuniversalEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_edge_to_string(s : DshashuniversalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_path_make(size : Int) -> DshashuniversalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_path_len(s : DshashuniversalPath) -> Int { s.size }

pub fn ds_hash_universal_path_get(s : DshashuniversalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_path_set(s : DshashuniversalPath, i : Int, v : Double) -> DshashuniversalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_path_sum(s : DshashuniversalPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_path_mean(s : DshashuniversalPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_path_scale(s : DshashuniversalPath, f : Double) -> DshashuniversalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_path_add(a : DshashuniversalPath, b : DshashuniversalPath) -> DshashuniversalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_path_copy(s : DshashuniversalPath) -> DshashuniversalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_path_fill(s : DshashuniversalPath, v : Double) -> DshashuniversalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_path_min(s : DshashuniversalPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_path_max(s : DshashuniversalPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_path_to_string(s : DshashuniversalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_cluster_make(size : Int) -> DshashuniversalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_cluster_len(s : DshashuniversalCluster) -> Int { s.size }

pub fn ds_hash_universal_cluster_get(s : DshashuniversalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_cluster_set(s : DshashuniversalCluster, i : Int, v : Double) -> DshashuniversalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cluster_sum(s : DshashuniversalCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_cluster_mean(s : DshashuniversalCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_cluster_scale(s : DshashuniversalCluster, f : Double) -> DshashuniversalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cluster_add(a : DshashuniversalCluster, b : DshashuniversalCluster) -> DshashuniversalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_cluster_copy(s : DshashuniversalCluster) -> DshashuniversalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cluster_fill(s : DshashuniversalCluster, v : Double) -> DshashuniversalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cluster_min(s : DshashuniversalCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_cluster_max(s : DshashuniversalCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_cluster_to_string(s : DshashuniversalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_model_make(size : Int) -> DshashuniversalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_model_len(s : DshashuniversalModel) -> Int { s.size }

pub fn ds_hash_universal_model_get(s : DshashuniversalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_model_set(s : DshashuniversalModel, i : Int, v : Double) -> DshashuniversalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_model_sum(s : DshashuniversalModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_model_mean(s : DshashuniversalModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_model_scale(s : DshashuniversalModel, f : Double) -> DshashuniversalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_model_add(a : DshashuniversalModel, b : DshashuniversalModel) -> DshashuniversalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_model_copy(s : DshashuniversalModel) -> DshashuniversalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_model_fill(s : DshashuniversalModel, v : Double) -> DshashuniversalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_model_min(s : DshashuniversalModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_model_max(s : DshashuniversalModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_model_to_string(s : DshashuniversalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_layer_make(size : Int) -> DshashuniversalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_layer_len(s : DshashuniversalLayer) -> Int { s.size }

pub fn ds_hash_universal_layer_get(s : DshashuniversalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_layer_set(s : DshashuniversalLayer, i : Int, v : Double) -> DshashuniversalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_layer_sum(s : DshashuniversalLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_layer_mean(s : DshashuniversalLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_layer_scale(s : DshashuniversalLayer, f : Double) -> DshashuniversalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_layer_add(a : DshashuniversalLayer, b : DshashuniversalLayer) -> DshashuniversalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_layer_copy(s : DshashuniversalLayer) -> DshashuniversalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_layer_fill(s : DshashuniversalLayer, v : Double) -> DshashuniversalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_layer_min(s : DshashuniversalLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_layer_max(s : DshashuniversalLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_layer_to_string(s : DshashuniversalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_buffer_make(size : Int) -> DshashuniversalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_buffer_len(s : DshashuniversalBuffer) -> Int { s.size }

pub fn ds_hash_universal_buffer_get(s : DshashuniversalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_buffer_set(s : DshashuniversalBuffer, i : Int, v : Double) -> DshashuniversalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_buffer_sum(s : DshashuniversalBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_buffer_mean(s : DshashuniversalBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_buffer_scale(s : DshashuniversalBuffer, f : Double) -> DshashuniversalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_buffer_add(a : DshashuniversalBuffer, b : DshashuniversalBuffer) -> DshashuniversalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_buffer_copy(s : DshashuniversalBuffer) -> DshashuniversalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_buffer_fill(s : DshashuniversalBuffer, v : Double) -> DshashuniversalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_buffer_min(s : DshashuniversalBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_buffer_max(s : DshashuniversalBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_buffer_to_string(s : DshashuniversalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_cursor_make(size : Int) -> DshashuniversalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_cursor_len(s : DshashuniversalCursor) -> Int { s.size }

pub fn ds_hash_universal_cursor_get(s : DshashuniversalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_cursor_set(s : DshashuniversalCursor, i : Int, v : Double) -> DshashuniversalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cursor_sum(s : DshashuniversalCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_cursor_mean(s : DshashuniversalCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_cursor_scale(s : DshashuniversalCursor, f : Double) -> DshashuniversalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cursor_add(a : DshashuniversalCursor, b : DshashuniversalCursor) -> DshashuniversalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_cursor_copy(s : DshashuniversalCursor) -> DshashuniversalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cursor_fill(s : DshashuniversalCursor, v : Double) -> DshashuniversalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_cursor_min(s : DshashuniversalCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_cursor_max(s : DshashuniversalCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_cursor_to_string(s : DshashuniversalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_view_make(size : Int) -> DshashuniversalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_view_len(s : DshashuniversalView) -> Int { s.size }

pub fn ds_hash_universal_view_get(s : DshashuniversalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_view_set(s : DshashuniversalView, i : Int, v : Double) -> DshashuniversalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_view_sum(s : DshashuniversalView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_view_mean(s : DshashuniversalView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_view_scale(s : DshashuniversalView, f : Double) -> DshashuniversalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_view_add(a : DshashuniversalView, b : DshashuniversalView) -> DshashuniversalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_view_copy(s : DshashuniversalView) -> DshashuniversalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_view_fill(s : DshashuniversalView, v : Double) -> DshashuniversalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_view_min(s : DshashuniversalView) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_view_max(s : DshashuniversalView) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_view_to_string(s : DshashuniversalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_range_make(size : Int) -> DshashuniversalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_range_len(s : DshashuniversalRange) -> Int { s.size }

pub fn ds_hash_universal_range_get(s : DshashuniversalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_range_set(s : DshashuniversalRange, i : Int, v : Double) -> DshashuniversalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_range_sum(s : DshashuniversalRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_range_mean(s : DshashuniversalRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_range_scale(s : DshashuniversalRange, f : Double) -> DshashuniversalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_range_add(a : DshashuniversalRange, b : DshashuniversalRange) -> DshashuniversalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_range_copy(s : DshashuniversalRange) -> DshashuniversalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_range_fill(s : DshashuniversalRange, v : Double) -> DshashuniversalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_range_min(s : DshashuniversalRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_range_max(s : DshashuniversalRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_range_to_string(s : DshashuniversalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashuniversalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_universal_slice_make(size : Int) -> DshashuniversalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_universal_slice_len(s : DshashuniversalSlice) -> Int { s.size }

pub fn ds_hash_universal_slice_get(s : DshashuniversalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_universal_slice_set(s : DshashuniversalSlice, i : Int, v : Double) -> DshashuniversalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_slice_sum(s : DshashuniversalSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_universal_slice_mean(s : DshashuniversalSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_universal_slice_scale(s : DshashuniversalSlice, f : Double) -> DshashuniversalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_slice_add(a : DshashuniversalSlice, b : DshashuniversalSlice) -> DshashuniversalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_universal_slice_copy(s : DshashuniversalSlice) -> DshashuniversalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_slice_fill(s : DshashuniversalSlice, v : Double) -> DshashuniversalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_universal_slice_min(s : DshashuniversalSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_universal_slice_max(s : DshashuniversalSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_universal_slice_to_string(s : DshashuniversalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

