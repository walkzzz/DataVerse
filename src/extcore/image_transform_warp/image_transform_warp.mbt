///===
/// extcore/image_transform_warp

pub(all) struct ImagetransformwarpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_warp_make_point(x : Double, y : Double) -> ImagetransformwarpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_warp_make_point3(x : Double, y : Double, z : Double) -> ImagetransformwarpPoint {
  { x, y, z, label: 0 }
}

pub fn ImagetransformwarpPoint::x(self : ImagetransformwarpPoint) -> Double { self.x }

pub fn ImagetransformwarpPoint::y(self : ImagetransformwarpPoint) -> Double { self.y }

pub fn ImagetransformwarpPoint::z(self : ImagetransformwarpPoint) -> Double { self.z }

pub fn ImagetransformwarpPoint::label(self : ImagetransformwarpPoint) -> Int { self.label }

pub fn ImagetransformwarpPoint::dist(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagetransformwarpPoint::add(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagetransformwarpPoint::sub(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagetransformwarpPoint::scale(self : ImagetransformwarpPoint, s : Double) -> ImagetransformwarpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagetransformwarpPoint::dot(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagetransformwarpPoint::cross(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagetransformwarpPoint::norm(self : ImagetransformwarpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagetransformwarpPoint::normalize(self : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformwarpPoint::negate(self : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagetransformwarpPoint::mid(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagetransformwarpPoint::lerp(self : ImagetransformwarpPoint, other : ImagetransformwarpPoint, t : Double) -> ImagetransformwarpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagetransformwarpPoint::to_string(self : ImagetransformwarpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagetransformwarpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_warp_make_series(vals : Array[Double], name : String) -> ImagetransformwarpSeries {
  { vals, name, meta: 0 }
}

pub fn ImagetransformwarpSeries::len(self : ImagetransformwarpSeries) -> Int { self.vals.length() }

pub fn ImagetransformwarpSeries::sum(self : ImagetransformwarpSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagetransformwarpSeries::mean(self : ImagetransformwarpSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagetransformwarpSeries::min(self : ImagetransformwarpSeries) -> Double { @_common.min(self.vals) }

pub fn ImagetransformwarpSeries::max(self : ImagetransformwarpSeries) -> Double { @_common.max(self.vals) }

pub fn ImagetransformwarpSeries::range(self : ImagetransformwarpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagetransformwarpSeries::variance(self : ImagetransformwarpSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagetransformwarpSeries::std(self : ImagetransformwarpSeries) -> Double { @_common.std(self.vals) }

pub fn ImagetransformwarpSeries::median(self : ImagetransformwarpSeries) -> Double { @_common.median(self.vals) }

pub fn ImagetransformwarpSeries::scale(self : ImagetransformwarpSeries, f : Double) -> ImagetransformwarpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagetransformwarpSeries::add(self : ImagetransformwarpSeries, other : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagetransformwarpSeries::sub(self : ImagetransformwarpSeries, other : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagetransformwarpSeries::normalize(self : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagetransformwarpSeries::cumsum(self : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagetransformwarpSeries::to_string(self : ImagetransformwarpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformwarpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_warp_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformwarpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_warp_matrix_identity(n : Int) -> ImagetransformwarpMatrix {
  let m = image_transform_warp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagetransformwarpMatrix::get(self : ImagetransformwarpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagetransformwarpMatrix::transpose(self : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagetransformwarpMatrix::add(self : ImagetransformwarpMatrix, other : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_transform_warp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagetransformwarpMatrix::scale(self : ImagetransformwarpMatrix, s : Double) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagetransformwarpMatrix::multiply(self : ImagetransformwarpMatrix, other : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if self.cols != other.rows { return image_transform_warp_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_transform_warp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagetransformwarpMatrix::trace(self : ImagetransformwarpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagetransformwarpMatrix::det(self : ImagetransformwarpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagetransformwarpMatrix::norm(self : ImagetransformwarpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagetransformwarpMatrix::to_string(self : ImagetransformwarpMatrix) -> String {
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

pub(all) struct ImagetransformwarpVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_warp_make_vector(comps : Array[Double]) -> ImagetransformwarpVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_warp_vector_zero(dim : Int) -> ImagetransformwarpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagetransformwarpVector::add(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformwarpVector::sub(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagetransformwarpVector::scale(self : ImagetransformwarpVector, s : Double) -> ImagetransformwarpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagetransformwarpVector::dot(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagetransformwarpVector::norm(self : ImagetransformwarpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagetransformwarpVector::normalize(self : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagetransformwarpVector::dist(self : ImagetransformwarpVector, other : ImagetransformwarpVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagetransformwarpVector::to_string(self : ImagetransformwarpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_warp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_warp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_warp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_warp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_warp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_warp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_warp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_warp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_warp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_warp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_warp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_warp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_warp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_warp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_warp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_warp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_warp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_warp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_warp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_warp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_warp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_warp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_warp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_warp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_warp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_warp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_warp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_warp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_warp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformwarpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_frame_make(size : Int) -> ImagetransformwarpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_frame_len(s : ImagetransformwarpFrame) -> Int { s.size }

pub fn image_transform_warp_frame_get(s : ImagetransformwarpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_frame_set(s : ImagetransformwarpFrame, i : Int, v : Double) -> ImagetransformwarpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_sum(s : ImagetransformwarpFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_frame_mean(s : ImagetransformwarpFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_frame_scale(s : ImagetransformwarpFrame, f : Double) -> ImagetransformwarpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_add(a : ImagetransformwarpFrame, b : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_frame_copy(s : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_fill(s : ImagetransformwarpFrame, v : Double) -> ImagetransformwarpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_min(s : ImagetransformwarpFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_frame_max(s : ImagetransformwarpFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_frame_to_string(s : ImagetransformwarpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_table_make(size : Int) -> ImagetransformwarpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_table_len(s : ImagetransformwarpTable) -> Int { s.size }

pub fn image_transform_warp_table_get(s : ImagetransformwarpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_table_set(s : ImagetransformwarpTable, i : Int, v : Double) -> ImagetransformwarpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_sum(s : ImagetransformwarpTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_table_mean(s : ImagetransformwarpTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_table_scale(s : ImagetransformwarpTable, f : Double) -> ImagetransformwarpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_add(a : ImagetransformwarpTable, b : ImagetransformwarpTable) -> ImagetransformwarpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_table_copy(s : ImagetransformwarpTable) -> ImagetransformwarpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_fill(s : ImagetransformwarpTable, v : Double) -> ImagetransformwarpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_min(s : ImagetransformwarpTable) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_table_max(s : ImagetransformwarpTable) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_table_to_string(s : ImagetransformwarpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_graphn_make(size : Int) -> ImagetransformwarpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_graphn_len(s : ImagetransformwarpGraphN) -> Int { s.size }

pub fn image_transform_warp_graphn_get(s : ImagetransformwarpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_graphn_set(s : ImagetransformwarpGraphN, i : Int, v : Double) -> ImagetransformwarpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_sum(s : ImagetransformwarpGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_graphn_mean(s : ImagetransformwarpGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_graphn_scale(s : ImagetransformwarpGraphN, f : Double) -> ImagetransformwarpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_add(a : ImagetransformwarpGraphN, b : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_graphn_copy(s : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_fill(s : ImagetransformwarpGraphN, v : Double) -> ImagetransformwarpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_min(s : ImagetransformwarpGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_graphn_max(s : ImagetransformwarpGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_graphn_to_string(s : ImagetransformwarpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_node_make(size : Int) -> ImagetransformwarpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_node_len(s : ImagetransformwarpNode) -> Int { s.size }

pub fn image_transform_warp_node_get(s : ImagetransformwarpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_node_set(s : ImagetransformwarpNode, i : Int, v : Double) -> ImagetransformwarpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_sum(s : ImagetransformwarpNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_node_mean(s : ImagetransformwarpNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_node_scale(s : ImagetransformwarpNode, f : Double) -> ImagetransformwarpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_add(a : ImagetransformwarpNode, b : ImagetransformwarpNode) -> ImagetransformwarpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_node_copy(s : ImagetransformwarpNode) -> ImagetransformwarpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_fill(s : ImagetransformwarpNode, v : Double) -> ImagetransformwarpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_min(s : ImagetransformwarpNode) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_node_max(s : ImagetransformwarpNode) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_node_to_string(s : ImagetransformwarpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_edge_make(size : Int) -> ImagetransformwarpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_edge_len(s : ImagetransformwarpEdge) -> Int { s.size }

pub fn image_transform_warp_edge_get(s : ImagetransformwarpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_edge_set(s : ImagetransformwarpEdge, i : Int, v : Double) -> ImagetransformwarpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_sum(s : ImagetransformwarpEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_edge_mean(s : ImagetransformwarpEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_edge_scale(s : ImagetransformwarpEdge, f : Double) -> ImagetransformwarpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_add(a : ImagetransformwarpEdge, b : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_edge_copy(s : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_fill(s : ImagetransformwarpEdge, v : Double) -> ImagetransformwarpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_min(s : ImagetransformwarpEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_edge_max(s : ImagetransformwarpEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_edge_to_string(s : ImagetransformwarpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_path_make(size : Int) -> ImagetransformwarpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_path_len(s : ImagetransformwarpPath) -> Int { s.size }

pub fn image_transform_warp_path_get(s : ImagetransformwarpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_path_set(s : ImagetransformwarpPath, i : Int, v : Double) -> ImagetransformwarpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_sum(s : ImagetransformwarpPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_path_mean(s : ImagetransformwarpPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_path_scale(s : ImagetransformwarpPath, f : Double) -> ImagetransformwarpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_add(a : ImagetransformwarpPath, b : ImagetransformwarpPath) -> ImagetransformwarpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_path_copy(s : ImagetransformwarpPath) -> ImagetransformwarpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_fill(s : ImagetransformwarpPath, v : Double) -> ImagetransformwarpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_min(s : ImagetransformwarpPath) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_path_max(s : ImagetransformwarpPath) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_path_to_string(s : ImagetransformwarpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cluster_make(size : Int) -> ImagetransformwarpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_cluster_len(s : ImagetransformwarpCluster) -> Int { s.size }

pub fn image_transform_warp_cluster_get(s : ImagetransformwarpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_cluster_set(s : ImagetransformwarpCluster, i : Int, v : Double) -> ImagetransformwarpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_sum(s : ImagetransformwarpCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_cluster_mean(s : ImagetransformwarpCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_cluster_scale(s : ImagetransformwarpCluster, f : Double) -> ImagetransformwarpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_add(a : ImagetransformwarpCluster, b : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_cluster_copy(s : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_fill(s : ImagetransformwarpCluster, v : Double) -> ImagetransformwarpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_min(s : ImagetransformwarpCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_cluster_max(s : ImagetransformwarpCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_cluster_to_string(s : ImagetransformwarpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_model_make(size : Int) -> ImagetransformwarpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_model_len(s : ImagetransformwarpModel) -> Int { s.size }

pub fn image_transform_warp_model_get(s : ImagetransformwarpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_model_set(s : ImagetransformwarpModel, i : Int, v : Double) -> ImagetransformwarpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_sum(s : ImagetransformwarpModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_model_mean(s : ImagetransformwarpModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_model_scale(s : ImagetransformwarpModel, f : Double) -> ImagetransformwarpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_add(a : ImagetransformwarpModel, b : ImagetransformwarpModel) -> ImagetransformwarpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_model_copy(s : ImagetransformwarpModel) -> ImagetransformwarpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_fill(s : ImagetransformwarpModel, v : Double) -> ImagetransformwarpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_min(s : ImagetransformwarpModel) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_model_max(s : ImagetransformwarpModel) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_model_to_string(s : ImagetransformwarpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_layer_make(size : Int) -> ImagetransformwarpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_layer_len(s : ImagetransformwarpLayer) -> Int { s.size }

pub fn image_transform_warp_layer_get(s : ImagetransformwarpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_layer_set(s : ImagetransformwarpLayer, i : Int, v : Double) -> ImagetransformwarpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_sum(s : ImagetransformwarpLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_layer_mean(s : ImagetransformwarpLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_layer_scale(s : ImagetransformwarpLayer, f : Double) -> ImagetransformwarpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_add(a : ImagetransformwarpLayer, b : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_layer_copy(s : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_fill(s : ImagetransformwarpLayer, v : Double) -> ImagetransformwarpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_min(s : ImagetransformwarpLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_layer_max(s : ImagetransformwarpLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_layer_to_string(s : ImagetransformwarpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_buffer_make(size : Int) -> ImagetransformwarpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_buffer_len(s : ImagetransformwarpBuffer) -> Int { s.size }

pub fn image_transform_warp_buffer_get(s : ImagetransformwarpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_buffer_set(s : ImagetransformwarpBuffer, i : Int, v : Double) -> ImagetransformwarpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_sum(s : ImagetransformwarpBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_buffer_mean(s : ImagetransformwarpBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_buffer_scale(s : ImagetransformwarpBuffer, f : Double) -> ImagetransformwarpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_add(a : ImagetransformwarpBuffer, b : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_buffer_copy(s : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_fill(s : ImagetransformwarpBuffer, v : Double) -> ImagetransformwarpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_min(s : ImagetransformwarpBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_buffer_max(s : ImagetransformwarpBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_buffer_to_string(s : ImagetransformwarpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cursor_make(size : Int) -> ImagetransformwarpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_cursor_len(s : ImagetransformwarpCursor) -> Int { s.size }

pub fn image_transform_warp_cursor_get(s : ImagetransformwarpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_cursor_set(s : ImagetransformwarpCursor, i : Int, v : Double) -> ImagetransformwarpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_sum(s : ImagetransformwarpCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_cursor_mean(s : ImagetransformwarpCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_cursor_scale(s : ImagetransformwarpCursor, f : Double) -> ImagetransformwarpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_add(a : ImagetransformwarpCursor, b : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_cursor_copy(s : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_fill(s : ImagetransformwarpCursor, v : Double) -> ImagetransformwarpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_min(s : ImagetransformwarpCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_cursor_max(s : ImagetransformwarpCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_cursor_to_string(s : ImagetransformwarpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_view_make(size : Int) -> ImagetransformwarpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_view_len(s : ImagetransformwarpView) -> Int { s.size }

pub fn image_transform_warp_view_get(s : ImagetransformwarpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_view_set(s : ImagetransformwarpView, i : Int, v : Double) -> ImagetransformwarpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_sum(s : ImagetransformwarpView) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_view_mean(s : ImagetransformwarpView) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_view_scale(s : ImagetransformwarpView, f : Double) -> ImagetransformwarpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_add(a : ImagetransformwarpView, b : ImagetransformwarpView) -> ImagetransformwarpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_view_copy(s : ImagetransformwarpView) -> ImagetransformwarpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_fill(s : ImagetransformwarpView, v : Double) -> ImagetransformwarpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_min(s : ImagetransformwarpView) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_view_max(s : ImagetransformwarpView) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_view_to_string(s : ImagetransformwarpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_range_make(size : Int) -> ImagetransformwarpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_range_len(s : ImagetransformwarpRange) -> Int { s.size }

pub fn image_transform_warp_range_get(s : ImagetransformwarpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_range_set(s : ImagetransformwarpRange, i : Int, v : Double) -> ImagetransformwarpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_sum(s : ImagetransformwarpRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_range_mean(s : ImagetransformwarpRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_range_scale(s : ImagetransformwarpRange, f : Double) -> ImagetransformwarpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_add(a : ImagetransformwarpRange, b : ImagetransformwarpRange) -> ImagetransformwarpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_range_copy(s : ImagetransformwarpRange) -> ImagetransformwarpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_fill(s : ImagetransformwarpRange, v : Double) -> ImagetransformwarpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_min(s : ImagetransformwarpRange) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_range_max(s : ImagetransformwarpRange) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_range_to_string(s : ImagetransformwarpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_slice_make(size : Int) -> ImagetransformwarpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_slice_len(s : ImagetransformwarpSlice) -> Int { s.size }

pub fn image_transform_warp_slice_get(s : ImagetransformwarpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_slice_set(s : ImagetransformwarpSlice, i : Int, v : Double) -> ImagetransformwarpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_sum(s : ImagetransformwarpSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_slice_mean(s : ImagetransformwarpSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_slice_scale(s : ImagetransformwarpSlice, f : Double) -> ImagetransformwarpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_add(a : ImagetransformwarpSlice, b : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_slice_copy(s : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_fill(s : ImagetransformwarpSlice, v : Double) -> ImagetransformwarpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_min(s : ImagetransformwarpSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_slice_max(s : ImagetransformwarpSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_slice_to_string(s : ImagetransformwarpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

