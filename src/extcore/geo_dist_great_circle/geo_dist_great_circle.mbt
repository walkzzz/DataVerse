///===
/// extcore/geo_dist_great_circle

pub(all) struct GeodistgreatcirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_great_circle_make_point(x : Double, y : Double) -> GeodistgreatcirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_great_circle_make_point3(x : Double, y : Double, z : Double) -> GeodistgreatcirclePoint {
  { x, y, z, label: 0 }
}

pub fn GeodistgreatcirclePoint::x(self : GeodistgreatcirclePoint) -> Double { self.x }

pub fn GeodistgreatcirclePoint::y(self : GeodistgreatcirclePoint) -> Double { self.y }

pub fn GeodistgreatcirclePoint::z(self : GeodistgreatcirclePoint) -> Double { self.z }

pub fn GeodistgreatcirclePoint::label(self : GeodistgreatcirclePoint) -> Int { self.label }

pub fn GeodistgreatcirclePoint::dist(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistgreatcirclePoint::add(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistgreatcirclePoint::sub(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistgreatcirclePoint::scale(self : GeodistgreatcirclePoint, s : Double) -> GeodistgreatcirclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistgreatcirclePoint::dot(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistgreatcirclePoint::cross(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistgreatcirclePoint::norm(self : GeodistgreatcirclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistgreatcirclePoint::normalize(self : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgreatcirclePoint::negate(self : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistgreatcirclePoint::mid(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint) -> GeodistgreatcirclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistgreatcirclePoint::lerp(self : GeodistgreatcirclePoint, other : GeodistgreatcirclePoint, t : Double) -> GeodistgreatcirclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistgreatcirclePoint::to_string(self : GeodistgreatcirclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistgreatcircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_great_circle_make_series(vals : Array[Double], name : String) -> GeodistgreatcircleSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistgreatcircleSeries::len(self : GeodistgreatcircleSeries) -> Int { self.vals.length() }

pub fn GeodistgreatcircleSeries::sum(self : GeodistgreatcircleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistgreatcircleSeries::mean(self : GeodistgreatcircleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistgreatcircleSeries::min(self : GeodistgreatcircleSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistgreatcircleSeries::max(self : GeodistgreatcircleSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistgreatcircleSeries::range(self : GeodistgreatcircleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistgreatcircleSeries::variance(self : GeodistgreatcircleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistgreatcircleSeries::std(self : GeodistgreatcircleSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistgreatcircleSeries::median(self : GeodistgreatcircleSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistgreatcircleSeries::scale(self : GeodistgreatcircleSeries, f : Double) -> GeodistgreatcircleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistgreatcircleSeries::add(self : GeodistgreatcircleSeries, other : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistgreatcircleSeries::sub(self : GeodistgreatcircleSeries, other : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistgreatcircleSeries::normalize(self : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistgreatcircleSeries::cumsum(self : GeodistgreatcircleSeries) -> GeodistgreatcircleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistgreatcircleSeries::to_string(self : GeodistgreatcircleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistgreatcircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_great_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistgreatcircleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_great_circle_matrix_identity(n : Int) -> GeodistgreatcircleMatrix {
  let m = geo_dist_great_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistgreatcircleMatrix::get(self : GeodistgreatcircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistgreatcircleMatrix::transpose(self : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  let result = geo_dist_great_circle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistgreatcircleMatrix::add(self : GeodistgreatcircleMatrix, other : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_great_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistgreatcircleMatrix::scale(self : GeodistgreatcircleMatrix, s : Double) -> GeodistgreatcircleMatrix {
  let result = geo_dist_great_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistgreatcircleMatrix::multiply(self : GeodistgreatcircleMatrix, other : GeodistgreatcircleMatrix) -> GeodistgreatcircleMatrix {
  if self.cols != other.rows { return geo_dist_great_circle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_great_circle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistgreatcircleMatrix::trace(self : GeodistgreatcircleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistgreatcircleMatrix::det(self : GeodistgreatcircleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistgreatcircleMatrix::norm(self : GeodistgreatcircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistgreatcircleMatrix::to_string(self : GeodistgreatcircleMatrix) -> String {
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

pub(all) struct GeodistgreatcircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_great_circle_make_vector(comps : Array[Double]) -> GeodistgreatcircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_great_circle_vector_zero(dim : Int) -> GeodistgreatcircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistgreatcircleVector::add(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgreatcircleVector::sub(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgreatcircleVector::scale(self : GeodistgreatcircleVector, s : Double) -> GeodistgreatcircleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistgreatcircleVector::dot(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistgreatcircleVector::norm(self : GeodistgreatcircleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistgreatcircleVector::normalize(self : GeodistgreatcircleVector) -> GeodistgreatcircleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgreatcircleVector::dist(self : GeodistgreatcircleVector, other : GeodistgreatcircleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistgreatcircleVector::to_string(self : GeodistgreatcircleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_great_circle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_great_circle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_great_circle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_great_circle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_great_circle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_great_circle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_great_circle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_great_circle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_great_circle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_great_circle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_great_circle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_great_circle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_great_circle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_great_circle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_great_circle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_great_circle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_great_circle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_great_circle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_great_circle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_great_circle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_great_circle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_great_circle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_great_circle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_great_circle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_great_circle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_great_circle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_great_circle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_great_circle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_great_circle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistgreatcircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_frame_make(size : Int) -> GeodistgreatcircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_frame_len(s : GeodistgreatcircleFrame) -> Int { s.size }

pub fn geo_dist_great_circle_frame_get(s : GeodistgreatcircleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_frame_set(s : GeodistgreatcircleFrame, i : Int, v : Double) -> GeodistgreatcircleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_frame_sum(s : GeodistgreatcircleFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_frame_mean(s : GeodistgreatcircleFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_frame_scale(s : GeodistgreatcircleFrame, f : Double) -> GeodistgreatcircleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_frame_add(a : GeodistgreatcircleFrame, b : GeodistgreatcircleFrame) -> GeodistgreatcircleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_frame_copy(s : GeodistgreatcircleFrame) -> GeodistgreatcircleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_frame_fill(s : GeodistgreatcircleFrame, v : Double) -> GeodistgreatcircleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_frame_min(s : GeodistgreatcircleFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_frame_max(s : GeodistgreatcircleFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_frame_to_string(s : GeodistgreatcircleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_table_make(size : Int) -> GeodistgreatcircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_table_len(s : GeodistgreatcircleTable) -> Int { s.size }

pub fn geo_dist_great_circle_table_get(s : GeodistgreatcircleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_table_set(s : GeodistgreatcircleTable, i : Int, v : Double) -> GeodistgreatcircleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_table_sum(s : GeodistgreatcircleTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_table_mean(s : GeodistgreatcircleTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_table_scale(s : GeodistgreatcircleTable, f : Double) -> GeodistgreatcircleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_table_add(a : GeodistgreatcircleTable, b : GeodistgreatcircleTable) -> GeodistgreatcircleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_table_copy(s : GeodistgreatcircleTable) -> GeodistgreatcircleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_table_fill(s : GeodistgreatcircleTable, v : Double) -> GeodistgreatcircleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_table_min(s : GeodistgreatcircleTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_table_max(s : GeodistgreatcircleTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_table_to_string(s : GeodistgreatcircleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_graphn_make(size : Int) -> GeodistgreatcircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_graphn_len(s : GeodistgreatcircleGraphN) -> Int { s.size }

pub fn geo_dist_great_circle_graphn_get(s : GeodistgreatcircleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_graphn_set(s : GeodistgreatcircleGraphN, i : Int, v : Double) -> GeodistgreatcircleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_graphn_sum(s : GeodistgreatcircleGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_graphn_mean(s : GeodistgreatcircleGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_graphn_scale(s : GeodistgreatcircleGraphN, f : Double) -> GeodistgreatcircleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_graphn_add(a : GeodistgreatcircleGraphN, b : GeodistgreatcircleGraphN) -> GeodistgreatcircleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_graphn_copy(s : GeodistgreatcircleGraphN) -> GeodistgreatcircleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_graphn_fill(s : GeodistgreatcircleGraphN, v : Double) -> GeodistgreatcircleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_graphn_min(s : GeodistgreatcircleGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_graphn_max(s : GeodistgreatcircleGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_graphn_to_string(s : GeodistgreatcircleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_node_make(size : Int) -> GeodistgreatcircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_node_len(s : GeodistgreatcircleNode) -> Int { s.size }

pub fn geo_dist_great_circle_node_get(s : GeodistgreatcircleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_node_set(s : GeodistgreatcircleNode, i : Int, v : Double) -> GeodistgreatcircleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_node_sum(s : GeodistgreatcircleNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_node_mean(s : GeodistgreatcircleNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_node_scale(s : GeodistgreatcircleNode, f : Double) -> GeodistgreatcircleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_node_add(a : GeodistgreatcircleNode, b : GeodistgreatcircleNode) -> GeodistgreatcircleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_node_copy(s : GeodistgreatcircleNode) -> GeodistgreatcircleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_node_fill(s : GeodistgreatcircleNode, v : Double) -> GeodistgreatcircleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_node_min(s : GeodistgreatcircleNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_node_max(s : GeodistgreatcircleNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_node_to_string(s : GeodistgreatcircleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_edge_make(size : Int) -> GeodistgreatcircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_edge_len(s : GeodistgreatcircleEdge) -> Int { s.size }

pub fn geo_dist_great_circle_edge_get(s : GeodistgreatcircleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_edge_set(s : GeodistgreatcircleEdge, i : Int, v : Double) -> GeodistgreatcircleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_edge_sum(s : GeodistgreatcircleEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_edge_mean(s : GeodistgreatcircleEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_edge_scale(s : GeodistgreatcircleEdge, f : Double) -> GeodistgreatcircleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_edge_add(a : GeodistgreatcircleEdge, b : GeodistgreatcircleEdge) -> GeodistgreatcircleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_edge_copy(s : GeodistgreatcircleEdge) -> GeodistgreatcircleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_edge_fill(s : GeodistgreatcircleEdge, v : Double) -> GeodistgreatcircleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_edge_min(s : GeodistgreatcircleEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_edge_max(s : GeodistgreatcircleEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_edge_to_string(s : GeodistgreatcircleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_path_make(size : Int) -> GeodistgreatcirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_path_len(s : GeodistgreatcirclePath) -> Int { s.size }

pub fn geo_dist_great_circle_path_get(s : GeodistgreatcirclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_path_set(s : GeodistgreatcirclePath, i : Int, v : Double) -> GeodistgreatcirclePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_path_sum(s : GeodistgreatcirclePath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_path_mean(s : GeodistgreatcirclePath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_path_scale(s : GeodistgreatcirclePath, f : Double) -> GeodistgreatcirclePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_path_add(a : GeodistgreatcirclePath, b : GeodistgreatcirclePath) -> GeodistgreatcirclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_path_copy(s : GeodistgreatcirclePath) -> GeodistgreatcirclePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_path_fill(s : GeodistgreatcirclePath, v : Double) -> GeodistgreatcirclePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_path_min(s : GeodistgreatcirclePath) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_path_max(s : GeodistgreatcirclePath) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_path_to_string(s : GeodistgreatcirclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_cluster_make(size : Int) -> GeodistgreatcircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_cluster_len(s : GeodistgreatcircleCluster) -> Int { s.size }

pub fn geo_dist_great_circle_cluster_get(s : GeodistgreatcircleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_cluster_set(s : GeodistgreatcircleCluster, i : Int, v : Double) -> GeodistgreatcircleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cluster_sum(s : GeodistgreatcircleCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_cluster_mean(s : GeodistgreatcircleCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_cluster_scale(s : GeodistgreatcircleCluster, f : Double) -> GeodistgreatcircleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cluster_add(a : GeodistgreatcircleCluster, b : GeodistgreatcircleCluster) -> GeodistgreatcircleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_cluster_copy(s : GeodistgreatcircleCluster) -> GeodistgreatcircleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cluster_fill(s : GeodistgreatcircleCluster, v : Double) -> GeodistgreatcircleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cluster_min(s : GeodistgreatcircleCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_cluster_max(s : GeodistgreatcircleCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_cluster_to_string(s : GeodistgreatcircleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_model_make(size : Int) -> GeodistgreatcircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_model_len(s : GeodistgreatcircleModel) -> Int { s.size }

pub fn geo_dist_great_circle_model_get(s : GeodistgreatcircleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_model_set(s : GeodistgreatcircleModel, i : Int, v : Double) -> GeodistgreatcircleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_model_sum(s : GeodistgreatcircleModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_model_mean(s : GeodistgreatcircleModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_model_scale(s : GeodistgreatcircleModel, f : Double) -> GeodistgreatcircleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_model_add(a : GeodistgreatcircleModel, b : GeodistgreatcircleModel) -> GeodistgreatcircleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_model_copy(s : GeodistgreatcircleModel) -> GeodistgreatcircleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_model_fill(s : GeodistgreatcircleModel, v : Double) -> GeodistgreatcircleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_model_min(s : GeodistgreatcircleModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_model_max(s : GeodistgreatcircleModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_model_to_string(s : GeodistgreatcircleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_layer_make(size : Int) -> GeodistgreatcircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_layer_len(s : GeodistgreatcircleLayer) -> Int { s.size }

pub fn geo_dist_great_circle_layer_get(s : GeodistgreatcircleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_layer_set(s : GeodistgreatcircleLayer, i : Int, v : Double) -> GeodistgreatcircleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_layer_sum(s : GeodistgreatcircleLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_layer_mean(s : GeodistgreatcircleLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_layer_scale(s : GeodistgreatcircleLayer, f : Double) -> GeodistgreatcircleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_layer_add(a : GeodistgreatcircleLayer, b : GeodistgreatcircleLayer) -> GeodistgreatcircleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_layer_copy(s : GeodistgreatcircleLayer) -> GeodistgreatcircleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_layer_fill(s : GeodistgreatcircleLayer, v : Double) -> GeodistgreatcircleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_layer_min(s : GeodistgreatcircleLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_layer_max(s : GeodistgreatcircleLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_layer_to_string(s : GeodistgreatcircleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_buffer_make(size : Int) -> GeodistgreatcircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_buffer_len(s : GeodistgreatcircleBuffer) -> Int { s.size }

pub fn geo_dist_great_circle_buffer_get(s : GeodistgreatcircleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_buffer_set(s : GeodistgreatcircleBuffer, i : Int, v : Double) -> GeodistgreatcircleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_buffer_sum(s : GeodistgreatcircleBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_buffer_mean(s : GeodistgreatcircleBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_buffer_scale(s : GeodistgreatcircleBuffer, f : Double) -> GeodistgreatcircleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_buffer_add(a : GeodistgreatcircleBuffer, b : GeodistgreatcircleBuffer) -> GeodistgreatcircleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_buffer_copy(s : GeodistgreatcircleBuffer) -> GeodistgreatcircleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_buffer_fill(s : GeodistgreatcircleBuffer, v : Double) -> GeodistgreatcircleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_buffer_min(s : GeodistgreatcircleBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_buffer_max(s : GeodistgreatcircleBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_buffer_to_string(s : GeodistgreatcircleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_cursor_make(size : Int) -> GeodistgreatcircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_cursor_len(s : GeodistgreatcircleCursor) -> Int { s.size }

pub fn geo_dist_great_circle_cursor_get(s : GeodistgreatcircleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_cursor_set(s : GeodistgreatcircleCursor, i : Int, v : Double) -> GeodistgreatcircleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cursor_sum(s : GeodistgreatcircleCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_cursor_mean(s : GeodistgreatcircleCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_cursor_scale(s : GeodistgreatcircleCursor, f : Double) -> GeodistgreatcircleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cursor_add(a : GeodistgreatcircleCursor, b : GeodistgreatcircleCursor) -> GeodistgreatcircleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_cursor_copy(s : GeodistgreatcircleCursor) -> GeodistgreatcircleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cursor_fill(s : GeodistgreatcircleCursor, v : Double) -> GeodistgreatcircleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_cursor_min(s : GeodistgreatcircleCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_cursor_max(s : GeodistgreatcircleCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_cursor_to_string(s : GeodistgreatcircleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_view_make(size : Int) -> GeodistgreatcircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_view_len(s : GeodistgreatcircleView) -> Int { s.size }

pub fn geo_dist_great_circle_view_get(s : GeodistgreatcircleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_view_set(s : GeodistgreatcircleView, i : Int, v : Double) -> GeodistgreatcircleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_view_sum(s : GeodistgreatcircleView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_view_mean(s : GeodistgreatcircleView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_view_scale(s : GeodistgreatcircleView, f : Double) -> GeodistgreatcircleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_view_add(a : GeodistgreatcircleView, b : GeodistgreatcircleView) -> GeodistgreatcircleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_view_copy(s : GeodistgreatcircleView) -> GeodistgreatcircleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_view_fill(s : GeodistgreatcircleView, v : Double) -> GeodistgreatcircleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_view_min(s : GeodistgreatcircleView) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_view_max(s : GeodistgreatcircleView) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_view_to_string(s : GeodistgreatcircleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_range_make(size : Int) -> GeodistgreatcircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_range_len(s : GeodistgreatcircleRange) -> Int { s.size }

pub fn geo_dist_great_circle_range_get(s : GeodistgreatcircleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_range_set(s : GeodistgreatcircleRange, i : Int, v : Double) -> GeodistgreatcircleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_range_sum(s : GeodistgreatcircleRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_range_mean(s : GeodistgreatcircleRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_range_scale(s : GeodistgreatcircleRange, f : Double) -> GeodistgreatcircleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_range_add(a : GeodistgreatcircleRange, b : GeodistgreatcircleRange) -> GeodistgreatcircleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_range_copy(s : GeodistgreatcircleRange) -> GeodistgreatcircleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_range_fill(s : GeodistgreatcircleRange, v : Double) -> GeodistgreatcircleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_range_min(s : GeodistgreatcircleRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_range_max(s : GeodistgreatcircleRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_range_to_string(s : GeodistgreatcircleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgreatcircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_great_circle_slice_make(size : Int) -> GeodistgreatcircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_great_circle_slice_len(s : GeodistgreatcircleSlice) -> Int { s.size }

pub fn geo_dist_great_circle_slice_get(s : GeodistgreatcircleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_great_circle_slice_set(s : GeodistgreatcircleSlice, i : Int, v : Double) -> GeodistgreatcircleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_slice_sum(s : GeodistgreatcircleSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_great_circle_slice_mean(s : GeodistgreatcircleSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_great_circle_slice_scale(s : GeodistgreatcircleSlice, f : Double) -> GeodistgreatcircleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_slice_add(a : GeodistgreatcircleSlice, b : GeodistgreatcircleSlice) -> GeodistgreatcircleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_great_circle_slice_copy(s : GeodistgreatcircleSlice) -> GeodistgreatcircleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_slice_fill(s : GeodistgreatcircleSlice, v : Double) -> GeodistgreatcircleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_great_circle_slice_min(s : GeodistgreatcircleSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_great_circle_slice_max(s : GeodistgreatcircleSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_great_circle_slice_to_string(s : GeodistgreatcircleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

