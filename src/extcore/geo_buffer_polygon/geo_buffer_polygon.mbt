///===
/// extcore/geo_buffer_polygon

pub(all) struct GeobufferpolygonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_polygon_make_point(x : Double, y : Double) -> GeobufferpolygonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_polygon_make_point3(x : Double, y : Double, z : Double) -> GeobufferpolygonPoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferpolygonPoint::x(self : GeobufferpolygonPoint) -> Double { self.x }

pub fn GeobufferpolygonPoint::y(self : GeobufferpolygonPoint) -> Double { self.y }

pub fn GeobufferpolygonPoint::z(self : GeobufferpolygonPoint) -> Double { self.z }

pub fn GeobufferpolygonPoint::label(self : GeobufferpolygonPoint) -> Int { self.label }

pub fn GeobufferpolygonPoint::dist(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferpolygonPoint::add(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferpolygonPoint::sub(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferpolygonPoint::scale(self : GeobufferpolygonPoint, s : Double) -> GeobufferpolygonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferpolygonPoint::dot(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferpolygonPoint::cross(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferpolygonPoint::norm(self : GeobufferpolygonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferpolygonPoint::normalize(self : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferpolygonPoint::negate(self : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferpolygonPoint::mid(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferpolygonPoint::lerp(self : GeobufferpolygonPoint, other : GeobufferpolygonPoint, t : Double) -> GeobufferpolygonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferpolygonPoint::to_string(self : GeobufferpolygonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferpolygonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_polygon_make_series(vals : Array[Double], name : String) -> GeobufferpolygonSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferpolygonSeries::len(self : GeobufferpolygonSeries) -> Int { self.vals.length() }

pub fn GeobufferpolygonSeries::sum(self : GeobufferpolygonSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferpolygonSeries::mean(self : GeobufferpolygonSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferpolygonSeries::min(self : GeobufferpolygonSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferpolygonSeries::max(self : GeobufferpolygonSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferpolygonSeries::range(self : GeobufferpolygonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferpolygonSeries::variance(self : GeobufferpolygonSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferpolygonSeries::std(self : GeobufferpolygonSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferpolygonSeries::median(self : GeobufferpolygonSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferpolygonSeries::scale(self : GeobufferpolygonSeries, f : Double) -> GeobufferpolygonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferpolygonSeries::add(self : GeobufferpolygonSeries, other : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferpolygonSeries::sub(self : GeobufferpolygonSeries, other : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferpolygonSeries::normalize(self : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferpolygonSeries::cumsum(self : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferpolygonSeries::to_string(self : GeobufferpolygonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferpolygonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_polygon_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferpolygonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_polygon_matrix_identity(n : Int) -> GeobufferpolygonMatrix {
  let m = geo_buffer_polygon_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferpolygonMatrix::get(self : GeobufferpolygonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferpolygonMatrix::transpose(self : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  let result = geo_buffer_polygon_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferpolygonMatrix::add(self : GeobufferpolygonMatrix, other : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferpolygonMatrix::scale(self : GeobufferpolygonMatrix, s : Double) -> GeobufferpolygonMatrix {
  let result = geo_buffer_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferpolygonMatrix::multiply(self : GeobufferpolygonMatrix, other : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  if self.cols != other.rows { return geo_buffer_polygon_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_polygon_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferpolygonMatrix::trace(self : GeobufferpolygonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferpolygonMatrix::det(self : GeobufferpolygonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferpolygonMatrix::norm(self : GeobufferpolygonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferpolygonMatrix::to_string(self : GeobufferpolygonMatrix) -> String {
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

pub(all) struct GeobufferpolygonVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_polygon_make_vector(comps : Array[Double]) -> GeobufferpolygonVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_polygon_vector_zero(dim : Int) -> GeobufferpolygonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferpolygonVector::add(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferpolygonVector::sub(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferpolygonVector::scale(self : GeobufferpolygonVector, s : Double) -> GeobufferpolygonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferpolygonVector::dot(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferpolygonVector::norm(self : GeobufferpolygonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferpolygonVector::normalize(self : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferpolygonVector::dist(self : GeobufferpolygonVector, other : GeobufferpolygonVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferpolygonVector::to_string(self : GeobufferpolygonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_polygon_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_polygon_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_polygon_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_polygon_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_polygon_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_polygon_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_polygon_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_polygon_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_polygon_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_polygon_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_polygon_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_polygon_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_polygon_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_polygon_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_polygon_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_polygon_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_polygon_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_polygon_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_polygon_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_polygon_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_polygon_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_polygon_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_polygon_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_polygon_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_polygon_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_polygon_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_polygon_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_polygon_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_polygon_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferpolygonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_frame_make(size : Int) -> GeobufferpolygonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_frame_len(s : GeobufferpolygonFrame) -> Int { s.size }

pub fn geo_buffer_polygon_frame_get(s : GeobufferpolygonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_frame_set(s : GeobufferpolygonFrame, i : Int, v : Double) -> GeobufferpolygonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_frame_sum(s : GeobufferpolygonFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_frame_mean(s : GeobufferpolygonFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_frame_scale(s : GeobufferpolygonFrame, f : Double) -> GeobufferpolygonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_frame_add(a : GeobufferpolygonFrame, b : GeobufferpolygonFrame) -> GeobufferpolygonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_frame_copy(s : GeobufferpolygonFrame) -> GeobufferpolygonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_frame_fill(s : GeobufferpolygonFrame, v : Double) -> GeobufferpolygonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_frame_min(s : GeobufferpolygonFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_frame_max(s : GeobufferpolygonFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_frame_to_string(s : GeobufferpolygonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_table_make(size : Int) -> GeobufferpolygonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_table_len(s : GeobufferpolygonTable) -> Int { s.size }

pub fn geo_buffer_polygon_table_get(s : GeobufferpolygonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_table_set(s : GeobufferpolygonTable, i : Int, v : Double) -> GeobufferpolygonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_table_sum(s : GeobufferpolygonTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_table_mean(s : GeobufferpolygonTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_table_scale(s : GeobufferpolygonTable, f : Double) -> GeobufferpolygonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_table_add(a : GeobufferpolygonTable, b : GeobufferpolygonTable) -> GeobufferpolygonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_table_copy(s : GeobufferpolygonTable) -> GeobufferpolygonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_table_fill(s : GeobufferpolygonTable, v : Double) -> GeobufferpolygonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_table_min(s : GeobufferpolygonTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_table_max(s : GeobufferpolygonTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_table_to_string(s : GeobufferpolygonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_graphn_make(size : Int) -> GeobufferpolygonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_graphn_len(s : GeobufferpolygonGraphN) -> Int { s.size }

pub fn geo_buffer_polygon_graphn_get(s : GeobufferpolygonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_graphn_set(s : GeobufferpolygonGraphN, i : Int, v : Double) -> GeobufferpolygonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_graphn_sum(s : GeobufferpolygonGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_graphn_mean(s : GeobufferpolygonGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_graphn_scale(s : GeobufferpolygonGraphN, f : Double) -> GeobufferpolygonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_graphn_add(a : GeobufferpolygonGraphN, b : GeobufferpolygonGraphN) -> GeobufferpolygonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_graphn_copy(s : GeobufferpolygonGraphN) -> GeobufferpolygonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_graphn_fill(s : GeobufferpolygonGraphN, v : Double) -> GeobufferpolygonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_graphn_min(s : GeobufferpolygonGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_graphn_max(s : GeobufferpolygonGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_graphn_to_string(s : GeobufferpolygonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_node_make(size : Int) -> GeobufferpolygonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_node_len(s : GeobufferpolygonNode) -> Int { s.size }

pub fn geo_buffer_polygon_node_get(s : GeobufferpolygonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_node_set(s : GeobufferpolygonNode, i : Int, v : Double) -> GeobufferpolygonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_node_sum(s : GeobufferpolygonNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_node_mean(s : GeobufferpolygonNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_node_scale(s : GeobufferpolygonNode, f : Double) -> GeobufferpolygonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_node_add(a : GeobufferpolygonNode, b : GeobufferpolygonNode) -> GeobufferpolygonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_node_copy(s : GeobufferpolygonNode) -> GeobufferpolygonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_node_fill(s : GeobufferpolygonNode, v : Double) -> GeobufferpolygonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_node_min(s : GeobufferpolygonNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_node_max(s : GeobufferpolygonNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_node_to_string(s : GeobufferpolygonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_edge_make(size : Int) -> GeobufferpolygonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_edge_len(s : GeobufferpolygonEdge) -> Int { s.size }

pub fn geo_buffer_polygon_edge_get(s : GeobufferpolygonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_edge_set(s : GeobufferpolygonEdge, i : Int, v : Double) -> GeobufferpolygonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_edge_sum(s : GeobufferpolygonEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_edge_mean(s : GeobufferpolygonEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_edge_scale(s : GeobufferpolygonEdge, f : Double) -> GeobufferpolygonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_edge_add(a : GeobufferpolygonEdge, b : GeobufferpolygonEdge) -> GeobufferpolygonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_edge_copy(s : GeobufferpolygonEdge) -> GeobufferpolygonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_edge_fill(s : GeobufferpolygonEdge, v : Double) -> GeobufferpolygonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_edge_min(s : GeobufferpolygonEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_edge_max(s : GeobufferpolygonEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_edge_to_string(s : GeobufferpolygonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_path_make(size : Int) -> GeobufferpolygonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_path_len(s : GeobufferpolygonPath) -> Int { s.size }

pub fn geo_buffer_polygon_path_get(s : GeobufferpolygonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_path_set(s : GeobufferpolygonPath, i : Int, v : Double) -> GeobufferpolygonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_path_sum(s : GeobufferpolygonPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_path_mean(s : GeobufferpolygonPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_path_scale(s : GeobufferpolygonPath, f : Double) -> GeobufferpolygonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_path_add(a : GeobufferpolygonPath, b : GeobufferpolygonPath) -> GeobufferpolygonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_path_copy(s : GeobufferpolygonPath) -> GeobufferpolygonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_path_fill(s : GeobufferpolygonPath, v : Double) -> GeobufferpolygonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_path_min(s : GeobufferpolygonPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_path_max(s : GeobufferpolygonPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_path_to_string(s : GeobufferpolygonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_cluster_make(size : Int) -> GeobufferpolygonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_cluster_len(s : GeobufferpolygonCluster) -> Int { s.size }

pub fn geo_buffer_polygon_cluster_get(s : GeobufferpolygonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_cluster_set(s : GeobufferpolygonCluster, i : Int, v : Double) -> GeobufferpolygonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cluster_sum(s : GeobufferpolygonCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_cluster_mean(s : GeobufferpolygonCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_cluster_scale(s : GeobufferpolygonCluster, f : Double) -> GeobufferpolygonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cluster_add(a : GeobufferpolygonCluster, b : GeobufferpolygonCluster) -> GeobufferpolygonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_cluster_copy(s : GeobufferpolygonCluster) -> GeobufferpolygonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cluster_fill(s : GeobufferpolygonCluster, v : Double) -> GeobufferpolygonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cluster_min(s : GeobufferpolygonCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_cluster_max(s : GeobufferpolygonCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_cluster_to_string(s : GeobufferpolygonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_model_make(size : Int) -> GeobufferpolygonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_model_len(s : GeobufferpolygonModel) -> Int { s.size }

pub fn geo_buffer_polygon_model_get(s : GeobufferpolygonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_model_set(s : GeobufferpolygonModel, i : Int, v : Double) -> GeobufferpolygonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_model_sum(s : GeobufferpolygonModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_model_mean(s : GeobufferpolygonModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_model_scale(s : GeobufferpolygonModel, f : Double) -> GeobufferpolygonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_model_add(a : GeobufferpolygonModel, b : GeobufferpolygonModel) -> GeobufferpolygonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_model_copy(s : GeobufferpolygonModel) -> GeobufferpolygonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_model_fill(s : GeobufferpolygonModel, v : Double) -> GeobufferpolygonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_model_min(s : GeobufferpolygonModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_model_max(s : GeobufferpolygonModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_model_to_string(s : GeobufferpolygonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_layer_make(size : Int) -> GeobufferpolygonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_layer_len(s : GeobufferpolygonLayer) -> Int { s.size }

pub fn geo_buffer_polygon_layer_get(s : GeobufferpolygonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_layer_set(s : GeobufferpolygonLayer, i : Int, v : Double) -> GeobufferpolygonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_layer_sum(s : GeobufferpolygonLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_layer_mean(s : GeobufferpolygonLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_layer_scale(s : GeobufferpolygonLayer, f : Double) -> GeobufferpolygonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_layer_add(a : GeobufferpolygonLayer, b : GeobufferpolygonLayer) -> GeobufferpolygonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_layer_copy(s : GeobufferpolygonLayer) -> GeobufferpolygonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_layer_fill(s : GeobufferpolygonLayer, v : Double) -> GeobufferpolygonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_layer_min(s : GeobufferpolygonLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_layer_max(s : GeobufferpolygonLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_layer_to_string(s : GeobufferpolygonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_buffer_make(size : Int) -> GeobufferpolygonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_buffer_len(s : GeobufferpolygonBuffer) -> Int { s.size }

pub fn geo_buffer_polygon_buffer_get(s : GeobufferpolygonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_buffer_set(s : GeobufferpolygonBuffer, i : Int, v : Double) -> GeobufferpolygonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_buffer_sum(s : GeobufferpolygonBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_buffer_mean(s : GeobufferpolygonBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_buffer_scale(s : GeobufferpolygonBuffer, f : Double) -> GeobufferpolygonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_buffer_add(a : GeobufferpolygonBuffer, b : GeobufferpolygonBuffer) -> GeobufferpolygonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_buffer_copy(s : GeobufferpolygonBuffer) -> GeobufferpolygonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_buffer_fill(s : GeobufferpolygonBuffer, v : Double) -> GeobufferpolygonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_buffer_min(s : GeobufferpolygonBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_buffer_max(s : GeobufferpolygonBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_buffer_to_string(s : GeobufferpolygonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_cursor_make(size : Int) -> GeobufferpolygonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_cursor_len(s : GeobufferpolygonCursor) -> Int { s.size }

pub fn geo_buffer_polygon_cursor_get(s : GeobufferpolygonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_cursor_set(s : GeobufferpolygonCursor, i : Int, v : Double) -> GeobufferpolygonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cursor_sum(s : GeobufferpolygonCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_cursor_mean(s : GeobufferpolygonCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_cursor_scale(s : GeobufferpolygonCursor, f : Double) -> GeobufferpolygonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cursor_add(a : GeobufferpolygonCursor, b : GeobufferpolygonCursor) -> GeobufferpolygonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_cursor_copy(s : GeobufferpolygonCursor) -> GeobufferpolygonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cursor_fill(s : GeobufferpolygonCursor, v : Double) -> GeobufferpolygonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_cursor_min(s : GeobufferpolygonCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_cursor_max(s : GeobufferpolygonCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_cursor_to_string(s : GeobufferpolygonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_view_make(size : Int) -> GeobufferpolygonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_view_len(s : GeobufferpolygonView) -> Int { s.size }

pub fn geo_buffer_polygon_view_get(s : GeobufferpolygonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_view_set(s : GeobufferpolygonView, i : Int, v : Double) -> GeobufferpolygonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_view_sum(s : GeobufferpolygonView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_view_mean(s : GeobufferpolygonView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_view_scale(s : GeobufferpolygonView, f : Double) -> GeobufferpolygonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_view_add(a : GeobufferpolygonView, b : GeobufferpolygonView) -> GeobufferpolygonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_view_copy(s : GeobufferpolygonView) -> GeobufferpolygonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_view_fill(s : GeobufferpolygonView, v : Double) -> GeobufferpolygonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_view_min(s : GeobufferpolygonView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_view_max(s : GeobufferpolygonView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_view_to_string(s : GeobufferpolygonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_range_make(size : Int) -> GeobufferpolygonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_range_len(s : GeobufferpolygonRange) -> Int { s.size }

pub fn geo_buffer_polygon_range_get(s : GeobufferpolygonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_range_set(s : GeobufferpolygonRange, i : Int, v : Double) -> GeobufferpolygonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_range_sum(s : GeobufferpolygonRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_range_mean(s : GeobufferpolygonRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_range_scale(s : GeobufferpolygonRange, f : Double) -> GeobufferpolygonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_range_add(a : GeobufferpolygonRange, b : GeobufferpolygonRange) -> GeobufferpolygonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_range_copy(s : GeobufferpolygonRange) -> GeobufferpolygonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_range_fill(s : GeobufferpolygonRange, v : Double) -> GeobufferpolygonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_range_min(s : GeobufferpolygonRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_range_max(s : GeobufferpolygonRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_range_to_string(s : GeobufferpolygonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_slice_make(size : Int) -> GeobufferpolygonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_slice_len(s : GeobufferpolygonSlice) -> Int { s.size }

pub fn geo_buffer_polygon_slice_get(s : GeobufferpolygonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_slice_set(s : GeobufferpolygonSlice, i : Int, v : Double) -> GeobufferpolygonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_slice_sum(s : GeobufferpolygonSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_polygon_slice_mean(s : GeobufferpolygonSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_polygon_slice_scale(s : GeobufferpolygonSlice, f : Double) -> GeobufferpolygonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_slice_add(a : GeobufferpolygonSlice, b : GeobufferpolygonSlice) -> GeobufferpolygonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_polygon_slice_copy(s : GeobufferpolygonSlice) -> GeobufferpolygonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_slice_fill(s : GeobufferpolygonSlice, v : Double) -> GeobufferpolygonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_polygon_slice_min(s : GeobufferpolygonSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_polygon_slice_max(s : GeobufferpolygonSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_polygon_slice_to_string(s : GeobufferpolygonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

