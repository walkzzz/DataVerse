///===
/// extcore/image_filter_canny

pub(all) struct ImagefiltercannyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_canny_make_point(x : Double, y : Double) -> ImagefiltercannyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_canny_make_point3(x : Double, y : Double, z : Double) -> ImagefiltercannyPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltercannyPoint::x(self : ImagefiltercannyPoint) -> Double { self.x }

pub fn ImagefiltercannyPoint::y(self : ImagefiltercannyPoint) -> Double { self.y }

pub fn ImagefiltercannyPoint::z(self : ImagefiltercannyPoint) -> Double { self.z }

pub fn ImagefiltercannyPoint::label(self : ImagefiltercannyPoint) -> Int { self.label }

pub fn ImagefiltercannyPoint::dist(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltercannyPoint::add(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltercannyPoint::sub(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltercannyPoint::scale(self : ImagefiltercannyPoint, s : Double) -> ImagefiltercannyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltercannyPoint::dot(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltercannyPoint::cross(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltercannyPoint::norm(self : ImagefiltercannyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltercannyPoint::normalize(self : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltercannyPoint::negate(self : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltercannyPoint::mid(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltercannyPoint::lerp(self : ImagefiltercannyPoint, other : ImagefiltercannyPoint, t : Double) -> ImagefiltercannyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltercannyPoint::to_string(self : ImagefiltercannyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltercannySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_canny_make_series(vals : Array[Double], name : String) -> ImagefiltercannySeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltercannySeries::len(self : ImagefiltercannySeries) -> Int { self.vals.length() }

pub fn ImagefiltercannySeries::sum(self : ImagefiltercannySeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltercannySeries::mean(self : ImagefiltercannySeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltercannySeries::min(self : ImagefiltercannySeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltercannySeries::max(self : ImagefiltercannySeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltercannySeries::range(self : ImagefiltercannySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltercannySeries::variance(self : ImagefiltercannySeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltercannySeries::std(self : ImagefiltercannySeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltercannySeries::median(self : ImagefiltercannySeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltercannySeries::scale(self : ImagefiltercannySeries, f : Double) -> ImagefiltercannySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltercannySeries::add(self : ImagefiltercannySeries, other : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltercannySeries::sub(self : ImagefiltercannySeries, other : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltercannySeries::normalize(self : ImagefiltercannySeries) -> ImagefiltercannySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltercannySeries::cumsum(self : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltercannySeries::to_string(self : ImagefiltercannySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltercannyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_canny_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltercannyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_canny_matrix_identity(n : Int) -> ImagefiltercannyMatrix {
  let m = image_filter_canny_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltercannyMatrix::get(self : ImagefiltercannyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltercannyMatrix::transpose(self : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  let result = image_filter_canny_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltercannyMatrix::add(self : ImagefiltercannyMatrix, other : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_canny_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltercannyMatrix::scale(self : ImagefiltercannyMatrix, s : Double) -> ImagefiltercannyMatrix {
  let result = image_filter_canny_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltercannyMatrix::multiply(self : ImagefiltercannyMatrix, other : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  if self.cols != other.rows { return image_filter_canny_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_canny_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefiltercannyMatrix::trace(self : ImagefiltercannyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltercannyMatrix::det(self : ImagefiltercannyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltercannyMatrix::norm(self : ImagefiltercannyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltercannyMatrix::to_string(self : ImagefiltercannyMatrix) -> String {
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

pub(all) struct ImagefiltercannyVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_canny_make_vector(comps : Array[Double]) -> ImagefiltercannyVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_canny_vector_zero(dim : Int) -> ImagefiltercannyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltercannyVector::add(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltercannyVector::sub(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltercannyVector::scale(self : ImagefiltercannyVector, s : Double) -> ImagefiltercannyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltercannyVector::dot(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltercannyVector::norm(self : ImagefiltercannyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltercannyVector::normalize(self : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltercannyVector::dist(self : ImagefiltercannyVector, other : ImagefiltercannyVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltercannyVector::to_string(self : ImagefiltercannyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_canny_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_canny_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_canny_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_canny_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_canny_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_canny_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_canny_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_canny_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_canny_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_canny_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_canny_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_canny_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_canny_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_canny_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_canny_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_canny_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_canny_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_canny_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_canny_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_canny_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_canny_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_canny_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_canny_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_canny_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_canny_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_canny_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_canny_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_canny_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_canny_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltercannyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_frame_make(size : Int) -> ImagefiltercannyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_frame_len(s : ImagefiltercannyFrame) -> Int { s.size }

pub fn image_filter_canny_frame_get(s : ImagefiltercannyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_frame_set(s : ImagefiltercannyFrame, i : Int, v : Double) -> ImagefiltercannyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_frame_sum(s : ImagefiltercannyFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_frame_mean(s : ImagefiltercannyFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_frame_scale(s : ImagefiltercannyFrame, f : Double) -> ImagefiltercannyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_frame_add(a : ImagefiltercannyFrame, b : ImagefiltercannyFrame) -> ImagefiltercannyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_frame_copy(s : ImagefiltercannyFrame) -> ImagefiltercannyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_frame_fill(s : ImagefiltercannyFrame, v : Double) -> ImagefiltercannyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_frame_min(s : ImagefiltercannyFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_frame_max(s : ImagefiltercannyFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_frame_to_string(s : ImagefiltercannyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_table_make(size : Int) -> ImagefiltercannyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_table_len(s : ImagefiltercannyTable) -> Int { s.size }

pub fn image_filter_canny_table_get(s : ImagefiltercannyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_table_set(s : ImagefiltercannyTable, i : Int, v : Double) -> ImagefiltercannyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_table_sum(s : ImagefiltercannyTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_table_mean(s : ImagefiltercannyTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_table_scale(s : ImagefiltercannyTable, f : Double) -> ImagefiltercannyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_table_add(a : ImagefiltercannyTable, b : ImagefiltercannyTable) -> ImagefiltercannyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_table_copy(s : ImagefiltercannyTable) -> ImagefiltercannyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_table_fill(s : ImagefiltercannyTable, v : Double) -> ImagefiltercannyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_table_min(s : ImagefiltercannyTable) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_table_max(s : ImagefiltercannyTable) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_table_to_string(s : ImagefiltercannyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_graphn_make(size : Int) -> ImagefiltercannyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_graphn_len(s : ImagefiltercannyGraphN) -> Int { s.size }

pub fn image_filter_canny_graphn_get(s : ImagefiltercannyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_graphn_set(s : ImagefiltercannyGraphN, i : Int, v : Double) -> ImagefiltercannyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_graphn_sum(s : ImagefiltercannyGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_graphn_mean(s : ImagefiltercannyGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_graphn_scale(s : ImagefiltercannyGraphN, f : Double) -> ImagefiltercannyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_graphn_add(a : ImagefiltercannyGraphN, b : ImagefiltercannyGraphN) -> ImagefiltercannyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_graphn_copy(s : ImagefiltercannyGraphN) -> ImagefiltercannyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_graphn_fill(s : ImagefiltercannyGraphN, v : Double) -> ImagefiltercannyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_graphn_min(s : ImagefiltercannyGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_graphn_max(s : ImagefiltercannyGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_graphn_to_string(s : ImagefiltercannyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_node_make(size : Int) -> ImagefiltercannyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_node_len(s : ImagefiltercannyNode) -> Int { s.size }

pub fn image_filter_canny_node_get(s : ImagefiltercannyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_node_set(s : ImagefiltercannyNode, i : Int, v : Double) -> ImagefiltercannyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_node_sum(s : ImagefiltercannyNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_node_mean(s : ImagefiltercannyNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_node_scale(s : ImagefiltercannyNode, f : Double) -> ImagefiltercannyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_node_add(a : ImagefiltercannyNode, b : ImagefiltercannyNode) -> ImagefiltercannyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_node_copy(s : ImagefiltercannyNode) -> ImagefiltercannyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_node_fill(s : ImagefiltercannyNode, v : Double) -> ImagefiltercannyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_node_min(s : ImagefiltercannyNode) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_node_max(s : ImagefiltercannyNode) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_node_to_string(s : ImagefiltercannyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_edge_make(size : Int) -> ImagefiltercannyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_edge_len(s : ImagefiltercannyEdge) -> Int { s.size }

pub fn image_filter_canny_edge_get(s : ImagefiltercannyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_edge_set(s : ImagefiltercannyEdge, i : Int, v : Double) -> ImagefiltercannyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_edge_sum(s : ImagefiltercannyEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_edge_mean(s : ImagefiltercannyEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_edge_scale(s : ImagefiltercannyEdge, f : Double) -> ImagefiltercannyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_edge_add(a : ImagefiltercannyEdge, b : ImagefiltercannyEdge) -> ImagefiltercannyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_edge_copy(s : ImagefiltercannyEdge) -> ImagefiltercannyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_edge_fill(s : ImagefiltercannyEdge, v : Double) -> ImagefiltercannyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_edge_min(s : ImagefiltercannyEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_edge_max(s : ImagefiltercannyEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_edge_to_string(s : ImagefiltercannyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_path_make(size : Int) -> ImagefiltercannyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_path_len(s : ImagefiltercannyPath) -> Int { s.size }

pub fn image_filter_canny_path_get(s : ImagefiltercannyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_path_set(s : ImagefiltercannyPath, i : Int, v : Double) -> ImagefiltercannyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_path_sum(s : ImagefiltercannyPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_path_mean(s : ImagefiltercannyPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_path_scale(s : ImagefiltercannyPath, f : Double) -> ImagefiltercannyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_path_add(a : ImagefiltercannyPath, b : ImagefiltercannyPath) -> ImagefiltercannyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_path_copy(s : ImagefiltercannyPath) -> ImagefiltercannyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_path_fill(s : ImagefiltercannyPath, v : Double) -> ImagefiltercannyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_path_min(s : ImagefiltercannyPath) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_path_max(s : ImagefiltercannyPath) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_path_to_string(s : ImagefiltercannyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_cluster_make(size : Int) -> ImagefiltercannyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_cluster_len(s : ImagefiltercannyCluster) -> Int { s.size }

pub fn image_filter_canny_cluster_get(s : ImagefiltercannyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_cluster_set(s : ImagefiltercannyCluster, i : Int, v : Double) -> ImagefiltercannyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cluster_sum(s : ImagefiltercannyCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_cluster_mean(s : ImagefiltercannyCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_cluster_scale(s : ImagefiltercannyCluster, f : Double) -> ImagefiltercannyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cluster_add(a : ImagefiltercannyCluster, b : ImagefiltercannyCluster) -> ImagefiltercannyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_cluster_copy(s : ImagefiltercannyCluster) -> ImagefiltercannyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cluster_fill(s : ImagefiltercannyCluster, v : Double) -> ImagefiltercannyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cluster_min(s : ImagefiltercannyCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_cluster_max(s : ImagefiltercannyCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_cluster_to_string(s : ImagefiltercannyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_model_make(size : Int) -> ImagefiltercannyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_model_len(s : ImagefiltercannyModel) -> Int { s.size }

pub fn image_filter_canny_model_get(s : ImagefiltercannyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_model_set(s : ImagefiltercannyModel, i : Int, v : Double) -> ImagefiltercannyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_model_sum(s : ImagefiltercannyModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_model_mean(s : ImagefiltercannyModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_model_scale(s : ImagefiltercannyModel, f : Double) -> ImagefiltercannyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_model_add(a : ImagefiltercannyModel, b : ImagefiltercannyModel) -> ImagefiltercannyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_model_copy(s : ImagefiltercannyModel) -> ImagefiltercannyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_model_fill(s : ImagefiltercannyModel, v : Double) -> ImagefiltercannyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_model_min(s : ImagefiltercannyModel) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_model_max(s : ImagefiltercannyModel) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_model_to_string(s : ImagefiltercannyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_layer_make(size : Int) -> ImagefiltercannyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_layer_len(s : ImagefiltercannyLayer) -> Int { s.size }

pub fn image_filter_canny_layer_get(s : ImagefiltercannyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_layer_set(s : ImagefiltercannyLayer, i : Int, v : Double) -> ImagefiltercannyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_layer_sum(s : ImagefiltercannyLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_layer_mean(s : ImagefiltercannyLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_layer_scale(s : ImagefiltercannyLayer, f : Double) -> ImagefiltercannyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_layer_add(a : ImagefiltercannyLayer, b : ImagefiltercannyLayer) -> ImagefiltercannyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_layer_copy(s : ImagefiltercannyLayer) -> ImagefiltercannyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_layer_fill(s : ImagefiltercannyLayer, v : Double) -> ImagefiltercannyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_layer_min(s : ImagefiltercannyLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_layer_max(s : ImagefiltercannyLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_layer_to_string(s : ImagefiltercannyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_buffer_make(size : Int) -> ImagefiltercannyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_buffer_len(s : ImagefiltercannyBuffer) -> Int { s.size }

pub fn image_filter_canny_buffer_get(s : ImagefiltercannyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_buffer_set(s : ImagefiltercannyBuffer, i : Int, v : Double) -> ImagefiltercannyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_buffer_sum(s : ImagefiltercannyBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_buffer_mean(s : ImagefiltercannyBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_buffer_scale(s : ImagefiltercannyBuffer, f : Double) -> ImagefiltercannyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_buffer_add(a : ImagefiltercannyBuffer, b : ImagefiltercannyBuffer) -> ImagefiltercannyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_buffer_copy(s : ImagefiltercannyBuffer) -> ImagefiltercannyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_buffer_fill(s : ImagefiltercannyBuffer, v : Double) -> ImagefiltercannyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_buffer_min(s : ImagefiltercannyBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_buffer_max(s : ImagefiltercannyBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_buffer_to_string(s : ImagefiltercannyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_cursor_make(size : Int) -> ImagefiltercannyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_cursor_len(s : ImagefiltercannyCursor) -> Int { s.size }

pub fn image_filter_canny_cursor_get(s : ImagefiltercannyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_cursor_set(s : ImagefiltercannyCursor, i : Int, v : Double) -> ImagefiltercannyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cursor_sum(s : ImagefiltercannyCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_cursor_mean(s : ImagefiltercannyCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_cursor_scale(s : ImagefiltercannyCursor, f : Double) -> ImagefiltercannyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cursor_add(a : ImagefiltercannyCursor, b : ImagefiltercannyCursor) -> ImagefiltercannyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_cursor_copy(s : ImagefiltercannyCursor) -> ImagefiltercannyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cursor_fill(s : ImagefiltercannyCursor, v : Double) -> ImagefiltercannyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_cursor_min(s : ImagefiltercannyCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_cursor_max(s : ImagefiltercannyCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_cursor_to_string(s : ImagefiltercannyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_view_make(size : Int) -> ImagefiltercannyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_view_len(s : ImagefiltercannyView) -> Int { s.size }

pub fn image_filter_canny_view_get(s : ImagefiltercannyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_view_set(s : ImagefiltercannyView, i : Int, v : Double) -> ImagefiltercannyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_view_sum(s : ImagefiltercannyView) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_view_mean(s : ImagefiltercannyView) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_view_scale(s : ImagefiltercannyView, f : Double) -> ImagefiltercannyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_view_add(a : ImagefiltercannyView, b : ImagefiltercannyView) -> ImagefiltercannyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_view_copy(s : ImagefiltercannyView) -> ImagefiltercannyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_view_fill(s : ImagefiltercannyView, v : Double) -> ImagefiltercannyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_view_min(s : ImagefiltercannyView) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_view_max(s : ImagefiltercannyView) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_view_to_string(s : ImagefiltercannyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_range_make(size : Int) -> ImagefiltercannyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_range_len(s : ImagefiltercannyRange) -> Int { s.size }

pub fn image_filter_canny_range_get(s : ImagefiltercannyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_range_set(s : ImagefiltercannyRange, i : Int, v : Double) -> ImagefiltercannyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_range_sum(s : ImagefiltercannyRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_range_mean(s : ImagefiltercannyRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_range_scale(s : ImagefiltercannyRange, f : Double) -> ImagefiltercannyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_range_add(a : ImagefiltercannyRange, b : ImagefiltercannyRange) -> ImagefiltercannyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_range_copy(s : ImagefiltercannyRange) -> ImagefiltercannyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_range_fill(s : ImagefiltercannyRange, v : Double) -> ImagefiltercannyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_range_min(s : ImagefiltercannyRange) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_range_max(s : ImagefiltercannyRange) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_range_to_string(s : ImagefiltercannyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_slice_make(size : Int) -> ImagefiltercannySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_slice_len(s : ImagefiltercannySlice) -> Int { s.size }

pub fn image_filter_canny_slice_get(s : ImagefiltercannySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_slice_set(s : ImagefiltercannySlice, i : Int, v : Double) -> ImagefiltercannySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_canny_slice_sum(s : ImagefiltercannySlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_canny_slice_mean(s : ImagefiltercannySlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_canny_slice_scale(s : ImagefiltercannySlice, f : Double) -> ImagefiltercannySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_slice_add(a : ImagefiltercannySlice, b : ImagefiltercannySlice) -> ImagefiltercannySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_canny_slice_copy(s : ImagefiltercannySlice) -> ImagefiltercannySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_slice_fill(s : ImagefiltercannySlice, v : Double) -> ImagefiltercannySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_canny_slice_min(s : ImagefiltercannySlice) -> Double { @_common.min(s.data) }

pub fn image_filter_canny_slice_max(s : ImagefiltercannySlice) -> Double { @_common.max(s.data) }

pub fn image_filter_canny_slice_to_string(s : ImagefiltercannySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

