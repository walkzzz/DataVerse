///===
/// extcore/signal_transform_stft

pub(all) struct SignaltransformstftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_stft_make_point(x : Double, y : Double) -> SignaltransformstftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_stft_make_point3(x : Double, y : Double, z : Double) -> SignaltransformstftPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformstftPoint::x(self : SignaltransformstftPoint) -> Double { self.x }

pub fn SignaltransformstftPoint::y(self : SignaltransformstftPoint) -> Double { self.y }

pub fn SignaltransformstftPoint::z(self : SignaltransformstftPoint) -> Double { self.z }

pub fn SignaltransformstftPoint::label(self : SignaltransformstftPoint) -> Int { self.label }

pub fn SignaltransformstftPoint::dist(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformstftPoint::add(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformstftPoint::sub(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformstftPoint::scale(self : SignaltransformstftPoint, s : Double) -> SignaltransformstftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformstftPoint::dot(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformstftPoint::cross(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformstftPoint::norm(self : SignaltransformstftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformstftPoint::normalize(self : SignaltransformstftPoint) -> SignaltransformstftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformstftPoint::negate(self : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformstftPoint::mid(self : SignaltransformstftPoint, other : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformstftPoint::lerp(self : SignaltransformstftPoint, other : SignaltransformstftPoint, t : Double) -> SignaltransformstftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformstftPoint::to_string(self : SignaltransformstftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformstftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_stft_make_series(vals : Array[Double], name : String) -> SignaltransformstftSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformstftSeries::len(self : SignaltransformstftSeries) -> Int { self.vals.length() }

pub fn SignaltransformstftSeries::sum(self : SignaltransformstftSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformstftSeries::mean(self : SignaltransformstftSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformstftSeries::min(self : SignaltransformstftSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformstftSeries::max(self : SignaltransformstftSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformstftSeries::range(self : SignaltransformstftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformstftSeries::variance(self : SignaltransformstftSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformstftSeries::std(self : SignaltransformstftSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformstftSeries::median(self : SignaltransformstftSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformstftSeries::scale(self : SignaltransformstftSeries, f : Double) -> SignaltransformstftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformstftSeries::add(self : SignaltransformstftSeries, other : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformstftSeries::sub(self : SignaltransformstftSeries, other : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformstftSeries::normalize(self : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformstftSeries::cumsum(self : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformstftSeries::to_string(self : SignaltransformstftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformstftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_stft_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformstftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_stft_matrix_identity(n : Int) -> SignaltransformstftMatrix {
  let m = signal_transform_stft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformstftMatrix::get(self : SignaltransformstftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformstftMatrix::transpose(self : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformstftMatrix::add(self : SignaltransformstftMatrix, other : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_stft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformstftMatrix::scale(self : SignaltransformstftMatrix, s : Double) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformstftMatrix::multiply(self : SignaltransformstftMatrix, other : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if self.cols != other.rows { return signal_transform_stft_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_stft_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformstftMatrix::trace(self : SignaltransformstftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformstftMatrix::det(self : SignaltransformstftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformstftMatrix::norm(self : SignaltransformstftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformstftMatrix::to_string(self : SignaltransformstftMatrix) -> String {
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

pub(all) struct SignaltransformstftVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_stft_make_vector(comps : Array[Double]) -> SignaltransformstftVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_stft_vector_zero(dim : Int) -> SignaltransformstftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformstftVector::add(self : SignaltransformstftVector, other : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformstftVector::sub(self : SignaltransformstftVector, other : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformstftVector::scale(self : SignaltransformstftVector, s : Double) -> SignaltransformstftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformstftVector::dot(self : SignaltransformstftVector, other : SignaltransformstftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformstftVector::norm(self : SignaltransformstftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformstftVector::normalize(self : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformstftVector::dist(self : SignaltransformstftVector, other : SignaltransformstftVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformstftVector::to_string(self : SignaltransformstftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_stft_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_stft_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_stft_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_stft_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_stft_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_stft_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_stft_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_stft_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_stft_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_stft_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_stft_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_stft_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_stft_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_stft_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_stft_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_stft_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_stft_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_stft_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_stft_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_stft_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_stft_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_stft_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_stft_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_stft_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_stft_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_stft_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_stft_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_stft_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_stft_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformstftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_frame_make(size : Int) -> SignaltransformstftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_frame_len(s : SignaltransformstftFrame) -> Int { s.size }

pub fn signal_transform_stft_frame_get(s : SignaltransformstftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_frame_set(s : SignaltransformstftFrame, i : Int, v : Double) -> SignaltransformstftFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_sum(s : SignaltransformstftFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_frame_mean(s : SignaltransformstftFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_frame_scale(s : SignaltransformstftFrame, f : Double) -> SignaltransformstftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_add(a : SignaltransformstftFrame, b : SignaltransformstftFrame) -> SignaltransformstftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_frame_copy(s : SignaltransformstftFrame) -> SignaltransformstftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_fill(s : SignaltransformstftFrame, v : Double) -> SignaltransformstftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_min(s : SignaltransformstftFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_frame_max(s : SignaltransformstftFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_frame_to_string(s : SignaltransformstftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_table_make(size : Int) -> SignaltransformstftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_table_len(s : SignaltransformstftTable) -> Int { s.size }

pub fn signal_transform_stft_table_get(s : SignaltransformstftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_table_set(s : SignaltransformstftTable, i : Int, v : Double) -> SignaltransformstftTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_sum(s : SignaltransformstftTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_table_mean(s : SignaltransformstftTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_table_scale(s : SignaltransformstftTable, f : Double) -> SignaltransformstftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_add(a : SignaltransformstftTable, b : SignaltransformstftTable) -> SignaltransformstftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_table_copy(s : SignaltransformstftTable) -> SignaltransformstftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_fill(s : SignaltransformstftTable, v : Double) -> SignaltransformstftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_min(s : SignaltransformstftTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_table_max(s : SignaltransformstftTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_table_to_string(s : SignaltransformstftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_graphn_make(size : Int) -> SignaltransformstftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_graphn_len(s : SignaltransformstftGraphN) -> Int { s.size }

pub fn signal_transform_stft_graphn_get(s : SignaltransformstftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_graphn_set(s : SignaltransformstftGraphN, i : Int, v : Double) -> SignaltransformstftGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_sum(s : SignaltransformstftGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_graphn_mean(s : SignaltransformstftGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_graphn_scale(s : SignaltransformstftGraphN, f : Double) -> SignaltransformstftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_add(a : SignaltransformstftGraphN, b : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_graphn_copy(s : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_fill(s : SignaltransformstftGraphN, v : Double) -> SignaltransformstftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_min(s : SignaltransformstftGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_graphn_max(s : SignaltransformstftGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_graphn_to_string(s : SignaltransformstftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_node_make(size : Int) -> SignaltransformstftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_node_len(s : SignaltransformstftNode) -> Int { s.size }

pub fn signal_transform_stft_node_get(s : SignaltransformstftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_node_set(s : SignaltransformstftNode, i : Int, v : Double) -> SignaltransformstftNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_sum(s : SignaltransformstftNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_node_mean(s : SignaltransformstftNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_node_scale(s : SignaltransformstftNode, f : Double) -> SignaltransformstftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_add(a : SignaltransformstftNode, b : SignaltransformstftNode) -> SignaltransformstftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_node_copy(s : SignaltransformstftNode) -> SignaltransformstftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_fill(s : SignaltransformstftNode, v : Double) -> SignaltransformstftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_min(s : SignaltransformstftNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_node_max(s : SignaltransformstftNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_node_to_string(s : SignaltransformstftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_edge_make(size : Int) -> SignaltransformstftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_edge_len(s : SignaltransformstftEdge) -> Int { s.size }

pub fn signal_transform_stft_edge_get(s : SignaltransformstftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_edge_set(s : SignaltransformstftEdge, i : Int, v : Double) -> SignaltransformstftEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_sum(s : SignaltransformstftEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_edge_mean(s : SignaltransformstftEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_edge_scale(s : SignaltransformstftEdge, f : Double) -> SignaltransformstftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_add(a : SignaltransformstftEdge, b : SignaltransformstftEdge) -> SignaltransformstftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_edge_copy(s : SignaltransformstftEdge) -> SignaltransformstftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_fill(s : SignaltransformstftEdge, v : Double) -> SignaltransformstftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_min(s : SignaltransformstftEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_edge_max(s : SignaltransformstftEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_edge_to_string(s : SignaltransformstftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_path_make(size : Int) -> SignaltransformstftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_path_len(s : SignaltransformstftPath) -> Int { s.size }

pub fn signal_transform_stft_path_get(s : SignaltransformstftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_path_set(s : SignaltransformstftPath, i : Int, v : Double) -> SignaltransformstftPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_sum(s : SignaltransformstftPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_path_mean(s : SignaltransformstftPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_path_scale(s : SignaltransformstftPath, f : Double) -> SignaltransformstftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_add(a : SignaltransformstftPath, b : SignaltransformstftPath) -> SignaltransformstftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_path_copy(s : SignaltransformstftPath) -> SignaltransformstftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_fill(s : SignaltransformstftPath, v : Double) -> SignaltransformstftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_min(s : SignaltransformstftPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_path_max(s : SignaltransformstftPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_path_to_string(s : SignaltransformstftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cluster_make(size : Int) -> SignaltransformstftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_cluster_len(s : SignaltransformstftCluster) -> Int { s.size }

pub fn signal_transform_stft_cluster_get(s : SignaltransformstftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_cluster_set(s : SignaltransformstftCluster, i : Int, v : Double) -> SignaltransformstftCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_sum(s : SignaltransformstftCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_cluster_mean(s : SignaltransformstftCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_cluster_scale(s : SignaltransformstftCluster, f : Double) -> SignaltransformstftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_add(a : SignaltransformstftCluster, b : SignaltransformstftCluster) -> SignaltransformstftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_cluster_copy(s : SignaltransformstftCluster) -> SignaltransformstftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_fill(s : SignaltransformstftCluster, v : Double) -> SignaltransformstftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_min(s : SignaltransformstftCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_cluster_max(s : SignaltransformstftCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_cluster_to_string(s : SignaltransformstftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_model_make(size : Int) -> SignaltransformstftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_model_len(s : SignaltransformstftModel) -> Int { s.size }

pub fn signal_transform_stft_model_get(s : SignaltransformstftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_model_set(s : SignaltransformstftModel, i : Int, v : Double) -> SignaltransformstftModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_sum(s : SignaltransformstftModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_model_mean(s : SignaltransformstftModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_model_scale(s : SignaltransformstftModel, f : Double) -> SignaltransformstftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_add(a : SignaltransformstftModel, b : SignaltransformstftModel) -> SignaltransformstftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_model_copy(s : SignaltransformstftModel) -> SignaltransformstftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_fill(s : SignaltransformstftModel, v : Double) -> SignaltransformstftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_min(s : SignaltransformstftModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_model_max(s : SignaltransformstftModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_model_to_string(s : SignaltransformstftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_layer_make(size : Int) -> SignaltransformstftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_layer_len(s : SignaltransformstftLayer) -> Int { s.size }

pub fn signal_transform_stft_layer_get(s : SignaltransformstftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_layer_set(s : SignaltransformstftLayer, i : Int, v : Double) -> SignaltransformstftLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_sum(s : SignaltransformstftLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_layer_mean(s : SignaltransformstftLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_layer_scale(s : SignaltransformstftLayer, f : Double) -> SignaltransformstftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_add(a : SignaltransformstftLayer, b : SignaltransformstftLayer) -> SignaltransformstftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_layer_copy(s : SignaltransformstftLayer) -> SignaltransformstftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_fill(s : SignaltransformstftLayer, v : Double) -> SignaltransformstftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_min(s : SignaltransformstftLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_layer_max(s : SignaltransformstftLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_layer_to_string(s : SignaltransformstftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_buffer_make(size : Int) -> SignaltransformstftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_buffer_len(s : SignaltransformstftBuffer) -> Int { s.size }

pub fn signal_transform_stft_buffer_get(s : SignaltransformstftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_buffer_set(s : SignaltransformstftBuffer, i : Int, v : Double) -> SignaltransformstftBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_sum(s : SignaltransformstftBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_buffer_mean(s : SignaltransformstftBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_buffer_scale(s : SignaltransformstftBuffer, f : Double) -> SignaltransformstftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_add(a : SignaltransformstftBuffer, b : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_buffer_copy(s : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_fill(s : SignaltransformstftBuffer, v : Double) -> SignaltransformstftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_min(s : SignaltransformstftBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_buffer_max(s : SignaltransformstftBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_buffer_to_string(s : SignaltransformstftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cursor_make(size : Int) -> SignaltransformstftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_cursor_len(s : SignaltransformstftCursor) -> Int { s.size }

pub fn signal_transform_stft_cursor_get(s : SignaltransformstftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_cursor_set(s : SignaltransformstftCursor, i : Int, v : Double) -> SignaltransformstftCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_sum(s : SignaltransformstftCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_cursor_mean(s : SignaltransformstftCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_cursor_scale(s : SignaltransformstftCursor, f : Double) -> SignaltransformstftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_add(a : SignaltransformstftCursor, b : SignaltransformstftCursor) -> SignaltransformstftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_cursor_copy(s : SignaltransformstftCursor) -> SignaltransformstftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_fill(s : SignaltransformstftCursor, v : Double) -> SignaltransformstftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_min(s : SignaltransformstftCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_cursor_max(s : SignaltransformstftCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_cursor_to_string(s : SignaltransformstftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_view_make(size : Int) -> SignaltransformstftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_view_len(s : SignaltransformstftView) -> Int { s.size }

pub fn signal_transform_stft_view_get(s : SignaltransformstftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_view_set(s : SignaltransformstftView, i : Int, v : Double) -> SignaltransformstftView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_sum(s : SignaltransformstftView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_view_mean(s : SignaltransformstftView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_view_scale(s : SignaltransformstftView, f : Double) -> SignaltransformstftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_add(a : SignaltransformstftView, b : SignaltransformstftView) -> SignaltransformstftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_view_copy(s : SignaltransformstftView) -> SignaltransformstftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_fill(s : SignaltransformstftView, v : Double) -> SignaltransformstftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_min(s : SignaltransformstftView) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_view_max(s : SignaltransformstftView) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_view_to_string(s : SignaltransformstftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_range_make(size : Int) -> SignaltransformstftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_range_len(s : SignaltransformstftRange) -> Int { s.size }

pub fn signal_transform_stft_range_get(s : SignaltransformstftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_range_set(s : SignaltransformstftRange, i : Int, v : Double) -> SignaltransformstftRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_sum(s : SignaltransformstftRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_range_mean(s : SignaltransformstftRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_range_scale(s : SignaltransformstftRange, f : Double) -> SignaltransformstftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_add(a : SignaltransformstftRange, b : SignaltransformstftRange) -> SignaltransformstftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_range_copy(s : SignaltransformstftRange) -> SignaltransformstftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_fill(s : SignaltransformstftRange, v : Double) -> SignaltransformstftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_min(s : SignaltransformstftRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_range_max(s : SignaltransformstftRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_range_to_string(s : SignaltransformstftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_slice_make(size : Int) -> SignaltransformstftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_slice_len(s : SignaltransformstftSlice) -> Int { s.size }

pub fn signal_transform_stft_slice_get(s : SignaltransformstftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_slice_set(s : SignaltransformstftSlice, i : Int, v : Double) -> SignaltransformstftSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_sum(s : SignaltransformstftSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_slice_mean(s : SignaltransformstftSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_slice_scale(s : SignaltransformstftSlice, f : Double) -> SignaltransformstftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_add(a : SignaltransformstftSlice, b : SignaltransformstftSlice) -> SignaltransformstftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_slice_copy(s : SignaltransformstftSlice) -> SignaltransformstftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_fill(s : SignaltransformstftSlice, v : Double) -> SignaltransformstftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_min(s : SignaltransformstftSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_slice_max(s : SignaltransformstftSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_slice_to_string(s : SignaltransformstftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

