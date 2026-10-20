///===
/// extcore/signal_filter_elliptic

pub(all) struct SignalfilterellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_elliptic_make_point(x : Double, y : Double) -> SignalfilterellipticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_elliptic_make_point3(x : Double, y : Double, z : Double) -> SignalfilterellipticPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterellipticPoint::x(self : SignalfilterellipticPoint) -> Double { self.x }

pub fn SignalfilterellipticPoint::y(self : SignalfilterellipticPoint) -> Double { self.y }

pub fn SignalfilterellipticPoint::z(self : SignalfilterellipticPoint) -> Double { self.z }

pub fn SignalfilterellipticPoint::label(self : SignalfilterellipticPoint) -> Int { self.label }

pub fn SignalfilterellipticPoint::dist(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterellipticPoint::add(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterellipticPoint::sub(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterellipticPoint::scale(self : SignalfilterellipticPoint, s : Double) -> SignalfilterellipticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterellipticPoint::dot(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterellipticPoint::cross(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterellipticPoint::norm(self : SignalfilterellipticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterellipticPoint::normalize(self : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterellipticPoint::negate(self : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterellipticPoint::mid(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterellipticPoint::lerp(self : SignalfilterellipticPoint, other : SignalfilterellipticPoint, t : Double) -> SignalfilterellipticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterellipticPoint::to_string(self : SignalfilterellipticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_elliptic_make_series(vals : Array[Double], name : String) -> SignalfilterellipticSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterellipticSeries::len(self : SignalfilterellipticSeries) -> Int { self.vals.length() }

pub fn SignalfilterellipticSeries::sum(self : SignalfilterellipticSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterellipticSeries::mean(self : SignalfilterellipticSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterellipticSeries::min(self : SignalfilterellipticSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterellipticSeries::max(self : SignalfilterellipticSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterellipticSeries::range(self : SignalfilterellipticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterellipticSeries::variance(self : SignalfilterellipticSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterellipticSeries::std(self : SignalfilterellipticSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterellipticSeries::median(self : SignalfilterellipticSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterellipticSeries::scale(self : SignalfilterellipticSeries, f : Double) -> SignalfilterellipticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterellipticSeries::add(self : SignalfilterellipticSeries, other : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterellipticSeries::sub(self : SignalfilterellipticSeries, other : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterellipticSeries::normalize(self : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterellipticSeries::cumsum(self : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterellipticSeries::to_string(self : SignalfilterellipticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterellipticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_elliptic_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterellipticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_elliptic_matrix_identity(n : Int) -> SignalfilterellipticMatrix {
  let m = signal_filter_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterellipticMatrix::get(self : SignalfilterellipticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterellipticMatrix::transpose(self : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterellipticMatrix::add(self : SignalfilterellipticMatrix, other : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterellipticMatrix::scale(self : SignalfilterellipticMatrix, s : Double) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterellipticMatrix::multiply(self : SignalfilterellipticMatrix, other : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  if self.cols != other.rows { return signal_filter_elliptic_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_elliptic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilterellipticMatrix::trace(self : SignalfilterellipticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterellipticMatrix::det(self : SignalfilterellipticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterellipticMatrix::norm(self : SignalfilterellipticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterellipticMatrix::to_string(self : SignalfilterellipticMatrix) -> String {
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

pub(all) struct SignalfilterellipticVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_elliptic_make_vector(comps : Array[Double]) -> SignalfilterellipticVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_elliptic_vector_zero(dim : Int) -> SignalfilterellipticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterellipticVector::add(self : SignalfilterellipticVector, other : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterellipticVector::sub(self : SignalfilterellipticVector, other : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterellipticVector::scale(self : SignalfilterellipticVector, s : Double) -> SignalfilterellipticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterellipticVector::dot(self : SignalfilterellipticVector, other : SignalfilterellipticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterellipticVector::norm(self : SignalfilterellipticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterellipticVector::normalize(self : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterellipticVector::dist(self : SignalfilterellipticVector, other : SignalfilterellipticVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterellipticVector::to_string(self : SignalfilterellipticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_elliptic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_elliptic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_elliptic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_elliptic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_elliptic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_elliptic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_elliptic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_elliptic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_elliptic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_elliptic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_elliptic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_elliptic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_elliptic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_elliptic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_elliptic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_elliptic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_elliptic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_elliptic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_elliptic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_elliptic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_elliptic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_elliptic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_elliptic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_elliptic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_elliptic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_elliptic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_elliptic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_elliptic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_elliptic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterellipticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_frame_make(size : Int) -> SignalfilterellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_frame_len(s : SignalfilterellipticFrame) -> Int { s.size }

pub fn signal_filter_elliptic_frame_get(s : SignalfilterellipticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_frame_set(s : SignalfilterellipticFrame, i : Int, v : Double) -> SignalfilterellipticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_sum(s : SignalfilterellipticFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_frame_mean(s : SignalfilterellipticFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_frame_scale(s : SignalfilterellipticFrame, f : Double) -> SignalfilterellipticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_add(a : SignalfilterellipticFrame, b : SignalfilterellipticFrame) -> SignalfilterellipticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_frame_copy(s : SignalfilterellipticFrame) -> SignalfilterellipticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_fill(s : SignalfilterellipticFrame, v : Double) -> SignalfilterellipticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_min(s : SignalfilterellipticFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_frame_max(s : SignalfilterellipticFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_frame_to_string(s : SignalfilterellipticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_table_make(size : Int) -> SignalfilterellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_table_len(s : SignalfilterellipticTable) -> Int { s.size }

pub fn signal_filter_elliptic_table_get(s : SignalfilterellipticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_table_set(s : SignalfilterellipticTable, i : Int, v : Double) -> SignalfilterellipticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_sum(s : SignalfilterellipticTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_table_mean(s : SignalfilterellipticTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_table_scale(s : SignalfilterellipticTable, f : Double) -> SignalfilterellipticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_add(a : SignalfilterellipticTable, b : SignalfilterellipticTable) -> SignalfilterellipticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_table_copy(s : SignalfilterellipticTable) -> SignalfilterellipticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_fill(s : SignalfilterellipticTable, v : Double) -> SignalfilterellipticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_min(s : SignalfilterellipticTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_table_max(s : SignalfilterellipticTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_table_to_string(s : SignalfilterellipticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_graphn_make(size : Int) -> SignalfilterellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_graphn_len(s : SignalfilterellipticGraphN) -> Int { s.size }

pub fn signal_filter_elliptic_graphn_get(s : SignalfilterellipticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_graphn_set(s : SignalfilterellipticGraphN, i : Int, v : Double) -> SignalfilterellipticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_sum(s : SignalfilterellipticGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_graphn_mean(s : SignalfilterellipticGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_graphn_scale(s : SignalfilterellipticGraphN, f : Double) -> SignalfilterellipticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_add(a : SignalfilterellipticGraphN, b : SignalfilterellipticGraphN) -> SignalfilterellipticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_graphn_copy(s : SignalfilterellipticGraphN) -> SignalfilterellipticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_fill(s : SignalfilterellipticGraphN, v : Double) -> SignalfilterellipticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_min(s : SignalfilterellipticGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_graphn_max(s : SignalfilterellipticGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_graphn_to_string(s : SignalfilterellipticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_node_make(size : Int) -> SignalfilterellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_node_len(s : SignalfilterellipticNode) -> Int { s.size }

pub fn signal_filter_elliptic_node_get(s : SignalfilterellipticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_node_set(s : SignalfilterellipticNode, i : Int, v : Double) -> SignalfilterellipticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_sum(s : SignalfilterellipticNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_node_mean(s : SignalfilterellipticNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_node_scale(s : SignalfilterellipticNode, f : Double) -> SignalfilterellipticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_add(a : SignalfilterellipticNode, b : SignalfilterellipticNode) -> SignalfilterellipticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_node_copy(s : SignalfilterellipticNode) -> SignalfilterellipticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_fill(s : SignalfilterellipticNode, v : Double) -> SignalfilterellipticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_min(s : SignalfilterellipticNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_node_max(s : SignalfilterellipticNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_node_to_string(s : SignalfilterellipticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_edge_make(size : Int) -> SignalfilterellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_edge_len(s : SignalfilterellipticEdge) -> Int { s.size }

pub fn signal_filter_elliptic_edge_get(s : SignalfilterellipticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_edge_set(s : SignalfilterellipticEdge, i : Int, v : Double) -> SignalfilterellipticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_sum(s : SignalfilterellipticEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_edge_mean(s : SignalfilterellipticEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_edge_scale(s : SignalfilterellipticEdge, f : Double) -> SignalfilterellipticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_add(a : SignalfilterellipticEdge, b : SignalfilterellipticEdge) -> SignalfilterellipticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_edge_copy(s : SignalfilterellipticEdge) -> SignalfilterellipticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_fill(s : SignalfilterellipticEdge, v : Double) -> SignalfilterellipticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_min(s : SignalfilterellipticEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_edge_max(s : SignalfilterellipticEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_edge_to_string(s : SignalfilterellipticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_path_make(size : Int) -> SignalfilterellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_path_len(s : SignalfilterellipticPath) -> Int { s.size }

pub fn signal_filter_elliptic_path_get(s : SignalfilterellipticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_path_set(s : SignalfilterellipticPath, i : Int, v : Double) -> SignalfilterellipticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_sum(s : SignalfilterellipticPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_path_mean(s : SignalfilterellipticPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_path_scale(s : SignalfilterellipticPath, f : Double) -> SignalfilterellipticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_add(a : SignalfilterellipticPath, b : SignalfilterellipticPath) -> SignalfilterellipticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_path_copy(s : SignalfilterellipticPath) -> SignalfilterellipticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_fill(s : SignalfilterellipticPath, v : Double) -> SignalfilterellipticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_min(s : SignalfilterellipticPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_path_max(s : SignalfilterellipticPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_path_to_string(s : SignalfilterellipticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_cluster_make(size : Int) -> SignalfilterellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_cluster_len(s : SignalfilterellipticCluster) -> Int { s.size }

pub fn signal_filter_elliptic_cluster_get(s : SignalfilterellipticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_cluster_set(s : SignalfilterellipticCluster, i : Int, v : Double) -> SignalfilterellipticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_sum(s : SignalfilterellipticCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_cluster_mean(s : SignalfilterellipticCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_cluster_scale(s : SignalfilterellipticCluster, f : Double) -> SignalfilterellipticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_add(a : SignalfilterellipticCluster, b : SignalfilterellipticCluster) -> SignalfilterellipticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_cluster_copy(s : SignalfilterellipticCluster) -> SignalfilterellipticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_fill(s : SignalfilterellipticCluster, v : Double) -> SignalfilterellipticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_min(s : SignalfilterellipticCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_cluster_max(s : SignalfilterellipticCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_cluster_to_string(s : SignalfilterellipticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_model_make(size : Int) -> SignalfilterellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_model_len(s : SignalfilterellipticModel) -> Int { s.size }

pub fn signal_filter_elliptic_model_get(s : SignalfilterellipticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_model_set(s : SignalfilterellipticModel, i : Int, v : Double) -> SignalfilterellipticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_sum(s : SignalfilterellipticModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_model_mean(s : SignalfilterellipticModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_model_scale(s : SignalfilterellipticModel, f : Double) -> SignalfilterellipticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_add(a : SignalfilterellipticModel, b : SignalfilterellipticModel) -> SignalfilterellipticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_model_copy(s : SignalfilterellipticModel) -> SignalfilterellipticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_fill(s : SignalfilterellipticModel, v : Double) -> SignalfilterellipticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_min(s : SignalfilterellipticModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_model_max(s : SignalfilterellipticModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_model_to_string(s : SignalfilterellipticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_layer_make(size : Int) -> SignalfilterellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_layer_len(s : SignalfilterellipticLayer) -> Int { s.size }

pub fn signal_filter_elliptic_layer_get(s : SignalfilterellipticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_layer_set(s : SignalfilterellipticLayer, i : Int, v : Double) -> SignalfilterellipticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_sum(s : SignalfilterellipticLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_layer_mean(s : SignalfilterellipticLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_layer_scale(s : SignalfilterellipticLayer, f : Double) -> SignalfilterellipticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_add(a : SignalfilterellipticLayer, b : SignalfilterellipticLayer) -> SignalfilterellipticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_layer_copy(s : SignalfilterellipticLayer) -> SignalfilterellipticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_fill(s : SignalfilterellipticLayer, v : Double) -> SignalfilterellipticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_min(s : SignalfilterellipticLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_layer_max(s : SignalfilterellipticLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_layer_to_string(s : SignalfilterellipticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_buffer_make(size : Int) -> SignalfilterellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_buffer_len(s : SignalfilterellipticBuffer) -> Int { s.size }

pub fn signal_filter_elliptic_buffer_get(s : SignalfilterellipticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_buffer_set(s : SignalfilterellipticBuffer, i : Int, v : Double) -> SignalfilterellipticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_sum(s : SignalfilterellipticBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_buffer_mean(s : SignalfilterellipticBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_buffer_scale(s : SignalfilterellipticBuffer, f : Double) -> SignalfilterellipticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_add(a : SignalfilterellipticBuffer, b : SignalfilterellipticBuffer) -> SignalfilterellipticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_buffer_copy(s : SignalfilterellipticBuffer) -> SignalfilterellipticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_fill(s : SignalfilterellipticBuffer, v : Double) -> SignalfilterellipticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_min(s : SignalfilterellipticBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_buffer_max(s : SignalfilterellipticBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_buffer_to_string(s : SignalfilterellipticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_cursor_make(size : Int) -> SignalfilterellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_cursor_len(s : SignalfilterellipticCursor) -> Int { s.size }

pub fn signal_filter_elliptic_cursor_get(s : SignalfilterellipticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_cursor_set(s : SignalfilterellipticCursor, i : Int, v : Double) -> SignalfilterellipticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_sum(s : SignalfilterellipticCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_cursor_mean(s : SignalfilterellipticCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_cursor_scale(s : SignalfilterellipticCursor, f : Double) -> SignalfilterellipticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_add(a : SignalfilterellipticCursor, b : SignalfilterellipticCursor) -> SignalfilterellipticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_cursor_copy(s : SignalfilterellipticCursor) -> SignalfilterellipticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_fill(s : SignalfilterellipticCursor, v : Double) -> SignalfilterellipticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_min(s : SignalfilterellipticCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_cursor_max(s : SignalfilterellipticCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_cursor_to_string(s : SignalfilterellipticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_view_make(size : Int) -> SignalfilterellipticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_view_len(s : SignalfilterellipticView) -> Int { s.size }

pub fn signal_filter_elliptic_view_get(s : SignalfilterellipticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_view_set(s : SignalfilterellipticView, i : Int, v : Double) -> SignalfilterellipticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_sum(s : SignalfilterellipticView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_view_mean(s : SignalfilterellipticView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_view_scale(s : SignalfilterellipticView, f : Double) -> SignalfilterellipticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_add(a : SignalfilterellipticView, b : SignalfilterellipticView) -> SignalfilterellipticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_view_copy(s : SignalfilterellipticView) -> SignalfilterellipticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_fill(s : SignalfilterellipticView, v : Double) -> SignalfilterellipticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_min(s : SignalfilterellipticView) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_view_max(s : SignalfilterellipticView) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_view_to_string(s : SignalfilterellipticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_range_make(size : Int) -> SignalfilterellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_range_len(s : SignalfilterellipticRange) -> Int { s.size }

pub fn signal_filter_elliptic_range_get(s : SignalfilterellipticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_range_set(s : SignalfilterellipticRange, i : Int, v : Double) -> SignalfilterellipticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_sum(s : SignalfilterellipticRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_range_mean(s : SignalfilterellipticRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_range_scale(s : SignalfilterellipticRange, f : Double) -> SignalfilterellipticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_add(a : SignalfilterellipticRange, b : SignalfilterellipticRange) -> SignalfilterellipticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_range_copy(s : SignalfilterellipticRange) -> SignalfilterellipticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_fill(s : SignalfilterellipticRange, v : Double) -> SignalfilterellipticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_min(s : SignalfilterellipticRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_range_max(s : SignalfilterellipticRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_range_to_string(s : SignalfilterellipticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_slice_make(size : Int) -> SignalfilterellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_slice_len(s : SignalfilterellipticSlice) -> Int { s.size }

pub fn signal_filter_elliptic_slice_get(s : SignalfilterellipticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_slice_set(s : SignalfilterellipticSlice, i : Int, v : Double) -> SignalfilterellipticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_sum(s : SignalfilterellipticSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_slice_mean(s : SignalfilterellipticSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_slice_scale(s : SignalfilterellipticSlice, f : Double) -> SignalfilterellipticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_add(a : SignalfilterellipticSlice, b : SignalfilterellipticSlice) -> SignalfilterellipticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_slice_copy(s : SignalfilterellipticSlice) -> SignalfilterellipticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_fill(s : SignalfilterellipticSlice, v : Double) -> SignalfilterellipticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_min(s : SignalfilterellipticSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_slice_max(s : SignalfilterellipticSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_slice_to_string(s : SignalfilterellipticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

