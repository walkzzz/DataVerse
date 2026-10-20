///===
/// extcore/signal_spec_daniell

pub(all) struct SignalspecdaniellPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_daniell_make_point(x : Double, y : Double) -> SignalspecdaniellPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_daniell_make_point3(x : Double, y : Double, z : Double) -> SignalspecdaniellPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecdaniellPoint::x(self : SignalspecdaniellPoint) -> Double { self.x }

pub fn SignalspecdaniellPoint::y(self : SignalspecdaniellPoint) -> Double { self.y }

pub fn SignalspecdaniellPoint::z(self : SignalspecdaniellPoint) -> Double { self.z }

pub fn SignalspecdaniellPoint::label(self : SignalspecdaniellPoint) -> Int { self.label }

pub fn SignalspecdaniellPoint::dist(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecdaniellPoint::add(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecdaniellPoint::sub(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecdaniellPoint::scale(self : SignalspecdaniellPoint, s : Double) -> SignalspecdaniellPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecdaniellPoint::dot(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecdaniellPoint::cross(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecdaniellPoint::norm(self : SignalspecdaniellPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecdaniellPoint::normalize(self : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecdaniellPoint::negate(self : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecdaniellPoint::mid(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecdaniellPoint::lerp(self : SignalspecdaniellPoint, other : SignalspecdaniellPoint, t : Double) -> SignalspecdaniellPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecdaniellPoint::to_string(self : SignalspecdaniellPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecdaniellSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_daniell_make_series(vals : Array[Double], name : String) -> SignalspecdaniellSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecdaniellSeries::len(self : SignalspecdaniellSeries) -> Int { self.vals.length() }

pub fn SignalspecdaniellSeries::sum(self : SignalspecdaniellSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecdaniellSeries::mean(self : SignalspecdaniellSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecdaniellSeries::min(self : SignalspecdaniellSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecdaniellSeries::max(self : SignalspecdaniellSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecdaniellSeries::range(self : SignalspecdaniellSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecdaniellSeries::variance(self : SignalspecdaniellSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecdaniellSeries::std(self : SignalspecdaniellSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecdaniellSeries::median(self : SignalspecdaniellSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecdaniellSeries::scale(self : SignalspecdaniellSeries, f : Double) -> SignalspecdaniellSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecdaniellSeries::add(self : SignalspecdaniellSeries, other : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecdaniellSeries::sub(self : SignalspecdaniellSeries, other : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecdaniellSeries::normalize(self : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecdaniellSeries::cumsum(self : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecdaniellSeries::to_string(self : SignalspecdaniellSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecdaniellMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_daniell_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecdaniellMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_daniell_matrix_identity(n : Int) -> SignalspecdaniellMatrix {
  let m = signal_spec_daniell_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecdaniellMatrix::get(self : SignalspecdaniellMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecdaniellMatrix::transpose(self : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecdaniellMatrix::add(self : SignalspecdaniellMatrix, other : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_daniell_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecdaniellMatrix::scale(self : SignalspecdaniellMatrix, s : Double) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecdaniellMatrix::multiply(self : SignalspecdaniellMatrix, other : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if self.cols != other.rows { return signal_spec_daniell_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_daniell_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecdaniellMatrix::trace(self : SignalspecdaniellMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecdaniellMatrix::det(self : SignalspecdaniellMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecdaniellMatrix::norm(self : SignalspecdaniellMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecdaniellMatrix::to_string(self : SignalspecdaniellMatrix) -> String {
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

pub(all) struct SignalspecdaniellVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_daniell_make_vector(comps : Array[Double]) -> SignalspecdaniellVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_daniell_vector_zero(dim : Int) -> SignalspecdaniellVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecdaniellVector::add(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecdaniellVector::sub(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecdaniellVector::scale(self : SignalspecdaniellVector, s : Double) -> SignalspecdaniellVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecdaniellVector::dot(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecdaniellVector::norm(self : SignalspecdaniellVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecdaniellVector::normalize(self : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecdaniellVector::dist(self : SignalspecdaniellVector, other : SignalspecdaniellVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecdaniellVector::to_string(self : SignalspecdaniellVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_daniell_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_daniell_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_daniell_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_daniell_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_daniell_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_daniell_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_daniell_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_daniell_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_daniell_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_daniell_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_daniell_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_daniell_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_daniell_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_daniell_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_daniell_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_daniell_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_daniell_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_daniell_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_daniell_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_daniell_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_daniell_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_daniell_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_daniell_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_daniell_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_daniell_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_daniell_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_daniell_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_daniell_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_daniell_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecdaniellFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_frame_make(size : Int) -> SignalspecdaniellFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_frame_len(s : SignalspecdaniellFrame) -> Int { s.size }

pub fn signal_spec_daniell_frame_get(s : SignalspecdaniellFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_frame_set(s : SignalspecdaniellFrame, i : Int, v : Double) -> SignalspecdaniellFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_sum(s : SignalspecdaniellFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_frame_mean(s : SignalspecdaniellFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_frame_scale(s : SignalspecdaniellFrame, f : Double) -> SignalspecdaniellFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_add(a : SignalspecdaniellFrame, b : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_frame_copy(s : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_fill(s : SignalspecdaniellFrame, v : Double) -> SignalspecdaniellFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_min(s : SignalspecdaniellFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_frame_max(s : SignalspecdaniellFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_frame_to_string(s : SignalspecdaniellFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_table_make(size : Int) -> SignalspecdaniellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_table_len(s : SignalspecdaniellTable) -> Int { s.size }

pub fn signal_spec_daniell_table_get(s : SignalspecdaniellTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_table_set(s : SignalspecdaniellTable, i : Int, v : Double) -> SignalspecdaniellTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_sum(s : SignalspecdaniellTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_table_mean(s : SignalspecdaniellTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_table_scale(s : SignalspecdaniellTable, f : Double) -> SignalspecdaniellTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_add(a : SignalspecdaniellTable, b : SignalspecdaniellTable) -> SignalspecdaniellTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_table_copy(s : SignalspecdaniellTable) -> SignalspecdaniellTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_fill(s : SignalspecdaniellTable, v : Double) -> SignalspecdaniellTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_min(s : SignalspecdaniellTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_table_max(s : SignalspecdaniellTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_table_to_string(s : SignalspecdaniellTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_graphn_make(size : Int) -> SignalspecdaniellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_graphn_len(s : SignalspecdaniellGraphN) -> Int { s.size }

pub fn signal_spec_daniell_graphn_get(s : SignalspecdaniellGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_graphn_set(s : SignalspecdaniellGraphN, i : Int, v : Double) -> SignalspecdaniellGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_sum(s : SignalspecdaniellGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_graphn_mean(s : SignalspecdaniellGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_graphn_scale(s : SignalspecdaniellGraphN, f : Double) -> SignalspecdaniellGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_add(a : SignalspecdaniellGraphN, b : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_graphn_copy(s : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_fill(s : SignalspecdaniellGraphN, v : Double) -> SignalspecdaniellGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_min(s : SignalspecdaniellGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_graphn_max(s : SignalspecdaniellGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_graphn_to_string(s : SignalspecdaniellGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_node_make(size : Int) -> SignalspecdaniellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_node_len(s : SignalspecdaniellNode) -> Int { s.size }

pub fn signal_spec_daniell_node_get(s : SignalspecdaniellNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_node_set(s : SignalspecdaniellNode, i : Int, v : Double) -> SignalspecdaniellNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_sum(s : SignalspecdaniellNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_node_mean(s : SignalspecdaniellNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_node_scale(s : SignalspecdaniellNode, f : Double) -> SignalspecdaniellNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_add(a : SignalspecdaniellNode, b : SignalspecdaniellNode) -> SignalspecdaniellNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_node_copy(s : SignalspecdaniellNode) -> SignalspecdaniellNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_fill(s : SignalspecdaniellNode, v : Double) -> SignalspecdaniellNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_min(s : SignalspecdaniellNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_node_max(s : SignalspecdaniellNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_node_to_string(s : SignalspecdaniellNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_edge_make(size : Int) -> SignalspecdaniellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_edge_len(s : SignalspecdaniellEdge) -> Int { s.size }

pub fn signal_spec_daniell_edge_get(s : SignalspecdaniellEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_edge_set(s : SignalspecdaniellEdge, i : Int, v : Double) -> SignalspecdaniellEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_sum(s : SignalspecdaniellEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_edge_mean(s : SignalspecdaniellEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_edge_scale(s : SignalspecdaniellEdge, f : Double) -> SignalspecdaniellEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_add(a : SignalspecdaniellEdge, b : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_edge_copy(s : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_fill(s : SignalspecdaniellEdge, v : Double) -> SignalspecdaniellEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_min(s : SignalspecdaniellEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_edge_max(s : SignalspecdaniellEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_edge_to_string(s : SignalspecdaniellEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_path_make(size : Int) -> SignalspecdaniellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_path_len(s : SignalspecdaniellPath) -> Int { s.size }

pub fn signal_spec_daniell_path_get(s : SignalspecdaniellPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_path_set(s : SignalspecdaniellPath, i : Int, v : Double) -> SignalspecdaniellPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_sum(s : SignalspecdaniellPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_path_mean(s : SignalspecdaniellPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_path_scale(s : SignalspecdaniellPath, f : Double) -> SignalspecdaniellPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_add(a : SignalspecdaniellPath, b : SignalspecdaniellPath) -> SignalspecdaniellPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_path_copy(s : SignalspecdaniellPath) -> SignalspecdaniellPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_fill(s : SignalspecdaniellPath, v : Double) -> SignalspecdaniellPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_min(s : SignalspecdaniellPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_path_max(s : SignalspecdaniellPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_path_to_string(s : SignalspecdaniellPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cluster_make(size : Int) -> SignalspecdaniellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_cluster_len(s : SignalspecdaniellCluster) -> Int { s.size }

pub fn signal_spec_daniell_cluster_get(s : SignalspecdaniellCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_cluster_set(s : SignalspecdaniellCluster, i : Int, v : Double) -> SignalspecdaniellCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_sum(s : SignalspecdaniellCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_cluster_mean(s : SignalspecdaniellCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_cluster_scale(s : SignalspecdaniellCluster, f : Double) -> SignalspecdaniellCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_add(a : SignalspecdaniellCluster, b : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_cluster_copy(s : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_fill(s : SignalspecdaniellCluster, v : Double) -> SignalspecdaniellCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_min(s : SignalspecdaniellCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_cluster_max(s : SignalspecdaniellCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_cluster_to_string(s : SignalspecdaniellCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_model_make(size : Int) -> SignalspecdaniellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_model_len(s : SignalspecdaniellModel) -> Int { s.size }

pub fn signal_spec_daniell_model_get(s : SignalspecdaniellModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_model_set(s : SignalspecdaniellModel, i : Int, v : Double) -> SignalspecdaniellModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_sum(s : SignalspecdaniellModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_model_mean(s : SignalspecdaniellModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_model_scale(s : SignalspecdaniellModel, f : Double) -> SignalspecdaniellModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_add(a : SignalspecdaniellModel, b : SignalspecdaniellModel) -> SignalspecdaniellModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_model_copy(s : SignalspecdaniellModel) -> SignalspecdaniellModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_fill(s : SignalspecdaniellModel, v : Double) -> SignalspecdaniellModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_min(s : SignalspecdaniellModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_model_max(s : SignalspecdaniellModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_model_to_string(s : SignalspecdaniellModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_layer_make(size : Int) -> SignalspecdaniellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_layer_len(s : SignalspecdaniellLayer) -> Int { s.size }

pub fn signal_spec_daniell_layer_get(s : SignalspecdaniellLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_layer_set(s : SignalspecdaniellLayer, i : Int, v : Double) -> SignalspecdaniellLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_sum(s : SignalspecdaniellLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_layer_mean(s : SignalspecdaniellLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_layer_scale(s : SignalspecdaniellLayer, f : Double) -> SignalspecdaniellLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_add(a : SignalspecdaniellLayer, b : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_layer_copy(s : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_fill(s : SignalspecdaniellLayer, v : Double) -> SignalspecdaniellLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_min(s : SignalspecdaniellLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_layer_max(s : SignalspecdaniellLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_layer_to_string(s : SignalspecdaniellLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_buffer_make(size : Int) -> SignalspecdaniellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_buffer_len(s : SignalspecdaniellBuffer) -> Int { s.size }

pub fn signal_spec_daniell_buffer_get(s : SignalspecdaniellBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_buffer_set(s : SignalspecdaniellBuffer, i : Int, v : Double) -> SignalspecdaniellBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_sum(s : SignalspecdaniellBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_buffer_mean(s : SignalspecdaniellBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_buffer_scale(s : SignalspecdaniellBuffer, f : Double) -> SignalspecdaniellBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_add(a : SignalspecdaniellBuffer, b : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_buffer_copy(s : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_fill(s : SignalspecdaniellBuffer, v : Double) -> SignalspecdaniellBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_min(s : SignalspecdaniellBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_buffer_max(s : SignalspecdaniellBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_buffer_to_string(s : SignalspecdaniellBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cursor_make(size : Int) -> SignalspecdaniellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_cursor_len(s : SignalspecdaniellCursor) -> Int { s.size }

pub fn signal_spec_daniell_cursor_get(s : SignalspecdaniellCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_cursor_set(s : SignalspecdaniellCursor, i : Int, v : Double) -> SignalspecdaniellCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_sum(s : SignalspecdaniellCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_cursor_mean(s : SignalspecdaniellCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_cursor_scale(s : SignalspecdaniellCursor, f : Double) -> SignalspecdaniellCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_add(a : SignalspecdaniellCursor, b : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_cursor_copy(s : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_fill(s : SignalspecdaniellCursor, v : Double) -> SignalspecdaniellCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_min(s : SignalspecdaniellCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_cursor_max(s : SignalspecdaniellCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_cursor_to_string(s : SignalspecdaniellCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_view_make(size : Int) -> SignalspecdaniellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_view_len(s : SignalspecdaniellView) -> Int { s.size }

pub fn signal_spec_daniell_view_get(s : SignalspecdaniellView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_view_set(s : SignalspecdaniellView, i : Int, v : Double) -> SignalspecdaniellView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_sum(s : SignalspecdaniellView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_view_mean(s : SignalspecdaniellView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_view_scale(s : SignalspecdaniellView, f : Double) -> SignalspecdaniellView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_add(a : SignalspecdaniellView, b : SignalspecdaniellView) -> SignalspecdaniellView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_view_copy(s : SignalspecdaniellView) -> SignalspecdaniellView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_fill(s : SignalspecdaniellView, v : Double) -> SignalspecdaniellView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_min(s : SignalspecdaniellView) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_view_max(s : SignalspecdaniellView) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_view_to_string(s : SignalspecdaniellView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_range_make(size : Int) -> SignalspecdaniellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_range_len(s : SignalspecdaniellRange) -> Int { s.size }

pub fn signal_spec_daniell_range_get(s : SignalspecdaniellRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_range_set(s : SignalspecdaniellRange, i : Int, v : Double) -> SignalspecdaniellRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_sum(s : SignalspecdaniellRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_range_mean(s : SignalspecdaniellRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_range_scale(s : SignalspecdaniellRange, f : Double) -> SignalspecdaniellRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_add(a : SignalspecdaniellRange, b : SignalspecdaniellRange) -> SignalspecdaniellRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_range_copy(s : SignalspecdaniellRange) -> SignalspecdaniellRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_fill(s : SignalspecdaniellRange, v : Double) -> SignalspecdaniellRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_min(s : SignalspecdaniellRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_range_max(s : SignalspecdaniellRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_range_to_string(s : SignalspecdaniellRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_slice_make(size : Int) -> SignalspecdaniellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_slice_len(s : SignalspecdaniellSlice) -> Int { s.size }

pub fn signal_spec_daniell_slice_get(s : SignalspecdaniellSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_slice_set(s : SignalspecdaniellSlice, i : Int, v : Double) -> SignalspecdaniellSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_sum(s : SignalspecdaniellSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_slice_mean(s : SignalspecdaniellSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_slice_scale(s : SignalspecdaniellSlice, f : Double) -> SignalspecdaniellSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_add(a : SignalspecdaniellSlice, b : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_slice_copy(s : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_fill(s : SignalspecdaniellSlice, v : Double) -> SignalspecdaniellSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_min(s : SignalspecdaniellSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_slice_max(s : SignalspecdaniellSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_slice_to_string(s : SignalspecdaniellSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

