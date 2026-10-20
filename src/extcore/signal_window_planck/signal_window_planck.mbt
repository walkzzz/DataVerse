///===
/// extcore/signal_window_planck

pub(all) struct SignalwindowplanckPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_planck_make_point(x : Double, y : Double) -> SignalwindowplanckPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_planck_make_point3(x : Double, y : Double, z : Double) -> SignalwindowplanckPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowplanckPoint::x(self : SignalwindowplanckPoint) -> Double { self.x }

pub fn SignalwindowplanckPoint::y(self : SignalwindowplanckPoint) -> Double { self.y }

pub fn SignalwindowplanckPoint::z(self : SignalwindowplanckPoint) -> Double { self.z }

pub fn SignalwindowplanckPoint::label(self : SignalwindowplanckPoint) -> Int { self.label }

pub fn SignalwindowplanckPoint::dist(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowplanckPoint::add(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowplanckPoint::sub(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowplanckPoint::scale(self : SignalwindowplanckPoint, s : Double) -> SignalwindowplanckPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowplanckPoint::dot(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowplanckPoint::cross(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowplanckPoint::norm(self : SignalwindowplanckPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowplanckPoint::normalize(self : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowplanckPoint::negate(self : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowplanckPoint::mid(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint) -> SignalwindowplanckPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowplanckPoint::lerp(self : SignalwindowplanckPoint, other : SignalwindowplanckPoint, t : Double) -> SignalwindowplanckPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowplanckPoint::to_string(self : SignalwindowplanckPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowplanckSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_planck_make_series(vals : Array[Double], name : String) -> SignalwindowplanckSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowplanckSeries::len(self : SignalwindowplanckSeries) -> Int { self.vals.length() }

pub fn SignalwindowplanckSeries::sum(self : SignalwindowplanckSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowplanckSeries::mean(self : SignalwindowplanckSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowplanckSeries::min(self : SignalwindowplanckSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowplanckSeries::max(self : SignalwindowplanckSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowplanckSeries::range(self : SignalwindowplanckSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowplanckSeries::variance(self : SignalwindowplanckSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowplanckSeries::std(self : SignalwindowplanckSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowplanckSeries::median(self : SignalwindowplanckSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowplanckSeries::scale(self : SignalwindowplanckSeries, f : Double) -> SignalwindowplanckSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowplanckSeries::add(self : SignalwindowplanckSeries, other : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowplanckSeries::sub(self : SignalwindowplanckSeries, other : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowplanckSeries::normalize(self : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowplanckSeries::cumsum(self : SignalwindowplanckSeries) -> SignalwindowplanckSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowplanckSeries::to_string(self : SignalwindowplanckSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowplanckMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_planck_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowplanckMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_planck_matrix_identity(n : Int) -> SignalwindowplanckMatrix {
  let m = signal_window_planck_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowplanckMatrix::get(self : SignalwindowplanckMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowplanckMatrix::transpose(self : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  let result = signal_window_planck_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowplanckMatrix::add(self : SignalwindowplanckMatrix, other : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_planck_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowplanckMatrix::scale(self : SignalwindowplanckMatrix, s : Double) -> SignalwindowplanckMatrix {
  let result = signal_window_planck_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowplanckMatrix::multiply(self : SignalwindowplanckMatrix, other : SignalwindowplanckMatrix) -> SignalwindowplanckMatrix {
  if self.cols != other.rows { return signal_window_planck_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_planck_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowplanckMatrix::trace(self : SignalwindowplanckMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowplanckMatrix::det(self : SignalwindowplanckMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowplanckMatrix::norm(self : SignalwindowplanckMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowplanckMatrix::to_string(self : SignalwindowplanckMatrix) -> String {
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

pub(all) struct SignalwindowplanckVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_planck_make_vector(comps : Array[Double]) -> SignalwindowplanckVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_planck_vector_zero(dim : Int) -> SignalwindowplanckVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowplanckVector::add(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowplanckVector::sub(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowplanckVector::scale(self : SignalwindowplanckVector, s : Double) -> SignalwindowplanckVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowplanckVector::dot(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowplanckVector::norm(self : SignalwindowplanckVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowplanckVector::normalize(self : SignalwindowplanckVector) -> SignalwindowplanckVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowplanckVector::dist(self : SignalwindowplanckVector, other : SignalwindowplanckVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowplanckVector::to_string(self : SignalwindowplanckVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_planck_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_planck_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_planck_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_planck_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_planck_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_planck_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_planck_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_planck_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_planck_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_planck_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_planck_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_planck_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_planck_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_planck_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_planck_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_planck_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_planck_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_planck_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_planck_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_planck_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_planck_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_planck_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_planck_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_planck_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_planck_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_planck_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_planck_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_planck_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_planck_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowplanckFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_frame_make(size : Int) -> SignalwindowplanckFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_frame_len(s : SignalwindowplanckFrame) -> Int { s.size }

pub fn signal_window_planck_frame_get(s : SignalwindowplanckFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_frame_set(s : SignalwindowplanckFrame, i : Int, v : Double) -> SignalwindowplanckFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_frame_sum(s : SignalwindowplanckFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_frame_mean(s : SignalwindowplanckFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_frame_scale(s : SignalwindowplanckFrame, f : Double) -> SignalwindowplanckFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_frame_add(a : SignalwindowplanckFrame, b : SignalwindowplanckFrame) -> SignalwindowplanckFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_frame_copy(s : SignalwindowplanckFrame) -> SignalwindowplanckFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_frame_fill(s : SignalwindowplanckFrame, v : Double) -> SignalwindowplanckFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_frame_min(s : SignalwindowplanckFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_frame_max(s : SignalwindowplanckFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_frame_to_string(s : SignalwindowplanckFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_table_make(size : Int) -> SignalwindowplanckTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_table_len(s : SignalwindowplanckTable) -> Int { s.size }

pub fn signal_window_planck_table_get(s : SignalwindowplanckTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_table_set(s : SignalwindowplanckTable, i : Int, v : Double) -> SignalwindowplanckTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_table_sum(s : SignalwindowplanckTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_table_mean(s : SignalwindowplanckTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_table_scale(s : SignalwindowplanckTable, f : Double) -> SignalwindowplanckTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_table_add(a : SignalwindowplanckTable, b : SignalwindowplanckTable) -> SignalwindowplanckTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_table_copy(s : SignalwindowplanckTable) -> SignalwindowplanckTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_table_fill(s : SignalwindowplanckTable, v : Double) -> SignalwindowplanckTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_table_min(s : SignalwindowplanckTable) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_table_max(s : SignalwindowplanckTable) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_table_to_string(s : SignalwindowplanckTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_graphn_make(size : Int) -> SignalwindowplanckGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_graphn_len(s : SignalwindowplanckGraphN) -> Int { s.size }

pub fn signal_window_planck_graphn_get(s : SignalwindowplanckGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_graphn_set(s : SignalwindowplanckGraphN, i : Int, v : Double) -> SignalwindowplanckGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_graphn_sum(s : SignalwindowplanckGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_graphn_mean(s : SignalwindowplanckGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_graphn_scale(s : SignalwindowplanckGraphN, f : Double) -> SignalwindowplanckGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_graphn_add(a : SignalwindowplanckGraphN, b : SignalwindowplanckGraphN) -> SignalwindowplanckGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_graphn_copy(s : SignalwindowplanckGraphN) -> SignalwindowplanckGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_graphn_fill(s : SignalwindowplanckGraphN, v : Double) -> SignalwindowplanckGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_graphn_min(s : SignalwindowplanckGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_graphn_max(s : SignalwindowplanckGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_graphn_to_string(s : SignalwindowplanckGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_node_make(size : Int) -> SignalwindowplanckNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_node_len(s : SignalwindowplanckNode) -> Int { s.size }

pub fn signal_window_planck_node_get(s : SignalwindowplanckNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_node_set(s : SignalwindowplanckNode, i : Int, v : Double) -> SignalwindowplanckNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_node_sum(s : SignalwindowplanckNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_node_mean(s : SignalwindowplanckNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_node_scale(s : SignalwindowplanckNode, f : Double) -> SignalwindowplanckNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_node_add(a : SignalwindowplanckNode, b : SignalwindowplanckNode) -> SignalwindowplanckNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_node_copy(s : SignalwindowplanckNode) -> SignalwindowplanckNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_node_fill(s : SignalwindowplanckNode, v : Double) -> SignalwindowplanckNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_node_min(s : SignalwindowplanckNode) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_node_max(s : SignalwindowplanckNode) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_node_to_string(s : SignalwindowplanckNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_edge_make(size : Int) -> SignalwindowplanckEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_edge_len(s : SignalwindowplanckEdge) -> Int { s.size }

pub fn signal_window_planck_edge_get(s : SignalwindowplanckEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_edge_set(s : SignalwindowplanckEdge, i : Int, v : Double) -> SignalwindowplanckEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_edge_sum(s : SignalwindowplanckEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_edge_mean(s : SignalwindowplanckEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_edge_scale(s : SignalwindowplanckEdge, f : Double) -> SignalwindowplanckEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_edge_add(a : SignalwindowplanckEdge, b : SignalwindowplanckEdge) -> SignalwindowplanckEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_edge_copy(s : SignalwindowplanckEdge) -> SignalwindowplanckEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_edge_fill(s : SignalwindowplanckEdge, v : Double) -> SignalwindowplanckEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_edge_min(s : SignalwindowplanckEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_edge_max(s : SignalwindowplanckEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_edge_to_string(s : SignalwindowplanckEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_path_make(size : Int) -> SignalwindowplanckPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_path_len(s : SignalwindowplanckPath) -> Int { s.size }

pub fn signal_window_planck_path_get(s : SignalwindowplanckPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_path_set(s : SignalwindowplanckPath, i : Int, v : Double) -> SignalwindowplanckPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_path_sum(s : SignalwindowplanckPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_path_mean(s : SignalwindowplanckPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_path_scale(s : SignalwindowplanckPath, f : Double) -> SignalwindowplanckPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_path_add(a : SignalwindowplanckPath, b : SignalwindowplanckPath) -> SignalwindowplanckPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_path_copy(s : SignalwindowplanckPath) -> SignalwindowplanckPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_path_fill(s : SignalwindowplanckPath, v : Double) -> SignalwindowplanckPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_path_min(s : SignalwindowplanckPath) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_path_max(s : SignalwindowplanckPath) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_path_to_string(s : SignalwindowplanckPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_cluster_make(size : Int) -> SignalwindowplanckCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_cluster_len(s : SignalwindowplanckCluster) -> Int { s.size }

pub fn signal_window_planck_cluster_get(s : SignalwindowplanckCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_cluster_set(s : SignalwindowplanckCluster, i : Int, v : Double) -> SignalwindowplanckCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cluster_sum(s : SignalwindowplanckCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_cluster_mean(s : SignalwindowplanckCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_cluster_scale(s : SignalwindowplanckCluster, f : Double) -> SignalwindowplanckCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cluster_add(a : SignalwindowplanckCluster, b : SignalwindowplanckCluster) -> SignalwindowplanckCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_cluster_copy(s : SignalwindowplanckCluster) -> SignalwindowplanckCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cluster_fill(s : SignalwindowplanckCluster, v : Double) -> SignalwindowplanckCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cluster_min(s : SignalwindowplanckCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_cluster_max(s : SignalwindowplanckCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_cluster_to_string(s : SignalwindowplanckCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_model_make(size : Int) -> SignalwindowplanckModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_model_len(s : SignalwindowplanckModel) -> Int { s.size }

pub fn signal_window_planck_model_get(s : SignalwindowplanckModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_model_set(s : SignalwindowplanckModel, i : Int, v : Double) -> SignalwindowplanckModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_model_sum(s : SignalwindowplanckModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_model_mean(s : SignalwindowplanckModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_model_scale(s : SignalwindowplanckModel, f : Double) -> SignalwindowplanckModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_model_add(a : SignalwindowplanckModel, b : SignalwindowplanckModel) -> SignalwindowplanckModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_model_copy(s : SignalwindowplanckModel) -> SignalwindowplanckModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_model_fill(s : SignalwindowplanckModel, v : Double) -> SignalwindowplanckModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_model_min(s : SignalwindowplanckModel) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_model_max(s : SignalwindowplanckModel) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_model_to_string(s : SignalwindowplanckModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_layer_make(size : Int) -> SignalwindowplanckLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_layer_len(s : SignalwindowplanckLayer) -> Int { s.size }

pub fn signal_window_planck_layer_get(s : SignalwindowplanckLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_layer_set(s : SignalwindowplanckLayer, i : Int, v : Double) -> SignalwindowplanckLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_layer_sum(s : SignalwindowplanckLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_layer_mean(s : SignalwindowplanckLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_layer_scale(s : SignalwindowplanckLayer, f : Double) -> SignalwindowplanckLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_layer_add(a : SignalwindowplanckLayer, b : SignalwindowplanckLayer) -> SignalwindowplanckLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_layer_copy(s : SignalwindowplanckLayer) -> SignalwindowplanckLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_layer_fill(s : SignalwindowplanckLayer, v : Double) -> SignalwindowplanckLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_layer_min(s : SignalwindowplanckLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_layer_max(s : SignalwindowplanckLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_layer_to_string(s : SignalwindowplanckLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_buffer_make(size : Int) -> SignalwindowplanckBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_buffer_len(s : SignalwindowplanckBuffer) -> Int { s.size }

pub fn signal_window_planck_buffer_get(s : SignalwindowplanckBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_buffer_set(s : SignalwindowplanckBuffer, i : Int, v : Double) -> SignalwindowplanckBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_buffer_sum(s : SignalwindowplanckBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_buffer_mean(s : SignalwindowplanckBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_buffer_scale(s : SignalwindowplanckBuffer, f : Double) -> SignalwindowplanckBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_buffer_add(a : SignalwindowplanckBuffer, b : SignalwindowplanckBuffer) -> SignalwindowplanckBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_buffer_copy(s : SignalwindowplanckBuffer) -> SignalwindowplanckBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_buffer_fill(s : SignalwindowplanckBuffer, v : Double) -> SignalwindowplanckBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_buffer_min(s : SignalwindowplanckBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_buffer_max(s : SignalwindowplanckBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_buffer_to_string(s : SignalwindowplanckBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_cursor_make(size : Int) -> SignalwindowplanckCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_cursor_len(s : SignalwindowplanckCursor) -> Int { s.size }

pub fn signal_window_planck_cursor_get(s : SignalwindowplanckCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_cursor_set(s : SignalwindowplanckCursor, i : Int, v : Double) -> SignalwindowplanckCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cursor_sum(s : SignalwindowplanckCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_cursor_mean(s : SignalwindowplanckCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_cursor_scale(s : SignalwindowplanckCursor, f : Double) -> SignalwindowplanckCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cursor_add(a : SignalwindowplanckCursor, b : SignalwindowplanckCursor) -> SignalwindowplanckCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_cursor_copy(s : SignalwindowplanckCursor) -> SignalwindowplanckCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cursor_fill(s : SignalwindowplanckCursor, v : Double) -> SignalwindowplanckCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_cursor_min(s : SignalwindowplanckCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_cursor_max(s : SignalwindowplanckCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_cursor_to_string(s : SignalwindowplanckCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_view_make(size : Int) -> SignalwindowplanckView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_view_len(s : SignalwindowplanckView) -> Int { s.size }

pub fn signal_window_planck_view_get(s : SignalwindowplanckView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_view_set(s : SignalwindowplanckView, i : Int, v : Double) -> SignalwindowplanckView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_view_sum(s : SignalwindowplanckView) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_view_mean(s : SignalwindowplanckView) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_view_scale(s : SignalwindowplanckView, f : Double) -> SignalwindowplanckView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_view_add(a : SignalwindowplanckView, b : SignalwindowplanckView) -> SignalwindowplanckView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_view_copy(s : SignalwindowplanckView) -> SignalwindowplanckView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_view_fill(s : SignalwindowplanckView, v : Double) -> SignalwindowplanckView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_view_min(s : SignalwindowplanckView) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_view_max(s : SignalwindowplanckView) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_view_to_string(s : SignalwindowplanckView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_range_make(size : Int) -> SignalwindowplanckRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_range_len(s : SignalwindowplanckRange) -> Int { s.size }

pub fn signal_window_planck_range_get(s : SignalwindowplanckRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_range_set(s : SignalwindowplanckRange, i : Int, v : Double) -> SignalwindowplanckRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_range_sum(s : SignalwindowplanckRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_range_mean(s : SignalwindowplanckRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_range_scale(s : SignalwindowplanckRange, f : Double) -> SignalwindowplanckRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_range_add(a : SignalwindowplanckRange, b : SignalwindowplanckRange) -> SignalwindowplanckRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_range_copy(s : SignalwindowplanckRange) -> SignalwindowplanckRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_range_fill(s : SignalwindowplanckRange, v : Double) -> SignalwindowplanckRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_range_min(s : SignalwindowplanckRange) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_range_max(s : SignalwindowplanckRange) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_range_to_string(s : SignalwindowplanckRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowplanckSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_planck_slice_make(size : Int) -> SignalwindowplanckSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_planck_slice_len(s : SignalwindowplanckSlice) -> Int { s.size }

pub fn signal_window_planck_slice_get(s : SignalwindowplanckSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_planck_slice_set(s : SignalwindowplanckSlice, i : Int, v : Double) -> SignalwindowplanckSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_planck_slice_sum(s : SignalwindowplanckSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_planck_slice_mean(s : SignalwindowplanckSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_planck_slice_scale(s : SignalwindowplanckSlice, f : Double) -> SignalwindowplanckSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_slice_add(a : SignalwindowplanckSlice, b : SignalwindowplanckSlice) -> SignalwindowplanckSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_planck_slice_copy(s : SignalwindowplanckSlice) -> SignalwindowplanckSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_slice_fill(s : SignalwindowplanckSlice, v : Double) -> SignalwindowplanckSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_planck_slice_min(s : SignalwindowplanckSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_planck_slice_max(s : SignalwindowplanckSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_planck_slice_to_string(s : SignalwindowplanckSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

