///===
/// extcore/image_feature_surf

pub(all) struct ImagefeaturesurfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_surf_make_point(x : Double, y : Double) -> ImagefeaturesurfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_surf_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturesurfPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeaturesurfPoint::x(self : ImagefeaturesurfPoint) -> Double { self.x }

pub fn ImagefeaturesurfPoint::y(self : ImagefeaturesurfPoint) -> Double { self.y }

pub fn ImagefeaturesurfPoint::z(self : ImagefeaturesurfPoint) -> Double { self.z }

pub fn ImagefeaturesurfPoint::label(self : ImagefeaturesurfPoint) -> Int { self.label }

pub fn ImagefeaturesurfPoint::dist(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeaturesurfPoint::add(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeaturesurfPoint::sub(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeaturesurfPoint::scale(self : ImagefeaturesurfPoint, s : Double) -> ImagefeaturesurfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeaturesurfPoint::dot(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeaturesurfPoint::cross(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeaturesurfPoint::norm(self : ImagefeaturesurfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeaturesurfPoint::normalize(self : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesurfPoint::negate(self : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeaturesurfPoint::mid(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeaturesurfPoint::lerp(self : ImagefeaturesurfPoint, other : ImagefeaturesurfPoint, t : Double) -> ImagefeaturesurfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeaturesurfPoint::to_string(self : ImagefeaturesurfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeaturesurfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_surf_make_series(vals : Array[Double], name : String) -> ImagefeaturesurfSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeaturesurfSeries::len(self : ImagefeaturesurfSeries) -> Int { self.vals.length() }

pub fn ImagefeaturesurfSeries::sum(self : ImagefeaturesurfSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeaturesurfSeries::mean(self : ImagefeaturesurfSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeaturesurfSeries::min(self : ImagefeaturesurfSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeaturesurfSeries::max(self : ImagefeaturesurfSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeaturesurfSeries::range(self : ImagefeaturesurfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeaturesurfSeries::variance(self : ImagefeaturesurfSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeaturesurfSeries::std(self : ImagefeaturesurfSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeaturesurfSeries::median(self : ImagefeaturesurfSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeaturesurfSeries::scale(self : ImagefeaturesurfSeries, f : Double) -> ImagefeaturesurfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeaturesurfSeries::add(self : ImagefeaturesurfSeries, other : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeaturesurfSeries::sub(self : ImagefeaturesurfSeries, other : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeaturesurfSeries::normalize(self : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeaturesurfSeries::cumsum(self : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeaturesurfSeries::to_string(self : ImagefeaturesurfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesurfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_surf_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturesurfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_surf_matrix_identity(n : Int) -> ImagefeaturesurfMatrix {
  let m = image_feature_surf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeaturesurfMatrix::get(self : ImagefeaturesurfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeaturesurfMatrix::transpose(self : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  let result = image_feature_surf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeaturesurfMatrix::add(self : ImagefeaturesurfMatrix, other : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_surf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeaturesurfMatrix::scale(self : ImagefeaturesurfMatrix, s : Double) -> ImagefeaturesurfMatrix {
  let result = image_feature_surf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeaturesurfMatrix::multiply(self : ImagefeaturesurfMatrix, other : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  if self.cols != other.rows { return image_feature_surf_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_surf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeaturesurfMatrix::trace(self : ImagefeaturesurfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeaturesurfMatrix::det(self : ImagefeaturesurfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeaturesurfMatrix::norm(self : ImagefeaturesurfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeaturesurfMatrix::to_string(self : ImagefeaturesurfMatrix) -> String {
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

pub(all) struct ImagefeaturesurfVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_surf_make_vector(comps : Array[Double]) -> ImagefeaturesurfVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_surf_vector_zero(dim : Int) -> ImagefeaturesurfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeaturesurfVector::add(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesurfVector::sub(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeaturesurfVector::scale(self : ImagefeaturesurfVector, s : Double) -> ImagefeaturesurfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeaturesurfVector::dot(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeaturesurfVector::norm(self : ImagefeaturesurfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeaturesurfVector::normalize(self : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeaturesurfVector::dist(self : ImagefeaturesurfVector, other : ImagefeaturesurfVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeaturesurfVector::to_string(self : ImagefeaturesurfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_surf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_surf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_surf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_surf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_surf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_surf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_surf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_surf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_surf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_surf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_surf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_surf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_surf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_surf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_surf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_surf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_surf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_surf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_surf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_surf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_surf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_surf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_surf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_surf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_surf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_surf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_surf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_surf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_surf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturesurfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_frame_make(size : Int) -> ImagefeaturesurfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_frame_len(s : ImagefeaturesurfFrame) -> Int { s.size }

pub fn image_feature_surf_frame_get(s : ImagefeaturesurfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_frame_set(s : ImagefeaturesurfFrame, i : Int, v : Double) -> ImagefeaturesurfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_frame_sum(s : ImagefeaturesurfFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_frame_mean(s : ImagefeaturesurfFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_frame_scale(s : ImagefeaturesurfFrame, f : Double) -> ImagefeaturesurfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_frame_add(a : ImagefeaturesurfFrame, b : ImagefeaturesurfFrame) -> ImagefeaturesurfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_frame_copy(s : ImagefeaturesurfFrame) -> ImagefeaturesurfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_frame_fill(s : ImagefeaturesurfFrame, v : Double) -> ImagefeaturesurfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_frame_min(s : ImagefeaturesurfFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_frame_max(s : ImagefeaturesurfFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_frame_to_string(s : ImagefeaturesurfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_table_make(size : Int) -> ImagefeaturesurfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_table_len(s : ImagefeaturesurfTable) -> Int { s.size }

pub fn image_feature_surf_table_get(s : ImagefeaturesurfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_table_set(s : ImagefeaturesurfTable, i : Int, v : Double) -> ImagefeaturesurfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_table_sum(s : ImagefeaturesurfTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_table_mean(s : ImagefeaturesurfTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_table_scale(s : ImagefeaturesurfTable, f : Double) -> ImagefeaturesurfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_table_add(a : ImagefeaturesurfTable, b : ImagefeaturesurfTable) -> ImagefeaturesurfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_table_copy(s : ImagefeaturesurfTable) -> ImagefeaturesurfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_table_fill(s : ImagefeaturesurfTable, v : Double) -> ImagefeaturesurfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_table_min(s : ImagefeaturesurfTable) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_table_max(s : ImagefeaturesurfTable) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_table_to_string(s : ImagefeaturesurfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_graphn_make(size : Int) -> ImagefeaturesurfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_graphn_len(s : ImagefeaturesurfGraphN) -> Int { s.size }

pub fn image_feature_surf_graphn_get(s : ImagefeaturesurfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_graphn_set(s : ImagefeaturesurfGraphN, i : Int, v : Double) -> ImagefeaturesurfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_graphn_sum(s : ImagefeaturesurfGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_graphn_mean(s : ImagefeaturesurfGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_graphn_scale(s : ImagefeaturesurfGraphN, f : Double) -> ImagefeaturesurfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_graphn_add(a : ImagefeaturesurfGraphN, b : ImagefeaturesurfGraphN) -> ImagefeaturesurfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_graphn_copy(s : ImagefeaturesurfGraphN) -> ImagefeaturesurfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_graphn_fill(s : ImagefeaturesurfGraphN, v : Double) -> ImagefeaturesurfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_graphn_min(s : ImagefeaturesurfGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_graphn_max(s : ImagefeaturesurfGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_graphn_to_string(s : ImagefeaturesurfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_node_make(size : Int) -> ImagefeaturesurfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_node_len(s : ImagefeaturesurfNode) -> Int { s.size }

pub fn image_feature_surf_node_get(s : ImagefeaturesurfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_node_set(s : ImagefeaturesurfNode, i : Int, v : Double) -> ImagefeaturesurfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_node_sum(s : ImagefeaturesurfNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_node_mean(s : ImagefeaturesurfNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_node_scale(s : ImagefeaturesurfNode, f : Double) -> ImagefeaturesurfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_node_add(a : ImagefeaturesurfNode, b : ImagefeaturesurfNode) -> ImagefeaturesurfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_node_copy(s : ImagefeaturesurfNode) -> ImagefeaturesurfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_node_fill(s : ImagefeaturesurfNode, v : Double) -> ImagefeaturesurfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_node_min(s : ImagefeaturesurfNode) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_node_max(s : ImagefeaturesurfNode) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_node_to_string(s : ImagefeaturesurfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_edge_make(size : Int) -> ImagefeaturesurfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_edge_len(s : ImagefeaturesurfEdge) -> Int { s.size }

pub fn image_feature_surf_edge_get(s : ImagefeaturesurfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_edge_set(s : ImagefeaturesurfEdge, i : Int, v : Double) -> ImagefeaturesurfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_edge_sum(s : ImagefeaturesurfEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_edge_mean(s : ImagefeaturesurfEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_edge_scale(s : ImagefeaturesurfEdge, f : Double) -> ImagefeaturesurfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_edge_add(a : ImagefeaturesurfEdge, b : ImagefeaturesurfEdge) -> ImagefeaturesurfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_edge_copy(s : ImagefeaturesurfEdge) -> ImagefeaturesurfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_edge_fill(s : ImagefeaturesurfEdge, v : Double) -> ImagefeaturesurfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_edge_min(s : ImagefeaturesurfEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_edge_max(s : ImagefeaturesurfEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_edge_to_string(s : ImagefeaturesurfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_path_make(size : Int) -> ImagefeaturesurfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_path_len(s : ImagefeaturesurfPath) -> Int { s.size }

pub fn image_feature_surf_path_get(s : ImagefeaturesurfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_path_set(s : ImagefeaturesurfPath, i : Int, v : Double) -> ImagefeaturesurfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_path_sum(s : ImagefeaturesurfPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_path_mean(s : ImagefeaturesurfPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_path_scale(s : ImagefeaturesurfPath, f : Double) -> ImagefeaturesurfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_path_add(a : ImagefeaturesurfPath, b : ImagefeaturesurfPath) -> ImagefeaturesurfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_path_copy(s : ImagefeaturesurfPath) -> ImagefeaturesurfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_path_fill(s : ImagefeaturesurfPath, v : Double) -> ImagefeaturesurfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_path_min(s : ImagefeaturesurfPath) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_path_max(s : ImagefeaturesurfPath) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_path_to_string(s : ImagefeaturesurfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_cluster_make(size : Int) -> ImagefeaturesurfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_cluster_len(s : ImagefeaturesurfCluster) -> Int { s.size }

pub fn image_feature_surf_cluster_get(s : ImagefeaturesurfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_cluster_set(s : ImagefeaturesurfCluster, i : Int, v : Double) -> ImagefeaturesurfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cluster_sum(s : ImagefeaturesurfCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_cluster_mean(s : ImagefeaturesurfCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_cluster_scale(s : ImagefeaturesurfCluster, f : Double) -> ImagefeaturesurfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cluster_add(a : ImagefeaturesurfCluster, b : ImagefeaturesurfCluster) -> ImagefeaturesurfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_cluster_copy(s : ImagefeaturesurfCluster) -> ImagefeaturesurfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cluster_fill(s : ImagefeaturesurfCluster, v : Double) -> ImagefeaturesurfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cluster_min(s : ImagefeaturesurfCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_cluster_max(s : ImagefeaturesurfCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_cluster_to_string(s : ImagefeaturesurfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_model_make(size : Int) -> ImagefeaturesurfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_model_len(s : ImagefeaturesurfModel) -> Int { s.size }

pub fn image_feature_surf_model_get(s : ImagefeaturesurfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_model_set(s : ImagefeaturesurfModel, i : Int, v : Double) -> ImagefeaturesurfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_model_sum(s : ImagefeaturesurfModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_model_mean(s : ImagefeaturesurfModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_model_scale(s : ImagefeaturesurfModel, f : Double) -> ImagefeaturesurfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_model_add(a : ImagefeaturesurfModel, b : ImagefeaturesurfModel) -> ImagefeaturesurfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_model_copy(s : ImagefeaturesurfModel) -> ImagefeaturesurfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_model_fill(s : ImagefeaturesurfModel, v : Double) -> ImagefeaturesurfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_model_min(s : ImagefeaturesurfModel) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_model_max(s : ImagefeaturesurfModel) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_model_to_string(s : ImagefeaturesurfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_layer_make(size : Int) -> ImagefeaturesurfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_layer_len(s : ImagefeaturesurfLayer) -> Int { s.size }

pub fn image_feature_surf_layer_get(s : ImagefeaturesurfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_layer_set(s : ImagefeaturesurfLayer, i : Int, v : Double) -> ImagefeaturesurfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_layer_sum(s : ImagefeaturesurfLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_layer_mean(s : ImagefeaturesurfLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_layer_scale(s : ImagefeaturesurfLayer, f : Double) -> ImagefeaturesurfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_layer_add(a : ImagefeaturesurfLayer, b : ImagefeaturesurfLayer) -> ImagefeaturesurfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_layer_copy(s : ImagefeaturesurfLayer) -> ImagefeaturesurfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_layer_fill(s : ImagefeaturesurfLayer, v : Double) -> ImagefeaturesurfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_layer_min(s : ImagefeaturesurfLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_layer_max(s : ImagefeaturesurfLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_layer_to_string(s : ImagefeaturesurfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_buffer_make(size : Int) -> ImagefeaturesurfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_buffer_len(s : ImagefeaturesurfBuffer) -> Int { s.size }

pub fn image_feature_surf_buffer_get(s : ImagefeaturesurfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_buffer_set(s : ImagefeaturesurfBuffer, i : Int, v : Double) -> ImagefeaturesurfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_buffer_sum(s : ImagefeaturesurfBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_buffer_mean(s : ImagefeaturesurfBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_buffer_scale(s : ImagefeaturesurfBuffer, f : Double) -> ImagefeaturesurfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_buffer_add(a : ImagefeaturesurfBuffer, b : ImagefeaturesurfBuffer) -> ImagefeaturesurfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_buffer_copy(s : ImagefeaturesurfBuffer) -> ImagefeaturesurfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_buffer_fill(s : ImagefeaturesurfBuffer, v : Double) -> ImagefeaturesurfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_buffer_min(s : ImagefeaturesurfBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_buffer_max(s : ImagefeaturesurfBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_buffer_to_string(s : ImagefeaturesurfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_cursor_make(size : Int) -> ImagefeaturesurfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_cursor_len(s : ImagefeaturesurfCursor) -> Int { s.size }

pub fn image_feature_surf_cursor_get(s : ImagefeaturesurfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_cursor_set(s : ImagefeaturesurfCursor, i : Int, v : Double) -> ImagefeaturesurfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cursor_sum(s : ImagefeaturesurfCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_cursor_mean(s : ImagefeaturesurfCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_cursor_scale(s : ImagefeaturesurfCursor, f : Double) -> ImagefeaturesurfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cursor_add(a : ImagefeaturesurfCursor, b : ImagefeaturesurfCursor) -> ImagefeaturesurfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_cursor_copy(s : ImagefeaturesurfCursor) -> ImagefeaturesurfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cursor_fill(s : ImagefeaturesurfCursor, v : Double) -> ImagefeaturesurfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_cursor_min(s : ImagefeaturesurfCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_cursor_max(s : ImagefeaturesurfCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_cursor_to_string(s : ImagefeaturesurfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_view_make(size : Int) -> ImagefeaturesurfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_view_len(s : ImagefeaturesurfView) -> Int { s.size }

pub fn image_feature_surf_view_get(s : ImagefeaturesurfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_view_set(s : ImagefeaturesurfView, i : Int, v : Double) -> ImagefeaturesurfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_view_sum(s : ImagefeaturesurfView) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_view_mean(s : ImagefeaturesurfView) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_view_scale(s : ImagefeaturesurfView, f : Double) -> ImagefeaturesurfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_view_add(a : ImagefeaturesurfView, b : ImagefeaturesurfView) -> ImagefeaturesurfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_view_copy(s : ImagefeaturesurfView) -> ImagefeaturesurfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_view_fill(s : ImagefeaturesurfView, v : Double) -> ImagefeaturesurfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_view_min(s : ImagefeaturesurfView) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_view_max(s : ImagefeaturesurfView) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_view_to_string(s : ImagefeaturesurfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_range_make(size : Int) -> ImagefeaturesurfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_range_len(s : ImagefeaturesurfRange) -> Int { s.size }

pub fn image_feature_surf_range_get(s : ImagefeaturesurfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_range_set(s : ImagefeaturesurfRange, i : Int, v : Double) -> ImagefeaturesurfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_range_sum(s : ImagefeaturesurfRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_range_mean(s : ImagefeaturesurfRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_range_scale(s : ImagefeaturesurfRange, f : Double) -> ImagefeaturesurfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_range_add(a : ImagefeaturesurfRange, b : ImagefeaturesurfRange) -> ImagefeaturesurfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_range_copy(s : ImagefeaturesurfRange) -> ImagefeaturesurfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_range_fill(s : ImagefeaturesurfRange, v : Double) -> ImagefeaturesurfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_range_min(s : ImagefeaturesurfRange) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_range_max(s : ImagefeaturesurfRange) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_range_to_string(s : ImagefeaturesurfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_slice_make(size : Int) -> ImagefeaturesurfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_slice_len(s : ImagefeaturesurfSlice) -> Int { s.size }

pub fn image_feature_surf_slice_get(s : ImagefeaturesurfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_slice_set(s : ImagefeaturesurfSlice, i : Int, v : Double) -> ImagefeaturesurfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_surf_slice_sum(s : ImagefeaturesurfSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_surf_slice_mean(s : ImagefeaturesurfSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_surf_slice_scale(s : ImagefeaturesurfSlice, f : Double) -> ImagefeaturesurfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_slice_add(a : ImagefeaturesurfSlice, b : ImagefeaturesurfSlice) -> ImagefeaturesurfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_surf_slice_copy(s : ImagefeaturesurfSlice) -> ImagefeaturesurfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_slice_fill(s : ImagefeaturesurfSlice, v : Double) -> ImagefeaturesurfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_surf_slice_min(s : ImagefeaturesurfSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_surf_slice_max(s : ImagefeaturesurfSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_surf_slice_to_string(s : ImagefeaturesurfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

