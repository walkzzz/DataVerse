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

pub fn SignalwindowflattopFrame::len(self : SignalwindowflattopFrame) -> Int { self.size }

pub fn SignalwindowflattopFrame::get(self : SignalwindowflattopFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopFrame::set(self : SignalwindowflattopFrame, i : Int, v : Double) -> SignalwindowflattopFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopFrame::sum(self : SignalwindowflattopFrame) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopFrame::mean(self : SignalwindowflattopFrame) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopFrame::scale(self : SignalwindowflattopFrame, f : Double) -> SignalwindowflattopFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopFrame::add(self : SignalwindowflattopFrame, other : SignalwindowflattopFrame) -> SignalwindowflattopFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopFrame::copy(self : SignalwindowflattopFrame) -> SignalwindowflattopFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopFrame::fill(self : SignalwindowflattopFrame, v : Double) -> SignalwindowflattopFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopFrame::min(self : SignalwindowflattopFrame) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopFrame::max(self : SignalwindowflattopFrame) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopFrame::to_string(self : SignalwindowflattopFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_table_make(size : Int) -> SignalwindowflattopTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopTable::len(self : SignalwindowflattopTable) -> Int { self.size }

pub fn SignalwindowflattopTable::get(self : SignalwindowflattopTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopTable::set(self : SignalwindowflattopTable, i : Int, v : Double) -> SignalwindowflattopTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopTable::sum(self : SignalwindowflattopTable) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopTable::mean(self : SignalwindowflattopTable) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopTable::scale(self : SignalwindowflattopTable, f : Double) -> SignalwindowflattopTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopTable::add(self : SignalwindowflattopTable, other : SignalwindowflattopTable) -> SignalwindowflattopTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopTable::copy(self : SignalwindowflattopTable) -> SignalwindowflattopTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopTable::fill(self : SignalwindowflattopTable, v : Double) -> SignalwindowflattopTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopTable::min(self : SignalwindowflattopTable) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopTable::max(self : SignalwindowflattopTable) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopTable::to_string(self : SignalwindowflattopTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_graphn_make(size : Int) -> SignalwindowflattopGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopGraphN::len(self : SignalwindowflattopGraphN) -> Int { self.size }

pub fn SignalwindowflattopGraphN::get(self : SignalwindowflattopGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopGraphN::set(self : SignalwindowflattopGraphN, i : Int, v : Double) -> SignalwindowflattopGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopGraphN::sum(self : SignalwindowflattopGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopGraphN::mean(self : SignalwindowflattopGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopGraphN::scale(self : SignalwindowflattopGraphN, f : Double) -> SignalwindowflattopGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopGraphN::add(self : SignalwindowflattopGraphN, other : SignalwindowflattopGraphN) -> SignalwindowflattopGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopGraphN::copy(self : SignalwindowflattopGraphN) -> SignalwindowflattopGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopGraphN::fill(self : SignalwindowflattopGraphN, v : Double) -> SignalwindowflattopGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopGraphN::min(self : SignalwindowflattopGraphN) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopGraphN::max(self : SignalwindowflattopGraphN) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopGraphN::to_string(self : SignalwindowflattopGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_node_make(size : Int) -> SignalwindowflattopNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopNode::len(self : SignalwindowflattopNode) -> Int { self.size }

pub fn SignalwindowflattopNode::get(self : SignalwindowflattopNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopNode::set(self : SignalwindowflattopNode, i : Int, v : Double) -> SignalwindowflattopNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopNode::sum(self : SignalwindowflattopNode) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopNode::mean(self : SignalwindowflattopNode) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopNode::scale(self : SignalwindowflattopNode, f : Double) -> SignalwindowflattopNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopNode::add(self : SignalwindowflattopNode, other : SignalwindowflattopNode) -> SignalwindowflattopNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopNode::copy(self : SignalwindowflattopNode) -> SignalwindowflattopNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopNode::fill(self : SignalwindowflattopNode, v : Double) -> SignalwindowflattopNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopNode::min(self : SignalwindowflattopNode) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopNode::max(self : SignalwindowflattopNode) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopNode::to_string(self : SignalwindowflattopNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_edge_make(size : Int) -> SignalwindowflattopEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopEdge::len(self : SignalwindowflattopEdge) -> Int { self.size }

pub fn SignalwindowflattopEdge::get(self : SignalwindowflattopEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopEdge::set(self : SignalwindowflattopEdge, i : Int, v : Double) -> SignalwindowflattopEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopEdge::sum(self : SignalwindowflattopEdge) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopEdge::mean(self : SignalwindowflattopEdge) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopEdge::scale(self : SignalwindowflattopEdge, f : Double) -> SignalwindowflattopEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopEdge::add(self : SignalwindowflattopEdge, other : SignalwindowflattopEdge) -> SignalwindowflattopEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopEdge::copy(self : SignalwindowflattopEdge) -> SignalwindowflattopEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopEdge::fill(self : SignalwindowflattopEdge, v : Double) -> SignalwindowflattopEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopEdge::min(self : SignalwindowflattopEdge) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopEdge::max(self : SignalwindowflattopEdge) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopEdge::to_string(self : SignalwindowflattopEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_path_make(size : Int) -> SignalwindowflattopPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopPath::len(self : SignalwindowflattopPath) -> Int { self.size }

pub fn SignalwindowflattopPath::get(self : SignalwindowflattopPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopPath::set(self : SignalwindowflattopPath, i : Int, v : Double) -> SignalwindowflattopPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopPath::sum(self : SignalwindowflattopPath) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopPath::mean(self : SignalwindowflattopPath) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopPath::scale(self : SignalwindowflattopPath, f : Double) -> SignalwindowflattopPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopPath::add(self : SignalwindowflattopPath, other : SignalwindowflattopPath) -> SignalwindowflattopPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopPath::copy(self : SignalwindowflattopPath) -> SignalwindowflattopPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopPath::fill(self : SignalwindowflattopPath, v : Double) -> SignalwindowflattopPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopPath::min(self : SignalwindowflattopPath) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopPath::max(self : SignalwindowflattopPath) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopPath::to_string(self : SignalwindowflattopPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_cluster_make(size : Int) -> SignalwindowflattopCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopCluster::len(self : SignalwindowflattopCluster) -> Int { self.size }

pub fn SignalwindowflattopCluster::get(self : SignalwindowflattopCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopCluster::set(self : SignalwindowflattopCluster, i : Int, v : Double) -> SignalwindowflattopCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCluster::sum(self : SignalwindowflattopCluster) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopCluster::mean(self : SignalwindowflattopCluster) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopCluster::scale(self : SignalwindowflattopCluster, f : Double) -> SignalwindowflattopCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCluster::add(self : SignalwindowflattopCluster, other : SignalwindowflattopCluster) -> SignalwindowflattopCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopCluster::copy(self : SignalwindowflattopCluster) -> SignalwindowflattopCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCluster::fill(self : SignalwindowflattopCluster, v : Double) -> SignalwindowflattopCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCluster::min(self : SignalwindowflattopCluster) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopCluster::max(self : SignalwindowflattopCluster) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopCluster::to_string(self : SignalwindowflattopCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_model_make(size : Int) -> SignalwindowflattopModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopModel::len(self : SignalwindowflattopModel) -> Int { self.size }

pub fn SignalwindowflattopModel::get(self : SignalwindowflattopModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopModel::set(self : SignalwindowflattopModel, i : Int, v : Double) -> SignalwindowflattopModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopModel::sum(self : SignalwindowflattopModel) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopModel::mean(self : SignalwindowflattopModel) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopModel::scale(self : SignalwindowflattopModel, f : Double) -> SignalwindowflattopModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopModel::add(self : SignalwindowflattopModel, other : SignalwindowflattopModel) -> SignalwindowflattopModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopModel::copy(self : SignalwindowflattopModel) -> SignalwindowflattopModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopModel::fill(self : SignalwindowflattopModel, v : Double) -> SignalwindowflattopModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopModel::min(self : SignalwindowflattopModel) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopModel::max(self : SignalwindowflattopModel) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopModel::to_string(self : SignalwindowflattopModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_layer_make(size : Int) -> SignalwindowflattopLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopLayer::len(self : SignalwindowflattopLayer) -> Int { self.size }

pub fn SignalwindowflattopLayer::get(self : SignalwindowflattopLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopLayer::set(self : SignalwindowflattopLayer, i : Int, v : Double) -> SignalwindowflattopLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopLayer::sum(self : SignalwindowflattopLayer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopLayer::mean(self : SignalwindowflattopLayer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopLayer::scale(self : SignalwindowflattopLayer, f : Double) -> SignalwindowflattopLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopLayer::add(self : SignalwindowflattopLayer, other : SignalwindowflattopLayer) -> SignalwindowflattopLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopLayer::copy(self : SignalwindowflattopLayer) -> SignalwindowflattopLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopLayer::fill(self : SignalwindowflattopLayer, v : Double) -> SignalwindowflattopLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopLayer::min(self : SignalwindowflattopLayer) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopLayer::max(self : SignalwindowflattopLayer) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopLayer::to_string(self : SignalwindowflattopLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_buffer_make(size : Int) -> SignalwindowflattopBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopBuffer::len(self : SignalwindowflattopBuffer) -> Int { self.size }

pub fn SignalwindowflattopBuffer::get(self : SignalwindowflattopBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopBuffer::set(self : SignalwindowflattopBuffer, i : Int, v : Double) -> SignalwindowflattopBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopBuffer::sum(self : SignalwindowflattopBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopBuffer::mean(self : SignalwindowflattopBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopBuffer::scale(self : SignalwindowflattopBuffer, f : Double) -> SignalwindowflattopBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopBuffer::add(self : SignalwindowflattopBuffer, other : SignalwindowflattopBuffer) -> SignalwindowflattopBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopBuffer::copy(self : SignalwindowflattopBuffer) -> SignalwindowflattopBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopBuffer::fill(self : SignalwindowflattopBuffer, v : Double) -> SignalwindowflattopBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopBuffer::min(self : SignalwindowflattopBuffer) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopBuffer::max(self : SignalwindowflattopBuffer) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopBuffer::to_string(self : SignalwindowflattopBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_cursor_make(size : Int) -> SignalwindowflattopCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopCursor::len(self : SignalwindowflattopCursor) -> Int { self.size }

pub fn SignalwindowflattopCursor::get(self : SignalwindowflattopCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopCursor::set(self : SignalwindowflattopCursor, i : Int, v : Double) -> SignalwindowflattopCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCursor::sum(self : SignalwindowflattopCursor) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopCursor::mean(self : SignalwindowflattopCursor) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopCursor::scale(self : SignalwindowflattopCursor, f : Double) -> SignalwindowflattopCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCursor::add(self : SignalwindowflattopCursor, other : SignalwindowflattopCursor) -> SignalwindowflattopCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopCursor::copy(self : SignalwindowflattopCursor) -> SignalwindowflattopCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCursor::fill(self : SignalwindowflattopCursor, v : Double) -> SignalwindowflattopCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopCursor::min(self : SignalwindowflattopCursor) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopCursor::max(self : SignalwindowflattopCursor) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopCursor::to_string(self : SignalwindowflattopCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_view_make(size : Int) -> SignalwindowflattopView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopView::len(self : SignalwindowflattopView) -> Int { self.size }

pub fn SignalwindowflattopView::get(self : SignalwindowflattopView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopView::set(self : SignalwindowflattopView, i : Int, v : Double) -> SignalwindowflattopView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopView::sum(self : SignalwindowflattopView) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopView::mean(self : SignalwindowflattopView) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopView::scale(self : SignalwindowflattopView, f : Double) -> SignalwindowflattopView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopView::add(self : SignalwindowflattopView, other : SignalwindowflattopView) -> SignalwindowflattopView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopView::copy(self : SignalwindowflattopView) -> SignalwindowflattopView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopView::fill(self : SignalwindowflattopView, v : Double) -> SignalwindowflattopView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopView::min(self : SignalwindowflattopView) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopView::max(self : SignalwindowflattopView) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopView::to_string(self : SignalwindowflattopView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_range_make(size : Int) -> SignalwindowflattopRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopRange::len(self : SignalwindowflattopRange) -> Int { self.size }

pub fn SignalwindowflattopRange::get(self : SignalwindowflattopRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopRange::set(self : SignalwindowflattopRange, i : Int, v : Double) -> SignalwindowflattopRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopRange::sum(self : SignalwindowflattopRange) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopRange::mean(self : SignalwindowflattopRange) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopRange::scale(self : SignalwindowflattopRange, f : Double) -> SignalwindowflattopRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopRange::add(self : SignalwindowflattopRange, other : SignalwindowflattopRange) -> SignalwindowflattopRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopRange::copy(self : SignalwindowflattopRange) -> SignalwindowflattopRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopRange::fill(self : SignalwindowflattopRange, v : Double) -> SignalwindowflattopRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopRange::min(self : SignalwindowflattopRange) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopRange::max(self : SignalwindowflattopRange) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopRange::to_string(self : SignalwindowflattopRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowflattopSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_flattop_slice_make(size : Int) -> SignalwindowflattopSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowflattopSlice::len(self : SignalwindowflattopSlice) -> Int { self.size }

pub fn SignalwindowflattopSlice::get(self : SignalwindowflattopSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowflattopSlice::set(self : SignalwindowflattopSlice, i : Int, v : Double) -> SignalwindowflattopSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopSlice::sum(self : SignalwindowflattopSlice) -> Double { @_common.sum(self.data) }

pub fn SignalwindowflattopSlice::mean(self : SignalwindowflattopSlice) -> Double { @_common.mean(self.data) }

pub fn SignalwindowflattopSlice::scale(self : SignalwindowflattopSlice, f : Double) -> SignalwindowflattopSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopSlice::add(self : SignalwindowflattopSlice, other : SignalwindowflattopSlice) -> SignalwindowflattopSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowflattopSlice::copy(self : SignalwindowflattopSlice) -> SignalwindowflattopSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopSlice::fill(self : SignalwindowflattopSlice, v : Double) -> SignalwindowflattopSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowflattopSlice::min(self : SignalwindowflattopSlice) -> Double { @_common.min(self.data) }

pub fn SignalwindowflattopSlice::max(self : SignalwindowflattopSlice) -> Double { @_common.max(self.data) }

pub fn SignalwindowflattopSlice::to_string(self : SignalwindowflattopSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

