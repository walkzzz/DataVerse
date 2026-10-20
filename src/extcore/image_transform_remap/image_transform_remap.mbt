///===
/// extcore/image_transform_remap

pub(all) struct ImagetransformremapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_remap_make_point(x : Double, y : Double) -> ImagetransformremapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_remap_make_point3(x : Double, y : Double, z : Double) -> ImagetransformremapPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformremapPoint::x(self : ImagetransformremapPoint) -> Double { self.x }

pub fn ImagetransformremapPoint::y(self : ImagetransformremapPoint) -> Double { self.y }

pub fn ImagetransformremapPoint::z(self : ImagetransformremapPoint) -> Double { self.z }

pub fn ImagetransformremapPoint::label(self : ImagetransformremapPoint) -> Int { self.label }

pub fn ImagetransformremapPoint::dist(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformremapPoint::add(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformremapPoint::sub(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformremapPoint::scale(self : ImagetransformremapPoint, s : Double) -> ImagetransformremapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformremapPoint::dot(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformremapPoint::cross(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformremapPoint::norm(self : ImagetransformremapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformremapPoint::normalize(self : ImagetransformremapPoint) -> ImagetransformremapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformremapPoint::negate(self : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformremapPoint::mid(self : ImagetransformremapPoint, other : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformremapPoint::lerp(self : ImagetransformremapPoint, other : ImagetransformremapPoint, t : Double) -> ImagetransformremapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformremapPoint::to_string(self : ImagetransformremapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformremapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_remap_make_series(vals : Array[Double], name : String) -> ImagetransformremapSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformremapSeries::len(self : ImagetransformremapSeries) -> Int { self.vals.length() }

pub fn ImagetransformremapSeries::sum(self : ImagetransformremapSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformremapSeries::mean(self : ImagetransformremapSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformremapSeries::min(self : ImagetransformremapSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformremapSeries::max(self : ImagetransformremapSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformremapSeries::range(self : ImagetransformremapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformremapSeries::variance(self : ImagetransformremapSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformremapSeries::std(self : ImagetransformremapSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformremapSeries::median(self : ImagetransformremapSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformremapSeries::scale(self : ImagetransformremapSeries, f : Double) -> ImagetransformremapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformremapSeries::add(self : ImagetransformremapSeries, other : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformremapSeries::sub(self : ImagetransformremapSeries, other : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformremapSeries::normalize(self : ImagetransformremapSeries) -> ImagetransformremapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformremapSeries::cumsum(self : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformremapSeries::to_string(self : ImagetransformremapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformremapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_remap_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformremapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_remap_matrix_identity(n : Int) -> ImagetransformremapMatrix {
  let m = image_transform_remap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformremapMatrix::get(self : ImagetransformremapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformremapMatrix::transpose(self : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  let result = image_transform_remap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformremapMatrix::add(self : ImagetransformremapMatrix, other : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_remap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformremapMatrix::scale(self : ImagetransformremapMatrix, s : Double) -> ImagetransformremapMatrix {
  let result = image_transform_remap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformremapMatrix::multiply(self : ImagetransformremapMatrix, other : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  if self.cols != other.rows { return image_transform_remap_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_remap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformremapMatrix::trace(self : ImagetransformremapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformremapMatrix::det(self : ImagetransformremapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformremapMatrix::norm(self : ImagetransformremapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformremapMatrix::to_string(self : ImagetransformremapMatrix) -> String {
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

pub(all) struct ImagetransformremapVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_remap_make_vector(comps : Array[Double]) -> ImagetransformremapVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_remap_vector_zero(dim : Int) -> ImagetransformremapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformremapVector::add(self : ImagetransformremapVector, other : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformremapVector::sub(self : ImagetransformremapVector, other : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformremapVector::scale(self : ImagetransformremapVector, s : Double) -> ImagetransformremapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformremapVector::dot(self : ImagetransformremapVector, other : ImagetransformremapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformremapVector::norm(self : ImagetransformremapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformremapVector::normalize(self : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformremapVector::dist(self : ImagetransformremapVector, other : ImagetransformremapVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformremapVector::to_string(self : ImagetransformremapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_remap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_remap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_remap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_remap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_remap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_remap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_remap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_remap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_remap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_remap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_remap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_remap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_remap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_remap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_remap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_remap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_remap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_remap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_remap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_remap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_remap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_remap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_remap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_remap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_remap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_remap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_remap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_remap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_remap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformremapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_frame_make(size : Int) -> ImagetransformremapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_frame_len(s : ImagetransformremapFrame) -> Int { s.size }

pub fn image_transform_remap_frame_get(s : ImagetransformremapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_frame_set(s : ImagetransformremapFrame, i : Int, v : Double) -> ImagetransformremapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_frame_sum(s : ImagetransformremapFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_frame_mean(s : ImagetransformremapFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_frame_scale(s : ImagetransformremapFrame, f : Double) -> ImagetransformremapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_frame_add(a : ImagetransformremapFrame, b : ImagetransformremapFrame) -> ImagetransformremapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_frame_copy(s : ImagetransformremapFrame) -> ImagetransformremapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_frame_fill(s : ImagetransformremapFrame, v : Double) -> ImagetransformremapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_frame_min(s : ImagetransformremapFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_frame_max(s : ImagetransformremapFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_frame_to_string(s : ImagetransformremapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_table_make(size : Int) -> ImagetransformremapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_table_len(s : ImagetransformremapTable) -> Int { s.size }

pub fn image_transform_remap_table_get(s : ImagetransformremapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_table_set(s : ImagetransformremapTable, i : Int, v : Double) -> ImagetransformremapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_table_sum(s : ImagetransformremapTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_table_mean(s : ImagetransformremapTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_table_scale(s : ImagetransformremapTable, f : Double) -> ImagetransformremapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_table_add(a : ImagetransformremapTable, b : ImagetransformremapTable) -> ImagetransformremapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_table_copy(s : ImagetransformremapTable) -> ImagetransformremapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_table_fill(s : ImagetransformremapTable, v : Double) -> ImagetransformremapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_table_min(s : ImagetransformremapTable) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_table_max(s : ImagetransformremapTable) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_table_to_string(s : ImagetransformremapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_graphn_make(size : Int) -> ImagetransformremapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_graphn_len(s : ImagetransformremapGraphN) -> Int { s.size }

pub fn image_transform_remap_graphn_get(s : ImagetransformremapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_graphn_set(s : ImagetransformremapGraphN, i : Int, v : Double) -> ImagetransformremapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_graphn_sum(s : ImagetransformremapGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_graphn_mean(s : ImagetransformremapGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_graphn_scale(s : ImagetransformremapGraphN, f : Double) -> ImagetransformremapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_graphn_add(a : ImagetransformremapGraphN, b : ImagetransformremapGraphN) -> ImagetransformremapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_graphn_copy(s : ImagetransformremapGraphN) -> ImagetransformremapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_graphn_fill(s : ImagetransformremapGraphN, v : Double) -> ImagetransformremapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_graphn_min(s : ImagetransformremapGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_graphn_max(s : ImagetransformremapGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_graphn_to_string(s : ImagetransformremapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_node_make(size : Int) -> ImagetransformremapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_node_len(s : ImagetransformremapNode) -> Int { s.size }

pub fn image_transform_remap_node_get(s : ImagetransformremapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_node_set(s : ImagetransformremapNode, i : Int, v : Double) -> ImagetransformremapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_node_sum(s : ImagetransformremapNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_node_mean(s : ImagetransformremapNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_node_scale(s : ImagetransformremapNode, f : Double) -> ImagetransformremapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_node_add(a : ImagetransformremapNode, b : ImagetransformremapNode) -> ImagetransformremapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_node_copy(s : ImagetransformremapNode) -> ImagetransformremapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_node_fill(s : ImagetransformremapNode, v : Double) -> ImagetransformremapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_node_min(s : ImagetransformremapNode) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_node_max(s : ImagetransformremapNode) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_node_to_string(s : ImagetransformremapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_edge_make(size : Int) -> ImagetransformremapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_edge_len(s : ImagetransformremapEdge) -> Int { s.size }

pub fn image_transform_remap_edge_get(s : ImagetransformremapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_edge_set(s : ImagetransformremapEdge, i : Int, v : Double) -> ImagetransformremapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_edge_sum(s : ImagetransformremapEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_edge_mean(s : ImagetransformremapEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_edge_scale(s : ImagetransformremapEdge, f : Double) -> ImagetransformremapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_edge_add(a : ImagetransformremapEdge, b : ImagetransformremapEdge) -> ImagetransformremapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_edge_copy(s : ImagetransformremapEdge) -> ImagetransformremapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_edge_fill(s : ImagetransformremapEdge, v : Double) -> ImagetransformremapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_edge_min(s : ImagetransformremapEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_edge_max(s : ImagetransformremapEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_edge_to_string(s : ImagetransformremapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_path_make(size : Int) -> ImagetransformremapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_path_len(s : ImagetransformremapPath) -> Int { s.size }

pub fn image_transform_remap_path_get(s : ImagetransformremapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_path_set(s : ImagetransformremapPath, i : Int, v : Double) -> ImagetransformremapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_path_sum(s : ImagetransformremapPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_path_mean(s : ImagetransformremapPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_path_scale(s : ImagetransformremapPath, f : Double) -> ImagetransformremapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_path_add(a : ImagetransformremapPath, b : ImagetransformremapPath) -> ImagetransformremapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_path_copy(s : ImagetransformremapPath) -> ImagetransformremapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_path_fill(s : ImagetransformremapPath, v : Double) -> ImagetransformremapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_path_min(s : ImagetransformremapPath) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_path_max(s : ImagetransformremapPath) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_path_to_string(s : ImagetransformremapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_cluster_make(size : Int) -> ImagetransformremapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_cluster_len(s : ImagetransformremapCluster) -> Int { s.size }

pub fn image_transform_remap_cluster_get(s : ImagetransformremapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_cluster_set(s : ImagetransformremapCluster, i : Int, v : Double) -> ImagetransformremapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cluster_sum(s : ImagetransformremapCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_cluster_mean(s : ImagetransformremapCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_cluster_scale(s : ImagetransformremapCluster, f : Double) -> ImagetransformremapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cluster_add(a : ImagetransformremapCluster, b : ImagetransformremapCluster) -> ImagetransformremapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_cluster_copy(s : ImagetransformremapCluster) -> ImagetransformremapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cluster_fill(s : ImagetransformremapCluster, v : Double) -> ImagetransformremapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cluster_min(s : ImagetransformremapCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_cluster_max(s : ImagetransformremapCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_cluster_to_string(s : ImagetransformremapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_model_make(size : Int) -> ImagetransformremapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_model_len(s : ImagetransformremapModel) -> Int { s.size }

pub fn image_transform_remap_model_get(s : ImagetransformremapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_model_set(s : ImagetransformremapModel, i : Int, v : Double) -> ImagetransformremapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_model_sum(s : ImagetransformremapModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_model_mean(s : ImagetransformremapModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_model_scale(s : ImagetransformremapModel, f : Double) -> ImagetransformremapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_model_add(a : ImagetransformremapModel, b : ImagetransformremapModel) -> ImagetransformremapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_model_copy(s : ImagetransformremapModel) -> ImagetransformremapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_model_fill(s : ImagetransformremapModel, v : Double) -> ImagetransformremapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_model_min(s : ImagetransformremapModel) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_model_max(s : ImagetransformremapModel) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_model_to_string(s : ImagetransformremapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_layer_make(size : Int) -> ImagetransformremapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_layer_len(s : ImagetransformremapLayer) -> Int { s.size }

pub fn image_transform_remap_layer_get(s : ImagetransformremapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_layer_set(s : ImagetransformremapLayer, i : Int, v : Double) -> ImagetransformremapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_layer_sum(s : ImagetransformremapLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_layer_mean(s : ImagetransformremapLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_layer_scale(s : ImagetransformremapLayer, f : Double) -> ImagetransformremapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_layer_add(a : ImagetransformremapLayer, b : ImagetransformremapLayer) -> ImagetransformremapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_layer_copy(s : ImagetransformremapLayer) -> ImagetransformremapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_layer_fill(s : ImagetransformremapLayer, v : Double) -> ImagetransformremapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_layer_min(s : ImagetransformremapLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_layer_max(s : ImagetransformremapLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_layer_to_string(s : ImagetransformremapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_buffer_make(size : Int) -> ImagetransformremapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_buffer_len(s : ImagetransformremapBuffer) -> Int { s.size }

pub fn image_transform_remap_buffer_get(s : ImagetransformremapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_buffer_set(s : ImagetransformremapBuffer, i : Int, v : Double) -> ImagetransformremapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_buffer_sum(s : ImagetransformremapBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_buffer_mean(s : ImagetransformremapBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_buffer_scale(s : ImagetransformremapBuffer, f : Double) -> ImagetransformremapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_buffer_add(a : ImagetransformremapBuffer, b : ImagetransformremapBuffer) -> ImagetransformremapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_buffer_copy(s : ImagetransformremapBuffer) -> ImagetransformremapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_buffer_fill(s : ImagetransformremapBuffer, v : Double) -> ImagetransformremapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_buffer_min(s : ImagetransformremapBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_buffer_max(s : ImagetransformremapBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_buffer_to_string(s : ImagetransformremapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_cursor_make(size : Int) -> ImagetransformremapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_cursor_len(s : ImagetransformremapCursor) -> Int { s.size }

pub fn image_transform_remap_cursor_get(s : ImagetransformremapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_cursor_set(s : ImagetransformremapCursor, i : Int, v : Double) -> ImagetransformremapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cursor_sum(s : ImagetransformremapCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_cursor_mean(s : ImagetransformremapCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_cursor_scale(s : ImagetransformremapCursor, f : Double) -> ImagetransformremapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cursor_add(a : ImagetransformremapCursor, b : ImagetransformremapCursor) -> ImagetransformremapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_cursor_copy(s : ImagetransformremapCursor) -> ImagetransformremapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cursor_fill(s : ImagetransformremapCursor, v : Double) -> ImagetransformremapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_cursor_min(s : ImagetransformremapCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_cursor_max(s : ImagetransformremapCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_cursor_to_string(s : ImagetransformremapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_view_make(size : Int) -> ImagetransformremapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_view_len(s : ImagetransformremapView) -> Int { s.size }

pub fn image_transform_remap_view_get(s : ImagetransformremapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_view_set(s : ImagetransformremapView, i : Int, v : Double) -> ImagetransformremapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_view_sum(s : ImagetransformremapView) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_view_mean(s : ImagetransformremapView) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_view_scale(s : ImagetransformremapView, f : Double) -> ImagetransformremapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_view_add(a : ImagetransformremapView, b : ImagetransformremapView) -> ImagetransformremapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_view_copy(s : ImagetransformremapView) -> ImagetransformremapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_view_fill(s : ImagetransformremapView, v : Double) -> ImagetransformremapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_view_min(s : ImagetransformremapView) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_view_max(s : ImagetransformremapView) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_view_to_string(s : ImagetransformremapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_range_make(size : Int) -> ImagetransformremapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_range_len(s : ImagetransformremapRange) -> Int { s.size }

pub fn image_transform_remap_range_get(s : ImagetransformremapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_range_set(s : ImagetransformremapRange, i : Int, v : Double) -> ImagetransformremapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_range_sum(s : ImagetransformremapRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_range_mean(s : ImagetransformremapRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_range_scale(s : ImagetransformremapRange, f : Double) -> ImagetransformremapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_range_add(a : ImagetransformremapRange, b : ImagetransformremapRange) -> ImagetransformremapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_range_copy(s : ImagetransformremapRange) -> ImagetransformremapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_range_fill(s : ImagetransformremapRange, v : Double) -> ImagetransformremapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_range_min(s : ImagetransformremapRange) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_range_max(s : ImagetransformremapRange) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_range_to_string(s : ImagetransformremapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_slice_make(size : Int) -> ImagetransformremapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_slice_len(s : ImagetransformremapSlice) -> Int { s.size }

pub fn image_transform_remap_slice_get(s : ImagetransformremapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_slice_set(s : ImagetransformremapSlice, i : Int, v : Double) -> ImagetransformremapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_remap_slice_sum(s : ImagetransformremapSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_slice_mean(s : ImagetransformremapSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_slice_scale(s : ImagetransformremapSlice, f : Double) -> ImagetransformremapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_slice_add(a : ImagetransformremapSlice, b : ImagetransformremapSlice) -> ImagetransformremapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_remap_slice_copy(s : ImagetransformremapSlice) -> ImagetransformremapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_slice_fill(s : ImagetransformremapSlice, v : Double) -> ImagetransformremapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_remap_slice_min(s : ImagetransformremapSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_slice_max(s : ImagetransformremapSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_slice_to_string(s : ImagetransformremapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

