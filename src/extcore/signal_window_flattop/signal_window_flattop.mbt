///===
/// extcore/signal_window_flattop

pub(all) struct SignalwindowflattopPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_flattop_make_point(x : Double, y : Double) -> SignalwindowflattopPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_flattop_make_point3(x : Double, y : Double, z : Double) -> SignalwindowflattopPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowflattopPoint::x(self : SignalwindowflattopPoint) -> Double { self.x }

pub fn SignalwindowflattopPoint::y(self : SignalwindowflattopPoint) -> Double { self.y }

pub fn SignalwindowflattopPoint::z(self : SignalwindowflattopPoint) -> Double { self.z }

pub fn SignalwindowflattopPoint::label(self : SignalwindowflattopPoint) -> Int { self.label }

pub fn SignalwindowflattopPoint::dist(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowflattopPoint::add(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowflattopPoint::sub(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowflattopPoint::scale(self : SignalwindowflattopPoint, s : Double) -> SignalwindowflattopPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowflattopPoint::dot(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowflattopPoint::cross(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowflattopPoint::norm(self : SignalwindowflattopPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowflattopPoint::normalize(self : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowflattopPoint::negate(self : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowflattopPoint::mid(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint) -> SignalwindowflattopPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowflattopPoint::lerp(self : SignalwindowflattopPoint, other : SignalwindowflattopPoint, t : Double) -> SignalwindowflattopPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowflattopPoint::to_string(self : SignalwindowflattopPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowflattopSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_flattop_make_series(vals : Array[Double], name : String) -> SignalwindowflattopSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowflattopSeries::len(self : SignalwindowflattopSeries) -> Int { self.vals.length() }

pub fn SignalwindowflattopSeries::sum(self : SignalwindowflattopSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowflattopSeries::mean(self : SignalwindowflattopSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowflattopSeries::min(self : SignalwindowflattopSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowflattopSeries::max(self : SignalwindowflattopSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowflattopSeries::range(self : SignalwindowflattopSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowflattopSeries::variance(self : SignalwindowflattopSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowflattopSeries::std(self : SignalwindowflattopSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowflattopSeries::median(self : SignalwindowflattopSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowflattopSeries::scale(self : SignalwindowflattopSeries, f : Double) -> SignalwindowflattopSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowflattopSeries::add(self : SignalwindowflattopSeries, other : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowflattopSeries::sub(self : SignalwindowflattopSeries, other : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowflattopSeries::normalize(self : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowflattopSeries::cumsum(self : SignalwindowflattopSeries) -> SignalwindowflattopSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowflattopSeries::to_string(self : SignalwindowflattopSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowflattopMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_flattop_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowflattopMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_flattop_matrix_identity(n : Int) -> SignalwindowflattopMatrix {
  let m = signal_window_flattop_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowflattopMatrix::get(self : SignalwindowflattopMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowflattopMatrix::transpose(self : SignalwindowflattopMatrix) -> SignalwindowflattopMatrix {
  let result = signal_window_flattop_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowflattopMatrix::add(self : SignalwindowflattopMatrix, other : SignalwindowflattopMatrix) -> SignalwindowflattopMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_flattop_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowflattopMatrix::scale(self : SignalwindowflattopMatrix, s : Double) -> SignalwindowflattopMatrix {
  let result = signal_window_flattop_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowflattopMatrix::multiply(self : SignalwindowflattopMatrix, other : SignalwindowflattopMatrix) -> SignalwindowflattopMatrix {
  if self.cols != other.rows { return signal_window_flattop_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_flattop_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowflattopMatrix::trace(self : SignalwindowflattopMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowflattopMatrix::det(self : SignalwindowflattopMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowflattopMatrix::norm(self : SignalwindowflattopMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowflattopMatrix::to_string(self : SignalwindowflattopMatrix) -> String {
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

pub(all) struct SignalwindowflattopVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_flattop_make_vector(comps : Array[Double]) -> SignalwindowflattopVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_flattop_vector_zero(dim : Int) -> SignalwindowflattopVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowflattopVector::add(self : SignalwindowflattopVector, other : SignalwindowflattopVector) -> SignalwindowflattopVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowflattopVector::sub(self : SignalwindowflattopVector, other : SignalwindowflattopVector) -> SignalwindowflattopVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowflattopVector::scale(self : SignalwindowflattopVector, s : Double) -> SignalwindowflattopVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowflattopVector::dot(self : SignalwindowflattopVector, other : SignalwindowflattopVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowflattopVector::norm(self : SignalwindowflattopVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowflattopVector::normalize(self : SignalwindowflattopVector) -> SignalwindowflattopVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowflattopVector::dist(self : SignalwindowflattopVector, other : SignalwindowflattopVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowflattopVector::to_string(self : SignalwindowflattopVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_flattop_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_flattop_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_flattop_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_flattop_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_flattop_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_flattop_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_flattop_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_flattop_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_flattop_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_flattop_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_flattop_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_flattop_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_flattop_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_flattop_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_flattop_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_flattop_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_flattop_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_flattop_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_flattop_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_flattop_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_flattop_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_flattop_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_flattop_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_flattop_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_flattop_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_flattop_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_flattop_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_flattop_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_flattop_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowflattopFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_frame_make(size : Int) -> SignalwindowflattopFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_frame_len(s : SignalwindowflattopFrame) -> Int { s.size }

pub fn signal_window_flattop_frame_get(s : SignalwindowflattopFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_frame_set(s : SignalwindowflattopFrame, i : Int, v : Double) -> SignalwindowflattopFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_frame_sum(s : SignalwindowflattopFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_frame_mean(s : SignalwindowflattopFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_frame_scale(s : SignalwindowflattopFrame, f : Double) -> SignalwindowflattopFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_frame_add(a : SignalwindowflattopFrame, b : SignalwindowflattopFrame) -> SignalwindowflattopFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_frame_copy(s : SignalwindowflattopFrame) -> SignalwindowflattopFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_frame_fill(s : SignalwindowflattopFrame, v : Double) -> SignalwindowflattopFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_frame_min(s : SignalwindowflattopFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_frame_max(s : SignalwindowflattopFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_frame_to_string(s : SignalwindowflattopFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_table_make(size : Int) -> SignalwindowflattopTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_table_len(s : SignalwindowflattopTable) -> Int { s.size }

pub fn signal_window_flattop_table_get(s : SignalwindowflattopTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_table_set(s : SignalwindowflattopTable, i : Int, v : Double) -> SignalwindowflattopTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_table_sum(s : SignalwindowflattopTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_table_mean(s : SignalwindowflattopTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_table_scale(s : SignalwindowflattopTable, f : Double) -> SignalwindowflattopTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_table_add(a : SignalwindowflattopTable, b : SignalwindowflattopTable) -> SignalwindowflattopTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_table_copy(s : SignalwindowflattopTable) -> SignalwindowflattopTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_table_fill(s : SignalwindowflattopTable, v : Double) -> SignalwindowflattopTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_table_min(s : SignalwindowflattopTable) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_table_max(s : SignalwindowflattopTable) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_table_to_string(s : SignalwindowflattopTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_graphn_make(size : Int) -> SignalwindowflattopGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_graphn_len(s : SignalwindowflattopGraphN) -> Int { s.size }

pub fn signal_window_flattop_graphn_get(s : SignalwindowflattopGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_graphn_set(s : SignalwindowflattopGraphN, i : Int, v : Double) -> SignalwindowflattopGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_graphn_sum(s : SignalwindowflattopGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_graphn_mean(s : SignalwindowflattopGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_graphn_scale(s : SignalwindowflattopGraphN, f : Double) -> SignalwindowflattopGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_graphn_add(a : SignalwindowflattopGraphN, b : SignalwindowflattopGraphN) -> SignalwindowflattopGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_graphn_copy(s : SignalwindowflattopGraphN) -> SignalwindowflattopGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_graphn_fill(s : SignalwindowflattopGraphN, v : Double) -> SignalwindowflattopGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_graphn_min(s : SignalwindowflattopGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_graphn_max(s : SignalwindowflattopGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_graphn_to_string(s : SignalwindowflattopGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_node_make(size : Int) -> SignalwindowflattopNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_node_len(s : SignalwindowflattopNode) -> Int { s.size }

pub fn signal_window_flattop_node_get(s : SignalwindowflattopNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_node_set(s : SignalwindowflattopNode, i : Int, v : Double) -> SignalwindowflattopNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_node_sum(s : SignalwindowflattopNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_node_mean(s : SignalwindowflattopNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_node_scale(s : SignalwindowflattopNode, f : Double) -> SignalwindowflattopNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_node_add(a : SignalwindowflattopNode, b : SignalwindowflattopNode) -> SignalwindowflattopNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_node_copy(s : SignalwindowflattopNode) -> SignalwindowflattopNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_node_fill(s : SignalwindowflattopNode, v : Double) -> SignalwindowflattopNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_node_min(s : SignalwindowflattopNode) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_node_max(s : SignalwindowflattopNode) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_node_to_string(s : SignalwindowflattopNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_edge_make(size : Int) -> SignalwindowflattopEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_edge_len(s : SignalwindowflattopEdge) -> Int { s.size }

pub fn signal_window_flattop_edge_get(s : SignalwindowflattopEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_edge_set(s : SignalwindowflattopEdge, i : Int, v : Double) -> SignalwindowflattopEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_edge_sum(s : SignalwindowflattopEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_edge_mean(s : SignalwindowflattopEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_edge_scale(s : SignalwindowflattopEdge, f : Double) -> SignalwindowflattopEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_edge_add(a : SignalwindowflattopEdge, b : SignalwindowflattopEdge) -> SignalwindowflattopEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_edge_copy(s : SignalwindowflattopEdge) -> SignalwindowflattopEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_edge_fill(s : SignalwindowflattopEdge, v : Double) -> SignalwindowflattopEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_edge_min(s : SignalwindowflattopEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_edge_max(s : SignalwindowflattopEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_edge_to_string(s : SignalwindowflattopEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_path_make(size : Int) -> SignalwindowflattopPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_path_len(s : SignalwindowflattopPath) -> Int { s.size }

pub fn signal_window_flattop_path_get(s : SignalwindowflattopPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_path_set(s : SignalwindowflattopPath, i : Int, v : Double) -> SignalwindowflattopPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_path_sum(s : SignalwindowflattopPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_path_mean(s : SignalwindowflattopPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_path_scale(s : SignalwindowflattopPath, f : Double) -> SignalwindowflattopPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_path_add(a : SignalwindowflattopPath, b : SignalwindowflattopPath) -> SignalwindowflattopPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_path_copy(s : SignalwindowflattopPath) -> SignalwindowflattopPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_path_fill(s : SignalwindowflattopPath, v : Double) -> SignalwindowflattopPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_path_min(s : SignalwindowflattopPath) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_path_max(s : SignalwindowflattopPath) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_path_to_string(s : SignalwindowflattopPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_cluster_make(size : Int) -> SignalwindowflattopCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_cluster_len(s : SignalwindowflattopCluster) -> Int { s.size }

pub fn signal_window_flattop_cluster_get(s : SignalwindowflattopCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_cluster_set(s : SignalwindowflattopCluster, i : Int, v : Double) -> SignalwindowflattopCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cluster_sum(s : SignalwindowflattopCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_cluster_mean(s : SignalwindowflattopCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_cluster_scale(s : SignalwindowflattopCluster, f : Double) -> SignalwindowflattopCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cluster_add(a : SignalwindowflattopCluster, b : SignalwindowflattopCluster) -> SignalwindowflattopCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_cluster_copy(s : SignalwindowflattopCluster) -> SignalwindowflattopCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cluster_fill(s : SignalwindowflattopCluster, v : Double) -> SignalwindowflattopCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cluster_min(s : SignalwindowflattopCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_cluster_max(s : SignalwindowflattopCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_cluster_to_string(s : SignalwindowflattopCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_model_make(size : Int) -> SignalwindowflattopModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_model_len(s : SignalwindowflattopModel) -> Int { s.size }

pub fn signal_window_flattop_model_get(s : SignalwindowflattopModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_model_set(s : SignalwindowflattopModel, i : Int, v : Double) -> SignalwindowflattopModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_model_sum(s : SignalwindowflattopModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_model_mean(s : SignalwindowflattopModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_model_scale(s : SignalwindowflattopModel, f : Double) -> SignalwindowflattopModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_model_add(a : SignalwindowflattopModel, b : SignalwindowflattopModel) -> SignalwindowflattopModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_model_copy(s : SignalwindowflattopModel) -> SignalwindowflattopModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_model_fill(s : SignalwindowflattopModel, v : Double) -> SignalwindowflattopModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_model_min(s : SignalwindowflattopModel) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_model_max(s : SignalwindowflattopModel) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_model_to_string(s : SignalwindowflattopModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_layer_make(size : Int) -> SignalwindowflattopLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_layer_len(s : SignalwindowflattopLayer) -> Int { s.size }

pub fn signal_window_flattop_layer_get(s : SignalwindowflattopLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_layer_set(s : SignalwindowflattopLayer, i : Int, v : Double) -> SignalwindowflattopLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_layer_sum(s : SignalwindowflattopLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_layer_mean(s : SignalwindowflattopLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_layer_scale(s : SignalwindowflattopLayer, f : Double) -> SignalwindowflattopLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_layer_add(a : SignalwindowflattopLayer, b : SignalwindowflattopLayer) -> SignalwindowflattopLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_layer_copy(s : SignalwindowflattopLayer) -> SignalwindowflattopLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_layer_fill(s : SignalwindowflattopLayer, v : Double) -> SignalwindowflattopLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_layer_min(s : SignalwindowflattopLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_layer_max(s : SignalwindowflattopLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_layer_to_string(s : SignalwindowflattopLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_buffer_make(size : Int) -> SignalwindowflattopBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_buffer_len(s : SignalwindowflattopBuffer) -> Int { s.size }

pub fn signal_window_flattop_buffer_get(s : SignalwindowflattopBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_buffer_set(s : SignalwindowflattopBuffer, i : Int, v : Double) -> SignalwindowflattopBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_buffer_sum(s : SignalwindowflattopBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_buffer_mean(s : SignalwindowflattopBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_buffer_scale(s : SignalwindowflattopBuffer, f : Double) -> SignalwindowflattopBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_buffer_add(a : SignalwindowflattopBuffer, b : SignalwindowflattopBuffer) -> SignalwindowflattopBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_buffer_copy(s : SignalwindowflattopBuffer) -> SignalwindowflattopBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_buffer_fill(s : SignalwindowflattopBuffer, v : Double) -> SignalwindowflattopBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_buffer_min(s : SignalwindowflattopBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_buffer_max(s : SignalwindowflattopBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_buffer_to_string(s : SignalwindowflattopBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_cursor_make(size : Int) -> SignalwindowflattopCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_cursor_len(s : SignalwindowflattopCursor) -> Int { s.size }

pub fn signal_window_flattop_cursor_get(s : SignalwindowflattopCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_cursor_set(s : SignalwindowflattopCursor, i : Int, v : Double) -> SignalwindowflattopCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cursor_sum(s : SignalwindowflattopCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_cursor_mean(s : SignalwindowflattopCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_cursor_scale(s : SignalwindowflattopCursor, f : Double) -> SignalwindowflattopCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cursor_add(a : SignalwindowflattopCursor, b : SignalwindowflattopCursor) -> SignalwindowflattopCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_cursor_copy(s : SignalwindowflattopCursor) -> SignalwindowflattopCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cursor_fill(s : SignalwindowflattopCursor, v : Double) -> SignalwindowflattopCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_cursor_min(s : SignalwindowflattopCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_cursor_max(s : SignalwindowflattopCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_cursor_to_string(s : SignalwindowflattopCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_view_make(size : Int) -> SignalwindowflattopView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_view_len(s : SignalwindowflattopView) -> Int { s.size }

pub fn signal_window_flattop_view_get(s : SignalwindowflattopView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_view_set(s : SignalwindowflattopView, i : Int, v : Double) -> SignalwindowflattopView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_view_sum(s : SignalwindowflattopView) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_view_mean(s : SignalwindowflattopView) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_view_scale(s : SignalwindowflattopView, f : Double) -> SignalwindowflattopView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_view_add(a : SignalwindowflattopView, b : SignalwindowflattopView) -> SignalwindowflattopView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_view_copy(s : SignalwindowflattopView) -> SignalwindowflattopView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_view_fill(s : SignalwindowflattopView, v : Double) -> SignalwindowflattopView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_view_min(s : SignalwindowflattopView) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_view_max(s : SignalwindowflattopView) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_view_to_string(s : SignalwindowflattopView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_range_make(size : Int) -> SignalwindowflattopRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_range_len(s : SignalwindowflattopRange) -> Int { s.size }

pub fn signal_window_flattop_range_get(s : SignalwindowflattopRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_range_set(s : SignalwindowflattopRange, i : Int, v : Double) -> SignalwindowflattopRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_range_sum(s : SignalwindowflattopRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_range_mean(s : SignalwindowflattopRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_range_scale(s : SignalwindowflattopRange, f : Double) -> SignalwindowflattopRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_range_add(a : SignalwindowflattopRange, b : SignalwindowflattopRange) -> SignalwindowflattopRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_range_copy(s : SignalwindowflattopRange) -> SignalwindowflattopRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_range_fill(s : SignalwindowflattopRange, v : Double) -> SignalwindowflattopRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_range_min(s : SignalwindowflattopRange) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_range_max(s : SignalwindowflattopRange) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_range_to_string(s : SignalwindowflattopRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_slice_make(size : Int) -> SignalwindowflattopSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_flattop_slice_len(s : SignalwindowflattopSlice) -> Int { s.size }

pub fn signal_window_flattop_slice_get(s : SignalwindowflattopSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_flattop_slice_set(s : SignalwindowflattopSlice, i : Int, v : Double) -> SignalwindowflattopSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_slice_sum(s : SignalwindowflattopSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_flattop_slice_mean(s : SignalwindowflattopSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_flattop_slice_scale(s : SignalwindowflattopSlice, f : Double) -> SignalwindowflattopSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_slice_add(a : SignalwindowflattopSlice, b : SignalwindowflattopSlice) -> SignalwindowflattopSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_flattop_slice_copy(s : SignalwindowflattopSlice) -> SignalwindowflattopSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_slice_fill(s : SignalwindowflattopSlice, v : Double) -> SignalwindowflattopSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_flattop_slice_min(s : SignalwindowflattopSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_flattop_slice_max(s : SignalwindowflattopSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_flattop_slice_to_string(s : SignalwindowflattopSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

