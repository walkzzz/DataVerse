///===
/// extcore/image_transform_shear

pub(all) struct ImagetransformshearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_shear_make_point(x : Double, y : Double) -> ImagetransformshearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_shear_make_point3(x : Double, y : Double, z : Double) -> ImagetransformshearPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformshearPoint::x(self : ImagetransformshearPoint) -> Double { self.x }

pub fn ImagetransformshearPoint::y(self : ImagetransformshearPoint) -> Double { self.y }

pub fn ImagetransformshearPoint::z(self : ImagetransformshearPoint) -> Double { self.z }

pub fn ImagetransformshearPoint::label(self : ImagetransformshearPoint) -> Int { self.label }

pub fn ImagetransformshearPoint::dist(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformshearPoint::add(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformshearPoint::sub(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformshearPoint::scale(self : ImagetransformshearPoint, s : Double) -> ImagetransformshearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformshearPoint::dot(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformshearPoint::cross(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformshearPoint::norm(self : ImagetransformshearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformshearPoint::normalize(self : ImagetransformshearPoint) -> ImagetransformshearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformshearPoint::negate(self : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformshearPoint::mid(self : ImagetransformshearPoint, other : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformshearPoint::lerp(self : ImagetransformshearPoint, other : ImagetransformshearPoint, t : Double) -> ImagetransformshearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformshearPoint::to_string(self : ImagetransformshearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformshearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_shear_make_series(vals : Array[Double], name : String) -> ImagetransformshearSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformshearSeries::len(self : ImagetransformshearSeries) -> Int { self.vals.length() }

pub fn ImagetransformshearSeries::sum(self : ImagetransformshearSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformshearSeries::mean(self : ImagetransformshearSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformshearSeries::min(self : ImagetransformshearSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformshearSeries::max(self : ImagetransformshearSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformshearSeries::range(self : ImagetransformshearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformshearSeries::variance(self : ImagetransformshearSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformshearSeries::std(self : ImagetransformshearSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformshearSeries::median(self : ImagetransformshearSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformshearSeries::scale(self : ImagetransformshearSeries, f : Double) -> ImagetransformshearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformshearSeries::add(self : ImagetransformshearSeries, other : ImagetransformshearSeries) -> ImagetransformshearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformshearSeries::sub(self : ImagetransformshearSeries, other : ImagetransformshearSeries) -> ImagetransformshearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformshearSeries::normalize(self : ImagetransformshearSeries) -> ImagetransformshearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformshearSeries::cumsum(self : ImagetransformshearSeries) -> ImagetransformshearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformshearSeries::to_string(self : ImagetransformshearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformshearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_shear_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformshearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_shear_matrix_identity(n : Int) -> ImagetransformshearMatrix {
  let m = image_transform_shear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformshearMatrix::get(self : ImagetransformshearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformshearMatrix::transpose(self : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  let result = image_transform_shear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformshearMatrix::add(self : ImagetransformshearMatrix, other : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_shear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformshearMatrix::scale(self : ImagetransformshearMatrix, s : Double) -> ImagetransformshearMatrix {
  let result = image_transform_shear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformshearMatrix::multiply(self : ImagetransformshearMatrix, other : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  if self.cols != other.rows { return image_transform_shear_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_shear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformshearMatrix::trace(self : ImagetransformshearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformshearMatrix::det(self : ImagetransformshearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformshearMatrix::norm(self : ImagetransformshearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformshearMatrix::to_string(self : ImagetransformshearMatrix) -> String {
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

pub(all) struct ImagetransformshearVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_shear_make_vector(comps : Array[Double]) -> ImagetransformshearVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_shear_vector_zero(dim : Int) -> ImagetransformshearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformshearVector::add(self : ImagetransformshearVector, other : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformshearVector::sub(self : ImagetransformshearVector, other : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformshearVector::scale(self : ImagetransformshearVector, s : Double) -> ImagetransformshearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformshearVector::dot(self : ImagetransformshearVector, other : ImagetransformshearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformshearVector::norm(self : ImagetransformshearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformshearVector::normalize(self : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformshearVector::dist(self : ImagetransformshearVector, other : ImagetransformshearVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformshearVector::to_string(self : ImagetransformshearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_shear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_shear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_shear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_shear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_shear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_shear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_shear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_shear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_shear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_shear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_shear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_shear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_shear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_shear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_shear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_shear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_shear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_shear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_shear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_shear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_shear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_shear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_shear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_shear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_shear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_shear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_shear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_shear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_shear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformshearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_frame_make(size : Int) -> ImagetransformshearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_frame_len(s : ImagetransformshearFrame) -> Int { s.size }

pub fn image_transform_shear_frame_get(s : ImagetransformshearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_frame_set(s : ImagetransformshearFrame, i : Int, v : Double) -> ImagetransformshearFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_frame_sum(s : ImagetransformshearFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_frame_mean(s : ImagetransformshearFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_frame_scale(s : ImagetransformshearFrame, f : Double) -> ImagetransformshearFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_frame_add(a : ImagetransformshearFrame, b : ImagetransformshearFrame) -> ImagetransformshearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_frame_copy(s : ImagetransformshearFrame) -> ImagetransformshearFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_frame_fill(s : ImagetransformshearFrame, v : Double) -> ImagetransformshearFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_frame_min(s : ImagetransformshearFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_frame_max(s : ImagetransformshearFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_frame_to_string(s : ImagetransformshearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_table_make(size : Int) -> ImagetransformshearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_table_len(s : ImagetransformshearTable) -> Int { s.size }

pub fn image_transform_shear_table_get(s : ImagetransformshearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_table_set(s : ImagetransformshearTable, i : Int, v : Double) -> ImagetransformshearTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_table_sum(s : ImagetransformshearTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_table_mean(s : ImagetransformshearTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_table_scale(s : ImagetransformshearTable, f : Double) -> ImagetransformshearTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_table_add(a : ImagetransformshearTable, b : ImagetransformshearTable) -> ImagetransformshearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_table_copy(s : ImagetransformshearTable) -> ImagetransformshearTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_table_fill(s : ImagetransformshearTable, v : Double) -> ImagetransformshearTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_table_min(s : ImagetransformshearTable) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_table_max(s : ImagetransformshearTable) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_table_to_string(s : ImagetransformshearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_graphn_make(size : Int) -> ImagetransformshearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_graphn_len(s : ImagetransformshearGraphN) -> Int { s.size }

pub fn image_transform_shear_graphn_get(s : ImagetransformshearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_graphn_set(s : ImagetransformshearGraphN, i : Int, v : Double) -> ImagetransformshearGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_graphn_sum(s : ImagetransformshearGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_graphn_mean(s : ImagetransformshearGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_graphn_scale(s : ImagetransformshearGraphN, f : Double) -> ImagetransformshearGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_graphn_add(a : ImagetransformshearGraphN, b : ImagetransformshearGraphN) -> ImagetransformshearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_graphn_copy(s : ImagetransformshearGraphN) -> ImagetransformshearGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_graphn_fill(s : ImagetransformshearGraphN, v : Double) -> ImagetransformshearGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_graphn_min(s : ImagetransformshearGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_graphn_max(s : ImagetransformshearGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_graphn_to_string(s : ImagetransformshearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_node_make(size : Int) -> ImagetransformshearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_node_len(s : ImagetransformshearNode) -> Int { s.size }

pub fn image_transform_shear_node_get(s : ImagetransformshearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_node_set(s : ImagetransformshearNode, i : Int, v : Double) -> ImagetransformshearNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_node_sum(s : ImagetransformshearNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_node_mean(s : ImagetransformshearNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_node_scale(s : ImagetransformshearNode, f : Double) -> ImagetransformshearNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_node_add(a : ImagetransformshearNode, b : ImagetransformshearNode) -> ImagetransformshearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_node_copy(s : ImagetransformshearNode) -> ImagetransformshearNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_node_fill(s : ImagetransformshearNode, v : Double) -> ImagetransformshearNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_node_min(s : ImagetransformshearNode) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_node_max(s : ImagetransformshearNode) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_node_to_string(s : ImagetransformshearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_edge_make(size : Int) -> ImagetransformshearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_edge_len(s : ImagetransformshearEdge) -> Int { s.size }

pub fn image_transform_shear_edge_get(s : ImagetransformshearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_edge_set(s : ImagetransformshearEdge, i : Int, v : Double) -> ImagetransformshearEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_edge_sum(s : ImagetransformshearEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_edge_mean(s : ImagetransformshearEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_edge_scale(s : ImagetransformshearEdge, f : Double) -> ImagetransformshearEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_edge_add(a : ImagetransformshearEdge, b : ImagetransformshearEdge) -> ImagetransformshearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_edge_copy(s : ImagetransformshearEdge) -> ImagetransformshearEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_edge_fill(s : ImagetransformshearEdge, v : Double) -> ImagetransformshearEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_edge_min(s : ImagetransformshearEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_edge_max(s : ImagetransformshearEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_edge_to_string(s : ImagetransformshearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_path_make(size : Int) -> ImagetransformshearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_path_len(s : ImagetransformshearPath) -> Int { s.size }

pub fn image_transform_shear_path_get(s : ImagetransformshearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_path_set(s : ImagetransformshearPath, i : Int, v : Double) -> ImagetransformshearPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_path_sum(s : ImagetransformshearPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_path_mean(s : ImagetransformshearPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_path_scale(s : ImagetransformshearPath, f : Double) -> ImagetransformshearPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_path_add(a : ImagetransformshearPath, b : ImagetransformshearPath) -> ImagetransformshearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_path_copy(s : ImagetransformshearPath) -> ImagetransformshearPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_path_fill(s : ImagetransformshearPath, v : Double) -> ImagetransformshearPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_path_min(s : ImagetransformshearPath) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_path_max(s : ImagetransformshearPath) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_path_to_string(s : ImagetransformshearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_cluster_make(size : Int) -> ImagetransformshearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_cluster_len(s : ImagetransformshearCluster) -> Int { s.size }

pub fn image_transform_shear_cluster_get(s : ImagetransformshearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_cluster_set(s : ImagetransformshearCluster, i : Int, v : Double) -> ImagetransformshearCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cluster_sum(s : ImagetransformshearCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_cluster_mean(s : ImagetransformshearCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_cluster_scale(s : ImagetransformshearCluster, f : Double) -> ImagetransformshearCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cluster_add(a : ImagetransformshearCluster, b : ImagetransformshearCluster) -> ImagetransformshearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_cluster_copy(s : ImagetransformshearCluster) -> ImagetransformshearCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cluster_fill(s : ImagetransformshearCluster, v : Double) -> ImagetransformshearCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cluster_min(s : ImagetransformshearCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_cluster_max(s : ImagetransformshearCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_cluster_to_string(s : ImagetransformshearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_model_make(size : Int) -> ImagetransformshearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_model_len(s : ImagetransformshearModel) -> Int { s.size }

pub fn image_transform_shear_model_get(s : ImagetransformshearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_model_set(s : ImagetransformshearModel, i : Int, v : Double) -> ImagetransformshearModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_model_sum(s : ImagetransformshearModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_model_mean(s : ImagetransformshearModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_model_scale(s : ImagetransformshearModel, f : Double) -> ImagetransformshearModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_model_add(a : ImagetransformshearModel, b : ImagetransformshearModel) -> ImagetransformshearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_model_copy(s : ImagetransformshearModel) -> ImagetransformshearModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_model_fill(s : ImagetransformshearModel, v : Double) -> ImagetransformshearModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_model_min(s : ImagetransformshearModel) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_model_max(s : ImagetransformshearModel) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_model_to_string(s : ImagetransformshearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_layer_make(size : Int) -> ImagetransformshearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_layer_len(s : ImagetransformshearLayer) -> Int { s.size }

pub fn image_transform_shear_layer_get(s : ImagetransformshearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_layer_set(s : ImagetransformshearLayer, i : Int, v : Double) -> ImagetransformshearLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_layer_sum(s : ImagetransformshearLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_layer_mean(s : ImagetransformshearLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_layer_scale(s : ImagetransformshearLayer, f : Double) -> ImagetransformshearLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_layer_add(a : ImagetransformshearLayer, b : ImagetransformshearLayer) -> ImagetransformshearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_layer_copy(s : ImagetransformshearLayer) -> ImagetransformshearLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_layer_fill(s : ImagetransformshearLayer, v : Double) -> ImagetransformshearLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_layer_min(s : ImagetransformshearLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_layer_max(s : ImagetransformshearLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_layer_to_string(s : ImagetransformshearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_buffer_make(size : Int) -> ImagetransformshearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_buffer_len(s : ImagetransformshearBuffer) -> Int { s.size }

pub fn image_transform_shear_buffer_get(s : ImagetransformshearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_buffer_set(s : ImagetransformshearBuffer, i : Int, v : Double) -> ImagetransformshearBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_buffer_sum(s : ImagetransformshearBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_buffer_mean(s : ImagetransformshearBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_buffer_scale(s : ImagetransformshearBuffer, f : Double) -> ImagetransformshearBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_buffer_add(a : ImagetransformshearBuffer, b : ImagetransformshearBuffer) -> ImagetransformshearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_buffer_copy(s : ImagetransformshearBuffer) -> ImagetransformshearBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_buffer_fill(s : ImagetransformshearBuffer, v : Double) -> ImagetransformshearBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_buffer_min(s : ImagetransformshearBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_buffer_max(s : ImagetransformshearBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_buffer_to_string(s : ImagetransformshearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_cursor_make(size : Int) -> ImagetransformshearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_cursor_len(s : ImagetransformshearCursor) -> Int { s.size }

pub fn image_transform_shear_cursor_get(s : ImagetransformshearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_cursor_set(s : ImagetransformshearCursor, i : Int, v : Double) -> ImagetransformshearCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cursor_sum(s : ImagetransformshearCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_cursor_mean(s : ImagetransformshearCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_cursor_scale(s : ImagetransformshearCursor, f : Double) -> ImagetransformshearCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cursor_add(a : ImagetransformshearCursor, b : ImagetransformshearCursor) -> ImagetransformshearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_cursor_copy(s : ImagetransformshearCursor) -> ImagetransformshearCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cursor_fill(s : ImagetransformshearCursor, v : Double) -> ImagetransformshearCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_cursor_min(s : ImagetransformshearCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_cursor_max(s : ImagetransformshearCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_cursor_to_string(s : ImagetransformshearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_view_make(size : Int) -> ImagetransformshearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_view_len(s : ImagetransformshearView) -> Int { s.size }

pub fn image_transform_shear_view_get(s : ImagetransformshearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_view_set(s : ImagetransformshearView, i : Int, v : Double) -> ImagetransformshearView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_view_sum(s : ImagetransformshearView) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_view_mean(s : ImagetransformshearView) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_view_scale(s : ImagetransformshearView, f : Double) -> ImagetransformshearView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_view_add(a : ImagetransformshearView, b : ImagetransformshearView) -> ImagetransformshearView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_view_copy(s : ImagetransformshearView) -> ImagetransformshearView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_view_fill(s : ImagetransformshearView, v : Double) -> ImagetransformshearView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_view_min(s : ImagetransformshearView) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_view_max(s : ImagetransformshearView) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_view_to_string(s : ImagetransformshearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_range_make(size : Int) -> ImagetransformshearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_range_len(s : ImagetransformshearRange) -> Int { s.size }

pub fn image_transform_shear_range_get(s : ImagetransformshearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_range_set(s : ImagetransformshearRange, i : Int, v : Double) -> ImagetransformshearRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_range_sum(s : ImagetransformshearRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_range_mean(s : ImagetransformshearRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_range_scale(s : ImagetransformshearRange, f : Double) -> ImagetransformshearRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_range_add(a : ImagetransformshearRange, b : ImagetransformshearRange) -> ImagetransformshearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_range_copy(s : ImagetransformshearRange) -> ImagetransformshearRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_range_fill(s : ImagetransformshearRange, v : Double) -> ImagetransformshearRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_range_min(s : ImagetransformshearRange) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_range_max(s : ImagetransformshearRange) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_range_to_string(s : ImagetransformshearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_slice_make(size : Int) -> ImagetransformshearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_slice_len(s : ImagetransformshearSlice) -> Int { s.size }

pub fn image_transform_shear_slice_get(s : ImagetransformshearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_slice_set(s : ImagetransformshearSlice, i : Int, v : Double) -> ImagetransformshearSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_shear_slice_sum(s : ImagetransformshearSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_shear_slice_mean(s : ImagetransformshearSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_shear_slice_scale(s : ImagetransformshearSlice, f : Double) -> ImagetransformshearSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_slice_add(a : ImagetransformshearSlice, b : ImagetransformshearSlice) -> ImagetransformshearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_shear_slice_copy(s : ImagetransformshearSlice) -> ImagetransformshearSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_slice_fill(s : ImagetransformshearSlice, v : Double) -> ImagetransformshearSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_shear_slice_min(s : ImagetransformshearSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_shear_slice_max(s : ImagetransformshearSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_shear_slice_to_string(s : ImagetransformshearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

