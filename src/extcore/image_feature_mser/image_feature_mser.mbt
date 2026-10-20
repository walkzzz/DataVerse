///===
/// extcore/image_feature_mser

pub(all) struct ImagefeaturemserPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_mser_make_point(x : Double, y : Double) -> ImagefeaturemserPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_mser_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturemserPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturemserPoint::x(self : ImagefeaturemserPoint) -> Double { self.x }

pub fn ImagefeaturemserPoint::y(self : ImagefeaturemserPoint) -> Double { self.y }

pub fn ImagefeaturemserPoint::z(self : ImagefeaturemserPoint) -> Double { self.z }

pub fn ImagefeaturemserPoint::label(self : ImagefeaturemserPoint) -> Int { self.label }

pub fn ImagefeaturemserPoint::dist(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturemserPoint::add(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturemserPoint::sub(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturemserPoint::scale(self : ImagefeaturemserPoint, s : Double) -> ImagefeaturemserPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturemserPoint::dot(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturemserPoint::cross(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturemserPoint::norm(self : ImagefeaturemserPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturemserPoint::normalize(self : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturemserPoint::negate(self : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturemserPoint::mid(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturemserPoint::lerp(self : ImagefeaturemserPoint, other : ImagefeaturemserPoint, t : Double) -> ImagefeaturemserPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturemserPoint::to_string(self : ImagefeaturemserPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturemserSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_mser_make_series(vals : Array[Double], name : String) -> ImagefeaturemserSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturemserSeries::len(self : ImagefeaturemserSeries) -> Int { self.vals.length() }

pub fn ImagefeaturemserSeries::sum(self : ImagefeaturemserSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturemserSeries::mean(self : ImagefeaturemserSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturemserSeries::min(self : ImagefeaturemserSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturemserSeries::max(self : ImagefeaturemserSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturemserSeries::range(self : ImagefeaturemserSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturemserSeries::variance(self : ImagefeaturemserSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturemserSeries::std(self : ImagefeaturemserSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturemserSeries::median(self : ImagefeaturemserSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturemserSeries::scale(self : ImagefeaturemserSeries, f : Double) -> ImagefeaturemserSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturemserSeries::add(self : ImagefeaturemserSeries, other : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturemserSeries::sub(self : ImagefeaturemserSeries, other : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturemserSeries::normalize(self : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturemserSeries::cumsum(self : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturemserSeries::to_string(self : ImagefeaturemserSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturemserMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_mser_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturemserMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_mser_matrix_identity(n : Int) -> ImagefeaturemserMatrix {
  let m = image_feature_mser_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturemserMatrix::get(self : ImagefeaturemserMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturemserMatrix::transpose(self : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  let result = image_feature_mser_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturemserMatrix::add(self : ImagefeaturemserMatrix, other : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_mser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturemserMatrix::scale(self : ImagefeaturemserMatrix, s : Double) -> ImagefeaturemserMatrix {
  let result = image_feature_mser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturemserMatrix::multiply(self : ImagefeaturemserMatrix, other : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  if self.cols != other.rows { return image_feature_mser_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_mser_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturemserMatrix::trace(self : ImagefeaturemserMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturemserMatrix::det(self : ImagefeaturemserMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturemserMatrix::norm(self : ImagefeaturemserMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturemserMatrix::to_string(self : ImagefeaturemserMatrix) -> String {
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

pub(all) struct ImagefeaturemserVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_mser_make_vector(comps : Array[Double]) -> ImagefeaturemserVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_mser_vector_zero(dim : Int) -> ImagefeaturemserVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturemserVector::add(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturemserVector::sub(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturemserVector::scale(self : ImagefeaturemserVector, s : Double) -> ImagefeaturemserVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturemserVector::dot(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturemserVector::norm(self : ImagefeaturemserVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturemserVector::normalize(self : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturemserVector::dist(self : ImagefeaturemserVector, other : ImagefeaturemserVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturemserVector::to_string(self : ImagefeaturemserVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_mser_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_mser_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_mser_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_mser_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_mser_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_mser_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_mser_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_mser_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_mser_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_mser_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_mser_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_mser_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_mser_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_mser_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_mser_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_mser_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_mser_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_mser_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_mser_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_mser_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_mser_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_mser_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_mser_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_mser_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_mser_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_mser_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_mser_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_mser_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_mser_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturemserFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_frame_make(size : Int) -> ImagefeaturemserFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_frame_len(s : ImagefeaturemserFrame) -> Int { s.size }

pub fn image_feature_mser_frame_get(s : ImagefeaturemserFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_frame_set(s : ImagefeaturemserFrame, i : Int, v : Double) -> ImagefeaturemserFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_frame_sum(s : ImagefeaturemserFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_frame_mean(s : ImagefeaturemserFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_frame_scale(s : ImagefeaturemserFrame, f : Double) -> ImagefeaturemserFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_frame_add(a : ImagefeaturemserFrame, b : ImagefeaturemserFrame) -> ImagefeaturemserFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_frame_copy(s : ImagefeaturemserFrame) -> ImagefeaturemserFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_frame_fill(s : ImagefeaturemserFrame, v : Double) -> ImagefeaturemserFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_frame_min(s : ImagefeaturemserFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_frame_max(s : ImagefeaturemserFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_frame_to_string(s : ImagefeaturemserFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_table_make(size : Int) -> ImagefeaturemserTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_table_len(s : ImagefeaturemserTable) -> Int { s.size }

pub fn image_feature_mser_table_get(s : ImagefeaturemserTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_table_set(s : ImagefeaturemserTable, i : Int, v : Double) -> ImagefeaturemserTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_table_sum(s : ImagefeaturemserTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_table_mean(s : ImagefeaturemserTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_table_scale(s : ImagefeaturemserTable, f : Double) -> ImagefeaturemserTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_table_add(a : ImagefeaturemserTable, b : ImagefeaturemserTable) -> ImagefeaturemserTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_table_copy(s : ImagefeaturemserTable) -> ImagefeaturemserTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_table_fill(s : ImagefeaturemserTable, v : Double) -> ImagefeaturemserTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_table_min(s : ImagefeaturemserTable) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_table_max(s : ImagefeaturemserTable) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_table_to_string(s : ImagefeaturemserTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_graphn_make(size : Int) -> ImagefeaturemserGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_graphn_len(s : ImagefeaturemserGraphN) -> Int { s.size }

pub fn image_feature_mser_graphn_get(s : ImagefeaturemserGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_graphn_set(s : ImagefeaturemserGraphN, i : Int, v : Double) -> ImagefeaturemserGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_graphn_sum(s : ImagefeaturemserGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_graphn_mean(s : ImagefeaturemserGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_graphn_scale(s : ImagefeaturemserGraphN, f : Double) -> ImagefeaturemserGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_graphn_add(a : ImagefeaturemserGraphN, b : ImagefeaturemserGraphN) -> ImagefeaturemserGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_graphn_copy(s : ImagefeaturemserGraphN) -> ImagefeaturemserGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_graphn_fill(s : ImagefeaturemserGraphN, v : Double) -> ImagefeaturemserGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_graphn_min(s : ImagefeaturemserGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_graphn_max(s : ImagefeaturemserGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_graphn_to_string(s : ImagefeaturemserGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_node_make(size : Int) -> ImagefeaturemserNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_node_len(s : ImagefeaturemserNode) -> Int { s.size }

pub fn image_feature_mser_node_get(s : ImagefeaturemserNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_node_set(s : ImagefeaturemserNode, i : Int, v : Double) -> ImagefeaturemserNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_node_sum(s : ImagefeaturemserNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_node_mean(s : ImagefeaturemserNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_node_scale(s : ImagefeaturemserNode, f : Double) -> ImagefeaturemserNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_node_add(a : ImagefeaturemserNode, b : ImagefeaturemserNode) -> ImagefeaturemserNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_node_copy(s : ImagefeaturemserNode) -> ImagefeaturemserNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_node_fill(s : ImagefeaturemserNode, v : Double) -> ImagefeaturemserNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_node_min(s : ImagefeaturemserNode) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_node_max(s : ImagefeaturemserNode) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_node_to_string(s : ImagefeaturemserNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_edge_make(size : Int) -> ImagefeaturemserEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_edge_len(s : ImagefeaturemserEdge) -> Int { s.size }

pub fn image_feature_mser_edge_get(s : ImagefeaturemserEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_edge_set(s : ImagefeaturemserEdge, i : Int, v : Double) -> ImagefeaturemserEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_edge_sum(s : ImagefeaturemserEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_edge_mean(s : ImagefeaturemserEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_edge_scale(s : ImagefeaturemserEdge, f : Double) -> ImagefeaturemserEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_edge_add(a : ImagefeaturemserEdge, b : ImagefeaturemserEdge) -> ImagefeaturemserEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_edge_copy(s : ImagefeaturemserEdge) -> ImagefeaturemserEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_edge_fill(s : ImagefeaturemserEdge, v : Double) -> ImagefeaturemserEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_edge_min(s : ImagefeaturemserEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_edge_max(s : ImagefeaturemserEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_edge_to_string(s : ImagefeaturemserEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_path_make(size : Int) -> ImagefeaturemserPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_path_len(s : ImagefeaturemserPath) -> Int { s.size }

pub fn image_feature_mser_path_get(s : ImagefeaturemserPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_path_set(s : ImagefeaturemserPath, i : Int, v : Double) -> ImagefeaturemserPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_path_sum(s : ImagefeaturemserPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_path_mean(s : ImagefeaturemserPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_path_scale(s : ImagefeaturemserPath, f : Double) -> ImagefeaturemserPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_path_add(a : ImagefeaturemserPath, b : ImagefeaturemserPath) -> ImagefeaturemserPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_path_copy(s : ImagefeaturemserPath) -> ImagefeaturemserPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_path_fill(s : ImagefeaturemserPath, v : Double) -> ImagefeaturemserPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_path_min(s : ImagefeaturemserPath) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_path_max(s : ImagefeaturemserPath) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_path_to_string(s : ImagefeaturemserPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_cluster_make(size : Int) -> ImagefeaturemserCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_cluster_len(s : ImagefeaturemserCluster) -> Int { s.size }

pub fn image_feature_mser_cluster_get(s : ImagefeaturemserCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_cluster_set(s : ImagefeaturemserCluster, i : Int, v : Double) -> ImagefeaturemserCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cluster_sum(s : ImagefeaturemserCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_cluster_mean(s : ImagefeaturemserCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_cluster_scale(s : ImagefeaturemserCluster, f : Double) -> ImagefeaturemserCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cluster_add(a : ImagefeaturemserCluster, b : ImagefeaturemserCluster) -> ImagefeaturemserCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_cluster_copy(s : ImagefeaturemserCluster) -> ImagefeaturemserCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cluster_fill(s : ImagefeaturemserCluster, v : Double) -> ImagefeaturemserCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cluster_min(s : ImagefeaturemserCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_cluster_max(s : ImagefeaturemserCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_cluster_to_string(s : ImagefeaturemserCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_model_make(size : Int) -> ImagefeaturemserModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_model_len(s : ImagefeaturemserModel) -> Int { s.size }

pub fn image_feature_mser_model_get(s : ImagefeaturemserModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_model_set(s : ImagefeaturemserModel, i : Int, v : Double) -> ImagefeaturemserModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_model_sum(s : ImagefeaturemserModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_model_mean(s : ImagefeaturemserModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_model_scale(s : ImagefeaturemserModel, f : Double) -> ImagefeaturemserModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_model_add(a : ImagefeaturemserModel, b : ImagefeaturemserModel) -> ImagefeaturemserModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_model_copy(s : ImagefeaturemserModel) -> ImagefeaturemserModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_model_fill(s : ImagefeaturemserModel, v : Double) -> ImagefeaturemserModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_model_min(s : ImagefeaturemserModel) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_model_max(s : ImagefeaturemserModel) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_model_to_string(s : ImagefeaturemserModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_layer_make(size : Int) -> ImagefeaturemserLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_layer_len(s : ImagefeaturemserLayer) -> Int { s.size }

pub fn image_feature_mser_layer_get(s : ImagefeaturemserLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_layer_set(s : ImagefeaturemserLayer, i : Int, v : Double) -> ImagefeaturemserLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_layer_sum(s : ImagefeaturemserLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_layer_mean(s : ImagefeaturemserLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_layer_scale(s : ImagefeaturemserLayer, f : Double) -> ImagefeaturemserLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_layer_add(a : ImagefeaturemserLayer, b : ImagefeaturemserLayer) -> ImagefeaturemserLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_layer_copy(s : ImagefeaturemserLayer) -> ImagefeaturemserLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_layer_fill(s : ImagefeaturemserLayer, v : Double) -> ImagefeaturemserLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_layer_min(s : ImagefeaturemserLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_layer_max(s : ImagefeaturemserLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_layer_to_string(s : ImagefeaturemserLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_buffer_make(size : Int) -> ImagefeaturemserBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_buffer_len(s : ImagefeaturemserBuffer) -> Int { s.size }

pub fn image_feature_mser_buffer_get(s : ImagefeaturemserBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_buffer_set(s : ImagefeaturemserBuffer, i : Int, v : Double) -> ImagefeaturemserBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_buffer_sum(s : ImagefeaturemserBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_buffer_mean(s : ImagefeaturemserBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_buffer_scale(s : ImagefeaturemserBuffer, f : Double) -> ImagefeaturemserBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_buffer_add(a : ImagefeaturemserBuffer, b : ImagefeaturemserBuffer) -> ImagefeaturemserBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_buffer_copy(s : ImagefeaturemserBuffer) -> ImagefeaturemserBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_buffer_fill(s : ImagefeaturemserBuffer, v : Double) -> ImagefeaturemserBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_buffer_min(s : ImagefeaturemserBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_buffer_max(s : ImagefeaturemserBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_buffer_to_string(s : ImagefeaturemserBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_cursor_make(size : Int) -> ImagefeaturemserCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_cursor_len(s : ImagefeaturemserCursor) -> Int { s.size }

pub fn image_feature_mser_cursor_get(s : ImagefeaturemserCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_cursor_set(s : ImagefeaturemserCursor, i : Int, v : Double) -> ImagefeaturemserCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cursor_sum(s : ImagefeaturemserCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_cursor_mean(s : ImagefeaturemserCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_cursor_scale(s : ImagefeaturemserCursor, f : Double) -> ImagefeaturemserCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cursor_add(a : ImagefeaturemserCursor, b : ImagefeaturemserCursor) -> ImagefeaturemserCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_cursor_copy(s : ImagefeaturemserCursor) -> ImagefeaturemserCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cursor_fill(s : ImagefeaturemserCursor, v : Double) -> ImagefeaturemserCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_cursor_min(s : ImagefeaturemserCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_cursor_max(s : ImagefeaturemserCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_cursor_to_string(s : ImagefeaturemserCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_view_make(size : Int) -> ImagefeaturemserView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_view_len(s : ImagefeaturemserView) -> Int { s.size }

pub fn image_feature_mser_view_get(s : ImagefeaturemserView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_view_set(s : ImagefeaturemserView, i : Int, v : Double) -> ImagefeaturemserView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_view_sum(s : ImagefeaturemserView) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_view_mean(s : ImagefeaturemserView) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_view_scale(s : ImagefeaturemserView, f : Double) -> ImagefeaturemserView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_view_add(a : ImagefeaturemserView, b : ImagefeaturemserView) -> ImagefeaturemserView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_view_copy(s : ImagefeaturemserView) -> ImagefeaturemserView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_view_fill(s : ImagefeaturemserView, v : Double) -> ImagefeaturemserView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_view_min(s : ImagefeaturemserView) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_view_max(s : ImagefeaturemserView) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_view_to_string(s : ImagefeaturemserView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_range_make(size : Int) -> ImagefeaturemserRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_range_len(s : ImagefeaturemserRange) -> Int { s.size }

pub fn image_feature_mser_range_get(s : ImagefeaturemserRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_range_set(s : ImagefeaturemserRange, i : Int, v : Double) -> ImagefeaturemserRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_range_sum(s : ImagefeaturemserRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_range_mean(s : ImagefeaturemserRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_range_scale(s : ImagefeaturemserRange, f : Double) -> ImagefeaturemserRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_range_add(a : ImagefeaturemserRange, b : ImagefeaturemserRange) -> ImagefeaturemserRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_range_copy(s : ImagefeaturemserRange) -> ImagefeaturemserRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_range_fill(s : ImagefeaturemserRange, v : Double) -> ImagefeaturemserRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_range_min(s : ImagefeaturemserRange) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_range_max(s : ImagefeaturemserRange) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_range_to_string(s : ImagefeaturemserRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_slice_make(size : Int) -> ImagefeaturemserSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_slice_len(s : ImagefeaturemserSlice) -> Int { s.size }

pub fn image_feature_mser_slice_get(s : ImagefeaturemserSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_slice_set(s : ImagefeaturemserSlice, i : Int, v : Double) -> ImagefeaturemserSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_mser_slice_sum(s : ImagefeaturemserSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_mser_slice_mean(s : ImagefeaturemserSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_mser_slice_scale(s : ImagefeaturemserSlice, f : Double) -> ImagefeaturemserSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_slice_add(a : ImagefeaturemserSlice, b : ImagefeaturemserSlice) -> ImagefeaturemserSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_mser_slice_copy(s : ImagefeaturemserSlice) -> ImagefeaturemserSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_slice_fill(s : ImagefeaturemserSlice, v : Double) -> ImagefeaturemserSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_mser_slice_min(s : ImagefeaturemserSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_mser_slice_max(s : ImagefeaturemserSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_mser_slice_to_string(s : ImagefeaturemserSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

