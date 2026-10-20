///===
/// extcore/image_transform_rotate

pub(all) struct ImagetransformrotatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_rotate_make_point(x : Double, y : Double) -> ImagetransformrotatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_rotate_make_point3(x : Double, y : Double, z : Double) -> ImagetransformrotatePoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformrotatePoint::x(self : ImagetransformrotatePoint) -> Double { self.x }

pub fn ImagetransformrotatePoint::y(self : ImagetransformrotatePoint) -> Double { self.y }

pub fn ImagetransformrotatePoint::z(self : ImagetransformrotatePoint) -> Double { self.z }

pub fn ImagetransformrotatePoint::label(self : ImagetransformrotatePoint) -> Int { self.label }

pub fn ImagetransformrotatePoint::dist(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformrotatePoint::add(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformrotatePoint::sub(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformrotatePoint::scale(self : ImagetransformrotatePoint, s : Double) -> ImagetransformrotatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformrotatePoint::dot(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformrotatePoint::cross(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformrotatePoint::norm(self : ImagetransformrotatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformrotatePoint::normalize(self : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformrotatePoint::negate(self : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformrotatePoint::mid(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformrotatePoint::lerp(self : ImagetransformrotatePoint, other : ImagetransformrotatePoint, t : Double) -> ImagetransformrotatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformrotatePoint::to_string(self : ImagetransformrotatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformrotateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_rotate_make_series(vals : Array[Double], name : String) -> ImagetransformrotateSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformrotateSeries::len(self : ImagetransformrotateSeries) -> Int { self.vals.length() }

pub fn ImagetransformrotateSeries::sum(self : ImagetransformrotateSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformrotateSeries::mean(self : ImagetransformrotateSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformrotateSeries::min(self : ImagetransformrotateSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformrotateSeries::max(self : ImagetransformrotateSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformrotateSeries::range(self : ImagetransformrotateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformrotateSeries::variance(self : ImagetransformrotateSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformrotateSeries::std(self : ImagetransformrotateSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformrotateSeries::median(self : ImagetransformrotateSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformrotateSeries::scale(self : ImagetransformrotateSeries, f : Double) -> ImagetransformrotateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformrotateSeries::add(self : ImagetransformrotateSeries, other : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformrotateSeries::sub(self : ImagetransformrotateSeries, other : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformrotateSeries::normalize(self : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformrotateSeries::cumsum(self : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformrotateSeries::to_string(self : ImagetransformrotateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformrotateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_rotate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformrotateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_rotate_matrix_identity(n : Int) -> ImagetransformrotateMatrix {
  let m = image_transform_rotate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformrotateMatrix::get(self : ImagetransformrotateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformrotateMatrix::transpose(self : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  let result = image_transform_rotate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformrotateMatrix::add(self : ImagetransformrotateMatrix, other : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_rotate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformrotateMatrix::scale(self : ImagetransformrotateMatrix, s : Double) -> ImagetransformrotateMatrix {
  let result = image_transform_rotate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformrotateMatrix::multiply(self : ImagetransformrotateMatrix, other : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  if self.cols != other.rows { return image_transform_rotate_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_rotate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformrotateMatrix::trace(self : ImagetransformrotateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformrotateMatrix::det(self : ImagetransformrotateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformrotateMatrix::norm(self : ImagetransformrotateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformrotateMatrix::to_string(self : ImagetransformrotateMatrix) -> String {
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

pub(all) struct ImagetransformrotateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_rotate_make_vector(comps : Array[Double]) -> ImagetransformrotateVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_rotate_vector_zero(dim : Int) -> ImagetransformrotateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformrotateVector::add(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformrotateVector::sub(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformrotateVector::scale(self : ImagetransformrotateVector, s : Double) -> ImagetransformrotateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformrotateVector::dot(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformrotateVector::norm(self : ImagetransformrotateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformrotateVector::normalize(self : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformrotateVector::dist(self : ImagetransformrotateVector, other : ImagetransformrotateVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformrotateVector::to_string(self : ImagetransformrotateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_rotate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_rotate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_rotate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_rotate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_rotate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_rotate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_rotate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_rotate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_rotate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_rotate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_rotate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_rotate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_rotate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_rotate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_rotate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_rotate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_rotate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_rotate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_rotate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_rotate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_rotate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_rotate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_rotate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_rotate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_rotate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_rotate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_rotate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_rotate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_rotate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformrotateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_frame_make(size : Int) -> ImagetransformrotateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_frame_len(s : ImagetransformrotateFrame) -> Int { s.size }

pub fn image_transform_rotate_frame_get(s : ImagetransformrotateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_frame_set(s : ImagetransformrotateFrame, i : Int, v : Double) -> ImagetransformrotateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_sum(s : ImagetransformrotateFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_frame_mean(s : ImagetransformrotateFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_frame_scale(s : ImagetransformrotateFrame, f : Double) -> ImagetransformrotateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_add(a : ImagetransformrotateFrame, b : ImagetransformrotateFrame) -> ImagetransformrotateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_frame_copy(s : ImagetransformrotateFrame) -> ImagetransformrotateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_fill(s : ImagetransformrotateFrame, v : Double) -> ImagetransformrotateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_min(s : ImagetransformrotateFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_frame_max(s : ImagetransformrotateFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_frame_to_string(s : ImagetransformrotateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_table_make(size : Int) -> ImagetransformrotateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_table_len(s : ImagetransformrotateTable) -> Int { s.size }

pub fn image_transform_rotate_table_get(s : ImagetransformrotateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_table_set(s : ImagetransformrotateTable, i : Int, v : Double) -> ImagetransformrotateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_sum(s : ImagetransformrotateTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_table_mean(s : ImagetransformrotateTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_table_scale(s : ImagetransformrotateTable, f : Double) -> ImagetransformrotateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_add(a : ImagetransformrotateTable, b : ImagetransformrotateTable) -> ImagetransformrotateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_table_copy(s : ImagetransformrotateTable) -> ImagetransformrotateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_fill(s : ImagetransformrotateTable, v : Double) -> ImagetransformrotateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_min(s : ImagetransformrotateTable) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_table_max(s : ImagetransformrotateTable) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_table_to_string(s : ImagetransformrotateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_graphn_make(size : Int) -> ImagetransformrotateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_graphn_len(s : ImagetransformrotateGraphN) -> Int { s.size }

pub fn image_transform_rotate_graphn_get(s : ImagetransformrotateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_graphn_set(s : ImagetransformrotateGraphN, i : Int, v : Double) -> ImagetransformrotateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_sum(s : ImagetransformrotateGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_graphn_mean(s : ImagetransformrotateGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_graphn_scale(s : ImagetransformrotateGraphN, f : Double) -> ImagetransformrotateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_add(a : ImagetransformrotateGraphN, b : ImagetransformrotateGraphN) -> ImagetransformrotateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_graphn_copy(s : ImagetransformrotateGraphN) -> ImagetransformrotateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_fill(s : ImagetransformrotateGraphN, v : Double) -> ImagetransformrotateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_min(s : ImagetransformrotateGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_graphn_max(s : ImagetransformrotateGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_graphn_to_string(s : ImagetransformrotateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_node_make(size : Int) -> ImagetransformrotateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_node_len(s : ImagetransformrotateNode) -> Int { s.size }

pub fn image_transform_rotate_node_get(s : ImagetransformrotateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_node_set(s : ImagetransformrotateNode, i : Int, v : Double) -> ImagetransformrotateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_sum(s : ImagetransformrotateNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_node_mean(s : ImagetransformrotateNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_node_scale(s : ImagetransformrotateNode, f : Double) -> ImagetransformrotateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_add(a : ImagetransformrotateNode, b : ImagetransformrotateNode) -> ImagetransformrotateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_node_copy(s : ImagetransformrotateNode) -> ImagetransformrotateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_fill(s : ImagetransformrotateNode, v : Double) -> ImagetransformrotateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_min(s : ImagetransformrotateNode) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_node_max(s : ImagetransformrotateNode) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_node_to_string(s : ImagetransformrotateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_edge_make(size : Int) -> ImagetransformrotateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_edge_len(s : ImagetransformrotateEdge) -> Int { s.size }

pub fn image_transform_rotate_edge_get(s : ImagetransformrotateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_edge_set(s : ImagetransformrotateEdge, i : Int, v : Double) -> ImagetransformrotateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_sum(s : ImagetransformrotateEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_edge_mean(s : ImagetransformrotateEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_edge_scale(s : ImagetransformrotateEdge, f : Double) -> ImagetransformrotateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_add(a : ImagetransformrotateEdge, b : ImagetransformrotateEdge) -> ImagetransformrotateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_edge_copy(s : ImagetransformrotateEdge) -> ImagetransformrotateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_fill(s : ImagetransformrotateEdge, v : Double) -> ImagetransformrotateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_min(s : ImagetransformrotateEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_edge_max(s : ImagetransformrotateEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_edge_to_string(s : ImagetransformrotateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_path_make(size : Int) -> ImagetransformrotatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_path_len(s : ImagetransformrotatePath) -> Int { s.size }

pub fn image_transform_rotate_path_get(s : ImagetransformrotatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_path_set(s : ImagetransformrotatePath, i : Int, v : Double) -> ImagetransformrotatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_sum(s : ImagetransformrotatePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_path_mean(s : ImagetransformrotatePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_path_scale(s : ImagetransformrotatePath, f : Double) -> ImagetransformrotatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_add(a : ImagetransformrotatePath, b : ImagetransformrotatePath) -> ImagetransformrotatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_path_copy(s : ImagetransformrotatePath) -> ImagetransformrotatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_fill(s : ImagetransformrotatePath, v : Double) -> ImagetransformrotatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_min(s : ImagetransformrotatePath) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_path_max(s : ImagetransformrotatePath) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_path_to_string(s : ImagetransformrotatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_cluster_make(size : Int) -> ImagetransformrotateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_cluster_len(s : ImagetransformrotateCluster) -> Int { s.size }

pub fn image_transform_rotate_cluster_get(s : ImagetransformrotateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_cluster_set(s : ImagetransformrotateCluster, i : Int, v : Double) -> ImagetransformrotateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_sum(s : ImagetransformrotateCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_cluster_mean(s : ImagetransformrotateCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_cluster_scale(s : ImagetransformrotateCluster, f : Double) -> ImagetransformrotateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_add(a : ImagetransformrotateCluster, b : ImagetransformrotateCluster) -> ImagetransformrotateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_cluster_copy(s : ImagetransformrotateCluster) -> ImagetransformrotateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_fill(s : ImagetransformrotateCluster, v : Double) -> ImagetransformrotateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_min(s : ImagetransformrotateCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_cluster_max(s : ImagetransformrotateCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_cluster_to_string(s : ImagetransformrotateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_model_make(size : Int) -> ImagetransformrotateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_model_len(s : ImagetransformrotateModel) -> Int { s.size }

pub fn image_transform_rotate_model_get(s : ImagetransformrotateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_model_set(s : ImagetransformrotateModel, i : Int, v : Double) -> ImagetransformrotateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_sum(s : ImagetransformrotateModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_model_mean(s : ImagetransformrotateModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_model_scale(s : ImagetransformrotateModel, f : Double) -> ImagetransformrotateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_add(a : ImagetransformrotateModel, b : ImagetransformrotateModel) -> ImagetransformrotateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_model_copy(s : ImagetransformrotateModel) -> ImagetransformrotateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_fill(s : ImagetransformrotateModel, v : Double) -> ImagetransformrotateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_min(s : ImagetransformrotateModel) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_model_max(s : ImagetransformrotateModel) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_model_to_string(s : ImagetransformrotateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_layer_make(size : Int) -> ImagetransformrotateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_layer_len(s : ImagetransformrotateLayer) -> Int { s.size }

pub fn image_transform_rotate_layer_get(s : ImagetransformrotateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_layer_set(s : ImagetransformrotateLayer, i : Int, v : Double) -> ImagetransformrotateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_sum(s : ImagetransformrotateLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_layer_mean(s : ImagetransformrotateLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_layer_scale(s : ImagetransformrotateLayer, f : Double) -> ImagetransformrotateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_add(a : ImagetransformrotateLayer, b : ImagetransformrotateLayer) -> ImagetransformrotateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_layer_copy(s : ImagetransformrotateLayer) -> ImagetransformrotateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_fill(s : ImagetransformrotateLayer, v : Double) -> ImagetransformrotateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_min(s : ImagetransformrotateLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_layer_max(s : ImagetransformrotateLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_layer_to_string(s : ImagetransformrotateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_buffer_make(size : Int) -> ImagetransformrotateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_buffer_len(s : ImagetransformrotateBuffer) -> Int { s.size }

pub fn image_transform_rotate_buffer_get(s : ImagetransformrotateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_buffer_set(s : ImagetransformrotateBuffer, i : Int, v : Double) -> ImagetransformrotateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_sum(s : ImagetransformrotateBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_buffer_mean(s : ImagetransformrotateBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_buffer_scale(s : ImagetransformrotateBuffer, f : Double) -> ImagetransformrotateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_add(a : ImagetransformrotateBuffer, b : ImagetransformrotateBuffer) -> ImagetransformrotateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_buffer_copy(s : ImagetransformrotateBuffer) -> ImagetransformrotateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_fill(s : ImagetransformrotateBuffer, v : Double) -> ImagetransformrotateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_min(s : ImagetransformrotateBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_buffer_max(s : ImagetransformrotateBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_buffer_to_string(s : ImagetransformrotateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_cursor_make(size : Int) -> ImagetransformrotateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_cursor_len(s : ImagetransformrotateCursor) -> Int { s.size }

pub fn image_transform_rotate_cursor_get(s : ImagetransformrotateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_cursor_set(s : ImagetransformrotateCursor, i : Int, v : Double) -> ImagetransformrotateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_sum(s : ImagetransformrotateCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_cursor_mean(s : ImagetransformrotateCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_cursor_scale(s : ImagetransformrotateCursor, f : Double) -> ImagetransformrotateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_add(a : ImagetransformrotateCursor, b : ImagetransformrotateCursor) -> ImagetransformrotateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_cursor_copy(s : ImagetransformrotateCursor) -> ImagetransformrotateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_fill(s : ImagetransformrotateCursor, v : Double) -> ImagetransformrotateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_min(s : ImagetransformrotateCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_cursor_max(s : ImagetransformrotateCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_cursor_to_string(s : ImagetransformrotateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_view_make(size : Int) -> ImagetransformrotateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_view_len(s : ImagetransformrotateView) -> Int { s.size }

pub fn image_transform_rotate_view_get(s : ImagetransformrotateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_view_set(s : ImagetransformrotateView, i : Int, v : Double) -> ImagetransformrotateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_sum(s : ImagetransformrotateView) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_view_mean(s : ImagetransformrotateView) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_view_scale(s : ImagetransformrotateView, f : Double) -> ImagetransformrotateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_add(a : ImagetransformrotateView, b : ImagetransformrotateView) -> ImagetransformrotateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_view_copy(s : ImagetransformrotateView) -> ImagetransformrotateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_fill(s : ImagetransformrotateView, v : Double) -> ImagetransformrotateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_min(s : ImagetransformrotateView) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_view_max(s : ImagetransformrotateView) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_view_to_string(s : ImagetransformrotateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_range_make(size : Int) -> ImagetransformrotateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_range_len(s : ImagetransformrotateRange) -> Int { s.size }

pub fn image_transform_rotate_range_get(s : ImagetransformrotateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_range_set(s : ImagetransformrotateRange, i : Int, v : Double) -> ImagetransformrotateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_sum(s : ImagetransformrotateRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_range_mean(s : ImagetransformrotateRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_range_scale(s : ImagetransformrotateRange, f : Double) -> ImagetransformrotateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_add(a : ImagetransformrotateRange, b : ImagetransformrotateRange) -> ImagetransformrotateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_range_copy(s : ImagetransformrotateRange) -> ImagetransformrotateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_fill(s : ImagetransformrotateRange, v : Double) -> ImagetransformrotateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_min(s : ImagetransformrotateRange) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_range_max(s : ImagetransformrotateRange) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_range_to_string(s : ImagetransformrotateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_slice_make(size : Int) -> ImagetransformrotateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_slice_len(s : ImagetransformrotateSlice) -> Int { s.size }

pub fn image_transform_rotate_slice_get(s : ImagetransformrotateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_slice_set(s : ImagetransformrotateSlice, i : Int, v : Double) -> ImagetransformrotateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_sum(s : ImagetransformrotateSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_slice_mean(s : ImagetransformrotateSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_slice_scale(s : ImagetransformrotateSlice, f : Double) -> ImagetransformrotateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_add(a : ImagetransformrotateSlice, b : ImagetransformrotateSlice) -> ImagetransformrotateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_slice_copy(s : ImagetransformrotateSlice) -> ImagetransformrotateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_fill(s : ImagetransformrotateSlice, v : Double) -> ImagetransformrotateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_min(s : ImagetransformrotateSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_slice_max(s : ImagetransformrotateSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_slice_to_string(s : ImagetransformrotateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

