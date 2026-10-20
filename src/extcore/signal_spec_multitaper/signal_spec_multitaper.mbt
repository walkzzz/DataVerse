///===
/// extcore/signal_spec_multitaper

pub(all) struct SignalspecmultitaperPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_multitaper_make_point(x : Double, y : Double) -> SignalspecmultitaperPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_multitaper_make_point3(x : Double, y : Double, z : Double) -> SignalspecmultitaperPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecmultitaperPoint::x(self : SignalspecmultitaperPoint) -> Double { self.x }

pub fn SignalspecmultitaperPoint::y(self : SignalspecmultitaperPoint) -> Double { self.y }

pub fn SignalspecmultitaperPoint::z(self : SignalspecmultitaperPoint) -> Double { self.z }

pub fn SignalspecmultitaperPoint::label(self : SignalspecmultitaperPoint) -> Int { self.label }

pub fn SignalspecmultitaperPoint::dist(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecmultitaperPoint::add(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecmultitaperPoint::sub(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecmultitaperPoint::scale(self : SignalspecmultitaperPoint, s : Double) -> SignalspecmultitaperPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecmultitaperPoint::dot(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecmultitaperPoint::cross(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecmultitaperPoint::norm(self : SignalspecmultitaperPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecmultitaperPoint::normalize(self : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecmultitaperPoint::negate(self : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecmultitaperPoint::mid(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint) -> SignalspecmultitaperPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecmultitaperPoint::lerp(self : SignalspecmultitaperPoint, other : SignalspecmultitaperPoint, t : Double) -> SignalspecmultitaperPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecmultitaperPoint::to_string(self : SignalspecmultitaperPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecmultitaperSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_multitaper_make_series(vals : Array[Double], name : String) -> SignalspecmultitaperSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecmultitaperSeries::len(self : SignalspecmultitaperSeries) -> Int { self.vals.length() }

pub fn SignalspecmultitaperSeries::sum(self : SignalspecmultitaperSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecmultitaperSeries::mean(self : SignalspecmultitaperSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecmultitaperSeries::min(self : SignalspecmultitaperSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecmultitaperSeries::max(self : SignalspecmultitaperSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecmultitaperSeries::range(self : SignalspecmultitaperSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecmultitaperSeries::variance(self : SignalspecmultitaperSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecmultitaperSeries::std(self : SignalspecmultitaperSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecmultitaperSeries::median(self : SignalspecmultitaperSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecmultitaperSeries::scale(self : SignalspecmultitaperSeries, f : Double) -> SignalspecmultitaperSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecmultitaperSeries::add(self : SignalspecmultitaperSeries, other : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecmultitaperSeries::sub(self : SignalspecmultitaperSeries, other : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecmultitaperSeries::normalize(self : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecmultitaperSeries::cumsum(self : SignalspecmultitaperSeries) -> SignalspecmultitaperSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecmultitaperSeries::to_string(self : SignalspecmultitaperSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecmultitaperMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_multitaper_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecmultitaperMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_multitaper_matrix_identity(n : Int) -> SignalspecmultitaperMatrix {
  let m = signal_spec_multitaper_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecmultitaperMatrix::get(self : SignalspecmultitaperMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecmultitaperMatrix::transpose(self : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecmultitaperMatrix::add(self : SignalspecmultitaperMatrix, other : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_multitaper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecmultitaperMatrix::scale(self : SignalspecmultitaperMatrix, s : Double) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecmultitaperMatrix::multiply(self : SignalspecmultitaperMatrix, other : SignalspecmultitaperMatrix) -> SignalspecmultitaperMatrix {
  if self.cols != other.rows { return signal_spec_multitaper_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_multitaper_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecmultitaperMatrix::trace(self : SignalspecmultitaperMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecmultitaperMatrix::det(self : SignalspecmultitaperMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecmultitaperMatrix::norm(self : SignalspecmultitaperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecmultitaperMatrix::to_string(self : SignalspecmultitaperMatrix) -> String {
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

pub(all) struct SignalspecmultitaperVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_multitaper_make_vector(comps : Array[Double]) -> SignalspecmultitaperVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_multitaper_vector_zero(dim : Int) -> SignalspecmultitaperVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecmultitaperVector::add(self : SignalspecmultitaperVector, other : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecmultitaperVector::sub(self : SignalspecmultitaperVector, other : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecmultitaperVector::scale(self : SignalspecmultitaperVector, s : Double) -> SignalspecmultitaperVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecmultitaperVector::dot(self : SignalspecmultitaperVector, other : SignalspecmultitaperVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecmultitaperVector::norm(self : SignalspecmultitaperVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecmultitaperVector::normalize(self : SignalspecmultitaperVector) -> SignalspecmultitaperVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecmultitaperVector::dist(self : SignalspecmultitaperVector, other : SignalspecmultitaperVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecmultitaperVector::to_string(self : SignalspecmultitaperVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_multitaper_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_multitaper_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_multitaper_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_multitaper_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_multitaper_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_multitaper_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_multitaper_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_multitaper_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_multitaper_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_multitaper_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_multitaper_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_multitaper_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_multitaper_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_multitaper_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_multitaper_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_multitaper_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_multitaper_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_multitaper_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_multitaper_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_multitaper_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_multitaper_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_multitaper_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_multitaper_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_multitaper_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_multitaper_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_multitaper_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_multitaper_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_multitaper_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_multitaper_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecmultitaperFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_frame_make(size : Int) -> SignalspecmultitaperFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_frame_len(s : SignalspecmultitaperFrame) -> Int { s.size }

pub fn signal_spec_multitaper_frame_get(s : SignalspecmultitaperFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_frame_set(s : SignalspecmultitaperFrame, i : Int, v : Double) -> SignalspecmultitaperFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_sum(s : SignalspecmultitaperFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_frame_mean(s : SignalspecmultitaperFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_frame_scale(s : SignalspecmultitaperFrame, f : Double) -> SignalspecmultitaperFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_add(a : SignalspecmultitaperFrame, b : SignalspecmultitaperFrame) -> SignalspecmultitaperFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_frame_copy(s : SignalspecmultitaperFrame) -> SignalspecmultitaperFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_fill(s : SignalspecmultitaperFrame, v : Double) -> SignalspecmultitaperFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_frame_min(s : SignalspecmultitaperFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_frame_max(s : SignalspecmultitaperFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_frame_to_string(s : SignalspecmultitaperFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_table_make(size : Int) -> SignalspecmultitaperTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_table_len(s : SignalspecmultitaperTable) -> Int { s.size }

pub fn signal_spec_multitaper_table_get(s : SignalspecmultitaperTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_table_set(s : SignalspecmultitaperTable, i : Int, v : Double) -> SignalspecmultitaperTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_sum(s : SignalspecmultitaperTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_table_mean(s : SignalspecmultitaperTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_table_scale(s : SignalspecmultitaperTable, f : Double) -> SignalspecmultitaperTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_add(a : SignalspecmultitaperTable, b : SignalspecmultitaperTable) -> SignalspecmultitaperTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_table_copy(s : SignalspecmultitaperTable) -> SignalspecmultitaperTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_fill(s : SignalspecmultitaperTable, v : Double) -> SignalspecmultitaperTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_table_min(s : SignalspecmultitaperTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_table_max(s : SignalspecmultitaperTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_table_to_string(s : SignalspecmultitaperTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_graphn_make(size : Int) -> SignalspecmultitaperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_graphn_len(s : SignalspecmultitaperGraphN) -> Int { s.size }

pub fn signal_spec_multitaper_graphn_get(s : SignalspecmultitaperGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_graphn_set(s : SignalspecmultitaperGraphN, i : Int, v : Double) -> SignalspecmultitaperGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_sum(s : SignalspecmultitaperGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_graphn_mean(s : SignalspecmultitaperGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_graphn_scale(s : SignalspecmultitaperGraphN, f : Double) -> SignalspecmultitaperGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_add(a : SignalspecmultitaperGraphN, b : SignalspecmultitaperGraphN) -> SignalspecmultitaperGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_graphn_copy(s : SignalspecmultitaperGraphN) -> SignalspecmultitaperGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_fill(s : SignalspecmultitaperGraphN, v : Double) -> SignalspecmultitaperGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_graphn_min(s : SignalspecmultitaperGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_graphn_max(s : SignalspecmultitaperGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_graphn_to_string(s : SignalspecmultitaperGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_node_make(size : Int) -> SignalspecmultitaperNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_node_len(s : SignalspecmultitaperNode) -> Int { s.size }

pub fn signal_spec_multitaper_node_get(s : SignalspecmultitaperNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_node_set(s : SignalspecmultitaperNode, i : Int, v : Double) -> SignalspecmultitaperNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_sum(s : SignalspecmultitaperNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_node_mean(s : SignalspecmultitaperNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_node_scale(s : SignalspecmultitaperNode, f : Double) -> SignalspecmultitaperNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_add(a : SignalspecmultitaperNode, b : SignalspecmultitaperNode) -> SignalspecmultitaperNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_node_copy(s : SignalspecmultitaperNode) -> SignalspecmultitaperNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_fill(s : SignalspecmultitaperNode, v : Double) -> SignalspecmultitaperNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_node_min(s : SignalspecmultitaperNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_node_max(s : SignalspecmultitaperNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_node_to_string(s : SignalspecmultitaperNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_edge_make(size : Int) -> SignalspecmultitaperEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_edge_len(s : SignalspecmultitaperEdge) -> Int { s.size }

pub fn signal_spec_multitaper_edge_get(s : SignalspecmultitaperEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_edge_set(s : SignalspecmultitaperEdge, i : Int, v : Double) -> SignalspecmultitaperEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_sum(s : SignalspecmultitaperEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_edge_mean(s : SignalspecmultitaperEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_edge_scale(s : SignalspecmultitaperEdge, f : Double) -> SignalspecmultitaperEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_add(a : SignalspecmultitaperEdge, b : SignalspecmultitaperEdge) -> SignalspecmultitaperEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_edge_copy(s : SignalspecmultitaperEdge) -> SignalspecmultitaperEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_fill(s : SignalspecmultitaperEdge, v : Double) -> SignalspecmultitaperEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_edge_min(s : SignalspecmultitaperEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_edge_max(s : SignalspecmultitaperEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_edge_to_string(s : SignalspecmultitaperEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_path_make(size : Int) -> SignalspecmultitaperPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_path_len(s : SignalspecmultitaperPath) -> Int { s.size }

pub fn signal_spec_multitaper_path_get(s : SignalspecmultitaperPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_path_set(s : SignalspecmultitaperPath, i : Int, v : Double) -> SignalspecmultitaperPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_sum(s : SignalspecmultitaperPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_path_mean(s : SignalspecmultitaperPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_path_scale(s : SignalspecmultitaperPath, f : Double) -> SignalspecmultitaperPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_add(a : SignalspecmultitaperPath, b : SignalspecmultitaperPath) -> SignalspecmultitaperPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_path_copy(s : SignalspecmultitaperPath) -> SignalspecmultitaperPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_fill(s : SignalspecmultitaperPath, v : Double) -> SignalspecmultitaperPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_path_min(s : SignalspecmultitaperPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_path_max(s : SignalspecmultitaperPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_path_to_string(s : SignalspecmultitaperPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_cluster_make(size : Int) -> SignalspecmultitaperCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_cluster_len(s : SignalspecmultitaperCluster) -> Int { s.size }

pub fn signal_spec_multitaper_cluster_get(s : SignalspecmultitaperCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_cluster_set(s : SignalspecmultitaperCluster, i : Int, v : Double) -> SignalspecmultitaperCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_sum(s : SignalspecmultitaperCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_cluster_mean(s : SignalspecmultitaperCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_cluster_scale(s : SignalspecmultitaperCluster, f : Double) -> SignalspecmultitaperCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_add(a : SignalspecmultitaperCluster, b : SignalspecmultitaperCluster) -> SignalspecmultitaperCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_cluster_copy(s : SignalspecmultitaperCluster) -> SignalspecmultitaperCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_fill(s : SignalspecmultitaperCluster, v : Double) -> SignalspecmultitaperCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cluster_min(s : SignalspecmultitaperCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_cluster_max(s : SignalspecmultitaperCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_cluster_to_string(s : SignalspecmultitaperCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_model_make(size : Int) -> SignalspecmultitaperModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_model_len(s : SignalspecmultitaperModel) -> Int { s.size }

pub fn signal_spec_multitaper_model_get(s : SignalspecmultitaperModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_model_set(s : SignalspecmultitaperModel, i : Int, v : Double) -> SignalspecmultitaperModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_sum(s : SignalspecmultitaperModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_model_mean(s : SignalspecmultitaperModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_model_scale(s : SignalspecmultitaperModel, f : Double) -> SignalspecmultitaperModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_add(a : SignalspecmultitaperModel, b : SignalspecmultitaperModel) -> SignalspecmultitaperModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_model_copy(s : SignalspecmultitaperModel) -> SignalspecmultitaperModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_fill(s : SignalspecmultitaperModel, v : Double) -> SignalspecmultitaperModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_model_min(s : SignalspecmultitaperModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_model_max(s : SignalspecmultitaperModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_model_to_string(s : SignalspecmultitaperModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_layer_make(size : Int) -> SignalspecmultitaperLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_layer_len(s : SignalspecmultitaperLayer) -> Int { s.size }

pub fn signal_spec_multitaper_layer_get(s : SignalspecmultitaperLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_layer_set(s : SignalspecmultitaperLayer, i : Int, v : Double) -> SignalspecmultitaperLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_sum(s : SignalspecmultitaperLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_layer_mean(s : SignalspecmultitaperLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_layer_scale(s : SignalspecmultitaperLayer, f : Double) -> SignalspecmultitaperLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_add(a : SignalspecmultitaperLayer, b : SignalspecmultitaperLayer) -> SignalspecmultitaperLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_layer_copy(s : SignalspecmultitaperLayer) -> SignalspecmultitaperLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_fill(s : SignalspecmultitaperLayer, v : Double) -> SignalspecmultitaperLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_layer_min(s : SignalspecmultitaperLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_layer_max(s : SignalspecmultitaperLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_layer_to_string(s : SignalspecmultitaperLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_buffer_make(size : Int) -> SignalspecmultitaperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_buffer_len(s : SignalspecmultitaperBuffer) -> Int { s.size }

pub fn signal_spec_multitaper_buffer_get(s : SignalspecmultitaperBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_buffer_set(s : SignalspecmultitaperBuffer, i : Int, v : Double) -> SignalspecmultitaperBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_sum(s : SignalspecmultitaperBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_buffer_mean(s : SignalspecmultitaperBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_buffer_scale(s : SignalspecmultitaperBuffer, f : Double) -> SignalspecmultitaperBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_add(a : SignalspecmultitaperBuffer, b : SignalspecmultitaperBuffer) -> SignalspecmultitaperBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_buffer_copy(s : SignalspecmultitaperBuffer) -> SignalspecmultitaperBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_fill(s : SignalspecmultitaperBuffer, v : Double) -> SignalspecmultitaperBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_buffer_min(s : SignalspecmultitaperBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_buffer_max(s : SignalspecmultitaperBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_buffer_to_string(s : SignalspecmultitaperBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_cursor_make(size : Int) -> SignalspecmultitaperCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_cursor_len(s : SignalspecmultitaperCursor) -> Int { s.size }

pub fn signal_spec_multitaper_cursor_get(s : SignalspecmultitaperCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_cursor_set(s : SignalspecmultitaperCursor, i : Int, v : Double) -> SignalspecmultitaperCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_sum(s : SignalspecmultitaperCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_cursor_mean(s : SignalspecmultitaperCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_cursor_scale(s : SignalspecmultitaperCursor, f : Double) -> SignalspecmultitaperCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_add(a : SignalspecmultitaperCursor, b : SignalspecmultitaperCursor) -> SignalspecmultitaperCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_cursor_copy(s : SignalspecmultitaperCursor) -> SignalspecmultitaperCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_fill(s : SignalspecmultitaperCursor, v : Double) -> SignalspecmultitaperCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_cursor_min(s : SignalspecmultitaperCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_cursor_max(s : SignalspecmultitaperCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_cursor_to_string(s : SignalspecmultitaperCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_view_make(size : Int) -> SignalspecmultitaperView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_view_len(s : SignalspecmultitaperView) -> Int { s.size }

pub fn signal_spec_multitaper_view_get(s : SignalspecmultitaperView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_view_set(s : SignalspecmultitaperView, i : Int, v : Double) -> SignalspecmultitaperView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_sum(s : SignalspecmultitaperView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_view_mean(s : SignalspecmultitaperView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_view_scale(s : SignalspecmultitaperView, f : Double) -> SignalspecmultitaperView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_add(a : SignalspecmultitaperView, b : SignalspecmultitaperView) -> SignalspecmultitaperView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_view_copy(s : SignalspecmultitaperView) -> SignalspecmultitaperView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_fill(s : SignalspecmultitaperView, v : Double) -> SignalspecmultitaperView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_view_min(s : SignalspecmultitaperView) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_view_max(s : SignalspecmultitaperView) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_view_to_string(s : SignalspecmultitaperView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_range_make(size : Int) -> SignalspecmultitaperRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_range_len(s : SignalspecmultitaperRange) -> Int { s.size }

pub fn signal_spec_multitaper_range_get(s : SignalspecmultitaperRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_range_set(s : SignalspecmultitaperRange, i : Int, v : Double) -> SignalspecmultitaperRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_sum(s : SignalspecmultitaperRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_range_mean(s : SignalspecmultitaperRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_range_scale(s : SignalspecmultitaperRange, f : Double) -> SignalspecmultitaperRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_add(a : SignalspecmultitaperRange, b : SignalspecmultitaperRange) -> SignalspecmultitaperRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_range_copy(s : SignalspecmultitaperRange) -> SignalspecmultitaperRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_fill(s : SignalspecmultitaperRange, v : Double) -> SignalspecmultitaperRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_range_min(s : SignalspecmultitaperRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_range_max(s : SignalspecmultitaperRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_range_to_string(s : SignalspecmultitaperRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecmultitaperSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_multitaper_slice_make(size : Int) -> SignalspecmultitaperSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_multitaper_slice_len(s : SignalspecmultitaperSlice) -> Int { s.size }

pub fn signal_spec_multitaper_slice_get(s : SignalspecmultitaperSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_multitaper_slice_set(s : SignalspecmultitaperSlice, i : Int, v : Double) -> SignalspecmultitaperSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_sum(s : SignalspecmultitaperSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_multitaper_slice_mean(s : SignalspecmultitaperSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_multitaper_slice_scale(s : SignalspecmultitaperSlice, f : Double) -> SignalspecmultitaperSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_add(a : SignalspecmultitaperSlice, b : SignalspecmultitaperSlice) -> SignalspecmultitaperSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_multitaper_slice_copy(s : SignalspecmultitaperSlice) -> SignalspecmultitaperSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_fill(s : SignalspecmultitaperSlice, v : Double) -> SignalspecmultitaperSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_multitaper_slice_min(s : SignalspecmultitaperSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_multitaper_slice_max(s : SignalspecmultitaperSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_multitaper_slice_to_string(s : SignalspecmultitaperSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

