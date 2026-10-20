///===
/// extcore/signal_transform_dct

pub(all) struct SignaltransformdctPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dct_make_point(x : Double, y : Double) -> SignaltransformdctPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dct_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdctPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformdctPoint::x(self : SignaltransformdctPoint) -> Double { self.x }

pub fn SignaltransformdctPoint::y(self : SignaltransformdctPoint) -> Double { self.y }

pub fn SignaltransformdctPoint::z(self : SignaltransformdctPoint) -> Double { self.z }

pub fn SignaltransformdctPoint::label(self : SignaltransformdctPoint) -> Int { self.label }

pub fn SignaltransformdctPoint::dist(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformdctPoint::add(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformdctPoint::sub(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformdctPoint::scale(self : SignaltransformdctPoint, s : Double) -> SignaltransformdctPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformdctPoint::dot(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformdctPoint::cross(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformdctPoint::norm(self : SignaltransformdctPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformdctPoint::normalize(self : SignaltransformdctPoint) -> SignaltransformdctPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdctPoint::negate(self : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformdctPoint::mid(self : SignaltransformdctPoint, other : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformdctPoint::lerp(self : SignaltransformdctPoint, other : SignaltransformdctPoint, t : Double) -> SignaltransformdctPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformdctPoint::to_string(self : SignaltransformdctPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformdctSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dct_make_series(vals : Array[Double], name : String) -> SignaltransformdctSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformdctSeries::len(self : SignaltransformdctSeries) -> Int { self.vals.length() }

pub fn SignaltransformdctSeries::sum(self : SignaltransformdctSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformdctSeries::mean(self : SignaltransformdctSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformdctSeries::min(self : SignaltransformdctSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformdctSeries::max(self : SignaltransformdctSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformdctSeries::range(self : SignaltransformdctSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformdctSeries::variance(self : SignaltransformdctSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformdctSeries::std(self : SignaltransformdctSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformdctSeries::median(self : SignaltransformdctSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformdctSeries::scale(self : SignaltransformdctSeries, f : Double) -> SignaltransformdctSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformdctSeries::add(self : SignaltransformdctSeries, other : SignaltransformdctSeries) -> SignaltransformdctSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformdctSeries::sub(self : SignaltransformdctSeries, other : SignaltransformdctSeries) -> SignaltransformdctSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformdctSeries::normalize(self : SignaltransformdctSeries) -> SignaltransformdctSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformdctSeries::cumsum(self : SignaltransformdctSeries) -> SignaltransformdctSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformdctSeries::to_string(self : SignaltransformdctSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdctMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dct_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdctMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dct_matrix_identity(n : Int) -> SignaltransformdctMatrix {
  let m = signal_transform_dct_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformdctMatrix::get(self : SignaltransformdctMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformdctMatrix::transpose(self : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  let result = signal_transform_dct_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformdctMatrix::add(self : SignaltransformdctMatrix, other : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_dct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformdctMatrix::scale(self : SignaltransformdctMatrix, s : Double) -> SignaltransformdctMatrix {
  let result = signal_transform_dct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformdctMatrix::multiply(self : SignaltransformdctMatrix, other : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  if self.cols != other.rows { return signal_transform_dct_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_dct_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformdctMatrix::trace(self : SignaltransformdctMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformdctMatrix::det(self : SignaltransformdctMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformdctMatrix::norm(self : SignaltransformdctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformdctMatrix::to_string(self : SignaltransformdctMatrix) -> String {
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

pub(all) struct SignaltransformdctVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dct_make_vector(comps : Array[Double]) -> SignaltransformdctVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dct_vector_zero(dim : Int) -> SignaltransformdctVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformdctVector::add(self : SignaltransformdctVector, other : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdctVector::sub(self : SignaltransformdctVector, other : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdctVector::scale(self : SignaltransformdctVector, s : Double) -> SignaltransformdctVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformdctVector::dot(self : SignaltransformdctVector, other : SignaltransformdctVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformdctVector::norm(self : SignaltransformdctVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformdctVector::normalize(self : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdctVector::dist(self : SignaltransformdctVector, other : SignaltransformdctVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformdctVector::to_string(self : SignaltransformdctVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dct_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_dct_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_dct_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_dct_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_dct_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_dct_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_dct_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_dct_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_dct_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_dct_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_dct_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_dct_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_dct_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_dct_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_dct_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_dct_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_dct_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_dct_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_dct_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_dct_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_dct_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_dct_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_dct_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_dct_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_dct_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_dct_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_dct_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_dct_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_dct_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformdctFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_frame_make(size : Int) -> SignaltransformdctFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_frame_len(s : SignaltransformdctFrame) -> Int { s.size }

pub fn signal_transform_dct_frame_get(s : SignaltransformdctFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_frame_set(s : SignaltransformdctFrame, i : Int, v : Double) -> SignaltransformdctFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_frame_sum(s : SignaltransformdctFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_frame_mean(s : SignaltransformdctFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_frame_scale(s : SignaltransformdctFrame, f : Double) -> SignaltransformdctFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_frame_add(a : SignaltransformdctFrame, b : SignaltransformdctFrame) -> SignaltransformdctFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_frame_copy(s : SignaltransformdctFrame) -> SignaltransformdctFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_frame_fill(s : SignaltransformdctFrame, v : Double) -> SignaltransformdctFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_frame_min(s : SignaltransformdctFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_frame_max(s : SignaltransformdctFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_frame_to_string(s : SignaltransformdctFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_table_make(size : Int) -> SignaltransformdctTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_table_len(s : SignaltransformdctTable) -> Int { s.size }

pub fn signal_transform_dct_table_get(s : SignaltransformdctTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_table_set(s : SignaltransformdctTable, i : Int, v : Double) -> SignaltransformdctTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_table_sum(s : SignaltransformdctTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_table_mean(s : SignaltransformdctTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_table_scale(s : SignaltransformdctTable, f : Double) -> SignaltransformdctTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_table_add(a : SignaltransformdctTable, b : SignaltransformdctTable) -> SignaltransformdctTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_table_copy(s : SignaltransformdctTable) -> SignaltransformdctTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_table_fill(s : SignaltransformdctTable, v : Double) -> SignaltransformdctTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_table_min(s : SignaltransformdctTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_table_max(s : SignaltransformdctTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_table_to_string(s : SignaltransformdctTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_graphn_make(size : Int) -> SignaltransformdctGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_graphn_len(s : SignaltransformdctGraphN) -> Int { s.size }

pub fn signal_transform_dct_graphn_get(s : SignaltransformdctGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_graphn_set(s : SignaltransformdctGraphN, i : Int, v : Double) -> SignaltransformdctGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_graphn_sum(s : SignaltransformdctGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_graphn_mean(s : SignaltransformdctGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_graphn_scale(s : SignaltransformdctGraphN, f : Double) -> SignaltransformdctGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_graphn_add(a : SignaltransformdctGraphN, b : SignaltransformdctGraphN) -> SignaltransformdctGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_graphn_copy(s : SignaltransformdctGraphN) -> SignaltransformdctGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_graphn_fill(s : SignaltransformdctGraphN, v : Double) -> SignaltransformdctGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_graphn_min(s : SignaltransformdctGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_graphn_max(s : SignaltransformdctGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_graphn_to_string(s : SignaltransformdctGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_node_make(size : Int) -> SignaltransformdctNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_node_len(s : SignaltransformdctNode) -> Int { s.size }

pub fn signal_transform_dct_node_get(s : SignaltransformdctNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_node_set(s : SignaltransformdctNode, i : Int, v : Double) -> SignaltransformdctNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_node_sum(s : SignaltransformdctNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_node_mean(s : SignaltransformdctNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_node_scale(s : SignaltransformdctNode, f : Double) -> SignaltransformdctNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_node_add(a : SignaltransformdctNode, b : SignaltransformdctNode) -> SignaltransformdctNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_node_copy(s : SignaltransformdctNode) -> SignaltransformdctNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_node_fill(s : SignaltransformdctNode, v : Double) -> SignaltransformdctNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_node_min(s : SignaltransformdctNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_node_max(s : SignaltransformdctNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_node_to_string(s : SignaltransformdctNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_edge_make(size : Int) -> SignaltransformdctEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_edge_len(s : SignaltransformdctEdge) -> Int { s.size }

pub fn signal_transform_dct_edge_get(s : SignaltransformdctEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_edge_set(s : SignaltransformdctEdge, i : Int, v : Double) -> SignaltransformdctEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_edge_sum(s : SignaltransformdctEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_edge_mean(s : SignaltransformdctEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_edge_scale(s : SignaltransformdctEdge, f : Double) -> SignaltransformdctEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_edge_add(a : SignaltransformdctEdge, b : SignaltransformdctEdge) -> SignaltransformdctEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_edge_copy(s : SignaltransformdctEdge) -> SignaltransformdctEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_edge_fill(s : SignaltransformdctEdge, v : Double) -> SignaltransformdctEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_edge_min(s : SignaltransformdctEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_edge_max(s : SignaltransformdctEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_edge_to_string(s : SignaltransformdctEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_path_make(size : Int) -> SignaltransformdctPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_path_len(s : SignaltransformdctPath) -> Int { s.size }

pub fn signal_transform_dct_path_get(s : SignaltransformdctPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_path_set(s : SignaltransformdctPath, i : Int, v : Double) -> SignaltransformdctPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_path_sum(s : SignaltransformdctPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_path_mean(s : SignaltransformdctPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_path_scale(s : SignaltransformdctPath, f : Double) -> SignaltransformdctPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_path_add(a : SignaltransformdctPath, b : SignaltransformdctPath) -> SignaltransformdctPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_path_copy(s : SignaltransformdctPath) -> SignaltransformdctPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_path_fill(s : SignaltransformdctPath, v : Double) -> SignaltransformdctPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_path_min(s : SignaltransformdctPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_path_max(s : SignaltransformdctPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_path_to_string(s : SignaltransformdctPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_cluster_make(size : Int) -> SignaltransformdctCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_cluster_len(s : SignaltransformdctCluster) -> Int { s.size }

pub fn signal_transform_dct_cluster_get(s : SignaltransformdctCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_cluster_set(s : SignaltransformdctCluster, i : Int, v : Double) -> SignaltransformdctCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cluster_sum(s : SignaltransformdctCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_cluster_mean(s : SignaltransformdctCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_cluster_scale(s : SignaltransformdctCluster, f : Double) -> SignaltransformdctCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cluster_add(a : SignaltransformdctCluster, b : SignaltransformdctCluster) -> SignaltransformdctCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_cluster_copy(s : SignaltransformdctCluster) -> SignaltransformdctCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cluster_fill(s : SignaltransformdctCluster, v : Double) -> SignaltransformdctCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cluster_min(s : SignaltransformdctCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_cluster_max(s : SignaltransformdctCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_cluster_to_string(s : SignaltransformdctCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_model_make(size : Int) -> SignaltransformdctModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_model_len(s : SignaltransformdctModel) -> Int { s.size }

pub fn signal_transform_dct_model_get(s : SignaltransformdctModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_model_set(s : SignaltransformdctModel, i : Int, v : Double) -> SignaltransformdctModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_model_sum(s : SignaltransformdctModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_model_mean(s : SignaltransformdctModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_model_scale(s : SignaltransformdctModel, f : Double) -> SignaltransformdctModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_model_add(a : SignaltransformdctModel, b : SignaltransformdctModel) -> SignaltransformdctModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_model_copy(s : SignaltransformdctModel) -> SignaltransformdctModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_model_fill(s : SignaltransformdctModel, v : Double) -> SignaltransformdctModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_model_min(s : SignaltransformdctModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_model_max(s : SignaltransformdctModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_model_to_string(s : SignaltransformdctModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_layer_make(size : Int) -> SignaltransformdctLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_layer_len(s : SignaltransformdctLayer) -> Int { s.size }

pub fn signal_transform_dct_layer_get(s : SignaltransformdctLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_layer_set(s : SignaltransformdctLayer, i : Int, v : Double) -> SignaltransformdctLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_layer_sum(s : SignaltransformdctLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_layer_mean(s : SignaltransformdctLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_layer_scale(s : SignaltransformdctLayer, f : Double) -> SignaltransformdctLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_layer_add(a : SignaltransformdctLayer, b : SignaltransformdctLayer) -> SignaltransformdctLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_layer_copy(s : SignaltransformdctLayer) -> SignaltransformdctLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_layer_fill(s : SignaltransformdctLayer, v : Double) -> SignaltransformdctLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_layer_min(s : SignaltransformdctLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_layer_max(s : SignaltransformdctLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_layer_to_string(s : SignaltransformdctLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_buffer_make(size : Int) -> SignaltransformdctBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_buffer_len(s : SignaltransformdctBuffer) -> Int { s.size }

pub fn signal_transform_dct_buffer_get(s : SignaltransformdctBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_buffer_set(s : SignaltransformdctBuffer, i : Int, v : Double) -> SignaltransformdctBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_buffer_sum(s : SignaltransformdctBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_buffer_mean(s : SignaltransformdctBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_buffer_scale(s : SignaltransformdctBuffer, f : Double) -> SignaltransformdctBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_buffer_add(a : SignaltransformdctBuffer, b : SignaltransformdctBuffer) -> SignaltransformdctBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_buffer_copy(s : SignaltransformdctBuffer) -> SignaltransformdctBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_buffer_fill(s : SignaltransformdctBuffer, v : Double) -> SignaltransformdctBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_buffer_min(s : SignaltransformdctBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_buffer_max(s : SignaltransformdctBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_buffer_to_string(s : SignaltransformdctBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_cursor_make(size : Int) -> SignaltransformdctCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_cursor_len(s : SignaltransformdctCursor) -> Int { s.size }

pub fn signal_transform_dct_cursor_get(s : SignaltransformdctCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_cursor_set(s : SignaltransformdctCursor, i : Int, v : Double) -> SignaltransformdctCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cursor_sum(s : SignaltransformdctCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_cursor_mean(s : SignaltransformdctCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_cursor_scale(s : SignaltransformdctCursor, f : Double) -> SignaltransformdctCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cursor_add(a : SignaltransformdctCursor, b : SignaltransformdctCursor) -> SignaltransformdctCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_cursor_copy(s : SignaltransformdctCursor) -> SignaltransformdctCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cursor_fill(s : SignaltransformdctCursor, v : Double) -> SignaltransformdctCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_cursor_min(s : SignaltransformdctCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_cursor_max(s : SignaltransformdctCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_cursor_to_string(s : SignaltransformdctCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_view_make(size : Int) -> SignaltransformdctView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_view_len(s : SignaltransformdctView) -> Int { s.size }

pub fn signal_transform_dct_view_get(s : SignaltransformdctView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_view_set(s : SignaltransformdctView, i : Int, v : Double) -> SignaltransformdctView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_view_sum(s : SignaltransformdctView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_view_mean(s : SignaltransformdctView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_view_scale(s : SignaltransformdctView, f : Double) -> SignaltransformdctView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_view_add(a : SignaltransformdctView, b : SignaltransformdctView) -> SignaltransformdctView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_view_copy(s : SignaltransformdctView) -> SignaltransformdctView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_view_fill(s : SignaltransformdctView, v : Double) -> SignaltransformdctView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_view_min(s : SignaltransformdctView) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_view_max(s : SignaltransformdctView) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_view_to_string(s : SignaltransformdctView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_range_make(size : Int) -> SignaltransformdctRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_range_len(s : SignaltransformdctRange) -> Int { s.size }

pub fn signal_transform_dct_range_get(s : SignaltransformdctRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_range_set(s : SignaltransformdctRange, i : Int, v : Double) -> SignaltransformdctRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_range_sum(s : SignaltransformdctRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_range_mean(s : SignaltransformdctRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_range_scale(s : SignaltransformdctRange, f : Double) -> SignaltransformdctRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_range_add(a : SignaltransformdctRange, b : SignaltransformdctRange) -> SignaltransformdctRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_range_copy(s : SignaltransformdctRange) -> SignaltransformdctRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_range_fill(s : SignaltransformdctRange, v : Double) -> SignaltransformdctRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_range_min(s : SignaltransformdctRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_range_max(s : SignaltransformdctRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_range_to_string(s : SignaltransformdctRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_slice_make(size : Int) -> SignaltransformdctSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_slice_len(s : SignaltransformdctSlice) -> Int { s.size }

pub fn signal_transform_dct_slice_get(s : SignaltransformdctSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_slice_set(s : SignaltransformdctSlice, i : Int, v : Double) -> SignaltransformdctSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_slice_sum(s : SignaltransformdctSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dct_slice_mean(s : SignaltransformdctSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dct_slice_scale(s : SignaltransformdctSlice, f : Double) -> SignaltransformdctSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_slice_add(a : SignaltransformdctSlice, b : SignaltransformdctSlice) -> SignaltransformdctSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dct_slice_copy(s : SignaltransformdctSlice) -> SignaltransformdctSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_slice_fill(s : SignaltransformdctSlice, v : Double) -> SignaltransformdctSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dct_slice_min(s : SignaltransformdctSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_dct_slice_max(s : SignaltransformdctSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_dct_slice_to_string(s : SignaltransformdctSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

