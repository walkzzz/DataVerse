///===
/// extcore/ds_list_doubly

pub(all) struct DslistdoublyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_doubly_make_point(x : Double, y : Double) -> DslistdoublyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_doubly_make_point3(x : Double, y : Double, z : Double) -> DslistdoublyPoint {
  { x, y, z, label: 0 }
}

pub fn DslistdoublyPoint::x(self : DslistdoublyPoint) -> Double { self.x }

pub fn DslistdoublyPoint::y(self : DslistdoublyPoint) -> Double { self.y }

pub fn DslistdoublyPoint::z(self : DslistdoublyPoint) -> Double { self.z }

pub fn DslistdoublyPoint::label(self : DslistdoublyPoint) -> Int { self.label }

pub fn DslistdoublyPoint::dist(self : DslistdoublyPoint, other : DslistdoublyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistdoublyPoint::add(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistdoublyPoint::sub(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistdoublyPoint::scale(self : DslistdoublyPoint, s : Double) -> DslistdoublyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistdoublyPoint::dot(self : DslistdoublyPoint, other : DslistdoublyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistdoublyPoint::cross(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistdoublyPoint::norm(self : DslistdoublyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistdoublyPoint::normalize(self : DslistdoublyPoint) -> DslistdoublyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistdoublyPoint::negate(self : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistdoublyPoint::mid(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistdoublyPoint::lerp(self : DslistdoublyPoint, other : DslistdoublyPoint, t : Double) -> DslistdoublyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistdoublyPoint::to_string(self : DslistdoublyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistdoublySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_doubly_make_series(vals : Array[Double], name : String) -> DslistdoublySeries {
  { vals, name, meta: 0 }
}

pub fn DslistdoublySeries::len(self : DslistdoublySeries) -> Int { self.vals.length() }

pub fn DslistdoublySeries::sum(self : DslistdoublySeries) -> Double { @_common.sum(self.vals) }

pub fn DslistdoublySeries::mean(self : DslistdoublySeries) -> Double { @_common.mean(self.vals) }

pub fn DslistdoublySeries::min(self : DslistdoublySeries) -> Double { @_common.min(self.vals) }

pub fn DslistdoublySeries::max(self : DslistdoublySeries) -> Double { @_common.max(self.vals) }

pub fn DslistdoublySeries::range(self : DslistdoublySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistdoublySeries::variance(self : DslistdoublySeries) -> Double { @_common.variance(self.vals) }

pub fn DslistdoublySeries::std(self : DslistdoublySeries) -> Double { @_common.std(self.vals) }

pub fn DslistdoublySeries::median(self : DslistdoublySeries) -> Double { @_common.median(self.vals) }

pub fn DslistdoublySeries::scale(self : DslistdoublySeries, f : Double) -> DslistdoublySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistdoublySeries::add(self : DslistdoublySeries, other : DslistdoublySeries) -> DslistdoublySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistdoublySeries::sub(self : DslistdoublySeries, other : DslistdoublySeries) -> DslistdoublySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistdoublySeries::normalize(self : DslistdoublySeries) -> DslistdoublySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistdoublySeries::cumsum(self : DslistdoublySeries) -> DslistdoublySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistdoublySeries::to_string(self : DslistdoublySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistdoublyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_doubly_make_matrix(rows : Int, cols : Int, val : Double) -> DslistdoublyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_doubly_matrix_identity(n : Int) -> DslistdoublyMatrix {
  let m = ds_list_doubly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistdoublyMatrix::get(self : DslistdoublyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistdoublyMatrix::transpose(self : DslistdoublyMatrix) -> DslistdoublyMatrix {
  let result = ds_list_doubly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistdoublyMatrix::add(self : DslistdoublyMatrix, other : DslistdoublyMatrix) -> DslistdoublyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_doubly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistdoublyMatrix::scale(self : DslistdoublyMatrix, s : Double) -> DslistdoublyMatrix {
  let result = ds_list_doubly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistdoublyMatrix::multiply(self : DslistdoublyMatrix, other : DslistdoublyMatrix) -> DslistdoublyMatrix {
  if self.cols != other.rows { return ds_list_doubly_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_doubly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistdoublyMatrix::trace(self : DslistdoublyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistdoublyMatrix::det(self : DslistdoublyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistdoublyMatrix::norm(self : DslistdoublyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistdoublyMatrix::to_string(self : DslistdoublyMatrix) -> String {
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

pub(all) struct DslistdoublyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_doubly_make_vector(comps : Array[Double]) -> DslistdoublyVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_doubly_vector_zero(dim : Int) -> DslistdoublyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistdoublyVector::add(self : DslistdoublyVector, other : DslistdoublyVector) -> DslistdoublyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistdoublyVector::sub(self : DslistdoublyVector, other : DslistdoublyVector) -> DslistdoublyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistdoublyVector::scale(self : DslistdoublyVector, s : Double) -> DslistdoublyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistdoublyVector::dot(self : DslistdoublyVector, other : DslistdoublyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistdoublyVector::norm(self : DslistdoublyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistdoublyVector::normalize(self : DslistdoublyVector) -> DslistdoublyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistdoublyVector::dist(self : DslistdoublyVector, other : DslistdoublyVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistdoublyVector::to_string(self : DslistdoublyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_doubly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_doubly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_doubly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_doubly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_doubly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_doubly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_doubly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_doubly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_doubly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_doubly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_doubly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_doubly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_doubly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_doubly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_doubly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_doubly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_doubly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_doubly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_doubly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_doubly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_doubly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_doubly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_doubly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_doubly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_doubly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_doubly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_doubly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_doubly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_doubly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistdoublyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_frame_make(size : Int) -> DslistdoublyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_frame_len(s : DslistdoublyFrame) -> Int { s.size }

pub fn ds_list_doubly_frame_get(s : DslistdoublyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_frame_set(s : DslistdoublyFrame, i : Int, v : Double) -> DslistdoublyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_frame_sum(s : DslistdoublyFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_frame_mean(s : DslistdoublyFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_frame_scale(s : DslistdoublyFrame, f : Double) -> DslistdoublyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_frame_add(a : DslistdoublyFrame, b : DslistdoublyFrame) -> DslistdoublyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_frame_copy(s : DslistdoublyFrame) -> DslistdoublyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_frame_fill(s : DslistdoublyFrame, v : Double) -> DslistdoublyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_frame_min(s : DslistdoublyFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_frame_max(s : DslistdoublyFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_frame_to_string(s : DslistdoublyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_table_make(size : Int) -> DslistdoublyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_table_len(s : DslistdoublyTable) -> Int { s.size }

pub fn ds_list_doubly_table_get(s : DslistdoublyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_table_set(s : DslistdoublyTable, i : Int, v : Double) -> DslistdoublyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_table_sum(s : DslistdoublyTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_table_mean(s : DslistdoublyTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_table_scale(s : DslistdoublyTable, f : Double) -> DslistdoublyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_table_add(a : DslistdoublyTable, b : DslistdoublyTable) -> DslistdoublyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_table_copy(s : DslistdoublyTable) -> DslistdoublyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_table_fill(s : DslistdoublyTable, v : Double) -> DslistdoublyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_table_min(s : DslistdoublyTable) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_table_max(s : DslistdoublyTable) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_table_to_string(s : DslistdoublyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_graphn_make(size : Int) -> DslistdoublyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_graphn_len(s : DslistdoublyGraphN) -> Int { s.size }

pub fn ds_list_doubly_graphn_get(s : DslistdoublyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_graphn_set(s : DslistdoublyGraphN, i : Int, v : Double) -> DslistdoublyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_graphn_sum(s : DslistdoublyGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_graphn_mean(s : DslistdoublyGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_graphn_scale(s : DslistdoublyGraphN, f : Double) -> DslistdoublyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_graphn_add(a : DslistdoublyGraphN, b : DslistdoublyGraphN) -> DslistdoublyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_graphn_copy(s : DslistdoublyGraphN) -> DslistdoublyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_graphn_fill(s : DslistdoublyGraphN, v : Double) -> DslistdoublyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_graphn_min(s : DslistdoublyGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_graphn_max(s : DslistdoublyGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_graphn_to_string(s : DslistdoublyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_node_make(size : Int) -> DslistdoublyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_node_len(s : DslistdoublyNode) -> Int { s.size }

pub fn ds_list_doubly_node_get(s : DslistdoublyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_node_set(s : DslistdoublyNode, i : Int, v : Double) -> DslistdoublyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_node_sum(s : DslistdoublyNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_node_mean(s : DslistdoublyNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_node_scale(s : DslistdoublyNode, f : Double) -> DslistdoublyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_node_add(a : DslistdoublyNode, b : DslistdoublyNode) -> DslistdoublyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_node_copy(s : DslistdoublyNode) -> DslistdoublyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_node_fill(s : DslistdoublyNode, v : Double) -> DslistdoublyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_node_min(s : DslistdoublyNode) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_node_max(s : DslistdoublyNode) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_node_to_string(s : DslistdoublyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_edge_make(size : Int) -> DslistdoublyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_edge_len(s : DslistdoublyEdge) -> Int { s.size }

pub fn ds_list_doubly_edge_get(s : DslistdoublyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_edge_set(s : DslistdoublyEdge, i : Int, v : Double) -> DslistdoublyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_edge_sum(s : DslistdoublyEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_edge_mean(s : DslistdoublyEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_edge_scale(s : DslistdoublyEdge, f : Double) -> DslistdoublyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_edge_add(a : DslistdoublyEdge, b : DslistdoublyEdge) -> DslistdoublyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_edge_copy(s : DslistdoublyEdge) -> DslistdoublyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_edge_fill(s : DslistdoublyEdge, v : Double) -> DslistdoublyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_edge_min(s : DslistdoublyEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_edge_max(s : DslistdoublyEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_edge_to_string(s : DslistdoublyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_path_make(size : Int) -> DslistdoublyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_path_len(s : DslistdoublyPath) -> Int { s.size }

pub fn ds_list_doubly_path_get(s : DslistdoublyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_path_set(s : DslistdoublyPath, i : Int, v : Double) -> DslistdoublyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_path_sum(s : DslistdoublyPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_path_mean(s : DslistdoublyPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_path_scale(s : DslistdoublyPath, f : Double) -> DslistdoublyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_path_add(a : DslistdoublyPath, b : DslistdoublyPath) -> DslistdoublyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_path_copy(s : DslistdoublyPath) -> DslistdoublyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_path_fill(s : DslistdoublyPath, v : Double) -> DslistdoublyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_path_min(s : DslistdoublyPath) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_path_max(s : DslistdoublyPath) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_path_to_string(s : DslistdoublyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_cluster_make(size : Int) -> DslistdoublyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_cluster_len(s : DslistdoublyCluster) -> Int { s.size }

pub fn ds_list_doubly_cluster_get(s : DslistdoublyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_cluster_set(s : DslistdoublyCluster, i : Int, v : Double) -> DslistdoublyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cluster_sum(s : DslistdoublyCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_cluster_mean(s : DslistdoublyCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_cluster_scale(s : DslistdoublyCluster, f : Double) -> DslistdoublyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cluster_add(a : DslistdoublyCluster, b : DslistdoublyCluster) -> DslistdoublyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_cluster_copy(s : DslistdoublyCluster) -> DslistdoublyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cluster_fill(s : DslistdoublyCluster, v : Double) -> DslistdoublyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cluster_min(s : DslistdoublyCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_cluster_max(s : DslistdoublyCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_cluster_to_string(s : DslistdoublyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_model_make(size : Int) -> DslistdoublyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_model_len(s : DslistdoublyModel) -> Int { s.size }

pub fn ds_list_doubly_model_get(s : DslistdoublyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_model_set(s : DslistdoublyModel, i : Int, v : Double) -> DslistdoublyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_model_sum(s : DslistdoublyModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_model_mean(s : DslistdoublyModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_model_scale(s : DslistdoublyModel, f : Double) -> DslistdoublyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_model_add(a : DslistdoublyModel, b : DslistdoublyModel) -> DslistdoublyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_model_copy(s : DslistdoublyModel) -> DslistdoublyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_model_fill(s : DslistdoublyModel, v : Double) -> DslistdoublyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_model_min(s : DslistdoublyModel) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_model_max(s : DslistdoublyModel) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_model_to_string(s : DslistdoublyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_layer_make(size : Int) -> DslistdoublyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_layer_len(s : DslistdoublyLayer) -> Int { s.size }

pub fn ds_list_doubly_layer_get(s : DslistdoublyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_layer_set(s : DslistdoublyLayer, i : Int, v : Double) -> DslistdoublyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_layer_sum(s : DslistdoublyLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_layer_mean(s : DslistdoublyLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_layer_scale(s : DslistdoublyLayer, f : Double) -> DslistdoublyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_layer_add(a : DslistdoublyLayer, b : DslistdoublyLayer) -> DslistdoublyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_layer_copy(s : DslistdoublyLayer) -> DslistdoublyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_layer_fill(s : DslistdoublyLayer, v : Double) -> DslistdoublyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_layer_min(s : DslistdoublyLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_layer_max(s : DslistdoublyLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_layer_to_string(s : DslistdoublyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_buffer_make(size : Int) -> DslistdoublyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_buffer_len(s : DslistdoublyBuffer) -> Int { s.size }

pub fn ds_list_doubly_buffer_get(s : DslistdoublyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_buffer_set(s : DslistdoublyBuffer, i : Int, v : Double) -> DslistdoublyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_buffer_sum(s : DslistdoublyBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_buffer_mean(s : DslistdoublyBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_buffer_scale(s : DslistdoublyBuffer, f : Double) -> DslistdoublyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_buffer_add(a : DslistdoublyBuffer, b : DslistdoublyBuffer) -> DslistdoublyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_buffer_copy(s : DslistdoublyBuffer) -> DslistdoublyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_buffer_fill(s : DslistdoublyBuffer, v : Double) -> DslistdoublyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_buffer_min(s : DslistdoublyBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_buffer_max(s : DslistdoublyBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_buffer_to_string(s : DslistdoublyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_cursor_make(size : Int) -> DslistdoublyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_cursor_len(s : DslistdoublyCursor) -> Int { s.size }

pub fn ds_list_doubly_cursor_get(s : DslistdoublyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_cursor_set(s : DslistdoublyCursor, i : Int, v : Double) -> DslistdoublyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cursor_sum(s : DslistdoublyCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_cursor_mean(s : DslistdoublyCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_cursor_scale(s : DslistdoublyCursor, f : Double) -> DslistdoublyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cursor_add(a : DslistdoublyCursor, b : DslistdoublyCursor) -> DslistdoublyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_cursor_copy(s : DslistdoublyCursor) -> DslistdoublyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cursor_fill(s : DslistdoublyCursor, v : Double) -> DslistdoublyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_cursor_min(s : DslistdoublyCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_cursor_max(s : DslistdoublyCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_cursor_to_string(s : DslistdoublyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_view_make(size : Int) -> DslistdoublyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_view_len(s : DslistdoublyView) -> Int { s.size }

pub fn ds_list_doubly_view_get(s : DslistdoublyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_view_set(s : DslistdoublyView, i : Int, v : Double) -> DslistdoublyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_view_sum(s : DslistdoublyView) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_view_mean(s : DslistdoublyView) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_view_scale(s : DslistdoublyView, f : Double) -> DslistdoublyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_view_add(a : DslistdoublyView, b : DslistdoublyView) -> DslistdoublyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_view_copy(s : DslistdoublyView) -> DslistdoublyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_view_fill(s : DslistdoublyView, v : Double) -> DslistdoublyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_view_min(s : DslistdoublyView) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_view_max(s : DslistdoublyView) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_view_to_string(s : DslistdoublyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_range_make(size : Int) -> DslistdoublyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_range_len(s : DslistdoublyRange) -> Int { s.size }

pub fn ds_list_doubly_range_get(s : DslistdoublyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_range_set(s : DslistdoublyRange, i : Int, v : Double) -> DslistdoublyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_range_sum(s : DslistdoublyRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_range_mean(s : DslistdoublyRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_range_scale(s : DslistdoublyRange, f : Double) -> DslistdoublyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_range_add(a : DslistdoublyRange, b : DslistdoublyRange) -> DslistdoublyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_range_copy(s : DslistdoublyRange) -> DslistdoublyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_range_fill(s : DslistdoublyRange, v : Double) -> DslistdoublyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_range_min(s : DslistdoublyRange) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_range_max(s : DslistdoublyRange) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_range_to_string(s : DslistdoublyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_slice_make(size : Int) -> DslistdoublySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_slice_len(s : DslistdoublySlice) -> Int { s.size }

pub fn ds_list_doubly_slice_get(s : DslistdoublySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_slice_set(s : DslistdoublySlice, i : Int, v : Double) -> DslistdoublySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_slice_sum(s : DslistdoublySlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_doubly_slice_mean(s : DslistdoublySlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_doubly_slice_scale(s : DslistdoublySlice, f : Double) -> DslistdoublySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_slice_add(a : DslistdoublySlice, b : DslistdoublySlice) -> DslistdoublySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_doubly_slice_copy(s : DslistdoublySlice) -> DslistdoublySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_slice_fill(s : DslistdoublySlice, v : Double) -> DslistdoublySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_doubly_slice_min(s : DslistdoublySlice) -> Double { @_common.min(s.data) }

pub fn ds_list_doubly_slice_max(s : DslistdoublySlice) -> Double { @_common.max(s.data) }

pub fn ds_list_doubly_slice_to_string(s : DslistdoublySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

