///===
/// extcore/opt_convex_line_search

pub(all) struct OptconvexlinesearchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_line_search_make_point(x : Double, y : Double) -> OptconvexlinesearchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_line_search_make_point3(x : Double, y : Double, z : Double) -> OptconvexlinesearchPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexlinesearchPoint::x(self : OptconvexlinesearchPoint) -> Double { self.x }

pub fn OptconvexlinesearchPoint::y(self : OptconvexlinesearchPoint) -> Double { self.y }

pub fn OptconvexlinesearchPoint::z(self : OptconvexlinesearchPoint) -> Double { self.z }

pub fn OptconvexlinesearchPoint::label(self : OptconvexlinesearchPoint) -> Int { self.label }

pub fn OptconvexlinesearchPoint::dist(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexlinesearchPoint::add(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexlinesearchPoint::sub(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexlinesearchPoint::scale(self : OptconvexlinesearchPoint, s : Double) -> OptconvexlinesearchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexlinesearchPoint::dot(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexlinesearchPoint::cross(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexlinesearchPoint::norm(self : OptconvexlinesearchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexlinesearchPoint::normalize(self : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlinesearchPoint::negate(self : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexlinesearchPoint::mid(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint) -> OptconvexlinesearchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexlinesearchPoint::lerp(self : OptconvexlinesearchPoint, other : OptconvexlinesearchPoint, t : Double) -> OptconvexlinesearchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexlinesearchPoint::to_string(self : OptconvexlinesearchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexlinesearchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_line_search_make_series(vals : Array[Double], name : String) -> OptconvexlinesearchSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexlinesearchSeries::len(self : OptconvexlinesearchSeries) -> Int { self.vals.length() }

pub fn OptconvexlinesearchSeries::sum(self : OptconvexlinesearchSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexlinesearchSeries::mean(self : OptconvexlinesearchSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexlinesearchSeries::min(self : OptconvexlinesearchSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexlinesearchSeries::max(self : OptconvexlinesearchSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexlinesearchSeries::range(self : OptconvexlinesearchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexlinesearchSeries::variance(self : OptconvexlinesearchSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexlinesearchSeries::std(self : OptconvexlinesearchSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexlinesearchSeries::median(self : OptconvexlinesearchSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexlinesearchSeries::scale(self : OptconvexlinesearchSeries, f : Double) -> OptconvexlinesearchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexlinesearchSeries::add(self : OptconvexlinesearchSeries, other : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexlinesearchSeries::sub(self : OptconvexlinesearchSeries, other : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexlinesearchSeries::normalize(self : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexlinesearchSeries::cumsum(self : OptconvexlinesearchSeries) -> OptconvexlinesearchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexlinesearchSeries::to_string(self : OptconvexlinesearchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlinesearchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_line_search_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlinesearchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_line_search_matrix_identity(n : Int) -> OptconvexlinesearchMatrix {
  let m = opt_convex_line_search_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexlinesearchMatrix::get(self : OptconvexlinesearchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexlinesearchMatrix::transpose(self : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  let result = opt_convex_line_search_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexlinesearchMatrix::add(self : OptconvexlinesearchMatrix, other : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_line_search_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexlinesearchMatrix::scale(self : OptconvexlinesearchMatrix, s : Double) -> OptconvexlinesearchMatrix {
  let result = opt_convex_line_search_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexlinesearchMatrix::multiply(self : OptconvexlinesearchMatrix, other : OptconvexlinesearchMatrix) -> OptconvexlinesearchMatrix {
  if self.cols != other.rows { return opt_convex_line_search_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_line_search_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexlinesearchMatrix::trace(self : OptconvexlinesearchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexlinesearchMatrix::det(self : OptconvexlinesearchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexlinesearchMatrix::norm(self : OptconvexlinesearchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexlinesearchMatrix::to_string(self : OptconvexlinesearchMatrix) -> String {
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

pub(all) struct OptconvexlinesearchVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_line_search_make_vector(comps : Array[Double]) -> OptconvexlinesearchVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_line_search_vector_zero(dim : Int) -> OptconvexlinesearchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexlinesearchVector::add(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlinesearchVector::sub(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlinesearchVector::scale(self : OptconvexlinesearchVector, s : Double) -> OptconvexlinesearchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexlinesearchVector::dot(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexlinesearchVector::norm(self : OptconvexlinesearchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexlinesearchVector::normalize(self : OptconvexlinesearchVector) -> OptconvexlinesearchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlinesearchVector::dist(self : OptconvexlinesearchVector, other : OptconvexlinesearchVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexlinesearchVector::to_string(self : OptconvexlinesearchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_line_search_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_line_search_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_line_search_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_line_search_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_line_search_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_line_search_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_line_search_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_line_search_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_line_search_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_line_search_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_line_search_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_line_search_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_line_search_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_line_search_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_line_search_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_line_search_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_line_search_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_line_search_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_line_search_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_line_search_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_line_search_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_line_search_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_line_search_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_line_search_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_line_search_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_line_search_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_line_search_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_line_search_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_line_search_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexlinesearchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_frame_make(size : Int) -> OptconvexlinesearchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_frame_len(s : OptconvexlinesearchFrame) -> Int { s.size }

pub fn opt_convex_line_search_frame_get(s : OptconvexlinesearchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_frame_set(s : OptconvexlinesearchFrame, i : Int, v : Double) -> OptconvexlinesearchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_frame_sum(s : OptconvexlinesearchFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_frame_mean(s : OptconvexlinesearchFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_frame_scale(s : OptconvexlinesearchFrame, f : Double) -> OptconvexlinesearchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_frame_add(a : OptconvexlinesearchFrame, b : OptconvexlinesearchFrame) -> OptconvexlinesearchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_frame_copy(s : OptconvexlinesearchFrame) -> OptconvexlinesearchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_frame_fill(s : OptconvexlinesearchFrame, v : Double) -> OptconvexlinesearchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_frame_min(s : OptconvexlinesearchFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_frame_max(s : OptconvexlinesearchFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_frame_to_string(s : OptconvexlinesearchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_table_make(size : Int) -> OptconvexlinesearchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_table_len(s : OptconvexlinesearchTable) -> Int { s.size }

pub fn opt_convex_line_search_table_get(s : OptconvexlinesearchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_table_set(s : OptconvexlinesearchTable, i : Int, v : Double) -> OptconvexlinesearchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_table_sum(s : OptconvexlinesearchTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_table_mean(s : OptconvexlinesearchTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_table_scale(s : OptconvexlinesearchTable, f : Double) -> OptconvexlinesearchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_table_add(a : OptconvexlinesearchTable, b : OptconvexlinesearchTable) -> OptconvexlinesearchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_table_copy(s : OptconvexlinesearchTable) -> OptconvexlinesearchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_table_fill(s : OptconvexlinesearchTable, v : Double) -> OptconvexlinesearchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_table_min(s : OptconvexlinesearchTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_table_max(s : OptconvexlinesearchTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_table_to_string(s : OptconvexlinesearchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_graphn_make(size : Int) -> OptconvexlinesearchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_graphn_len(s : OptconvexlinesearchGraphN) -> Int { s.size }

pub fn opt_convex_line_search_graphn_get(s : OptconvexlinesearchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_graphn_set(s : OptconvexlinesearchGraphN, i : Int, v : Double) -> OptconvexlinesearchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_graphn_sum(s : OptconvexlinesearchGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_graphn_mean(s : OptconvexlinesearchGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_graphn_scale(s : OptconvexlinesearchGraphN, f : Double) -> OptconvexlinesearchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_graphn_add(a : OptconvexlinesearchGraphN, b : OptconvexlinesearchGraphN) -> OptconvexlinesearchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_graphn_copy(s : OptconvexlinesearchGraphN) -> OptconvexlinesearchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_graphn_fill(s : OptconvexlinesearchGraphN, v : Double) -> OptconvexlinesearchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_graphn_min(s : OptconvexlinesearchGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_graphn_max(s : OptconvexlinesearchGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_graphn_to_string(s : OptconvexlinesearchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_node_make(size : Int) -> OptconvexlinesearchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_node_len(s : OptconvexlinesearchNode) -> Int { s.size }

pub fn opt_convex_line_search_node_get(s : OptconvexlinesearchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_node_set(s : OptconvexlinesearchNode, i : Int, v : Double) -> OptconvexlinesearchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_node_sum(s : OptconvexlinesearchNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_node_mean(s : OptconvexlinesearchNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_node_scale(s : OptconvexlinesearchNode, f : Double) -> OptconvexlinesearchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_node_add(a : OptconvexlinesearchNode, b : OptconvexlinesearchNode) -> OptconvexlinesearchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_node_copy(s : OptconvexlinesearchNode) -> OptconvexlinesearchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_node_fill(s : OptconvexlinesearchNode, v : Double) -> OptconvexlinesearchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_node_min(s : OptconvexlinesearchNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_node_max(s : OptconvexlinesearchNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_node_to_string(s : OptconvexlinesearchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_edge_make(size : Int) -> OptconvexlinesearchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_edge_len(s : OptconvexlinesearchEdge) -> Int { s.size }

pub fn opt_convex_line_search_edge_get(s : OptconvexlinesearchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_edge_set(s : OptconvexlinesearchEdge, i : Int, v : Double) -> OptconvexlinesearchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_edge_sum(s : OptconvexlinesearchEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_edge_mean(s : OptconvexlinesearchEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_edge_scale(s : OptconvexlinesearchEdge, f : Double) -> OptconvexlinesearchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_edge_add(a : OptconvexlinesearchEdge, b : OptconvexlinesearchEdge) -> OptconvexlinesearchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_edge_copy(s : OptconvexlinesearchEdge) -> OptconvexlinesearchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_edge_fill(s : OptconvexlinesearchEdge, v : Double) -> OptconvexlinesearchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_edge_min(s : OptconvexlinesearchEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_edge_max(s : OptconvexlinesearchEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_edge_to_string(s : OptconvexlinesearchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_path_make(size : Int) -> OptconvexlinesearchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_path_len(s : OptconvexlinesearchPath) -> Int { s.size }

pub fn opt_convex_line_search_path_get(s : OptconvexlinesearchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_path_set(s : OptconvexlinesearchPath, i : Int, v : Double) -> OptconvexlinesearchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_path_sum(s : OptconvexlinesearchPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_path_mean(s : OptconvexlinesearchPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_path_scale(s : OptconvexlinesearchPath, f : Double) -> OptconvexlinesearchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_path_add(a : OptconvexlinesearchPath, b : OptconvexlinesearchPath) -> OptconvexlinesearchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_path_copy(s : OptconvexlinesearchPath) -> OptconvexlinesearchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_path_fill(s : OptconvexlinesearchPath, v : Double) -> OptconvexlinesearchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_path_min(s : OptconvexlinesearchPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_path_max(s : OptconvexlinesearchPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_path_to_string(s : OptconvexlinesearchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_cluster_make(size : Int) -> OptconvexlinesearchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_cluster_len(s : OptconvexlinesearchCluster) -> Int { s.size }

pub fn opt_convex_line_search_cluster_get(s : OptconvexlinesearchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_cluster_set(s : OptconvexlinesearchCluster, i : Int, v : Double) -> OptconvexlinesearchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cluster_sum(s : OptconvexlinesearchCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_cluster_mean(s : OptconvexlinesearchCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_cluster_scale(s : OptconvexlinesearchCluster, f : Double) -> OptconvexlinesearchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cluster_add(a : OptconvexlinesearchCluster, b : OptconvexlinesearchCluster) -> OptconvexlinesearchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_cluster_copy(s : OptconvexlinesearchCluster) -> OptconvexlinesearchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cluster_fill(s : OptconvexlinesearchCluster, v : Double) -> OptconvexlinesearchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cluster_min(s : OptconvexlinesearchCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_cluster_max(s : OptconvexlinesearchCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_cluster_to_string(s : OptconvexlinesearchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_model_make(size : Int) -> OptconvexlinesearchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_model_len(s : OptconvexlinesearchModel) -> Int { s.size }

pub fn opt_convex_line_search_model_get(s : OptconvexlinesearchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_model_set(s : OptconvexlinesearchModel, i : Int, v : Double) -> OptconvexlinesearchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_model_sum(s : OptconvexlinesearchModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_model_mean(s : OptconvexlinesearchModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_model_scale(s : OptconvexlinesearchModel, f : Double) -> OptconvexlinesearchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_model_add(a : OptconvexlinesearchModel, b : OptconvexlinesearchModel) -> OptconvexlinesearchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_model_copy(s : OptconvexlinesearchModel) -> OptconvexlinesearchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_model_fill(s : OptconvexlinesearchModel, v : Double) -> OptconvexlinesearchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_model_min(s : OptconvexlinesearchModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_model_max(s : OptconvexlinesearchModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_model_to_string(s : OptconvexlinesearchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_layer_make(size : Int) -> OptconvexlinesearchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_layer_len(s : OptconvexlinesearchLayer) -> Int { s.size }

pub fn opt_convex_line_search_layer_get(s : OptconvexlinesearchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_layer_set(s : OptconvexlinesearchLayer, i : Int, v : Double) -> OptconvexlinesearchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_layer_sum(s : OptconvexlinesearchLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_layer_mean(s : OptconvexlinesearchLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_layer_scale(s : OptconvexlinesearchLayer, f : Double) -> OptconvexlinesearchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_layer_add(a : OptconvexlinesearchLayer, b : OptconvexlinesearchLayer) -> OptconvexlinesearchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_layer_copy(s : OptconvexlinesearchLayer) -> OptconvexlinesearchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_layer_fill(s : OptconvexlinesearchLayer, v : Double) -> OptconvexlinesearchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_layer_min(s : OptconvexlinesearchLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_layer_max(s : OptconvexlinesearchLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_layer_to_string(s : OptconvexlinesearchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_buffer_make(size : Int) -> OptconvexlinesearchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_buffer_len(s : OptconvexlinesearchBuffer) -> Int { s.size }

pub fn opt_convex_line_search_buffer_get(s : OptconvexlinesearchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_buffer_set(s : OptconvexlinesearchBuffer, i : Int, v : Double) -> OptconvexlinesearchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_buffer_sum(s : OptconvexlinesearchBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_buffer_mean(s : OptconvexlinesearchBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_buffer_scale(s : OptconvexlinesearchBuffer, f : Double) -> OptconvexlinesearchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_buffer_add(a : OptconvexlinesearchBuffer, b : OptconvexlinesearchBuffer) -> OptconvexlinesearchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_buffer_copy(s : OptconvexlinesearchBuffer) -> OptconvexlinesearchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_buffer_fill(s : OptconvexlinesearchBuffer, v : Double) -> OptconvexlinesearchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_buffer_min(s : OptconvexlinesearchBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_buffer_max(s : OptconvexlinesearchBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_buffer_to_string(s : OptconvexlinesearchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_cursor_make(size : Int) -> OptconvexlinesearchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_cursor_len(s : OptconvexlinesearchCursor) -> Int { s.size }

pub fn opt_convex_line_search_cursor_get(s : OptconvexlinesearchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_cursor_set(s : OptconvexlinesearchCursor, i : Int, v : Double) -> OptconvexlinesearchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cursor_sum(s : OptconvexlinesearchCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_cursor_mean(s : OptconvexlinesearchCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_cursor_scale(s : OptconvexlinesearchCursor, f : Double) -> OptconvexlinesearchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cursor_add(a : OptconvexlinesearchCursor, b : OptconvexlinesearchCursor) -> OptconvexlinesearchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_cursor_copy(s : OptconvexlinesearchCursor) -> OptconvexlinesearchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cursor_fill(s : OptconvexlinesearchCursor, v : Double) -> OptconvexlinesearchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_cursor_min(s : OptconvexlinesearchCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_cursor_max(s : OptconvexlinesearchCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_cursor_to_string(s : OptconvexlinesearchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_view_make(size : Int) -> OptconvexlinesearchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_view_len(s : OptconvexlinesearchView) -> Int { s.size }

pub fn opt_convex_line_search_view_get(s : OptconvexlinesearchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_view_set(s : OptconvexlinesearchView, i : Int, v : Double) -> OptconvexlinesearchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_view_sum(s : OptconvexlinesearchView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_view_mean(s : OptconvexlinesearchView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_view_scale(s : OptconvexlinesearchView, f : Double) -> OptconvexlinesearchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_view_add(a : OptconvexlinesearchView, b : OptconvexlinesearchView) -> OptconvexlinesearchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_view_copy(s : OptconvexlinesearchView) -> OptconvexlinesearchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_view_fill(s : OptconvexlinesearchView, v : Double) -> OptconvexlinesearchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_view_min(s : OptconvexlinesearchView) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_view_max(s : OptconvexlinesearchView) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_view_to_string(s : OptconvexlinesearchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_range_make(size : Int) -> OptconvexlinesearchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_range_len(s : OptconvexlinesearchRange) -> Int { s.size }

pub fn opt_convex_line_search_range_get(s : OptconvexlinesearchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_range_set(s : OptconvexlinesearchRange, i : Int, v : Double) -> OptconvexlinesearchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_range_sum(s : OptconvexlinesearchRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_range_mean(s : OptconvexlinesearchRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_range_scale(s : OptconvexlinesearchRange, f : Double) -> OptconvexlinesearchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_range_add(a : OptconvexlinesearchRange, b : OptconvexlinesearchRange) -> OptconvexlinesearchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_range_copy(s : OptconvexlinesearchRange) -> OptconvexlinesearchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_range_fill(s : OptconvexlinesearchRange, v : Double) -> OptconvexlinesearchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_range_min(s : OptconvexlinesearchRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_range_max(s : OptconvexlinesearchRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_range_to_string(s : OptconvexlinesearchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlinesearchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_line_search_slice_make(size : Int) -> OptconvexlinesearchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_line_search_slice_len(s : OptconvexlinesearchSlice) -> Int { s.size }

pub fn opt_convex_line_search_slice_get(s : OptconvexlinesearchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_line_search_slice_set(s : OptconvexlinesearchSlice, i : Int, v : Double) -> OptconvexlinesearchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_slice_sum(s : OptconvexlinesearchSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_line_search_slice_mean(s : OptconvexlinesearchSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_line_search_slice_scale(s : OptconvexlinesearchSlice, f : Double) -> OptconvexlinesearchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_slice_add(a : OptconvexlinesearchSlice, b : OptconvexlinesearchSlice) -> OptconvexlinesearchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_line_search_slice_copy(s : OptconvexlinesearchSlice) -> OptconvexlinesearchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_slice_fill(s : OptconvexlinesearchSlice, v : Double) -> OptconvexlinesearchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_line_search_slice_min(s : OptconvexlinesearchSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_line_search_slice_max(s : OptconvexlinesearchSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_line_search_slice_to_string(s : OptconvexlinesearchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

