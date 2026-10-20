///===
/// extcore/geo_intersect_circle

pub(all) struct GeointersectcirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_circle_make_point(x : Double, y : Double) -> GeointersectcirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_circle_make_point3(x : Double, y : Double, z : Double) -> GeointersectcirclePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectcirclePoint::x(self : GeointersectcirclePoint) -> Double { self.x }

pub fn GeointersectcirclePoint::y(self : GeointersectcirclePoint) -> Double { self.y }

pub fn GeointersectcirclePoint::z(self : GeointersectcirclePoint) -> Double { self.z }

pub fn GeointersectcirclePoint::label(self : GeointersectcirclePoint) -> Int { self.label }

pub fn GeointersectcirclePoint::dist(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectcirclePoint::add(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectcirclePoint::sub(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectcirclePoint::scale(self : GeointersectcirclePoint, s : Double) -> GeointersectcirclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectcirclePoint::dot(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectcirclePoint::cross(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectcirclePoint::norm(self : GeointersectcirclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectcirclePoint::normalize(self : GeointersectcirclePoint) -> GeointersectcirclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectcirclePoint::negate(self : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectcirclePoint::mid(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectcirclePoint::lerp(self : GeointersectcirclePoint, other : GeointersectcirclePoint, t : Double) -> GeointersectcirclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectcirclePoint::to_string(self : GeointersectcirclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectcircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_circle_make_series(vals : Array[Double], name : String) -> GeointersectcircleSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectcircleSeries::len(self : GeointersectcircleSeries) -> Int { self.vals.length() }

pub fn GeointersectcircleSeries::sum(self : GeointersectcircleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectcircleSeries::mean(self : GeointersectcircleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectcircleSeries::min(self : GeointersectcircleSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectcircleSeries::max(self : GeointersectcircleSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectcircleSeries::range(self : GeointersectcircleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectcircleSeries::variance(self : GeointersectcircleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectcircleSeries::std(self : GeointersectcircleSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectcircleSeries::median(self : GeointersectcircleSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectcircleSeries::scale(self : GeointersectcircleSeries, f : Double) -> GeointersectcircleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectcircleSeries::add(self : GeointersectcircleSeries, other : GeointersectcircleSeries) -> GeointersectcircleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectcircleSeries::sub(self : GeointersectcircleSeries, other : GeointersectcircleSeries) -> GeointersectcircleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectcircleSeries::normalize(self : GeointersectcircleSeries) -> GeointersectcircleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectcircleSeries::cumsum(self : GeointersectcircleSeries) -> GeointersectcircleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectcircleSeries::to_string(self : GeointersectcircleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectcircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectcircleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_circle_matrix_identity(n : Int) -> GeointersectcircleMatrix {
  let m = geo_intersect_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectcircleMatrix::get(self : GeointersectcircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectcircleMatrix::transpose(self : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  let result = geo_intersect_circle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectcircleMatrix::add(self : GeointersectcircleMatrix, other : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectcircleMatrix::scale(self : GeointersectcircleMatrix, s : Double) -> GeointersectcircleMatrix {
  let result = geo_intersect_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectcircleMatrix::multiply(self : GeointersectcircleMatrix, other : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  if self.cols != other.rows { return geo_intersect_circle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_circle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectcircleMatrix::trace(self : GeointersectcircleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectcircleMatrix::det(self : GeointersectcircleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectcircleMatrix::norm(self : GeointersectcircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectcircleMatrix::to_string(self : GeointersectcircleMatrix) -> String {
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

pub(all) struct GeointersectcircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_circle_make_vector(comps : Array[Double]) -> GeointersectcircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_circle_vector_zero(dim : Int) -> GeointersectcircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectcircleVector::add(self : GeointersectcircleVector, other : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectcircleVector::sub(self : GeointersectcircleVector, other : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectcircleVector::scale(self : GeointersectcircleVector, s : Double) -> GeointersectcircleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectcircleVector::dot(self : GeointersectcircleVector, other : GeointersectcircleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectcircleVector::norm(self : GeointersectcircleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectcircleVector::normalize(self : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectcircleVector::dist(self : GeointersectcircleVector, other : GeointersectcircleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectcircleVector::to_string(self : GeointersectcircleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_circle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_circle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_circle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_circle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_circle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_circle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_circle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_circle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_circle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_circle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_circle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_circle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_circle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_circle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_circle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_circle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_circle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_circle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_circle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_circle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_circle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_circle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_circle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_circle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_circle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_circle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_circle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_circle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_circle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectcircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_frame_make(size : Int) -> GeointersectcircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_frame_len(s : GeointersectcircleFrame) -> Int { s.size }

pub fn geo_intersect_circle_frame_get(s : GeointersectcircleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_frame_set(s : GeointersectcircleFrame, i : Int, v : Double) -> GeointersectcircleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_frame_sum(s : GeointersectcircleFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_frame_mean(s : GeointersectcircleFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_frame_scale(s : GeointersectcircleFrame, f : Double) -> GeointersectcircleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_frame_add(a : GeointersectcircleFrame, b : GeointersectcircleFrame) -> GeointersectcircleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_frame_copy(s : GeointersectcircleFrame) -> GeointersectcircleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_frame_fill(s : GeointersectcircleFrame, v : Double) -> GeointersectcircleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_frame_min(s : GeointersectcircleFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_frame_max(s : GeointersectcircleFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_frame_to_string(s : GeointersectcircleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_table_make(size : Int) -> GeointersectcircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_table_len(s : GeointersectcircleTable) -> Int { s.size }

pub fn geo_intersect_circle_table_get(s : GeointersectcircleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_table_set(s : GeointersectcircleTable, i : Int, v : Double) -> GeointersectcircleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_table_sum(s : GeointersectcircleTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_table_mean(s : GeointersectcircleTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_table_scale(s : GeointersectcircleTable, f : Double) -> GeointersectcircleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_table_add(a : GeointersectcircleTable, b : GeointersectcircleTable) -> GeointersectcircleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_table_copy(s : GeointersectcircleTable) -> GeointersectcircleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_table_fill(s : GeointersectcircleTable, v : Double) -> GeointersectcircleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_table_min(s : GeointersectcircleTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_table_max(s : GeointersectcircleTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_table_to_string(s : GeointersectcircleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_graphn_make(size : Int) -> GeointersectcircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_graphn_len(s : GeointersectcircleGraphN) -> Int { s.size }

pub fn geo_intersect_circle_graphn_get(s : GeointersectcircleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_graphn_set(s : GeointersectcircleGraphN, i : Int, v : Double) -> GeointersectcircleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_graphn_sum(s : GeointersectcircleGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_graphn_mean(s : GeointersectcircleGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_graphn_scale(s : GeointersectcircleGraphN, f : Double) -> GeointersectcircleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_graphn_add(a : GeointersectcircleGraphN, b : GeointersectcircleGraphN) -> GeointersectcircleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_graphn_copy(s : GeointersectcircleGraphN) -> GeointersectcircleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_graphn_fill(s : GeointersectcircleGraphN, v : Double) -> GeointersectcircleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_graphn_min(s : GeointersectcircleGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_graphn_max(s : GeointersectcircleGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_graphn_to_string(s : GeointersectcircleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_node_make(size : Int) -> GeointersectcircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_node_len(s : GeointersectcircleNode) -> Int { s.size }

pub fn geo_intersect_circle_node_get(s : GeointersectcircleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_node_set(s : GeointersectcircleNode, i : Int, v : Double) -> GeointersectcircleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_node_sum(s : GeointersectcircleNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_node_mean(s : GeointersectcircleNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_node_scale(s : GeointersectcircleNode, f : Double) -> GeointersectcircleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_node_add(a : GeointersectcircleNode, b : GeointersectcircleNode) -> GeointersectcircleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_node_copy(s : GeointersectcircleNode) -> GeointersectcircleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_node_fill(s : GeointersectcircleNode, v : Double) -> GeointersectcircleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_node_min(s : GeointersectcircleNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_node_max(s : GeointersectcircleNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_node_to_string(s : GeointersectcircleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_edge_make(size : Int) -> GeointersectcircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_edge_len(s : GeointersectcircleEdge) -> Int { s.size }

pub fn geo_intersect_circle_edge_get(s : GeointersectcircleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_edge_set(s : GeointersectcircleEdge, i : Int, v : Double) -> GeointersectcircleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_edge_sum(s : GeointersectcircleEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_edge_mean(s : GeointersectcircleEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_edge_scale(s : GeointersectcircleEdge, f : Double) -> GeointersectcircleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_edge_add(a : GeointersectcircleEdge, b : GeointersectcircleEdge) -> GeointersectcircleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_edge_copy(s : GeointersectcircleEdge) -> GeointersectcircleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_edge_fill(s : GeointersectcircleEdge, v : Double) -> GeointersectcircleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_edge_min(s : GeointersectcircleEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_edge_max(s : GeointersectcircleEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_edge_to_string(s : GeointersectcircleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_path_make(size : Int) -> GeointersectcirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_path_len(s : GeointersectcirclePath) -> Int { s.size }

pub fn geo_intersect_circle_path_get(s : GeointersectcirclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_path_set(s : GeointersectcirclePath, i : Int, v : Double) -> GeointersectcirclePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_path_sum(s : GeointersectcirclePath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_path_mean(s : GeointersectcirclePath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_path_scale(s : GeointersectcirclePath, f : Double) -> GeointersectcirclePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_path_add(a : GeointersectcirclePath, b : GeointersectcirclePath) -> GeointersectcirclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_path_copy(s : GeointersectcirclePath) -> GeointersectcirclePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_path_fill(s : GeointersectcirclePath, v : Double) -> GeointersectcirclePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_path_min(s : GeointersectcirclePath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_path_max(s : GeointersectcirclePath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_path_to_string(s : GeointersectcirclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_cluster_make(size : Int) -> GeointersectcircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_cluster_len(s : GeointersectcircleCluster) -> Int { s.size }

pub fn geo_intersect_circle_cluster_get(s : GeointersectcircleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_cluster_set(s : GeointersectcircleCluster, i : Int, v : Double) -> GeointersectcircleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cluster_sum(s : GeointersectcircleCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_cluster_mean(s : GeointersectcircleCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_cluster_scale(s : GeointersectcircleCluster, f : Double) -> GeointersectcircleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cluster_add(a : GeointersectcircleCluster, b : GeointersectcircleCluster) -> GeointersectcircleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_cluster_copy(s : GeointersectcircleCluster) -> GeointersectcircleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cluster_fill(s : GeointersectcircleCluster, v : Double) -> GeointersectcircleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cluster_min(s : GeointersectcircleCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_cluster_max(s : GeointersectcircleCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_cluster_to_string(s : GeointersectcircleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_model_make(size : Int) -> GeointersectcircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_model_len(s : GeointersectcircleModel) -> Int { s.size }

pub fn geo_intersect_circle_model_get(s : GeointersectcircleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_model_set(s : GeointersectcircleModel, i : Int, v : Double) -> GeointersectcircleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_model_sum(s : GeointersectcircleModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_model_mean(s : GeointersectcircleModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_model_scale(s : GeointersectcircleModel, f : Double) -> GeointersectcircleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_model_add(a : GeointersectcircleModel, b : GeointersectcircleModel) -> GeointersectcircleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_model_copy(s : GeointersectcircleModel) -> GeointersectcircleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_model_fill(s : GeointersectcircleModel, v : Double) -> GeointersectcircleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_model_min(s : GeointersectcircleModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_model_max(s : GeointersectcircleModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_model_to_string(s : GeointersectcircleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_layer_make(size : Int) -> GeointersectcircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_layer_len(s : GeointersectcircleLayer) -> Int { s.size }

pub fn geo_intersect_circle_layer_get(s : GeointersectcircleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_layer_set(s : GeointersectcircleLayer, i : Int, v : Double) -> GeointersectcircleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_layer_sum(s : GeointersectcircleLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_layer_mean(s : GeointersectcircleLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_layer_scale(s : GeointersectcircleLayer, f : Double) -> GeointersectcircleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_layer_add(a : GeointersectcircleLayer, b : GeointersectcircleLayer) -> GeointersectcircleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_layer_copy(s : GeointersectcircleLayer) -> GeointersectcircleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_layer_fill(s : GeointersectcircleLayer, v : Double) -> GeointersectcircleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_layer_min(s : GeointersectcircleLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_layer_max(s : GeointersectcircleLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_layer_to_string(s : GeointersectcircleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_buffer_make(size : Int) -> GeointersectcircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_buffer_len(s : GeointersectcircleBuffer) -> Int { s.size }

pub fn geo_intersect_circle_buffer_get(s : GeointersectcircleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_buffer_set(s : GeointersectcircleBuffer, i : Int, v : Double) -> GeointersectcircleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_buffer_sum(s : GeointersectcircleBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_buffer_mean(s : GeointersectcircleBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_buffer_scale(s : GeointersectcircleBuffer, f : Double) -> GeointersectcircleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_buffer_add(a : GeointersectcircleBuffer, b : GeointersectcircleBuffer) -> GeointersectcircleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_buffer_copy(s : GeointersectcircleBuffer) -> GeointersectcircleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_buffer_fill(s : GeointersectcircleBuffer, v : Double) -> GeointersectcircleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_buffer_min(s : GeointersectcircleBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_buffer_max(s : GeointersectcircleBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_buffer_to_string(s : GeointersectcircleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_cursor_make(size : Int) -> GeointersectcircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_cursor_len(s : GeointersectcircleCursor) -> Int { s.size }

pub fn geo_intersect_circle_cursor_get(s : GeointersectcircleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_cursor_set(s : GeointersectcircleCursor, i : Int, v : Double) -> GeointersectcircleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cursor_sum(s : GeointersectcircleCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_cursor_mean(s : GeointersectcircleCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_cursor_scale(s : GeointersectcircleCursor, f : Double) -> GeointersectcircleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cursor_add(a : GeointersectcircleCursor, b : GeointersectcircleCursor) -> GeointersectcircleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_cursor_copy(s : GeointersectcircleCursor) -> GeointersectcircleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cursor_fill(s : GeointersectcircleCursor, v : Double) -> GeointersectcircleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_cursor_min(s : GeointersectcircleCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_cursor_max(s : GeointersectcircleCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_cursor_to_string(s : GeointersectcircleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_view_make(size : Int) -> GeointersectcircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_view_len(s : GeointersectcircleView) -> Int { s.size }

pub fn geo_intersect_circle_view_get(s : GeointersectcircleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_view_set(s : GeointersectcircleView, i : Int, v : Double) -> GeointersectcircleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_view_sum(s : GeointersectcircleView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_view_mean(s : GeointersectcircleView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_view_scale(s : GeointersectcircleView, f : Double) -> GeointersectcircleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_view_add(a : GeointersectcircleView, b : GeointersectcircleView) -> GeointersectcircleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_view_copy(s : GeointersectcircleView) -> GeointersectcircleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_view_fill(s : GeointersectcircleView, v : Double) -> GeointersectcircleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_view_min(s : GeointersectcircleView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_view_max(s : GeointersectcircleView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_view_to_string(s : GeointersectcircleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_range_make(size : Int) -> GeointersectcircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_range_len(s : GeointersectcircleRange) -> Int { s.size }

pub fn geo_intersect_circle_range_get(s : GeointersectcircleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_range_set(s : GeointersectcircleRange, i : Int, v : Double) -> GeointersectcircleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_range_sum(s : GeointersectcircleRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_range_mean(s : GeointersectcircleRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_range_scale(s : GeointersectcircleRange, f : Double) -> GeointersectcircleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_range_add(a : GeointersectcircleRange, b : GeointersectcircleRange) -> GeointersectcircleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_range_copy(s : GeointersectcircleRange) -> GeointersectcircleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_range_fill(s : GeointersectcircleRange, v : Double) -> GeointersectcircleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_range_min(s : GeointersectcircleRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_range_max(s : GeointersectcircleRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_range_to_string(s : GeointersectcircleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_slice_make(size : Int) -> GeointersectcircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_circle_slice_len(s : GeointersectcircleSlice) -> Int { s.size }

pub fn geo_intersect_circle_slice_get(s : GeointersectcircleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_circle_slice_set(s : GeointersectcircleSlice, i : Int, v : Double) -> GeointersectcircleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_slice_sum(s : GeointersectcircleSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_circle_slice_mean(s : GeointersectcircleSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_circle_slice_scale(s : GeointersectcircleSlice, f : Double) -> GeointersectcircleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_slice_add(a : GeointersectcircleSlice, b : GeointersectcircleSlice) -> GeointersectcircleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_circle_slice_copy(s : GeointersectcircleSlice) -> GeointersectcircleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_slice_fill(s : GeointersectcircleSlice, v : Double) -> GeointersectcircleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_circle_slice_min(s : GeointersectcircleSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_circle_slice_max(s : GeointersectcircleSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_circle_slice_to_string(s : GeointersectcircleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

