///===
/// extcore/signal_transform_fft

pub(all) struct SignaltransformfftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_fft_make_point(x : Double, y : Double) -> SignaltransformfftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_fft_make_point3(x : Double, y : Double, z : Double) -> SignaltransformfftPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformfftPoint::x(self : SignaltransformfftPoint) -> Double { self.x }

pub fn SignaltransformfftPoint::y(self : SignaltransformfftPoint) -> Double { self.y }

pub fn SignaltransformfftPoint::z(self : SignaltransformfftPoint) -> Double { self.z }

pub fn SignaltransformfftPoint::label(self : SignaltransformfftPoint) -> Int { self.label }

pub fn SignaltransformfftPoint::dist(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformfftPoint::add(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformfftPoint::sub(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformfftPoint::scale(self : SignaltransformfftPoint, s : Double) -> SignaltransformfftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformfftPoint::dot(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformfftPoint::cross(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformfftPoint::norm(self : SignaltransformfftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformfftPoint::normalize(self : SignaltransformfftPoint) -> SignaltransformfftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformfftPoint::negate(self : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformfftPoint::mid(self : SignaltransformfftPoint, other : SignaltransformfftPoint) -> SignaltransformfftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformfftPoint::lerp(self : SignaltransformfftPoint, other : SignaltransformfftPoint, t : Double) -> SignaltransformfftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformfftPoint::to_string(self : SignaltransformfftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformfftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_fft_make_series(vals : Array[Double], name : String) -> SignaltransformfftSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformfftSeries::len(self : SignaltransformfftSeries) -> Int { self.vals.length() }

pub fn SignaltransformfftSeries::sum(self : SignaltransformfftSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformfftSeries::mean(self : SignaltransformfftSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformfftSeries::min(self : SignaltransformfftSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformfftSeries::max(self : SignaltransformfftSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformfftSeries::range(self : SignaltransformfftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformfftSeries::variance(self : SignaltransformfftSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformfftSeries::std(self : SignaltransformfftSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformfftSeries::median(self : SignaltransformfftSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformfftSeries::scale(self : SignaltransformfftSeries, f : Double) -> SignaltransformfftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformfftSeries::add(self : SignaltransformfftSeries, other : SignaltransformfftSeries) -> SignaltransformfftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformfftSeries::sub(self : SignaltransformfftSeries, other : SignaltransformfftSeries) -> SignaltransformfftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformfftSeries::normalize(self : SignaltransformfftSeries) -> SignaltransformfftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformfftSeries::cumsum(self : SignaltransformfftSeries) -> SignaltransformfftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformfftSeries::to_string(self : SignaltransformfftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformfftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_fft_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformfftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_fft_matrix_identity(n : Int) -> SignaltransformfftMatrix {
  let m = signal_transform_fft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformfftMatrix::get(self : SignaltransformfftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformfftMatrix::transpose(self : SignaltransformfftMatrix) -> SignaltransformfftMatrix {
  let result = signal_transform_fft_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformfftMatrix::add(self : SignaltransformfftMatrix, other : SignaltransformfftMatrix) -> SignaltransformfftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_fft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformfftMatrix::scale(self : SignaltransformfftMatrix, s : Double) -> SignaltransformfftMatrix {
  let result = signal_transform_fft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformfftMatrix::multiply(self : SignaltransformfftMatrix, other : SignaltransformfftMatrix) -> SignaltransformfftMatrix {
  if self.cols != other.rows { return signal_transform_fft_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_fft_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformfftMatrix::trace(self : SignaltransformfftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformfftMatrix::det(self : SignaltransformfftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformfftMatrix::norm(self : SignaltransformfftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformfftMatrix::to_string(self : SignaltransformfftMatrix) -> String {
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

pub(all) struct SignaltransformfftVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_fft_make_vector(comps : Array[Double]) -> SignaltransformfftVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_fft_vector_zero(dim : Int) -> SignaltransformfftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformfftVector::add(self : SignaltransformfftVector, other : SignaltransformfftVector) -> SignaltransformfftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformfftVector::sub(self : SignaltransformfftVector, other : SignaltransformfftVector) -> SignaltransformfftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformfftVector::scale(self : SignaltransformfftVector, s : Double) -> SignaltransformfftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformfftVector::dot(self : SignaltransformfftVector, other : SignaltransformfftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformfftVector::norm(self : SignaltransformfftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformfftVector::normalize(self : SignaltransformfftVector) -> SignaltransformfftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformfftVector::dist(self : SignaltransformfftVector, other : SignaltransformfftVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformfftVector::to_string(self : SignaltransformfftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_fft_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_fft_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_fft_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_fft_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_fft_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_fft_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_fft_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_fft_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_fft_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_fft_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_fft_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_fft_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_fft_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_fft_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_fft_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_fft_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_fft_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_fft_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_fft_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_fft_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_fft_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_fft_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_fft_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_fft_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_fft_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_fft_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_fft_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_fft_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_fft_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformfftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_frame_make(size : Int) -> SignaltransformfftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_frame_len(s : SignaltransformfftFrame) -> Int { s.size }

pub fn signal_transform_fft_frame_get(s : SignaltransformfftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_frame_set(s : SignaltransformfftFrame, i : Int, v : Double) -> SignaltransformfftFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_frame_sum(s : SignaltransformfftFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_frame_mean(s : SignaltransformfftFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_frame_scale(s : SignaltransformfftFrame, f : Double) -> SignaltransformfftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_frame_add(a : SignaltransformfftFrame, b : SignaltransformfftFrame) -> SignaltransformfftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_frame_copy(s : SignaltransformfftFrame) -> SignaltransformfftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_frame_fill(s : SignaltransformfftFrame, v : Double) -> SignaltransformfftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_frame_min(s : SignaltransformfftFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_frame_max(s : SignaltransformfftFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_frame_to_string(s : SignaltransformfftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_table_make(size : Int) -> SignaltransformfftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_table_len(s : SignaltransformfftTable) -> Int { s.size }

pub fn signal_transform_fft_table_get(s : SignaltransformfftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_table_set(s : SignaltransformfftTable, i : Int, v : Double) -> SignaltransformfftTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_table_sum(s : SignaltransformfftTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_table_mean(s : SignaltransformfftTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_table_scale(s : SignaltransformfftTable, f : Double) -> SignaltransformfftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_table_add(a : SignaltransformfftTable, b : SignaltransformfftTable) -> SignaltransformfftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_table_copy(s : SignaltransformfftTable) -> SignaltransformfftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_table_fill(s : SignaltransformfftTable, v : Double) -> SignaltransformfftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_table_min(s : SignaltransformfftTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_table_max(s : SignaltransformfftTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_table_to_string(s : SignaltransformfftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_graphn_make(size : Int) -> SignaltransformfftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_graphn_len(s : SignaltransformfftGraphN) -> Int { s.size }

pub fn signal_transform_fft_graphn_get(s : SignaltransformfftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_graphn_set(s : SignaltransformfftGraphN, i : Int, v : Double) -> SignaltransformfftGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_graphn_sum(s : SignaltransformfftGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_graphn_mean(s : SignaltransformfftGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_graphn_scale(s : SignaltransformfftGraphN, f : Double) -> SignaltransformfftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_graphn_add(a : SignaltransformfftGraphN, b : SignaltransformfftGraphN) -> SignaltransformfftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_graphn_copy(s : SignaltransformfftGraphN) -> SignaltransformfftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_graphn_fill(s : SignaltransformfftGraphN, v : Double) -> SignaltransformfftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_graphn_min(s : SignaltransformfftGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_graphn_max(s : SignaltransformfftGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_graphn_to_string(s : SignaltransformfftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_node_make(size : Int) -> SignaltransformfftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_node_len(s : SignaltransformfftNode) -> Int { s.size }

pub fn signal_transform_fft_node_get(s : SignaltransformfftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_node_set(s : SignaltransformfftNode, i : Int, v : Double) -> SignaltransformfftNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_node_sum(s : SignaltransformfftNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_node_mean(s : SignaltransformfftNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_node_scale(s : SignaltransformfftNode, f : Double) -> SignaltransformfftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_node_add(a : SignaltransformfftNode, b : SignaltransformfftNode) -> SignaltransformfftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_node_copy(s : SignaltransformfftNode) -> SignaltransformfftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_node_fill(s : SignaltransformfftNode, v : Double) -> SignaltransformfftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_node_min(s : SignaltransformfftNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_node_max(s : SignaltransformfftNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_node_to_string(s : SignaltransformfftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_edge_make(size : Int) -> SignaltransformfftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_edge_len(s : SignaltransformfftEdge) -> Int { s.size }

pub fn signal_transform_fft_edge_get(s : SignaltransformfftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_edge_set(s : SignaltransformfftEdge, i : Int, v : Double) -> SignaltransformfftEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_edge_sum(s : SignaltransformfftEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_edge_mean(s : SignaltransformfftEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_edge_scale(s : SignaltransformfftEdge, f : Double) -> SignaltransformfftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_edge_add(a : SignaltransformfftEdge, b : SignaltransformfftEdge) -> SignaltransformfftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_edge_copy(s : SignaltransformfftEdge) -> SignaltransformfftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_edge_fill(s : SignaltransformfftEdge, v : Double) -> SignaltransformfftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_edge_min(s : SignaltransformfftEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_edge_max(s : SignaltransformfftEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_edge_to_string(s : SignaltransformfftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_path_make(size : Int) -> SignaltransformfftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_path_len(s : SignaltransformfftPath) -> Int { s.size }

pub fn signal_transform_fft_path_get(s : SignaltransformfftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_path_set(s : SignaltransformfftPath, i : Int, v : Double) -> SignaltransformfftPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_path_sum(s : SignaltransformfftPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_path_mean(s : SignaltransformfftPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_path_scale(s : SignaltransformfftPath, f : Double) -> SignaltransformfftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_path_add(a : SignaltransformfftPath, b : SignaltransformfftPath) -> SignaltransformfftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_path_copy(s : SignaltransformfftPath) -> SignaltransformfftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_path_fill(s : SignaltransformfftPath, v : Double) -> SignaltransformfftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_path_min(s : SignaltransformfftPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_path_max(s : SignaltransformfftPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_path_to_string(s : SignaltransformfftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_cluster_make(size : Int) -> SignaltransformfftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_cluster_len(s : SignaltransformfftCluster) -> Int { s.size }

pub fn signal_transform_fft_cluster_get(s : SignaltransformfftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_cluster_set(s : SignaltransformfftCluster, i : Int, v : Double) -> SignaltransformfftCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cluster_sum(s : SignaltransformfftCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_cluster_mean(s : SignaltransformfftCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_cluster_scale(s : SignaltransformfftCluster, f : Double) -> SignaltransformfftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cluster_add(a : SignaltransformfftCluster, b : SignaltransformfftCluster) -> SignaltransformfftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_cluster_copy(s : SignaltransformfftCluster) -> SignaltransformfftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cluster_fill(s : SignaltransformfftCluster, v : Double) -> SignaltransformfftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cluster_min(s : SignaltransformfftCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_cluster_max(s : SignaltransformfftCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_cluster_to_string(s : SignaltransformfftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_model_make(size : Int) -> SignaltransformfftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_model_len(s : SignaltransformfftModel) -> Int { s.size }

pub fn signal_transform_fft_model_get(s : SignaltransformfftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_model_set(s : SignaltransformfftModel, i : Int, v : Double) -> SignaltransformfftModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_model_sum(s : SignaltransformfftModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_model_mean(s : SignaltransformfftModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_model_scale(s : SignaltransformfftModel, f : Double) -> SignaltransformfftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_model_add(a : SignaltransformfftModel, b : SignaltransformfftModel) -> SignaltransformfftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_model_copy(s : SignaltransformfftModel) -> SignaltransformfftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_model_fill(s : SignaltransformfftModel, v : Double) -> SignaltransformfftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_model_min(s : SignaltransformfftModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_model_max(s : SignaltransformfftModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_model_to_string(s : SignaltransformfftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_layer_make(size : Int) -> SignaltransformfftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_layer_len(s : SignaltransformfftLayer) -> Int { s.size }

pub fn signal_transform_fft_layer_get(s : SignaltransformfftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_layer_set(s : SignaltransformfftLayer, i : Int, v : Double) -> SignaltransformfftLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_layer_sum(s : SignaltransformfftLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_layer_mean(s : SignaltransformfftLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_layer_scale(s : SignaltransformfftLayer, f : Double) -> SignaltransformfftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_layer_add(a : SignaltransformfftLayer, b : SignaltransformfftLayer) -> SignaltransformfftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_layer_copy(s : SignaltransformfftLayer) -> SignaltransformfftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_layer_fill(s : SignaltransformfftLayer, v : Double) -> SignaltransformfftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_layer_min(s : SignaltransformfftLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_layer_max(s : SignaltransformfftLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_layer_to_string(s : SignaltransformfftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_buffer_make(size : Int) -> SignaltransformfftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_buffer_len(s : SignaltransformfftBuffer) -> Int { s.size }

pub fn signal_transform_fft_buffer_get(s : SignaltransformfftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_buffer_set(s : SignaltransformfftBuffer, i : Int, v : Double) -> SignaltransformfftBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_buffer_sum(s : SignaltransformfftBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_buffer_mean(s : SignaltransformfftBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_buffer_scale(s : SignaltransformfftBuffer, f : Double) -> SignaltransformfftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_buffer_add(a : SignaltransformfftBuffer, b : SignaltransformfftBuffer) -> SignaltransformfftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_buffer_copy(s : SignaltransformfftBuffer) -> SignaltransformfftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_buffer_fill(s : SignaltransformfftBuffer, v : Double) -> SignaltransformfftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_buffer_min(s : SignaltransformfftBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_buffer_max(s : SignaltransformfftBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_buffer_to_string(s : SignaltransformfftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_cursor_make(size : Int) -> SignaltransformfftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_cursor_len(s : SignaltransformfftCursor) -> Int { s.size }

pub fn signal_transform_fft_cursor_get(s : SignaltransformfftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_cursor_set(s : SignaltransformfftCursor, i : Int, v : Double) -> SignaltransformfftCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cursor_sum(s : SignaltransformfftCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_cursor_mean(s : SignaltransformfftCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_cursor_scale(s : SignaltransformfftCursor, f : Double) -> SignaltransformfftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cursor_add(a : SignaltransformfftCursor, b : SignaltransformfftCursor) -> SignaltransformfftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_cursor_copy(s : SignaltransformfftCursor) -> SignaltransformfftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cursor_fill(s : SignaltransformfftCursor, v : Double) -> SignaltransformfftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_cursor_min(s : SignaltransformfftCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_cursor_max(s : SignaltransformfftCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_cursor_to_string(s : SignaltransformfftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_view_make(size : Int) -> SignaltransformfftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_view_len(s : SignaltransformfftView) -> Int { s.size }

pub fn signal_transform_fft_view_get(s : SignaltransformfftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_view_set(s : SignaltransformfftView, i : Int, v : Double) -> SignaltransformfftView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_view_sum(s : SignaltransformfftView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_view_mean(s : SignaltransformfftView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_view_scale(s : SignaltransformfftView, f : Double) -> SignaltransformfftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_view_add(a : SignaltransformfftView, b : SignaltransformfftView) -> SignaltransformfftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_view_copy(s : SignaltransformfftView) -> SignaltransformfftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_view_fill(s : SignaltransformfftView, v : Double) -> SignaltransformfftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_view_min(s : SignaltransformfftView) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_view_max(s : SignaltransformfftView) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_view_to_string(s : SignaltransformfftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_range_make(size : Int) -> SignaltransformfftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_range_len(s : SignaltransformfftRange) -> Int { s.size }

pub fn signal_transform_fft_range_get(s : SignaltransformfftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_range_set(s : SignaltransformfftRange, i : Int, v : Double) -> SignaltransformfftRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_range_sum(s : SignaltransformfftRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_range_mean(s : SignaltransformfftRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_range_scale(s : SignaltransformfftRange, f : Double) -> SignaltransformfftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_range_add(a : SignaltransformfftRange, b : SignaltransformfftRange) -> SignaltransformfftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_range_copy(s : SignaltransformfftRange) -> SignaltransformfftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_range_fill(s : SignaltransformfftRange, v : Double) -> SignaltransformfftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_range_min(s : SignaltransformfftRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_range_max(s : SignaltransformfftRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_range_to_string(s : SignaltransformfftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformfftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_fft_slice_make(size : Int) -> SignaltransformfftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_fft_slice_len(s : SignaltransformfftSlice) -> Int { s.size }

pub fn signal_transform_fft_slice_get(s : SignaltransformfftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_fft_slice_set(s : SignaltransformfftSlice, i : Int, v : Double) -> SignaltransformfftSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_slice_sum(s : SignaltransformfftSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_fft_slice_mean(s : SignaltransformfftSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_fft_slice_scale(s : SignaltransformfftSlice, f : Double) -> SignaltransformfftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_slice_add(a : SignaltransformfftSlice, b : SignaltransformfftSlice) -> SignaltransformfftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_fft_slice_copy(s : SignaltransformfftSlice) -> SignaltransformfftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_slice_fill(s : SignaltransformfftSlice, v : Double) -> SignaltransformfftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_fft_slice_min(s : SignaltransformfftSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_fft_slice_max(s : SignaltransformfftSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_fft_slice_to_string(s : SignaltransformfftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

