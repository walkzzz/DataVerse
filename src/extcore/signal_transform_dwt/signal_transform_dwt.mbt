///===
/// extcore/signal_transform_dwt

pub(all) struct SignaltransformdwtPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dwt_make_point(x : Double, y : Double) -> SignaltransformdwtPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dwt_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdwtPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformdwtPoint::x(self : SignaltransformdwtPoint) -> Double { self.x }

pub fn SignaltransformdwtPoint::y(self : SignaltransformdwtPoint) -> Double { self.y }

pub fn SignaltransformdwtPoint::z(self : SignaltransformdwtPoint) -> Double { self.z }

pub fn SignaltransformdwtPoint::label(self : SignaltransformdwtPoint) -> Int { self.label }

pub fn SignaltransformdwtPoint::dist(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformdwtPoint::add(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformdwtPoint::sub(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformdwtPoint::scale(self : SignaltransformdwtPoint, s : Double) -> SignaltransformdwtPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformdwtPoint::dot(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformdwtPoint::cross(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformdwtPoint::norm(self : SignaltransformdwtPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformdwtPoint::normalize(self : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdwtPoint::negate(self : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformdwtPoint::mid(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint) -> SignaltransformdwtPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformdwtPoint::lerp(self : SignaltransformdwtPoint, other : SignaltransformdwtPoint, t : Double) -> SignaltransformdwtPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformdwtPoint::to_string(self : SignaltransformdwtPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformdwtSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dwt_make_series(vals : Array[Double], name : String) -> SignaltransformdwtSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformdwtSeries::len(self : SignaltransformdwtSeries) -> Int { self.vals.length() }

pub fn SignaltransformdwtSeries::sum(self : SignaltransformdwtSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformdwtSeries::mean(self : SignaltransformdwtSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformdwtSeries::min(self : SignaltransformdwtSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformdwtSeries::max(self : SignaltransformdwtSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformdwtSeries::range(self : SignaltransformdwtSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformdwtSeries::variance(self : SignaltransformdwtSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformdwtSeries::std(self : SignaltransformdwtSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformdwtSeries::median(self : SignaltransformdwtSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformdwtSeries::scale(self : SignaltransformdwtSeries, f : Double) -> SignaltransformdwtSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformdwtSeries::add(self : SignaltransformdwtSeries, other : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformdwtSeries::sub(self : SignaltransformdwtSeries, other : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformdwtSeries::normalize(self : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformdwtSeries::cumsum(self : SignaltransformdwtSeries) -> SignaltransformdwtSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformdwtSeries::to_string(self : SignaltransformdwtSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdwtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dwt_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdwtMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dwt_matrix_identity(n : Int) -> SignaltransformdwtMatrix {
  let m = signal_transform_dwt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformdwtMatrix::get(self : SignaltransformdwtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformdwtMatrix::transpose(self : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  let result = signal_transform_dwt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformdwtMatrix::add(self : SignaltransformdwtMatrix, other : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_dwt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformdwtMatrix::scale(self : SignaltransformdwtMatrix, s : Double) -> SignaltransformdwtMatrix {
  let result = signal_transform_dwt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformdwtMatrix::multiply(self : SignaltransformdwtMatrix, other : SignaltransformdwtMatrix) -> SignaltransformdwtMatrix {
  if self.cols != other.rows { return signal_transform_dwt_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_dwt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformdwtMatrix::trace(self : SignaltransformdwtMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformdwtMatrix::det(self : SignaltransformdwtMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformdwtMatrix::norm(self : SignaltransformdwtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformdwtMatrix::to_string(self : SignaltransformdwtMatrix) -> String {
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

pub(all) struct SignaltransformdwtVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dwt_make_vector(comps : Array[Double]) -> SignaltransformdwtVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dwt_vector_zero(dim : Int) -> SignaltransformdwtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformdwtVector::add(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdwtVector::sub(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdwtVector::scale(self : SignaltransformdwtVector, s : Double) -> SignaltransformdwtVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformdwtVector::dot(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformdwtVector::norm(self : SignaltransformdwtVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformdwtVector::normalize(self : SignaltransformdwtVector) -> SignaltransformdwtVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdwtVector::dist(self : SignaltransformdwtVector, other : SignaltransformdwtVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformdwtVector::to_string(self : SignaltransformdwtVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dwt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_dwt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_dwt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_dwt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_dwt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_dwt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_dwt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_dwt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_dwt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_dwt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_dwt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_dwt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_dwt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_dwt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_dwt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_dwt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_dwt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_dwt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_dwt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_dwt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_dwt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_dwt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_dwt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_dwt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_dwt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_dwt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_dwt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_dwt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_dwt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformdwtFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_frame_make(size : Int) -> SignaltransformdwtFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_frame_len(s : SignaltransformdwtFrame) -> Int { s.size }

pub fn signal_transform_dwt_frame_get(s : SignaltransformdwtFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_frame_set(s : SignaltransformdwtFrame, i : Int, v : Double) -> SignaltransformdwtFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_frame_sum(s : SignaltransformdwtFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_frame_mean(s : SignaltransformdwtFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_frame_scale(s : SignaltransformdwtFrame, f : Double) -> SignaltransformdwtFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_frame_add(a : SignaltransformdwtFrame, b : SignaltransformdwtFrame) -> SignaltransformdwtFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_frame_copy(s : SignaltransformdwtFrame) -> SignaltransformdwtFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_frame_fill(s : SignaltransformdwtFrame, v : Double) -> SignaltransformdwtFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_frame_min(s : SignaltransformdwtFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_frame_max(s : SignaltransformdwtFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_frame_to_string(s : SignaltransformdwtFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_table_make(size : Int) -> SignaltransformdwtTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_table_len(s : SignaltransformdwtTable) -> Int { s.size }

pub fn signal_transform_dwt_table_get(s : SignaltransformdwtTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_table_set(s : SignaltransformdwtTable, i : Int, v : Double) -> SignaltransformdwtTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_table_sum(s : SignaltransformdwtTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_table_mean(s : SignaltransformdwtTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_table_scale(s : SignaltransformdwtTable, f : Double) -> SignaltransformdwtTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_table_add(a : SignaltransformdwtTable, b : SignaltransformdwtTable) -> SignaltransformdwtTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_table_copy(s : SignaltransformdwtTable) -> SignaltransformdwtTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_table_fill(s : SignaltransformdwtTable, v : Double) -> SignaltransformdwtTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_table_min(s : SignaltransformdwtTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_table_max(s : SignaltransformdwtTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_table_to_string(s : SignaltransformdwtTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_graphn_make(size : Int) -> SignaltransformdwtGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_graphn_len(s : SignaltransformdwtGraphN) -> Int { s.size }

pub fn signal_transform_dwt_graphn_get(s : SignaltransformdwtGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_graphn_set(s : SignaltransformdwtGraphN, i : Int, v : Double) -> SignaltransformdwtGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_graphn_sum(s : SignaltransformdwtGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_graphn_mean(s : SignaltransformdwtGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_graphn_scale(s : SignaltransformdwtGraphN, f : Double) -> SignaltransformdwtGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_graphn_add(a : SignaltransformdwtGraphN, b : SignaltransformdwtGraphN) -> SignaltransformdwtGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_graphn_copy(s : SignaltransformdwtGraphN) -> SignaltransformdwtGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_graphn_fill(s : SignaltransformdwtGraphN, v : Double) -> SignaltransformdwtGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_graphn_min(s : SignaltransformdwtGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_graphn_max(s : SignaltransformdwtGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_graphn_to_string(s : SignaltransformdwtGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_node_make(size : Int) -> SignaltransformdwtNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_node_len(s : SignaltransformdwtNode) -> Int { s.size }

pub fn signal_transform_dwt_node_get(s : SignaltransformdwtNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_node_set(s : SignaltransformdwtNode, i : Int, v : Double) -> SignaltransformdwtNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_node_sum(s : SignaltransformdwtNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_node_mean(s : SignaltransformdwtNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_node_scale(s : SignaltransformdwtNode, f : Double) -> SignaltransformdwtNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_node_add(a : SignaltransformdwtNode, b : SignaltransformdwtNode) -> SignaltransformdwtNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_node_copy(s : SignaltransformdwtNode) -> SignaltransformdwtNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_node_fill(s : SignaltransformdwtNode, v : Double) -> SignaltransformdwtNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_node_min(s : SignaltransformdwtNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_node_max(s : SignaltransformdwtNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_node_to_string(s : SignaltransformdwtNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_edge_make(size : Int) -> SignaltransformdwtEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_edge_len(s : SignaltransformdwtEdge) -> Int { s.size }

pub fn signal_transform_dwt_edge_get(s : SignaltransformdwtEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_edge_set(s : SignaltransformdwtEdge, i : Int, v : Double) -> SignaltransformdwtEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_edge_sum(s : SignaltransformdwtEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_edge_mean(s : SignaltransformdwtEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_edge_scale(s : SignaltransformdwtEdge, f : Double) -> SignaltransformdwtEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_edge_add(a : SignaltransformdwtEdge, b : SignaltransformdwtEdge) -> SignaltransformdwtEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_edge_copy(s : SignaltransformdwtEdge) -> SignaltransformdwtEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_edge_fill(s : SignaltransformdwtEdge, v : Double) -> SignaltransformdwtEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_edge_min(s : SignaltransformdwtEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_edge_max(s : SignaltransformdwtEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_edge_to_string(s : SignaltransformdwtEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_path_make(size : Int) -> SignaltransformdwtPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_path_len(s : SignaltransformdwtPath) -> Int { s.size }

pub fn signal_transform_dwt_path_get(s : SignaltransformdwtPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_path_set(s : SignaltransformdwtPath, i : Int, v : Double) -> SignaltransformdwtPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_path_sum(s : SignaltransformdwtPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_path_mean(s : SignaltransformdwtPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_path_scale(s : SignaltransformdwtPath, f : Double) -> SignaltransformdwtPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_path_add(a : SignaltransformdwtPath, b : SignaltransformdwtPath) -> SignaltransformdwtPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_path_copy(s : SignaltransformdwtPath) -> SignaltransformdwtPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_path_fill(s : SignaltransformdwtPath, v : Double) -> SignaltransformdwtPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_path_min(s : SignaltransformdwtPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_path_max(s : SignaltransformdwtPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_path_to_string(s : SignaltransformdwtPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_cluster_make(size : Int) -> SignaltransformdwtCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_cluster_len(s : SignaltransformdwtCluster) -> Int { s.size }

pub fn signal_transform_dwt_cluster_get(s : SignaltransformdwtCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_cluster_set(s : SignaltransformdwtCluster, i : Int, v : Double) -> SignaltransformdwtCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cluster_sum(s : SignaltransformdwtCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_cluster_mean(s : SignaltransformdwtCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_cluster_scale(s : SignaltransformdwtCluster, f : Double) -> SignaltransformdwtCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cluster_add(a : SignaltransformdwtCluster, b : SignaltransformdwtCluster) -> SignaltransformdwtCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_cluster_copy(s : SignaltransformdwtCluster) -> SignaltransformdwtCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cluster_fill(s : SignaltransformdwtCluster, v : Double) -> SignaltransformdwtCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cluster_min(s : SignaltransformdwtCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_cluster_max(s : SignaltransformdwtCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_cluster_to_string(s : SignaltransformdwtCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_model_make(size : Int) -> SignaltransformdwtModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_model_len(s : SignaltransformdwtModel) -> Int { s.size }

pub fn signal_transform_dwt_model_get(s : SignaltransformdwtModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_model_set(s : SignaltransformdwtModel, i : Int, v : Double) -> SignaltransformdwtModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_model_sum(s : SignaltransformdwtModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_model_mean(s : SignaltransformdwtModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_model_scale(s : SignaltransformdwtModel, f : Double) -> SignaltransformdwtModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_model_add(a : SignaltransformdwtModel, b : SignaltransformdwtModel) -> SignaltransformdwtModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_model_copy(s : SignaltransformdwtModel) -> SignaltransformdwtModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_model_fill(s : SignaltransformdwtModel, v : Double) -> SignaltransformdwtModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_model_min(s : SignaltransformdwtModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_model_max(s : SignaltransformdwtModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_model_to_string(s : SignaltransformdwtModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_layer_make(size : Int) -> SignaltransformdwtLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_layer_len(s : SignaltransformdwtLayer) -> Int { s.size }

pub fn signal_transform_dwt_layer_get(s : SignaltransformdwtLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_layer_set(s : SignaltransformdwtLayer, i : Int, v : Double) -> SignaltransformdwtLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_layer_sum(s : SignaltransformdwtLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_layer_mean(s : SignaltransformdwtLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_layer_scale(s : SignaltransformdwtLayer, f : Double) -> SignaltransformdwtLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_layer_add(a : SignaltransformdwtLayer, b : SignaltransformdwtLayer) -> SignaltransformdwtLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_layer_copy(s : SignaltransformdwtLayer) -> SignaltransformdwtLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_layer_fill(s : SignaltransformdwtLayer, v : Double) -> SignaltransformdwtLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_layer_min(s : SignaltransformdwtLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_layer_max(s : SignaltransformdwtLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_layer_to_string(s : SignaltransformdwtLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_buffer_make(size : Int) -> SignaltransformdwtBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_buffer_len(s : SignaltransformdwtBuffer) -> Int { s.size }

pub fn signal_transform_dwt_buffer_get(s : SignaltransformdwtBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_buffer_set(s : SignaltransformdwtBuffer, i : Int, v : Double) -> SignaltransformdwtBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_buffer_sum(s : SignaltransformdwtBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_buffer_mean(s : SignaltransformdwtBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_buffer_scale(s : SignaltransformdwtBuffer, f : Double) -> SignaltransformdwtBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_buffer_add(a : SignaltransformdwtBuffer, b : SignaltransformdwtBuffer) -> SignaltransformdwtBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_buffer_copy(s : SignaltransformdwtBuffer) -> SignaltransformdwtBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_buffer_fill(s : SignaltransformdwtBuffer, v : Double) -> SignaltransformdwtBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_buffer_min(s : SignaltransformdwtBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_buffer_max(s : SignaltransformdwtBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_buffer_to_string(s : SignaltransformdwtBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_cursor_make(size : Int) -> SignaltransformdwtCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_cursor_len(s : SignaltransformdwtCursor) -> Int { s.size }

pub fn signal_transform_dwt_cursor_get(s : SignaltransformdwtCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_cursor_set(s : SignaltransformdwtCursor, i : Int, v : Double) -> SignaltransformdwtCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cursor_sum(s : SignaltransformdwtCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_cursor_mean(s : SignaltransformdwtCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_cursor_scale(s : SignaltransformdwtCursor, f : Double) -> SignaltransformdwtCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cursor_add(a : SignaltransformdwtCursor, b : SignaltransformdwtCursor) -> SignaltransformdwtCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_cursor_copy(s : SignaltransformdwtCursor) -> SignaltransformdwtCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cursor_fill(s : SignaltransformdwtCursor, v : Double) -> SignaltransformdwtCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_cursor_min(s : SignaltransformdwtCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_cursor_max(s : SignaltransformdwtCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_cursor_to_string(s : SignaltransformdwtCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_view_make(size : Int) -> SignaltransformdwtView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_view_len(s : SignaltransformdwtView) -> Int { s.size }

pub fn signal_transform_dwt_view_get(s : SignaltransformdwtView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_view_set(s : SignaltransformdwtView, i : Int, v : Double) -> SignaltransformdwtView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_view_sum(s : SignaltransformdwtView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_view_mean(s : SignaltransformdwtView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_view_scale(s : SignaltransformdwtView, f : Double) -> SignaltransformdwtView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_view_add(a : SignaltransformdwtView, b : SignaltransformdwtView) -> SignaltransformdwtView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_view_copy(s : SignaltransformdwtView) -> SignaltransformdwtView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_view_fill(s : SignaltransformdwtView, v : Double) -> SignaltransformdwtView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_view_min(s : SignaltransformdwtView) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_view_max(s : SignaltransformdwtView) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_view_to_string(s : SignaltransformdwtView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_range_make(size : Int) -> SignaltransformdwtRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_range_len(s : SignaltransformdwtRange) -> Int { s.size }

pub fn signal_transform_dwt_range_get(s : SignaltransformdwtRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_range_set(s : SignaltransformdwtRange, i : Int, v : Double) -> SignaltransformdwtRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_range_sum(s : SignaltransformdwtRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_range_mean(s : SignaltransformdwtRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_range_scale(s : SignaltransformdwtRange, f : Double) -> SignaltransformdwtRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_range_add(a : SignaltransformdwtRange, b : SignaltransformdwtRange) -> SignaltransformdwtRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_range_copy(s : SignaltransformdwtRange) -> SignaltransformdwtRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_range_fill(s : SignaltransformdwtRange, v : Double) -> SignaltransformdwtRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_range_min(s : SignaltransformdwtRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_range_max(s : SignaltransformdwtRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_range_to_string(s : SignaltransformdwtRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdwtSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dwt_slice_make(size : Int) -> SignaltransformdwtSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dwt_slice_len(s : SignaltransformdwtSlice) -> Int { s.size }

pub fn signal_transform_dwt_slice_get(s : SignaltransformdwtSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dwt_slice_set(s : SignaltransformdwtSlice, i : Int, v : Double) -> SignaltransformdwtSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_slice_sum(s : SignaltransformdwtSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dwt_slice_mean(s : SignaltransformdwtSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dwt_slice_scale(s : SignaltransformdwtSlice, f : Double) -> SignaltransformdwtSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_slice_add(a : SignaltransformdwtSlice, b : SignaltransformdwtSlice) -> SignaltransformdwtSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dwt_slice_copy(s : SignaltransformdwtSlice) -> SignaltransformdwtSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_slice_fill(s : SignaltransformdwtSlice, v : Double) -> SignaltransformdwtSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dwt_slice_min(s : SignaltransformdwtSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_dwt_slice_max(s : SignaltransformdwtSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_dwt_slice_to_string(s : SignaltransformdwtSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

