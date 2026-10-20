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

pub fn ImagefiltersobelFrame::len(self : ImagefiltersobelFrame) -> Int { self.size }

pub fn ImagefiltersobelFrame::get(self : ImagefiltersobelFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelFrame::set(self : ImagefiltersobelFrame, i : Int, v : Double) -> ImagefiltersobelFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelFrame::sum(self : ImagefiltersobelFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelFrame::mean(self : ImagefiltersobelFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelFrame::scale(self : ImagefiltersobelFrame, f : Double) -> ImagefiltersobelFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelFrame::add(self : ImagefiltersobelFrame, other : ImagefiltersobelFrame) -> ImagefiltersobelFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelFrame::copy(self : ImagefiltersobelFrame) -> ImagefiltersobelFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelFrame::fill(self : ImagefiltersobelFrame, v : Double) -> ImagefiltersobelFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelFrame::min(self : ImagefiltersobelFrame) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelFrame::max(self : ImagefiltersobelFrame) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelFrame::to_string(self : ImagefiltersobelFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_table_make(size : Int) -> ImagefiltersobelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelTable::len(self : ImagefiltersobelTable) -> Int { self.size }

pub fn ImagefiltersobelTable::get(self : ImagefiltersobelTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelTable::set(self : ImagefiltersobelTable, i : Int, v : Double) -> ImagefiltersobelTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelTable::sum(self : ImagefiltersobelTable) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelTable::mean(self : ImagefiltersobelTable) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelTable::scale(self : ImagefiltersobelTable, f : Double) -> ImagefiltersobelTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelTable::add(self : ImagefiltersobelTable, other : ImagefiltersobelTable) -> ImagefiltersobelTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelTable::copy(self : ImagefiltersobelTable) -> ImagefiltersobelTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelTable::fill(self : ImagefiltersobelTable, v : Double) -> ImagefiltersobelTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelTable::min(self : ImagefiltersobelTable) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelTable::max(self : ImagefiltersobelTable) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelTable::to_string(self : ImagefiltersobelTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_graphn_make(size : Int) -> ImagefiltersobelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelGraphN::len(self : ImagefiltersobelGraphN) -> Int { self.size }

pub fn ImagefiltersobelGraphN::get(self : ImagefiltersobelGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelGraphN::set(self : ImagefiltersobelGraphN, i : Int, v : Double) -> ImagefiltersobelGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelGraphN::sum(self : ImagefiltersobelGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelGraphN::mean(self : ImagefiltersobelGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelGraphN::scale(self : ImagefiltersobelGraphN, f : Double) -> ImagefiltersobelGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelGraphN::add(self : ImagefiltersobelGraphN, other : ImagefiltersobelGraphN) -> ImagefiltersobelGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelGraphN::copy(self : ImagefiltersobelGraphN) -> ImagefiltersobelGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelGraphN::fill(self : ImagefiltersobelGraphN, v : Double) -> ImagefiltersobelGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelGraphN::min(self : ImagefiltersobelGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelGraphN::max(self : ImagefiltersobelGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelGraphN::to_string(self : ImagefiltersobelGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_node_make(size : Int) -> ImagefiltersobelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelNode::len(self : ImagefiltersobelNode) -> Int { self.size }

pub fn ImagefiltersobelNode::get(self : ImagefiltersobelNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelNode::set(self : ImagefiltersobelNode, i : Int, v : Double) -> ImagefiltersobelNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelNode::sum(self : ImagefiltersobelNode) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelNode::mean(self : ImagefiltersobelNode) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelNode::scale(self : ImagefiltersobelNode, f : Double) -> ImagefiltersobelNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelNode::add(self : ImagefiltersobelNode, other : ImagefiltersobelNode) -> ImagefiltersobelNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelNode::copy(self : ImagefiltersobelNode) -> ImagefiltersobelNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelNode::fill(self : ImagefiltersobelNode, v : Double) -> ImagefiltersobelNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelNode::min(self : ImagefiltersobelNode) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelNode::max(self : ImagefiltersobelNode) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelNode::to_string(self : ImagefiltersobelNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_edge_make(size : Int) -> ImagefiltersobelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelEdge::len(self : ImagefiltersobelEdge) -> Int { self.size }

pub fn ImagefiltersobelEdge::get(self : ImagefiltersobelEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelEdge::set(self : ImagefiltersobelEdge, i : Int, v : Double) -> ImagefiltersobelEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelEdge::sum(self : ImagefiltersobelEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelEdge::mean(self : ImagefiltersobelEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelEdge::scale(self : ImagefiltersobelEdge, f : Double) -> ImagefiltersobelEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelEdge::add(self : ImagefiltersobelEdge, other : ImagefiltersobelEdge) -> ImagefiltersobelEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelEdge::copy(self : ImagefiltersobelEdge) -> ImagefiltersobelEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelEdge::fill(self : ImagefiltersobelEdge, v : Double) -> ImagefiltersobelEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelEdge::min(self : ImagefiltersobelEdge) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelEdge::max(self : ImagefiltersobelEdge) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelEdge::to_string(self : ImagefiltersobelEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_path_make(size : Int) -> ImagefiltersobelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelPath::len(self : ImagefiltersobelPath) -> Int { self.size }

pub fn ImagefiltersobelPath::get(self : ImagefiltersobelPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelPath::set(self : ImagefiltersobelPath, i : Int, v : Double) -> ImagefiltersobelPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelPath::sum(self : ImagefiltersobelPath) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelPath::mean(self : ImagefiltersobelPath) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelPath::scale(self : ImagefiltersobelPath, f : Double) -> ImagefiltersobelPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelPath::add(self : ImagefiltersobelPath, other : ImagefiltersobelPath) -> ImagefiltersobelPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelPath::copy(self : ImagefiltersobelPath) -> ImagefiltersobelPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelPath::fill(self : ImagefiltersobelPath, v : Double) -> ImagefiltersobelPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelPath::min(self : ImagefiltersobelPath) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelPath::max(self : ImagefiltersobelPath) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelPath::to_string(self : ImagefiltersobelPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_cluster_make(size : Int) -> ImagefiltersobelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelCluster::len(self : ImagefiltersobelCluster) -> Int { self.size }

pub fn ImagefiltersobelCluster::get(self : ImagefiltersobelCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelCluster::set(self : ImagefiltersobelCluster, i : Int, v : Double) -> ImagefiltersobelCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCluster::sum(self : ImagefiltersobelCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelCluster::mean(self : ImagefiltersobelCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelCluster::scale(self : ImagefiltersobelCluster, f : Double) -> ImagefiltersobelCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCluster::add(self : ImagefiltersobelCluster, other : ImagefiltersobelCluster) -> ImagefiltersobelCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelCluster::copy(self : ImagefiltersobelCluster) -> ImagefiltersobelCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCluster::fill(self : ImagefiltersobelCluster, v : Double) -> ImagefiltersobelCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCluster::min(self : ImagefiltersobelCluster) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelCluster::max(self : ImagefiltersobelCluster) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelCluster::to_string(self : ImagefiltersobelCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_model_make(size : Int) -> ImagefiltersobelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelModel::len(self : ImagefiltersobelModel) -> Int { self.size }

pub fn ImagefiltersobelModel::get(self : ImagefiltersobelModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelModel::set(self : ImagefiltersobelModel, i : Int, v : Double) -> ImagefiltersobelModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelModel::sum(self : ImagefiltersobelModel) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelModel::mean(self : ImagefiltersobelModel) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelModel::scale(self : ImagefiltersobelModel, f : Double) -> ImagefiltersobelModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelModel::add(self : ImagefiltersobelModel, other : ImagefiltersobelModel) -> ImagefiltersobelModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelModel::copy(self : ImagefiltersobelModel) -> ImagefiltersobelModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelModel::fill(self : ImagefiltersobelModel, v : Double) -> ImagefiltersobelModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelModel::min(self : ImagefiltersobelModel) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelModel::max(self : ImagefiltersobelModel) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelModel::to_string(self : ImagefiltersobelModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_layer_make(size : Int) -> ImagefiltersobelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelLayer::len(self : ImagefiltersobelLayer) -> Int { self.size }

pub fn ImagefiltersobelLayer::get(self : ImagefiltersobelLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelLayer::set(self : ImagefiltersobelLayer, i : Int, v : Double) -> ImagefiltersobelLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelLayer::sum(self : ImagefiltersobelLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelLayer::mean(self : ImagefiltersobelLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelLayer::scale(self : ImagefiltersobelLayer, f : Double) -> ImagefiltersobelLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelLayer::add(self : ImagefiltersobelLayer, other : ImagefiltersobelLayer) -> ImagefiltersobelLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelLayer::copy(self : ImagefiltersobelLayer) -> ImagefiltersobelLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelLayer::fill(self : ImagefiltersobelLayer, v : Double) -> ImagefiltersobelLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelLayer::min(self : ImagefiltersobelLayer) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelLayer::max(self : ImagefiltersobelLayer) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelLayer::to_string(self : ImagefiltersobelLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_buffer_make(size : Int) -> ImagefiltersobelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelBuffer::len(self : ImagefiltersobelBuffer) -> Int { self.size }

pub fn ImagefiltersobelBuffer::get(self : ImagefiltersobelBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelBuffer::set(self : ImagefiltersobelBuffer, i : Int, v : Double) -> ImagefiltersobelBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelBuffer::sum(self : ImagefiltersobelBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelBuffer::mean(self : ImagefiltersobelBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelBuffer::scale(self : ImagefiltersobelBuffer, f : Double) -> ImagefiltersobelBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelBuffer::add(self : ImagefiltersobelBuffer, other : ImagefiltersobelBuffer) -> ImagefiltersobelBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelBuffer::copy(self : ImagefiltersobelBuffer) -> ImagefiltersobelBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelBuffer::fill(self : ImagefiltersobelBuffer, v : Double) -> ImagefiltersobelBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelBuffer::min(self : ImagefiltersobelBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelBuffer::max(self : ImagefiltersobelBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelBuffer::to_string(self : ImagefiltersobelBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_cursor_make(size : Int) -> ImagefiltersobelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelCursor::len(self : ImagefiltersobelCursor) -> Int { self.size }

pub fn ImagefiltersobelCursor::get(self : ImagefiltersobelCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelCursor::set(self : ImagefiltersobelCursor, i : Int, v : Double) -> ImagefiltersobelCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCursor::sum(self : ImagefiltersobelCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelCursor::mean(self : ImagefiltersobelCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelCursor::scale(self : ImagefiltersobelCursor, f : Double) -> ImagefiltersobelCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCursor::add(self : ImagefiltersobelCursor, other : ImagefiltersobelCursor) -> ImagefiltersobelCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelCursor::copy(self : ImagefiltersobelCursor) -> ImagefiltersobelCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCursor::fill(self : ImagefiltersobelCursor, v : Double) -> ImagefiltersobelCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelCursor::min(self : ImagefiltersobelCursor) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelCursor::max(self : ImagefiltersobelCursor) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelCursor::to_string(self : ImagefiltersobelCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_view_make(size : Int) -> ImagefiltersobelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelView::len(self : ImagefiltersobelView) -> Int { self.size }

pub fn ImagefiltersobelView::get(self : ImagefiltersobelView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelView::set(self : ImagefiltersobelView, i : Int, v : Double) -> ImagefiltersobelView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelView::sum(self : ImagefiltersobelView) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelView::mean(self : ImagefiltersobelView) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelView::scale(self : ImagefiltersobelView, f : Double) -> ImagefiltersobelView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelView::add(self : ImagefiltersobelView, other : ImagefiltersobelView) -> ImagefiltersobelView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelView::copy(self : ImagefiltersobelView) -> ImagefiltersobelView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelView::fill(self : ImagefiltersobelView, v : Double) -> ImagefiltersobelView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelView::min(self : ImagefiltersobelView) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelView::max(self : ImagefiltersobelView) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelView::to_string(self : ImagefiltersobelView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_range_make(size : Int) -> ImagefiltersobelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelRange::len(self : ImagefiltersobelRange) -> Int { self.size }

pub fn ImagefiltersobelRange::get(self : ImagefiltersobelRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelRange::set(self : ImagefiltersobelRange, i : Int, v : Double) -> ImagefiltersobelRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelRange::sum(self : ImagefiltersobelRange) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelRange::mean(self : ImagefiltersobelRange) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelRange::scale(self : ImagefiltersobelRange, f : Double) -> ImagefiltersobelRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelRange::add(self : ImagefiltersobelRange, other : ImagefiltersobelRange) -> ImagefiltersobelRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelRange::copy(self : ImagefiltersobelRange) -> ImagefiltersobelRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelRange::fill(self : ImagefiltersobelRange, v : Double) -> ImagefiltersobelRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelRange::min(self : ImagefiltersobelRange) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelRange::max(self : ImagefiltersobelRange) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelRange::to_string(self : ImagefiltersobelRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_slice_make(size : Int) -> ImagefiltersobelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltersobelSlice::len(self : ImagefiltersobelSlice) -> Int { self.size }

pub fn ImagefiltersobelSlice::get(self : ImagefiltersobelSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltersobelSlice::set(self : ImagefiltersobelSlice, i : Int, v : Double) -> ImagefiltersobelSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelSlice::sum(self : ImagefiltersobelSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefiltersobelSlice::mean(self : ImagefiltersobelSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefiltersobelSlice::scale(self : ImagefiltersobelSlice, f : Double) -> ImagefiltersobelSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelSlice::add(self : ImagefiltersobelSlice, other : ImagefiltersobelSlice) -> ImagefiltersobelSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltersobelSlice::copy(self : ImagefiltersobelSlice) -> ImagefiltersobelSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelSlice::fill(self : ImagefiltersobelSlice, v : Double) -> ImagefiltersobelSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltersobelSlice::min(self : ImagefiltersobelSlice) -> Double { @_common.min(self.data) }

pub fn ImagefiltersobelSlice::max(self : ImagefiltersobelSlice) -> Double { @_common.max(self.data) }

pub fn ImagefiltersobelSlice::to_string(self : ImagefiltersobelSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

