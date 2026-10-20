///===
/// extcore/ds_hash_closed

pub(all) struct DshashclosedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_closed_make_point(x : Double, y : Double) -> DshashclosedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_closed_make_point3(x : Double, y : Double, z : Double) -> DshashclosedPoint {
  { x, y, z, label: 0 }
}

pub fn DshashclosedPoint::x(self : DshashclosedPoint) -> Double { self.x }

pub fn DshashclosedPoint::y(self : DshashclosedPoint) -> Double { self.y }

pub fn DshashclosedPoint::z(self : DshashclosedPoint) -> Double { self.z }

pub fn DshashclosedPoint::label(self : DshashclosedPoint) -> Int { self.label }

pub fn DshashclosedPoint::dist(self : DshashclosedPoint, other : DshashclosedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashclosedPoint::add(self : DshashclosedPoint, other : DshashclosedPoint) -> DshashclosedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashclosedPoint::sub(self : DshashclosedPoint, other : DshashclosedPoint) -> DshashclosedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashclosedPoint::scale(self : DshashclosedPoint, s : Double) -> DshashclosedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashclosedPoint::dot(self : DshashclosedPoint, other : DshashclosedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashclosedPoint::cross(self : DshashclosedPoint, other : DshashclosedPoint) -> DshashclosedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashclosedPoint::norm(self : DshashclosedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashclosedPoint::normalize(self : DshashclosedPoint) -> DshashclosedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashclosedPoint::negate(self : DshashclosedPoint) -> DshashclosedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashclosedPoint::mid(self : DshashclosedPoint, other : DshashclosedPoint) -> DshashclosedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashclosedPoint::lerp(self : DshashclosedPoint, other : DshashclosedPoint, t : Double) -> DshashclosedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashclosedPoint::to_string(self : DshashclosedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashclosedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_closed_make_series(vals : Array[Double], name : String) -> DshashclosedSeries {
  { vals, name, meta: 0 }
}

pub fn DshashclosedSeries::len(self : DshashclosedSeries) -> Int { self.vals.length() }

pub fn DshashclosedSeries::sum(self : DshashclosedSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashclosedSeries::mean(self : DshashclosedSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashclosedSeries::min(self : DshashclosedSeries) -> Double { @_common.min(self.vals) }

pub fn DshashclosedSeries::max(self : DshashclosedSeries) -> Double { @_common.max(self.vals) }

pub fn DshashclosedSeries::range(self : DshashclosedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashclosedSeries::variance(self : DshashclosedSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashclosedSeries::std(self : DshashclosedSeries) -> Double { @_common.std(self.vals) }

pub fn DshashclosedSeries::median(self : DshashclosedSeries) -> Double { @_common.median(self.vals) }

pub fn DshashclosedSeries::scale(self : DshashclosedSeries, f : Double) -> DshashclosedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashclosedSeries::add(self : DshashclosedSeries, other : DshashclosedSeries) -> DshashclosedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashclosedSeries::sub(self : DshashclosedSeries, other : DshashclosedSeries) -> DshashclosedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashclosedSeries::normalize(self : DshashclosedSeries) -> DshashclosedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashclosedSeries::cumsum(self : DshashclosedSeries) -> DshashclosedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashclosedSeries::to_string(self : DshashclosedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashclosedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_closed_make_matrix(rows : Int, cols : Int, val : Double) -> DshashclosedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_closed_matrix_identity(n : Int) -> DshashclosedMatrix {
  let m = ds_hash_closed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashclosedMatrix::get(self : DshashclosedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashclosedMatrix::transpose(self : DshashclosedMatrix) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashclosedMatrix::add(self : DshashclosedMatrix, other : DshashclosedMatrix) -> DshashclosedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_closed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashclosedMatrix::scale(self : DshashclosedMatrix, s : Double) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashclosedMatrix::multiply(self : DshashclosedMatrix, other : DshashclosedMatrix) -> DshashclosedMatrix {
  if self.cols != other.rows { return ds_hash_closed_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_closed_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashclosedMatrix::trace(self : DshashclosedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashclosedMatrix::det(self : DshashclosedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashclosedMatrix::norm(self : DshashclosedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashclosedMatrix::to_string(self : DshashclosedMatrix) -> String {
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

pub(all) struct DshashclosedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_closed_make_vector(comps : Array[Double]) -> DshashclosedVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_closed_vector_zero(dim : Int) -> DshashclosedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashclosedVector::add(self : DshashclosedVector, other : DshashclosedVector) -> DshashclosedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashclosedVector::sub(self : DshashclosedVector, other : DshashclosedVector) -> DshashclosedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashclosedVector::scale(self : DshashclosedVector, s : Double) -> DshashclosedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashclosedVector::dot(self : DshashclosedVector, other : DshashclosedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashclosedVector::norm(self : DshashclosedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashclosedVector::normalize(self : DshashclosedVector) -> DshashclosedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashclosedVector::dist(self : DshashclosedVector, other : DshashclosedVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashclosedVector::to_string(self : DshashclosedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_closed_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_closed_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_closed_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_closed_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_closed_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_closed_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_closed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_closed_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_closed_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_closed_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_closed_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_closed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_closed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_closed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_closed_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_closed_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_closed_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_closed_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_closed_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_closed_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_closed_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_closed_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_closed_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_closed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_closed_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_closed_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_closed_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_closed_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_closed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashclosedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_frame_make(size : Int) -> DshashclosedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_frame_len(s : DshashclosedFrame) -> Int { s.size }

pub fn ds_hash_closed_frame_get(s : DshashclosedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_frame_set(s : DshashclosedFrame, i : Int, v : Double) -> DshashclosedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_sum(s : DshashclosedFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_frame_mean(s : DshashclosedFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_frame_scale(s : DshashclosedFrame, f : Double) -> DshashclosedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_add(a : DshashclosedFrame, b : DshashclosedFrame) -> DshashclosedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_frame_copy(s : DshashclosedFrame) -> DshashclosedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_fill(s : DshashclosedFrame, v : Double) -> DshashclosedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_frame_min(s : DshashclosedFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_frame_max(s : DshashclosedFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_frame_to_string(s : DshashclosedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_table_make(size : Int) -> DshashclosedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_table_len(s : DshashclosedTable) -> Int { s.size }

pub fn ds_hash_closed_table_get(s : DshashclosedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_table_set(s : DshashclosedTable, i : Int, v : Double) -> DshashclosedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_sum(s : DshashclosedTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_table_mean(s : DshashclosedTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_table_scale(s : DshashclosedTable, f : Double) -> DshashclosedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_add(a : DshashclosedTable, b : DshashclosedTable) -> DshashclosedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_table_copy(s : DshashclosedTable) -> DshashclosedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_fill(s : DshashclosedTable, v : Double) -> DshashclosedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_table_min(s : DshashclosedTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_table_max(s : DshashclosedTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_table_to_string(s : DshashclosedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_graphn_make(size : Int) -> DshashclosedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_graphn_len(s : DshashclosedGraphN) -> Int { s.size }

pub fn ds_hash_closed_graphn_get(s : DshashclosedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_graphn_set(s : DshashclosedGraphN, i : Int, v : Double) -> DshashclosedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_sum(s : DshashclosedGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_graphn_mean(s : DshashclosedGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_graphn_scale(s : DshashclosedGraphN, f : Double) -> DshashclosedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_add(a : DshashclosedGraphN, b : DshashclosedGraphN) -> DshashclosedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_graphn_copy(s : DshashclosedGraphN) -> DshashclosedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_fill(s : DshashclosedGraphN, v : Double) -> DshashclosedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_graphn_min(s : DshashclosedGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_graphn_max(s : DshashclosedGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_graphn_to_string(s : DshashclosedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_node_make(size : Int) -> DshashclosedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_node_len(s : DshashclosedNode) -> Int { s.size }

pub fn ds_hash_closed_node_get(s : DshashclosedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_node_set(s : DshashclosedNode, i : Int, v : Double) -> DshashclosedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_sum(s : DshashclosedNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_node_mean(s : DshashclosedNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_node_scale(s : DshashclosedNode, f : Double) -> DshashclosedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_add(a : DshashclosedNode, b : DshashclosedNode) -> DshashclosedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_node_copy(s : DshashclosedNode) -> DshashclosedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_fill(s : DshashclosedNode, v : Double) -> DshashclosedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_node_min(s : DshashclosedNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_node_max(s : DshashclosedNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_node_to_string(s : DshashclosedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_edge_make(size : Int) -> DshashclosedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_edge_len(s : DshashclosedEdge) -> Int { s.size }

pub fn ds_hash_closed_edge_get(s : DshashclosedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_edge_set(s : DshashclosedEdge, i : Int, v : Double) -> DshashclosedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_sum(s : DshashclosedEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_edge_mean(s : DshashclosedEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_edge_scale(s : DshashclosedEdge, f : Double) -> DshashclosedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_add(a : DshashclosedEdge, b : DshashclosedEdge) -> DshashclosedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_edge_copy(s : DshashclosedEdge) -> DshashclosedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_fill(s : DshashclosedEdge, v : Double) -> DshashclosedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_edge_min(s : DshashclosedEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_edge_max(s : DshashclosedEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_edge_to_string(s : DshashclosedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_path_make(size : Int) -> DshashclosedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_path_len(s : DshashclosedPath) -> Int { s.size }

pub fn ds_hash_closed_path_get(s : DshashclosedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_path_set(s : DshashclosedPath, i : Int, v : Double) -> DshashclosedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_sum(s : DshashclosedPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_path_mean(s : DshashclosedPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_path_scale(s : DshashclosedPath, f : Double) -> DshashclosedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_add(a : DshashclosedPath, b : DshashclosedPath) -> DshashclosedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_path_copy(s : DshashclosedPath) -> DshashclosedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_fill(s : DshashclosedPath, v : Double) -> DshashclosedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_path_min(s : DshashclosedPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_path_max(s : DshashclosedPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_path_to_string(s : DshashclosedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_cluster_make(size : Int) -> DshashclosedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_cluster_len(s : DshashclosedCluster) -> Int { s.size }

pub fn ds_hash_closed_cluster_get(s : DshashclosedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_cluster_set(s : DshashclosedCluster, i : Int, v : Double) -> DshashclosedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_sum(s : DshashclosedCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_cluster_mean(s : DshashclosedCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_cluster_scale(s : DshashclosedCluster, f : Double) -> DshashclosedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_add(a : DshashclosedCluster, b : DshashclosedCluster) -> DshashclosedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_cluster_copy(s : DshashclosedCluster) -> DshashclosedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_fill(s : DshashclosedCluster, v : Double) -> DshashclosedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cluster_min(s : DshashclosedCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_cluster_max(s : DshashclosedCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_cluster_to_string(s : DshashclosedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_model_make(size : Int) -> DshashclosedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_model_len(s : DshashclosedModel) -> Int { s.size }

pub fn ds_hash_closed_model_get(s : DshashclosedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_model_set(s : DshashclosedModel, i : Int, v : Double) -> DshashclosedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_sum(s : DshashclosedModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_model_mean(s : DshashclosedModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_model_scale(s : DshashclosedModel, f : Double) -> DshashclosedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_add(a : DshashclosedModel, b : DshashclosedModel) -> DshashclosedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_model_copy(s : DshashclosedModel) -> DshashclosedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_fill(s : DshashclosedModel, v : Double) -> DshashclosedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_model_min(s : DshashclosedModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_model_max(s : DshashclosedModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_model_to_string(s : DshashclosedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_layer_make(size : Int) -> DshashclosedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_layer_len(s : DshashclosedLayer) -> Int { s.size }

pub fn ds_hash_closed_layer_get(s : DshashclosedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_layer_set(s : DshashclosedLayer, i : Int, v : Double) -> DshashclosedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_sum(s : DshashclosedLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_layer_mean(s : DshashclosedLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_layer_scale(s : DshashclosedLayer, f : Double) -> DshashclosedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_add(a : DshashclosedLayer, b : DshashclosedLayer) -> DshashclosedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_layer_copy(s : DshashclosedLayer) -> DshashclosedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_fill(s : DshashclosedLayer, v : Double) -> DshashclosedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_layer_min(s : DshashclosedLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_layer_max(s : DshashclosedLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_layer_to_string(s : DshashclosedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_buffer_make(size : Int) -> DshashclosedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_buffer_len(s : DshashclosedBuffer) -> Int { s.size }

pub fn ds_hash_closed_buffer_get(s : DshashclosedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_buffer_set(s : DshashclosedBuffer, i : Int, v : Double) -> DshashclosedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_sum(s : DshashclosedBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_buffer_mean(s : DshashclosedBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_buffer_scale(s : DshashclosedBuffer, f : Double) -> DshashclosedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_add(a : DshashclosedBuffer, b : DshashclosedBuffer) -> DshashclosedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_buffer_copy(s : DshashclosedBuffer) -> DshashclosedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_fill(s : DshashclosedBuffer, v : Double) -> DshashclosedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_buffer_min(s : DshashclosedBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_buffer_max(s : DshashclosedBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_buffer_to_string(s : DshashclosedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_cursor_make(size : Int) -> DshashclosedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_cursor_len(s : DshashclosedCursor) -> Int { s.size }

pub fn ds_hash_closed_cursor_get(s : DshashclosedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_cursor_set(s : DshashclosedCursor, i : Int, v : Double) -> DshashclosedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_sum(s : DshashclosedCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_cursor_mean(s : DshashclosedCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_cursor_scale(s : DshashclosedCursor, f : Double) -> DshashclosedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_add(a : DshashclosedCursor, b : DshashclosedCursor) -> DshashclosedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_cursor_copy(s : DshashclosedCursor) -> DshashclosedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_fill(s : DshashclosedCursor, v : Double) -> DshashclosedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_cursor_min(s : DshashclosedCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_cursor_max(s : DshashclosedCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_cursor_to_string(s : DshashclosedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_view_make(size : Int) -> DshashclosedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_view_len(s : DshashclosedView) -> Int { s.size }

pub fn ds_hash_closed_view_get(s : DshashclosedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_view_set(s : DshashclosedView, i : Int, v : Double) -> DshashclosedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_sum(s : DshashclosedView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_view_mean(s : DshashclosedView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_view_scale(s : DshashclosedView, f : Double) -> DshashclosedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_add(a : DshashclosedView, b : DshashclosedView) -> DshashclosedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_view_copy(s : DshashclosedView) -> DshashclosedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_fill(s : DshashclosedView, v : Double) -> DshashclosedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_view_min(s : DshashclosedView) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_view_max(s : DshashclosedView) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_view_to_string(s : DshashclosedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_range_make(size : Int) -> DshashclosedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_range_len(s : DshashclosedRange) -> Int { s.size }

pub fn ds_hash_closed_range_get(s : DshashclosedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_range_set(s : DshashclosedRange, i : Int, v : Double) -> DshashclosedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_sum(s : DshashclosedRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_range_mean(s : DshashclosedRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_range_scale(s : DshashclosedRange, f : Double) -> DshashclosedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_add(a : DshashclosedRange, b : DshashclosedRange) -> DshashclosedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_range_copy(s : DshashclosedRange) -> DshashclosedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_fill(s : DshashclosedRange, v : Double) -> DshashclosedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_range_min(s : DshashclosedRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_range_max(s : DshashclosedRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_range_to_string(s : DshashclosedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_slice_make(size : Int) -> DshashclosedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_slice_len(s : DshashclosedSlice) -> Int { s.size }

pub fn ds_hash_closed_slice_get(s : DshashclosedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_slice_set(s : DshashclosedSlice, i : Int, v : Double) -> DshashclosedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_sum(s : DshashclosedSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_closed_slice_mean(s : DshashclosedSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_closed_slice_scale(s : DshashclosedSlice, f : Double) -> DshashclosedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_add(a : DshashclosedSlice, b : DshashclosedSlice) -> DshashclosedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_closed_slice_copy(s : DshashclosedSlice) -> DshashclosedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_fill(s : DshashclosedSlice, v : Double) -> DshashclosedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_closed_slice_min(s : DshashclosedSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_closed_slice_max(s : DshashclosedSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_closed_slice_to_string(s : DshashclosedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

