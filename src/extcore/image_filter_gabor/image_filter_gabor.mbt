///===
/// extcore/image_filter_gabor

pub(all) struct ImagefiltergaborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_gabor_make_point(x : Double, y : Double) -> ImagefiltergaborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_gabor_make_point3(x : Double, y : Double, z : Double) -> ImagefiltergaborPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltergaborPoint::x(self : ImagefiltergaborPoint) -> Double { self.x }

pub fn ImagefiltergaborPoint::y(self : ImagefiltergaborPoint) -> Double { self.y }

pub fn ImagefiltergaborPoint::z(self : ImagefiltergaborPoint) -> Double { self.z }

pub fn ImagefiltergaborPoint::label(self : ImagefiltergaborPoint) -> Int { self.label }

pub fn ImagefiltergaborPoint::dist(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltergaborPoint::add(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltergaborPoint::sub(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltergaborPoint::scale(self : ImagefiltergaborPoint, s : Double) -> ImagefiltergaborPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltergaborPoint::dot(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltergaborPoint::cross(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltergaborPoint::norm(self : ImagefiltergaborPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltergaborPoint::normalize(self : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltergaborPoint::negate(self : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltergaborPoint::mid(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltergaborPoint::lerp(self : ImagefiltergaborPoint, other : ImagefiltergaborPoint, t : Double) -> ImagefiltergaborPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltergaborPoint::to_string(self : ImagefiltergaborPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltergaborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_gabor_make_series(vals : Array[Double], name : String) -> ImagefiltergaborSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltergaborSeries::len(self : ImagefiltergaborSeries) -> Int { self.vals.length() }

pub fn ImagefiltergaborSeries::sum(self : ImagefiltergaborSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltergaborSeries::mean(self : ImagefiltergaborSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltergaborSeries::min(self : ImagefiltergaborSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltergaborSeries::max(self : ImagefiltergaborSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltergaborSeries::range(self : ImagefiltergaborSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltergaborSeries::variance(self : ImagefiltergaborSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltergaborSeries::std(self : ImagefiltergaborSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltergaborSeries::median(self : ImagefiltergaborSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltergaborSeries::scale(self : ImagefiltergaborSeries, f : Double) -> ImagefiltergaborSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltergaborSeries::add(self : ImagefiltergaborSeries, other : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltergaborSeries::sub(self : ImagefiltergaborSeries, other : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltergaborSeries::normalize(self : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltergaborSeries::cumsum(self : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltergaborSeries::to_string(self : ImagefiltergaborSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltergaborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_gabor_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltergaborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_gabor_matrix_identity(n : Int) -> ImagefiltergaborMatrix {
  let m = image_filter_gabor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltergaborMatrix::get(self : ImagefiltergaborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltergaborMatrix::transpose(self : ImagefiltergaborMatrix) -> ImagefiltergaborMatrix {
  let result = image_filter_gabor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltergaborMatrix::add(self : ImagefiltergaborMatrix, other : ImagefiltergaborMatrix) -> ImagefiltergaborMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltergaborMatrix::scale(self : ImagefiltergaborMatrix, s : Double) -> ImagefiltergaborMatrix {
  let result = image_filter_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltergaborMatrix::multiply(self : ImagefiltergaborMatrix, other : ImagefiltergaborMatrix) -> ImagefiltergaborMatrix {
  if self.cols != other.rows { return image_filter_gabor_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_gabor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefiltergaborMatrix::trace(self : ImagefiltergaborMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltergaborMatrix::det(self : ImagefiltergaborMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltergaborMatrix::norm(self : ImagefiltergaborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltergaborMatrix::to_string(self : ImagefiltergaborMatrix) -> String {
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

pub(all) struct ImagefiltergaborVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_gabor_make_vector(comps : Array[Double]) -> ImagefiltergaborVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_gabor_vector_zero(dim : Int) -> ImagefiltergaborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltergaborVector::add(self : ImagefiltergaborVector, other : ImagefiltergaborVector) -> ImagefiltergaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltergaborVector::sub(self : ImagefiltergaborVector, other : ImagefiltergaborVector) -> ImagefiltergaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltergaborVector::scale(self : ImagefiltergaborVector, s : Double) -> ImagefiltergaborVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltergaborVector::dot(self : ImagefiltergaborVector, other : ImagefiltergaborVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltergaborVector::norm(self : ImagefiltergaborVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltergaborVector::normalize(self : ImagefiltergaborVector) -> ImagefiltergaborVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltergaborVector::dist(self : ImagefiltergaborVector, other : ImagefiltergaborVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltergaborVector::to_string(self : ImagefiltergaborVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_gabor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_gabor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_gabor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_gabor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_gabor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_gabor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_gabor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_gabor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_gabor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_gabor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_gabor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_gabor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_gabor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_gabor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_gabor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_gabor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_gabor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_gabor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_gabor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_gabor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_gabor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_gabor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_gabor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_gabor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_gabor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_gabor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_gabor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_gabor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_gabor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltergaborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_frame_make(size : Int) -> ImagefiltergaborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_frame_len(s : ImagefiltergaborFrame) -> Int { s.size }

pub fn image_filter_gabor_frame_get(s : ImagefiltergaborFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_frame_set(s : ImagefiltergaborFrame, i : Int, v : Double) -> ImagefiltergaborFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_frame_sum(s : ImagefiltergaborFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_frame_mean(s : ImagefiltergaborFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_frame_scale(s : ImagefiltergaborFrame, f : Double) -> ImagefiltergaborFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_frame_add(a : ImagefiltergaborFrame, b : ImagefiltergaborFrame) -> ImagefiltergaborFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_frame_copy(s : ImagefiltergaborFrame) -> ImagefiltergaborFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_frame_fill(s : ImagefiltergaborFrame, v : Double) -> ImagefiltergaborFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_frame_min(s : ImagefiltergaborFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_frame_max(s : ImagefiltergaborFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_frame_to_string(s : ImagefiltergaborFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_table_make(size : Int) -> ImagefiltergaborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_table_len(s : ImagefiltergaborTable) -> Int { s.size }

pub fn image_filter_gabor_table_get(s : ImagefiltergaborTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_table_set(s : ImagefiltergaborTable, i : Int, v : Double) -> ImagefiltergaborTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_table_sum(s : ImagefiltergaborTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_table_mean(s : ImagefiltergaborTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_table_scale(s : ImagefiltergaborTable, f : Double) -> ImagefiltergaborTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_table_add(a : ImagefiltergaborTable, b : ImagefiltergaborTable) -> ImagefiltergaborTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_table_copy(s : ImagefiltergaborTable) -> ImagefiltergaborTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_table_fill(s : ImagefiltergaborTable, v : Double) -> ImagefiltergaborTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_table_min(s : ImagefiltergaborTable) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_table_max(s : ImagefiltergaborTable) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_table_to_string(s : ImagefiltergaborTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_graphn_make(size : Int) -> ImagefiltergaborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_graphn_len(s : ImagefiltergaborGraphN) -> Int { s.size }

pub fn image_filter_gabor_graphn_get(s : ImagefiltergaborGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_graphn_set(s : ImagefiltergaborGraphN, i : Int, v : Double) -> ImagefiltergaborGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_graphn_sum(s : ImagefiltergaborGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_graphn_mean(s : ImagefiltergaborGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_graphn_scale(s : ImagefiltergaborGraphN, f : Double) -> ImagefiltergaborGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_graphn_add(a : ImagefiltergaborGraphN, b : ImagefiltergaborGraphN) -> ImagefiltergaborGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_graphn_copy(s : ImagefiltergaborGraphN) -> ImagefiltergaborGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_graphn_fill(s : ImagefiltergaborGraphN, v : Double) -> ImagefiltergaborGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_graphn_min(s : ImagefiltergaborGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_graphn_max(s : ImagefiltergaborGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_graphn_to_string(s : ImagefiltergaborGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_node_make(size : Int) -> ImagefiltergaborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_node_len(s : ImagefiltergaborNode) -> Int { s.size }

pub fn image_filter_gabor_node_get(s : ImagefiltergaborNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_node_set(s : ImagefiltergaborNode, i : Int, v : Double) -> ImagefiltergaborNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_node_sum(s : ImagefiltergaborNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_node_mean(s : ImagefiltergaborNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_node_scale(s : ImagefiltergaborNode, f : Double) -> ImagefiltergaborNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_node_add(a : ImagefiltergaborNode, b : ImagefiltergaborNode) -> ImagefiltergaborNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_node_copy(s : ImagefiltergaborNode) -> ImagefiltergaborNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_node_fill(s : ImagefiltergaborNode, v : Double) -> ImagefiltergaborNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_node_min(s : ImagefiltergaborNode) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_node_max(s : ImagefiltergaborNode) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_node_to_string(s : ImagefiltergaborNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_edge_make(size : Int) -> ImagefiltergaborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_edge_len(s : ImagefiltergaborEdge) -> Int { s.size }

pub fn image_filter_gabor_edge_get(s : ImagefiltergaborEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_edge_set(s : ImagefiltergaborEdge, i : Int, v : Double) -> ImagefiltergaborEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_edge_sum(s : ImagefiltergaborEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_edge_mean(s : ImagefiltergaborEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_edge_scale(s : ImagefiltergaborEdge, f : Double) -> ImagefiltergaborEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_edge_add(a : ImagefiltergaborEdge, b : ImagefiltergaborEdge) -> ImagefiltergaborEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_edge_copy(s : ImagefiltergaborEdge) -> ImagefiltergaborEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_edge_fill(s : ImagefiltergaborEdge, v : Double) -> ImagefiltergaborEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_edge_min(s : ImagefiltergaborEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_edge_max(s : ImagefiltergaborEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_edge_to_string(s : ImagefiltergaborEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_path_make(size : Int) -> ImagefiltergaborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_path_len(s : ImagefiltergaborPath) -> Int { s.size }

pub fn image_filter_gabor_path_get(s : ImagefiltergaborPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_path_set(s : ImagefiltergaborPath, i : Int, v : Double) -> ImagefiltergaborPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_path_sum(s : ImagefiltergaborPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_path_mean(s : ImagefiltergaborPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_path_scale(s : ImagefiltergaborPath, f : Double) -> ImagefiltergaborPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_path_add(a : ImagefiltergaborPath, b : ImagefiltergaborPath) -> ImagefiltergaborPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_path_copy(s : ImagefiltergaborPath) -> ImagefiltergaborPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_path_fill(s : ImagefiltergaborPath, v : Double) -> ImagefiltergaborPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_path_min(s : ImagefiltergaborPath) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_path_max(s : ImagefiltergaborPath) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_path_to_string(s : ImagefiltergaborPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_cluster_make(size : Int) -> ImagefiltergaborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_cluster_len(s : ImagefiltergaborCluster) -> Int { s.size }

pub fn image_filter_gabor_cluster_get(s : ImagefiltergaborCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_cluster_set(s : ImagefiltergaborCluster, i : Int, v : Double) -> ImagefiltergaborCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cluster_sum(s : ImagefiltergaborCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_cluster_mean(s : ImagefiltergaborCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_cluster_scale(s : ImagefiltergaborCluster, f : Double) -> ImagefiltergaborCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cluster_add(a : ImagefiltergaborCluster, b : ImagefiltergaborCluster) -> ImagefiltergaborCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_cluster_copy(s : ImagefiltergaborCluster) -> ImagefiltergaborCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cluster_fill(s : ImagefiltergaborCluster, v : Double) -> ImagefiltergaborCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cluster_min(s : ImagefiltergaborCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_cluster_max(s : ImagefiltergaborCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_cluster_to_string(s : ImagefiltergaborCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_model_make(size : Int) -> ImagefiltergaborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_model_len(s : ImagefiltergaborModel) -> Int { s.size }

pub fn image_filter_gabor_model_get(s : ImagefiltergaborModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_model_set(s : ImagefiltergaborModel, i : Int, v : Double) -> ImagefiltergaborModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_model_sum(s : ImagefiltergaborModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_model_mean(s : ImagefiltergaborModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_model_scale(s : ImagefiltergaborModel, f : Double) -> ImagefiltergaborModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_model_add(a : ImagefiltergaborModel, b : ImagefiltergaborModel) -> ImagefiltergaborModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_model_copy(s : ImagefiltergaborModel) -> ImagefiltergaborModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_model_fill(s : ImagefiltergaborModel, v : Double) -> ImagefiltergaborModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_model_min(s : ImagefiltergaborModel) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_model_max(s : ImagefiltergaborModel) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_model_to_string(s : ImagefiltergaborModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_layer_make(size : Int) -> ImagefiltergaborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_layer_len(s : ImagefiltergaborLayer) -> Int { s.size }

pub fn image_filter_gabor_layer_get(s : ImagefiltergaborLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_layer_set(s : ImagefiltergaborLayer, i : Int, v : Double) -> ImagefiltergaborLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_layer_sum(s : ImagefiltergaborLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_layer_mean(s : ImagefiltergaborLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_layer_scale(s : ImagefiltergaborLayer, f : Double) -> ImagefiltergaborLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_layer_add(a : ImagefiltergaborLayer, b : ImagefiltergaborLayer) -> ImagefiltergaborLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_layer_copy(s : ImagefiltergaborLayer) -> ImagefiltergaborLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_layer_fill(s : ImagefiltergaborLayer, v : Double) -> ImagefiltergaborLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_layer_min(s : ImagefiltergaborLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_layer_max(s : ImagefiltergaborLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_layer_to_string(s : ImagefiltergaborLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_buffer_make(size : Int) -> ImagefiltergaborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_buffer_len(s : ImagefiltergaborBuffer) -> Int { s.size }

pub fn image_filter_gabor_buffer_get(s : ImagefiltergaborBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_buffer_set(s : ImagefiltergaborBuffer, i : Int, v : Double) -> ImagefiltergaborBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_buffer_sum(s : ImagefiltergaborBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_buffer_mean(s : ImagefiltergaborBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_buffer_scale(s : ImagefiltergaborBuffer, f : Double) -> ImagefiltergaborBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_buffer_add(a : ImagefiltergaborBuffer, b : ImagefiltergaborBuffer) -> ImagefiltergaborBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_buffer_copy(s : ImagefiltergaborBuffer) -> ImagefiltergaborBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_buffer_fill(s : ImagefiltergaborBuffer, v : Double) -> ImagefiltergaborBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_buffer_min(s : ImagefiltergaborBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_buffer_max(s : ImagefiltergaborBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_buffer_to_string(s : ImagefiltergaborBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_cursor_make(size : Int) -> ImagefiltergaborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_cursor_len(s : ImagefiltergaborCursor) -> Int { s.size }

pub fn image_filter_gabor_cursor_get(s : ImagefiltergaborCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_cursor_set(s : ImagefiltergaborCursor, i : Int, v : Double) -> ImagefiltergaborCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cursor_sum(s : ImagefiltergaborCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_cursor_mean(s : ImagefiltergaborCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_cursor_scale(s : ImagefiltergaborCursor, f : Double) -> ImagefiltergaborCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cursor_add(a : ImagefiltergaborCursor, b : ImagefiltergaborCursor) -> ImagefiltergaborCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_cursor_copy(s : ImagefiltergaborCursor) -> ImagefiltergaborCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cursor_fill(s : ImagefiltergaborCursor, v : Double) -> ImagefiltergaborCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_cursor_min(s : ImagefiltergaborCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_cursor_max(s : ImagefiltergaborCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_cursor_to_string(s : ImagefiltergaborCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_view_make(size : Int) -> ImagefiltergaborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_view_len(s : ImagefiltergaborView) -> Int { s.size }

pub fn image_filter_gabor_view_get(s : ImagefiltergaborView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_view_set(s : ImagefiltergaborView, i : Int, v : Double) -> ImagefiltergaborView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_view_sum(s : ImagefiltergaborView) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_view_mean(s : ImagefiltergaborView) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_view_scale(s : ImagefiltergaborView, f : Double) -> ImagefiltergaborView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_view_add(a : ImagefiltergaborView, b : ImagefiltergaborView) -> ImagefiltergaborView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_view_copy(s : ImagefiltergaborView) -> ImagefiltergaborView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_view_fill(s : ImagefiltergaborView, v : Double) -> ImagefiltergaborView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_view_min(s : ImagefiltergaborView) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_view_max(s : ImagefiltergaborView) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_view_to_string(s : ImagefiltergaborView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_range_make(size : Int) -> ImagefiltergaborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_range_len(s : ImagefiltergaborRange) -> Int { s.size }

pub fn image_filter_gabor_range_get(s : ImagefiltergaborRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_range_set(s : ImagefiltergaborRange, i : Int, v : Double) -> ImagefiltergaborRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_range_sum(s : ImagefiltergaborRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_range_mean(s : ImagefiltergaborRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_range_scale(s : ImagefiltergaborRange, f : Double) -> ImagefiltergaborRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_range_add(a : ImagefiltergaborRange, b : ImagefiltergaborRange) -> ImagefiltergaborRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_range_copy(s : ImagefiltergaborRange) -> ImagefiltergaborRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_range_fill(s : ImagefiltergaborRange, v : Double) -> ImagefiltergaborRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_range_min(s : ImagefiltergaborRange) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_range_max(s : ImagefiltergaborRange) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_range_to_string(s : ImagefiltergaborRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_slice_make(size : Int) -> ImagefiltergaborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_slice_len(s : ImagefiltergaborSlice) -> Int { s.size }

pub fn image_filter_gabor_slice_get(s : ImagefiltergaborSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_slice_set(s : ImagefiltergaborSlice, i : Int, v : Double) -> ImagefiltergaborSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_slice_sum(s : ImagefiltergaborSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_gabor_slice_mean(s : ImagefiltergaborSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_gabor_slice_scale(s : ImagefiltergaborSlice, f : Double) -> ImagefiltergaborSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_slice_add(a : ImagefiltergaborSlice, b : ImagefiltergaborSlice) -> ImagefiltergaborSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_gabor_slice_copy(s : ImagefiltergaborSlice) -> ImagefiltergaborSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_slice_fill(s : ImagefiltergaborSlice, v : Double) -> ImagefiltergaborSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_gabor_slice_min(s : ImagefiltergaborSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_gabor_slice_max(s : ImagefiltergaborSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_gabor_slice_to_string(s : ImagefiltergaborSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

