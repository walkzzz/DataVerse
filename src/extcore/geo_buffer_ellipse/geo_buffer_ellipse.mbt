///===
/// extcore/geo_buffer_ellipse

pub(all) struct GeobufferellipsePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_ellipse_make_point(x : Double, y : Double) -> GeobufferellipsePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_ellipse_make_point3(x : Double, y : Double, z : Double) -> GeobufferellipsePoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferellipsePoint::x(self : GeobufferellipsePoint) -> Double { self.x }

pub fn GeobufferellipsePoint::y(self : GeobufferellipsePoint) -> Double { self.y }

pub fn GeobufferellipsePoint::z(self : GeobufferellipsePoint) -> Double { self.z }

pub fn GeobufferellipsePoint::label(self : GeobufferellipsePoint) -> Int { self.label }

pub fn GeobufferellipsePoint::dist(self : GeobufferellipsePoint, other : GeobufferellipsePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferellipsePoint::add(self : GeobufferellipsePoint, other : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferellipsePoint::sub(self : GeobufferellipsePoint, other : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferellipsePoint::scale(self : GeobufferellipsePoint, s : Double) -> GeobufferellipsePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferellipsePoint::dot(self : GeobufferellipsePoint, other : GeobufferellipsePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferellipsePoint::cross(self : GeobufferellipsePoint, other : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferellipsePoint::norm(self : GeobufferellipsePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferellipsePoint::normalize(self : GeobufferellipsePoint) -> GeobufferellipsePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferellipsePoint::negate(self : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferellipsePoint::mid(self : GeobufferellipsePoint, other : GeobufferellipsePoint) -> GeobufferellipsePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferellipsePoint::lerp(self : GeobufferellipsePoint, other : GeobufferellipsePoint, t : Double) -> GeobufferellipsePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferellipsePoint::to_string(self : GeobufferellipsePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferellipseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_ellipse_make_series(vals : Array[Double], name : String) -> GeobufferellipseSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferellipseSeries::len(self : GeobufferellipseSeries) -> Int { self.vals.length() }

pub fn GeobufferellipseSeries::sum(self : GeobufferellipseSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferellipseSeries::mean(self : GeobufferellipseSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferellipseSeries::min(self : GeobufferellipseSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferellipseSeries::max(self : GeobufferellipseSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferellipseSeries::range(self : GeobufferellipseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferellipseSeries::variance(self : GeobufferellipseSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferellipseSeries::std(self : GeobufferellipseSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferellipseSeries::median(self : GeobufferellipseSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferellipseSeries::scale(self : GeobufferellipseSeries, f : Double) -> GeobufferellipseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferellipseSeries::add(self : GeobufferellipseSeries, other : GeobufferellipseSeries) -> GeobufferellipseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferellipseSeries::sub(self : GeobufferellipseSeries, other : GeobufferellipseSeries) -> GeobufferellipseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferellipseSeries::normalize(self : GeobufferellipseSeries) -> GeobufferellipseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferellipseSeries::cumsum(self : GeobufferellipseSeries) -> GeobufferellipseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferellipseSeries::to_string(self : GeobufferellipseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferellipseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_ellipse_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferellipseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_ellipse_matrix_identity(n : Int) -> GeobufferellipseMatrix {
  let m = geo_buffer_ellipse_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferellipseMatrix::get(self : GeobufferellipseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferellipseMatrix::transpose(self : GeobufferellipseMatrix) -> GeobufferellipseMatrix {
  let result = geo_buffer_ellipse_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferellipseMatrix::add(self : GeobufferellipseMatrix, other : GeobufferellipseMatrix) -> GeobufferellipseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferellipseMatrix::scale(self : GeobufferellipseMatrix, s : Double) -> GeobufferellipseMatrix {
  let result = geo_buffer_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferellipseMatrix::multiply(self : GeobufferellipseMatrix, other : GeobufferellipseMatrix) -> GeobufferellipseMatrix {
  if self.cols != other.rows { return geo_buffer_ellipse_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_ellipse_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferellipseMatrix::trace(self : GeobufferellipseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferellipseMatrix::det(self : GeobufferellipseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferellipseMatrix::norm(self : GeobufferellipseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferellipseMatrix::to_string(self : GeobufferellipseMatrix) -> String {
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

pub(all) struct GeobufferellipseVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_ellipse_make_vector(comps : Array[Double]) -> GeobufferellipseVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_ellipse_vector_zero(dim : Int) -> GeobufferellipseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferellipseVector::add(self : GeobufferellipseVector, other : GeobufferellipseVector) -> GeobufferellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferellipseVector::sub(self : GeobufferellipseVector, other : GeobufferellipseVector) -> GeobufferellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferellipseVector::scale(self : GeobufferellipseVector, s : Double) -> GeobufferellipseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferellipseVector::dot(self : GeobufferellipseVector, other : GeobufferellipseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferellipseVector::norm(self : GeobufferellipseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferellipseVector::normalize(self : GeobufferellipseVector) -> GeobufferellipseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferellipseVector::dist(self : GeobufferellipseVector, other : GeobufferellipseVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferellipseVector::to_string(self : GeobufferellipseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_ellipse_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_ellipse_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_ellipse_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_ellipse_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_ellipse_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_ellipse_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_ellipse_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_ellipse_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_ellipse_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_ellipse_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_ellipse_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_ellipse_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_ellipse_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_ellipse_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_ellipse_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_ellipse_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_ellipse_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_ellipse_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_ellipse_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_ellipse_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_ellipse_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_ellipse_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_ellipse_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_ellipse_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_ellipse_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_ellipse_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_ellipse_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_ellipse_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_ellipse_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferellipseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_frame_make(size : Int) -> GeobufferellipseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_frame_len(s : GeobufferellipseFrame) -> Int { s.size }

pub fn geo_buffer_ellipse_frame_get(s : GeobufferellipseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_frame_set(s : GeobufferellipseFrame, i : Int, v : Double) -> GeobufferellipseFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_frame_sum(s : GeobufferellipseFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_frame_mean(s : GeobufferellipseFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_frame_scale(s : GeobufferellipseFrame, f : Double) -> GeobufferellipseFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_frame_add(a : GeobufferellipseFrame, b : GeobufferellipseFrame) -> GeobufferellipseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_frame_copy(s : GeobufferellipseFrame) -> GeobufferellipseFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_frame_fill(s : GeobufferellipseFrame, v : Double) -> GeobufferellipseFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_frame_min(s : GeobufferellipseFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_frame_max(s : GeobufferellipseFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_frame_to_string(s : GeobufferellipseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_table_make(size : Int) -> GeobufferellipseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_table_len(s : GeobufferellipseTable) -> Int { s.size }

pub fn geo_buffer_ellipse_table_get(s : GeobufferellipseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_table_set(s : GeobufferellipseTable, i : Int, v : Double) -> GeobufferellipseTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_table_sum(s : GeobufferellipseTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_table_mean(s : GeobufferellipseTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_table_scale(s : GeobufferellipseTable, f : Double) -> GeobufferellipseTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_table_add(a : GeobufferellipseTable, b : GeobufferellipseTable) -> GeobufferellipseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_table_copy(s : GeobufferellipseTable) -> GeobufferellipseTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_table_fill(s : GeobufferellipseTable, v : Double) -> GeobufferellipseTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_table_min(s : GeobufferellipseTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_table_max(s : GeobufferellipseTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_table_to_string(s : GeobufferellipseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_graphn_make(size : Int) -> GeobufferellipseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_graphn_len(s : GeobufferellipseGraphN) -> Int { s.size }

pub fn geo_buffer_ellipse_graphn_get(s : GeobufferellipseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_graphn_set(s : GeobufferellipseGraphN, i : Int, v : Double) -> GeobufferellipseGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_graphn_sum(s : GeobufferellipseGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_graphn_mean(s : GeobufferellipseGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_graphn_scale(s : GeobufferellipseGraphN, f : Double) -> GeobufferellipseGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_graphn_add(a : GeobufferellipseGraphN, b : GeobufferellipseGraphN) -> GeobufferellipseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_graphn_copy(s : GeobufferellipseGraphN) -> GeobufferellipseGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_graphn_fill(s : GeobufferellipseGraphN, v : Double) -> GeobufferellipseGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_graphn_min(s : GeobufferellipseGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_graphn_max(s : GeobufferellipseGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_graphn_to_string(s : GeobufferellipseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_node_make(size : Int) -> GeobufferellipseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_node_len(s : GeobufferellipseNode) -> Int { s.size }

pub fn geo_buffer_ellipse_node_get(s : GeobufferellipseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_node_set(s : GeobufferellipseNode, i : Int, v : Double) -> GeobufferellipseNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_node_sum(s : GeobufferellipseNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_node_mean(s : GeobufferellipseNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_node_scale(s : GeobufferellipseNode, f : Double) -> GeobufferellipseNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_node_add(a : GeobufferellipseNode, b : GeobufferellipseNode) -> GeobufferellipseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_node_copy(s : GeobufferellipseNode) -> GeobufferellipseNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_node_fill(s : GeobufferellipseNode, v : Double) -> GeobufferellipseNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_node_min(s : GeobufferellipseNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_node_max(s : GeobufferellipseNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_node_to_string(s : GeobufferellipseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_edge_make(size : Int) -> GeobufferellipseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_edge_len(s : GeobufferellipseEdge) -> Int { s.size }

pub fn geo_buffer_ellipse_edge_get(s : GeobufferellipseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_edge_set(s : GeobufferellipseEdge, i : Int, v : Double) -> GeobufferellipseEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_edge_sum(s : GeobufferellipseEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_edge_mean(s : GeobufferellipseEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_edge_scale(s : GeobufferellipseEdge, f : Double) -> GeobufferellipseEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_edge_add(a : GeobufferellipseEdge, b : GeobufferellipseEdge) -> GeobufferellipseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_edge_copy(s : GeobufferellipseEdge) -> GeobufferellipseEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_edge_fill(s : GeobufferellipseEdge, v : Double) -> GeobufferellipseEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_edge_min(s : GeobufferellipseEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_edge_max(s : GeobufferellipseEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_edge_to_string(s : GeobufferellipseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipsePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_path_make(size : Int) -> GeobufferellipsePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_path_len(s : GeobufferellipsePath) -> Int { s.size }

pub fn geo_buffer_ellipse_path_get(s : GeobufferellipsePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_path_set(s : GeobufferellipsePath, i : Int, v : Double) -> GeobufferellipsePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_path_sum(s : GeobufferellipsePath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_path_mean(s : GeobufferellipsePath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_path_scale(s : GeobufferellipsePath, f : Double) -> GeobufferellipsePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_path_add(a : GeobufferellipsePath, b : GeobufferellipsePath) -> GeobufferellipsePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_path_copy(s : GeobufferellipsePath) -> GeobufferellipsePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_path_fill(s : GeobufferellipsePath, v : Double) -> GeobufferellipsePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_path_min(s : GeobufferellipsePath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_path_max(s : GeobufferellipsePath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_path_to_string(s : GeobufferellipsePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_cluster_make(size : Int) -> GeobufferellipseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_cluster_len(s : GeobufferellipseCluster) -> Int { s.size }

pub fn geo_buffer_ellipse_cluster_get(s : GeobufferellipseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_cluster_set(s : GeobufferellipseCluster, i : Int, v : Double) -> GeobufferellipseCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cluster_sum(s : GeobufferellipseCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_cluster_mean(s : GeobufferellipseCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_cluster_scale(s : GeobufferellipseCluster, f : Double) -> GeobufferellipseCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cluster_add(a : GeobufferellipseCluster, b : GeobufferellipseCluster) -> GeobufferellipseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_cluster_copy(s : GeobufferellipseCluster) -> GeobufferellipseCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cluster_fill(s : GeobufferellipseCluster, v : Double) -> GeobufferellipseCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cluster_min(s : GeobufferellipseCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_cluster_max(s : GeobufferellipseCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_cluster_to_string(s : GeobufferellipseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_model_make(size : Int) -> GeobufferellipseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_model_len(s : GeobufferellipseModel) -> Int { s.size }

pub fn geo_buffer_ellipse_model_get(s : GeobufferellipseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_model_set(s : GeobufferellipseModel, i : Int, v : Double) -> GeobufferellipseModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_model_sum(s : GeobufferellipseModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_model_mean(s : GeobufferellipseModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_model_scale(s : GeobufferellipseModel, f : Double) -> GeobufferellipseModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_model_add(a : GeobufferellipseModel, b : GeobufferellipseModel) -> GeobufferellipseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_model_copy(s : GeobufferellipseModel) -> GeobufferellipseModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_model_fill(s : GeobufferellipseModel, v : Double) -> GeobufferellipseModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_model_min(s : GeobufferellipseModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_model_max(s : GeobufferellipseModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_model_to_string(s : GeobufferellipseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_layer_make(size : Int) -> GeobufferellipseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_layer_len(s : GeobufferellipseLayer) -> Int { s.size }

pub fn geo_buffer_ellipse_layer_get(s : GeobufferellipseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_layer_set(s : GeobufferellipseLayer, i : Int, v : Double) -> GeobufferellipseLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_layer_sum(s : GeobufferellipseLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_layer_mean(s : GeobufferellipseLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_layer_scale(s : GeobufferellipseLayer, f : Double) -> GeobufferellipseLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_layer_add(a : GeobufferellipseLayer, b : GeobufferellipseLayer) -> GeobufferellipseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_layer_copy(s : GeobufferellipseLayer) -> GeobufferellipseLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_layer_fill(s : GeobufferellipseLayer, v : Double) -> GeobufferellipseLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_layer_min(s : GeobufferellipseLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_layer_max(s : GeobufferellipseLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_layer_to_string(s : GeobufferellipseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_buffer_make(size : Int) -> GeobufferellipseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_buffer_len(s : GeobufferellipseBuffer) -> Int { s.size }

pub fn geo_buffer_ellipse_buffer_get(s : GeobufferellipseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_buffer_set(s : GeobufferellipseBuffer, i : Int, v : Double) -> GeobufferellipseBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_buffer_sum(s : GeobufferellipseBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_buffer_mean(s : GeobufferellipseBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_buffer_scale(s : GeobufferellipseBuffer, f : Double) -> GeobufferellipseBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_buffer_add(a : GeobufferellipseBuffer, b : GeobufferellipseBuffer) -> GeobufferellipseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_buffer_copy(s : GeobufferellipseBuffer) -> GeobufferellipseBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_buffer_fill(s : GeobufferellipseBuffer, v : Double) -> GeobufferellipseBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_buffer_min(s : GeobufferellipseBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_buffer_max(s : GeobufferellipseBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_buffer_to_string(s : GeobufferellipseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_cursor_make(size : Int) -> GeobufferellipseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_cursor_len(s : GeobufferellipseCursor) -> Int { s.size }

pub fn geo_buffer_ellipse_cursor_get(s : GeobufferellipseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_cursor_set(s : GeobufferellipseCursor, i : Int, v : Double) -> GeobufferellipseCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cursor_sum(s : GeobufferellipseCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_cursor_mean(s : GeobufferellipseCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_cursor_scale(s : GeobufferellipseCursor, f : Double) -> GeobufferellipseCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cursor_add(a : GeobufferellipseCursor, b : GeobufferellipseCursor) -> GeobufferellipseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_cursor_copy(s : GeobufferellipseCursor) -> GeobufferellipseCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cursor_fill(s : GeobufferellipseCursor, v : Double) -> GeobufferellipseCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_cursor_min(s : GeobufferellipseCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_cursor_max(s : GeobufferellipseCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_cursor_to_string(s : GeobufferellipseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_view_make(size : Int) -> GeobufferellipseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_view_len(s : GeobufferellipseView) -> Int { s.size }

pub fn geo_buffer_ellipse_view_get(s : GeobufferellipseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_view_set(s : GeobufferellipseView, i : Int, v : Double) -> GeobufferellipseView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_view_sum(s : GeobufferellipseView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_view_mean(s : GeobufferellipseView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_view_scale(s : GeobufferellipseView, f : Double) -> GeobufferellipseView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_view_add(a : GeobufferellipseView, b : GeobufferellipseView) -> GeobufferellipseView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_view_copy(s : GeobufferellipseView) -> GeobufferellipseView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_view_fill(s : GeobufferellipseView, v : Double) -> GeobufferellipseView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_view_min(s : GeobufferellipseView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_view_max(s : GeobufferellipseView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_view_to_string(s : GeobufferellipseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_range_make(size : Int) -> GeobufferellipseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_range_len(s : GeobufferellipseRange) -> Int { s.size }

pub fn geo_buffer_ellipse_range_get(s : GeobufferellipseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_range_set(s : GeobufferellipseRange, i : Int, v : Double) -> GeobufferellipseRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_range_sum(s : GeobufferellipseRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_range_mean(s : GeobufferellipseRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_range_scale(s : GeobufferellipseRange, f : Double) -> GeobufferellipseRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_range_add(a : GeobufferellipseRange, b : GeobufferellipseRange) -> GeobufferellipseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_range_copy(s : GeobufferellipseRange) -> GeobufferellipseRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_range_fill(s : GeobufferellipseRange, v : Double) -> GeobufferellipseRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_range_min(s : GeobufferellipseRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_range_max(s : GeobufferellipseRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_range_to_string(s : GeobufferellipseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferellipseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_ellipse_slice_make(size : Int) -> GeobufferellipseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_ellipse_slice_len(s : GeobufferellipseSlice) -> Int { s.size }

pub fn geo_buffer_ellipse_slice_get(s : GeobufferellipseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_ellipse_slice_set(s : GeobufferellipseSlice, i : Int, v : Double) -> GeobufferellipseSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_slice_sum(s : GeobufferellipseSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_ellipse_slice_mean(s : GeobufferellipseSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_ellipse_slice_scale(s : GeobufferellipseSlice, f : Double) -> GeobufferellipseSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_slice_add(a : GeobufferellipseSlice, b : GeobufferellipseSlice) -> GeobufferellipseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_ellipse_slice_copy(s : GeobufferellipseSlice) -> GeobufferellipseSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_slice_fill(s : GeobufferellipseSlice, v : Double) -> GeobufferellipseSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_ellipse_slice_min(s : GeobufferellipseSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_ellipse_slice_max(s : GeobufferellipseSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_ellipse_slice_to_string(s : GeobufferellipseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

