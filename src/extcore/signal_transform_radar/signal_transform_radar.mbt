///===
/// extcore/signal_transform_radar

pub(all) struct SignaltransformradarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_radar_make_point(x : Double, y : Double) -> SignaltransformradarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_radar_make_point3(x : Double, y : Double, z : Double) -> SignaltransformradarPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformradarPoint::x(self : SignaltransformradarPoint) -> Double { self.x }

pub fn SignaltransformradarPoint::y(self : SignaltransformradarPoint) -> Double { self.y }

pub fn SignaltransformradarPoint::z(self : SignaltransformradarPoint) -> Double { self.z }

pub fn SignaltransformradarPoint::label(self : SignaltransformradarPoint) -> Int { self.label }

pub fn SignaltransformradarPoint::dist(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformradarPoint::add(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformradarPoint::sub(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformradarPoint::scale(self : SignaltransformradarPoint, s : Double) -> SignaltransformradarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformradarPoint::dot(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformradarPoint::cross(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformradarPoint::norm(self : SignaltransformradarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformradarPoint::normalize(self : SignaltransformradarPoint) -> SignaltransformradarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformradarPoint::negate(self : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformradarPoint::mid(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformradarPoint::lerp(self : SignaltransformradarPoint, other : SignaltransformradarPoint, t : Double) -> SignaltransformradarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformradarPoint::to_string(self : SignaltransformradarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformradarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_radar_make_series(vals : Array[Double], name : String) -> SignaltransformradarSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformradarSeries::len(self : SignaltransformradarSeries) -> Int { self.vals.length() }

pub fn SignaltransformradarSeries::sum(self : SignaltransformradarSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformradarSeries::mean(self : SignaltransformradarSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformradarSeries::min(self : SignaltransformradarSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformradarSeries::max(self : SignaltransformradarSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformradarSeries::range(self : SignaltransformradarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformradarSeries::variance(self : SignaltransformradarSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformradarSeries::std(self : SignaltransformradarSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformradarSeries::median(self : SignaltransformradarSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformradarSeries::scale(self : SignaltransformradarSeries, f : Double) -> SignaltransformradarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformradarSeries::add(self : SignaltransformradarSeries, other : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformradarSeries::sub(self : SignaltransformradarSeries, other : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformradarSeries::normalize(self : SignaltransformradarSeries) -> SignaltransformradarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformradarSeries::cumsum(self : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformradarSeries::to_string(self : SignaltransformradarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformradarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_radar_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformradarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_radar_matrix_identity(n : Int) -> SignaltransformradarMatrix {
  let m = signal_transform_radar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformradarMatrix::get(self : SignaltransformradarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformradarMatrix::transpose(self : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  let result = signal_transform_radar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformradarMatrix::add(self : SignaltransformradarMatrix, other : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_radar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformradarMatrix::scale(self : SignaltransformradarMatrix, s : Double) -> SignaltransformradarMatrix {
  let result = signal_transform_radar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformradarMatrix::multiply(self : SignaltransformradarMatrix, other : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  if self.cols != other.rows { return signal_transform_radar_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_radar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformradarMatrix::trace(self : SignaltransformradarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformradarMatrix::det(self : SignaltransformradarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformradarMatrix::norm(self : SignaltransformradarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformradarMatrix::to_string(self : SignaltransformradarMatrix) -> String {
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

pub(all) struct SignaltransformradarVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_radar_make_vector(comps : Array[Double]) -> SignaltransformradarVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_radar_vector_zero(dim : Int) -> SignaltransformradarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformradarVector::add(self : SignaltransformradarVector, other : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformradarVector::sub(self : SignaltransformradarVector, other : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformradarVector::scale(self : SignaltransformradarVector, s : Double) -> SignaltransformradarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformradarVector::dot(self : SignaltransformradarVector, other : SignaltransformradarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformradarVector::norm(self : SignaltransformradarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformradarVector::normalize(self : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformradarVector::dist(self : SignaltransformradarVector, other : SignaltransformradarVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformradarVector::to_string(self : SignaltransformradarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_radar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_radar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_radar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_radar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_radar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_radar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_radar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_radar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_radar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_radar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_radar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_radar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_radar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_radar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_radar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_radar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_radar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_radar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_radar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_radar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_radar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_radar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_radar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_radar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_radar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_radar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_radar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_radar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_radar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformradarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_frame_make(size : Int) -> SignaltransformradarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_frame_len(s : SignaltransformradarFrame) -> Int { s.size }

pub fn signal_transform_radar_frame_get(s : SignaltransformradarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_frame_set(s : SignaltransformradarFrame, i : Int, v : Double) -> SignaltransformradarFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_sum(s : SignaltransformradarFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_frame_mean(s : SignaltransformradarFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_frame_scale(s : SignaltransformradarFrame, f : Double) -> SignaltransformradarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_add(a : SignaltransformradarFrame, b : SignaltransformradarFrame) -> SignaltransformradarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_frame_copy(s : SignaltransformradarFrame) -> SignaltransformradarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_fill(s : SignaltransformradarFrame, v : Double) -> SignaltransformradarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_frame_min(s : SignaltransformradarFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_frame_max(s : SignaltransformradarFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_frame_to_string(s : SignaltransformradarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_table_make(size : Int) -> SignaltransformradarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_table_len(s : SignaltransformradarTable) -> Int { s.size }

pub fn signal_transform_radar_table_get(s : SignaltransformradarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_table_set(s : SignaltransformradarTable, i : Int, v : Double) -> SignaltransformradarTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_sum(s : SignaltransformradarTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_table_mean(s : SignaltransformradarTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_table_scale(s : SignaltransformradarTable, f : Double) -> SignaltransformradarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_add(a : SignaltransformradarTable, b : SignaltransformradarTable) -> SignaltransformradarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_table_copy(s : SignaltransformradarTable) -> SignaltransformradarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_fill(s : SignaltransformradarTable, v : Double) -> SignaltransformradarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_table_min(s : SignaltransformradarTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_table_max(s : SignaltransformradarTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_table_to_string(s : SignaltransformradarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_graphn_make(size : Int) -> SignaltransformradarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_graphn_len(s : SignaltransformradarGraphN) -> Int { s.size }

pub fn signal_transform_radar_graphn_get(s : SignaltransformradarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_graphn_set(s : SignaltransformradarGraphN, i : Int, v : Double) -> SignaltransformradarGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_sum(s : SignaltransformradarGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_graphn_mean(s : SignaltransformradarGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_graphn_scale(s : SignaltransformradarGraphN, f : Double) -> SignaltransformradarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_add(a : SignaltransformradarGraphN, b : SignaltransformradarGraphN) -> SignaltransformradarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_graphn_copy(s : SignaltransformradarGraphN) -> SignaltransformradarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_fill(s : SignaltransformradarGraphN, v : Double) -> SignaltransformradarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_graphn_min(s : SignaltransformradarGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_graphn_max(s : SignaltransformradarGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_graphn_to_string(s : SignaltransformradarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_node_make(size : Int) -> SignaltransformradarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_node_len(s : SignaltransformradarNode) -> Int { s.size }

pub fn signal_transform_radar_node_get(s : SignaltransformradarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_node_set(s : SignaltransformradarNode, i : Int, v : Double) -> SignaltransformradarNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_sum(s : SignaltransformradarNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_node_mean(s : SignaltransformradarNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_node_scale(s : SignaltransformradarNode, f : Double) -> SignaltransformradarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_add(a : SignaltransformradarNode, b : SignaltransformradarNode) -> SignaltransformradarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_node_copy(s : SignaltransformradarNode) -> SignaltransformradarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_fill(s : SignaltransformradarNode, v : Double) -> SignaltransformradarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_node_min(s : SignaltransformradarNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_node_max(s : SignaltransformradarNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_node_to_string(s : SignaltransformradarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_edge_make(size : Int) -> SignaltransformradarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_edge_len(s : SignaltransformradarEdge) -> Int { s.size }

pub fn signal_transform_radar_edge_get(s : SignaltransformradarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_edge_set(s : SignaltransformradarEdge, i : Int, v : Double) -> SignaltransformradarEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_sum(s : SignaltransformradarEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_edge_mean(s : SignaltransformradarEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_edge_scale(s : SignaltransformradarEdge, f : Double) -> SignaltransformradarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_add(a : SignaltransformradarEdge, b : SignaltransformradarEdge) -> SignaltransformradarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_edge_copy(s : SignaltransformradarEdge) -> SignaltransformradarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_fill(s : SignaltransformradarEdge, v : Double) -> SignaltransformradarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_edge_min(s : SignaltransformradarEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_edge_max(s : SignaltransformradarEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_edge_to_string(s : SignaltransformradarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_path_make(size : Int) -> SignaltransformradarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_path_len(s : SignaltransformradarPath) -> Int { s.size }

pub fn signal_transform_radar_path_get(s : SignaltransformradarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_path_set(s : SignaltransformradarPath, i : Int, v : Double) -> SignaltransformradarPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_sum(s : SignaltransformradarPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_path_mean(s : SignaltransformradarPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_path_scale(s : SignaltransformradarPath, f : Double) -> SignaltransformradarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_add(a : SignaltransformradarPath, b : SignaltransformradarPath) -> SignaltransformradarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_path_copy(s : SignaltransformradarPath) -> SignaltransformradarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_fill(s : SignaltransformradarPath, v : Double) -> SignaltransformradarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_path_min(s : SignaltransformradarPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_path_max(s : SignaltransformradarPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_path_to_string(s : SignaltransformradarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_cluster_make(size : Int) -> SignaltransformradarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_cluster_len(s : SignaltransformradarCluster) -> Int { s.size }

pub fn signal_transform_radar_cluster_get(s : SignaltransformradarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_cluster_set(s : SignaltransformradarCluster, i : Int, v : Double) -> SignaltransformradarCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_sum(s : SignaltransformradarCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_cluster_mean(s : SignaltransformradarCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_cluster_scale(s : SignaltransformradarCluster, f : Double) -> SignaltransformradarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_add(a : SignaltransformradarCluster, b : SignaltransformradarCluster) -> SignaltransformradarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_cluster_copy(s : SignaltransformradarCluster) -> SignaltransformradarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_fill(s : SignaltransformradarCluster, v : Double) -> SignaltransformradarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cluster_min(s : SignaltransformradarCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_cluster_max(s : SignaltransformradarCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_cluster_to_string(s : SignaltransformradarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_model_make(size : Int) -> SignaltransformradarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_model_len(s : SignaltransformradarModel) -> Int { s.size }

pub fn signal_transform_radar_model_get(s : SignaltransformradarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_model_set(s : SignaltransformradarModel, i : Int, v : Double) -> SignaltransformradarModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_sum(s : SignaltransformradarModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_model_mean(s : SignaltransformradarModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_model_scale(s : SignaltransformradarModel, f : Double) -> SignaltransformradarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_add(a : SignaltransformradarModel, b : SignaltransformradarModel) -> SignaltransformradarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_model_copy(s : SignaltransformradarModel) -> SignaltransformradarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_fill(s : SignaltransformradarModel, v : Double) -> SignaltransformradarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_model_min(s : SignaltransformradarModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_model_max(s : SignaltransformradarModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_model_to_string(s : SignaltransformradarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_layer_make(size : Int) -> SignaltransformradarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_layer_len(s : SignaltransformradarLayer) -> Int { s.size }

pub fn signal_transform_radar_layer_get(s : SignaltransformradarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_layer_set(s : SignaltransformradarLayer, i : Int, v : Double) -> SignaltransformradarLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_sum(s : SignaltransformradarLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_layer_mean(s : SignaltransformradarLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_layer_scale(s : SignaltransformradarLayer, f : Double) -> SignaltransformradarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_add(a : SignaltransformradarLayer, b : SignaltransformradarLayer) -> SignaltransformradarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_layer_copy(s : SignaltransformradarLayer) -> SignaltransformradarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_fill(s : SignaltransformradarLayer, v : Double) -> SignaltransformradarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_layer_min(s : SignaltransformradarLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_layer_max(s : SignaltransformradarLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_layer_to_string(s : SignaltransformradarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_buffer_make(size : Int) -> SignaltransformradarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_buffer_len(s : SignaltransformradarBuffer) -> Int { s.size }

pub fn signal_transform_radar_buffer_get(s : SignaltransformradarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_buffer_set(s : SignaltransformradarBuffer, i : Int, v : Double) -> SignaltransformradarBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_sum(s : SignaltransformradarBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_buffer_mean(s : SignaltransformradarBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_buffer_scale(s : SignaltransformradarBuffer, f : Double) -> SignaltransformradarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_add(a : SignaltransformradarBuffer, b : SignaltransformradarBuffer) -> SignaltransformradarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_buffer_copy(s : SignaltransformradarBuffer) -> SignaltransformradarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_fill(s : SignaltransformradarBuffer, v : Double) -> SignaltransformradarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_buffer_min(s : SignaltransformradarBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_buffer_max(s : SignaltransformradarBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_buffer_to_string(s : SignaltransformradarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_cursor_make(size : Int) -> SignaltransformradarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_cursor_len(s : SignaltransformradarCursor) -> Int { s.size }

pub fn signal_transform_radar_cursor_get(s : SignaltransformradarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_cursor_set(s : SignaltransformradarCursor, i : Int, v : Double) -> SignaltransformradarCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_sum(s : SignaltransformradarCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_cursor_mean(s : SignaltransformradarCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_cursor_scale(s : SignaltransformradarCursor, f : Double) -> SignaltransformradarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_add(a : SignaltransformradarCursor, b : SignaltransformradarCursor) -> SignaltransformradarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_cursor_copy(s : SignaltransformradarCursor) -> SignaltransformradarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_fill(s : SignaltransformradarCursor, v : Double) -> SignaltransformradarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_cursor_min(s : SignaltransformradarCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_cursor_max(s : SignaltransformradarCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_cursor_to_string(s : SignaltransformradarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_view_make(size : Int) -> SignaltransformradarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_view_len(s : SignaltransformradarView) -> Int { s.size }

pub fn signal_transform_radar_view_get(s : SignaltransformradarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_view_set(s : SignaltransformradarView, i : Int, v : Double) -> SignaltransformradarView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_sum(s : SignaltransformradarView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_view_mean(s : SignaltransformradarView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_view_scale(s : SignaltransformradarView, f : Double) -> SignaltransformradarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_add(a : SignaltransformradarView, b : SignaltransformradarView) -> SignaltransformradarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_view_copy(s : SignaltransformradarView) -> SignaltransformradarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_fill(s : SignaltransformradarView, v : Double) -> SignaltransformradarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_view_min(s : SignaltransformradarView) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_view_max(s : SignaltransformradarView) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_view_to_string(s : SignaltransformradarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_range_make(size : Int) -> SignaltransformradarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_range_len(s : SignaltransformradarRange) -> Int { s.size }

pub fn signal_transform_radar_range_get(s : SignaltransformradarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_range_set(s : SignaltransformradarRange, i : Int, v : Double) -> SignaltransformradarRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_sum(s : SignaltransformradarRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_range_mean(s : SignaltransformradarRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_range_scale(s : SignaltransformradarRange, f : Double) -> SignaltransformradarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_add(a : SignaltransformradarRange, b : SignaltransformradarRange) -> SignaltransformradarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_range_copy(s : SignaltransformradarRange) -> SignaltransformradarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_fill(s : SignaltransformradarRange, v : Double) -> SignaltransformradarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_range_min(s : SignaltransformradarRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_range_max(s : SignaltransformradarRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_range_to_string(s : SignaltransformradarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_slice_make(size : Int) -> SignaltransformradarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_radar_slice_len(s : SignaltransformradarSlice) -> Int { s.size }

pub fn signal_transform_radar_slice_get(s : SignaltransformradarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_radar_slice_set(s : SignaltransformradarSlice, i : Int, v : Double) -> SignaltransformradarSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_sum(s : SignaltransformradarSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_radar_slice_mean(s : SignaltransformradarSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_radar_slice_scale(s : SignaltransformradarSlice, f : Double) -> SignaltransformradarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_add(a : SignaltransformradarSlice, b : SignaltransformradarSlice) -> SignaltransformradarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_radar_slice_copy(s : SignaltransformradarSlice) -> SignaltransformradarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_fill(s : SignaltransformradarSlice, v : Double) -> SignaltransformradarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_radar_slice_min(s : SignaltransformradarSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_radar_slice_max(s : SignaltransformradarSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_radar_slice_to_string(s : SignaltransformradarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

