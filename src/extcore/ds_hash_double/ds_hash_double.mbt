///===
/// extcore/ds_hash_double

pub(all) struct DshashdoublePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_double_make_point(x : Double, y : Double) -> DshashdoublePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_double_make_point3(x : Double, y : Double, z : Double) -> DshashdoublePoint {
  { x, y, z, label: 0 }
}

pub fn DshashdoublePoint::x(self : DshashdoublePoint) -> Double { self.x }

pub fn DshashdoublePoint::y(self : DshashdoublePoint) -> Double { self.y }

pub fn DshashdoublePoint::z(self : DshashdoublePoint) -> Double { self.z }

pub fn DshashdoublePoint::label(self : DshashdoublePoint) -> Int { self.label }

pub fn DshashdoublePoint::dist(self : DshashdoublePoint, other : DshashdoublePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashdoublePoint::add(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashdoublePoint::sub(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashdoublePoint::scale(self : DshashdoublePoint, s : Double) -> DshashdoublePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashdoublePoint::dot(self : DshashdoublePoint, other : DshashdoublePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashdoublePoint::cross(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashdoublePoint::norm(self : DshashdoublePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashdoublePoint::normalize(self : DshashdoublePoint) -> DshashdoublePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashdoublePoint::negate(self : DshashdoublePoint) -> DshashdoublePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashdoublePoint::mid(self : DshashdoublePoint, other : DshashdoublePoint) -> DshashdoublePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashdoublePoint::lerp(self : DshashdoublePoint, other : DshashdoublePoint, t : Double) -> DshashdoublePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashdoublePoint::to_string(self : DshashdoublePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashdoubleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_double_make_series(vals : Array[Double], name : String) -> DshashdoubleSeries {
  { vals, name, meta: 0 }
}

pub fn DshashdoubleSeries::len(self : DshashdoubleSeries) -> Int { self.vals.length() }

pub fn DshashdoubleSeries::sum(self : DshashdoubleSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashdoubleSeries::mean(self : DshashdoubleSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashdoubleSeries::min(self : DshashdoubleSeries) -> Double { @_common.min(self.vals) }

pub fn DshashdoubleSeries::max(self : DshashdoubleSeries) -> Double { @_common.max(self.vals) }

pub fn DshashdoubleSeries::range(self : DshashdoubleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashdoubleSeries::variance(self : DshashdoubleSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashdoubleSeries::std(self : DshashdoubleSeries) -> Double { @_common.std(self.vals) }

pub fn DshashdoubleSeries::median(self : DshashdoubleSeries) -> Double { @_common.median(self.vals) }

pub fn DshashdoubleSeries::scale(self : DshashdoubleSeries, f : Double) -> DshashdoubleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashdoubleSeries::add(self : DshashdoubleSeries, other : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashdoubleSeries::sub(self : DshashdoubleSeries, other : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashdoubleSeries::normalize(self : DshashdoubleSeries) -> DshashdoubleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashdoubleSeries::cumsum(self : DshashdoubleSeries) -> DshashdoubleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashdoubleSeries::to_string(self : DshashdoubleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashdoubleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_double_make_matrix(rows : Int, cols : Int, val : Double) -> DshashdoubleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_double_matrix_identity(n : Int) -> DshashdoubleMatrix {
  let m = ds_hash_double_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashdoubleMatrix::get(self : DshashdoubleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashdoubleMatrix::transpose(self : DshashdoubleMatrix) -> DshashdoubleMatrix {
  let result = ds_hash_double_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashdoubleMatrix::add(self : DshashdoubleMatrix, other : DshashdoubleMatrix) -> DshashdoubleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_double_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashdoubleMatrix::scale(self : DshashdoubleMatrix, s : Double) -> DshashdoubleMatrix {
  let result = ds_hash_double_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashdoubleMatrix::multiply(self : DshashdoubleMatrix, other : DshashdoubleMatrix) -> DshashdoubleMatrix {
  if self.cols != other.rows { return ds_hash_double_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_double_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashdoubleMatrix::trace(self : DshashdoubleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashdoubleMatrix::det(self : DshashdoubleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashdoubleMatrix::norm(self : DshashdoubleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashdoubleMatrix::to_string(self : DshashdoubleMatrix) -> String {
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

pub(all) struct DshashdoubleVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_double_make_vector(comps : Array[Double]) -> DshashdoubleVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_double_vector_zero(dim : Int) -> DshashdoubleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashdoubleVector::add(self : DshashdoubleVector, other : DshashdoubleVector) -> DshashdoubleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashdoubleVector::sub(self : DshashdoubleVector, other : DshashdoubleVector) -> DshashdoubleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashdoubleVector::scale(self : DshashdoubleVector, s : Double) -> DshashdoubleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashdoubleVector::dot(self : DshashdoubleVector, other : DshashdoubleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashdoubleVector::norm(self : DshashdoubleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashdoubleVector::normalize(self : DshashdoubleVector) -> DshashdoubleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashdoubleVector::dist(self : DshashdoubleVector, other : DshashdoubleVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashdoubleVector::to_string(self : DshashdoubleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_double_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_double_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_double_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_double_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_double_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_double_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_double_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_double_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_double_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_double_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_double_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_double_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_double_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_double_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_double_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_double_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_double_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_double_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_double_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_double_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_double_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_double_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_double_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_double_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_double_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_double_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_double_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_double_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_double_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashdoubleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_frame_make(size : Int) -> DshashdoubleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_frame_len(s : DshashdoubleFrame) -> Int { s.size }

pub fn ds_hash_double_frame_get(s : DshashdoubleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_frame_set(s : DshashdoubleFrame, i : Int, v : Double) -> DshashdoubleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_frame_sum(s : DshashdoubleFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_frame_mean(s : DshashdoubleFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_frame_scale(s : DshashdoubleFrame, f : Double) -> DshashdoubleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_frame_add(a : DshashdoubleFrame, b : DshashdoubleFrame) -> DshashdoubleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_frame_copy(s : DshashdoubleFrame) -> DshashdoubleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_frame_fill(s : DshashdoubleFrame, v : Double) -> DshashdoubleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_frame_min(s : DshashdoubleFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_frame_max(s : DshashdoubleFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_frame_to_string(s : DshashdoubleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_table_make(size : Int) -> DshashdoubleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_table_len(s : DshashdoubleTable) -> Int { s.size }

pub fn ds_hash_double_table_get(s : DshashdoubleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_table_set(s : DshashdoubleTable, i : Int, v : Double) -> DshashdoubleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_table_sum(s : DshashdoubleTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_table_mean(s : DshashdoubleTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_table_scale(s : DshashdoubleTable, f : Double) -> DshashdoubleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_table_add(a : DshashdoubleTable, b : DshashdoubleTable) -> DshashdoubleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_table_copy(s : DshashdoubleTable) -> DshashdoubleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_table_fill(s : DshashdoubleTable, v : Double) -> DshashdoubleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_table_min(s : DshashdoubleTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_table_max(s : DshashdoubleTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_table_to_string(s : DshashdoubleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_graphn_make(size : Int) -> DshashdoubleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_graphn_len(s : DshashdoubleGraphN) -> Int { s.size }

pub fn ds_hash_double_graphn_get(s : DshashdoubleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_graphn_set(s : DshashdoubleGraphN, i : Int, v : Double) -> DshashdoubleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_graphn_sum(s : DshashdoubleGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_graphn_mean(s : DshashdoubleGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_graphn_scale(s : DshashdoubleGraphN, f : Double) -> DshashdoubleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_graphn_add(a : DshashdoubleGraphN, b : DshashdoubleGraphN) -> DshashdoubleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_graphn_copy(s : DshashdoubleGraphN) -> DshashdoubleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_graphn_fill(s : DshashdoubleGraphN, v : Double) -> DshashdoubleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_graphn_min(s : DshashdoubleGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_graphn_max(s : DshashdoubleGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_graphn_to_string(s : DshashdoubleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_node_make(size : Int) -> DshashdoubleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_node_len(s : DshashdoubleNode) -> Int { s.size }

pub fn ds_hash_double_node_get(s : DshashdoubleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_node_set(s : DshashdoubleNode, i : Int, v : Double) -> DshashdoubleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_node_sum(s : DshashdoubleNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_node_mean(s : DshashdoubleNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_node_scale(s : DshashdoubleNode, f : Double) -> DshashdoubleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_node_add(a : DshashdoubleNode, b : DshashdoubleNode) -> DshashdoubleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_node_copy(s : DshashdoubleNode) -> DshashdoubleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_node_fill(s : DshashdoubleNode, v : Double) -> DshashdoubleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_node_min(s : DshashdoubleNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_node_max(s : DshashdoubleNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_node_to_string(s : DshashdoubleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_edge_make(size : Int) -> DshashdoubleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_edge_len(s : DshashdoubleEdge) -> Int { s.size }

pub fn ds_hash_double_edge_get(s : DshashdoubleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_edge_set(s : DshashdoubleEdge, i : Int, v : Double) -> DshashdoubleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_edge_sum(s : DshashdoubleEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_edge_mean(s : DshashdoubleEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_edge_scale(s : DshashdoubleEdge, f : Double) -> DshashdoubleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_edge_add(a : DshashdoubleEdge, b : DshashdoubleEdge) -> DshashdoubleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_edge_copy(s : DshashdoubleEdge) -> DshashdoubleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_edge_fill(s : DshashdoubleEdge, v : Double) -> DshashdoubleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_edge_min(s : DshashdoubleEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_edge_max(s : DshashdoubleEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_edge_to_string(s : DshashdoubleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoublePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_path_make(size : Int) -> DshashdoublePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_path_len(s : DshashdoublePath) -> Int { s.size }

pub fn ds_hash_double_path_get(s : DshashdoublePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_path_set(s : DshashdoublePath, i : Int, v : Double) -> DshashdoublePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_path_sum(s : DshashdoublePath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_path_mean(s : DshashdoublePath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_path_scale(s : DshashdoublePath, f : Double) -> DshashdoublePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_path_add(a : DshashdoublePath, b : DshashdoublePath) -> DshashdoublePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_path_copy(s : DshashdoublePath) -> DshashdoublePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_path_fill(s : DshashdoublePath, v : Double) -> DshashdoublePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_path_min(s : DshashdoublePath) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_path_max(s : DshashdoublePath) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_path_to_string(s : DshashdoublePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_cluster_make(size : Int) -> DshashdoubleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_cluster_len(s : DshashdoubleCluster) -> Int { s.size }

pub fn ds_hash_double_cluster_get(s : DshashdoubleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_cluster_set(s : DshashdoubleCluster, i : Int, v : Double) -> DshashdoubleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cluster_sum(s : DshashdoubleCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_cluster_mean(s : DshashdoubleCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_cluster_scale(s : DshashdoubleCluster, f : Double) -> DshashdoubleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cluster_add(a : DshashdoubleCluster, b : DshashdoubleCluster) -> DshashdoubleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_cluster_copy(s : DshashdoubleCluster) -> DshashdoubleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cluster_fill(s : DshashdoubleCluster, v : Double) -> DshashdoubleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cluster_min(s : DshashdoubleCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_cluster_max(s : DshashdoubleCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_cluster_to_string(s : DshashdoubleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_model_make(size : Int) -> DshashdoubleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_model_len(s : DshashdoubleModel) -> Int { s.size }

pub fn ds_hash_double_model_get(s : DshashdoubleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_model_set(s : DshashdoubleModel, i : Int, v : Double) -> DshashdoubleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_model_sum(s : DshashdoubleModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_model_mean(s : DshashdoubleModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_model_scale(s : DshashdoubleModel, f : Double) -> DshashdoubleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_model_add(a : DshashdoubleModel, b : DshashdoubleModel) -> DshashdoubleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_model_copy(s : DshashdoubleModel) -> DshashdoubleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_model_fill(s : DshashdoubleModel, v : Double) -> DshashdoubleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_model_min(s : DshashdoubleModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_model_max(s : DshashdoubleModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_model_to_string(s : DshashdoubleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_layer_make(size : Int) -> DshashdoubleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_layer_len(s : DshashdoubleLayer) -> Int { s.size }

pub fn ds_hash_double_layer_get(s : DshashdoubleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_layer_set(s : DshashdoubleLayer, i : Int, v : Double) -> DshashdoubleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_layer_sum(s : DshashdoubleLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_layer_mean(s : DshashdoubleLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_layer_scale(s : DshashdoubleLayer, f : Double) -> DshashdoubleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_layer_add(a : DshashdoubleLayer, b : DshashdoubleLayer) -> DshashdoubleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_layer_copy(s : DshashdoubleLayer) -> DshashdoubleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_layer_fill(s : DshashdoubleLayer, v : Double) -> DshashdoubleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_layer_min(s : DshashdoubleLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_layer_max(s : DshashdoubleLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_layer_to_string(s : DshashdoubleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_buffer_make(size : Int) -> DshashdoubleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_buffer_len(s : DshashdoubleBuffer) -> Int { s.size }

pub fn ds_hash_double_buffer_get(s : DshashdoubleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_buffer_set(s : DshashdoubleBuffer, i : Int, v : Double) -> DshashdoubleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_buffer_sum(s : DshashdoubleBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_buffer_mean(s : DshashdoubleBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_buffer_scale(s : DshashdoubleBuffer, f : Double) -> DshashdoubleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_buffer_add(a : DshashdoubleBuffer, b : DshashdoubleBuffer) -> DshashdoubleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_buffer_copy(s : DshashdoubleBuffer) -> DshashdoubleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_buffer_fill(s : DshashdoubleBuffer, v : Double) -> DshashdoubleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_buffer_min(s : DshashdoubleBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_buffer_max(s : DshashdoubleBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_buffer_to_string(s : DshashdoubleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_cursor_make(size : Int) -> DshashdoubleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_cursor_len(s : DshashdoubleCursor) -> Int { s.size }

pub fn ds_hash_double_cursor_get(s : DshashdoubleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_cursor_set(s : DshashdoubleCursor, i : Int, v : Double) -> DshashdoubleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cursor_sum(s : DshashdoubleCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_cursor_mean(s : DshashdoubleCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_cursor_scale(s : DshashdoubleCursor, f : Double) -> DshashdoubleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cursor_add(a : DshashdoubleCursor, b : DshashdoubleCursor) -> DshashdoubleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_cursor_copy(s : DshashdoubleCursor) -> DshashdoubleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cursor_fill(s : DshashdoubleCursor, v : Double) -> DshashdoubleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_cursor_min(s : DshashdoubleCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_cursor_max(s : DshashdoubleCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_cursor_to_string(s : DshashdoubleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_view_make(size : Int) -> DshashdoubleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_view_len(s : DshashdoubleView) -> Int { s.size }

pub fn ds_hash_double_view_get(s : DshashdoubleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_view_set(s : DshashdoubleView, i : Int, v : Double) -> DshashdoubleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_view_sum(s : DshashdoubleView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_view_mean(s : DshashdoubleView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_view_scale(s : DshashdoubleView, f : Double) -> DshashdoubleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_view_add(a : DshashdoubleView, b : DshashdoubleView) -> DshashdoubleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_view_copy(s : DshashdoubleView) -> DshashdoubleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_view_fill(s : DshashdoubleView, v : Double) -> DshashdoubleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_view_min(s : DshashdoubleView) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_view_max(s : DshashdoubleView) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_view_to_string(s : DshashdoubleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_range_make(size : Int) -> DshashdoubleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_range_len(s : DshashdoubleRange) -> Int { s.size }

pub fn ds_hash_double_range_get(s : DshashdoubleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_range_set(s : DshashdoubleRange, i : Int, v : Double) -> DshashdoubleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_range_sum(s : DshashdoubleRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_range_mean(s : DshashdoubleRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_range_scale(s : DshashdoubleRange, f : Double) -> DshashdoubleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_range_add(a : DshashdoubleRange, b : DshashdoubleRange) -> DshashdoubleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_range_copy(s : DshashdoubleRange) -> DshashdoubleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_range_fill(s : DshashdoubleRange, v : Double) -> DshashdoubleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_range_min(s : DshashdoubleRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_range_max(s : DshashdoubleRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_range_to_string(s : DshashdoubleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashdoubleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_double_slice_make(size : Int) -> DshashdoubleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_double_slice_len(s : DshashdoubleSlice) -> Int { s.size }

pub fn ds_hash_double_slice_get(s : DshashdoubleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_double_slice_set(s : DshashdoubleSlice, i : Int, v : Double) -> DshashdoubleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_double_slice_sum(s : DshashdoubleSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_double_slice_mean(s : DshashdoubleSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_double_slice_scale(s : DshashdoubleSlice, f : Double) -> DshashdoubleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_slice_add(a : DshashdoubleSlice, b : DshashdoubleSlice) -> DshashdoubleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_double_slice_copy(s : DshashdoubleSlice) -> DshashdoubleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_slice_fill(s : DshashdoubleSlice, v : Double) -> DshashdoubleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_double_slice_min(s : DshashdoubleSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_double_slice_max(s : DshashdoubleSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_double_slice_to_string(s : DshashdoubleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

