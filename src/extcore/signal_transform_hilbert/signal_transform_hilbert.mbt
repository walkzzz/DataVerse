///===
/// extcore/signal_transform_hilbert

pub(all) struct SignaltransformhilbertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_hilbert_make_point(x : Double, y : Double) -> SignaltransformhilbertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_hilbert_make_point3(x : Double, y : Double, z : Double) -> SignaltransformhilbertPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformhilbertPoint::x(self : SignaltransformhilbertPoint) -> Double { self.x }

pub fn SignaltransformhilbertPoint::y(self : SignaltransformhilbertPoint) -> Double { self.y }

pub fn SignaltransformhilbertPoint::z(self : SignaltransformhilbertPoint) -> Double { self.z }

pub fn SignaltransformhilbertPoint::label(self : SignaltransformhilbertPoint) -> Int { self.label }

pub fn SignaltransformhilbertPoint::dist(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformhilbertPoint::add(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformhilbertPoint::sub(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformhilbertPoint::scale(self : SignaltransformhilbertPoint, s : Double) -> SignaltransformhilbertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformhilbertPoint::dot(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformhilbertPoint::cross(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformhilbertPoint::norm(self : SignaltransformhilbertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformhilbertPoint::normalize(self : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformhilbertPoint::negate(self : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformhilbertPoint::mid(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint) -> SignaltransformhilbertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformhilbertPoint::lerp(self : SignaltransformhilbertPoint, other : SignaltransformhilbertPoint, t : Double) -> SignaltransformhilbertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformhilbertPoint::to_string(self : SignaltransformhilbertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformhilbertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_hilbert_make_series(vals : Array[Double], name : String) -> SignaltransformhilbertSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformhilbertSeries::len(self : SignaltransformhilbertSeries) -> Int { self.vals.length() }

pub fn SignaltransformhilbertSeries::sum(self : SignaltransformhilbertSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformhilbertSeries::mean(self : SignaltransformhilbertSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformhilbertSeries::min(self : SignaltransformhilbertSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformhilbertSeries::max(self : SignaltransformhilbertSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformhilbertSeries::range(self : SignaltransformhilbertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformhilbertSeries::variance(self : SignaltransformhilbertSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformhilbertSeries::std(self : SignaltransformhilbertSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformhilbertSeries::median(self : SignaltransformhilbertSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformhilbertSeries::scale(self : SignaltransformhilbertSeries, f : Double) -> SignaltransformhilbertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformhilbertSeries::add(self : SignaltransformhilbertSeries, other : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformhilbertSeries::sub(self : SignaltransformhilbertSeries, other : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformhilbertSeries::normalize(self : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformhilbertSeries::cumsum(self : SignaltransformhilbertSeries) -> SignaltransformhilbertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformhilbertSeries::to_string(self : SignaltransformhilbertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformhilbertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_hilbert_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformhilbertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_hilbert_matrix_identity(n : Int) -> SignaltransformhilbertMatrix {
  let m = signal_transform_hilbert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformhilbertMatrix::get(self : SignaltransformhilbertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformhilbertMatrix::transpose(self : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  let result = signal_transform_hilbert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformhilbertMatrix::add(self : SignaltransformhilbertMatrix, other : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_hilbert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformhilbertMatrix::scale(self : SignaltransformhilbertMatrix, s : Double) -> SignaltransformhilbertMatrix {
  let result = signal_transform_hilbert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformhilbertMatrix::multiply(self : SignaltransformhilbertMatrix, other : SignaltransformhilbertMatrix) -> SignaltransformhilbertMatrix {
  if self.cols != other.rows { return signal_transform_hilbert_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_hilbert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformhilbertMatrix::trace(self : SignaltransformhilbertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformhilbertMatrix::det(self : SignaltransformhilbertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformhilbertMatrix::norm(self : SignaltransformhilbertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformhilbertMatrix::to_string(self : SignaltransformhilbertMatrix) -> String {
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

pub(all) struct SignaltransformhilbertVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_hilbert_make_vector(comps : Array[Double]) -> SignaltransformhilbertVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_hilbert_vector_zero(dim : Int) -> SignaltransformhilbertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformhilbertVector::add(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformhilbertVector::sub(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformhilbertVector::scale(self : SignaltransformhilbertVector, s : Double) -> SignaltransformhilbertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformhilbertVector::dot(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformhilbertVector::norm(self : SignaltransformhilbertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformhilbertVector::normalize(self : SignaltransformhilbertVector) -> SignaltransformhilbertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformhilbertVector::dist(self : SignaltransformhilbertVector, other : SignaltransformhilbertVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformhilbertVector::to_string(self : SignaltransformhilbertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_hilbert_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_hilbert_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_hilbert_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_hilbert_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_hilbert_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_hilbert_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_hilbert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_hilbert_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_hilbert_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_hilbert_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_hilbert_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_hilbert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_hilbert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_hilbert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_hilbert_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_hilbert_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_hilbert_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_hilbert_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_hilbert_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_hilbert_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_hilbert_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_hilbert_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_hilbert_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_hilbert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_hilbert_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_hilbert_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_hilbert_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_hilbert_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_hilbert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformhilbertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_frame_make(size : Int) -> SignaltransformhilbertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_frame_len(s : SignaltransformhilbertFrame) -> Int { s.size }

pub fn signal_transform_hilbert_frame_get(s : SignaltransformhilbertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_frame_set(s : SignaltransformhilbertFrame, i : Int, v : Double) -> SignaltransformhilbertFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_frame_sum(s : SignaltransformhilbertFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_frame_mean(s : SignaltransformhilbertFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_frame_scale(s : SignaltransformhilbertFrame, f : Double) -> SignaltransformhilbertFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_frame_add(a : SignaltransformhilbertFrame, b : SignaltransformhilbertFrame) -> SignaltransformhilbertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_frame_copy(s : SignaltransformhilbertFrame) -> SignaltransformhilbertFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_frame_fill(s : SignaltransformhilbertFrame, v : Double) -> SignaltransformhilbertFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_frame_min(s : SignaltransformhilbertFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_frame_max(s : SignaltransformhilbertFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_frame_to_string(s : SignaltransformhilbertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_table_make(size : Int) -> SignaltransformhilbertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_table_len(s : SignaltransformhilbertTable) -> Int { s.size }

pub fn signal_transform_hilbert_table_get(s : SignaltransformhilbertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_table_set(s : SignaltransformhilbertTable, i : Int, v : Double) -> SignaltransformhilbertTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_table_sum(s : SignaltransformhilbertTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_table_mean(s : SignaltransformhilbertTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_table_scale(s : SignaltransformhilbertTable, f : Double) -> SignaltransformhilbertTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_table_add(a : SignaltransformhilbertTable, b : SignaltransformhilbertTable) -> SignaltransformhilbertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_table_copy(s : SignaltransformhilbertTable) -> SignaltransformhilbertTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_table_fill(s : SignaltransformhilbertTable, v : Double) -> SignaltransformhilbertTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_table_min(s : SignaltransformhilbertTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_table_max(s : SignaltransformhilbertTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_table_to_string(s : SignaltransformhilbertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_graphn_make(size : Int) -> SignaltransformhilbertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_graphn_len(s : SignaltransformhilbertGraphN) -> Int { s.size }

pub fn signal_transform_hilbert_graphn_get(s : SignaltransformhilbertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_graphn_set(s : SignaltransformhilbertGraphN, i : Int, v : Double) -> SignaltransformhilbertGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_graphn_sum(s : SignaltransformhilbertGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_graphn_mean(s : SignaltransformhilbertGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_graphn_scale(s : SignaltransformhilbertGraphN, f : Double) -> SignaltransformhilbertGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_graphn_add(a : SignaltransformhilbertGraphN, b : SignaltransformhilbertGraphN) -> SignaltransformhilbertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_graphn_copy(s : SignaltransformhilbertGraphN) -> SignaltransformhilbertGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_graphn_fill(s : SignaltransformhilbertGraphN, v : Double) -> SignaltransformhilbertGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_graphn_min(s : SignaltransformhilbertGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_graphn_max(s : SignaltransformhilbertGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_graphn_to_string(s : SignaltransformhilbertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_node_make(size : Int) -> SignaltransformhilbertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_node_len(s : SignaltransformhilbertNode) -> Int { s.size }

pub fn signal_transform_hilbert_node_get(s : SignaltransformhilbertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_node_set(s : SignaltransformhilbertNode, i : Int, v : Double) -> SignaltransformhilbertNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_node_sum(s : SignaltransformhilbertNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_node_mean(s : SignaltransformhilbertNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_node_scale(s : SignaltransformhilbertNode, f : Double) -> SignaltransformhilbertNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_node_add(a : SignaltransformhilbertNode, b : SignaltransformhilbertNode) -> SignaltransformhilbertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_node_copy(s : SignaltransformhilbertNode) -> SignaltransformhilbertNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_node_fill(s : SignaltransformhilbertNode, v : Double) -> SignaltransformhilbertNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_node_min(s : SignaltransformhilbertNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_node_max(s : SignaltransformhilbertNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_node_to_string(s : SignaltransformhilbertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_edge_make(size : Int) -> SignaltransformhilbertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_edge_len(s : SignaltransformhilbertEdge) -> Int { s.size }

pub fn signal_transform_hilbert_edge_get(s : SignaltransformhilbertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_edge_set(s : SignaltransformhilbertEdge, i : Int, v : Double) -> SignaltransformhilbertEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_edge_sum(s : SignaltransformhilbertEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_edge_mean(s : SignaltransformhilbertEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_edge_scale(s : SignaltransformhilbertEdge, f : Double) -> SignaltransformhilbertEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_edge_add(a : SignaltransformhilbertEdge, b : SignaltransformhilbertEdge) -> SignaltransformhilbertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_edge_copy(s : SignaltransformhilbertEdge) -> SignaltransformhilbertEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_edge_fill(s : SignaltransformhilbertEdge, v : Double) -> SignaltransformhilbertEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_edge_min(s : SignaltransformhilbertEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_edge_max(s : SignaltransformhilbertEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_edge_to_string(s : SignaltransformhilbertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_path_make(size : Int) -> SignaltransformhilbertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_path_len(s : SignaltransformhilbertPath) -> Int { s.size }

pub fn signal_transform_hilbert_path_get(s : SignaltransformhilbertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_path_set(s : SignaltransformhilbertPath, i : Int, v : Double) -> SignaltransformhilbertPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_path_sum(s : SignaltransformhilbertPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_path_mean(s : SignaltransformhilbertPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_path_scale(s : SignaltransformhilbertPath, f : Double) -> SignaltransformhilbertPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_path_add(a : SignaltransformhilbertPath, b : SignaltransformhilbertPath) -> SignaltransformhilbertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_path_copy(s : SignaltransformhilbertPath) -> SignaltransformhilbertPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_path_fill(s : SignaltransformhilbertPath, v : Double) -> SignaltransformhilbertPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_path_min(s : SignaltransformhilbertPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_path_max(s : SignaltransformhilbertPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_path_to_string(s : SignaltransformhilbertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_cluster_make(size : Int) -> SignaltransformhilbertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_cluster_len(s : SignaltransformhilbertCluster) -> Int { s.size }

pub fn signal_transform_hilbert_cluster_get(s : SignaltransformhilbertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_cluster_set(s : SignaltransformhilbertCluster, i : Int, v : Double) -> SignaltransformhilbertCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cluster_sum(s : SignaltransformhilbertCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_cluster_mean(s : SignaltransformhilbertCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_cluster_scale(s : SignaltransformhilbertCluster, f : Double) -> SignaltransformhilbertCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cluster_add(a : SignaltransformhilbertCluster, b : SignaltransformhilbertCluster) -> SignaltransformhilbertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_cluster_copy(s : SignaltransformhilbertCluster) -> SignaltransformhilbertCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cluster_fill(s : SignaltransformhilbertCluster, v : Double) -> SignaltransformhilbertCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cluster_min(s : SignaltransformhilbertCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_cluster_max(s : SignaltransformhilbertCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_cluster_to_string(s : SignaltransformhilbertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_model_make(size : Int) -> SignaltransformhilbertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_model_len(s : SignaltransformhilbertModel) -> Int { s.size }

pub fn signal_transform_hilbert_model_get(s : SignaltransformhilbertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_model_set(s : SignaltransformhilbertModel, i : Int, v : Double) -> SignaltransformhilbertModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_model_sum(s : SignaltransformhilbertModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_model_mean(s : SignaltransformhilbertModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_model_scale(s : SignaltransformhilbertModel, f : Double) -> SignaltransformhilbertModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_model_add(a : SignaltransformhilbertModel, b : SignaltransformhilbertModel) -> SignaltransformhilbertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_model_copy(s : SignaltransformhilbertModel) -> SignaltransformhilbertModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_model_fill(s : SignaltransformhilbertModel, v : Double) -> SignaltransformhilbertModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_model_min(s : SignaltransformhilbertModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_model_max(s : SignaltransformhilbertModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_model_to_string(s : SignaltransformhilbertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_layer_make(size : Int) -> SignaltransformhilbertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_layer_len(s : SignaltransformhilbertLayer) -> Int { s.size }

pub fn signal_transform_hilbert_layer_get(s : SignaltransformhilbertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_layer_set(s : SignaltransformhilbertLayer, i : Int, v : Double) -> SignaltransformhilbertLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_layer_sum(s : SignaltransformhilbertLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_layer_mean(s : SignaltransformhilbertLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_layer_scale(s : SignaltransformhilbertLayer, f : Double) -> SignaltransformhilbertLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_layer_add(a : SignaltransformhilbertLayer, b : SignaltransformhilbertLayer) -> SignaltransformhilbertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_layer_copy(s : SignaltransformhilbertLayer) -> SignaltransformhilbertLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_layer_fill(s : SignaltransformhilbertLayer, v : Double) -> SignaltransformhilbertLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_layer_min(s : SignaltransformhilbertLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_layer_max(s : SignaltransformhilbertLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_layer_to_string(s : SignaltransformhilbertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_buffer_make(size : Int) -> SignaltransformhilbertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_buffer_len(s : SignaltransformhilbertBuffer) -> Int { s.size }

pub fn signal_transform_hilbert_buffer_get(s : SignaltransformhilbertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_buffer_set(s : SignaltransformhilbertBuffer, i : Int, v : Double) -> SignaltransformhilbertBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_buffer_sum(s : SignaltransformhilbertBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_buffer_mean(s : SignaltransformhilbertBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_buffer_scale(s : SignaltransformhilbertBuffer, f : Double) -> SignaltransformhilbertBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_buffer_add(a : SignaltransformhilbertBuffer, b : SignaltransformhilbertBuffer) -> SignaltransformhilbertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_buffer_copy(s : SignaltransformhilbertBuffer) -> SignaltransformhilbertBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_buffer_fill(s : SignaltransformhilbertBuffer, v : Double) -> SignaltransformhilbertBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_buffer_min(s : SignaltransformhilbertBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_buffer_max(s : SignaltransformhilbertBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_buffer_to_string(s : SignaltransformhilbertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_cursor_make(size : Int) -> SignaltransformhilbertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_cursor_len(s : SignaltransformhilbertCursor) -> Int { s.size }

pub fn signal_transform_hilbert_cursor_get(s : SignaltransformhilbertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_cursor_set(s : SignaltransformhilbertCursor, i : Int, v : Double) -> SignaltransformhilbertCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cursor_sum(s : SignaltransformhilbertCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_cursor_mean(s : SignaltransformhilbertCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_cursor_scale(s : SignaltransformhilbertCursor, f : Double) -> SignaltransformhilbertCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cursor_add(a : SignaltransformhilbertCursor, b : SignaltransformhilbertCursor) -> SignaltransformhilbertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_cursor_copy(s : SignaltransformhilbertCursor) -> SignaltransformhilbertCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cursor_fill(s : SignaltransformhilbertCursor, v : Double) -> SignaltransformhilbertCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_cursor_min(s : SignaltransformhilbertCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_cursor_max(s : SignaltransformhilbertCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_cursor_to_string(s : SignaltransformhilbertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_view_make(size : Int) -> SignaltransformhilbertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_view_len(s : SignaltransformhilbertView) -> Int { s.size }

pub fn signal_transform_hilbert_view_get(s : SignaltransformhilbertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_view_set(s : SignaltransformhilbertView, i : Int, v : Double) -> SignaltransformhilbertView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_view_sum(s : SignaltransformhilbertView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_view_mean(s : SignaltransformhilbertView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_view_scale(s : SignaltransformhilbertView, f : Double) -> SignaltransformhilbertView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_view_add(a : SignaltransformhilbertView, b : SignaltransformhilbertView) -> SignaltransformhilbertView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_view_copy(s : SignaltransformhilbertView) -> SignaltransformhilbertView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_view_fill(s : SignaltransformhilbertView, v : Double) -> SignaltransformhilbertView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_view_min(s : SignaltransformhilbertView) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_view_max(s : SignaltransformhilbertView) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_view_to_string(s : SignaltransformhilbertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_range_make(size : Int) -> SignaltransformhilbertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_range_len(s : SignaltransformhilbertRange) -> Int { s.size }

pub fn signal_transform_hilbert_range_get(s : SignaltransformhilbertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_range_set(s : SignaltransformhilbertRange, i : Int, v : Double) -> SignaltransformhilbertRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_range_sum(s : SignaltransformhilbertRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_range_mean(s : SignaltransformhilbertRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_range_scale(s : SignaltransformhilbertRange, f : Double) -> SignaltransformhilbertRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_range_add(a : SignaltransformhilbertRange, b : SignaltransformhilbertRange) -> SignaltransformhilbertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_range_copy(s : SignaltransformhilbertRange) -> SignaltransformhilbertRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_range_fill(s : SignaltransformhilbertRange, v : Double) -> SignaltransformhilbertRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_range_min(s : SignaltransformhilbertRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_range_max(s : SignaltransformhilbertRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_range_to_string(s : SignaltransformhilbertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformhilbertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_hilbert_slice_make(size : Int) -> SignaltransformhilbertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_hilbert_slice_len(s : SignaltransformhilbertSlice) -> Int { s.size }

pub fn signal_transform_hilbert_slice_get(s : SignaltransformhilbertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_hilbert_slice_set(s : SignaltransformhilbertSlice, i : Int, v : Double) -> SignaltransformhilbertSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_slice_sum(s : SignaltransformhilbertSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_hilbert_slice_mean(s : SignaltransformhilbertSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_hilbert_slice_scale(s : SignaltransformhilbertSlice, f : Double) -> SignaltransformhilbertSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_slice_add(a : SignaltransformhilbertSlice, b : SignaltransformhilbertSlice) -> SignaltransformhilbertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_hilbert_slice_copy(s : SignaltransformhilbertSlice) -> SignaltransformhilbertSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_slice_fill(s : SignaltransformhilbertSlice, v : Double) -> SignaltransformhilbertSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_hilbert_slice_min(s : SignaltransformhilbertSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_hilbert_slice_max(s : SignaltransformhilbertSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_hilbert_slice_to_string(s : SignaltransformhilbertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

