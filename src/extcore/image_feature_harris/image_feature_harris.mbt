///===
/// extcore/image_feature_harris

pub(all) struct ImagefeatureharrisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_harris_make_point(x : Double, y : Double) -> ImagefeatureharrisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_harris_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureharrisPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefeatureharrisPoint::x(self : ImagefeatureharrisPoint) -> Double { self.x }

pub fn ImagefeatureharrisPoint::y(self : ImagefeatureharrisPoint) -> Double { self.y }

pub fn ImagefeatureharrisPoint::z(self : ImagefeatureharrisPoint) -> Double { self.z }

pub fn ImagefeatureharrisPoint::label(self : ImagefeatureharrisPoint) -> Int { self.label }

pub fn ImagefeatureharrisPoint::dist(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefeatureharrisPoint::add(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefeatureharrisPoint::sub(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefeatureharrisPoint::scale(self : ImagefeatureharrisPoint, s : Double) -> ImagefeatureharrisPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefeatureharrisPoint::dot(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefeatureharrisPoint::cross(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefeatureharrisPoint::norm(self : ImagefeatureharrisPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefeatureharrisPoint::normalize(self : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureharrisPoint::negate(self : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefeatureharrisPoint::mid(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefeatureharrisPoint::lerp(self : ImagefeatureharrisPoint, other : ImagefeatureharrisPoint, t : Double) -> ImagefeatureharrisPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefeatureharrisPoint::to_string(self : ImagefeatureharrisPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefeatureharrisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_harris_make_series(vals : Array[Double], name : String) -> ImagefeatureharrisSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefeatureharrisSeries::len(self : ImagefeatureharrisSeries) -> Int { self.vals.length() }

pub fn ImagefeatureharrisSeries::sum(self : ImagefeatureharrisSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefeatureharrisSeries::mean(self : ImagefeatureharrisSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefeatureharrisSeries::min(self : ImagefeatureharrisSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefeatureharrisSeries::max(self : ImagefeatureharrisSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefeatureharrisSeries::range(self : ImagefeatureharrisSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefeatureharrisSeries::variance(self : ImagefeatureharrisSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefeatureharrisSeries::std(self : ImagefeatureharrisSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefeatureharrisSeries::median(self : ImagefeatureharrisSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefeatureharrisSeries::scale(self : ImagefeatureharrisSeries, f : Double) -> ImagefeatureharrisSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefeatureharrisSeries::add(self : ImagefeatureharrisSeries, other : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefeatureharrisSeries::sub(self : ImagefeatureharrisSeries, other : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefeatureharrisSeries::normalize(self : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefeatureharrisSeries::cumsum(self : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefeatureharrisSeries::to_string(self : ImagefeatureharrisSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureharrisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_harris_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureharrisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_harris_matrix_identity(n : Int) -> ImagefeatureharrisMatrix {
  let m = image_feature_harris_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefeatureharrisMatrix::get(self : ImagefeatureharrisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefeatureharrisMatrix::transpose(self : ImagefeatureharrisMatrix) -> ImagefeatureharrisMatrix {
  let result = image_feature_harris_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefeatureharrisMatrix::add(self : ImagefeatureharrisMatrix, other : ImagefeatureharrisMatrix) -> ImagefeatureharrisMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_feature_harris_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefeatureharrisMatrix::scale(self : ImagefeatureharrisMatrix, s : Double) -> ImagefeatureharrisMatrix {
  let result = image_feature_harris_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefeatureharrisMatrix::multiply(self : ImagefeatureharrisMatrix, other : ImagefeatureharrisMatrix) -> ImagefeatureharrisMatrix {
  if self.cols != other.rows { return image_feature_harris_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_feature_harris_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefeatureharrisMatrix::trace(self : ImagefeatureharrisMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefeatureharrisMatrix::det(self : ImagefeatureharrisMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefeatureharrisMatrix::norm(self : ImagefeatureharrisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefeatureharrisMatrix::to_string(self : ImagefeatureharrisMatrix) -> String {
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

pub(all) struct ImagefeatureharrisVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_harris_make_vector(comps : Array[Double]) -> ImagefeatureharrisVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_harris_vector_zero(dim : Int) -> ImagefeatureharrisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefeatureharrisVector::add(self : ImagefeatureharrisVector, other : ImagefeatureharrisVector) -> ImagefeatureharrisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureharrisVector::sub(self : ImagefeatureharrisVector, other : ImagefeatureharrisVector) -> ImagefeatureharrisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefeatureharrisVector::scale(self : ImagefeatureharrisVector, s : Double) -> ImagefeatureharrisVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefeatureharrisVector::dot(self : ImagefeatureharrisVector, other : ImagefeatureharrisVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefeatureharrisVector::norm(self : ImagefeatureharrisVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefeatureharrisVector::normalize(self : ImagefeatureharrisVector) -> ImagefeatureharrisVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefeatureharrisVector::dist(self : ImagefeatureharrisVector, other : ImagefeatureharrisVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefeatureharrisVector::to_string(self : ImagefeatureharrisVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_harris_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_harris_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_harris_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_harris_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_harris_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_harris_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_harris_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_harris_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_harris_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_harris_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_harris_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_harris_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_harris_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_harris_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_harris_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_harris_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_harris_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_harris_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_harris_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_harris_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_harris_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_harris_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_harris_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_harris_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_harris_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_harris_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_harris_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_harris_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_harris_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeatureharrisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_frame_make(size : Int) -> ImagefeatureharrisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_frame_len(s : ImagefeatureharrisFrame) -> Int { s.size }

pub fn image_feature_harris_frame_get(s : ImagefeatureharrisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_frame_set(s : ImagefeatureharrisFrame, i : Int, v : Double) -> ImagefeatureharrisFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_frame_sum(s : ImagefeatureharrisFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_frame_mean(s : ImagefeatureharrisFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_frame_scale(s : ImagefeatureharrisFrame, f : Double) -> ImagefeatureharrisFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_frame_add(a : ImagefeatureharrisFrame, b : ImagefeatureharrisFrame) -> ImagefeatureharrisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_frame_copy(s : ImagefeatureharrisFrame) -> ImagefeatureharrisFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_frame_fill(s : ImagefeatureharrisFrame, v : Double) -> ImagefeatureharrisFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_frame_min(s : ImagefeatureharrisFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_frame_max(s : ImagefeatureharrisFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_frame_to_string(s : ImagefeatureharrisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_table_make(size : Int) -> ImagefeatureharrisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_table_len(s : ImagefeatureharrisTable) -> Int { s.size }

pub fn image_feature_harris_table_get(s : ImagefeatureharrisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_table_set(s : ImagefeatureharrisTable, i : Int, v : Double) -> ImagefeatureharrisTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_table_sum(s : ImagefeatureharrisTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_table_mean(s : ImagefeatureharrisTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_table_scale(s : ImagefeatureharrisTable, f : Double) -> ImagefeatureharrisTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_table_add(a : ImagefeatureharrisTable, b : ImagefeatureharrisTable) -> ImagefeatureharrisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_table_copy(s : ImagefeatureharrisTable) -> ImagefeatureharrisTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_table_fill(s : ImagefeatureharrisTable, v : Double) -> ImagefeatureharrisTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_table_min(s : ImagefeatureharrisTable) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_table_max(s : ImagefeatureharrisTable) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_table_to_string(s : ImagefeatureharrisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_graphn_make(size : Int) -> ImagefeatureharrisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_graphn_len(s : ImagefeatureharrisGraphN) -> Int { s.size }

pub fn image_feature_harris_graphn_get(s : ImagefeatureharrisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_graphn_set(s : ImagefeatureharrisGraphN, i : Int, v : Double) -> ImagefeatureharrisGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_graphn_sum(s : ImagefeatureharrisGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_graphn_mean(s : ImagefeatureharrisGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_graphn_scale(s : ImagefeatureharrisGraphN, f : Double) -> ImagefeatureharrisGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_graphn_add(a : ImagefeatureharrisGraphN, b : ImagefeatureharrisGraphN) -> ImagefeatureharrisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_graphn_copy(s : ImagefeatureharrisGraphN) -> ImagefeatureharrisGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_graphn_fill(s : ImagefeatureharrisGraphN, v : Double) -> ImagefeatureharrisGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_graphn_min(s : ImagefeatureharrisGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_graphn_max(s : ImagefeatureharrisGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_graphn_to_string(s : ImagefeatureharrisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_node_make(size : Int) -> ImagefeatureharrisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_node_len(s : ImagefeatureharrisNode) -> Int { s.size }

pub fn image_feature_harris_node_get(s : ImagefeatureharrisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_node_set(s : ImagefeatureharrisNode, i : Int, v : Double) -> ImagefeatureharrisNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_node_sum(s : ImagefeatureharrisNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_node_mean(s : ImagefeatureharrisNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_node_scale(s : ImagefeatureharrisNode, f : Double) -> ImagefeatureharrisNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_node_add(a : ImagefeatureharrisNode, b : ImagefeatureharrisNode) -> ImagefeatureharrisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_node_copy(s : ImagefeatureharrisNode) -> ImagefeatureharrisNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_node_fill(s : ImagefeatureharrisNode, v : Double) -> ImagefeatureharrisNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_node_min(s : ImagefeatureharrisNode) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_node_max(s : ImagefeatureharrisNode) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_node_to_string(s : ImagefeatureharrisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_edge_make(size : Int) -> ImagefeatureharrisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_edge_len(s : ImagefeatureharrisEdge) -> Int { s.size }

pub fn image_feature_harris_edge_get(s : ImagefeatureharrisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_edge_set(s : ImagefeatureharrisEdge, i : Int, v : Double) -> ImagefeatureharrisEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_edge_sum(s : ImagefeatureharrisEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_edge_mean(s : ImagefeatureharrisEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_edge_scale(s : ImagefeatureharrisEdge, f : Double) -> ImagefeatureharrisEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_edge_add(a : ImagefeatureharrisEdge, b : ImagefeatureharrisEdge) -> ImagefeatureharrisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_edge_copy(s : ImagefeatureharrisEdge) -> ImagefeatureharrisEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_edge_fill(s : ImagefeatureharrisEdge, v : Double) -> ImagefeatureharrisEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_edge_min(s : ImagefeatureharrisEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_edge_max(s : ImagefeatureharrisEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_edge_to_string(s : ImagefeatureharrisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_path_make(size : Int) -> ImagefeatureharrisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_path_len(s : ImagefeatureharrisPath) -> Int { s.size }

pub fn image_feature_harris_path_get(s : ImagefeatureharrisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_path_set(s : ImagefeatureharrisPath, i : Int, v : Double) -> ImagefeatureharrisPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_path_sum(s : ImagefeatureharrisPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_path_mean(s : ImagefeatureharrisPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_path_scale(s : ImagefeatureharrisPath, f : Double) -> ImagefeatureharrisPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_path_add(a : ImagefeatureharrisPath, b : ImagefeatureharrisPath) -> ImagefeatureharrisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_path_copy(s : ImagefeatureharrisPath) -> ImagefeatureharrisPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_path_fill(s : ImagefeatureharrisPath, v : Double) -> ImagefeatureharrisPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_path_min(s : ImagefeatureharrisPath) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_path_max(s : ImagefeatureharrisPath) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_path_to_string(s : ImagefeatureharrisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_cluster_make(size : Int) -> ImagefeatureharrisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_cluster_len(s : ImagefeatureharrisCluster) -> Int { s.size }

pub fn image_feature_harris_cluster_get(s : ImagefeatureharrisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_cluster_set(s : ImagefeatureharrisCluster, i : Int, v : Double) -> ImagefeatureharrisCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cluster_sum(s : ImagefeatureharrisCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_cluster_mean(s : ImagefeatureharrisCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_cluster_scale(s : ImagefeatureharrisCluster, f : Double) -> ImagefeatureharrisCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cluster_add(a : ImagefeatureharrisCluster, b : ImagefeatureharrisCluster) -> ImagefeatureharrisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_cluster_copy(s : ImagefeatureharrisCluster) -> ImagefeatureharrisCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cluster_fill(s : ImagefeatureharrisCluster, v : Double) -> ImagefeatureharrisCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cluster_min(s : ImagefeatureharrisCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_cluster_max(s : ImagefeatureharrisCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_cluster_to_string(s : ImagefeatureharrisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_model_make(size : Int) -> ImagefeatureharrisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_model_len(s : ImagefeatureharrisModel) -> Int { s.size }

pub fn image_feature_harris_model_get(s : ImagefeatureharrisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_model_set(s : ImagefeatureharrisModel, i : Int, v : Double) -> ImagefeatureharrisModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_model_sum(s : ImagefeatureharrisModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_model_mean(s : ImagefeatureharrisModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_model_scale(s : ImagefeatureharrisModel, f : Double) -> ImagefeatureharrisModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_model_add(a : ImagefeatureharrisModel, b : ImagefeatureharrisModel) -> ImagefeatureharrisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_model_copy(s : ImagefeatureharrisModel) -> ImagefeatureharrisModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_model_fill(s : ImagefeatureharrisModel, v : Double) -> ImagefeatureharrisModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_model_min(s : ImagefeatureharrisModel) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_model_max(s : ImagefeatureharrisModel) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_model_to_string(s : ImagefeatureharrisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_layer_make(size : Int) -> ImagefeatureharrisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_layer_len(s : ImagefeatureharrisLayer) -> Int { s.size }

pub fn image_feature_harris_layer_get(s : ImagefeatureharrisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_layer_set(s : ImagefeatureharrisLayer, i : Int, v : Double) -> ImagefeatureharrisLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_layer_sum(s : ImagefeatureharrisLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_layer_mean(s : ImagefeatureharrisLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_layer_scale(s : ImagefeatureharrisLayer, f : Double) -> ImagefeatureharrisLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_layer_add(a : ImagefeatureharrisLayer, b : ImagefeatureharrisLayer) -> ImagefeatureharrisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_layer_copy(s : ImagefeatureharrisLayer) -> ImagefeatureharrisLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_layer_fill(s : ImagefeatureharrisLayer, v : Double) -> ImagefeatureharrisLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_layer_min(s : ImagefeatureharrisLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_layer_max(s : ImagefeatureharrisLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_layer_to_string(s : ImagefeatureharrisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_buffer_make(size : Int) -> ImagefeatureharrisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_buffer_len(s : ImagefeatureharrisBuffer) -> Int { s.size }

pub fn image_feature_harris_buffer_get(s : ImagefeatureharrisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_buffer_set(s : ImagefeatureharrisBuffer, i : Int, v : Double) -> ImagefeatureharrisBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_buffer_sum(s : ImagefeatureharrisBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_buffer_mean(s : ImagefeatureharrisBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_buffer_scale(s : ImagefeatureharrisBuffer, f : Double) -> ImagefeatureharrisBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_buffer_add(a : ImagefeatureharrisBuffer, b : ImagefeatureharrisBuffer) -> ImagefeatureharrisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_buffer_copy(s : ImagefeatureharrisBuffer) -> ImagefeatureharrisBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_buffer_fill(s : ImagefeatureharrisBuffer, v : Double) -> ImagefeatureharrisBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_buffer_min(s : ImagefeatureharrisBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_buffer_max(s : ImagefeatureharrisBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_buffer_to_string(s : ImagefeatureharrisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_cursor_make(size : Int) -> ImagefeatureharrisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_cursor_len(s : ImagefeatureharrisCursor) -> Int { s.size }

pub fn image_feature_harris_cursor_get(s : ImagefeatureharrisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_cursor_set(s : ImagefeatureharrisCursor, i : Int, v : Double) -> ImagefeatureharrisCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cursor_sum(s : ImagefeatureharrisCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_cursor_mean(s : ImagefeatureharrisCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_cursor_scale(s : ImagefeatureharrisCursor, f : Double) -> ImagefeatureharrisCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cursor_add(a : ImagefeatureharrisCursor, b : ImagefeatureharrisCursor) -> ImagefeatureharrisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_cursor_copy(s : ImagefeatureharrisCursor) -> ImagefeatureharrisCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cursor_fill(s : ImagefeatureharrisCursor, v : Double) -> ImagefeatureharrisCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_cursor_min(s : ImagefeatureharrisCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_cursor_max(s : ImagefeatureharrisCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_cursor_to_string(s : ImagefeatureharrisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_view_make(size : Int) -> ImagefeatureharrisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_view_len(s : ImagefeatureharrisView) -> Int { s.size }

pub fn image_feature_harris_view_get(s : ImagefeatureharrisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_view_set(s : ImagefeatureharrisView, i : Int, v : Double) -> ImagefeatureharrisView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_view_sum(s : ImagefeatureharrisView) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_view_mean(s : ImagefeatureharrisView) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_view_scale(s : ImagefeatureharrisView, f : Double) -> ImagefeatureharrisView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_view_add(a : ImagefeatureharrisView, b : ImagefeatureharrisView) -> ImagefeatureharrisView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_view_copy(s : ImagefeatureharrisView) -> ImagefeatureharrisView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_view_fill(s : ImagefeatureharrisView, v : Double) -> ImagefeatureharrisView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_view_min(s : ImagefeatureharrisView) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_view_max(s : ImagefeatureharrisView) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_view_to_string(s : ImagefeatureharrisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_range_make(size : Int) -> ImagefeatureharrisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_range_len(s : ImagefeatureharrisRange) -> Int { s.size }

pub fn image_feature_harris_range_get(s : ImagefeatureharrisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_range_set(s : ImagefeatureharrisRange, i : Int, v : Double) -> ImagefeatureharrisRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_range_sum(s : ImagefeatureharrisRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_range_mean(s : ImagefeatureharrisRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_range_scale(s : ImagefeatureharrisRange, f : Double) -> ImagefeatureharrisRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_range_add(a : ImagefeatureharrisRange, b : ImagefeatureharrisRange) -> ImagefeatureharrisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_range_copy(s : ImagefeatureharrisRange) -> ImagefeatureharrisRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_range_fill(s : ImagefeatureharrisRange, v : Double) -> ImagefeatureharrisRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_range_min(s : ImagefeatureharrisRange) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_range_max(s : ImagefeatureharrisRange) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_range_to_string(s : ImagefeatureharrisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_slice_make(size : Int) -> ImagefeatureharrisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_slice_len(s : ImagefeatureharrisSlice) -> Int { s.size }

pub fn image_feature_harris_slice_get(s : ImagefeatureharrisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_slice_set(s : ImagefeatureharrisSlice, i : Int, v : Double) -> ImagefeatureharrisSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_harris_slice_sum(s : ImagefeatureharrisSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_harris_slice_mean(s : ImagefeatureharrisSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_harris_slice_scale(s : ImagefeatureharrisSlice, f : Double) -> ImagefeatureharrisSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_slice_add(a : ImagefeatureharrisSlice, b : ImagefeatureharrisSlice) -> ImagefeatureharrisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_harris_slice_copy(s : ImagefeatureharrisSlice) -> ImagefeatureharrisSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_slice_fill(s : ImagefeatureharrisSlice, v : Double) -> ImagefeatureharrisSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_harris_slice_min(s : ImagefeatureharrisSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_harris_slice_max(s : ImagefeatureharrisSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_harris_slice_to_string(s : ImagefeatureharrisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

