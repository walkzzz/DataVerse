///===
/// extcore/signal_spec_modified

pub(all) struct SignalspecmodifiedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_modified_make_point(x : Double, y : Double) -> SignalspecmodifiedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_modified_make_point3(x : Double, y : Double, z : Double) -> SignalspecmodifiedPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecmodifiedPoint::x(self : SignalspecmodifiedPoint) -> Double { self.x }

pub fn SignalspecmodifiedPoint::y(self : SignalspecmodifiedPoint) -> Double { self.y }

pub fn SignalspecmodifiedPoint::z(self : SignalspecmodifiedPoint) -> Double { self.z }

pub fn SignalspecmodifiedPoint::label(self : SignalspecmodifiedPoint) -> Int { self.label }

pub fn SignalspecmodifiedPoint::dist(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecmodifiedPoint::add(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecmodifiedPoint::sub(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecmodifiedPoint::scale(self : SignalspecmodifiedPoint, s : Double) -> SignalspecmodifiedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecmodifiedPoint::dot(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecmodifiedPoint::cross(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecmodifiedPoint::norm(self : SignalspecmodifiedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecmodifiedPoint::normalize(self : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecmodifiedPoint::negate(self : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecmodifiedPoint::mid(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecmodifiedPoint::lerp(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint, t : Double) -> SignalspecmodifiedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecmodifiedPoint::to_string(self : SignalspecmodifiedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecmodifiedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_modified_make_series(vals : Array[Double], name : String) -> SignalspecmodifiedSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecmodifiedSeries::len(self : SignalspecmodifiedSeries) -> Int { self.vals.length() }

pub fn SignalspecmodifiedSeries::sum(self : SignalspecmodifiedSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecmodifiedSeries::mean(self : SignalspecmodifiedSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecmodifiedSeries::min(self : SignalspecmodifiedSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecmodifiedSeries::max(self : SignalspecmodifiedSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecmodifiedSeries::range(self : SignalspecmodifiedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecmodifiedSeries::variance(self : SignalspecmodifiedSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecmodifiedSeries::std(self : SignalspecmodifiedSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecmodifiedSeries::median(self : SignalspecmodifiedSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecmodifiedSeries::scale(self : SignalspecmodifiedSeries, f : Double) -> SignalspecmodifiedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecmodifiedSeries::add(self : SignalspecmodifiedSeries, other : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecmodifiedSeries::sub(self : SignalspecmodifiedSeries, other : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecmodifiedSeries::normalize(self : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecmodifiedSeries::cumsum(self : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecmodifiedSeries::to_string(self : SignalspecmodifiedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecmodifiedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_modified_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecmodifiedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_modified_matrix_identity(n : Int) -> SignalspecmodifiedMatrix {
  let m = signal_spec_modified_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecmodifiedMatrix::get(self : SignalspecmodifiedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecmodifiedMatrix::transpose(self : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  let result = signal_spec_modified_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecmodifiedMatrix::add(self : SignalspecmodifiedMatrix, other : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_modified_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecmodifiedMatrix::scale(self : SignalspecmodifiedMatrix, s : Double) -> SignalspecmodifiedMatrix {
  let result = signal_spec_modified_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecmodifiedMatrix::multiply(self : SignalspecmodifiedMatrix, other : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  if self.cols != other.rows { return signal_spec_modified_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_modified_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecmodifiedMatrix::trace(self : SignalspecmodifiedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecmodifiedMatrix::det(self : SignalspecmodifiedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecmodifiedMatrix::norm(self : SignalspecmodifiedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecmodifiedMatrix::to_string(self : SignalspecmodifiedMatrix) -> String {
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

pub(all) struct SignalspecmodifiedVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_modified_make_vector(comps : Array[Double]) -> SignalspecmodifiedVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_modified_vector_zero(dim : Int) -> SignalspecmodifiedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecmodifiedVector::add(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecmodifiedVector::sub(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecmodifiedVector::scale(self : SignalspecmodifiedVector, s : Double) -> SignalspecmodifiedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecmodifiedVector::dot(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecmodifiedVector::norm(self : SignalspecmodifiedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecmodifiedVector::normalize(self : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecmodifiedVector::dist(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecmodifiedVector::to_string(self : SignalspecmodifiedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_modified_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_modified_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_modified_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_modified_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_modified_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_modified_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_modified_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_modified_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_modified_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_modified_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_modified_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_modified_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_modified_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_modified_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_modified_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_modified_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_modified_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_modified_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_modified_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_modified_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_modified_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_modified_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_modified_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_modified_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_modified_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_modified_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_modified_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_modified_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_modified_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecmodifiedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_frame_make(size : Int) -> SignalspecmodifiedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_frame_len(s : SignalspecmodifiedFrame) -> Int { s.size }

pub fn signal_spec_modified_frame_get(s : SignalspecmodifiedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_frame_set(s : SignalspecmodifiedFrame, i : Int, v : Double) -> SignalspecmodifiedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_sum(s : SignalspecmodifiedFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_frame_mean(s : SignalspecmodifiedFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_frame_scale(s : SignalspecmodifiedFrame, f : Double) -> SignalspecmodifiedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_add(a : SignalspecmodifiedFrame, b : SignalspecmodifiedFrame) -> SignalspecmodifiedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_frame_copy(s : SignalspecmodifiedFrame) -> SignalspecmodifiedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_fill(s : SignalspecmodifiedFrame, v : Double) -> SignalspecmodifiedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_frame_min(s : SignalspecmodifiedFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_frame_max(s : SignalspecmodifiedFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_frame_to_string(s : SignalspecmodifiedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_table_make(size : Int) -> SignalspecmodifiedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_table_len(s : SignalspecmodifiedTable) -> Int { s.size }

pub fn signal_spec_modified_table_get(s : SignalspecmodifiedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_table_set(s : SignalspecmodifiedTable, i : Int, v : Double) -> SignalspecmodifiedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_sum(s : SignalspecmodifiedTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_table_mean(s : SignalspecmodifiedTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_table_scale(s : SignalspecmodifiedTable, f : Double) -> SignalspecmodifiedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_add(a : SignalspecmodifiedTable, b : SignalspecmodifiedTable) -> SignalspecmodifiedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_table_copy(s : SignalspecmodifiedTable) -> SignalspecmodifiedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_fill(s : SignalspecmodifiedTable, v : Double) -> SignalspecmodifiedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_table_min(s : SignalspecmodifiedTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_table_max(s : SignalspecmodifiedTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_table_to_string(s : SignalspecmodifiedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_graphn_make(size : Int) -> SignalspecmodifiedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_graphn_len(s : SignalspecmodifiedGraphN) -> Int { s.size }

pub fn signal_spec_modified_graphn_get(s : SignalspecmodifiedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_graphn_set(s : SignalspecmodifiedGraphN, i : Int, v : Double) -> SignalspecmodifiedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_sum(s : SignalspecmodifiedGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_graphn_mean(s : SignalspecmodifiedGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_graphn_scale(s : SignalspecmodifiedGraphN, f : Double) -> SignalspecmodifiedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_add(a : SignalspecmodifiedGraphN, b : SignalspecmodifiedGraphN) -> SignalspecmodifiedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_graphn_copy(s : SignalspecmodifiedGraphN) -> SignalspecmodifiedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_fill(s : SignalspecmodifiedGraphN, v : Double) -> SignalspecmodifiedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_graphn_min(s : SignalspecmodifiedGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_graphn_max(s : SignalspecmodifiedGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_graphn_to_string(s : SignalspecmodifiedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_node_make(size : Int) -> SignalspecmodifiedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_node_len(s : SignalspecmodifiedNode) -> Int { s.size }

pub fn signal_spec_modified_node_get(s : SignalspecmodifiedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_node_set(s : SignalspecmodifiedNode, i : Int, v : Double) -> SignalspecmodifiedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_sum(s : SignalspecmodifiedNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_node_mean(s : SignalspecmodifiedNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_node_scale(s : SignalspecmodifiedNode, f : Double) -> SignalspecmodifiedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_add(a : SignalspecmodifiedNode, b : SignalspecmodifiedNode) -> SignalspecmodifiedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_node_copy(s : SignalspecmodifiedNode) -> SignalspecmodifiedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_fill(s : SignalspecmodifiedNode, v : Double) -> SignalspecmodifiedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_node_min(s : SignalspecmodifiedNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_node_max(s : SignalspecmodifiedNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_node_to_string(s : SignalspecmodifiedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_edge_make(size : Int) -> SignalspecmodifiedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_edge_len(s : SignalspecmodifiedEdge) -> Int { s.size }

pub fn signal_spec_modified_edge_get(s : SignalspecmodifiedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_edge_set(s : SignalspecmodifiedEdge, i : Int, v : Double) -> SignalspecmodifiedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_sum(s : SignalspecmodifiedEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_edge_mean(s : SignalspecmodifiedEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_edge_scale(s : SignalspecmodifiedEdge, f : Double) -> SignalspecmodifiedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_add(a : SignalspecmodifiedEdge, b : SignalspecmodifiedEdge) -> SignalspecmodifiedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_edge_copy(s : SignalspecmodifiedEdge) -> SignalspecmodifiedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_fill(s : SignalspecmodifiedEdge, v : Double) -> SignalspecmodifiedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_edge_min(s : SignalspecmodifiedEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_edge_max(s : SignalspecmodifiedEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_edge_to_string(s : SignalspecmodifiedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_path_make(size : Int) -> SignalspecmodifiedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_path_len(s : SignalspecmodifiedPath) -> Int { s.size }

pub fn signal_spec_modified_path_get(s : SignalspecmodifiedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_path_set(s : SignalspecmodifiedPath, i : Int, v : Double) -> SignalspecmodifiedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_sum(s : SignalspecmodifiedPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_path_mean(s : SignalspecmodifiedPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_path_scale(s : SignalspecmodifiedPath, f : Double) -> SignalspecmodifiedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_add(a : SignalspecmodifiedPath, b : SignalspecmodifiedPath) -> SignalspecmodifiedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_path_copy(s : SignalspecmodifiedPath) -> SignalspecmodifiedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_fill(s : SignalspecmodifiedPath, v : Double) -> SignalspecmodifiedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_path_min(s : SignalspecmodifiedPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_path_max(s : SignalspecmodifiedPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_path_to_string(s : SignalspecmodifiedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_cluster_make(size : Int) -> SignalspecmodifiedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_cluster_len(s : SignalspecmodifiedCluster) -> Int { s.size }

pub fn signal_spec_modified_cluster_get(s : SignalspecmodifiedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_cluster_set(s : SignalspecmodifiedCluster, i : Int, v : Double) -> SignalspecmodifiedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_sum(s : SignalspecmodifiedCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_cluster_mean(s : SignalspecmodifiedCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_cluster_scale(s : SignalspecmodifiedCluster, f : Double) -> SignalspecmodifiedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_add(a : SignalspecmodifiedCluster, b : SignalspecmodifiedCluster) -> SignalspecmodifiedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_cluster_copy(s : SignalspecmodifiedCluster) -> SignalspecmodifiedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_fill(s : SignalspecmodifiedCluster, v : Double) -> SignalspecmodifiedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cluster_min(s : SignalspecmodifiedCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_cluster_max(s : SignalspecmodifiedCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_cluster_to_string(s : SignalspecmodifiedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_model_make(size : Int) -> SignalspecmodifiedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_model_len(s : SignalspecmodifiedModel) -> Int { s.size }

pub fn signal_spec_modified_model_get(s : SignalspecmodifiedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_model_set(s : SignalspecmodifiedModel, i : Int, v : Double) -> SignalspecmodifiedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_sum(s : SignalspecmodifiedModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_model_mean(s : SignalspecmodifiedModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_model_scale(s : SignalspecmodifiedModel, f : Double) -> SignalspecmodifiedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_add(a : SignalspecmodifiedModel, b : SignalspecmodifiedModel) -> SignalspecmodifiedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_model_copy(s : SignalspecmodifiedModel) -> SignalspecmodifiedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_fill(s : SignalspecmodifiedModel, v : Double) -> SignalspecmodifiedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_model_min(s : SignalspecmodifiedModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_model_max(s : SignalspecmodifiedModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_model_to_string(s : SignalspecmodifiedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_layer_make(size : Int) -> SignalspecmodifiedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_layer_len(s : SignalspecmodifiedLayer) -> Int { s.size }

pub fn signal_spec_modified_layer_get(s : SignalspecmodifiedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_layer_set(s : SignalspecmodifiedLayer, i : Int, v : Double) -> SignalspecmodifiedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_sum(s : SignalspecmodifiedLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_layer_mean(s : SignalspecmodifiedLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_layer_scale(s : SignalspecmodifiedLayer, f : Double) -> SignalspecmodifiedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_add(a : SignalspecmodifiedLayer, b : SignalspecmodifiedLayer) -> SignalspecmodifiedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_layer_copy(s : SignalspecmodifiedLayer) -> SignalspecmodifiedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_fill(s : SignalspecmodifiedLayer, v : Double) -> SignalspecmodifiedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_layer_min(s : SignalspecmodifiedLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_layer_max(s : SignalspecmodifiedLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_layer_to_string(s : SignalspecmodifiedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_buffer_make(size : Int) -> SignalspecmodifiedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_buffer_len(s : SignalspecmodifiedBuffer) -> Int { s.size }

pub fn signal_spec_modified_buffer_get(s : SignalspecmodifiedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_buffer_set(s : SignalspecmodifiedBuffer, i : Int, v : Double) -> SignalspecmodifiedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_sum(s : SignalspecmodifiedBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_buffer_mean(s : SignalspecmodifiedBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_buffer_scale(s : SignalspecmodifiedBuffer, f : Double) -> SignalspecmodifiedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_add(a : SignalspecmodifiedBuffer, b : SignalspecmodifiedBuffer) -> SignalspecmodifiedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_buffer_copy(s : SignalspecmodifiedBuffer) -> SignalspecmodifiedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_fill(s : SignalspecmodifiedBuffer, v : Double) -> SignalspecmodifiedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_buffer_min(s : SignalspecmodifiedBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_buffer_max(s : SignalspecmodifiedBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_buffer_to_string(s : SignalspecmodifiedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_cursor_make(size : Int) -> SignalspecmodifiedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_cursor_len(s : SignalspecmodifiedCursor) -> Int { s.size }

pub fn signal_spec_modified_cursor_get(s : SignalspecmodifiedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_cursor_set(s : SignalspecmodifiedCursor, i : Int, v : Double) -> SignalspecmodifiedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_sum(s : SignalspecmodifiedCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_cursor_mean(s : SignalspecmodifiedCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_cursor_scale(s : SignalspecmodifiedCursor, f : Double) -> SignalspecmodifiedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_add(a : SignalspecmodifiedCursor, b : SignalspecmodifiedCursor) -> SignalspecmodifiedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_cursor_copy(s : SignalspecmodifiedCursor) -> SignalspecmodifiedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_fill(s : SignalspecmodifiedCursor, v : Double) -> SignalspecmodifiedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_cursor_min(s : SignalspecmodifiedCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_cursor_max(s : SignalspecmodifiedCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_cursor_to_string(s : SignalspecmodifiedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_view_make(size : Int) -> SignalspecmodifiedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_view_len(s : SignalspecmodifiedView) -> Int { s.size }

pub fn signal_spec_modified_view_get(s : SignalspecmodifiedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_view_set(s : SignalspecmodifiedView, i : Int, v : Double) -> SignalspecmodifiedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_sum(s : SignalspecmodifiedView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_view_mean(s : SignalspecmodifiedView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_view_scale(s : SignalspecmodifiedView, f : Double) -> SignalspecmodifiedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_add(a : SignalspecmodifiedView, b : SignalspecmodifiedView) -> SignalspecmodifiedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_view_copy(s : SignalspecmodifiedView) -> SignalspecmodifiedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_fill(s : SignalspecmodifiedView, v : Double) -> SignalspecmodifiedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_view_min(s : SignalspecmodifiedView) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_view_max(s : SignalspecmodifiedView) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_view_to_string(s : SignalspecmodifiedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_range_make(size : Int) -> SignalspecmodifiedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_range_len(s : SignalspecmodifiedRange) -> Int { s.size }

pub fn signal_spec_modified_range_get(s : SignalspecmodifiedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_range_set(s : SignalspecmodifiedRange, i : Int, v : Double) -> SignalspecmodifiedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_sum(s : SignalspecmodifiedRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_range_mean(s : SignalspecmodifiedRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_range_scale(s : SignalspecmodifiedRange, f : Double) -> SignalspecmodifiedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_add(a : SignalspecmodifiedRange, b : SignalspecmodifiedRange) -> SignalspecmodifiedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_range_copy(s : SignalspecmodifiedRange) -> SignalspecmodifiedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_fill(s : SignalspecmodifiedRange, v : Double) -> SignalspecmodifiedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_range_min(s : SignalspecmodifiedRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_range_max(s : SignalspecmodifiedRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_range_to_string(s : SignalspecmodifiedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_slice_make(size : Int) -> SignalspecmodifiedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_modified_slice_len(s : SignalspecmodifiedSlice) -> Int { s.size }

pub fn signal_spec_modified_slice_get(s : SignalspecmodifiedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_modified_slice_set(s : SignalspecmodifiedSlice, i : Int, v : Double) -> SignalspecmodifiedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_sum(s : SignalspecmodifiedSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_modified_slice_mean(s : SignalspecmodifiedSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_modified_slice_scale(s : SignalspecmodifiedSlice, f : Double) -> SignalspecmodifiedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_add(a : SignalspecmodifiedSlice, b : SignalspecmodifiedSlice) -> SignalspecmodifiedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_modified_slice_copy(s : SignalspecmodifiedSlice) -> SignalspecmodifiedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_fill(s : SignalspecmodifiedSlice, v : Double) -> SignalspecmodifiedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_modified_slice_min(s : SignalspecmodifiedSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_modified_slice_max(s : SignalspecmodifiedSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_modified_slice_to_string(s : SignalspecmodifiedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

