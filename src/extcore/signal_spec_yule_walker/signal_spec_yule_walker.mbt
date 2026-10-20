///===
/// extcore/signal_spec_yule_walker

pub(all) struct SignalspecyulewalkerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_yule_walker_make_point(x : Double, y : Double) -> SignalspecyulewalkerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_yule_walker_make_point3(x : Double, y : Double, z : Double) -> SignalspecyulewalkerPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecyulewalkerPoint::x(self : SignalspecyulewalkerPoint) -> Double { self.x }

pub fn SignalspecyulewalkerPoint::y(self : SignalspecyulewalkerPoint) -> Double { self.y }

pub fn SignalspecyulewalkerPoint::z(self : SignalspecyulewalkerPoint) -> Double { self.z }

pub fn SignalspecyulewalkerPoint::label(self : SignalspecyulewalkerPoint) -> Int { self.label }

pub fn SignalspecyulewalkerPoint::dist(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecyulewalkerPoint::add(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecyulewalkerPoint::sub(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecyulewalkerPoint::scale(self : SignalspecyulewalkerPoint, s : Double) -> SignalspecyulewalkerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecyulewalkerPoint::dot(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecyulewalkerPoint::cross(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecyulewalkerPoint::norm(self : SignalspecyulewalkerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecyulewalkerPoint::normalize(self : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecyulewalkerPoint::negate(self : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecyulewalkerPoint::mid(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint) -> SignalspecyulewalkerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecyulewalkerPoint::lerp(self : SignalspecyulewalkerPoint, other : SignalspecyulewalkerPoint, t : Double) -> SignalspecyulewalkerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecyulewalkerPoint::to_string(self : SignalspecyulewalkerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_yule_walker_make_series(vals : Array[Double], name : String) -> SignalspecyulewalkerSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecyulewalkerSeries::len(self : SignalspecyulewalkerSeries) -> Int { self.vals.length() }

pub fn SignalspecyulewalkerSeries::sum(self : SignalspecyulewalkerSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecyulewalkerSeries::mean(self : SignalspecyulewalkerSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecyulewalkerSeries::min(self : SignalspecyulewalkerSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecyulewalkerSeries::max(self : SignalspecyulewalkerSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecyulewalkerSeries::range(self : SignalspecyulewalkerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecyulewalkerSeries::variance(self : SignalspecyulewalkerSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecyulewalkerSeries::std(self : SignalspecyulewalkerSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecyulewalkerSeries::median(self : SignalspecyulewalkerSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecyulewalkerSeries::scale(self : SignalspecyulewalkerSeries, f : Double) -> SignalspecyulewalkerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::add(self : SignalspecyulewalkerSeries, other : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::sub(self : SignalspecyulewalkerSeries, other : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::normalize(self : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecyulewalkerSeries::cumsum(self : SignalspecyulewalkerSeries) -> SignalspecyulewalkerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecyulewalkerSeries::to_string(self : SignalspecyulewalkerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecyulewalkerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_yule_walker_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecyulewalkerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_yule_walker_matrix_identity(n : Int) -> SignalspecyulewalkerMatrix {
  let m = signal_spec_yule_walker_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecyulewalkerMatrix::get(self : SignalspecyulewalkerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecyulewalkerMatrix::transpose(self : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  let result = signal_spec_yule_walker_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecyulewalkerMatrix::add(self : SignalspecyulewalkerMatrix, other : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_yule_walker_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecyulewalkerMatrix::scale(self : SignalspecyulewalkerMatrix, s : Double) -> SignalspecyulewalkerMatrix {
  let result = signal_spec_yule_walker_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecyulewalkerMatrix::multiply(self : SignalspecyulewalkerMatrix, other : SignalspecyulewalkerMatrix) -> SignalspecyulewalkerMatrix {
  if self.cols != other.rows { return signal_spec_yule_walker_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_yule_walker_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecyulewalkerMatrix::trace(self : SignalspecyulewalkerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecyulewalkerMatrix::det(self : SignalspecyulewalkerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecyulewalkerMatrix::norm(self : SignalspecyulewalkerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecyulewalkerMatrix::to_string(self : SignalspecyulewalkerMatrix) -> String {
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

pub(all) struct SignalspecyulewalkerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_yule_walker_make_vector(comps : Array[Double]) -> SignalspecyulewalkerVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_yule_walker_vector_zero(dim : Int) -> SignalspecyulewalkerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecyulewalkerVector::add(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecyulewalkerVector::sub(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecyulewalkerVector::scale(self : SignalspecyulewalkerVector, s : Double) -> SignalspecyulewalkerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecyulewalkerVector::dot(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecyulewalkerVector::norm(self : SignalspecyulewalkerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecyulewalkerVector::normalize(self : SignalspecyulewalkerVector) -> SignalspecyulewalkerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecyulewalkerVector::dist(self : SignalspecyulewalkerVector, other : SignalspecyulewalkerVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecyulewalkerVector::to_string(self : SignalspecyulewalkerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_yule_walker_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_yule_walker_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_yule_walker_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_yule_walker_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_yule_walker_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_yule_walker_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_yule_walker_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_yule_walker_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_yule_walker_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_yule_walker_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_yule_walker_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_yule_walker_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_yule_walker_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_yule_walker_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_yule_walker_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_yule_walker_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_yule_walker_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_yule_walker_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_yule_walker_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_yule_walker_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_yule_walker_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_yule_walker_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_yule_walker_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_yule_walker_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_yule_walker_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_yule_walker_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_yule_walker_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_yule_walker_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_yule_walker_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecyulewalkerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_frame_make(size : Int) -> SignalspecyulewalkerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_frame_len(s : SignalspecyulewalkerFrame) -> Int { s.size }

pub fn signal_spec_yule_walker_frame_get(s : SignalspecyulewalkerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_frame_set(s : SignalspecyulewalkerFrame, i : Int, v : Double) -> SignalspecyulewalkerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_frame_sum(s : SignalspecyulewalkerFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_frame_mean(s : SignalspecyulewalkerFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_frame_scale(s : SignalspecyulewalkerFrame, f : Double) -> SignalspecyulewalkerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_frame_add(a : SignalspecyulewalkerFrame, b : SignalspecyulewalkerFrame) -> SignalspecyulewalkerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_frame_copy(s : SignalspecyulewalkerFrame) -> SignalspecyulewalkerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_frame_fill(s : SignalspecyulewalkerFrame, v : Double) -> SignalspecyulewalkerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_frame_min(s : SignalspecyulewalkerFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_frame_max(s : SignalspecyulewalkerFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_frame_to_string(s : SignalspecyulewalkerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_table_make(size : Int) -> SignalspecyulewalkerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_table_len(s : SignalspecyulewalkerTable) -> Int { s.size }

pub fn signal_spec_yule_walker_table_get(s : SignalspecyulewalkerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_table_set(s : SignalspecyulewalkerTable, i : Int, v : Double) -> SignalspecyulewalkerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_table_sum(s : SignalspecyulewalkerTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_table_mean(s : SignalspecyulewalkerTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_table_scale(s : SignalspecyulewalkerTable, f : Double) -> SignalspecyulewalkerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_table_add(a : SignalspecyulewalkerTable, b : SignalspecyulewalkerTable) -> SignalspecyulewalkerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_table_copy(s : SignalspecyulewalkerTable) -> SignalspecyulewalkerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_table_fill(s : SignalspecyulewalkerTable, v : Double) -> SignalspecyulewalkerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_table_min(s : SignalspecyulewalkerTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_table_max(s : SignalspecyulewalkerTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_table_to_string(s : SignalspecyulewalkerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_graphn_make(size : Int) -> SignalspecyulewalkerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_graphn_len(s : SignalspecyulewalkerGraphN) -> Int { s.size }

pub fn signal_spec_yule_walker_graphn_get(s : SignalspecyulewalkerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_graphn_set(s : SignalspecyulewalkerGraphN, i : Int, v : Double) -> SignalspecyulewalkerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_graphn_sum(s : SignalspecyulewalkerGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_graphn_mean(s : SignalspecyulewalkerGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_graphn_scale(s : SignalspecyulewalkerGraphN, f : Double) -> SignalspecyulewalkerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_graphn_add(a : SignalspecyulewalkerGraphN, b : SignalspecyulewalkerGraphN) -> SignalspecyulewalkerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_graphn_copy(s : SignalspecyulewalkerGraphN) -> SignalspecyulewalkerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_graphn_fill(s : SignalspecyulewalkerGraphN, v : Double) -> SignalspecyulewalkerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_graphn_min(s : SignalspecyulewalkerGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_graphn_max(s : SignalspecyulewalkerGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_graphn_to_string(s : SignalspecyulewalkerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_node_make(size : Int) -> SignalspecyulewalkerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_node_len(s : SignalspecyulewalkerNode) -> Int { s.size }

pub fn signal_spec_yule_walker_node_get(s : SignalspecyulewalkerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_node_set(s : SignalspecyulewalkerNode, i : Int, v : Double) -> SignalspecyulewalkerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_node_sum(s : SignalspecyulewalkerNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_node_mean(s : SignalspecyulewalkerNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_node_scale(s : SignalspecyulewalkerNode, f : Double) -> SignalspecyulewalkerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_node_add(a : SignalspecyulewalkerNode, b : SignalspecyulewalkerNode) -> SignalspecyulewalkerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_node_copy(s : SignalspecyulewalkerNode) -> SignalspecyulewalkerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_node_fill(s : SignalspecyulewalkerNode, v : Double) -> SignalspecyulewalkerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_node_min(s : SignalspecyulewalkerNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_node_max(s : SignalspecyulewalkerNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_node_to_string(s : SignalspecyulewalkerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_edge_make(size : Int) -> SignalspecyulewalkerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_edge_len(s : SignalspecyulewalkerEdge) -> Int { s.size }

pub fn signal_spec_yule_walker_edge_get(s : SignalspecyulewalkerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_edge_set(s : SignalspecyulewalkerEdge, i : Int, v : Double) -> SignalspecyulewalkerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_edge_sum(s : SignalspecyulewalkerEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_edge_mean(s : SignalspecyulewalkerEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_edge_scale(s : SignalspecyulewalkerEdge, f : Double) -> SignalspecyulewalkerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_edge_add(a : SignalspecyulewalkerEdge, b : SignalspecyulewalkerEdge) -> SignalspecyulewalkerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_edge_copy(s : SignalspecyulewalkerEdge) -> SignalspecyulewalkerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_edge_fill(s : SignalspecyulewalkerEdge, v : Double) -> SignalspecyulewalkerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_edge_min(s : SignalspecyulewalkerEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_edge_max(s : SignalspecyulewalkerEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_edge_to_string(s : SignalspecyulewalkerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_path_make(size : Int) -> SignalspecyulewalkerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_path_len(s : SignalspecyulewalkerPath) -> Int { s.size }

pub fn signal_spec_yule_walker_path_get(s : SignalspecyulewalkerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_path_set(s : SignalspecyulewalkerPath, i : Int, v : Double) -> SignalspecyulewalkerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_path_sum(s : SignalspecyulewalkerPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_path_mean(s : SignalspecyulewalkerPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_path_scale(s : SignalspecyulewalkerPath, f : Double) -> SignalspecyulewalkerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_path_add(a : SignalspecyulewalkerPath, b : SignalspecyulewalkerPath) -> SignalspecyulewalkerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_path_copy(s : SignalspecyulewalkerPath) -> SignalspecyulewalkerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_path_fill(s : SignalspecyulewalkerPath, v : Double) -> SignalspecyulewalkerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_path_min(s : SignalspecyulewalkerPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_path_max(s : SignalspecyulewalkerPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_path_to_string(s : SignalspecyulewalkerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_cluster_make(size : Int) -> SignalspecyulewalkerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_cluster_len(s : SignalspecyulewalkerCluster) -> Int { s.size }

pub fn signal_spec_yule_walker_cluster_get(s : SignalspecyulewalkerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_cluster_set(s : SignalspecyulewalkerCluster, i : Int, v : Double) -> SignalspecyulewalkerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cluster_sum(s : SignalspecyulewalkerCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_cluster_mean(s : SignalspecyulewalkerCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_cluster_scale(s : SignalspecyulewalkerCluster, f : Double) -> SignalspecyulewalkerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cluster_add(a : SignalspecyulewalkerCluster, b : SignalspecyulewalkerCluster) -> SignalspecyulewalkerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_cluster_copy(s : SignalspecyulewalkerCluster) -> SignalspecyulewalkerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cluster_fill(s : SignalspecyulewalkerCluster, v : Double) -> SignalspecyulewalkerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cluster_min(s : SignalspecyulewalkerCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_cluster_max(s : SignalspecyulewalkerCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_cluster_to_string(s : SignalspecyulewalkerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_model_make(size : Int) -> SignalspecyulewalkerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_model_len(s : SignalspecyulewalkerModel) -> Int { s.size }

pub fn signal_spec_yule_walker_model_get(s : SignalspecyulewalkerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_model_set(s : SignalspecyulewalkerModel, i : Int, v : Double) -> SignalspecyulewalkerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_model_sum(s : SignalspecyulewalkerModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_model_mean(s : SignalspecyulewalkerModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_model_scale(s : SignalspecyulewalkerModel, f : Double) -> SignalspecyulewalkerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_model_add(a : SignalspecyulewalkerModel, b : SignalspecyulewalkerModel) -> SignalspecyulewalkerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_model_copy(s : SignalspecyulewalkerModel) -> SignalspecyulewalkerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_model_fill(s : SignalspecyulewalkerModel, v : Double) -> SignalspecyulewalkerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_model_min(s : SignalspecyulewalkerModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_model_max(s : SignalspecyulewalkerModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_model_to_string(s : SignalspecyulewalkerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_layer_make(size : Int) -> SignalspecyulewalkerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_layer_len(s : SignalspecyulewalkerLayer) -> Int { s.size }

pub fn signal_spec_yule_walker_layer_get(s : SignalspecyulewalkerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_layer_set(s : SignalspecyulewalkerLayer, i : Int, v : Double) -> SignalspecyulewalkerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_layer_sum(s : SignalspecyulewalkerLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_layer_mean(s : SignalspecyulewalkerLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_layer_scale(s : SignalspecyulewalkerLayer, f : Double) -> SignalspecyulewalkerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_layer_add(a : SignalspecyulewalkerLayer, b : SignalspecyulewalkerLayer) -> SignalspecyulewalkerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_layer_copy(s : SignalspecyulewalkerLayer) -> SignalspecyulewalkerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_layer_fill(s : SignalspecyulewalkerLayer, v : Double) -> SignalspecyulewalkerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_layer_min(s : SignalspecyulewalkerLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_layer_max(s : SignalspecyulewalkerLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_layer_to_string(s : SignalspecyulewalkerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_buffer_make(size : Int) -> SignalspecyulewalkerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_buffer_len(s : SignalspecyulewalkerBuffer) -> Int { s.size }

pub fn signal_spec_yule_walker_buffer_get(s : SignalspecyulewalkerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_buffer_set(s : SignalspecyulewalkerBuffer, i : Int, v : Double) -> SignalspecyulewalkerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_buffer_sum(s : SignalspecyulewalkerBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_buffer_mean(s : SignalspecyulewalkerBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_buffer_scale(s : SignalspecyulewalkerBuffer, f : Double) -> SignalspecyulewalkerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_buffer_add(a : SignalspecyulewalkerBuffer, b : SignalspecyulewalkerBuffer) -> SignalspecyulewalkerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_buffer_copy(s : SignalspecyulewalkerBuffer) -> SignalspecyulewalkerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_buffer_fill(s : SignalspecyulewalkerBuffer, v : Double) -> SignalspecyulewalkerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_buffer_min(s : SignalspecyulewalkerBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_buffer_max(s : SignalspecyulewalkerBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_buffer_to_string(s : SignalspecyulewalkerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_cursor_make(size : Int) -> SignalspecyulewalkerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_cursor_len(s : SignalspecyulewalkerCursor) -> Int { s.size }

pub fn signal_spec_yule_walker_cursor_get(s : SignalspecyulewalkerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_cursor_set(s : SignalspecyulewalkerCursor, i : Int, v : Double) -> SignalspecyulewalkerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cursor_sum(s : SignalspecyulewalkerCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_cursor_mean(s : SignalspecyulewalkerCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_cursor_scale(s : SignalspecyulewalkerCursor, f : Double) -> SignalspecyulewalkerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cursor_add(a : SignalspecyulewalkerCursor, b : SignalspecyulewalkerCursor) -> SignalspecyulewalkerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_cursor_copy(s : SignalspecyulewalkerCursor) -> SignalspecyulewalkerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cursor_fill(s : SignalspecyulewalkerCursor, v : Double) -> SignalspecyulewalkerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_cursor_min(s : SignalspecyulewalkerCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_cursor_max(s : SignalspecyulewalkerCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_cursor_to_string(s : SignalspecyulewalkerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_view_make(size : Int) -> SignalspecyulewalkerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_view_len(s : SignalspecyulewalkerView) -> Int { s.size }

pub fn signal_spec_yule_walker_view_get(s : SignalspecyulewalkerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_view_set(s : SignalspecyulewalkerView, i : Int, v : Double) -> SignalspecyulewalkerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_view_sum(s : SignalspecyulewalkerView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_view_mean(s : SignalspecyulewalkerView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_view_scale(s : SignalspecyulewalkerView, f : Double) -> SignalspecyulewalkerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_view_add(a : SignalspecyulewalkerView, b : SignalspecyulewalkerView) -> SignalspecyulewalkerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_view_copy(s : SignalspecyulewalkerView) -> SignalspecyulewalkerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_view_fill(s : SignalspecyulewalkerView, v : Double) -> SignalspecyulewalkerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_view_min(s : SignalspecyulewalkerView) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_view_max(s : SignalspecyulewalkerView) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_view_to_string(s : SignalspecyulewalkerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_range_make(size : Int) -> SignalspecyulewalkerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_range_len(s : SignalspecyulewalkerRange) -> Int { s.size }

pub fn signal_spec_yule_walker_range_get(s : SignalspecyulewalkerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_range_set(s : SignalspecyulewalkerRange, i : Int, v : Double) -> SignalspecyulewalkerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_range_sum(s : SignalspecyulewalkerRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_range_mean(s : SignalspecyulewalkerRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_range_scale(s : SignalspecyulewalkerRange, f : Double) -> SignalspecyulewalkerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_range_add(a : SignalspecyulewalkerRange, b : SignalspecyulewalkerRange) -> SignalspecyulewalkerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_range_copy(s : SignalspecyulewalkerRange) -> SignalspecyulewalkerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_range_fill(s : SignalspecyulewalkerRange, v : Double) -> SignalspecyulewalkerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_range_min(s : SignalspecyulewalkerRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_range_max(s : SignalspecyulewalkerRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_range_to_string(s : SignalspecyulewalkerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecyulewalkerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_yule_walker_slice_make(size : Int) -> SignalspecyulewalkerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_yule_walker_slice_len(s : SignalspecyulewalkerSlice) -> Int { s.size }

pub fn signal_spec_yule_walker_slice_get(s : SignalspecyulewalkerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_yule_walker_slice_set(s : SignalspecyulewalkerSlice, i : Int, v : Double) -> SignalspecyulewalkerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_slice_sum(s : SignalspecyulewalkerSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_yule_walker_slice_mean(s : SignalspecyulewalkerSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_yule_walker_slice_scale(s : SignalspecyulewalkerSlice, f : Double) -> SignalspecyulewalkerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_slice_add(a : SignalspecyulewalkerSlice, b : SignalspecyulewalkerSlice) -> SignalspecyulewalkerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_yule_walker_slice_copy(s : SignalspecyulewalkerSlice) -> SignalspecyulewalkerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_slice_fill(s : SignalspecyulewalkerSlice, v : Double) -> SignalspecyulewalkerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_yule_walker_slice_min(s : SignalspecyulewalkerSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_yule_walker_slice_max(s : SignalspecyulewalkerSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_yule_walker_slice_to_string(s : SignalspecyulewalkerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

