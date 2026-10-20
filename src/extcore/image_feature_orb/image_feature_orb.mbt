///===
/// extcore/image_feature_orb

pub(all) struct ImagefeatureorbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_orb_make_point(x : Double, y : Double) -> ImagefeatureorbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_orb_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureorbPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeatureorbPoint::x(self : ImagefeatureorbPoint) -> Double { self.x }

pub fn ImagefeatureorbPoint::y(self : ImagefeatureorbPoint) -> Double { self.y }

pub fn ImagefeatureorbPoint::z(self : ImagefeatureorbPoint) -> Double { self.z }

pub fn ImagefeatureorbPoint::label(self : ImagefeatureorbPoint) -> Int { self.label }

pub fn ImagefeatureorbPoint::dist(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeatureorbPoint::add(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeatureorbPoint::sub(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeatureorbPoint::scale(self : ImagefeatureorbPoint, s : Double) -> ImagefeatureorbPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeatureorbPoint::dot(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeatureorbPoint::cross(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeatureorbPoint::norm(self : ImagefeatureorbPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeatureorbPoint::normalize(self : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureorbPoint::negate(self : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeatureorbPoint::mid(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeatureorbPoint::lerp(self : ImagefeatureorbPoint, other : ImagefeatureorbPoint, t : Double) -> ImagefeatureorbPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeatureorbPoint::to_string(self : ImagefeatureorbPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeatureorbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_orb_make_series(vals : Array[Double], name : String) -> ImagefeatureorbSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeatureorbSeries::len(self : ImagefeatureorbSeries) -> Int { self.vals.length() }

pub fn ImagefeatureorbSeries::sum(self : ImagefeatureorbSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeatureorbSeries::mean(self : ImagefeatureorbSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeatureorbSeries::min(self : ImagefeatureorbSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeatureorbSeries::max(self : ImagefeatureorbSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeatureorbSeries::range(self : ImagefeatureorbSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeatureorbSeries::variance(self : ImagefeatureorbSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeatureorbSeries::std(self : ImagefeatureorbSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeatureorbSeries::median(self : ImagefeatureorbSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeatureorbSeries::scale(self : ImagefeatureorbSeries, f : Double) -> ImagefeatureorbSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeatureorbSeries::add(self : ImagefeatureorbSeries, other : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeatureorbSeries::sub(self : ImagefeatureorbSeries, other : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeatureorbSeries::normalize(self : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeatureorbSeries::cumsum(self : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeatureorbSeries::to_string(self : ImagefeatureorbSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureorbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_orb_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureorbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_orb_matrix_identity(n : Int) -> ImagefeatureorbMatrix {
  let m = image_feature_orb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeatureorbMatrix::get(self : ImagefeatureorbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeatureorbMatrix::transpose(self : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  let result = image_feature_orb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeatureorbMatrix::add(self : ImagefeatureorbMatrix, other : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_orb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeatureorbMatrix::scale(self : ImagefeatureorbMatrix, s : Double) -> ImagefeatureorbMatrix {
  let result = image_feature_orb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeatureorbMatrix::multiply(self : ImagefeatureorbMatrix, other : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  if self.cols != other.rows { return image_feature_orb_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_orb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeatureorbMatrix::trace(self : ImagefeatureorbMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeatureorbMatrix::det(self : ImagefeatureorbMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeatureorbMatrix::norm(self : ImagefeatureorbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeatureorbMatrix::to_string(self : ImagefeatureorbMatrix) -> String {
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

pub(all) struct ImagefeatureorbVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_orb_make_vector(comps : Array[Double]) -> ImagefeatureorbVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_orb_vector_zero(dim : Int) -> ImagefeatureorbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeatureorbVector::add(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureorbVector::sub(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureorbVector::scale(self : ImagefeatureorbVector, s : Double) -> ImagefeatureorbVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeatureorbVector::dot(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeatureorbVector::norm(self : ImagefeatureorbVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeatureorbVector::normalize(self : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureorbVector::dist(self : ImagefeatureorbVector, other : ImagefeatureorbVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeatureorbVector::to_string(self : ImagefeatureorbVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_orb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_orb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_orb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_orb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_orb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_orb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_orb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_orb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_orb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_orb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_orb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_orb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_orb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_orb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_orb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_orb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_orb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_orb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_orb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_orb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_orb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_orb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_orb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_orb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_orb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_orb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_orb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_orb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_orb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeatureorbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_frame_make(size : Int) -> ImagefeatureorbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_frame_len(s : ImagefeatureorbFrame) -> Int { s.size }

pub fn image_feature_orb_frame_get(s : ImagefeatureorbFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_frame_set(s : ImagefeatureorbFrame, i : Int, v : Double) -> ImagefeatureorbFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_frame_sum(s : ImagefeatureorbFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_frame_mean(s : ImagefeatureorbFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_frame_scale(s : ImagefeatureorbFrame, f : Double) -> ImagefeatureorbFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_frame_add(a : ImagefeatureorbFrame, b : ImagefeatureorbFrame) -> ImagefeatureorbFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_frame_copy(s : ImagefeatureorbFrame) -> ImagefeatureorbFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_frame_fill(s : ImagefeatureorbFrame, v : Double) -> ImagefeatureorbFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_frame_min(s : ImagefeatureorbFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_frame_max(s : ImagefeatureorbFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_frame_to_string(s : ImagefeatureorbFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_table_make(size : Int) -> ImagefeatureorbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_table_len(s : ImagefeatureorbTable) -> Int { s.size }

pub fn image_feature_orb_table_get(s : ImagefeatureorbTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_table_set(s : ImagefeatureorbTable, i : Int, v : Double) -> ImagefeatureorbTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_table_sum(s : ImagefeatureorbTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_table_mean(s : ImagefeatureorbTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_table_scale(s : ImagefeatureorbTable, f : Double) -> ImagefeatureorbTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_table_add(a : ImagefeatureorbTable, b : ImagefeatureorbTable) -> ImagefeatureorbTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_table_copy(s : ImagefeatureorbTable) -> ImagefeatureorbTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_table_fill(s : ImagefeatureorbTable, v : Double) -> ImagefeatureorbTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_table_min(s : ImagefeatureorbTable) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_table_max(s : ImagefeatureorbTable) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_table_to_string(s : ImagefeatureorbTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_graphn_make(size : Int) -> ImagefeatureorbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_graphn_len(s : ImagefeatureorbGraphN) -> Int { s.size }

pub fn image_feature_orb_graphn_get(s : ImagefeatureorbGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_graphn_set(s : ImagefeatureorbGraphN, i : Int, v : Double) -> ImagefeatureorbGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_graphn_sum(s : ImagefeatureorbGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_graphn_mean(s : ImagefeatureorbGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_graphn_scale(s : ImagefeatureorbGraphN, f : Double) -> ImagefeatureorbGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_graphn_add(a : ImagefeatureorbGraphN, b : ImagefeatureorbGraphN) -> ImagefeatureorbGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_graphn_copy(s : ImagefeatureorbGraphN) -> ImagefeatureorbGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_graphn_fill(s : ImagefeatureorbGraphN, v : Double) -> ImagefeatureorbGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_graphn_min(s : ImagefeatureorbGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_graphn_max(s : ImagefeatureorbGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_graphn_to_string(s : ImagefeatureorbGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_node_make(size : Int) -> ImagefeatureorbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_node_len(s : ImagefeatureorbNode) -> Int { s.size }

pub fn image_feature_orb_node_get(s : ImagefeatureorbNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_node_set(s : ImagefeatureorbNode, i : Int, v : Double) -> ImagefeatureorbNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_node_sum(s : ImagefeatureorbNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_node_mean(s : ImagefeatureorbNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_node_scale(s : ImagefeatureorbNode, f : Double) -> ImagefeatureorbNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_node_add(a : ImagefeatureorbNode, b : ImagefeatureorbNode) -> ImagefeatureorbNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_node_copy(s : ImagefeatureorbNode) -> ImagefeatureorbNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_node_fill(s : ImagefeatureorbNode, v : Double) -> ImagefeatureorbNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_node_min(s : ImagefeatureorbNode) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_node_max(s : ImagefeatureorbNode) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_node_to_string(s : ImagefeatureorbNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_edge_make(size : Int) -> ImagefeatureorbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_edge_len(s : ImagefeatureorbEdge) -> Int { s.size }

pub fn image_feature_orb_edge_get(s : ImagefeatureorbEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_edge_set(s : ImagefeatureorbEdge, i : Int, v : Double) -> ImagefeatureorbEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_edge_sum(s : ImagefeatureorbEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_edge_mean(s : ImagefeatureorbEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_edge_scale(s : ImagefeatureorbEdge, f : Double) -> ImagefeatureorbEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_edge_add(a : ImagefeatureorbEdge, b : ImagefeatureorbEdge) -> ImagefeatureorbEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_edge_copy(s : ImagefeatureorbEdge) -> ImagefeatureorbEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_edge_fill(s : ImagefeatureorbEdge, v : Double) -> ImagefeatureorbEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_edge_min(s : ImagefeatureorbEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_edge_max(s : ImagefeatureorbEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_edge_to_string(s : ImagefeatureorbEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_path_make(size : Int) -> ImagefeatureorbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_path_len(s : ImagefeatureorbPath) -> Int { s.size }

pub fn image_feature_orb_path_get(s : ImagefeatureorbPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_path_set(s : ImagefeatureorbPath, i : Int, v : Double) -> ImagefeatureorbPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_path_sum(s : ImagefeatureorbPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_path_mean(s : ImagefeatureorbPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_path_scale(s : ImagefeatureorbPath, f : Double) -> ImagefeatureorbPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_path_add(a : ImagefeatureorbPath, b : ImagefeatureorbPath) -> ImagefeatureorbPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_path_copy(s : ImagefeatureorbPath) -> ImagefeatureorbPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_path_fill(s : ImagefeatureorbPath, v : Double) -> ImagefeatureorbPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_path_min(s : ImagefeatureorbPath) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_path_max(s : ImagefeatureorbPath) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_path_to_string(s : ImagefeatureorbPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_cluster_make(size : Int) -> ImagefeatureorbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_cluster_len(s : ImagefeatureorbCluster) -> Int { s.size }

pub fn image_feature_orb_cluster_get(s : ImagefeatureorbCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_cluster_set(s : ImagefeatureorbCluster, i : Int, v : Double) -> ImagefeatureorbCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cluster_sum(s : ImagefeatureorbCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_cluster_mean(s : ImagefeatureorbCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_cluster_scale(s : ImagefeatureorbCluster, f : Double) -> ImagefeatureorbCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cluster_add(a : ImagefeatureorbCluster, b : ImagefeatureorbCluster) -> ImagefeatureorbCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_cluster_copy(s : ImagefeatureorbCluster) -> ImagefeatureorbCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cluster_fill(s : ImagefeatureorbCluster, v : Double) -> ImagefeatureorbCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cluster_min(s : ImagefeatureorbCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_cluster_max(s : ImagefeatureorbCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_cluster_to_string(s : ImagefeatureorbCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_model_make(size : Int) -> ImagefeatureorbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_model_len(s : ImagefeatureorbModel) -> Int { s.size }

pub fn image_feature_orb_model_get(s : ImagefeatureorbModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_model_set(s : ImagefeatureorbModel, i : Int, v : Double) -> ImagefeatureorbModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_model_sum(s : ImagefeatureorbModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_model_mean(s : ImagefeatureorbModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_model_scale(s : ImagefeatureorbModel, f : Double) -> ImagefeatureorbModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_model_add(a : ImagefeatureorbModel, b : ImagefeatureorbModel) -> ImagefeatureorbModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_model_copy(s : ImagefeatureorbModel) -> ImagefeatureorbModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_model_fill(s : ImagefeatureorbModel, v : Double) -> ImagefeatureorbModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_model_min(s : ImagefeatureorbModel) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_model_max(s : ImagefeatureorbModel) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_model_to_string(s : ImagefeatureorbModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_layer_make(size : Int) -> ImagefeatureorbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_layer_len(s : ImagefeatureorbLayer) -> Int { s.size }

pub fn image_feature_orb_layer_get(s : ImagefeatureorbLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_layer_set(s : ImagefeatureorbLayer, i : Int, v : Double) -> ImagefeatureorbLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_layer_sum(s : ImagefeatureorbLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_layer_mean(s : ImagefeatureorbLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_layer_scale(s : ImagefeatureorbLayer, f : Double) -> ImagefeatureorbLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_layer_add(a : ImagefeatureorbLayer, b : ImagefeatureorbLayer) -> ImagefeatureorbLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_layer_copy(s : ImagefeatureorbLayer) -> ImagefeatureorbLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_layer_fill(s : ImagefeatureorbLayer, v : Double) -> ImagefeatureorbLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_layer_min(s : ImagefeatureorbLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_layer_max(s : ImagefeatureorbLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_layer_to_string(s : ImagefeatureorbLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_buffer_make(size : Int) -> ImagefeatureorbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_buffer_len(s : ImagefeatureorbBuffer) -> Int { s.size }

pub fn image_feature_orb_buffer_get(s : ImagefeatureorbBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_buffer_set(s : ImagefeatureorbBuffer, i : Int, v : Double) -> ImagefeatureorbBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_buffer_sum(s : ImagefeatureorbBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_buffer_mean(s : ImagefeatureorbBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_buffer_scale(s : ImagefeatureorbBuffer, f : Double) -> ImagefeatureorbBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_buffer_add(a : ImagefeatureorbBuffer, b : ImagefeatureorbBuffer) -> ImagefeatureorbBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_buffer_copy(s : ImagefeatureorbBuffer) -> ImagefeatureorbBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_buffer_fill(s : ImagefeatureorbBuffer, v : Double) -> ImagefeatureorbBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_buffer_min(s : ImagefeatureorbBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_buffer_max(s : ImagefeatureorbBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_buffer_to_string(s : ImagefeatureorbBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_cursor_make(size : Int) -> ImagefeatureorbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_cursor_len(s : ImagefeatureorbCursor) -> Int { s.size }

pub fn image_feature_orb_cursor_get(s : ImagefeatureorbCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_cursor_set(s : ImagefeatureorbCursor, i : Int, v : Double) -> ImagefeatureorbCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cursor_sum(s : ImagefeatureorbCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_cursor_mean(s : ImagefeatureorbCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_cursor_scale(s : ImagefeatureorbCursor, f : Double) -> ImagefeatureorbCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cursor_add(a : ImagefeatureorbCursor, b : ImagefeatureorbCursor) -> ImagefeatureorbCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_cursor_copy(s : ImagefeatureorbCursor) -> ImagefeatureorbCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cursor_fill(s : ImagefeatureorbCursor, v : Double) -> ImagefeatureorbCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_cursor_min(s : ImagefeatureorbCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_cursor_max(s : ImagefeatureorbCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_cursor_to_string(s : ImagefeatureorbCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_view_make(size : Int) -> ImagefeatureorbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_view_len(s : ImagefeatureorbView) -> Int { s.size }

pub fn image_feature_orb_view_get(s : ImagefeatureorbView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_view_set(s : ImagefeatureorbView, i : Int, v : Double) -> ImagefeatureorbView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_view_sum(s : ImagefeatureorbView) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_view_mean(s : ImagefeatureorbView) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_view_scale(s : ImagefeatureorbView, f : Double) -> ImagefeatureorbView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_view_add(a : ImagefeatureorbView, b : ImagefeatureorbView) -> ImagefeatureorbView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_view_copy(s : ImagefeatureorbView) -> ImagefeatureorbView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_view_fill(s : ImagefeatureorbView, v : Double) -> ImagefeatureorbView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_view_min(s : ImagefeatureorbView) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_view_max(s : ImagefeatureorbView) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_view_to_string(s : ImagefeatureorbView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_range_make(size : Int) -> ImagefeatureorbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_range_len(s : ImagefeatureorbRange) -> Int { s.size }

pub fn image_feature_orb_range_get(s : ImagefeatureorbRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_range_set(s : ImagefeatureorbRange, i : Int, v : Double) -> ImagefeatureorbRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_range_sum(s : ImagefeatureorbRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_range_mean(s : ImagefeatureorbRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_range_scale(s : ImagefeatureorbRange, f : Double) -> ImagefeatureorbRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_range_add(a : ImagefeatureorbRange, b : ImagefeatureorbRange) -> ImagefeatureorbRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_range_copy(s : ImagefeatureorbRange) -> ImagefeatureorbRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_range_fill(s : ImagefeatureorbRange, v : Double) -> ImagefeatureorbRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_range_min(s : ImagefeatureorbRange) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_range_max(s : ImagefeatureorbRange) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_range_to_string(s : ImagefeatureorbRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_slice_make(size : Int) -> ImagefeatureorbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_slice_len(s : ImagefeatureorbSlice) -> Int { s.size }

pub fn image_feature_orb_slice_get(s : ImagefeatureorbSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_slice_set(s : ImagefeatureorbSlice, i : Int, v : Double) -> ImagefeatureorbSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_orb_slice_sum(s : ImagefeatureorbSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_orb_slice_mean(s : ImagefeatureorbSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_orb_slice_scale(s : ImagefeatureorbSlice, f : Double) -> ImagefeatureorbSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_slice_add(a : ImagefeatureorbSlice, b : ImagefeatureorbSlice) -> ImagefeatureorbSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_orb_slice_copy(s : ImagefeatureorbSlice) -> ImagefeatureorbSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_slice_fill(s : ImagefeatureorbSlice, v : Double) -> ImagefeatureorbSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_orb_slice_min(s : ImagefeatureorbSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_orb_slice_max(s : ImagefeatureorbSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_orb_slice_to_string(s : ImagefeatureorbSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

