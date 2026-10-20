///===
/// extcore/signal_window_hann

pub(all) struct SignalwindowhannPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_hann_make_point(x : Double, y : Double) -> SignalwindowhannPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_hann_make_point3(x : Double, y : Double, z : Double) -> SignalwindowhannPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowhannPoint::x(self : SignalwindowhannPoint) -> Double { self.x }

pub fn SignalwindowhannPoint::y(self : SignalwindowhannPoint) -> Double { self.y }

pub fn SignalwindowhannPoint::z(self : SignalwindowhannPoint) -> Double { self.z }

pub fn SignalwindowhannPoint::label(self : SignalwindowhannPoint) -> Int { self.label }

pub fn SignalwindowhannPoint::dist(self : SignalwindowhannPoint, other : SignalwindowhannPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowhannPoint::add(self : SignalwindowhannPoint, other : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowhannPoint::sub(self : SignalwindowhannPoint, other : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowhannPoint::scale(self : SignalwindowhannPoint, s : Double) -> SignalwindowhannPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowhannPoint::dot(self : SignalwindowhannPoint, other : SignalwindowhannPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowhannPoint::cross(self : SignalwindowhannPoint, other : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowhannPoint::norm(self : SignalwindowhannPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowhannPoint::normalize(self : SignalwindowhannPoint) -> SignalwindowhannPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowhannPoint::negate(self : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowhannPoint::mid(self : SignalwindowhannPoint, other : SignalwindowhannPoint) -> SignalwindowhannPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowhannPoint::lerp(self : SignalwindowhannPoint, other : SignalwindowhannPoint, t : Double) -> SignalwindowhannPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowhannPoint::to_string(self : SignalwindowhannPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowhannSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_hann_make_series(vals : Array[Double], name : String) -> SignalwindowhannSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowhannSeries::len(self : SignalwindowhannSeries) -> Int { self.vals.length() }

pub fn SignalwindowhannSeries::sum(self : SignalwindowhannSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowhannSeries::mean(self : SignalwindowhannSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowhannSeries::min(self : SignalwindowhannSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowhannSeries::max(self : SignalwindowhannSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowhannSeries::range(self : SignalwindowhannSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowhannSeries::variance(self : SignalwindowhannSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowhannSeries::std(self : SignalwindowhannSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowhannSeries::median(self : SignalwindowhannSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowhannSeries::scale(self : SignalwindowhannSeries, f : Double) -> SignalwindowhannSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowhannSeries::add(self : SignalwindowhannSeries, other : SignalwindowhannSeries) -> SignalwindowhannSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowhannSeries::sub(self : SignalwindowhannSeries, other : SignalwindowhannSeries) -> SignalwindowhannSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowhannSeries::normalize(self : SignalwindowhannSeries) -> SignalwindowhannSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowhannSeries::cumsum(self : SignalwindowhannSeries) -> SignalwindowhannSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowhannSeries::to_string(self : SignalwindowhannSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowhannMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_hann_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowhannMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_hann_matrix_identity(n : Int) -> SignalwindowhannMatrix {
  let m = signal_window_hann_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowhannMatrix::get(self : SignalwindowhannMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowhannMatrix::transpose(self : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowhannMatrix::add(self : SignalwindowhannMatrix, other : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_hann_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowhannMatrix::scale(self : SignalwindowhannMatrix, s : Double) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowhannMatrix::multiply(self : SignalwindowhannMatrix, other : SignalwindowhannMatrix) -> SignalwindowhannMatrix {
  if self.cols != other.rows { return signal_window_hann_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_hann_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowhannMatrix::trace(self : SignalwindowhannMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowhannMatrix::det(self : SignalwindowhannMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowhannMatrix::norm(self : SignalwindowhannMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowhannMatrix::to_string(self : SignalwindowhannMatrix) -> String {
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

pub(all) struct SignalwindowhannVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_hann_make_vector(comps : Array[Double]) -> SignalwindowhannVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_hann_vector_zero(dim : Int) -> SignalwindowhannVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowhannVector::add(self : SignalwindowhannVector, other : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowhannVector::sub(self : SignalwindowhannVector, other : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowhannVector::scale(self : SignalwindowhannVector, s : Double) -> SignalwindowhannVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowhannVector::dot(self : SignalwindowhannVector, other : SignalwindowhannVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowhannVector::norm(self : SignalwindowhannVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowhannVector::normalize(self : SignalwindowhannVector) -> SignalwindowhannVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowhannVector::dist(self : SignalwindowhannVector, other : SignalwindowhannVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowhannVector::to_string(self : SignalwindowhannVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_hann_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_hann_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_hann_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_hann_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_hann_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_hann_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_hann_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_hann_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_hann_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_hann_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_hann_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_hann_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_hann_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_hann_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_hann_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_hann_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_hann_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_hann_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_hann_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_hann_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_hann_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_hann_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_hann_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_hann_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_hann_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_hann_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_hann_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_hann_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_hann_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowhannFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_frame_make(size : Int) -> SignalwindowhannFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_frame_len(s : SignalwindowhannFrame) -> Int { s.size }

pub fn signal_window_hann_frame_get(s : SignalwindowhannFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_frame_set(s : SignalwindowhannFrame, i : Int, v : Double) -> SignalwindowhannFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_frame_sum(s : SignalwindowhannFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_frame_mean(s : SignalwindowhannFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_frame_scale(s : SignalwindowhannFrame, f : Double) -> SignalwindowhannFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_frame_add(a : SignalwindowhannFrame, b : SignalwindowhannFrame) -> SignalwindowhannFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_frame_copy(s : SignalwindowhannFrame) -> SignalwindowhannFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_frame_fill(s : SignalwindowhannFrame, v : Double) -> SignalwindowhannFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_frame_min(s : SignalwindowhannFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_frame_max(s : SignalwindowhannFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_frame_to_string(s : SignalwindowhannFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_table_make(size : Int) -> SignalwindowhannTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_table_len(s : SignalwindowhannTable) -> Int { s.size }

pub fn signal_window_hann_table_get(s : SignalwindowhannTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_table_set(s : SignalwindowhannTable, i : Int, v : Double) -> SignalwindowhannTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_table_sum(s : SignalwindowhannTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_table_mean(s : SignalwindowhannTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_table_scale(s : SignalwindowhannTable, f : Double) -> SignalwindowhannTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_table_add(a : SignalwindowhannTable, b : SignalwindowhannTable) -> SignalwindowhannTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_table_copy(s : SignalwindowhannTable) -> SignalwindowhannTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_table_fill(s : SignalwindowhannTable, v : Double) -> SignalwindowhannTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_table_min(s : SignalwindowhannTable) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_table_max(s : SignalwindowhannTable) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_table_to_string(s : SignalwindowhannTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_graphn_make(size : Int) -> SignalwindowhannGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_graphn_len(s : SignalwindowhannGraphN) -> Int { s.size }

pub fn signal_window_hann_graphn_get(s : SignalwindowhannGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_graphn_set(s : SignalwindowhannGraphN, i : Int, v : Double) -> SignalwindowhannGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_graphn_sum(s : SignalwindowhannGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_graphn_mean(s : SignalwindowhannGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_graphn_scale(s : SignalwindowhannGraphN, f : Double) -> SignalwindowhannGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_graphn_add(a : SignalwindowhannGraphN, b : SignalwindowhannGraphN) -> SignalwindowhannGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_graphn_copy(s : SignalwindowhannGraphN) -> SignalwindowhannGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_graphn_fill(s : SignalwindowhannGraphN, v : Double) -> SignalwindowhannGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_graphn_min(s : SignalwindowhannGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_graphn_max(s : SignalwindowhannGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_graphn_to_string(s : SignalwindowhannGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_node_make(size : Int) -> SignalwindowhannNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_node_len(s : SignalwindowhannNode) -> Int { s.size }

pub fn signal_window_hann_node_get(s : SignalwindowhannNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_node_set(s : SignalwindowhannNode, i : Int, v : Double) -> SignalwindowhannNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_node_sum(s : SignalwindowhannNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_node_mean(s : SignalwindowhannNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_node_scale(s : SignalwindowhannNode, f : Double) -> SignalwindowhannNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_node_add(a : SignalwindowhannNode, b : SignalwindowhannNode) -> SignalwindowhannNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_node_copy(s : SignalwindowhannNode) -> SignalwindowhannNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_node_fill(s : SignalwindowhannNode, v : Double) -> SignalwindowhannNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_node_min(s : SignalwindowhannNode) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_node_max(s : SignalwindowhannNode) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_node_to_string(s : SignalwindowhannNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_edge_make(size : Int) -> SignalwindowhannEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_edge_len(s : SignalwindowhannEdge) -> Int { s.size }

pub fn signal_window_hann_edge_get(s : SignalwindowhannEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_edge_set(s : SignalwindowhannEdge, i : Int, v : Double) -> SignalwindowhannEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_edge_sum(s : SignalwindowhannEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_edge_mean(s : SignalwindowhannEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_edge_scale(s : SignalwindowhannEdge, f : Double) -> SignalwindowhannEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_edge_add(a : SignalwindowhannEdge, b : SignalwindowhannEdge) -> SignalwindowhannEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_edge_copy(s : SignalwindowhannEdge) -> SignalwindowhannEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_edge_fill(s : SignalwindowhannEdge, v : Double) -> SignalwindowhannEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_edge_min(s : SignalwindowhannEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_edge_max(s : SignalwindowhannEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_edge_to_string(s : SignalwindowhannEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_path_make(size : Int) -> SignalwindowhannPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_path_len(s : SignalwindowhannPath) -> Int { s.size }

pub fn signal_window_hann_path_get(s : SignalwindowhannPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_path_set(s : SignalwindowhannPath, i : Int, v : Double) -> SignalwindowhannPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_path_sum(s : SignalwindowhannPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_path_mean(s : SignalwindowhannPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_path_scale(s : SignalwindowhannPath, f : Double) -> SignalwindowhannPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_path_add(a : SignalwindowhannPath, b : SignalwindowhannPath) -> SignalwindowhannPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_path_copy(s : SignalwindowhannPath) -> SignalwindowhannPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_path_fill(s : SignalwindowhannPath, v : Double) -> SignalwindowhannPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_path_min(s : SignalwindowhannPath) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_path_max(s : SignalwindowhannPath) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_path_to_string(s : SignalwindowhannPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_cluster_make(size : Int) -> SignalwindowhannCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_cluster_len(s : SignalwindowhannCluster) -> Int { s.size }

pub fn signal_window_hann_cluster_get(s : SignalwindowhannCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_cluster_set(s : SignalwindowhannCluster, i : Int, v : Double) -> SignalwindowhannCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cluster_sum(s : SignalwindowhannCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_cluster_mean(s : SignalwindowhannCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_cluster_scale(s : SignalwindowhannCluster, f : Double) -> SignalwindowhannCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cluster_add(a : SignalwindowhannCluster, b : SignalwindowhannCluster) -> SignalwindowhannCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_cluster_copy(s : SignalwindowhannCluster) -> SignalwindowhannCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cluster_fill(s : SignalwindowhannCluster, v : Double) -> SignalwindowhannCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cluster_min(s : SignalwindowhannCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_cluster_max(s : SignalwindowhannCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_cluster_to_string(s : SignalwindowhannCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_model_make(size : Int) -> SignalwindowhannModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_model_len(s : SignalwindowhannModel) -> Int { s.size }

pub fn signal_window_hann_model_get(s : SignalwindowhannModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_model_set(s : SignalwindowhannModel, i : Int, v : Double) -> SignalwindowhannModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_model_sum(s : SignalwindowhannModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_model_mean(s : SignalwindowhannModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_model_scale(s : SignalwindowhannModel, f : Double) -> SignalwindowhannModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_model_add(a : SignalwindowhannModel, b : SignalwindowhannModel) -> SignalwindowhannModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_model_copy(s : SignalwindowhannModel) -> SignalwindowhannModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_model_fill(s : SignalwindowhannModel, v : Double) -> SignalwindowhannModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_model_min(s : SignalwindowhannModel) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_model_max(s : SignalwindowhannModel) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_model_to_string(s : SignalwindowhannModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_layer_make(size : Int) -> SignalwindowhannLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_layer_len(s : SignalwindowhannLayer) -> Int { s.size }

pub fn signal_window_hann_layer_get(s : SignalwindowhannLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_layer_set(s : SignalwindowhannLayer, i : Int, v : Double) -> SignalwindowhannLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_layer_sum(s : SignalwindowhannLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_layer_mean(s : SignalwindowhannLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_layer_scale(s : SignalwindowhannLayer, f : Double) -> SignalwindowhannLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_layer_add(a : SignalwindowhannLayer, b : SignalwindowhannLayer) -> SignalwindowhannLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_layer_copy(s : SignalwindowhannLayer) -> SignalwindowhannLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_layer_fill(s : SignalwindowhannLayer, v : Double) -> SignalwindowhannLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_layer_min(s : SignalwindowhannLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_layer_max(s : SignalwindowhannLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_layer_to_string(s : SignalwindowhannLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_buffer_make(size : Int) -> SignalwindowhannBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_buffer_len(s : SignalwindowhannBuffer) -> Int { s.size }

pub fn signal_window_hann_buffer_get(s : SignalwindowhannBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_buffer_set(s : SignalwindowhannBuffer, i : Int, v : Double) -> SignalwindowhannBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_buffer_sum(s : SignalwindowhannBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_buffer_mean(s : SignalwindowhannBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_buffer_scale(s : SignalwindowhannBuffer, f : Double) -> SignalwindowhannBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_buffer_add(a : SignalwindowhannBuffer, b : SignalwindowhannBuffer) -> SignalwindowhannBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_buffer_copy(s : SignalwindowhannBuffer) -> SignalwindowhannBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_buffer_fill(s : SignalwindowhannBuffer, v : Double) -> SignalwindowhannBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_buffer_min(s : SignalwindowhannBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_buffer_max(s : SignalwindowhannBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_buffer_to_string(s : SignalwindowhannBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_cursor_make(size : Int) -> SignalwindowhannCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_cursor_len(s : SignalwindowhannCursor) -> Int { s.size }

pub fn signal_window_hann_cursor_get(s : SignalwindowhannCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_cursor_set(s : SignalwindowhannCursor, i : Int, v : Double) -> SignalwindowhannCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cursor_sum(s : SignalwindowhannCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_cursor_mean(s : SignalwindowhannCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_cursor_scale(s : SignalwindowhannCursor, f : Double) -> SignalwindowhannCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cursor_add(a : SignalwindowhannCursor, b : SignalwindowhannCursor) -> SignalwindowhannCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_cursor_copy(s : SignalwindowhannCursor) -> SignalwindowhannCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cursor_fill(s : SignalwindowhannCursor, v : Double) -> SignalwindowhannCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_cursor_min(s : SignalwindowhannCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_cursor_max(s : SignalwindowhannCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_cursor_to_string(s : SignalwindowhannCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_view_make(size : Int) -> SignalwindowhannView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_view_len(s : SignalwindowhannView) -> Int { s.size }

pub fn signal_window_hann_view_get(s : SignalwindowhannView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_view_set(s : SignalwindowhannView, i : Int, v : Double) -> SignalwindowhannView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_view_sum(s : SignalwindowhannView) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_view_mean(s : SignalwindowhannView) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_view_scale(s : SignalwindowhannView, f : Double) -> SignalwindowhannView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_view_add(a : SignalwindowhannView, b : SignalwindowhannView) -> SignalwindowhannView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_view_copy(s : SignalwindowhannView) -> SignalwindowhannView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_view_fill(s : SignalwindowhannView, v : Double) -> SignalwindowhannView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_view_min(s : SignalwindowhannView) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_view_max(s : SignalwindowhannView) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_view_to_string(s : SignalwindowhannView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_range_make(size : Int) -> SignalwindowhannRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_range_len(s : SignalwindowhannRange) -> Int { s.size }

pub fn signal_window_hann_range_get(s : SignalwindowhannRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_range_set(s : SignalwindowhannRange, i : Int, v : Double) -> SignalwindowhannRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_range_sum(s : SignalwindowhannRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_range_mean(s : SignalwindowhannRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_range_scale(s : SignalwindowhannRange, f : Double) -> SignalwindowhannRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_range_add(a : SignalwindowhannRange, b : SignalwindowhannRange) -> SignalwindowhannRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_range_copy(s : SignalwindowhannRange) -> SignalwindowhannRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_range_fill(s : SignalwindowhannRange, v : Double) -> SignalwindowhannRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_range_min(s : SignalwindowhannRange) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_range_max(s : SignalwindowhannRange) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_range_to_string(s : SignalwindowhannRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhannSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hann_slice_make(size : Int) -> SignalwindowhannSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hann_slice_len(s : SignalwindowhannSlice) -> Int { s.size }

pub fn signal_window_hann_slice_get(s : SignalwindowhannSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hann_slice_set(s : SignalwindowhannSlice, i : Int, v : Double) -> SignalwindowhannSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hann_slice_sum(s : SignalwindowhannSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_hann_slice_mean(s : SignalwindowhannSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_hann_slice_scale(s : SignalwindowhannSlice, f : Double) -> SignalwindowhannSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_slice_add(a : SignalwindowhannSlice, b : SignalwindowhannSlice) -> SignalwindowhannSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hann_slice_copy(s : SignalwindowhannSlice) -> SignalwindowhannSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_slice_fill(s : SignalwindowhannSlice, v : Double) -> SignalwindowhannSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hann_slice_min(s : SignalwindowhannSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_hann_slice_max(s : SignalwindowhannSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_hann_slice_to_string(s : SignalwindowhannSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

