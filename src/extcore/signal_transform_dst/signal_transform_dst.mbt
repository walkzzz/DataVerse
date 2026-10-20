///===
/// extcore/signal_transform_dst

pub(all) struct SignaltransformdstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dst_make_point(x : Double, y : Double) -> SignaltransformdstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dst_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdstPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformdstPoint::x(self : SignaltransformdstPoint) -> Double { self.x }

pub fn SignaltransformdstPoint::y(self : SignaltransformdstPoint) -> Double { self.y }

pub fn SignaltransformdstPoint::z(self : SignaltransformdstPoint) -> Double { self.z }

pub fn SignaltransformdstPoint::label(self : SignaltransformdstPoint) -> Int { self.label }

pub fn SignaltransformdstPoint::dist(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformdstPoint::add(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformdstPoint::sub(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformdstPoint::scale(self : SignaltransformdstPoint, s : Double) -> SignaltransformdstPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformdstPoint::dot(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformdstPoint::cross(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformdstPoint::norm(self : SignaltransformdstPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformdstPoint::normalize(self : SignaltransformdstPoint) -> SignaltransformdstPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdstPoint::negate(self : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformdstPoint::mid(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformdstPoint::lerp(self : SignaltransformdstPoint, other : SignaltransformdstPoint, t : Double) -> SignaltransformdstPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformdstPoint::to_string(self : SignaltransformdstPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformdstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dst_make_series(vals : Array[Double], name : String) -> SignaltransformdstSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformdstSeries::len(self : SignaltransformdstSeries) -> Int { self.vals.length() }

pub fn SignaltransformdstSeries::sum(self : SignaltransformdstSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformdstSeries::mean(self : SignaltransformdstSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformdstSeries::min(self : SignaltransformdstSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformdstSeries::max(self : SignaltransformdstSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformdstSeries::range(self : SignaltransformdstSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformdstSeries::variance(self : SignaltransformdstSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformdstSeries::std(self : SignaltransformdstSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformdstSeries::median(self : SignaltransformdstSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformdstSeries::scale(self : SignaltransformdstSeries, f : Double) -> SignaltransformdstSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformdstSeries::add(self : SignaltransformdstSeries, other : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformdstSeries::sub(self : SignaltransformdstSeries, other : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformdstSeries::normalize(self : SignaltransformdstSeries) -> SignaltransformdstSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformdstSeries::cumsum(self : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformdstSeries::to_string(self : SignaltransformdstSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dst_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dst_matrix_identity(n : Int) -> SignaltransformdstMatrix {
  let m = signal_transform_dst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformdstMatrix::get(self : SignaltransformdstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformdstMatrix::transpose(self : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  let result = signal_transform_dst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformdstMatrix::add(self : SignaltransformdstMatrix, other : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_dst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformdstMatrix::scale(self : SignaltransformdstMatrix, s : Double) -> SignaltransformdstMatrix {
  let result = signal_transform_dst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformdstMatrix::multiply(self : SignaltransformdstMatrix, other : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  if self.cols != other.rows { return signal_transform_dst_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_dst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformdstMatrix::trace(self : SignaltransformdstMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformdstMatrix::det(self : SignaltransformdstMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformdstMatrix::norm(self : SignaltransformdstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformdstMatrix::to_string(self : SignaltransformdstMatrix) -> String {
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

pub(all) struct SignaltransformdstVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dst_make_vector(comps : Array[Double]) -> SignaltransformdstVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dst_vector_zero(dim : Int) -> SignaltransformdstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformdstVector::add(self : SignaltransformdstVector, other : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdstVector::sub(self : SignaltransformdstVector, other : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdstVector::scale(self : SignaltransformdstVector, s : Double) -> SignaltransformdstVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformdstVector::dot(self : SignaltransformdstVector, other : SignaltransformdstVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformdstVector::norm(self : SignaltransformdstVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformdstVector::normalize(self : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdstVector::dist(self : SignaltransformdstVector, other : SignaltransformdstVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformdstVector::to_string(self : SignaltransformdstVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_dst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_dst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_dst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_dst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_dst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_dst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_dst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_dst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_dst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_dst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_dst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_dst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_dst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_dst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_dst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_dst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_dst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_dst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_dst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_dst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_dst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_dst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_dst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_dst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_dst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_dst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_dst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_dst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformdstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_frame_make(size : Int) -> SignaltransformdstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_frame_len(s : SignaltransformdstFrame) -> Int { s.size }

pub fn signal_transform_dst_frame_get(s : SignaltransformdstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_frame_set(s : SignaltransformdstFrame, i : Int, v : Double) -> SignaltransformdstFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_sum(s : SignaltransformdstFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_frame_mean(s : SignaltransformdstFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_frame_scale(s : SignaltransformdstFrame, f : Double) -> SignaltransformdstFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_add(a : SignaltransformdstFrame, b : SignaltransformdstFrame) -> SignaltransformdstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_frame_copy(s : SignaltransformdstFrame) -> SignaltransformdstFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_fill(s : SignaltransformdstFrame, v : Double) -> SignaltransformdstFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_min(s : SignaltransformdstFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_frame_max(s : SignaltransformdstFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_frame_to_string(s : SignaltransformdstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_table_make(size : Int) -> SignaltransformdstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_table_len(s : SignaltransformdstTable) -> Int { s.size }

pub fn signal_transform_dst_table_get(s : SignaltransformdstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_table_set(s : SignaltransformdstTable, i : Int, v : Double) -> SignaltransformdstTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_sum(s : SignaltransformdstTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_table_mean(s : SignaltransformdstTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_table_scale(s : SignaltransformdstTable, f : Double) -> SignaltransformdstTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_add(a : SignaltransformdstTable, b : SignaltransformdstTable) -> SignaltransformdstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_table_copy(s : SignaltransformdstTable) -> SignaltransformdstTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_fill(s : SignaltransformdstTable, v : Double) -> SignaltransformdstTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_min(s : SignaltransformdstTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_table_max(s : SignaltransformdstTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_table_to_string(s : SignaltransformdstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_graphn_make(size : Int) -> SignaltransformdstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_graphn_len(s : SignaltransformdstGraphN) -> Int { s.size }

pub fn signal_transform_dst_graphn_get(s : SignaltransformdstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_graphn_set(s : SignaltransformdstGraphN, i : Int, v : Double) -> SignaltransformdstGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_sum(s : SignaltransformdstGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_graphn_mean(s : SignaltransformdstGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_graphn_scale(s : SignaltransformdstGraphN, f : Double) -> SignaltransformdstGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_add(a : SignaltransformdstGraphN, b : SignaltransformdstGraphN) -> SignaltransformdstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_graphn_copy(s : SignaltransformdstGraphN) -> SignaltransformdstGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_fill(s : SignaltransformdstGraphN, v : Double) -> SignaltransformdstGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_min(s : SignaltransformdstGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_graphn_max(s : SignaltransformdstGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_graphn_to_string(s : SignaltransformdstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_node_make(size : Int) -> SignaltransformdstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_node_len(s : SignaltransformdstNode) -> Int { s.size }

pub fn signal_transform_dst_node_get(s : SignaltransformdstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_node_set(s : SignaltransformdstNode, i : Int, v : Double) -> SignaltransformdstNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_sum(s : SignaltransformdstNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_node_mean(s : SignaltransformdstNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_node_scale(s : SignaltransformdstNode, f : Double) -> SignaltransformdstNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_add(a : SignaltransformdstNode, b : SignaltransformdstNode) -> SignaltransformdstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_node_copy(s : SignaltransformdstNode) -> SignaltransformdstNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_fill(s : SignaltransformdstNode, v : Double) -> SignaltransformdstNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_min(s : SignaltransformdstNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_node_max(s : SignaltransformdstNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_node_to_string(s : SignaltransformdstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_edge_make(size : Int) -> SignaltransformdstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_edge_len(s : SignaltransformdstEdge) -> Int { s.size }

pub fn signal_transform_dst_edge_get(s : SignaltransformdstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_edge_set(s : SignaltransformdstEdge, i : Int, v : Double) -> SignaltransformdstEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_sum(s : SignaltransformdstEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_edge_mean(s : SignaltransformdstEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_edge_scale(s : SignaltransformdstEdge, f : Double) -> SignaltransformdstEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_add(a : SignaltransformdstEdge, b : SignaltransformdstEdge) -> SignaltransformdstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_edge_copy(s : SignaltransformdstEdge) -> SignaltransformdstEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_fill(s : SignaltransformdstEdge, v : Double) -> SignaltransformdstEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_min(s : SignaltransformdstEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_edge_max(s : SignaltransformdstEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_edge_to_string(s : SignaltransformdstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_path_make(size : Int) -> SignaltransformdstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_path_len(s : SignaltransformdstPath) -> Int { s.size }

pub fn signal_transform_dst_path_get(s : SignaltransformdstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_path_set(s : SignaltransformdstPath, i : Int, v : Double) -> SignaltransformdstPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_sum(s : SignaltransformdstPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_path_mean(s : SignaltransformdstPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_path_scale(s : SignaltransformdstPath, f : Double) -> SignaltransformdstPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_add(a : SignaltransformdstPath, b : SignaltransformdstPath) -> SignaltransformdstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_path_copy(s : SignaltransformdstPath) -> SignaltransformdstPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_fill(s : SignaltransformdstPath, v : Double) -> SignaltransformdstPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_min(s : SignaltransformdstPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_path_max(s : SignaltransformdstPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_path_to_string(s : SignaltransformdstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_cluster_make(size : Int) -> SignaltransformdstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_cluster_len(s : SignaltransformdstCluster) -> Int { s.size }

pub fn signal_transform_dst_cluster_get(s : SignaltransformdstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_cluster_set(s : SignaltransformdstCluster, i : Int, v : Double) -> SignaltransformdstCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_sum(s : SignaltransformdstCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_cluster_mean(s : SignaltransformdstCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_cluster_scale(s : SignaltransformdstCluster, f : Double) -> SignaltransformdstCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_add(a : SignaltransformdstCluster, b : SignaltransformdstCluster) -> SignaltransformdstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_cluster_copy(s : SignaltransformdstCluster) -> SignaltransformdstCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_fill(s : SignaltransformdstCluster, v : Double) -> SignaltransformdstCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_min(s : SignaltransformdstCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_cluster_max(s : SignaltransformdstCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_cluster_to_string(s : SignaltransformdstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_model_make(size : Int) -> SignaltransformdstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_model_len(s : SignaltransformdstModel) -> Int { s.size }

pub fn signal_transform_dst_model_get(s : SignaltransformdstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_model_set(s : SignaltransformdstModel, i : Int, v : Double) -> SignaltransformdstModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_sum(s : SignaltransformdstModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_model_mean(s : SignaltransformdstModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_model_scale(s : SignaltransformdstModel, f : Double) -> SignaltransformdstModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_add(a : SignaltransformdstModel, b : SignaltransformdstModel) -> SignaltransformdstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_model_copy(s : SignaltransformdstModel) -> SignaltransformdstModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_fill(s : SignaltransformdstModel, v : Double) -> SignaltransformdstModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_min(s : SignaltransformdstModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_model_max(s : SignaltransformdstModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_model_to_string(s : SignaltransformdstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_layer_make(size : Int) -> SignaltransformdstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_layer_len(s : SignaltransformdstLayer) -> Int { s.size }

pub fn signal_transform_dst_layer_get(s : SignaltransformdstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_layer_set(s : SignaltransformdstLayer, i : Int, v : Double) -> SignaltransformdstLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_sum(s : SignaltransformdstLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_layer_mean(s : SignaltransformdstLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_layer_scale(s : SignaltransformdstLayer, f : Double) -> SignaltransformdstLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_add(a : SignaltransformdstLayer, b : SignaltransformdstLayer) -> SignaltransformdstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_layer_copy(s : SignaltransformdstLayer) -> SignaltransformdstLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_fill(s : SignaltransformdstLayer, v : Double) -> SignaltransformdstLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_min(s : SignaltransformdstLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_layer_max(s : SignaltransformdstLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_layer_to_string(s : SignaltransformdstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_buffer_make(size : Int) -> SignaltransformdstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_buffer_len(s : SignaltransformdstBuffer) -> Int { s.size }

pub fn signal_transform_dst_buffer_get(s : SignaltransformdstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_buffer_set(s : SignaltransformdstBuffer, i : Int, v : Double) -> SignaltransformdstBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_sum(s : SignaltransformdstBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_buffer_mean(s : SignaltransformdstBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_buffer_scale(s : SignaltransformdstBuffer, f : Double) -> SignaltransformdstBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_add(a : SignaltransformdstBuffer, b : SignaltransformdstBuffer) -> SignaltransformdstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_buffer_copy(s : SignaltransformdstBuffer) -> SignaltransformdstBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_fill(s : SignaltransformdstBuffer, v : Double) -> SignaltransformdstBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_min(s : SignaltransformdstBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_buffer_max(s : SignaltransformdstBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_buffer_to_string(s : SignaltransformdstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_cursor_make(size : Int) -> SignaltransformdstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_cursor_len(s : SignaltransformdstCursor) -> Int { s.size }

pub fn signal_transform_dst_cursor_get(s : SignaltransformdstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_cursor_set(s : SignaltransformdstCursor, i : Int, v : Double) -> SignaltransformdstCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_sum(s : SignaltransformdstCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_cursor_mean(s : SignaltransformdstCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_cursor_scale(s : SignaltransformdstCursor, f : Double) -> SignaltransformdstCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_add(a : SignaltransformdstCursor, b : SignaltransformdstCursor) -> SignaltransformdstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_cursor_copy(s : SignaltransformdstCursor) -> SignaltransformdstCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_fill(s : SignaltransformdstCursor, v : Double) -> SignaltransformdstCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_min(s : SignaltransformdstCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_cursor_max(s : SignaltransformdstCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_cursor_to_string(s : SignaltransformdstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_view_make(size : Int) -> SignaltransformdstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_view_len(s : SignaltransformdstView) -> Int { s.size }

pub fn signal_transform_dst_view_get(s : SignaltransformdstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_view_set(s : SignaltransformdstView, i : Int, v : Double) -> SignaltransformdstView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_sum(s : SignaltransformdstView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_view_mean(s : SignaltransformdstView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_view_scale(s : SignaltransformdstView, f : Double) -> SignaltransformdstView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_add(a : SignaltransformdstView, b : SignaltransformdstView) -> SignaltransformdstView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_view_copy(s : SignaltransformdstView) -> SignaltransformdstView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_fill(s : SignaltransformdstView, v : Double) -> SignaltransformdstView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_min(s : SignaltransformdstView) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_view_max(s : SignaltransformdstView) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_view_to_string(s : SignaltransformdstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_range_make(size : Int) -> SignaltransformdstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_range_len(s : SignaltransformdstRange) -> Int { s.size }

pub fn signal_transform_dst_range_get(s : SignaltransformdstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_range_set(s : SignaltransformdstRange, i : Int, v : Double) -> SignaltransformdstRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_sum(s : SignaltransformdstRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_range_mean(s : SignaltransformdstRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_range_scale(s : SignaltransformdstRange, f : Double) -> SignaltransformdstRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_add(a : SignaltransformdstRange, b : SignaltransformdstRange) -> SignaltransformdstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_range_copy(s : SignaltransformdstRange) -> SignaltransformdstRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_fill(s : SignaltransformdstRange, v : Double) -> SignaltransformdstRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_min(s : SignaltransformdstRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_range_max(s : SignaltransformdstRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_range_to_string(s : SignaltransformdstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_slice_make(size : Int) -> SignaltransformdstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_slice_len(s : SignaltransformdstSlice) -> Int { s.size }

pub fn signal_transform_dst_slice_get(s : SignaltransformdstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_slice_set(s : SignaltransformdstSlice, i : Int, v : Double) -> SignaltransformdstSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_sum(s : SignaltransformdstSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_slice_mean(s : SignaltransformdstSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_slice_scale(s : SignaltransformdstSlice, f : Double) -> SignaltransformdstSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_add(a : SignaltransformdstSlice, b : SignaltransformdstSlice) -> SignaltransformdstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_slice_copy(s : SignaltransformdstSlice) -> SignaltransformdstSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_fill(s : SignaltransformdstSlice, v : Double) -> SignaltransformdstSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_min(s : SignaltransformdstSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_slice_max(s : SignaltransformdstSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_slice_to_string(s : SignaltransformdstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

