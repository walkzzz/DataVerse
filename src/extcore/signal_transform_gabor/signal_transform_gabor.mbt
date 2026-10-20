///===
/// extcore/signal_transform_gabor

pub(all) struct SignaltransformgaborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_gabor_make_point(x : Double, y : Double) -> SignaltransformgaborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_gabor_make_point3(x : Double, y : Double, z : Double) -> SignaltransformgaborPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformgaborPoint::x(self : SignaltransformgaborPoint) -> Double { self.x }

pub fn SignaltransformgaborPoint::y(self : SignaltransformgaborPoint) -> Double { self.y }

pub fn SignaltransformgaborPoint::z(self : SignaltransformgaborPoint) -> Double { self.z }

pub fn SignaltransformgaborPoint::label(self : SignaltransformgaborPoint) -> Int { self.label }

pub fn SignaltransformgaborPoint::dist(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformgaborPoint::add(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformgaborPoint::sub(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformgaborPoint::scale(self : SignaltransformgaborPoint, s : Double) -> SignaltransformgaborPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformgaborPoint::dot(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformgaborPoint::cross(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformgaborPoint::norm(self : SignaltransformgaborPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformgaborPoint::normalize(self : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformgaborPoint::negate(self : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformgaborPoint::mid(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint) -> SignaltransformgaborPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformgaborPoint::lerp(self : SignaltransformgaborPoint, other : SignaltransformgaborPoint, t : Double) -> SignaltransformgaborPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformgaborPoint::to_string(self : SignaltransformgaborPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformgaborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_gabor_make_series(vals : Array[Double], name : String) -> SignaltransformgaborSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformgaborSeries::len(self : SignaltransformgaborSeries) -> Int { self.vals.length() }

pub fn SignaltransformgaborSeries::sum(self : SignaltransformgaborSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformgaborSeries::mean(self : SignaltransformgaborSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformgaborSeries::min(self : SignaltransformgaborSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformgaborSeries::max(self : SignaltransformgaborSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformgaborSeries::range(self : SignaltransformgaborSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformgaborSeries::variance(self : SignaltransformgaborSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformgaborSeries::std(self : SignaltransformgaborSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformgaborSeries::median(self : SignaltransformgaborSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformgaborSeries::scale(self : SignaltransformgaborSeries, f : Double) -> SignaltransformgaborSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformgaborSeries::add(self : SignaltransformgaborSeries, other : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformgaborSeries::sub(self : SignaltransformgaborSeries, other : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformgaborSeries::normalize(self : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformgaborSeries::cumsum(self : SignaltransformgaborSeries) -> SignaltransformgaborSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformgaborSeries::to_string(self : SignaltransformgaborSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformgaborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_gabor_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformgaborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_gabor_matrix_identity(n : Int) -> SignaltransformgaborMatrix {
  let m = signal_transform_gabor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformgaborMatrix::get(self : SignaltransformgaborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformgaborMatrix::transpose(self : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  let result = signal_transform_gabor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformgaborMatrix::add(self : SignaltransformgaborMatrix, other : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformgaborMatrix::scale(self : SignaltransformgaborMatrix, s : Double) -> SignaltransformgaborMatrix {
  let result = signal_transform_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformgaborMatrix::multiply(self : SignaltransformgaborMatrix, other : SignaltransformgaborMatrix) -> SignaltransformgaborMatrix {
  if self.cols != other.rows { return signal_transform_gabor_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_gabor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformgaborMatrix::trace(self : SignaltransformgaborMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformgaborMatrix::det(self : SignaltransformgaborMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformgaborMatrix::norm(self : SignaltransformgaborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformgaborMatrix::to_string(self : SignaltransformgaborMatrix) -> String {
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

pub(all) struct SignaltransformgaborVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_gabor_make_vector(comps : Array[Double]) -> SignaltransformgaborVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_gabor_vector_zero(dim : Int) -> SignaltransformgaborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformgaborVector::add(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformgaborVector::sub(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformgaborVector::scale(self : SignaltransformgaborVector, s : Double) -> SignaltransformgaborVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformgaborVector::dot(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformgaborVector::norm(self : SignaltransformgaborVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformgaborVector::normalize(self : SignaltransformgaborVector) -> SignaltransformgaborVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformgaborVector::dist(self : SignaltransformgaborVector, other : SignaltransformgaborVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformgaborVector::to_string(self : SignaltransformgaborVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_gabor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_gabor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_gabor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_gabor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_gabor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_gabor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_gabor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_gabor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_gabor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_gabor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_gabor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_gabor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_gabor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_gabor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_gabor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_gabor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_gabor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_gabor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_gabor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_gabor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_gabor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_gabor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_gabor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_gabor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_gabor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_gabor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_gabor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_gabor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_gabor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformgaborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_frame_make(size : Int) -> SignaltransformgaborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_frame_len(s : SignaltransformgaborFrame) -> Int { s.size }

pub fn signal_transform_gabor_frame_get(s : SignaltransformgaborFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_frame_set(s : SignaltransformgaborFrame, i : Int, v : Double) -> SignaltransformgaborFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_frame_sum(s : SignaltransformgaborFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_frame_mean(s : SignaltransformgaborFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_frame_scale(s : SignaltransformgaborFrame, f : Double) -> SignaltransformgaborFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_frame_add(a : SignaltransformgaborFrame, b : SignaltransformgaborFrame) -> SignaltransformgaborFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_frame_copy(s : SignaltransformgaborFrame) -> SignaltransformgaborFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_frame_fill(s : SignaltransformgaborFrame, v : Double) -> SignaltransformgaborFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_frame_min(s : SignaltransformgaborFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_frame_max(s : SignaltransformgaborFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_frame_to_string(s : SignaltransformgaborFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_table_make(size : Int) -> SignaltransformgaborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_table_len(s : SignaltransformgaborTable) -> Int { s.size }

pub fn signal_transform_gabor_table_get(s : SignaltransformgaborTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_table_set(s : SignaltransformgaborTable, i : Int, v : Double) -> SignaltransformgaborTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_table_sum(s : SignaltransformgaborTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_table_mean(s : SignaltransformgaborTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_table_scale(s : SignaltransformgaborTable, f : Double) -> SignaltransformgaborTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_table_add(a : SignaltransformgaborTable, b : SignaltransformgaborTable) -> SignaltransformgaborTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_table_copy(s : SignaltransformgaborTable) -> SignaltransformgaborTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_table_fill(s : SignaltransformgaborTable, v : Double) -> SignaltransformgaborTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_table_min(s : SignaltransformgaborTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_table_max(s : SignaltransformgaborTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_table_to_string(s : SignaltransformgaborTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_graphn_make(size : Int) -> SignaltransformgaborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_graphn_len(s : SignaltransformgaborGraphN) -> Int { s.size }

pub fn signal_transform_gabor_graphn_get(s : SignaltransformgaborGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_graphn_set(s : SignaltransformgaborGraphN, i : Int, v : Double) -> SignaltransformgaborGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_graphn_sum(s : SignaltransformgaborGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_graphn_mean(s : SignaltransformgaborGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_graphn_scale(s : SignaltransformgaborGraphN, f : Double) -> SignaltransformgaborGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_graphn_add(a : SignaltransformgaborGraphN, b : SignaltransformgaborGraphN) -> SignaltransformgaborGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_graphn_copy(s : SignaltransformgaborGraphN) -> SignaltransformgaborGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_graphn_fill(s : SignaltransformgaborGraphN, v : Double) -> SignaltransformgaborGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_graphn_min(s : SignaltransformgaborGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_graphn_max(s : SignaltransformgaborGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_graphn_to_string(s : SignaltransformgaborGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_node_make(size : Int) -> SignaltransformgaborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_node_len(s : SignaltransformgaborNode) -> Int { s.size }

pub fn signal_transform_gabor_node_get(s : SignaltransformgaborNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_node_set(s : SignaltransformgaborNode, i : Int, v : Double) -> SignaltransformgaborNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_node_sum(s : SignaltransformgaborNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_node_mean(s : SignaltransformgaborNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_node_scale(s : SignaltransformgaborNode, f : Double) -> SignaltransformgaborNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_node_add(a : SignaltransformgaborNode, b : SignaltransformgaborNode) -> SignaltransformgaborNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_node_copy(s : SignaltransformgaborNode) -> SignaltransformgaborNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_node_fill(s : SignaltransformgaborNode, v : Double) -> SignaltransformgaborNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_node_min(s : SignaltransformgaborNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_node_max(s : SignaltransformgaborNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_node_to_string(s : SignaltransformgaborNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_edge_make(size : Int) -> SignaltransformgaborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_edge_len(s : SignaltransformgaborEdge) -> Int { s.size }

pub fn signal_transform_gabor_edge_get(s : SignaltransformgaborEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_edge_set(s : SignaltransformgaborEdge, i : Int, v : Double) -> SignaltransformgaborEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_edge_sum(s : SignaltransformgaborEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_edge_mean(s : SignaltransformgaborEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_edge_scale(s : SignaltransformgaborEdge, f : Double) -> SignaltransformgaborEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_edge_add(a : SignaltransformgaborEdge, b : SignaltransformgaborEdge) -> SignaltransformgaborEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_edge_copy(s : SignaltransformgaborEdge) -> SignaltransformgaborEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_edge_fill(s : SignaltransformgaborEdge, v : Double) -> SignaltransformgaborEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_edge_min(s : SignaltransformgaborEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_edge_max(s : SignaltransformgaborEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_edge_to_string(s : SignaltransformgaborEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_path_make(size : Int) -> SignaltransformgaborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_path_len(s : SignaltransformgaborPath) -> Int { s.size }

pub fn signal_transform_gabor_path_get(s : SignaltransformgaborPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_path_set(s : SignaltransformgaborPath, i : Int, v : Double) -> SignaltransformgaborPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_path_sum(s : SignaltransformgaborPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_path_mean(s : SignaltransformgaborPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_path_scale(s : SignaltransformgaborPath, f : Double) -> SignaltransformgaborPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_path_add(a : SignaltransformgaborPath, b : SignaltransformgaborPath) -> SignaltransformgaborPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_path_copy(s : SignaltransformgaborPath) -> SignaltransformgaborPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_path_fill(s : SignaltransformgaborPath, v : Double) -> SignaltransformgaborPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_path_min(s : SignaltransformgaborPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_path_max(s : SignaltransformgaborPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_path_to_string(s : SignaltransformgaborPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_cluster_make(size : Int) -> SignaltransformgaborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_cluster_len(s : SignaltransformgaborCluster) -> Int { s.size }

pub fn signal_transform_gabor_cluster_get(s : SignaltransformgaborCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_cluster_set(s : SignaltransformgaborCluster, i : Int, v : Double) -> SignaltransformgaborCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cluster_sum(s : SignaltransformgaborCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_cluster_mean(s : SignaltransformgaborCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_cluster_scale(s : SignaltransformgaborCluster, f : Double) -> SignaltransformgaborCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cluster_add(a : SignaltransformgaborCluster, b : SignaltransformgaborCluster) -> SignaltransformgaborCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_cluster_copy(s : SignaltransformgaborCluster) -> SignaltransformgaborCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cluster_fill(s : SignaltransformgaborCluster, v : Double) -> SignaltransformgaborCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cluster_min(s : SignaltransformgaborCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_cluster_max(s : SignaltransformgaborCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_cluster_to_string(s : SignaltransformgaborCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_model_make(size : Int) -> SignaltransformgaborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_model_len(s : SignaltransformgaborModel) -> Int { s.size }

pub fn signal_transform_gabor_model_get(s : SignaltransformgaborModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_model_set(s : SignaltransformgaborModel, i : Int, v : Double) -> SignaltransformgaborModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_model_sum(s : SignaltransformgaborModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_model_mean(s : SignaltransformgaborModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_model_scale(s : SignaltransformgaborModel, f : Double) -> SignaltransformgaborModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_model_add(a : SignaltransformgaborModel, b : SignaltransformgaborModel) -> SignaltransformgaborModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_model_copy(s : SignaltransformgaborModel) -> SignaltransformgaborModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_model_fill(s : SignaltransformgaborModel, v : Double) -> SignaltransformgaborModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_model_min(s : SignaltransformgaborModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_model_max(s : SignaltransformgaborModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_model_to_string(s : SignaltransformgaborModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_layer_make(size : Int) -> SignaltransformgaborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_layer_len(s : SignaltransformgaborLayer) -> Int { s.size }

pub fn signal_transform_gabor_layer_get(s : SignaltransformgaborLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_layer_set(s : SignaltransformgaborLayer, i : Int, v : Double) -> SignaltransformgaborLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_layer_sum(s : SignaltransformgaborLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_layer_mean(s : SignaltransformgaborLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_layer_scale(s : SignaltransformgaborLayer, f : Double) -> SignaltransformgaborLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_layer_add(a : SignaltransformgaborLayer, b : SignaltransformgaborLayer) -> SignaltransformgaborLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_layer_copy(s : SignaltransformgaborLayer) -> SignaltransformgaborLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_layer_fill(s : SignaltransformgaborLayer, v : Double) -> SignaltransformgaborLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_layer_min(s : SignaltransformgaborLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_layer_max(s : SignaltransformgaborLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_layer_to_string(s : SignaltransformgaborLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_buffer_make(size : Int) -> SignaltransformgaborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_buffer_len(s : SignaltransformgaborBuffer) -> Int { s.size }

pub fn signal_transform_gabor_buffer_get(s : SignaltransformgaborBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_buffer_set(s : SignaltransformgaborBuffer, i : Int, v : Double) -> SignaltransformgaborBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_buffer_sum(s : SignaltransformgaborBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_buffer_mean(s : SignaltransformgaborBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_buffer_scale(s : SignaltransformgaborBuffer, f : Double) -> SignaltransformgaborBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_buffer_add(a : SignaltransformgaborBuffer, b : SignaltransformgaborBuffer) -> SignaltransformgaborBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_buffer_copy(s : SignaltransformgaborBuffer) -> SignaltransformgaborBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_buffer_fill(s : SignaltransformgaborBuffer, v : Double) -> SignaltransformgaborBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_buffer_min(s : SignaltransformgaborBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_buffer_max(s : SignaltransformgaborBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_buffer_to_string(s : SignaltransformgaborBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_cursor_make(size : Int) -> SignaltransformgaborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_cursor_len(s : SignaltransformgaborCursor) -> Int { s.size }

pub fn signal_transform_gabor_cursor_get(s : SignaltransformgaborCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_cursor_set(s : SignaltransformgaborCursor, i : Int, v : Double) -> SignaltransformgaborCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cursor_sum(s : SignaltransformgaborCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_cursor_mean(s : SignaltransformgaborCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_cursor_scale(s : SignaltransformgaborCursor, f : Double) -> SignaltransformgaborCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cursor_add(a : SignaltransformgaborCursor, b : SignaltransformgaborCursor) -> SignaltransformgaborCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_cursor_copy(s : SignaltransformgaborCursor) -> SignaltransformgaborCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cursor_fill(s : SignaltransformgaborCursor, v : Double) -> SignaltransformgaborCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_cursor_min(s : SignaltransformgaborCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_cursor_max(s : SignaltransformgaborCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_cursor_to_string(s : SignaltransformgaborCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_view_make(size : Int) -> SignaltransformgaborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_view_len(s : SignaltransformgaborView) -> Int { s.size }

pub fn signal_transform_gabor_view_get(s : SignaltransformgaborView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_view_set(s : SignaltransformgaborView, i : Int, v : Double) -> SignaltransformgaborView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_view_sum(s : SignaltransformgaborView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_view_mean(s : SignaltransformgaborView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_view_scale(s : SignaltransformgaborView, f : Double) -> SignaltransformgaborView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_view_add(a : SignaltransformgaborView, b : SignaltransformgaborView) -> SignaltransformgaborView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_view_copy(s : SignaltransformgaborView) -> SignaltransformgaborView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_view_fill(s : SignaltransformgaborView, v : Double) -> SignaltransformgaborView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_view_min(s : SignaltransformgaborView) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_view_max(s : SignaltransformgaborView) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_view_to_string(s : SignaltransformgaborView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_range_make(size : Int) -> SignaltransformgaborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_range_len(s : SignaltransformgaborRange) -> Int { s.size }

pub fn signal_transform_gabor_range_get(s : SignaltransformgaborRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_range_set(s : SignaltransformgaborRange, i : Int, v : Double) -> SignaltransformgaborRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_range_sum(s : SignaltransformgaborRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_range_mean(s : SignaltransformgaborRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_range_scale(s : SignaltransformgaborRange, f : Double) -> SignaltransformgaborRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_range_add(a : SignaltransformgaborRange, b : SignaltransformgaborRange) -> SignaltransformgaborRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_range_copy(s : SignaltransformgaborRange) -> SignaltransformgaborRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_range_fill(s : SignaltransformgaborRange, v : Double) -> SignaltransformgaborRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_range_min(s : SignaltransformgaborRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_range_max(s : SignaltransformgaborRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_range_to_string(s : SignaltransformgaborRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformgaborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_gabor_slice_make(size : Int) -> SignaltransformgaborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_gabor_slice_len(s : SignaltransformgaborSlice) -> Int { s.size }

pub fn signal_transform_gabor_slice_get(s : SignaltransformgaborSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_gabor_slice_set(s : SignaltransformgaborSlice, i : Int, v : Double) -> SignaltransformgaborSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_slice_sum(s : SignaltransformgaborSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_gabor_slice_mean(s : SignaltransformgaborSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_gabor_slice_scale(s : SignaltransformgaborSlice, f : Double) -> SignaltransformgaborSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_slice_add(a : SignaltransformgaborSlice, b : SignaltransformgaborSlice) -> SignaltransformgaborSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_gabor_slice_copy(s : SignaltransformgaborSlice) -> SignaltransformgaborSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_slice_fill(s : SignaltransformgaborSlice, v : Double) -> SignaltransformgaborSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_gabor_slice_min(s : SignaltransformgaborSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_gabor_slice_max(s : SignaltransformgaborSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_gabor_slice_to_string(s : SignaltransformgaborSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

