///===
/// extcore/geo_intersect_ellipse

pub(all) struct GeointersectellipsePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_ellipse_make_point(x : Double, y : Double) -> GeointersectellipsePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_ellipse_make_point3(x : Double, y : Double, z : Double) -> GeointersectellipsePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectellipsePoint::x(self : GeointersectellipsePoint) -> Double { self.x }

pub fn GeointersectellipsePoint::y(self : GeointersectellipsePoint) -> Double { self.y }

pub fn GeointersectellipsePoint::z(self : GeointersectellipsePoint) -> Double { self.z }

pub fn GeointersectellipsePoint::label(self : GeointersectellipsePoint) -> Int { self.label }

pub fn GeointersectellipsePoint::dist(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectellipsePoint::add(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectellipsePoint::sub(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectellipsePoint::scale(self : GeointersectellipsePoint, s : Double) -> GeointersectellipsePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectellipsePoint::dot(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectellipsePoint::cross(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectellipsePoint::norm(self : GeointersectellipsePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectellipsePoint::normalize(self : GeointersectellipsePoint) -> GeointersectellipsePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectellipsePoint::negate(self : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectellipsePoint::mid(self : GeointersectellipsePoint, other : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectellipsePoint::lerp(self : GeointersectellipsePoint, other : GeointersectellipsePoint, t : Double) -> GeointersectellipsePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectellipsePoint::to_string(self : GeointersectellipsePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectellipseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_ellipse_make_series(vals : Array[Double], name : String) -> GeointersectellipseSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectellipseSeries::len(self : GeointersectellipseSeries) -> Int { self.vals.length() }

pub fn GeointersectellipseSeries::sum(self : GeointersectellipseSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectellipseSeries::mean(self : GeointersectellipseSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectellipseSeries::min(self : GeointersectellipseSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectellipseSeries::max(self : GeointersectellipseSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectellipseSeries::range(self : GeointersectellipseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectellipseSeries::variance(self : GeointersectellipseSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectellipseSeries::std(self : GeointersectellipseSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectellipseSeries::median(self : GeointersectellipseSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectellipseSeries::scale(self : GeointersectellipseSeries, f : Double) -> GeointersectellipseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectellipseSeries::add(self : GeointersectellipseSeries, other : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectellipseSeries::sub(self : GeointersectellipseSeries, other : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectellipseSeries::normalize(self : GeointersectellipseSeries) -> GeointersectellipseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectellipseSeries::cumsum(self : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectellipseSeries::to_string(self : GeointersectellipseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectellipseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_ellipse_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectellipseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_ellipse_matrix_identity(n : Int) -> GeointersectellipseMatrix {
  let m = geo_intersect_ellipse_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectellipseMatrix::get(self : GeointersectellipseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectellipseMatrix::transpose(self : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  let result = geo_intersect_ellipse_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectellipseMatrix::add(self : GeointersectellipseMatrix, other : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectellipseMatrix::scale(self : GeointersectellipseMatrix, s : Double) -> GeointersectellipseMatrix {
  let result = geo_intersect_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectellipseMatrix::multiply(self : GeointersectellipseMatrix, other : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  if self.cols != other.rows { return geo_intersect_ellipse_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_ellipse_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectellipseMatrix::trace(self : GeointersectellipseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectellipseMatrix::det(self : GeointersectellipseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectellipseMatrix::norm(self : GeointersectellipseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectellipseMatrix::to_string(self : GeointersectellipseMatrix) -> String {
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

pub(all) struct GeointersectellipseVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_ellipse_make_vector(comps : Array[Double]) -> GeointersectellipseVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_ellipse_vector_zero(dim : Int) -> GeointersectellipseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectellipseVector::add(self : GeointersectellipseVector, other : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectellipseVector::sub(self : GeointersectellipseVector, other : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectellipseVector::scale(self : GeointersectellipseVector, s : Double) -> GeointersectellipseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectellipseVector::dot(self : GeointersectellipseVector, other : GeointersectellipseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectellipseVector::norm(self : GeointersectellipseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectellipseVector::normalize(self : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectellipseVector::dist(self : GeointersectellipseVector, other : GeointersectellipseVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectellipseVector::to_string(self : GeointersectellipseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_ellipse_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_ellipse_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_ellipse_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_ellipse_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_ellipse_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_ellipse_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_ellipse_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_ellipse_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_ellipse_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_ellipse_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_ellipse_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_ellipse_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_ellipse_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_ellipse_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_ellipse_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_ellipse_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_ellipse_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_ellipse_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_ellipse_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_ellipse_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_ellipse_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_ellipse_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_ellipse_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_ellipse_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_ellipse_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_ellipse_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_ellipse_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_ellipse_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_ellipse_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectellipseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_frame_make(size : Int) -> GeointersectellipseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_frame_len(s : GeointersectellipseFrame) -> Int { s.size }

pub fn geo_intersect_ellipse_frame_get(s : GeointersectellipseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_frame_set(s : GeointersectellipseFrame, i : Int, v : Double) -> GeointersectellipseFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_sum(s : GeointersectellipseFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_frame_mean(s : GeointersectellipseFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_frame_scale(s : GeointersectellipseFrame, f : Double) -> GeointersectellipseFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_add(a : GeointersectellipseFrame, b : GeointersectellipseFrame) -> GeointersectellipseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_frame_copy(s : GeointersectellipseFrame) -> GeointersectellipseFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_fill(s : GeointersectellipseFrame, v : Double) -> GeointersectellipseFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_min(s : GeointersectellipseFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_frame_max(s : GeointersectellipseFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_frame_to_string(s : GeointersectellipseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_table_make(size : Int) -> GeointersectellipseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_table_len(s : GeointersectellipseTable) -> Int { s.size }

pub fn geo_intersect_ellipse_table_get(s : GeointersectellipseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_table_set(s : GeointersectellipseTable, i : Int, v : Double) -> GeointersectellipseTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_sum(s : GeointersectellipseTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_table_mean(s : GeointersectellipseTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_table_scale(s : GeointersectellipseTable, f : Double) -> GeointersectellipseTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_add(a : GeointersectellipseTable, b : GeointersectellipseTable) -> GeointersectellipseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_table_copy(s : GeointersectellipseTable) -> GeointersectellipseTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_fill(s : GeointersectellipseTable, v : Double) -> GeointersectellipseTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_min(s : GeointersectellipseTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_table_max(s : GeointersectellipseTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_table_to_string(s : GeointersectellipseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_graphn_make(size : Int) -> GeointersectellipseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_graphn_len(s : GeointersectellipseGraphN) -> Int { s.size }

pub fn geo_intersect_ellipse_graphn_get(s : GeointersectellipseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_graphn_set(s : GeointersectellipseGraphN, i : Int, v : Double) -> GeointersectellipseGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_sum(s : GeointersectellipseGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_graphn_mean(s : GeointersectellipseGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_graphn_scale(s : GeointersectellipseGraphN, f : Double) -> GeointersectellipseGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_add(a : GeointersectellipseGraphN, b : GeointersectellipseGraphN) -> GeointersectellipseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_graphn_copy(s : GeointersectellipseGraphN) -> GeointersectellipseGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_fill(s : GeointersectellipseGraphN, v : Double) -> GeointersectellipseGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_min(s : GeointersectellipseGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_graphn_max(s : GeointersectellipseGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_graphn_to_string(s : GeointersectellipseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_node_make(size : Int) -> GeointersectellipseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_node_len(s : GeointersectellipseNode) -> Int { s.size }

pub fn geo_intersect_ellipse_node_get(s : GeointersectellipseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_node_set(s : GeointersectellipseNode, i : Int, v : Double) -> GeointersectellipseNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_sum(s : GeointersectellipseNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_node_mean(s : GeointersectellipseNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_node_scale(s : GeointersectellipseNode, f : Double) -> GeointersectellipseNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_add(a : GeointersectellipseNode, b : GeointersectellipseNode) -> GeointersectellipseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_node_copy(s : GeointersectellipseNode) -> GeointersectellipseNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_fill(s : GeointersectellipseNode, v : Double) -> GeointersectellipseNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_min(s : GeointersectellipseNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_node_max(s : GeointersectellipseNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_node_to_string(s : GeointersectellipseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_edge_make(size : Int) -> GeointersectellipseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_edge_len(s : GeointersectellipseEdge) -> Int { s.size }

pub fn geo_intersect_ellipse_edge_get(s : GeointersectellipseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_edge_set(s : GeointersectellipseEdge, i : Int, v : Double) -> GeointersectellipseEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_sum(s : GeointersectellipseEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_edge_mean(s : GeointersectellipseEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_edge_scale(s : GeointersectellipseEdge, f : Double) -> GeointersectellipseEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_add(a : GeointersectellipseEdge, b : GeointersectellipseEdge) -> GeointersectellipseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_edge_copy(s : GeointersectellipseEdge) -> GeointersectellipseEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_fill(s : GeointersectellipseEdge, v : Double) -> GeointersectellipseEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_min(s : GeointersectellipseEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_edge_max(s : GeointersectellipseEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_edge_to_string(s : GeointersectellipseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipsePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_path_make(size : Int) -> GeointersectellipsePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_path_len(s : GeointersectellipsePath) -> Int { s.size }

pub fn geo_intersect_ellipse_path_get(s : GeointersectellipsePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_path_set(s : GeointersectellipsePath, i : Int, v : Double) -> GeointersectellipsePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_sum(s : GeointersectellipsePath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_path_mean(s : GeointersectellipsePath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_path_scale(s : GeointersectellipsePath, f : Double) -> GeointersectellipsePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_add(a : GeointersectellipsePath, b : GeointersectellipsePath) -> GeointersectellipsePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_path_copy(s : GeointersectellipsePath) -> GeointersectellipsePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_fill(s : GeointersectellipsePath, v : Double) -> GeointersectellipsePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_min(s : GeointersectellipsePath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_path_max(s : GeointersectellipsePath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_path_to_string(s : GeointersectellipsePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_cluster_make(size : Int) -> GeointersectellipseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_cluster_len(s : GeointersectellipseCluster) -> Int { s.size }

pub fn geo_intersect_ellipse_cluster_get(s : GeointersectellipseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_cluster_set(s : GeointersectellipseCluster, i : Int, v : Double) -> GeointersectellipseCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_sum(s : GeointersectellipseCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_cluster_mean(s : GeointersectellipseCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_cluster_scale(s : GeointersectellipseCluster, f : Double) -> GeointersectellipseCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_add(a : GeointersectellipseCluster, b : GeointersectellipseCluster) -> GeointersectellipseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_cluster_copy(s : GeointersectellipseCluster) -> GeointersectellipseCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_fill(s : GeointersectellipseCluster, v : Double) -> GeointersectellipseCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_min(s : GeointersectellipseCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_cluster_max(s : GeointersectellipseCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_cluster_to_string(s : GeointersectellipseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_model_make(size : Int) -> GeointersectellipseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_model_len(s : GeointersectellipseModel) -> Int { s.size }

pub fn geo_intersect_ellipse_model_get(s : GeointersectellipseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_model_set(s : GeointersectellipseModel, i : Int, v : Double) -> GeointersectellipseModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_sum(s : GeointersectellipseModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_model_mean(s : GeointersectellipseModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_model_scale(s : GeointersectellipseModel, f : Double) -> GeointersectellipseModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_add(a : GeointersectellipseModel, b : GeointersectellipseModel) -> GeointersectellipseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_model_copy(s : GeointersectellipseModel) -> GeointersectellipseModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_fill(s : GeointersectellipseModel, v : Double) -> GeointersectellipseModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_min(s : GeointersectellipseModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_model_max(s : GeointersectellipseModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_model_to_string(s : GeointersectellipseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_layer_make(size : Int) -> GeointersectellipseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_layer_len(s : GeointersectellipseLayer) -> Int { s.size }

pub fn geo_intersect_ellipse_layer_get(s : GeointersectellipseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_layer_set(s : GeointersectellipseLayer, i : Int, v : Double) -> GeointersectellipseLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_sum(s : GeointersectellipseLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_layer_mean(s : GeointersectellipseLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_layer_scale(s : GeointersectellipseLayer, f : Double) -> GeointersectellipseLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_add(a : GeointersectellipseLayer, b : GeointersectellipseLayer) -> GeointersectellipseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_layer_copy(s : GeointersectellipseLayer) -> GeointersectellipseLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_fill(s : GeointersectellipseLayer, v : Double) -> GeointersectellipseLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_min(s : GeointersectellipseLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_layer_max(s : GeointersectellipseLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_layer_to_string(s : GeointersectellipseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_buffer_make(size : Int) -> GeointersectellipseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_buffer_len(s : GeointersectellipseBuffer) -> Int { s.size }

pub fn geo_intersect_ellipse_buffer_get(s : GeointersectellipseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_buffer_set(s : GeointersectellipseBuffer, i : Int, v : Double) -> GeointersectellipseBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_sum(s : GeointersectellipseBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_buffer_mean(s : GeointersectellipseBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_buffer_scale(s : GeointersectellipseBuffer, f : Double) -> GeointersectellipseBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_add(a : GeointersectellipseBuffer, b : GeointersectellipseBuffer) -> GeointersectellipseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_buffer_copy(s : GeointersectellipseBuffer) -> GeointersectellipseBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_fill(s : GeointersectellipseBuffer, v : Double) -> GeointersectellipseBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_min(s : GeointersectellipseBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_buffer_max(s : GeointersectellipseBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_buffer_to_string(s : GeointersectellipseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_cursor_make(size : Int) -> GeointersectellipseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_cursor_len(s : GeointersectellipseCursor) -> Int { s.size }

pub fn geo_intersect_ellipse_cursor_get(s : GeointersectellipseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_cursor_set(s : GeointersectellipseCursor, i : Int, v : Double) -> GeointersectellipseCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_sum(s : GeointersectellipseCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_cursor_mean(s : GeointersectellipseCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_cursor_scale(s : GeointersectellipseCursor, f : Double) -> GeointersectellipseCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_add(a : GeointersectellipseCursor, b : GeointersectellipseCursor) -> GeointersectellipseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_cursor_copy(s : GeointersectellipseCursor) -> GeointersectellipseCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_fill(s : GeointersectellipseCursor, v : Double) -> GeointersectellipseCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_min(s : GeointersectellipseCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_cursor_max(s : GeointersectellipseCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_cursor_to_string(s : GeointersectellipseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_view_make(size : Int) -> GeointersectellipseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_view_len(s : GeointersectellipseView) -> Int { s.size }

pub fn geo_intersect_ellipse_view_get(s : GeointersectellipseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_view_set(s : GeointersectellipseView, i : Int, v : Double) -> GeointersectellipseView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_sum(s : GeointersectellipseView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_view_mean(s : GeointersectellipseView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_view_scale(s : GeointersectellipseView, f : Double) -> GeointersectellipseView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_add(a : GeointersectellipseView, b : GeointersectellipseView) -> GeointersectellipseView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_view_copy(s : GeointersectellipseView) -> GeointersectellipseView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_fill(s : GeointersectellipseView, v : Double) -> GeointersectellipseView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_min(s : GeointersectellipseView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_view_max(s : GeointersectellipseView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_view_to_string(s : GeointersectellipseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_range_make(size : Int) -> GeointersectellipseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_range_len(s : GeointersectellipseRange) -> Int { s.size }

pub fn geo_intersect_ellipse_range_get(s : GeointersectellipseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_range_set(s : GeointersectellipseRange, i : Int, v : Double) -> GeointersectellipseRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_sum(s : GeointersectellipseRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_range_mean(s : GeointersectellipseRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_range_scale(s : GeointersectellipseRange, f : Double) -> GeointersectellipseRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_add(a : GeointersectellipseRange, b : GeointersectellipseRange) -> GeointersectellipseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_range_copy(s : GeointersectellipseRange) -> GeointersectellipseRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_fill(s : GeointersectellipseRange, v : Double) -> GeointersectellipseRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_min(s : GeointersectellipseRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_range_max(s : GeointersectellipseRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_range_to_string(s : GeointersectellipseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_slice_make(size : Int) -> GeointersectellipseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_slice_len(s : GeointersectellipseSlice) -> Int { s.size }

pub fn geo_intersect_ellipse_slice_get(s : GeointersectellipseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_slice_set(s : GeointersectellipseSlice, i : Int, v : Double) -> GeointersectellipseSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_sum(s : GeointersectellipseSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_slice_mean(s : GeointersectellipseSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_slice_scale(s : GeointersectellipseSlice, f : Double) -> GeointersectellipseSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_add(a : GeointersectellipseSlice, b : GeointersectellipseSlice) -> GeointersectellipseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_slice_copy(s : GeointersectellipseSlice) -> GeointersectellipseSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_fill(s : GeointersectellipseSlice, v : Double) -> GeointersectellipseSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_min(s : GeointersectellipseSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_slice_max(s : GeointersectellipseSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_slice_to_string(s : GeointersectellipseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

