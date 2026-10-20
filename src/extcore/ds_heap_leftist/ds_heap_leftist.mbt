///===
/// extcore/ds_heap_leftist

pub(all) struct DsheapleftistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_leftist_make_point(x : Double, y : Double) -> DsheapleftistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_leftist_make_point3(x : Double, y : Double, z : Double) -> DsheapleftistPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapleftistPoint::x(self : DsheapleftistPoint) -> Double { self.x }

pub fn DsheapleftistPoint::y(self : DsheapleftistPoint) -> Double { self.y }

pub fn DsheapleftistPoint::z(self : DsheapleftistPoint) -> Double { self.z }

pub fn DsheapleftistPoint::label(self : DsheapleftistPoint) -> Int { self.label }

pub fn DsheapleftistPoint::dist(self : DsheapleftistPoint, other : DsheapleftistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapleftistPoint::add(self : DsheapleftistPoint, other : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapleftistPoint::sub(self : DsheapleftistPoint, other : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapleftistPoint::scale(self : DsheapleftistPoint, s : Double) -> DsheapleftistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapleftistPoint::dot(self : DsheapleftistPoint, other : DsheapleftistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapleftistPoint::cross(self : DsheapleftistPoint, other : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapleftistPoint::norm(self : DsheapleftistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapleftistPoint::normalize(self : DsheapleftistPoint) -> DsheapleftistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapleftistPoint::negate(self : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapleftistPoint::mid(self : DsheapleftistPoint, other : DsheapleftistPoint) -> DsheapleftistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapleftistPoint::lerp(self : DsheapleftistPoint, other : DsheapleftistPoint, t : Double) -> DsheapleftistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapleftistPoint::to_string(self : DsheapleftistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapleftistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_leftist_make_series(vals : Array[Double], name : String) -> DsheapleftistSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapleftistSeries::len(self : DsheapleftistSeries) -> Int { self.vals.length() }

pub fn DsheapleftistSeries::sum(self : DsheapleftistSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapleftistSeries::mean(self : DsheapleftistSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapleftistSeries::min(self : DsheapleftistSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapleftistSeries::max(self : DsheapleftistSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapleftistSeries::range(self : DsheapleftistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapleftistSeries::variance(self : DsheapleftistSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapleftistSeries::std(self : DsheapleftistSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapleftistSeries::median(self : DsheapleftistSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapleftistSeries::scale(self : DsheapleftistSeries, f : Double) -> DsheapleftistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapleftistSeries::add(self : DsheapleftistSeries, other : DsheapleftistSeries) -> DsheapleftistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapleftistSeries::sub(self : DsheapleftistSeries, other : DsheapleftistSeries) -> DsheapleftistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapleftistSeries::normalize(self : DsheapleftistSeries) -> DsheapleftistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapleftistSeries::cumsum(self : DsheapleftistSeries) -> DsheapleftistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapleftistSeries::to_string(self : DsheapleftistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapleftistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_leftist_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapleftistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_leftist_matrix_identity(n : Int) -> DsheapleftistMatrix {
  let m = ds_heap_leftist_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapleftistMatrix::get(self : DsheapleftistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapleftistMatrix::transpose(self : DsheapleftistMatrix) -> DsheapleftistMatrix {
  let result = ds_heap_leftist_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapleftistMatrix::add(self : DsheapleftistMatrix, other : DsheapleftistMatrix) -> DsheapleftistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_leftist_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapleftistMatrix::scale(self : DsheapleftistMatrix, s : Double) -> DsheapleftistMatrix {
  let result = ds_heap_leftist_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapleftistMatrix::multiply(self : DsheapleftistMatrix, other : DsheapleftistMatrix) -> DsheapleftistMatrix {
  if self.cols != other.rows { return ds_heap_leftist_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_leftist_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapleftistMatrix::trace(self : DsheapleftistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapleftistMatrix::det(self : DsheapleftistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapleftistMatrix::norm(self : DsheapleftistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapleftistMatrix::to_string(self : DsheapleftistMatrix) -> String {
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

pub(all) struct DsheapleftistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_leftist_make_vector(comps : Array[Double]) -> DsheapleftistVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_leftist_vector_zero(dim : Int) -> DsheapleftistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapleftistVector::add(self : DsheapleftistVector, other : DsheapleftistVector) -> DsheapleftistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapleftistVector::sub(self : DsheapleftistVector, other : DsheapleftistVector) -> DsheapleftistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapleftistVector::scale(self : DsheapleftistVector, s : Double) -> DsheapleftistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapleftistVector::dot(self : DsheapleftistVector, other : DsheapleftistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapleftistVector::norm(self : DsheapleftistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapleftistVector::normalize(self : DsheapleftistVector) -> DsheapleftistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapleftistVector::dist(self : DsheapleftistVector, other : DsheapleftistVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapleftistVector::to_string(self : DsheapleftistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_leftist_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_leftist_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_leftist_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_leftist_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_leftist_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_leftist_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_leftist_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_leftist_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_leftist_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_leftist_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_leftist_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_leftist_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_leftist_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_leftist_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_leftist_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_leftist_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_leftist_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_leftist_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_leftist_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_leftist_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_leftist_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_leftist_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_leftist_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_leftist_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_leftist_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_leftist_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_leftist_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_leftist_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_leftist_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapleftistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_frame_make(size : Int) -> DsheapleftistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_frame_len(s : DsheapleftistFrame) -> Int { s.size }

pub fn ds_heap_leftist_frame_get(s : DsheapleftistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_frame_set(s : DsheapleftistFrame, i : Int, v : Double) -> DsheapleftistFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_frame_sum(s : DsheapleftistFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_frame_mean(s : DsheapleftistFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_frame_scale(s : DsheapleftistFrame, f : Double) -> DsheapleftistFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_frame_add(a : DsheapleftistFrame, b : DsheapleftistFrame) -> DsheapleftistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_frame_copy(s : DsheapleftistFrame) -> DsheapleftistFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_frame_fill(s : DsheapleftistFrame, v : Double) -> DsheapleftistFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_frame_min(s : DsheapleftistFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_frame_max(s : DsheapleftistFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_frame_to_string(s : DsheapleftistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_table_make(size : Int) -> DsheapleftistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_table_len(s : DsheapleftistTable) -> Int { s.size }

pub fn ds_heap_leftist_table_get(s : DsheapleftistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_table_set(s : DsheapleftistTable, i : Int, v : Double) -> DsheapleftistTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_table_sum(s : DsheapleftistTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_table_mean(s : DsheapleftistTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_table_scale(s : DsheapleftistTable, f : Double) -> DsheapleftistTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_table_add(a : DsheapleftistTable, b : DsheapleftistTable) -> DsheapleftistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_table_copy(s : DsheapleftistTable) -> DsheapleftistTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_table_fill(s : DsheapleftistTable, v : Double) -> DsheapleftistTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_table_min(s : DsheapleftistTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_table_max(s : DsheapleftistTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_table_to_string(s : DsheapleftistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_graphn_make(size : Int) -> DsheapleftistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_graphn_len(s : DsheapleftistGraphN) -> Int { s.size }

pub fn ds_heap_leftist_graphn_get(s : DsheapleftistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_graphn_set(s : DsheapleftistGraphN, i : Int, v : Double) -> DsheapleftistGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_graphn_sum(s : DsheapleftistGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_graphn_mean(s : DsheapleftistGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_graphn_scale(s : DsheapleftistGraphN, f : Double) -> DsheapleftistGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_graphn_add(a : DsheapleftistGraphN, b : DsheapleftistGraphN) -> DsheapleftistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_graphn_copy(s : DsheapleftistGraphN) -> DsheapleftistGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_graphn_fill(s : DsheapleftistGraphN, v : Double) -> DsheapleftistGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_graphn_min(s : DsheapleftistGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_graphn_max(s : DsheapleftistGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_graphn_to_string(s : DsheapleftistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_node_make(size : Int) -> DsheapleftistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_node_len(s : DsheapleftistNode) -> Int { s.size }

pub fn ds_heap_leftist_node_get(s : DsheapleftistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_node_set(s : DsheapleftistNode, i : Int, v : Double) -> DsheapleftistNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_node_sum(s : DsheapleftistNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_node_mean(s : DsheapleftistNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_node_scale(s : DsheapleftistNode, f : Double) -> DsheapleftistNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_node_add(a : DsheapleftistNode, b : DsheapleftistNode) -> DsheapleftistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_node_copy(s : DsheapleftistNode) -> DsheapleftistNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_node_fill(s : DsheapleftistNode, v : Double) -> DsheapleftistNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_node_min(s : DsheapleftistNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_node_max(s : DsheapleftistNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_node_to_string(s : DsheapleftistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_edge_make(size : Int) -> DsheapleftistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_edge_len(s : DsheapleftistEdge) -> Int { s.size }

pub fn ds_heap_leftist_edge_get(s : DsheapleftistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_edge_set(s : DsheapleftistEdge, i : Int, v : Double) -> DsheapleftistEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_edge_sum(s : DsheapleftistEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_edge_mean(s : DsheapleftistEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_edge_scale(s : DsheapleftistEdge, f : Double) -> DsheapleftistEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_edge_add(a : DsheapleftistEdge, b : DsheapleftistEdge) -> DsheapleftistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_edge_copy(s : DsheapleftistEdge) -> DsheapleftistEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_edge_fill(s : DsheapleftistEdge, v : Double) -> DsheapleftistEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_edge_min(s : DsheapleftistEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_edge_max(s : DsheapleftistEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_edge_to_string(s : DsheapleftistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_path_make(size : Int) -> DsheapleftistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_path_len(s : DsheapleftistPath) -> Int { s.size }

pub fn ds_heap_leftist_path_get(s : DsheapleftistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_path_set(s : DsheapleftistPath, i : Int, v : Double) -> DsheapleftistPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_path_sum(s : DsheapleftistPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_path_mean(s : DsheapleftistPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_path_scale(s : DsheapleftistPath, f : Double) -> DsheapleftistPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_path_add(a : DsheapleftistPath, b : DsheapleftistPath) -> DsheapleftistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_path_copy(s : DsheapleftistPath) -> DsheapleftistPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_path_fill(s : DsheapleftistPath, v : Double) -> DsheapleftistPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_path_min(s : DsheapleftistPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_path_max(s : DsheapleftistPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_path_to_string(s : DsheapleftistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_cluster_make(size : Int) -> DsheapleftistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_cluster_len(s : DsheapleftistCluster) -> Int { s.size }

pub fn ds_heap_leftist_cluster_get(s : DsheapleftistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_cluster_set(s : DsheapleftistCluster, i : Int, v : Double) -> DsheapleftistCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cluster_sum(s : DsheapleftistCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_cluster_mean(s : DsheapleftistCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_cluster_scale(s : DsheapleftistCluster, f : Double) -> DsheapleftistCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cluster_add(a : DsheapleftistCluster, b : DsheapleftistCluster) -> DsheapleftistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_cluster_copy(s : DsheapleftistCluster) -> DsheapleftistCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cluster_fill(s : DsheapleftistCluster, v : Double) -> DsheapleftistCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cluster_min(s : DsheapleftistCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_cluster_max(s : DsheapleftistCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_cluster_to_string(s : DsheapleftistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_model_make(size : Int) -> DsheapleftistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_model_len(s : DsheapleftistModel) -> Int { s.size }

pub fn ds_heap_leftist_model_get(s : DsheapleftistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_model_set(s : DsheapleftistModel, i : Int, v : Double) -> DsheapleftistModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_model_sum(s : DsheapleftistModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_model_mean(s : DsheapleftistModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_model_scale(s : DsheapleftistModel, f : Double) -> DsheapleftistModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_model_add(a : DsheapleftistModel, b : DsheapleftistModel) -> DsheapleftistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_model_copy(s : DsheapleftistModel) -> DsheapleftistModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_model_fill(s : DsheapleftistModel, v : Double) -> DsheapleftistModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_model_min(s : DsheapleftistModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_model_max(s : DsheapleftistModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_model_to_string(s : DsheapleftistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_layer_make(size : Int) -> DsheapleftistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_layer_len(s : DsheapleftistLayer) -> Int { s.size }

pub fn ds_heap_leftist_layer_get(s : DsheapleftistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_layer_set(s : DsheapleftistLayer, i : Int, v : Double) -> DsheapleftistLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_layer_sum(s : DsheapleftistLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_layer_mean(s : DsheapleftistLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_layer_scale(s : DsheapleftistLayer, f : Double) -> DsheapleftistLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_layer_add(a : DsheapleftistLayer, b : DsheapleftistLayer) -> DsheapleftistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_layer_copy(s : DsheapleftistLayer) -> DsheapleftistLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_layer_fill(s : DsheapleftistLayer, v : Double) -> DsheapleftistLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_layer_min(s : DsheapleftistLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_layer_max(s : DsheapleftistLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_layer_to_string(s : DsheapleftistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_buffer_make(size : Int) -> DsheapleftistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_buffer_len(s : DsheapleftistBuffer) -> Int { s.size }

pub fn ds_heap_leftist_buffer_get(s : DsheapleftistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_buffer_set(s : DsheapleftistBuffer, i : Int, v : Double) -> DsheapleftistBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_buffer_sum(s : DsheapleftistBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_buffer_mean(s : DsheapleftistBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_buffer_scale(s : DsheapleftistBuffer, f : Double) -> DsheapleftistBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_buffer_add(a : DsheapleftistBuffer, b : DsheapleftistBuffer) -> DsheapleftistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_buffer_copy(s : DsheapleftistBuffer) -> DsheapleftistBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_buffer_fill(s : DsheapleftistBuffer, v : Double) -> DsheapleftistBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_buffer_min(s : DsheapleftistBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_buffer_max(s : DsheapleftistBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_buffer_to_string(s : DsheapleftistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_cursor_make(size : Int) -> DsheapleftistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_cursor_len(s : DsheapleftistCursor) -> Int { s.size }

pub fn ds_heap_leftist_cursor_get(s : DsheapleftistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_cursor_set(s : DsheapleftistCursor, i : Int, v : Double) -> DsheapleftistCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cursor_sum(s : DsheapleftistCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_cursor_mean(s : DsheapleftistCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_cursor_scale(s : DsheapleftistCursor, f : Double) -> DsheapleftistCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cursor_add(a : DsheapleftistCursor, b : DsheapleftistCursor) -> DsheapleftistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_cursor_copy(s : DsheapleftistCursor) -> DsheapleftistCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cursor_fill(s : DsheapleftistCursor, v : Double) -> DsheapleftistCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_cursor_min(s : DsheapleftistCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_cursor_max(s : DsheapleftistCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_cursor_to_string(s : DsheapleftistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_view_make(size : Int) -> DsheapleftistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_view_len(s : DsheapleftistView) -> Int { s.size }

pub fn ds_heap_leftist_view_get(s : DsheapleftistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_view_set(s : DsheapleftistView, i : Int, v : Double) -> DsheapleftistView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_view_sum(s : DsheapleftistView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_view_mean(s : DsheapleftistView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_view_scale(s : DsheapleftistView, f : Double) -> DsheapleftistView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_view_add(a : DsheapleftistView, b : DsheapleftistView) -> DsheapleftistView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_view_copy(s : DsheapleftistView) -> DsheapleftistView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_view_fill(s : DsheapleftistView, v : Double) -> DsheapleftistView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_view_min(s : DsheapleftistView) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_view_max(s : DsheapleftistView) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_view_to_string(s : DsheapleftistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_range_make(size : Int) -> DsheapleftistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_range_len(s : DsheapleftistRange) -> Int { s.size }

pub fn ds_heap_leftist_range_get(s : DsheapleftistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_range_set(s : DsheapleftistRange, i : Int, v : Double) -> DsheapleftistRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_range_sum(s : DsheapleftistRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_range_mean(s : DsheapleftistRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_range_scale(s : DsheapleftistRange, f : Double) -> DsheapleftistRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_range_add(a : DsheapleftistRange, b : DsheapleftistRange) -> DsheapleftistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_range_copy(s : DsheapleftistRange) -> DsheapleftistRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_range_fill(s : DsheapleftistRange, v : Double) -> DsheapleftistRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_range_min(s : DsheapleftistRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_range_max(s : DsheapleftistRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_range_to_string(s : DsheapleftistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapleftistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_leftist_slice_make(size : Int) -> DsheapleftistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_leftist_slice_len(s : DsheapleftistSlice) -> Int { s.size }

pub fn ds_heap_leftist_slice_get(s : DsheapleftistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_leftist_slice_set(s : DsheapleftistSlice, i : Int, v : Double) -> DsheapleftistSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_slice_sum(s : DsheapleftistSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_leftist_slice_mean(s : DsheapleftistSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_leftist_slice_scale(s : DsheapleftistSlice, f : Double) -> DsheapleftistSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_slice_add(a : DsheapleftistSlice, b : DsheapleftistSlice) -> DsheapleftistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_leftist_slice_copy(s : DsheapleftistSlice) -> DsheapleftistSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_slice_fill(s : DsheapleftistSlice, v : Double) -> DsheapleftistSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_leftist_slice_min(s : DsheapleftistSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_leftist_slice_max(s : DsheapleftistSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_leftist_slice_to_string(s : DsheapleftistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

