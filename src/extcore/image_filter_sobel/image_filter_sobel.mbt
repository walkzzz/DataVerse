///===
/// extcore/image_filter_sobel

pub(all) struct ImagefiltersobelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_sobel_make_point(x : Double, y : Double) -> ImagefiltersobelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_sobel_make_point3(x : Double, y : Double, z : Double) -> ImagefiltersobelPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltersobelPoint::x(self : ImagefiltersobelPoint) -> Double { self.x }

pub fn ImagefiltersobelPoint::y(self : ImagefiltersobelPoint) -> Double { self.y }

pub fn ImagefiltersobelPoint::z(self : ImagefiltersobelPoint) -> Double { self.z }

pub fn ImagefiltersobelPoint::label(self : ImagefiltersobelPoint) -> Int { self.label }

pub fn ImagefiltersobelPoint::dist(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltersobelPoint::add(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltersobelPoint::sub(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltersobelPoint::scale(self : ImagefiltersobelPoint, s : Double) -> ImagefiltersobelPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltersobelPoint::dot(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltersobelPoint::cross(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltersobelPoint::norm(self : ImagefiltersobelPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltersobelPoint::normalize(self : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltersobelPoint::negate(self : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltersobelPoint::mid(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltersobelPoint::lerp(self : ImagefiltersobelPoint, other : ImagefiltersobelPoint, t : Double) -> ImagefiltersobelPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltersobelPoint::to_string(self : ImagefiltersobelPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltersobelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_sobel_make_series(vals : Array[Double], name : String) -> ImagefiltersobelSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltersobelSeries::len(self : ImagefiltersobelSeries) -> Int { self.vals.length() }

pub fn ImagefiltersobelSeries::sum(self : ImagefiltersobelSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltersobelSeries::mean(self : ImagefiltersobelSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltersobelSeries::min(self : ImagefiltersobelSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltersobelSeries::max(self : ImagefiltersobelSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltersobelSeries::range(self : ImagefiltersobelSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltersobelSeries::variance(self : ImagefiltersobelSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltersobelSeries::std(self : ImagefiltersobelSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltersobelSeries::median(self : ImagefiltersobelSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltersobelSeries::scale(self : ImagefiltersobelSeries, f : Double) -> ImagefiltersobelSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltersobelSeries::add(self : ImagefiltersobelSeries, other : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltersobelSeries::sub(self : ImagefiltersobelSeries, other : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltersobelSeries::normalize(self : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltersobelSeries::cumsum(self : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltersobelSeries::to_string(self : ImagefiltersobelSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltersobelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_sobel_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltersobelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_sobel_matrix_identity(n : Int) -> ImagefiltersobelMatrix {
  let m = image_filter_sobel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltersobelMatrix::get(self : ImagefiltersobelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltersobelMatrix::transpose(self : ImagefiltersobelMatrix) -> ImagefiltersobelMatrix {
  let result = image_filter_sobel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltersobelMatrix::add(self : ImagefiltersobelMatrix, other : ImagefiltersobelMatrix) -> ImagefiltersobelMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_sobel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltersobelMatrix::scale(self : ImagefiltersobelMatrix, s : Double) -> ImagefiltersobelMatrix {
  let result = image_filter_sobel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltersobelMatrix::multiply(self : ImagefiltersobelMatrix, other : ImagefiltersobelMatrix) -> ImagefiltersobelMatrix {
  if self.cols != other.rows { return image_filter_sobel_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_sobel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefiltersobelMatrix::trace(self : ImagefiltersobelMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltersobelMatrix::det(self : ImagefiltersobelMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltersobelMatrix::norm(self : ImagefiltersobelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltersobelMatrix::to_string(self : ImagefiltersobelMatrix) -> String {
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

pub(all) struct ImagefiltersobelVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_sobel_make_vector(comps : Array[Double]) -> ImagefiltersobelVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_sobel_vector_zero(dim : Int) -> ImagefiltersobelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltersobelVector::add(self : ImagefiltersobelVector, other : ImagefiltersobelVector) -> ImagefiltersobelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltersobelVector::sub(self : ImagefiltersobelVector, other : ImagefiltersobelVector) -> ImagefiltersobelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltersobelVector::scale(self : ImagefiltersobelVector, s : Double) -> ImagefiltersobelVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltersobelVector::dot(self : ImagefiltersobelVector, other : ImagefiltersobelVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltersobelVector::norm(self : ImagefiltersobelVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltersobelVector::normalize(self : ImagefiltersobelVector) -> ImagefiltersobelVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltersobelVector::dist(self : ImagefiltersobelVector, other : ImagefiltersobelVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltersobelVector::to_string(self : ImagefiltersobelVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_sobel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_sobel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_sobel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_sobel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_sobel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_sobel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_sobel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_sobel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_sobel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_sobel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_sobel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_sobel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_sobel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_sobel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_sobel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_sobel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_sobel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_sobel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_sobel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_sobel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_sobel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_sobel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_sobel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_sobel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_sobel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_sobel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_sobel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_sobel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_sobel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltersobelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_frame_make(size : Int) -> ImagefiltersobelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_frame_len(s : ImagefiltersobelFrame) -> Int { s.size }

pub fn image_filter_sobel_frame_get(s : ImagefiltersobelFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_frame_set(s : ImagefiltersobelFrame, i : Int, v : Double) -> ImagefiltersobelFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_frame_sum(s : ImagefiltersobelFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_frame_mean(s : ImagefiltersobelFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_frame_scale(s : ImagefiltersobelFrame, f : Double) -> ImagefiltersobelFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_frame_add(a : ImagefiltersobelFrame, b : ImagefiltersobelFrame) -> ImagefiltersobelFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_frame_copy(s : ImagefiltersobelFrame) -> ImagefiltersobelFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_frame_fill(s : ImagefiltersobelFrame, v : Double) -> ImagefiltersobelFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_frame_min(s : ImagefiltersobelFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_frame_max(s : ImagefiltersobelFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_frame_to_string(s : ImagefiltersobelFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_table_make(size : Int) -> ImagefiltersobelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_table_len(s : ImagefiltersobelTable) -> Int { s.size }

pub fn image_filter_sobel_table_get(s : ImagefiltersobelTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_table_set(s : ImagefiltersobelTable, i : Int, v : Double) -> ImagefiltersobelTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_table_sum(s : ImagefiltersobelTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_table_mean(s : ImagefiltersobelTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_table_scale(s : ImagefiltersobelTable, f : Double) -> ImagefiltersobelTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_table_add(a : ImagefiltersobelTable, b : ImagefiltersobelTable) -> ImagefiltersobelTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_table_copy(s : ImagefiltersobelTable) -> ImagefiltersobelTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_table_fill(s : ImagefiltersobelTable, v : Double) -> ImagefiltersobelTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_table_min(s : ImagefiltersobelTable) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_table_max(s : ImagefiltersobelTable) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_table_to_string(s : ImagefiltersobelTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_graphn_make(size : Int) -> ImagefiltersobelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_graphn_len(s : ImagefiltersobelGraphN) -> Int { s.size }

pub fn image_filter_sobel_graphn_get(s : ImagefiltersobelGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_graphn_set(s : ImagefiltersobelGraphN, i : Int, v : Double) -> ImagefiltersobelGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_graphn_sum(s : ImagefiltersobelGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_graphn_mean(s : ImagefiltersobelGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_graphn_scale(s : ImagefiltersobelGraphN, f : Double) -> ImagefiltersobelGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_graphn_add(a : ImagefiltersobelGraphN, b : ImagefiltersobelGraphN) -> ImagefiltersobelGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_graphn_copy(s : ImagefiltersobelGraphN) -> ImagefiltersobelGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_graphn_fill(s : ImagefiltersobelGraphN, v : Double) -> ImagefiltersobelGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_graphn_min(s : ImagefiltersobelGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_graphn_max(s : ImagefiltersobelGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_graphn_to_string(s : ImagefiltersobelGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_node_make(size : Int) -> ImagefiltersobelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_node_len(s : ImagefiltersobelNode) -> Int { s.size }

pub fn image_filter_sobel_node_get(s : ImagefiltersobelNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_node_set(s : ImagefiltersobelNode, i : Int, v : Double) -> ImagefiltersobelNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_node_sum(s : ImagefiltersobelNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_node_mean(s : ImagefiltersobelNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_node_scale(s : ImagefiltersobelNode, f : Double) -> ImagefiltersobelNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_node_add(a : ImagefiltersobelNode, b : ImagefiltersobelNode) -> ImagefiltersobelNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_node_copy(s : ImagefiltersobelNode) -> ImagefiltersobelNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_node_fill(s : ImagefiltersobelNode, v : Double) -> ImagefiltersobelNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_node_min(s : ImagefiltersobelNode) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_node_max(s : ImagefiltersobelNode) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_node_to_string(s : ImagefiltersobelNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_edge_make(size : Int) -> ImagefiltersobelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_edge_len(s : ImagefiltersobelEdge) -> Int { s.size }

pub fn image_filter_sobel_edge_get(s : ImagefiltersobelEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_edge_set(s : ImagefiltersobelEdge, i : Int, v : Double) -> ImagefiltersobelEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_edge_sum(s : ImagefiltersobelEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_edge_mean(s : ImagefiltersobelEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_edge_scale(s : ImagefiltersobelEdge, f : Double) -> ImagefiltersobelEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_edge_add(a : ImagefiltersobelEdge, b : ImagefiltersobelEdge) -> ImagefiltersobelEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_edge_copy(s : ImagefiltersobelEdge) -> ImagefiltersobelEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_edge_fill(s : ImagefiltersobelEdge, v : Double) -> ImagefiltersobelEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_edge_min(s : ImagefiltersobelEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_edge_max(s : ImagefiltersobelEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_edge_to_string(s : ImagefiltersobelEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_path_make(size : Int) -> ImagefiltersobelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_path_len(s : ImagefiltersobelPath) -> Int { s.size }

pub fn image_filter_sobel_path_get(s : ImagefiltersobelPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_path_set(s : ImagefiltersobelPath, i : Int, v : Double) -> ImagefiltersobelPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_path_sum(s : ImagefiltersobelPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_path_mean(s : ImagefiltersobelPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_path_scale(s : ImagefiltersobelPath, f : Double) -> ImagefiltersobelPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_path_add(a : ImagefiltersobelPath, b : ImagefiltersobelPath) -> ImagefiltersobelPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_path_copy(s : ImagefiltersobelPath) -> ImagefiltersobelPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_path_fill(s : ImagefiltersobelPath, v : Double) -> ImagefiltersobelPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_path_min(s : ImagefiltersobelPath) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_path_max(s : ImagefiltersobelPath) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_path_to_string(s : ImagefiltersobelPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_cluster_make(size : Int) -> ImagefiltersobelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_cluster_len(s : ImagefiltersobelCluster) -> Int { s.size }

pub fn image_filter_sobel_cluster_get(s : ImagefiltersobelCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_cluster_set(s : ImagefiltersobelCluster, i : Int, v : Double) -> ImagefiltersobelCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cluster_sum(s : ImagefiltersobelCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_cluster_mean(s : ImagefiltersobelCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_cluster_scale(s : ImagefiltersobelCluster, f : Double) -> ImagefiltersobelCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cluster_add(a : ImagefiltersobelCluster, b : ImagefiltersobelCluster) -> ImagefiltersobelCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_cluster_copy(s : ImagefiltersobelCluster) -> ImagefiltersobelCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cluster_fill(s : ImagefiltersobelCluster, v : Double) -> ImagefiltersobelCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cluster_min(s : ImagefiltersobelCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_cluster_max(s : ImagefiltersobelCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_cluster_to_string(s : ImagefiltersobelCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_model_make(size : Int) -> ImagefiltersobelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_model_len(s : ImagefiltersobelModel) -> Int { s.size }

pub fn image_filter_sobel_model_get(s : ImagefiltersobelModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_model_set(s : ImagefiltersobelModel, i : Int, v : Double) -> ImagefiltersobelModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_model_sum(s : ImagefiltersobelModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_model_mean(s : ImagefiltersobelModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_model_scale(s : ImagefiltersobelModel, f : Double) -> ImagefiltersobelModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_model_add(a : ImagefiltersobelModel, b : ImagefiltersobelModel) -> ImagefiltersobelModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_model_copy(s : ImagefiltersobelModel) -> ImagefiltersobelModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_model_fill(s : ImagefiltersobelModel, v : Double) -> ImagefiltersobelModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_model_min(s : ImagefiltersobelModel) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_model_max(s : ImagefiltersobelModel) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_model_to_string(s : ImagefiltersobelModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_layer_make(size : Int) -> ImagefiltersobelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_layer_len(s : ImagefiltersobelLayer) -> Int { s.size }

pub fn image_filter_sobel_layer_get(s : ImagefiltersobelLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_layer_set(s : ImagefiltersobelLayer, i : Int, v : Double) -> ImagefiltersobelLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_layer_sum(s : ImagefiltersobelLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_layer_mean(s : ImagefiltersobelLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_layer_scale(s : ImagefiltersobelLayer, f : Double) -> ImagefiltersobelLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_layer_add(a : ImagefiltersobelLayer, b : ImagefiltersobelLayer) -> ImagefiltersobelLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_layer_copy(s : ImagefiltersobelLayer) -> ImagefiltersobelLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_layer_fill(s : ImagefiltersobelLayer, v : Double) -> ImagefiltersobelLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_layer_min(s : ImagefiltersobelLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_layer_max(s : ImagefiltersobelLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_layer_to_string(s : ImagefiltersobelLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_buffer_make(size : Int) -> ImagefiltersobelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_buffer_len(s : ImagefiltersobelBuffer) -> Int { s.size }

pub fn image_filter_sobel_buffer_get(s : ImagefiltersobelBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_buffer_set(s : ImagefiltersobelBuffer, i : Int, v : Double) -> ImagefiltersobelBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_buffer_sum(s : ImagefiltersobelBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_buffer_mean(s : ImagefiltersobelBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_buffer_scale(s : ImagefiltersobelBuffer, f : Double) -> ImagefiltersobelBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_buffer_add(a : ImagefiltersobelBuffer, b : ImagefiltersobelBuffer) -> ImagefiltersobelBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_buffer_copy(s : ImagefiltersobelBuffer) -> ImagefiltersobelBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_buffer_fill(s : ImagefiltersobelBuffer, v : Double) -> ImagefiltersobelBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_buffer_min(s : ImagefiltersobelBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_buffer_max(s : ImagefiltersobelBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_buffer_to_string(s : ImagefiltersobelBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_cursor_make(size : Int) -> ImagefiltersobelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_cursor_len(s : ImagefiltersobelCursor) -> Int { s.size }

pub fn image_filter_sobel_cursor_get(s : ImagefiltersobelCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_cursor_set(s : ImagefiltersobelCursor, i : Int, v : Double) -> ImagefiltersobelCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cursor_sum(s : ImagefiltersobelCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_cursor_mean(s : ImagefiltersobelCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_cursor_scale(s : ImagefiltersobelCursor, f : Double) -> ImagefiltersobelCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cursor_add(a : ImagefiltersobelCursor, b : ImagefiltersobelCursor) -> ImagefiltersobelCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_cursor_copy(s : ImagefiltersobelCursor) -> ImagefiltersobelCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cursor_fill(s : ImagefiltersobelCursor, v : Double) -> ImagefiltersobelCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_cursor_min(s : ImagefiltersobelCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_cursor_max(s : ImagefiltersobelCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_cursor_to_string(s : ImagefiltersobelCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_view_make(size : Int) -> ImagefiltersobelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_view_len(s : ImagefiltersobelView) -> Int { s.size }

pub fn image_filter_sobel_view_get(s : ImagefiltersobelView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_view_set(s : ImagefiltersobelView, i : Int, v : Double) -> ImagefiltersobelView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_view_sum(s : ImagefiltersobelView) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_view_mean(s : ImagefiltersobelView) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_view_scale(s : ImagefiltersobelView, f : Double) -> ImagefiltersobelView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_view_add(a : ImagefiltersobelView, b : ImagefiltersobelView) -> ImagefiltersobelView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_view_copy(s : ImagefiltersobelView) -> ImagefiltersobelView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_view_fill(s : ImagefiltersobelView, v : Double) -> ImagefiltersobelView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_view_min(s : ImagefiltersobelView) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_view_max(s : ImagefiltersobelView) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_view_to_string(s : ImagefiltersobelView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_range_make(size : Int) -> ImagefiltersobelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_range_len(s : ImagefiltersobelRange) -> Int { s.size }

pub fn image_filter_sobel_range_get(s : ImagefiltersobelRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_range_set(s : ImagefiltersobelRange, i : Int, v : Double) -> ImagefiltersobelRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_range_sum(s : ImagefiltersobelRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_range_mean(s : ImagefiltersobelRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_range_scale(s : ImagefiltersobelRange, f : Double) -> ImagefiltersobelRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_range_add(a : ImagefiltersobelRange, b : ImagefiltersobelRange) -> ImagefiltersobelRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_range_copy(s : ImagefiltersobelRange) -> ImagefiltersobelRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_range_fill(s : ImagefiltersobelRange, v : Double) -> ImagefiltersobelRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_range_min(s : ImagefiltersobelRange) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_range_max(s : ImagefiltersobelRange) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_range_to_string(s : ImagefiltersobelRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_slice_make(size : Int) -> ImagefiltersobelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_slice_len(s : ImagefiltersobelSlice) -> Int { s.size }

pub fn image_filter_sobel_slice_get(s : ImagefiltersobelSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_slice_set(s : ImagefiltersobelSlice, i : Int, v : Double) -> ImagefiltersobelSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_slice_sum(s : ImagefiltersobelSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_sobel_slice_mean(s : ImagefiltersobelSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_sobel_slice_scale(s : ImagefiltersobelSlice, f : Double) -> ImagefiltersobelSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_slice_add(a : ImagefiltersobelSlice, b : ImagefiltersobelSlice) -> ImagefiltersobelSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_sobel_slice_copy(s : ImagefiltersobelSlice) -> ImagefiltersobelSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_slice_fill(s : ImagefiltersobelSlice, v : Double) -> ImagefiltersobelSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_sobel_slice_min(s : ImagefiltersobelSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_sobel_slice_max(s : ImagefiltersobelSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_sobel_slice_to_string(s : ImagefiltersobelSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

