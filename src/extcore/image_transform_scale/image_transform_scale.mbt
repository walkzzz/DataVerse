///===
/// extcore/image_transform_scale

pub(all) struct ImagetransformscalePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_scale_make_point(x : Double, y : Double) -> ImagetransformscalePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_scale_make_point3(x : Double, y : Double, z : Double) -> ImagetransformscalePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformscalePoint::x(self : ImagetransformscalePoint) -> Double { self.x }

pub fn ImagetransformscalePoint::y(self : ImagetransformscalePoint) -> Double { self.y }

pub fn ImagetransformscalePoint::z(self : ImagetransformscalePoint) -> Double { self.z }

pub fn ImagetransformscalePoint::label(self : ImagetransformscalePoint) -> Int { self.label }

pub fn ImagetransformscalePoint::dist(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformscalePoint::add(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformscalePoint::sub(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformscalePoint::scale(self : ImagetransformscalePoint, s : Double) -> ImagetransformscalePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformscalePoint::dot(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformscalePoint::cross(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformscalePoint::norm(self : ImagetransformscalePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformscalePoint::normalize(self : ImagetransformscalePoint) -> ImagetransformscalePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformscalePoint::negate(self : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformscalePoint::mid(self : ImagetransformscalePoint, other : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformscalePoint::lerp(self : ImagetransformscalePoint, other : ImagetransformscalePoint, t : Double) -> ImagetransformscalePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformscalePoint::to_string(self : ImagetransformscalePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformscaleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_scale_make_series(vals : Array[Double], name : String) -> ImagetransformscaleSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformscaleSeries::len(self : ImagetransformscaleSeries) -> Int { self.vals.length() }

pub fn ImagetransformscaleSeries::sum(self : ImagetransformscaleSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformscaleSeries::mean(self : ImagetransformscaleSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformscaleSeries::min(self : ImagetransformscaleSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformscaleSeries::max(self : ImagetransformscaleSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformscaleSeries::range(self : ImagetransformscaleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformscaleSeries::variance(self : ImagetransformscaleSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformscaleSeries::std(self : ImagetransformscaleSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformscaleSeries::median(self : ImagetransformscaleSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformscaleSeries::scale(self : ImagetransformscaleSeries, f : Double) -> ImagetransformscaleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformscaleSeries::add(self : ImagetransformscaleSeries, other : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformscaleSeries::sub(self : ImagetransformscaleSeries, other : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformscaleSeries::normalize(self : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformscaleSeries::cumsum(self : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformscaleSeries::to_string(self : ImagetransformscaleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformscaleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_scale_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformscaleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_scale_matrix_identity(n : Int) -> ImagetransformscaleMatrix {
  let m = image_transform_scale_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformscaleMatrix::get(self : ImagetransformscaleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformscaleMatrix::transpose(self : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  let result = image_transform_scale_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformscaleMatrix::add(self : ImagetransformscaleMatrix, other : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_scale_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformscaleMatrix::scale(self : ImagetransformscaleMatrix, s : Double) -> ImagetransformscaleMatrix {
  let result = image_transform_scale_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformscaleMatrix::multiply(self : ImagetransformscaleMatrix, other : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  if self.cols != other.rows { return image_transform_scale_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_scale_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformscaleMatrix::trace(self : ImagetransformscaleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformscaleMatrix::det(self : ImagetransformscaleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformscaleMatrix::norm(self : ImagetransformscaleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformscaleMatrix::to_string(self : ImagetransformscaleMatrix) -> String {
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

pub(all) struct ImagetransformscaleVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_scale_make_vector(comps : Array[Double]) -> ImagetransformscaleVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_scale_vector_zero(dim : Int) -> ImagetransformscaleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformscaleVector::add(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformscaleVector::sub(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformscaleVector::scale(self : ImagetransformscaleVector, s : Double) -> ImagetransformscaleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformscaleVector::dot(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformscaleVector::norm(self : ImagetransformscaleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformscaleVector::normalize(self : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformscaleVector::dist(self : ImagetransformscaleVector, other : ImagetransformscaleVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformscaleVector::to_string(self : ImagetransformscaleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_scale_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_scale_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_scale_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_scale_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_scale_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_scale_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_scale_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_scale_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_scale_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_scale_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_scale_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_scale_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_scale_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_scale_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_scale_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_scale_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_scale_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_scale_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_scale_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_scale_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_scale_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_scale_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_scale_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_scale_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_scale_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_scale_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_scale_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_scale_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_scale_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformscaleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_frame_make(size : Int) -> ImagetransformscaleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_frame_len(s : ImagetransformscaleFrame) -> Int { s.size }

pub fn image_transform_scale_frame_get(s : ImagetransformscaleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_frame_set(s : ImagetransformscaleFrame, i : Int, v : Double) -> ImagetransformscaleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_frame_sum(s : ImagetransformscaleFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_frame_mean(s : ImagetransformscaleFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_frame_scale(s : ImagetransformscaleFrame, f : Double) -> ImagetransformscaleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_frame_add(a : ImagetransformscaleFrame, b : ImagetransformscaleFrame) -> ImagetransformscaleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_frame_copy(s : ImagetransformscaleFrame) -> ImagetransformscaleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_frame_fill(s : ImagetransformscaleFrame, v : Double) -> ImagetransformscaleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_frame_min(s : ImagetransformscaleFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_frame_max(s : ImagetransformscaleFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_frame_to_string(s : ImagetransformscaleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_table_make(size : Int) -> ImagetransformscaleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_table_len(s : ImagetransformscaleTable) -> Int { s.size }

pub fn image_transform_scale_table_get(s : ImagetransformscaleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_table_set(s : ImagetransformscaleTable, i : Int, v : Double) -> ImagetransformscaleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_table_sum(s : ImagetransformscaleTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_table_mean(s : ImagetransformscaleTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_table_scale(s : ImagetransformscaleTable, f : Double) -> ImagetransformscaleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_table_add(a : ImagetransformscaleTable, b : ImagetransformscaleTable) -> ImagetransformscaleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_table_copy(s : ImagetransformscaleTable) -> ImagetransformscaleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_table_fill(s : ImagetransformscaleTable, v : Double) -> ImagetransformscaleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_table_min(s : ImagetransformscaleTable) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_table_max(s : ImagetransformscaleTable) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_table_to_string(s : ImagetransformscaleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_graphn_make(size : Int) -> ImagetransformscaleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_graphn_len(s : ImagetransformscaleGraphN) -> Int { s.size }

pub fn image_transform_scale_graphn_get(s : ImagetransformscaleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_graphn_set(s : ImagetransformscaleGraphN, i : Int, v : Double) -> ImagetransformscaleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_graphn_sum(s : ImagetransformscaleGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_graphn_mean(s : ImagetransformscaleGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_graphn_scale(s : ImagetransformscaleGraphN, f : Double) -> ImagetransformscaleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_graphn_add(a : ImagetransformscaleGraphN, b : ImagetransformscaleGraphN) -> ImagetransformscaleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_graphn_copy(s : ImagetransformscaleGraphN) -> ImagetransformscaleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_graphn_fill(s : ImagetransformscaleGraphN, v : Double) -> ImagetransformscaleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_graphn_min(s : ImagetransformscaleGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_graphn_max(s : ImagetransformscaleGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_graphn_to_string(s : ImagetransformscaleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_node_make(size : Int) -> ImagetransformscaleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_node_len(s : ImagetransformscaleNode) -> Int { s.size }

pub fn image_transform_scale_node_get(s : ImagetransformscaleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_node_set(s : ImagetransformscaleNode, i : Int, v : Double) -> ImagetransformscaleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_node_sum(s : ImagetransformscaleNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_node_mean(s : ImagetransformscaleNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_node_scale(s : ImagetransformscaleNode, f : Double) -> ImagetransformscaleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_node_add(a : ImagetransformscaleNode, b : ImagetransformscaleNode) -> ImagetransformscaleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_node_copy(s : ImagetransformscaleNode) -> ImagetransformscaleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_node_fill(s : ImagetransformscaleNode, v : Double) -> ImagetransformscaleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_node_min(s : ImagetransformscaleNode) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_node_max(s : ImagetransformscaleNode) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_node_to_string(s : ImagetransformscaleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_edge_make(size : Int) -> ImagetransformscaleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_edge_len(s : ImagetransformscaleEdge) -> Int { s.size }

pub fn image_transform_scale_edge_get(s : ImagetransformscaleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_edge_set(s : ImagetransformscaleEdge, i : Int, v : Double) -> ImagetransformscaleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_edge_sum(s : ImagetransformscaleEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_edge_mean(s : ImagetransformscaleEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_edge_scale(s : ImagetransformscaleEdge, f : Double) -> ImagetransformscaleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_edge_add(a : ImagetransformscaleEdge, b : ImagetransformscaleEdge) -> ImagetransformscaleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_edge_copy(s : ImagetransformscaleEdge) -> ImagetransformscaleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_edge_fill(s : ImagetransformscaleEdge, v : Double) -> ImagetransformscaleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_edge_min(s : ImagetransformscaleEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_edge_max(s : ImagetransformscaleEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_edge_to_string(s : ImagetransformscaleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscalePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_path_make(size : Int) -> ImagetransformscalePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_path_len(s : ImagetransformscalePath) -> Int { s.size }

pub fn image_transform_scale_path_get(s : ImagetransformscalePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_path_set(s : ImagetransformscalePath, i : Int, v : Double) -> ImagetransformscalePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_path_sum(s : ImagetransformscalePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_path_mean(s : ImagetransformscalePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_path_scale(s : ImagetransformscalePath, f : Double) -> ImagetransformscalePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_path_add(a : ImagetransformscalePath, b : ImagetransformscalePath) -> ImagetransformscalePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_path_copy(s : ImagetransformscalePath) -> ImagetransformscalePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_path_fill(s : ImagetransformscalePath, v : Double) -> ImagetransformscalePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_path_min(s : ImagetransformscalePath) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_path_max(s : ImagetransformscalePath) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_path_to_string(s : ImagetransformscalePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_cluster_make(size : Int) -> ImagetransformscaleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_cluster_len(s : ImagetransformscaleCluster) -> Int { s.size }

pub fn image_transform_scale_cluster_get(s : ImagetransformscaleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_cluster_set(s : ImagetransformscaleCluster, i : Int, v : Double) -> ImagetransformscaleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cluster_sum(s : ImagetransformscaleCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_cluster_mean(s : ImagetransformscaleCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_cluster_scale(s : ImagetransformscaleCluster, f : Double) -> ImagetransformscaleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cluster_add(a : ImagetransformscaleCluster, b : ImagetransformscaleCluster) -> ImagetransformscaleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_cluster_copy(s : ImagetransformscaleCluster) -> ImagetransformscaleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cluster_fill(s : ImagetransformscaleCluster, v : Double) -> ImagetransformscaleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cluster_min(s : ImagetransformscaleCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_cluster_max(s : ImagetransformscaleCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_cluster_to_string(s : ImagetransformscaleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_model_make(size : Int) -> ImagetransformscaleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_model_len(s : ImagetransformscaleModel) -> Int { s.size }

pub fn image_transform_scale_model_get(s : ImagetransformscaleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_model_set(s : ImagetransformscaleModel, i : Int, v : Double) -> ImagetransformscaleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_model_sum(s : ImagetransformscaleModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_model_mean(s : ImagetransformscaleModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_model_scale(s : ImagetransformscaleModel, f : Double) -> ImagetransformscaleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_model_add(a : ImagetransformscaleModel, b : ImagetransformscaleModel) -> ImagetransformscaleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_model_copy(s : ImagetransformscaleModel) -> ImagetransformscaleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_model_fill(s : ImagetransformscaleModel, v : Double) -> ImagetransformscaleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_model_min(s : ImagetransformscaleModel) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_model_max(s : ImagetransformscaleModel) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_model_to_string(s : ImagetransformscaleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_layer_make(size : Int) -> ImagetransformscaleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_layer_len(s : ImagetransformscaleLayer) -> Int { s.size }

pub fn image_transform_scale_layer_get(s : ImagetransformscaleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_layer_set(s : ImagetransformscaleLayer, i : Int, v : Double) -> ImagetransformscaleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_layer_sum(s : ImagetransformscaleLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_layer_mean(s : ImagetransformscaleLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_layer_scale(s : ImagetransformscaleLayer, f : Double) -> ImagetransformscaleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_layer_add(a : ImagetransformscaleLayer, b : ImagetransformscaleLayer) -> ImagetransformscaleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_layer_copy(s : ImagetransformscaleLayer) -> ImagetransformscaleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_layer_fill(s : ImagetransformscaleLayer, v : Double) -> ImagetransformscaleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_layer_min(s : ImagetransformscaleLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_layer_max(s : ImagetransformscaleLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_layer_to_string(s : ImagetransformscaleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_buffer_make(size : Int) -> ImagetransformscaleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_buffer_len(s : ImagetransformscaleBuffer) -> Int { s.size }

pub fn image_transform_scale_buffer_get(s : ImagetransformscaleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_buffer_set(s : ImagetransformscaleBuffer, i : Int, v : Double) -> ImagetransformscaleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_buffer_sum(s : ImagetransformscaleBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_buffer_mean(s : ImagetransformscaleBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_buffer_scale(s : ImagetransformscaleBuffer, f : Double) -> ImagetransformscaleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_buffer_add(a : ImagetransformscaleBuffer, b : ImagetransformscaleBuffer) -> ImagetransformscaleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_buffer_copy(s : ImagetransformscaleBuffer) -> ImagetransformscaleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_buffer_fill(s : ImagetransformscaleBuffer, v : Double) -> ImagetransformscaleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_buffer_min(s : ImagetransformscaleBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_buffer_max(s : ImagetransformscaleBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_buffer_to_string(s : ImagetransformscaleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_cursor_make(size : Int) -> ImagetransformscaleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_cursor_len(s : ImagetransformscaleCursor) -> Int { s.size }

pub fn image_transform_scale_cursor_get(s : ImagetransformscaleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_cursor_set(s : ImagetransformscaleCursor, i : Int, v : Double) -> ImagetransformscaleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cursor_sum(s : ImagetransformscaleCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_cursor_mean(s : ImagetransformscaleCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_cursor_scale(s : ImagetransformscaleCursor, f : Double) -> ImagetransformscaleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cursor_add(a : ImagetransformscaleCursor, b : ImagetransformscaleCursor) -> ImagetransformscaleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_cursor_copy(s : ImagetransformscaleCursor) -> ImagetransformscaleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cursor_fill(s : ImagetransformscaleCursor, v : Double) -> ImagetransformscaleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_cursor_min(s : ImagetransformscaleCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_cursor_max(s : ImagetransformscaleCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_cursor_to_string(s : ImagetransformscaleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_view_make(size : Int) -> ImagetransformscaleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_view_len(s : ImagetransformscaleView) -> Int { s.size }

pub fn image_transform_scale_view_get(s : ImagetransformscaleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_view_set(s : ImagetransformscaleView, i : Int, v : Double) -> ImagetransformscaleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_view_sum(s : ImagetransformscaleView) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_view_mean(s : ImagetransformscaleView) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_view_scale(s : ImagetransformscaleView, f : Double) -> ImagetransformscaleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_view_add(a : ImagetransformscaleView, b : ImagetransformscaleView) -> ImagetransformscaleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_view_copy(s : ImagetransformscaleView) -> ImagetransformscaleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_view_fill(s : ImagetransformscaleView, v : Double) -> ImagetransformscaleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_view_min(s : ImagetransformscaleView) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_view_max(s : ImagetransformscaleView) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_view_to_string(s : ImagetransformscaleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_range_make(size : Int) -> ImagetransformscaleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_range_len(s : ImagetransformscaleRange) -> Int { s.size }

pub fn image_transform_scale_range_get(s : ImagetransformscaleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_range_set(s : ImagetransformscaleRange, i : Int, v : Double) -> ImagetransformscaleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_range_sum(s : ImagetransformscaleRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_range_mean(s : ImagetransformscaleRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_range_scale(s : ImagetransformscaleRange, f : Double) -> ImagetransformscaleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_range_add(a : ImagetransformscaleRange, b : ImagetransformscaleRange) -> ImagetransformscaleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_range_copy(s : ImagetransformscaleRange) -> ImagetransformscaleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_range_fill(s : ImagetransformscaleRange, v : Double) -> ImagetransformscaleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_range_min(s : ImagetransformscaleRange) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_range_max(s : ImagetransformscaleRange) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_range_to_string(s : ImagetransformscaleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_slice_make(size : Int) -> ImagetransformscaleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_slice_len(s : ImagetransformscaleSlice) -> Int { s.size }

pub fn image_transform_scale_slice_get(s : ImagetransformscaleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_slice_set(s : ImagetransformscaleSlice, i : Int, v : Double) -> ImagetransformscaleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_scale_slice_sum(s : ImagetransformscaleSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_scale_slice_mean(s : ImagetransformscaleSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_scale_slice_scale(s : ImagetransformscaleSlice, f : Double) -> ImagetransformscaleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_slice_add(a : ImagetransformscaleSlice, b : ImagetransformscaleSlice) -> ImagetransformscaleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_scale_slice_copy(s : ImagetransformscaleSlice) -> ImagetransformscaleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_slice_fill(s : ImagetransformscaleSlice, v : Double) -> ImagetransformscaleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_scale_slice_min(s : ImagetransformscaleSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_scale_slice_max(s : ImagetransformscaleSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_scale_slice_to_string(s : ImagetransformscaleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

