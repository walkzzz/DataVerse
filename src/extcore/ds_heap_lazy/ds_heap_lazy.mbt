///===
/// extcore/ds_heap_lazy

pub(all) struct DsheaplazyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_lazy_make_point(x : Double, y : Double) -> DsheaplazyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_lazy_make_point3(x : Double, y : Double, z : Double) -> DsheaplazyPoint {
  { x, y, z, label: 0 }
}

pub fn DsheaplazyPoint::x(self : DsheaplazyPoint) -> Double { self.x }

pub fn DsheaplazyPoint::y(self : DsheaplazyPoint) -> Double { self.y }

pub fn DsheaplazyPoint::z(self : DsheaplazyPoint) -> Double { self.z }

pub fn DsheaplazyPoint::label(self : DsheaplazyPoint) -> Int { self.label }

pub fn DsheaplazyPoint::dist(self : DsheaplazyPoint, other : DsheaplazyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheaplazyPoint::add(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheaplazyPoint::sub(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheaplazyPoint::scale(self : DsheaplazyPoint, s : Double) -> DsheaplazyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheaplazyPoint::dot(self : DsheaplazyPoint, other : DsheaplazyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheaplazyPoint::cross(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheaplazyPoint::norm(self : DsheaplazyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheaplazyPoint::normalize(self : DsheaplazyPoint) -> DsheaplazyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheaplazyPoint::negate(self : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheaplazyPoint::mid(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheaplazyPoint::lerp(self : DsheaplazyPoint, other : DsheaplazyPoint, t : Double) -> DsheaplazyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheaplazyPoint::to_string(self : DsheaplazyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheaplazySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_lazy_make_series(vals : Array[Double], name : String) -> DsheaplazySeries {
  { vals, name, meta: 0 }
}

pub fn DsheaplazySeries::len(self : DsheaplazySeries) -> Int { self.vals.length() }

pub fn DsheaplazySeries::sum(self : DsheaplazySeries) -> Double { @_common.sum(self.vals) }

pub fn DsheaplazySeries::mean(self : DsheaplazySeries) -> Double { @_common.mean(self.vals) }

pub fn DsheaplazySeries::min(self : DsheaplazySeries) -> Double { @_common.min(self.vals) }

pub fn DsheaplazySeries::max(self : DsheaplazySeries) -> Double { @_common.max(self.vals) }

pub fn DsheaplazySeries::range(self : DsheaplazySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheaplazySeries::variance(self : DsheaplazySeries) -> Double { @_common.variance(self.vals) }

pub fn DsheaplazySeries::std(self : DsheaplazySeries) -> Double { @_common.std(self.vals) }

pub fn DsheaplazySeries::median(self : DsheaplazySeries) -> Double { @_common.median(self.vals) }

pub fn DsheaplazySeries::scale(self : DsheaplazySeries, f : Double) -> DsheaplazySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheaplazySeries::add(self : DsheaplazySeries, other : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheaplazySeries::sub(self : DsheaplazySeries, other : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheaplazySeries::normalize(self : DsheaplazySeries) -> DsheaplazySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheaplazySeries::cumsum(self : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheaplazySeries::to_string(self : DsheaplazySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheaplazyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_lazy_make_matrix(rows : Int, cols : Int, val : Double) -> DsheaplazyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_lazy_matrix_identity(n : Int) -> DsheaplazyMatrix {
  let m = ds_heap_lazy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheaplazyMatrix::get(self : DsheaplazyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheaplazyMatrix::transpose(self : DsheaplazyMatrix) -> DsheaplazyMatrix {
  let result = ds_heap_lazy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheaplazyMatrix::add(self : DsheaplazyMatrix, other : DsheaplazyMatrix) -> DsheaplazyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_lazy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheaplazyMatrix::scale(self : DsheaplazyMatrix, s : Double) -> DsheaplazyMatrix {
  let result = ds_heap_lazy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheaplazyMatrix::multiply(self : DsheaplazyMatrix, other : DsheaplazyMatrix) -> DsheaplazyMatrix {
  if self.cols != other.rows { return ds_heap_lazy_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_lazy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheaplazyMatrix::trace(self : DsheaplazyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheaplazyMatrix::det(self : DsheaplazyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheaplazyMatrix::norm(self : DsheaplazyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheaplazyMatrix::to_string(self : DsheaplazyMatrix) -> String {
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

pub(all) struct DsheaplazyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_lazy_make_vector(comps : Array[Double]) -> DsheaplazyVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_lazy_vector_zero(dim : Int) -> DsheaplazyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheaplazyVector::add(self : DsheaplazyVector, other : DsheaplazyVector) -> DsheaplazyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheaplazyVector::sub(self : DsheaplazyVector, other : DsheaplazyVector) -> DsheaplazyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheaplazyVector::scale(self : DsheaplazyVector, s : Double) -> DsheaplazyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheaplazyVector::dot(self : DsheaplazyVector, other : DsheaplazyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheaplazyVector::norm(self : DsheaplazyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheaplazyVector::normalize(self : DsheaplazyVector) -> DsheaplazyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheaplazyVector::dist(self : DsheaplazyVector, other : DsheaplazyVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheaplazyVector::to_string(self : DsheaplazyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_lazy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_lazy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_lazy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_lazy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_lazy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_lazy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_lazy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_lazy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_lazy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_lazy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_lazy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_lazy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_lazy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_lazy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_lazy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_lazy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_lazy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_lazy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_lazy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_lazy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_lazy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_lazy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_lazy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_lazy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_lazy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_lazy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_lazy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_lazy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_lazy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheaplazyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_frame_make(size : Int) -> DsheaplazyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_frame_len(s : DsheaplazyFrame) -> Int { s.size }

pub fn ds_heap_lazy_frame_get(s : DsheaplazyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_frame_set(s : DsheaplazyFrame, i : Int, v : Double) -> DsheaplazyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_frame_sum(s : DsheaplazyFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_frame_mean(s : DsheaplazyFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_frame_scale(s : DsheaplazyFrame, f : Double) -> DsheaplazyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_frame_add(a : DsheaplazyFrame, b : DsheaplazyFrame) -> DsheaplazyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_frame_copy(s : DsheaplazyFrame) -> DsheaplazyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_frame_fill(s : DsheaplazyFrame, v : Double) -> DsheaplazyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_frame_min(s : DsheaplazyFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_frame_max(s : DsheaplazyFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_frame_to_string(s : DsheaplazyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_table_make(size : Int) -> DsheaplazyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_table_len(s : DsheaplazyTable) -> Int { s.size }

pub fn ds_heap_lazy_table_get(s : DsheaplazyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_table_set(s : DsheaplazyTable, i : Int, v : Double) -> DsheaplazyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_table_sum(s : DsheaplazyTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_table_mean(s : DsheaplazyTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_table_scale(s : DsheaplazyTable, f : Double) -> DsheaplazyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_table_add(a : DsheaplazyTable, b : DsheaplazyTable) -> DsheaplazyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_table_copy(s : DsheaplazyTable) -> DsheaplazyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_table_fill(s : DsheaplazyTable, v : Double) -> DsheaplazyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_table_min(s : DsheaplazyTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_table_max(s : DsheaplazyTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_table_to_string(s : DsheaplazyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_graphn_make(size : Int) -> DsheaplazyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_graphn_len(s : DsheaplazyGraphN) -> Int { s.size }

pub fn ds_heap_lazy_graphn_get(s : DsheaplazyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_graphn_set(s : DsheaplazyGraphN, i : Int, v : Double) -> DsheaplazyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_graphn_sum(s : DsheaplazyGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_graphn_mean(s : DsheaplazyGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_graphn_scale(s : DsheaplazyGraphN, f : Double) -> DsheaplazyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_graphn_add(a : DsheaplazyGraphN, b : DsheaplazyGraphN) -> DsheaplazyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_graphn_copy(s : DsheaplazyGraphN) -> DsheaplazyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_graphn_fill(s : DsheaplazyGraphN, v : Double) -> DsheaplazyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_graphn_min(s : DsheaplazyGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_graphn_max(s : DsheaplazyGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_graphn_to_string(s : DsheaplazyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_node_make(size : Int) -> DsheaplazyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_node_len(s : DsheaplazyNode) -> Int { s.size }

pub fn ds_heap_lazy_node_get(s : DsheaplazyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_node_set(s : DsheaplazyNode, i : Int, v : Double) -> DsheaplazyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_node_sum(s : DsheaplazyNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_node_mean(s : DsheaplazyNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_node_scale(s : DsheaplazyNode, f : Double) -> DsheaplazyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_node_add(a : DsheaplazyNode, b : DsheaplazyNode) -> DsheaplazyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_node_copy(s : DsheaplazyNode) -> DsheaplazyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_node_fill(s : DsheaplazyNode, v : Double) -> DsheaplazyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_node_min(s : DsheaplazyNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_node_max(s : DsheaplazyNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_node_to_string(s : DsheaplazyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_edge_make(size : Int) -> DsheaplazyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_edge_len(s : DsheaplazyEdge) -> Int { s.size }

pub fn ds_heap_lazy_edge_get(s : DsheaplazyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_edge_set(s : DsheaplazyEdge, i : Int, v : Double) -> DsheaplazyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_edge_sum(s : DsheaplazyEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_edge_mean(s : DsheaplazyEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_edge_scale(s : DsheaplazyEdge, f : Double) -> DsheaplazyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_edge_add(a : DsheaplazyEdge, b : DsheaplazyEdge) -> DsheaplazyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_edge_copy(s : DsheaplazyEdge) -> DsheaplazyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_edge_fill(s : DsheaplazyEdge, v : Double) -> DsheaplazyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_edge_min(s : DsheaplazyEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_edge_max(s : DsheaplazyEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_edge_to_string(s : DsheaplazyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_path_make(size : Int) -> DsheaplazyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_path_len(s : DsheaplazyPath) -> Int { s.size }

pub fn ds_heap_lazy_path_get(s : DsheaplazyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_path_set(s : DsheaplazyPath, i : Int, v : Double) -> DsheaplazyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_path_sum(s : DsheaplazyPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_path_mean(s : DsheaplazyPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_path_scale(s : DsheaplazyPath, f : Double) -> DsheaplazyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_path_add(a : DsheaplazyPath, b : DsheaplazyPath) -> DsheaplazyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_path_copy(s : DsheaplazyPath) -> DsheaplazyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_path_fill(s : DsheaplazyPath, v : Double) -> DsheaplazyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_path_min(s : DsheaplazyPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_path_max(s : DsheaplazyPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_path_to_string(s : DsheaplazyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_cluster_make(size : Int) -> DsheaplazyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_cluster_len(s : DsheaplazyCluster) -> Int { s.size }

pub fn ds_heap_lazy_cluster_get(s : DsheaplazyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_cluster_set(s : DsheaplazyCluster, i : Int, v : Double) -> DsheaplazyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cluster_sum(s : DsheaplazyCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_cluster_mean(s : DsheaplazyCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_cluster_scale(s : DsheaplazyCluster, f : Double) -> DsheaplazyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cluster_add(a : DsheaplazyCluster, b : DsheaplazyCluster) -> DsheaplazyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_cluster_copy(s : DsheaplazyCluster) -> DsheaplazyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cluster_fill(s : DsheaplazyCluster, v : Double) -> DsheaplazyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cluster_min(s : DsheaplazyCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_cluster_max(s : DsheaplazyCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_cluster_to_string(s : DsheaplazyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_model_make(size : Int) -> DsheaplazyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_model_len(s : DsheaplazyModel) -> Int { s.size }

pub fn ds_heap_lazy_model_get(s : DsheaplazyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_model_set(s : DsheaplazyModel, i : Int, v : Double) -> DsheaplazyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_model_sum(s : DsheaplazyModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_model_mean(s : DsheaplazyModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_model_scale(s : DsheaplazyModel, f : Double) -> DsheaplazyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_model_add(a : DsheaplazyModel, b : DsheaplazyModel) -> DsheaplazyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_model_copy(s : DsheaplazyModel) -> DsheaplazyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_model_fill(s : DsheaplazyModel, v : Double) -> DsheaplazyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_model_min(s : DsheaplazyModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_model_max(s : DsheaplazyModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_model_to_string(s : DsheaplazyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_layer_make(size : Int) -> DsheaplazyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_layer_len(s : DsheaplazyLayer) -> Int { s.size }

pub fn ds_heap_lazy_layer_get(s : DsheaplazyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_layer_set(s : DsheaplazyLayer, i : Int, v : Double) -> DsheaplazyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_layer_sum(s : DsheaplazyLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_layer_mean(s : DsheaplazyLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_layer_scale(s : DsheaplazyLayer, f : Double) -> DsheaplazyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_layer_add(a : DsheaplazyLayer, b : DsheaplazyLayer) -> DsheaplazyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_layer_copy(s : DsheaplazyLayer) -> DsheaplazyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_layer_fill(s : DsheaplazyLayer, v : Double) -> DsheaplazyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_layer_min(s : DsheaplazyLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_layer_max(s : DsheaplazyLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_layer_to_string(s : DsheaplazyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_buffer_make(size : Int) -> DsheaplazyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_buffer_len(s : DsheaplazyBuffer) -> Int { s.size }

pub fn ds_heap_lazy_buffer_get(s : DsheaplazyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_buffer_set(s : DsheaplazyBuffer, i : Int, v : Double) -> DsheaplazyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_buffer_sum(s : DsheaplazyBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_buffer_mean(s : DsheaplazyBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_buffer_scale(s : DsheaplazyBuffer, f : Double) -> DsheaplazyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_buffer_add(a : DsheaplazyBuffer, b : DsheaplazyBuffer) -> DsheaplazyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_buffer_copy(s : DsheaplazyBuffer) -> DsheaplazyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_buffer_fill(s : DsheaplazyBuffer, v : Double) -> DsheaplazyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_buffer_min(s : DsheaplazyBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_buffer_max(s : DsheaplazyBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_buffer_to_string(s : DsheaplazyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_cursor_make(size : Int) -> DsheaplazyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_cursor_len(s : DsheaplazyCursor) -> Int { s.size }

pub fn ds_heap_lazy_cursor_get(s : DsheaplazyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_cursor_set(s : DsheaplazyCursor, i : Int, v : Double) -> DsheaplazyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cursor_sum(s : DsheaplazyCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_cursor_mean(s : DsheaplazyCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_cursor_scale(s : DsheaplazyCursor, f : Double) -> DsheaplazyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cursor_add(a : DsheaplazyCursor, b : DsheaplazyCursor) -> DsheaplazyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_cursor_copy(s : DsheaplazyCursor) -> DsheaplazyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cursor_fill(s : DsheaplazyCursor, v : Double) -> DsheaplazyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_cursor_min(s : DsheaplazyCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_cursor_max(s : DsheaplazyCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_cursor_to_string(s : DsheaplazyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_view_make(size : Int) -> DsheaplazyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_view_len(s : DsheaplazyView) -> Int { s.size }

pub fn ds_heap_lazy_view_get(s : DsheaplazyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_view_set(s : DsheaplazyView, i : Int, v : Double) -> DsheaplazyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_view_sum(s : DsheaplazyView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_view_mean(s : DsheaplazyView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_view_scale(s : DsheaplazyView, f : Double) -> DsheaplazyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_view_add(a : DsheaplazyView, b : DsheaplazyView) -> DsheaplazyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_view_copy(s : DsheaplazyView) -> DsheaplazyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_view_fill(s : DsheaplazyView, v : Double) -> DsheaplazyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_view_min(s : DsheaplazyView) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_view_max(s : DsheaplazyView) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_view_to_string(s : DsheaplazyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_range_make(size : Int) -> DsheaplazyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_range_len(s : DsheaplazyRange) -> Int { s.size }

pub fn ds_heap_lazy_range_get(s : DsheaplazyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_range_set(s : DsheaplazyRange, i : Int, v : Double) -> DsheaplazyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_range_sum(s : DsheaplazyRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_range_mean(s : DsheaplazyRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_range_scale(s : DsheaplazyRange, f : Double) -> DsheaplazyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_range_add(a : DsheaplazyRange, b : DsheaplazyRange) -> DsheaplazyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_range_copy(s : DsheaplazyRange) -> DsheaplazyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_range_fill(s : DsheaplazyRange, v : Double) -> DsheaplazyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_range_min(s : DsheaplazyRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_range_max(s : DsheaplazyRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_range_to_string(s : DsheaplazyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheaplazySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_slice_make(size : Int) -> DsheaplazySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_lazy_slice_len(s : DsheaplazySlice) -> Int { s.size }

pub fn ds_heap_lazy_slice_get(s : DsheaplazySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_lazy_slice_set(s : DsheaplazySlice, i : Int, v : Double) -> DsheaplazySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_slice_sum(s : DsheaplazySlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_lazy_slice_mean(s : DsheaplazySlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_lazy_slice_scale(s : DsheaplazySlice, f : Double) -> DsheaplazySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_slice_add(a : DsheaplazySlice, b : DsheaplazySlice) -> DsheaplazySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_lazy_slice_copy(s : DsheaplazySlice) -> DsheaplazySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_slice_fill(s : DsheaplazySlice, v : Double) -> DsheaplazySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_lazy_slice_min(s : DsheaplazySlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_lazy_slice_max(s : DsheaplazySlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_lazy_slice_to_string(s : DsheaplazySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

