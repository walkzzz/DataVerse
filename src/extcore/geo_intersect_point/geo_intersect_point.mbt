///===
/// extcore/geo_intersect_point

pub(all) struct GeointersectpointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_point_make_point(x : Double, y : Double) -> GeointersectpointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_point_make_point3(x : Double, y : Double, z : Double) -> GeointersectpointPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectpointPoint::x(self : GeointersectpointPoint) -> Double { self.x }

pub fn GeointersectpointPoint::y(self : GeointersectpointPoint) -> Double { self.y }

pub fn GeointersectpointPoint::z(self : GeointersectpointPoint) -> Double { self.z }

pub fn GeointersectpointPoint::label(self : GeointersectpointPoint) -> Int { self.label }

pub fn GeointersectpointPoint::dist(self : GeointersectpointPoint, other : GeointersectpointPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectpointPoint::add(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectpointPoint::sub(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectpointPoint::scale(self : GeointersectpointPoint, s : Double) -> GeointersectpointPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectpointPoint::dot(self : GeointersectpointPoint, other : GeointersectpointPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectpointPoint::cross(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectpointPoint::norm(self : GeointersectpointPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectpointPoint::normalize(self : GeointersectpointPoint) -> GeointersectpointPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpointPoint::negate(self : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectpointPoint::mid(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectpointPoint::lerp(self : GeointersectpointPoint, other : GeointersectpointPoint, t : Double) -> GeointersectpointPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectpointPoint::to_string(self : GeointersectpointPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectpointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_point_make_series(vals : Array[Double], name : String) -> GeointersectpointSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectpointSeries::len(self : GeointersectpointSeries) -> Int { self.vals.length() }

pub fn GeointersectpointSeries::sum(self : GeointersectpointSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectpointSeries::mean(self : GeointersectpointSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectpointSeries::min(self : GeointersectpointSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectpointSeries::max(self : GeointersectpointSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectpointSeries::range(self : GeointersectpointSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectpointSeries::variance(self : GeointersectpointSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectpointSeries::std(self : GeointersectpointSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectpointSeries::median(self : GeointersectpointSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectpointSeries::scale(self : GeointersectpointSeries, f : Double) -> GeointersectpointSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectpointSeries::add(self : GeointersectpointSeries, other : GeointersectpointSeries) -> GeointersectpointSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectpointSeries::sub(self : GeointersectpointSeries, other : GeointersectpointSeries) -> GeointersectpointSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectpointSeries::normalize(self : GeointersectpointSeries) -> GeointersectpointSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectpointSeries::cumsum(self : GeointersectpointSeries) -> GeointersectpointSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectpointSeries::to_string(self : GeointersectpointSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_point_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectpointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_point_matrix_identity(n : Int) -> GeointersectpointMatrix {
  let m = geo_intersect_point_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectpointMatrix::get(self : GeointersectpointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectpointMatrix::transpose(self : GeointersectpointMatrix) -> GeointersectpointMatrix {
  let result = geo_intersect_point_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectpointMatrix::add(self : GeointersectpointMatrix, other : GeointersectpointMatrix) -> GeointersectpointMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectpointMatrix::scale(self : GeointersectpointMatrix, s : Double) -> GeointersectpointMatrix {
  let result = geo_intersect_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectpointMatrix::multiply(self : GeointersectpointMatrix, other : GeointersectpointMatrix) -> GeointersectpointMatrix {
  if self.cols != other.rows { return geo_intersect_point_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_point_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectpointMatrix::trace(self : GeointersectpointMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectpointMatrix::det(self : GeointersectpointMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectpointMatrix::norm(self : GeointersectpointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectpointMatrix::to_string(self : GeointersectpointMatrix) -> String {
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

pub(all) struct GeointersectpointVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_point_make_vector(comps : Array[Double]) -> GeointersectpointVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_point_vector_zero(dim : Int) -> GeointersectpointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectpointVector::add(self : GeointersectpointVector, other : GeointersectpointVector) -> GeointersectpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpointVector::sub(self : GeointersectpointVector, other : GeointersectpointVector) -> GeointersectpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpointVector::scale(self : GeointersectpointVector, s : Double) -> GeointersectpointVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectpointVector::dot(self : GeointersectpointVector, other : GeointersectpointVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectpointVector::norm(self : GeointersectpointVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectpointVector::normalize(self : GeointersectpointVector) -> GeointersectpointVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpointVector::dist(self : GeointersectpointVector, other : GeointersectpointVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectpointVector::to_string(self : GeointersectpointVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_point_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_point_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_point_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_point_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_point_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_point_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_point_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_point_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_point_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_point_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_point_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_point_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_point_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_point_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_point_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_point_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_point_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_point_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_point_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_point_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_point_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_point_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_point_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_point_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_point_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_point_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_point_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_point_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_point_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectpointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_frame_make(size : Int) -> GeointersectpointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_frame_len(s : GeointersectpointFrame) -> Int { s.size }

pub fn geo_intersect_point_frame_get(s : GeointersectpointFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_frame_set(s : GeointersectpointFrame, i : Int, v : Double) -> GeointersectpointFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_frame_sum(s : GeointersectpointFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_frame_mean(s : GeointersectpointFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_frame_scale(s : GeointersectpointFrame, f : Double) -> GeointersectpointFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_frame_add(a : GeointersectpointFrame, b : GeointersectpointFrame) -> GeointersectpointFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_frame_copy(s : GeointersectpointFrame) -> GeointersectpointFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_frame_fill(s : GeointersectpointFrame, v : Double) -> GeointersectpointFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_frame_min(s : GeointersectpointFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_frame_max(s : GeointersectpointFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_frame_to_string(s : GeointersectpointFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_table_make(size : Int) -> GeointersectpointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_table_len(s : GeointersectpointTable) -> Int { s.size }

pub fn geo_intersect_point_table_get(s : GeointersectpointTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_table_set(s : GeointersectpointTable, i : Int, v : Double) -> GeointersectpointTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_table_sum(s : GeointersectpointTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_table_mean(s : GeointersectpointTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_table_scale(s : GeointersectpointTable, f : Double) -> GeointersectpointTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_table_add(a : GeointersectpointTable, b : GeointersectpointTable) -> GeointersectpointTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_table_copy(s : GeointersectpointTable) -> GeointersectpointTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_table_fill(s : GeointersectpointTable, v : Double) -> GeointersectpointTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_table_min(s : GeointersectpointTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_table_max(s : GeointersectpointTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_table_to_string(s : GeointersectpointTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_graphn_make(size : Int) -> GeointersectpointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_graphn_len(s : GeointersectpointGraphN) -> Int { s.size }

pub fn geo_intersect_point_graphn_get(s : GeointersectpointGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_graphn_set(s : GeointersectpointGraphN, i : Int, v : Double) -> GeointersectpointGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_graphn_sum(s : GeointersectpointGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_graphn_mean(s : GeointersectpointGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_graphn_scale(s : GeointersectpointGraphN, f : Double) -> GeointersectpointGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_graphn_add(a : GeointersectpointGraphN, b : GeointersectpointGraphN) -> GeointersectpointGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_graphn_copy(s : GeointersectpointGraphN) -> GeointersectpointGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_graphn_fill(s : GeointersectpointGraphN, v : Double) -> GeointersectpointGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_graphn_min(s : GeointersectpointGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_graphn_max(s : GeointersectpointGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_graphn_to_string(s : GeointersectpointGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_node_make(size : Int) -> GeointersectpointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_node_len(s : GeointersectpointNode) -> Int { s.size }

pub fn geo_intersect_point_node_get(s : GeointersectpointNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_node_set(s : GeointersectpointNode, i : Int, v : Double) -> GeointersectpointNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_node_sum(s : GeointersectpointNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_node_mean(s : GeointersectpointNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_node_scale(s : GeointersectpointNode, f : Double) -> GeointersectpointNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_node_add(a : GeointersectpointNode, b : GeointersectpointNode) -> GeointersectpointNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_node_copy(s : GeointersectpointNode) -> GeointersectpointNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_node_fill(s : GeointersectpointNode, v : Double) -> GeointersectpointNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_node_min(s : GeointersectpointNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_node_max(s : GeointersectpointNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_node_to_string(s : GeointersectpointNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_edge_make(size : Int) -> GeointersectpointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_edge_len(s : GeointersectpointEdge) -> Int { s.size }

pub fn geo_intersect_point_edge_get(s : GeointersectpointEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_edge_set(s : GeointersectpointEdge, i : Int, v : Double) -> GeointersectpointEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_edge_sum(s : GeointersectpointEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_edge_mean(s : GeointersectpointEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_edge_scale(s : GeointersectpointEdge, f : Double) -> GeointersectpointEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_edge_add(a : GeointersectpointEdge, b : GeointersectpointEdge) -> GeointersectpointEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_edge_copy(s : GeointersectpointEdge) -> GeointersectpointEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_edge_fill(s : GeointersectpointEdge, v : Double) -> GeointersectpointEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_edge_min(s : GeointersectpointEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_edge_max(s : GeointersectpointEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_edge_to_string(s : GeointersectpointEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_path_make(size : Int) -> GeointersectpointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_path_len(s : GeointersectpointPath) -> Int { s.size }

pub fn geo_intersect_point_path_get(s : GeointersectpointPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_path_set(s : GeointersectpointPath, i : Int, v : Double) -> GeointersectpointPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_path_sum(s : GeointersectpointPath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_path_mean(s : GeointersectpointPath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_path_scale(s : GeointersectpointPath, f : Double) -> GeointersectpointPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_path_add(a : GeointersectpointPath, b : GeointersectpointPath) -> GeointersectpointPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_path_copy(s : GeointersectpointPath) -> GeointersectpointPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_path_fill(s : GeointersectpointPath, v : Double) -> GeointersectpointPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_path_min(s : GeointersectpointPath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_path_max(s : GeointersectpointPath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_path_to_string(s : GeointersectpointPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_cluster_make(size : Int) -> GeointersectpointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_cluster_len(s : GeointersectpointCluster) -> Int { s.size }

pub fn geo_intersect_point_cluster_get(s : GeointersectpointCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_cluster_set(s : GeointersectpointCluster, i : Int, v : Double) -> GeointersectpointCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cluster_sum(s : GeointersectpointCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_cluster_mean(s : GeointersectpointCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_cluster_scale(s : GeointersectpointCluster, f : Double) -> GeointersectpointCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cluster_add(a : GeointersectpointCluster, b : GeointersectpointCluster) -> GeointersectpointCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_cluster_copy(s : GeointersectpointCluster) -> GeointersectpointCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cluster_fill(s : GeointersectpointCluster, v : Double) -> GeointersectpointCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cluster_min(s : GeointersectpointCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_cluster_max(s : GeointersectpointCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_cluster_to_string(s : GeointersectpointCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_model_make(size : Int) -> GeointersectpointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_model_len(s : GeointersectpointModel) -> Int { s.size }

pub fn geo_intersect_point_model_get(s : GeointersectpointModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_model_set(s : GeointersectpointModel, i : Int, v : Double) -> GeointersectpointModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_model_sum(s : GeointersectpointModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_model_mean(s : GeointersectpointModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_model_scale(s : GeointersectpointModel, f : Double) -> GeointersectpointModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_model_add(a : GeointersectpointModel, b : GeointersectpointModel) -> GeointersectpointModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_model_copy(s : GeointersectpointModel) -> GeointersectpointModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_model_fill(s : GeointersectpointModel, v : Double) -> GeointersectpointModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_model_min(s : GeointersectpointModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_model_max(s : GeointersectpointModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_model_to_string(s : GeointersectpointModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_layer_make(size : Int) -> GeointersectpointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_layer_len(s : GeointersectpointLayer) -> Int { s.size }

pub fn geo_intersect_point_layer_get(s : GeointersectpointLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_layer_set(s : GeointersectpointLayer, i : Int, v : Double) -> GeointersectpointLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_layer_sum(s : GeointersectpointLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_layer_mean(s : GeointersectpointLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_layer_scale(s : GeointersectpointLayer, f : Double) -> GeointersectpointLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_layer_add(a : GeointersectpointLayer, b : GeointersectpointLayer) -> GeointersectpointLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_layer_copy(s : GeointersectpointLayer) -> GeointersectpointLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_layer_fill(s : GeointersectpointLayer, v : Double) -> GeointersectpointLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_layer_min(s : GeointersectpointLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_layer_max(s : GeointersectpointLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_layer_to_string(s : GeointersectpointLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_buffer_make(size : Int) -> GeointersectpointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_buffer_len(s : GeointersectpointBuffer) -> Int { s.size }

pub fn geo_intersect_point_buffer_get(s : GeointersectpointBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_buffer_set(s : GeointersectpointBuffer, i : Int, v : Double) -> GeointersectpointBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_buffer_sum(s : GeointersectpointBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_buffer_mean(s : GeointersectpointBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_buffer_scale(s : GeointersectpointBuffer, f : Double) -> GeointersectpointBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_buffer_add(a : GeointersectpointBuffer, b : GeointersectpointBuffer) -> GeointersectpointBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_buffer_copy(s : GeointersectpointBuffer) -> GeointersectpointBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_buffer_fill(s : GeointersectpointBuffer, v : Double) -> GeointersectpointBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_buffer_min(s : GeointersectpointBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_buffer_max(s : GeointersectpointBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_buffer_to_string(s : GeointersectpointBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_cursor_make(size : Int) -> GeointersectpointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_cursor_len(s : GeointersectpointCursor) -> Int { s.size }

pub fn geo_intersect_point_cursor_get(s : GeointersectpointCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_cursor_set(s : GeointersectpointCursor, i : Int, v : Double) -> GeointersectpointCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cursor_sum(s : GeointersectpointCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_cursor_mean(s : GeointersectpointCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_cursor_scale(s : GeointersectpointCursor, f : Double) -> GeointersectpointCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cursor_add(a : GeointersectpointCursor, b : GeointersectpointCursor) -> GeointersectpointCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_cursor_copy(s : GeointersectpointCursor) -> GeointersectpointCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cursor_fill(s : GeointersectpointCursor, v : Double) -> GeointersectpointCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_cursor_min(s : GeointersectpointCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_cursor_max(s : GeointersectpointCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_cursor_to_string(s : GeointersectpointCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_view_make(size : Int) -> GeointersectpointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_view_len(s : GeointersectpointView) -> Int { s.size }

pub fn geo_intersect_point_view_get(s : GeointersectpointView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_view_set(s : GeointersectpointView, i : Int, v : Double) -> GeointersectpointView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_view_sum(s : GeointersectpointView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_view_mean(s : GeointersectpointView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_view_scale(s : GeointersectpointView, f : Double) -> GeointersectpointView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_view_add(a : GeointersectpointView, b : GeointersectpointView) -> GeointersectpointView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_view_copy(s : GeointersectpointView) -> GeointersectpointView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_view_fill(s : GeointersectpointView, v : Double) -> GeointersectpointView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_view_min(s : GeointersectpointView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_view_max(s : GeointersectpointView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_view_to_string(s : GeointersectpointView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_range_make(size : Int) -> GeointersectpointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_range_len(s : GeointersectpointRange) -> Int { s.size }

pub fn geo_intersect_point_range_get(s : GeointersectpointRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_range_set(s : GeointersectpointRange, i : Int, v : Double) -> GeointersectpointRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_range_sum(s : GeointersectpointRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_range_mean(s : GeointersectpointRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_range_scale(s : GeointersectpointRange, f : Double) -> GeointersectpointRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_range_add(a : GeointersectpointRange, b : GeointersectpointRange) -> GeointersectpointRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_range_copy(s : GeointersectpointRange) -> GeointersectpointRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_range_fill(s : GeointersectpointRange, v : Double) -> GeointersectpointRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_range_min(s : GeointersectpointRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_range_max(s : GeointersectpointRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_range_to_string(s : GeointersectpointRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_slice_make(size : Int) -> GeointersectpointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_point_slice_len(s : GeointersectpointSlice) -> Int { s.size }

pub fn geo_intersect_point_slice_get(s : GeointersectpointSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_point_slice_set(s : GeointersectpointSlice, i : Int, v : Double) -> GeointersectpointSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_slice_sum(s : GeointersectpointSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_point_slice_mean(s : GeointersectpointSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_point_slice_scale(s : GeointersectpointSlice, f : Double) -> GeointersectpointSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_slice_add(a : GeointersectpointSlice, b : GeointersectpointSlice) -> GeointersectpointSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_point_slice_copy(s : GeointersectpointSlice) -> GeointersectpointSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_slice_fill(s : GeointersectpointSlice, v : Double) -> GeointersectpointSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_point_slice_min(s : GeointersectpointSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_point_slice_max(s : GeointersectpointSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_point_slice_to_string(s : GeointersectpointSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

