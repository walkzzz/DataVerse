///===
/// extcore/signal_window_rect

pub(all) struct SignalwindowrectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_rect_make_point(x : Double, y : Double) -> SignalwindowrectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_rect_make_point3(x : Double, y : Double, z : Double) -> SignalwindowrectPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowrectPoint::x(self : SignalwindowrectPoint) -> Double { self.x }

pub fn SignalwindowrectPoint::y(self : SignalwindowrectPoint) -> Double { self.y }

pub fn SignalwindowrectPoint::z(self : SignalwindowrectPoint) -> Double { self.z }

pub fn SignalwindowrectPoint::label(self : SignalwindowrectPoint) -> Int { self.label }

pub fn SignalwindowrectPoint::dist(self : SignalwindowrectPoint, other : SignalwindowrectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowrectPoint::add(self : SignalwindowrectPoint, other : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowrectPoint::sub(self : SignalwindowrectPoint, other : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowrectPoint::scale(self : SignalwindowrectPoint, s : Double) -> SignalwindowrectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowrectPoint::dot(self : SignalwindowrectPoint, other : SignalwindowrectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowrectPoint::cross(self : SignalwindowrectPoint, other : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowrectPoint::norm(self : SignalwindowrectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowrectPoint::normalize(self : SignalwindowrectPoint) -> SignalwindowrectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowrectPoint::negate(self : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowrectPoint::mid(self : SignalwindowrectPoint, other : SignalwindowrectPoint) -> SignalwindowrectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowrectPoint::lerp(self : SignalwindowrectPoint, other : SignalwindowrectPoint, t : Double) -> SignalwindowrectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowrectPoint::to_string(self : SignalwindowrectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowrectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_rect_make_series(vals : Array[Double], name : String) -> SignalwindowrectSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowrectSeries::len(self : SignalwindowrectSeries) -> Int { self.vals.length() }

pub fn SignalwindowrectSeries::sum(self : SignalwindowrectSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowrectSeries::mean(self : SignalwindowrectSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowrectSeries::min(self : SignalwindowrectSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowrectSeries::max(self : SignalwindowrectSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowrectSeries::range(self : SignalwindowrectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowrectSeries::variance(self : SignalwindowrectSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowrectSeries::std(self : SignalwindowrectSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowrectSeries::median(self : SignalwindowrectSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowrectSeries::scale(self : SignalwindowrectSeries, f : Double) -> SignalwindowrectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowrectSeries::add(self : SignalwindowrectSeries, other : SignalwindowrectSeries) -> SignalwindowrectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowrectSeries::sub(self : SignalwindowrectSeries, other : SignalwindowrectSeries) -> SignalwindowrectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowrectSeries::normalize(self : SignalwindowrectSeries) -> SignalwindowrectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowrectSeries::cumsum(self : SignalwindowrectSeries) -> SignalwindowrectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowrectSeries::to_string(self : SignalwindowrectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowrectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_rect_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowrectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_rect_matrix_identity(n : Int) -> SignalwindowrectMatrix {
  let m = signal_window_rect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowrectMatrix::get(self : SignalwindowrectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowrectMatrix::transpose(self : SignalwindowrectMatrix) -> SignalwindowrectMatrix {
  let result = signal_window_rect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowrectMatrix::add(self : SignalwindowrectMatrix, other : SignalwindowrectMatrix) -> SignalwindowrectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_rect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowrectMatrix::scale(self : SignalwindowrectMatrix, s : Double) -> SignalwindowrectMatrix {
  let result = signal_window_rect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowrectMatrix::multiply(self : SignalwindowrectMatrix, other : SignalwindowrectMatrix) -> SignalwindowrectMatrix {
  if self.cols != other.rows { return signal_window_rect_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_rect_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowrectMatrix::trace(self : SignalwindowrectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowrectMatrix::det(self : SignalwindowrectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowrectMatrix::norm(self : SignalwindowrectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowrectMatrix::to_string(self : SignalwindowrectMatrix) -> String {
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

pub(all) struct SignalwindowrectVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_rect_make_vector(comps : Array[Double]) -> SignalwindowrectVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_rect_vector_zero(dim : Int) -> SignalwindowrectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowrectVector::add(self : SignalwindowrectVector, other : SignalwindowrectVector) -> SignalwindowrectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowrectVector::sub(self : SignalwindowrectVector, other : SignalwindowrectVector) -> SignalwindowrectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowrectVector::scale(self : SignalwindowrectVector, s : Double) -> SignalwindowrectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowrectVector::dot(self : SignalwindowrectVector, other : SignalwindowrectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowrectVector::norm(self : SignalwindowrectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowrectVector::normalize(self : SignalwindowrectVector) -> SignalwindowrectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowrectVector::dist(self : SignalwindowrectVector, other : SignalwindowrectVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowrectVector::to_string(self : SignalwindowrectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_rect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_rect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_rect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_rect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_rect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_rect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_rect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_rect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_rect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_rect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_rect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_rect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_rect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_rect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_rect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_rect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_rect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_rect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_rect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_rect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_rect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_rect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_rect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_rect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_rect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_rect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_rect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_rect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_rect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowrectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_frame_make(size : Int) -> SignalwindowrectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_frame_len(s : SignalwindowrectFrame) -> Int { s.size }

pub fn signal_window_rect_frame_get(s : SignalwindowrectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_frame_set(s : SignalwindowrectFrame, i : Int, v : Double) -> SignalwindowrectFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_frame_sum(s : SignalwindowrectFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_frame_mean(s : SignalwindowrectFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_frame_scale(s : SignalwindowrectFrame, f : Double) -> SignalwindowrectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_frame_add(a : SignalwindowrectFrame, b : SignalwindowrectFrame) -> SignalwindowrectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_frame_copy(s : SignalwindowrectFrame) -> SignalwindowrectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_frame_fill(s : SignalwindowrectFrame, v : Double) -> SignalwindowrectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_frame_min(s : SignalwindowrectFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_frame_max(s : SignalwindowrectFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_frame_to_string(s : SignalwindowrectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_table_make(size : Int) -> SignalwindowrectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_table_len(s : SignalwindowrectTable) -> Int { s.size }

pub fn signal_window_rect_table_get(s : SignalwindowrectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_table_set(s : SignalwindowrectTable, i : Int, v : Double) -> SignalwindowrectTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_table_sum(s : SignalwindowrectTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_table_mean(s : SignalwindowrectTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_table_scale(s : SignalwindowrectTable, f : Double) -> SignalwindowrectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_table_add(a : SignalwindowrectTable, b : SignalwindowrectTable) -> SignalwindowrectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_table_copy(s : SignalwindowrectTable) -> SignalwindowrectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_table_fill(s : SignalwindowrectTable, v : Double) -> SignalwindowrectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_table_min(s : SignalwindowrectTable) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_table_max(s : SignalwindowrectTable) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_table_to_string(s : SignalwindowrectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_graphn_make(size : Int) -> SignalwindowrectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_graphn_len(s : SignalwindowrectGraphN) -> Int { s.size }

pub fn signal_window_rect_graphn_get(s : SignalwindowrectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_graphn_set(s : SignalwindowrectGraphN, i : Int, v : Double) -> SignalwindowrectGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_graphn_sum(s : SignalwindowrectGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_graphn_mean(s : SignalwindowrectGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_graphn_scale(s : SignalwindowrectGraphN, f : Double) -> SignalwindowrectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_graphn_add(a : SignalwindowrectGraphN, b : SignalwindowrectGraphN) -> SignalwindowrectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_graphn_copy(s : SignalwindowrectGraphN) -> SignalwindowrectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_graphn_fill(s : SignalwindowrectGraphN, v : Double) -> SignalwindowrectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_graphn_min(s : SignalwindowrectGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_graphn_max(s : SignalwindowrectGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_graphn_to_string(s : SignalwindowrectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_node_make(size : Int) -> SignalwindowrectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_node_len(s : SignalwindowrectNode) -> Int { s.size }

pub fn signal_window_rect_node_get(s : SignalwindowrectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_node_set(s : SignalwindowrectNode, i : Int, v : Double) -> SignalwindowrectNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_node_sum(s : SignalwindowrectNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_node_mean(s : SignalwindowrectNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_node_scale(s : SignalwindowrectNode, f : Double) -> SignalwindowrectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_node_add(a : SignalwindowrectNode, b : SignalwindowrectNode) -> SignalwindowrectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_node_copy(s : SignalwindowrectNode) -> SignalwindowrectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_node_fill(s : SignalwindowrectNode, v : Double) -> SignalwindowrectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_node_min(s : SignalwindowrectNode) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_node_max(s : SignalwindowrectNode) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_node_to_string(s : SignalwindowrectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_edge_make(size : Int) -> SignalwindowrectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_edge_len(s : SignalwindowrectEdge) -> Int { s.size }

pub fn signal_window_rect_edge_get(s : SignalwindowrectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_edge_set(s : SignalwindowrectEdge, i : Int, v : Double) -> SignalwindowrectEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_edge_sum(s : SignalwindowrectEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_edge_mean(s : SignalwindowrectEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_edge_scale(s : SignalwindowrectEdge, f : Double) -> SignalwindowrectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_edge_add(a : SignalwindowrectEdge, b : SignalwindowrectEdge) -> SignalwindowrectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_edge_copy(s : SignalwindowrectEdge) -> SignalwindowrectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_edge_fill(s : SignalwindowrectEdge, v : Double) -> SignalwindowrectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_edge_min(s : SignalwindowrectEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_edge_max(s : SignalwindowrectEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_edge_to_string(s : SignalwindowrectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_path_make(size : Int) -> SignalwindowrectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_path_len(s : SignalwindowrectPath) -> Int { s.size }

pub fn signal_window_rect_path_get(s : SignalwindowrectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_path_set(s : SignalwindowrectPath, i : Int, v : Double) -> SignalwindowrectPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_path_sum(s : SignalwindowrectPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_path_mean(s : SignalwindowrectPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_path_scale(s : SignalwindowrectPath, f : Double) -> SignalwindowrectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_path_add(a : SignalwindowrectPath, b : SignalwindowrectPath) -> SignalwindowrectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_path_copy(s : SignalwindowrectPath) -> SignalwindowrectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_path_fill(s : SignalwindowrectPath, v : Double) -> SignalwindowrectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_path_min(s : SignalwindowrectPath) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_path_max(s : SignalwindowrectPath) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_path_to_string(s : SignalwindowrectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_cluster_make(size : Int) -> SignalwindowrectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_cluster_len(s : SignalwindowrectCluster) -> Int { s.size }

pub fn signal_window_rect_cluster_get(s : SignalwindowrectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_cluster_set(s : SignalwindowrectCluster, i : Int, v : Double) -> SignalwindowrectCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cluster_sum(s : SignalwindowrectCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_cluster_mean(s : SignalwindowrectCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_cluster_scale(s : SignalwindowrectCluster, f : Double) -> SignalwindowrectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cluster_add(a : SignalwindowrectCluster, b : SignalwindowrectCluster) -> SignalwindowrectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_cluster_copy(s : SignalwindowrectCluster) -> SignalwindowrectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cluster_fill(s : SignalwindowrectCluster, v : Double) -> SignalwindowrectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cluster_min(s : SignalwindowrectCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_cluster_max(s : SignalwindowrectCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_cluster_to_string(s : SignalwindowrectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_model_make(size : Int) -> SignalwindowrectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_model_len(s : SignalwindowrectModel) -> Int { s.size }

pub fn signal_window_rect_model_get(s : SignalwindowrectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_model_set(s : SignalwindowrectModel, i : Int, v : Double) -> SignalwindowrectModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_model_sum(s : SignalwindowrectModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_model_mean(s : SignalwindowrectModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_model_scale(s : SignalwindowrectModel, f : Double) -> SignalwindowrectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_model_add(a : SignalwindowrectModel, b : SignalwindowrectModel) -> SignalwindowrectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_model_copy(s : SignalwindowrectModel) -> SignalwindowrectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_model_fill(s : SignalwindowrectModel, v : Double) -> SignalwindowrectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_model_min(s : SignalwindowrectModel) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_model_max(s : SignalwindowrectModel) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_model_to_string(s : SignalwindowrectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_layer_make(size : Int) -> SignalwindowrectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_layer_len(s : SignalwindowrectLayer) -> Int { s.size }

pub fn signal_window_rect_layer_get(s : SignalwindowrectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_layer_set(s : SignalwindowrectLayer, i : Int, v : Double) -> SignalwindowrectLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_layer_sum(s : SignalwindowrectLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_layer_mean(s : SignalwindowrectLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_layer_scale(s : SignalwindowrectLayer, f : Double) -> SignalwindowrectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_layer_add(a : SignalwindowrectLayer, b : SignalwindowrectLayer) -> SignalwindowrectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_layer_copy(s : SignalwindowrectLayer) -> SignalwindowrectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_layer_fill(s : SignalwindowrectLayer, v : Double) -> SignalwindowrectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_layer_min(s : SignalwindowrectLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_layer_max(s : SignalwindowrectLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_layer_to_string(s : SignalwindowrectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_buffer_make(size : Int) -> SignalwindowrectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_buffer_len(s : SignalwindowrectBuffer) -> Int { s.size }

pub fn signal_window_rect_buffer_get(s : SignalwindowrectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_buffer_set(s : SignalwindowrectBuffer, i : Int, v : Double) -> SignalwindowrectBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_buffer_sum(s : SignalwindowrectBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_buffer_mean(s : SignalwindowrectBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_buffer_scale(s : SignalwindowrectBuffer, f : Double) -> SignalwindowrectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_buffer_add(a : SignalwindowrectBuffer, b : SignalwindowrectBuffer) -> SignalwindowrectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_buffer_copy(s : SignalwindowrectBuffer) -> SignalwindowrectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_buffer_fill(s : SignalwindowrectBuffer, v : Double) -> SignalwindowrectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_buffer_min(s : SignalwindowrectBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_buffer_max(s : SignalwindowrectBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_buffer_to_string(s : SignalwindowrectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_cursor_make(size : Int) -> SignalwindowrectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_cursor_len(s : SignalwindowrectCursor) -> Int { s.size }

pub fn signal_window_rect_cursor_get(s : SignalwindowrectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_cursor_set(s : SignalwindowrectCursor, i : Int, v : Double) -> SignalwindowrectCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cursor_sum(s : SignalwindowrectCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_cursor_mean(s : SignalwindowrectCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_cursor_scale(s : SignalwindowrectCursor, f : Double) -> SignalwindowrectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cursor_add(a : SignalwindowrectCursor, b : SignalwindowrectCursor) -> SignalwindowrectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_cursor_copy(s : SignalwindowrectCursor) -> SignalwindowrectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cursor_fill(s : SignalwindowrectCursor, v : Double) -> SignalwindowrectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_cursor_min(s : SignalwindowrectCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_cursor_max(s : SignalwindowrectCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_cursor_to_string(s : SignalwindowrectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_view_make(size : Int) -> SignalwindowrectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_view_len(s : SignalwindowrectView) -> Int { s.size }

pub fn signal_window_rect_view_get(s : SignalwindowrectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_view_set(s : SignalwindowrectView, i : Int, v : Double) -> SignalwindowrectView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_view_sum(s : SignalwindowrectView) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_view_mean(s : SignalwindowrectView) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_view_scale(s : SignalwindowrectView, f : Double) -> SignalwindowrectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_view_add(a : SignalwindowrectView, b : SignalwindowrectView) -> SignalwindowrectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_view_copy(s : SignalwindowrectView) -> SignalwindowrectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_view_fill(s : SignalwindowrectView, v : Double) -> SignalwindowrectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_view_min(s : SignalwindowrectView) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_view_max(s : SignalwindowrectView) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_view_to_string(s : SignalwindowrectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_range_make(size : Int) -> SignalwindowrectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_range_len(s : SignalwindowrectRange) -> Int { s.size }

pub fn signal_window_rect_range_get(s : SignalwindowrectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_range_set(s : SignalwindowrectRange, i : Int, v : Double) -> SignalwindowrectRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_range_sum(s : SignalwindowrectRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_range_mean(s : SignalwindowrectRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_range_scale(s : SignalwindowrectRange, f : Double) -> SignalwindowrectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_range_add(a : SignalwindowrectRange, b : SignalwindowrectRange) -> SignalwindowrectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_range_copy(s : SignalwindowrectRange) -> SignalwindowrectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_range_fill(s : SignalwindowrectRange, v : Double) -> SignalwindowrectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_range_min(s : SignalwindowrectRange) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_range_max(s : SignalwindowrectRange) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_range_to_string(s : SignalwindowrectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowrectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_rect_slice_make(size : Int) -> SignalwindowrectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_rect_slice_len(s : SignalwindowrectSlice) -> Int { s.size }

pub fn signal_window_rect_slice_get(s : SignalwindowrectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_rect_slice_set(s : SignalwindowrectSlice, i : Int, v : Double) -> SignalwindowrectSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_rect_slice_sum(s : SignalwindowrectSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_rect_slice_mean(s : SignalwindowrectSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_rect_slice_scale(s : SignalwindowrectSlice, f : Double) -> SignalwindowrectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_slice_add(a : SignalwindowrectSlice, b : SignalwindowrectSlice) -> SignalwindowrectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_rect_slice_copy(s : SignalwindowrectSlice) -> SignalwindowrectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_slice_fill(s : SignalwindowrectSlice, v : Double) -> SignalwindowrectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_rect_slice_min(s : SignalwindowrectSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_rect_slice_max(s : SignalwindowrectSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_rect_slice_to_string(s : SignalwindowrectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

