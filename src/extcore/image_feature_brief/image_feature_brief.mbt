///===
/// extcore/image_feature_brief

pub(all) struct ImagefeaturebriefPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_brief_make_point(x : Double, y : Double) -> ImagefeaturebriefPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_brief_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturebriefPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturebriefPoint::x(self : ImagefeaturebriefPoint) -> Double { self.x }

pub fn ImagefeaturebriefPoint::y(self : ImagefeaturebriefPoint) -> Double { self.y }

pub fn ImagefeaturebriefPoint::z(self : ImagefeaturebriefPoint) -> Double { self.z }

pub fn ImagefeaturebriefPoint::label(self : ImagefeaturebriefPoint) -> Int { self.label }

pub fn ImagefeaturebriefPoint::dist(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturebriefPoint::add(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturebriefPoint::sub(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturebriefPoint::scale(self : ImagefeaturebriefPoint, s : Double) -> ImagefeaturebriefPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturebriefPoint::dot(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturebriefPoint::cross(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturebriefPoint::norm(self : ImagefeaturebriefPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturebriefPoint::normalize(self : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturebriefPoint::negate(self : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturebriefPoint::mid(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturebriefPoint::lerp(self : ImagefeaturebriefPoint, other : ImagefeaturebriefPoint, t : Double) -> ImagefeaturebriefPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturebriefPoint::to_string(self : ImagefeaturebriefPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturebriefSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_brief_make_series(vals : Array[Double], name : String) -> ImagefeaturebriefSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturebriefSeries::len(self : ImagefeaturebriefSeries) -> Int { self.vals.length() }

pub fn ImagefeaturebriefSeries::sum(self : ImagefeaturebriefSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturebriefSeries::mean(self : ImagefeaturebriefSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturebriefSeries::min(self : ImagefeaturebriefSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturebriefSeries::max(self : ImagefeaturebriefSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturebriefSeries::range(self : ImagefeaturebriefSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturebriefSeries::variance(self : ImagefeaturebriefSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturebriefSeries::std(self : ImagefeaturebriefSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturebriefSeries::median(self : ImagefeaturebriefSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturebriefSeries::scale(self : ImagefeaturebriefSeries, f : Double) -> ImagefeaturebriefSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturebriefSeries::add(self : ImagefeaturebriefSeries, other : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturebriefSeries::sub(self : ImagefeaturebriefSeries, other : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturebriefSeries::normalize(self : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturebriefSeries::cumsum(self : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturebriefSeries::to_string(self : ImagefeaturebriefSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturebriefMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_brief_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturebriefMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_brief_matrix_identity(n : Int) -> ImagefeaturebriefMatrix {
  let m = image_feature_brief_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturebriefMatrix::get(self : ImagefeaturebriefMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturebriefMatrix::transpose(self : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturebriefMatrix::add(self : ImagefeaturebriefMatrix, other : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_brief_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturebriefMatrix::scale(self : ImagefeaturebriefMatrix, s : Double) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturebriefMatrix::multiply(self : ImagefeaturebriefMatrix, other : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  if self.cols != other.rows { return image_feature_brief_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_brief_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturebriefMatrix::trace(self : ImagefeaturebriefMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturebriefMatrix::det(self : ImagefeaturebriefMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturebriefMatrix::norm(self : ImagefeaturebriefMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturebriefMatrix::to_string(self : ImagefeaturebriefMatrix) -> String {
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

pub(all) struct ImagefeaturebriefVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_brief_make_vector(comps : Array[Double]) -> ImagefeaturebriefVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_brief_vector_zero(dim : Int) -> ImagefeaturebriefVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturebriefVector::add(self : ImagefeaturebriefVector, other : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturebriefVector::sub(self : ImagefeaturebriefVector, other : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturebriefVector::scale(self : ImagefeaturebriefVector, s : Double) -> ImagefeaturebriefVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturebriefVector::dot(self : ImagefeaturebriefVector, other : ImagefeaturebriefVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturebriefVector::norm(self : ImagefeaturebriefVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturebriefVector::normalize(self : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturebriefVector::dist(self : ImagefeaturebriefVector, other : ImagefeaturebriefVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturebriefVector::to_string(self : ImagefeaturebriefVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_brief_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_brief_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_brief_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_brief_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_brief_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_brief_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_brief_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_brief_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_brief_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_brief_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_brief_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_brief_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_brief_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_brief_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_brief_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_brief_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_brief_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_brief_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_brief_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_brief_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_brief_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_brief_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_brief_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_brief_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_brief_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_brief_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_brief_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_brief_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_brief_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturebriefFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_frame_make(size : Int) -> ImagefeaturebriefFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_frame_len(s : ImagefeaturebriefFrame) -> Int { s.size }

pub fn image_feature_brief_frame_get(s : ImagefeaturebriefFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_frame_set(s : ImagefeaturebriefFrame, i : Int, v : Double) -> ImagefeaturebriefFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_sum(s : ImagefeaturebriefFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_frame_mean(s : ImagefeaturebriefFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_frame_scale(s : ImagefeaturebriefFrame, f : Double) -> ImagefeaturebriefFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_add(a : ImagefeaturebriefFrame, b : ImagefeaturebriefFrame) -> ImagefeaturebriefFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_frame_copy(s : ImagefeaturebriefFrame) -> ImagefeaturebriefFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_fill(s : ImagefeaturebriefFrame, v : Double) -> ImagefeaturebriefFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_min(s : ImagefeaturebriefFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_frame_max(s : ImagefeaturebriefFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_frame_to_string(s : ImagefeaturebriefFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_table_make(size : Int) -> ImagefeaturebriefTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_table_len(s : ImagefeaturebriefTable) -> Int { s.size }

pub fn image_feature_brief_table_get(s : ImagefeaturebriefTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_table_set(s : ImagefeaturebriefTable, i : Int, v : Double) -> ImagefeaturebriefTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_sum(s : ImagefeaturebriefTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_table_mean(s : ImagefeaturebriefTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_table_scale(s : ImagefeaturebriefTable, f : Double) -> ImagefeaturebriefTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_add(a : ImagefeaturebriefTable, b : ImagefeaturebriefTable) -> ImagefeaturebriefTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_table_copy(s : ImagefeaturebriefTable) -> ImagefeaturebriefTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_fill(s : ImagefeaturebriefTable, v : Double) -> ImagefeaturebriefTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_min(s : ImagefeaturebriefTable) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_table_max(s : ImagefeaturebriefTable) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_table_to_string(s : ImagefeaturebriefTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_graphn_make(size : Int) -> ImagefeaturebriefGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_graphn_len(s : ImagefeaturebriefGraphN) -> Int { s.size }

pub fn image_feature_brief_graphn_get(s : ImagefeaturebriefGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_graphn_set(s : ImagefeaturebriefGraphN, i : Int, v : Double) -> ImagefeaturebriefGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_sum(s : ImagefeaturebriefGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_graphn_mean(s : ImagefeaturebriefGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_graphn_scale(s : ImagefeaturebriefGraphN, f : Double) -> ImagefeaturebriefGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_add(a : ImagefeaturebriefGraphN, b : ImagefeaturebriefGraphN) -> ImagefeaturebriefGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_graphn_copy(s : ImagefeaturebriefGraphN) -> ImagefeaturebriefGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_fill(s : ImagefeaturebriefGraphN, v : Double) -> ImagefeaturebriefGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_min(s : ImagefeaturebriefGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_graphn_max(s : ImagefeaturebriefGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_graphn_to_string(s : ImagefeaturebriefGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_node_make(size : Int) -> ImagefeaturebriefNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_node_len(s : ImagefeaturebriefNode) -> Int { s.size }

pub fn image_feature_brief_node_get(s : ImagefeaturebriefNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_node_set(s : ImagefeaturebriefNode, i : Int, v : Double) -> ImagefeaturebriefNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_sum(s : ImagefeaturebriefNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_node_mean(s : ImagefeaturebriefNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_node_scale(s : ImagefeaturebriefNode, f : Double) -> ImagefeaturebriefNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_add(a : ImagefeaturebriefNode, b : ImagefeaturebriefNode) -> ImagefeaturebriefNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_node_copy(s : ImagefeaturebriefNode) -> ImagefeaturebriefNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_fill(s : ImagefeaturebriefNode, v : Double) -> ImagefeaturebriefNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_min(s : ImagefeaturebriefNode) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_node_max(s : ImagefeaturebriefNode) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_node_to_string(s : ImagefeaturebriefNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_edge_make(size : Int) -> ImagefeaturebriefEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_edge_len(s : ImagefeaturebriefEdge) -> Int { s.size }

pub fn image_feature_brief_edge_get(s : ImagefeaturebriefEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_edge_set(s : ImagefeaturebriefEdge, i : Int, v : Double) -> ImagefeaturebriefEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_sum(s : ImagefeaturebriefEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_edge_mean(s : ImagefeaturebriefEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_edge_scale(s : ImagefeaturebriefEdge, f : Double) -> ImagefeaturebriefEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_add(a : ImagefeaturebriefEdge, b : ImagefeaturebriefEdge) -> ImagefeaturebriefEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_edge_copy(s : ImagefeaturebriefEdge) -> ImagefeaturebriefEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_fill(s : ImagefeaturebriefEdge, v : Double) -> ImagefeaturebriefEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_min(s : ImagefeaturebriefEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_edge_max(s : ImagefeaturebriefEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_edge_to_string(s : ImagefeaturebriefEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_path_make(size : Int) -> ImagefeaturebriefPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_path_len(s : ImagefeaturebriefPath) -> Int { s.size }

pub fn image_feature_brief_path_get(s : ImagefeaturebriefPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_path_set(s : ImagefeaturebriefPath, i : Int, v : Double) -> ImagefeaturebriefPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_sum(s : ImagefeaturebriefPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_path_mean(s : ImagefeaturebriefPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_path_scale(s : ImagefeaturebriefPath, f : Double) -> ImagefeaturebriefPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_add(a : ImagefeaturebriefPath, b : ImagefeaturebriefPath) -> ImagefeaturebriefPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_path_copy(s : ImagefeaturebriefPath) -> ImagefeaturebriefPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_fill(s : ImagefeaturebriefPath, v : Double) -> ImagefeaturebriefPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_min(s : ImagefeaturebriefPath) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_path_max(s : ImagefeaturebriefPath) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_path_to_string(s : ImagefeaturebriefPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_cluster_make(size : Int) -> ImagefeaturebriefCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_cluster_len(s : ImagefeaturebriefCluster) -> Int { s.size }

pub fn image_feature_brief_cluster_get(s : ImagefeaturebriefCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_cluster_set(s : ImagefeaturebriefCluster, i : Int, v : Double) -> ImagefeaturebriefCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_sum(s : ImagefeaturebriefCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_cluster_mean(s : ImagefeaturebriefCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_cluster_scale(s : ImagefeaturebriefCluster, f : Double) -> ImagefeaturebriefCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_add(a : ImagefeaturebriefCluster, b : ImagefeaturebriefCluster) -> ImagefeaturebriefCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_cluster_copy(s : ImagefeaturebriefCluster) -> ImagefeaturebriefCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_fill(s : ImagefeaturebriefCluster, v : Double) -> ImagefeaturebriefCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_min(s : ImagefeaturebriefCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_cluster_max(s : ImagefeaturebriefCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_cluster_to_string(s : ImagefeaturebriefCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_model_make(size : Int) -> ImagefeaturebriefModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_model_len(s : ImagefeaturebriefModel) -> Int { s.size }

pub fn image_feature_brief_model_get(s : ImagefeaturebriefModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_model_set(s : ImagefeaturebriefModel, i : Int, v : Double) -> ImagefeaturebriefModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_sum(s : ImagefeaturebriefModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_model_mean(s : ImagefeaturebriefModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_model_scale(s : ImagefeaturebriefModel, f : Double) -> ImagefeaturebriefModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_add(a : ImagefeaturebriefModel, b : ImagefeaturebriefModel) -> ImagefeaturebriefModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_model_copy(s : ImagefeaturebriefModel) -> ImagefeaturebriefModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_fill(s : ImagefeaturebriefModel, v : Double) -> ImagefeaturebriefModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_min(s : ImagefeaturebriefModel) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_model_max(s : ImagefeaturebriefModel) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_model_to_string(s : ImagefeaturebriefModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_layer_make(size : Int) -> ImagefeaturebriefLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_layer_len(s : ImagefeaturebriefLayer) -> Int { s.size }

pub fn image_feature_brief_layer_get(s : ImagefeaturebriefLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_layer_set(s : ImagefeaturebriefLayer, i : Int, v : Double) -> ImagefeaturebriefLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_sum(s : ImagefeaturebriefLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_layer_mean(s : ImagefeaturebriefLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_layer_scale(s : ImagefeaturebriefLayer, f : Double) -> ImagefeaturebriefLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_add(a : ImagefeaturebriefLayer, b : ImagefeaturebriefLayer) -> ImagefeaturebriefLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_layer_copy(s : ImagefeaturebriefLayer) -> ImagefeaturebriefLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_fill(s : ImagefeaturebriefLayer, v : Double) -> ImagefeaturebriefLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_min(s : ImagefeaturebriefLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_layer_max(s : ImagefeaturebriefLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_layer_to_string(s : ImagefeaturebriefLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_buffer_make(size : Int) -> ImagefeaturebriefBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_buffer_len(s : ImagefeaturebriefBuffer) -> Int { s.size }

pub fn image_feature_brief_buffer_get(s : ImagefeaturebriefBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_buffer_set(s : ImagefeaturebriefBuffer, i : Int, v : Double) -> ImagefeaturebriefBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_sum(s : ImagefeaturebriefBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_buffer_mean(s : ImagefeaturebriefBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_buffer_scale(s : ImagefeaturebriefBuffer, f : Double) -> ImagefeaturebriefBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_add(a : ImagefeaturebriefBuffer, b : ImagefeaturebriefBuffer) -> ImagefeaturebriefBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_buffer_copy(s : ImagefeaturebriefBuffer) -> ImagefeaturebriefBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_fill(s : ImagefeaturebriefBuffer, v : Double) -> ImagefeaturebriefBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_min(s : ImagefeaturebriefBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_buffer_max(s : ImagefeaturebriefBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_buffer_to_string(s : ImagefeaturebriefBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_cursor_make(size : Int) -> ImagefeaturebriefCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_cursor_len(s : ImagefeaturebriefCursor) -> Int { s.size }

pub fn image_feature_brief_cursor_get(s : ImagefeaturebriefCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_cursor_set(s : ImagefeaturebriefCursor, i : Int, v : Double) -> ImagefeaturebriefCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_sum(s : ImagefeaturebriefCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_cursor_mean(s : ImagefeaturebriefCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_cursor_scale(s : ImagefeaturebriefCursor, f : Double) -> ImagefeaturebriefCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_add(a : ImagefeaturebriefCursor, b : ImagefeaturebriefCursor) -> ImagefeaturebriefCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_cursor_copy(s : ImagefeaturebriefCursor) -> ImagefeaturebriefCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_fill(s : ImagefeaturebriefCursor, v : Double) -> ImagefeaturebriefCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_min(s : ImagefeaturebriefCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_cursor_max(s : ImagefeaturebriefCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_cursor_to_string(s : ImagefeaturebriefCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_view_make(size : Int) -> ImagefeaturebriefView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_view_len(s : ImagefeaturebriefView) -> Int { s.size }

pub fn image_feature_brief_view_get(s : ImagefeaturebriefView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_view_set(s : ImagefeaturebriefView, i : Int, v : Double) -> ImagefeaturebriefView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_sum(s : ImagefeaturebriefView) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_view_mean(s : ImagefeaturebriefView) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_view_scale(s : ImagefeaturebriefView, f : Double) -> ImagefeaturebriefView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_add(a : ImagefeaturebriefView, b : ImagefeaturebriefView) -> ImagefeaturebriefView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_view_copy(s : ImagefeaturebriefView) -> ImagefeaturebriefView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_fill(s : ImagefeaturebriefView, v : Double) -> ImagefeaturebriefView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_min(s : ImagefeaturebriefView) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_view_max(s : ImagefeaturebriefView) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_view_to_string(s : ImagefeaturebriefView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_range_make(size : Int) -> ImagefeaturebriefRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_range_len(s : ImagefeaturebriefRange) -> Int { s.size }

pub fn image_feature_brief_range_get(s : ImagefeaturebriefRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_range_set(s : ImagefeaturebriefRange, i : Int, v : Double) -> ImagefeaturebriefRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_sum(s : ImagefeaturebriefRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_range_mean(s : ImagefeaturebriefRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_range_scale(s : ImagefeaturebriefRange, f : Double) -> ImagefeaturebriefRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_add(a : ImagefeaturebriefRange, b : ImagefeaturebriefRange) -> ImagefeaturebriefRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_range_copy(s : ImagefeaturebriefRange) -> ImagefeaturebriefRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_fill(s : ImagefeaturebriefRange, v : Double) -> ImagefeaturebriefRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_min(s : ImagefeaturebriefRange) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_range_max(s : ImagefeaturebriefRange) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_range_to_string(s : ImagefeaturebriefRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_slice_make(size : Int) -> ImagefeaturebriefSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_slice_len(s : ImagefeaturebriefSlice) -> Int { s.size }

pub fn image_feature_brief_slice_get(s : ImagefeaturebriefSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_slice_set(s : ImagefeaturebriefSlice, i : Int, v : Double) -> ImagefeaturebriefSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_sum(s : ImagefeaturebriefSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_slice_mean(s : ImagefeaturebriefSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_slice_scale(s : ImagefeaturebriefSlice, f : Double) -> ImagefeaturebriefSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_add(a : ImagefeaturebriefSlice, b : ImagefeaturebriefSlice) -> ImagefeaturebriefSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_slice_copy(s : ImagefeaturebriefSlice) -> ImagefeaturebriefSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_fill(s : ImagefeaturebriefSlice, v : Double) -> ImagefeaturebriefSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_min(s : ImagefeaturebriefSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_slice_max(s : ImagefeaturebriefSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_slice_to_string(s : ImagefeaturebriefSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

