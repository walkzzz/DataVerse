///===
/// extcore/image_transform_affine

pub(all) struct ImagetransformaffinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_affine_make_point(x : Double, y : Double) -> ImagetransformaffinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_affine_make_point3(x : Double, y : Double, z : Double) -> ImagetransformaffinePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformaffinePoint::x(self : ImagetransformaffinePoint) -> Double { self.x }

pub fn ImagetransformaffinePoint::y(self : ImagetransformaffinePoint) -> Double { self.y }

pub fn ImagetransformaffinePoint::z(self : ImagetransformaffinePoint) -> Double { self.z }

pub fn ImagetransformaffinePoint::label(self : ImagetransformaffinePoint) -> Int { self.label }

pub fn ImagetransformaffinePoint::dist(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformaffinePoint::add(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformaffinePoint::sub(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformaffinePoint::scale(self : ImagetransformaffinePoint, s : Double) -> ImagetransformaffinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformaffinePoint::dot(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformaffinePoint::cross(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformaffinePoint::norm(self : ImagetransformaffinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformaffinePoint::normalize(self : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformaffinePoint::negate(self : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformaffinePoint::mid(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformaffinePoint::lerp(self : ImagetransformaffinePoint, other : ImagetransformaffinePoint, t : Double) -> ImagetransformaffinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformaffinePoint::to_string(self : ImagetransformaffinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformaffineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_affine_make_series(vals : Array[Double], name : String) -> ImagetransformaffineSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformaffineSeries::len(self : ImagetransformaffineSeries) -> Int { self.vals.length() }

pub fn ImagetransformaffineSeries::sum(self : ImagetransformaffineSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformaffineSeries::mean(self : ImagetransformaffineSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformaffineSeries::min(self : ImagetransformaffineSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformaffineSeries::max(self : ImagetransformaffineSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformaffineSeries::range(self : ImagetransformaffineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformaffineSeries::variance(self : ImagetransformaffineSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformaffineSeries::std(self : ImagetransformaffineSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformaffineSeries::median(self : ImagetransformaffineSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformaffineSeries::scale(self : ImagetransformaffineSeries, f : Double) -> ImagetransformaffineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformaffineSeries::add(self : ImagetransformaffineSeries, other : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformaffineSeries::sub(self : ImagetransformaffineSeries, other : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformaffineSeries::normalize(self : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformaffineSeries::cumsum(self : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformaffineSeries::to_string(self : ImagetransformaffineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformaffineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_affine_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformaffineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_affine_matrix_identity(n : Int) -> ImagetransformaffineMatrix {
  let m = image_transform_affine_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformaffineMatrix::get(self : ImagetransformaffineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformaffineMatrix::transpose(self : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  let result = image_transform_affine_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformaffineMatrix::add(self : ImagetransformaffineMatrix, other : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_affine_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformaffineMatrix::scale(self : ImagetransformaffineMatrix, s : Double) -> ImagetransformaffineMatrix {
  let result = image_transform_affine_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformaffineMatrix::multiply(self : ImagetransformaffineMatrix, other : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  if self.cols != other.rows { return image_transform_affine_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_affine_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformaffineMatrix::trace(self : ImagetransformaffineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformaffineMatrix::det(self : ImagetransformaffineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformaffineMatrix::norm(self : ImagetransformaffineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformaffineMatrix::to_string(self : ImagetransformaffineMatrix) -> String {
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

pub(all) struct ImagetransformaffineVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_affine_make_vector(comps : Array[Double]) -> ImagetransformaffineVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_affine_vector_zero(dim : Int) -> ImagetransformaffineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformaffineVector::add(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformaffineVector::sub(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformaffineVector::scale(self : ImagetransformaffineVector, s : Double) -> ImagetransformaffineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformaffineVector::dot(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformaffineVector::norm(self : ImagetransformaffineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformaffineVector::normalize(self : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformaffineVector::dist(self : ImagetransformaffineVector, other : ImagetransformaffineVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformaffineVector::to_string(self : ImagetransformaffineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_affine_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_affine_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_affine_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_affine_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_affine_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_affine_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_affine_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_affine_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_affine_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_affine_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_affine_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_affine_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_affine_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_affine_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_affine_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_affine_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_affine_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_affine_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_affine_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_affine_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_affine_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_affine_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_affine_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_affine_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_affine_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_affine_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_affine_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_affine_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_affine_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformaffineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_frame_make(size : Int) -> ImagetransformaffineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_frame_len(s : ImagetransformaffineFrame) -> Int { s.size }

pub fn image_transform_affine_frame_get(s : ImagetransformaffineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_frame_set(s : ImagetransformaffineFrame, i : Int, v : Double) -> ImagetransformaffineFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_frame_sum(s : ImagetransformaffineFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_frame_mean(s : ImagetransformaffineFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_frame_scale(s : ImagetransformaffineFrame, f : Double) -> ImagetransformaffineFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_frame_add(a : ImagetransformaffineFrame, b : ImagetransformaffineFrame) -> ImagetransformaffineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_frame_copy(s : ImagetransformaffineFrame) -> ImagetransformaffineFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_frame_fill(s : ImagetransformaffineFrame, v : Double) -> ImagetransformaffineFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_frame_min(s : ImagetransformaffineFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_frame_max(s : ImagetransformaffineFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_frame_to_string(s : ImagetransformaffineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_table_make(size : Int) -> ImagetransformaffineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_table_len(s : ImagetransformaffineTable) -> Int { s.size }

pub fn image_transform_affine_table_get(s : ImagetransformaffineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_table_set(s : ImagetransformaffineTable, i : Int, v : Double) -> ImagetransformaffineTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_table_sum(s : ImagetransformaffineTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_table_mean(s : ImagetransformaffineTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_table_scale(s : ImagetransformaffineTable, f : Double) -> ImagetransformaffineTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_table_add(a : ImagetransformaffineTable, b : ImagetransformaffineTable) -> ImagetransformaffineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_table_copy(s : ImagetransformaffineTable) -> ImagetransformaffineTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_table_fill(s : ImagetransformaffineTable, v : Double) -> ImagetransformaffineTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_table_min(s : ImagetransformaffineTable) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_table_max(s : ImagetransformaffineTable) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_table_to_string(s : ImagetransformaffineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_graphn_make(size : Int) -> ImagetransformaffineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_graphn_len(s : ImagetransformaffineGraphN) -> Int { s.size }

pub fn image_transform_affine_graphn_get(s : ImagetransformaffineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_graphn_set(s : ImagetransformaffineGraphN, i : Int, v : Double) -> ImagetransformaffineGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_graphn_sum(s : ImagetransformaffineGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_graphn_mean(s : ImagetransformaffineGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_graphn_scale(s : ImagetransformaffineGraphN, f : Double) -> ImagetransformaffineGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_graphn_add(a : ImagetransformaffineGraphN, b : ImagetransformaffineGraphN) -> ImagetransformaffineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_graphn_copy(s : ImagetransformaffineGraphN) -> ImagetransformaffineGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_graphn_fill(s : ImagetransformaffineGraphN, v : Double) -> ImagetransformaffineGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_graphn_min(s : ImagetransformaffineGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_graphn_max(s : ImagetransformaffineGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_graphn_to_string(s : ImagetransformaffineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_node_make(size : Int) -> ImagetransformaffineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_node_len(s : ImagetransformaffineNode) -> Int { s.size }

pub fn image_transform_affine_node_get(s : ImagetransformaffineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_node_set(s : ImagetransformaffineNode, i : Int, v : Double) -> ImagetransformaffineNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_node_sum(s : ImagetransformaffineNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_node_mean(s : ImagetransformaffineNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_node_scale(s : ImagetransformaffineNode, f : Double) -> ImagetransformaffineNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_node_add(a : ImagetransformaffineNode, b : ImagetransformaffineNode) -> ImagetransformaffineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_node_copy(s : ImagetransformaffineNode) -> ImagetransformaffineNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_node_fill(s : ImagetransformaffineNode, v : Double) -> ImagetransformaffineNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_node_min(s : ImagetransformaffineNode) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_node_max(s : ImagetransformaffineNode) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_node_to_string(s : ImagetransformaffineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_edge_make(size : Int) -> ImagetransformaffineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_edge_len(s : ImagetransformaffineEdge) -> Int { s.size }

pub fn image_transform_affine_edge_get(s : ImagetransformaffineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_edge_set(s : ImagetransformaffineEdge, i : Int, v : Double) -> ImagetransformaffineEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_edge_sum(s : ImagetransformaffineEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_edge_mean(s : ImagetransformaffineEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_edge_scale(s : ImagetransformaffineEdge, f : Double) -> ImagetransformaffineEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_edge_add(a : ImagetransformaffineEdge, b : ImagetransformaffineEdge) -> ImagetransformaffineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_edge_copy(s : ImagetransformaffineEdge) -> ImagetransformaffineEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_edge_fill(s : ImagetransformaffineEdge, v : Double) -> ImagetransformaffineEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_edge_min(s : ImagetransformaffineEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_edge_max(s : ImagetransformaffineEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_edge_to_string(s : ImagetransformaffineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_path_make(size : Int) -> ImagetransformaffinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_path_len(s : ImagetransformaffinePath) -> Int { s.size }

pub fn image_transform_affine_path_get(s : ImagetransformaffinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_path_set(s : ImagetransformaffinePath, i : Int, v : Double) -> ImagetransformaffinePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_path_sum(s : ImagetransformaffinePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_path_mean(s : ImagetransformaffinePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_path_scale(s : ImagetransformaffinePath, f : Double) -> ImagetransformaffinePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_path_add(a : ImagetransformaffinePath, b : ImagetransformaffinePath) -> ImagetransformaffinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_path_copy(s : ImagetransformaffinePath) -> ImagetransformaffinePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_path_fill(s : ImagetransformaffinePath, v : Double) -> ImagetransformaffinePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_path_min(s : ImagetransformaffinePath) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_path_max(s : ImagetransformaffinePath) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_path_to_string(s : ImagetransformaffinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_cluster_make(size : Int) -> ImagetransformaffineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_cluster_len(s : ImagetransformaffineCluster) -> Int { s.size }

pub fn image_transform_affine_cluster_get(s : ImagetransformaffineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_cluster_set(s : ImagetransformaffineCluster, i : Int, v : Double) -> ImagetransformaffineCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cluster_sum(s : ImagetransformaffineCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_cluster_mean(s : ImagetransformaffineCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_cluster_scale(s : ImagetransformaffineCluster, f : Double) -> ImagetransformaffineCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cluster_add(a : ImagetransformaffineCluster, b : ImagetransformaffineCluster) -> ImagetransformaffineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_cluster_copy(s : ImagetransformaffineCluster) -> ImagetransformaffineCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cluster_fill(s : ImagetransformaffineCluster, v : Double) -> ImagetransformaffineCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cluster_min(s : ImagetransformaffineCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_cluster_max(s : ImagetransformaffineCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_cluster_to_string(s : ImagetransformaffineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_model_make(size : Int) -> ImagetransformaffineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_model_len(s : ImagetransformaffineModel) -> Int { s.size }

pub fn image_transform_affine_model_get(s : ImagetransformaffineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_model_set(s : ImagetransformaffineModel, i : Int, v : Double) -> ImagetransformaffineModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_model_sum(s : ImagetransformaffineModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_model_mean(s : ImagetransformaffineModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_model_scale(s : ImagetransformaffineModel, f : Double) -> ImagetransformaffineModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_model_add(a : ImagetransformaffineModel, b : ImagetransformaffineModel) -> ImagetransformaffineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_model_copy(s : ImagetransformaffineModel) -> ImagetransformaffineModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_model_fill(s : ImagetransformaffineModel, v : Double) -> ImagetransformaffineModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_model_min(s : ImagetransformaffineModel) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_model_max(s : ImagetransformaffineModel) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_model_to_string(s : ImagetransformaffineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_layer_make(size : Int) -> ImagetransformaffineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_layer_len(s : ImagetransformaffineLayer) -> Int { s.size }

pub fn image_transform_affine_layer_get(s : ImagetransformaffineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_layer_set(s : ImagetransformaffineLayer, i : Int, v : Double) -> ImagetransformaffineLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_layer_sum(s : ImagetransformaffineLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_layer_mean(s : ImagetransformaffineLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_layer_scale(s : ImagetransformaffineLayer, f : Double) -> ImagetransformaffineLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_layer_add(a : ImagetransformaffineLayer, b : ImagetransformaffineLayer) -> ImagetransformaffineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_layer_copy(s : ImagetransformaffineLayer) -> ImagetransformaffineLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_layer_fill(s : ImagetransformaffineLayer, v : Double) -> ImagetransformaffineLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_layer_min(s : ImagetransformaffineLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_layer_max(s : ImagetransformaffineLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_layer_to_string(s : ImagetransformaffineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_buffer_make(size : Int) -> ImagetransformaffineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_buffer_len(s : ImagetransformaffineBuffer) -> Int { s.size }

pub fn image_transform_affine_buffer_get(s : ImagetransformaffineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_buffer_set(s : ImagetransformaffineBuffer, i : Int, v : Double) -> ImagetransformaffineBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_buffer_sum(s : ImagetransformaffineBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_buffer_mean(s : ImagetransformaffineBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_buffer_scale(s : ImagetransformaffineBuffer, f : Double) -> ImagetransformaffineBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_buffer_add(a : ImagetransformaffineBuffer, b : ImagetransformaffineBuffer) -> ImagetransformaffineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_buffer_copy(s : ImagetransformaffineBuffer) -> ImagetransformaffineBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_buffer_fill(s : ImagetransformaffineBuffer, v : Double) -> ImagetransformaffineBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_buffer_min(s : ImagetransformaffineBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_buffer_max(s : ImagetransformaffineBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_buffer_to_string(s : ImagetransformaffineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_cursor_make(size : Int) -> ImagetransformaffineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_cursor_len(s : ImagetransformaffineCursor) -> Int { s.size }

pub fn image_transform_affine_cursor_get(s : ImagetransformaffineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_cursor_set(s : ImagetransformaffineCursor, i : Int, v : Double) -> ImagetransformaffineCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cursor_sum(s : ImagetransformaffineCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_cursor_mean(s : ImagetransformaffineCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_cursor_scale(s : ImagetransformaffineCursor, f : Double) -> ImagetransformaffineCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cursor_add(a : ImagetransformaffineCursor, b : ImagetransformaffineCursor) -> ImagetransformaffineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_cursor_copy(s : ImagetransformaffineCursor) -> ImagetransformaffineCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cursor_fill(s : ImagetransformaffineCursor, v : Double) -> ImagetransformaffineCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_cursor_min(s : ImagetransformaffineCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_cursor_max(s : ImagetransformaffineCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_cursor_to_string(s : ImagetransformaffineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_view_make(size : Int) -> ImagetransformaffineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_view_len(s : ImagetransformaffineView) -> Int { s.size }

pub fn image_transform_affine_view_get(s : ImagetransformaffineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_view_set(s : ImagetransformaffineView, i : Int, v : Double) -> ImagetransformaffineView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_view_sum(s : ImagetransformaffineView) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_view_mean(s : ImagetransformaffineView) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_view_scale(s : ImagetransformaffineView, f : Double) -> ImagetransformaffineView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_view_add(a : ImagetransformaffineView, b : ImagetransformaffineView) -> ImagetransformaffineView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_view_copy(s : ImagetransformaffineView) -> ImagetransformaffineView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_view_fill(s : ImagetransformaffineView, v : Double) -> ImagetransformaffineView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_view_min(s : ImagetransformaffineView) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_view_max(s : ImagetransformaffineView) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_view_to_string(s : ImagetransformaffineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_range_make(size : Int) -> ImagetransformaffineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_range_len(s : ImagetransformaffineRange) -> Int { s.size }

pub fn image_transform_affine_range_get(s : ImagetransformaffineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_range_set(s : ImagetransformaffineRange, i : Int, v : Double) -> ImagetransformaffineRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_range_sum(s : ImagetransformaffineRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_range_mean(s : ImagetransformaffineRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_range_scale(s : ImagetransformaffineRange, f : Double) -> ImagetransformaffineRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_range_add(a : ImagetransformaffineRange, b : ImagetransformaffineRange) -> ImagetransformaffineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_range_copy(s : ImagetransformaffineRange) -> ImagetransformaffineRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_range_fill(s : ImagetransformaffineRange, v : Double) -> ImagetransformaffineRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_range_min(s : ImagetransformaffineRange) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_range_max(s : ImagetransformaffineRange) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_range_to_string(s : ImagetransformaffineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_slice_make(size : Int) -> ImagetransformaffineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_slice_len(s : ImagetransformaffineSlice) -> Int { s.size }

pub fn image_transform_affine_slice_get(s : ImagetransformaffineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_slice_set(s : ImagetransformaffineSlice, i : Int, v : Double) -> ImagetransformaffineSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_affine_slice_sum(s : ImagetransformaffineSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_affine_slice_mean(s : ImagetransformaffineSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_affine_slice_scale(s : ImagetransformaffineSlice, f : Double) -> ImagetransformaffineSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_slice_add(a : ImagetransformaffineSlice, b : ImagetransformaffineSlice) -> ImagetransformaffineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_affine_slice_copy(s : ImagetransformaffineSlice) -> ImagetransformaffineSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_slice_fill(s : ImagetransformaffineSlice, v : Double) -> ImagetransformaffineSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_affine_slice_min(s : ImagetransformaffineSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_affine_slice_max(s : ImagetransformaffineSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_affine_slice_to_string(s : ImagetransformaffineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

