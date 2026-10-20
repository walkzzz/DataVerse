///===
/// extcore/opt_convex_gd

pub(all) struct OptconvexgdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_gd_make_point(x : Double, y : Double) -> OptconvexgdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_gd_make_point3(x : Double, y : Double, z : Double) -> OptconvexgdPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexgdPoint::x(self : OptconvexgdPoint) -> Double { self.x }

pub fn OptconvexgdPoint::y(self : OptconvexgdPoint) -> Double { self.y }

pub fn OptconvexgdPoint::z(self : OptconvexgdPoint) -> Double { self.z }

pub fn OptconvexgdPoint::label(self : OptconvexgdPoint) -> Int { self.label }

pub fn OptconvexgdPoint::dist(self : OptconvexgdPoint, other : OptconvexgdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexgdPoint::add(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexgdPoint::sub(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexgdPoint::scale(self : OptconvexgdPoint, s : Double) -> OptconvexgdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexgdPoint::dot(self : OptconvexgdPoint, other : OptconvexgdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexgdPoint::cross(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexgdPoint::norm(self : OptconvexgdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexgdPoint::normalize(self : OptconvexgdPoint) -> OptconvexgdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexgdPoint::negate(self : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexgdPoint::mid(self : OptconvexgdPoint, other : OptconvexgdPoint) -> OptconvexgdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexgdPoint::lerp(self : OptconvexgdPoint, other : OptconvexgdPoint, t : Double) -> OptconvexgdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexgdPoint::to_string(self : OptconvexgdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexgdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_gd_make_series(vals : Array[Double], name : String) -> OptconvexgdSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexgdSeries::len(self : OptconvexgdSeries) -> Int { self.vals.length() }

pub fn OptconvexgdSeries::sum(self : OptconvexgdSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexgdSeries::mean(self : OptconvexgdSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexgdSeries::min(self : OptconvexgdSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexgdSeries::max(self : OptconvexgdSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexgdSeries::range(self : OptconvexgdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexgdSeries::variance(self : OptconvexgdSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexgdSeries::std(self : OptconvexgdSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexgdSeries::median(self : OptconvexgdSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexgdSeries::scale(self : OptconvexgdSeries, f : Double) -> OptconvexgdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexgdSeries::add(self : OptconvexgdSeries, other : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexgdSeries::sub(self : OptconvexgdSeries, other : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexgdSeries::normalize(self : OptconvexgdSeries) -> OptconvexgdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexgdSeries::cumsum(self : OptconvexgdSeries) -> OptconvexgdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexgdSeries::to_string(self : OptconvexgdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexgdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_gd_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexgdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_gd_matrix_identity(n : Int) -> OptconvexgdMatrix {
  let m = opt_convex_gd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexgdMatrix::get(self : OptconvexgdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexgdMatrix::transpose(self : OptconvexgdMatrix) -> OptconvexgdMatrix {
  let result = opt_convex_gd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexgdMatrix::add(self : OptconvexgdMatrix, other : OptconvexgdMatrix) -> OptconvexgdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_gd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexgdMatrix::scale(self : OptconvexgdMatrix, s : Double) -> OptconvexgdMatrix {
  let result = opt_convex_gd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexgdMatrix::multiply(self : OptconvexgdMatrix, other : OptconvexgdMatrix) -> OptconvexgdMatrix {
  if self.cols != other.rows { return opt_convex_gd_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_gd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexgdMatrix::trace(self : OptconvexgdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexgdMatrix::det(self : OptconvexgdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexgdMatrix::norm(self : OptconvexgdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexgdMatrix::to_string(self : OptconvexgdMatrix) -> String {
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

pub(all) struct OptconvexgdVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_gd_make_vector(comps : Array[Double]) -> OptconvexgdVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_gd_vector_zero(dim : Int) -> OptconvexgdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexgdVector::add(self : OptconvexgdVector, other : OptconvexgdVector) -> OptconvexgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexgdVector::sub(self : OptconvexgdVector, other : OptconvexgdVector) -> OptconvexgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexgdVector::scale(self : OptconvexgdVector, s : Double) -> OptconvexgdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexgdVector::dot(self : OptconvexgdVector, other : OptconvexgdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexgdVector::norm(self : OptconvexgdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexgdVector::normalize(self : OptconvexgdVector) -> OptconvexgdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexgdVector::dist(self : OptconvexgdVector, other : OptconvexgdVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexgdVector::to_string(self : OptconvexgdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_gd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_gd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_gd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_gd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_gd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_gd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_gd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_gd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_gd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_gd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_gd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_gd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_gd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_gd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_gd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_gd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_gd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_gd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_gd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_gd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_gd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_gd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_gd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_gd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_gd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_gd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_gd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_gd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_gd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexgdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_frame_make(size : Int) -> OptconvexgdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_frame_len(s : OptconvexgdFrame) -> Int { s.size }

pub fn opt_convex_gd_frame_get(s : OptconvexgdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_frame_set(s : OptconvexgdFrame, i : Int, v : Double) -> OptconvexgdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_frame_sum(s : OptconvexgdFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_frame_mean(s : OptconvexgdFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_frame_scale(s : OptconvexgdFrame, f : Double) -> OptconvexgdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_frame_add(a : OptconvexgdFrame, b : OptconvexgdFrame) -> OptconvexgdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_frame_copy(s : OptconvexgdFrame) -> OptconvexgdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_frame_fill(s : OptconvexgdFrame, v : Double) -> OptconvexgdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_frame_min(s : OptconvexgdFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_frame_max(s : OptconvexgdFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_frame_to_string(s : OptconvexgdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_table_make(size : Int) -> OptconvexgdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_table_len(s : OptconvexgdTable) -> Int { s.size }

pub fn opt_convex_gd_table_get(s : OptconvexgdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_table_set(s : OptconvexgdTable, i : Int, v : Double) -> OptconvexgdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_table_sum(s : OptconvexgdTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_table_mean(s : OptconvexgdTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_table_scale(s : OptconvexgdTable, f : Double) -> OptconvexgdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_table_add(a : OptconvexgdTable, b : OptconvexgdTable) -> OptconvexgdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_table_copy(s : OptconvexgdTable) -> OptconvexgdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_table_fill(s : OptconvexgdTable, v : Double) -> OptconvexgdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_table_min(s : OptconvexgdTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_table_max(s : OptconvexgdTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_table_to_string(s : OptconvexgdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_graphn_make(size : Int) -> OptconvexgdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_graphn_len(s : OptconvexgdGraphN) -> Int { s.size }

pub fn opt_convex_gd_graphn_get(s : OptconvexgdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_graphn_set(s : OptconvexgdGraphN, i : Int, v : Double) -> OptconvexgdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_graphn_sum(s : OptconvexgdGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_graphn_mean(s : OptconvexgdGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_graphn_scale(s : OptconvexgdGraphN, f : Double) -> OptconvexgdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_graphn_add(a : OptconvexgdGraphN, b : OptconvexgdGraphN) -> OptconvexgdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_graphn_copy(s : OptconvexgdGraphN) -> OptconvexgdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_graphn_fill(s : OptconvexgdGraphN, v : Double) -> OptconvexgdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_graphn_min(s : OptconvexgdGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_graphn_max(s : OptconvexgdGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_graphn_to_string(s : OptconvexgdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_node_make(size : Int) -> OptconvexgdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_node_len(s : OptconvexgdNode) -> Int { s.size }

pub fn opt_convex_gd_node_get(s : OptconvexgdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_node_set(s : OptconvexgdNode, i : Int, v : Double) -> OptconvexgdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_node_sum(s : OptconvexgdNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_node_mean(s : OptconvexgdNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_node_scale(s : OptconvexgdNode, f : Double) -> OptconvexgdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_node_add(a : OptconvexgdNode, b : OptconvexgdNode) -> OptconvexgdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_node_copy(s : OptconvexgdNode) -> OptconvexgdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_node_fill(s : OptconvexgdNode, v : Double) -> OptconvexgdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_node_min(s : OptconvexgdNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_node_max(s : OptconvexgdNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_node_to_string(s : OptconvexgdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_edge_make(size : Int) -> OptconvexgdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_edge_len(s : OptconvexgdEdge) -> Int { s.size }

pub fn opt_convex_gd_edge_get(s : OptconvexgdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_edge_set(s : OptconvexgdEdge, i : Int, v : Double) -> OptconvexgdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_edge_sum(s : OptconvexgdEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_edge_mean(s : OptconvexgdEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_edge_scale(s : OptconvexgdEdge, f : Double) -> OptconvexgdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_edge_add(a : OptconvexgdEdge, b : OptconvexgdEdge) -> OptconvexgdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_edge_copy(s : OptconvexgdEdge) -> OptconvexgdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_edge_fill(s : OptconvexgdEdge, v : Double) -> OptconvexgdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_edge_min(s : OptconvexgdEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_edge_max(s : OptconvexgdEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_edge_to_string(s : OptconvexgdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_path_make(size : Int) -> OptconvexgdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_path_len(s : OptconvexgdPath) -> Int { s.size }

pub fn opt_convex_gd_path_get(s : OptconvexgdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_path_set(s : OptconvexgdPath, i : Int, v : Double) -> OptconvexgdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_path_sum(s : OptconvexgdPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_path_mean(s : OptconvexgdPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_path_scale(s : OptconvexgdPath, f : Double) -> OptconvexgdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_path_add(a : OptconvexgdPath, b : OptconvexgdPath) -> OptconvexgdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_path_copy(s : OptconvexgdPath) -> OptconvexgdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_path_fill(s : OptconvexgdPath, v : Double) -> OptconvexgdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_path_min(s : OptconvexgdPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_path_max(s : OptconvexgdPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_path_to_string(s : OptconvexgdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_cluster_make(size : Int) -> OptconvexgdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_cluster_len(s : OptconvexgdCluster) -> Int { s.size }

pub fn opt_convex_gd_cluster_get(s : OptconvexgdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_cluster_set(s : OptconvexgdCluster, i : Int, v : Double) -> OptconvexgdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cluster_sum(s : OptconvexgdCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_cluster_mean(s : OptconvexgdCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_cluster_scale(s : OptconvexgdCluster, f : Double) -> OptconvexgdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cluster_add(a : OptconvexgdCluster, b : OptconvexgdCluster) -> OptconvexgdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_cluster_copy(s : OptconvexgdCluster) -> OptconvexgdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cluster_fill(s : OptconvexgdCluster, v : Double) -> OptconvexgdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cluster_min(s : OptconvexgdCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_cluster_max(s : OptconvexgdCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_cluster_to_string(s : OptconvexgdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_model_make(size : Int) -> OptconvexgdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_model_len(s : OptconvexgdModel) -> Int { s.size }

pub fn opt_convex_gd_model_get(s : OptconvexgdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_model_set(s : OptconvexgdModel, i : Int, v : Double) -> OptconvexgdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_model_sum(s : OptconvexgdModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_model_mean(s : OptconvexgdModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_model_scale(s : OptconvexgdModel, f : Double) -> OptconvexgdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_model_add(a : OptconvexgdModel, b : OptconvexgdModel) -> OptconvexgdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_model_copy(s : OptconvexgdModel) -> OptconvexgdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_model_fill(s : OptconvexgdModel, v : Double) -> OptconvexgdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_model_min(s : OptconvexgdModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_model_max(s : OptconvexgdModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_model_to_string(s : OptconvexgdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_layer_make(size : Int) -> OptconvexgdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_layer_len(s : OptconvexgdLayer) -> Int { s.size }

pub fn opt_convex_gd_layer_get(s : OptconvexgdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_layer_set(s : OptconvexgdLayer, i : Int, v : Double) -> OptconvexgdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_layer_sum(s : OptconvexgdLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_layer_mean(s : OptconvexgdLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_layer_scale(s : OptconvexgdLayer, f : Double) -> OptconvexgdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_layer_add(a : OptconvexgdLayer, b : OptconvexgdLayer) -> OptconvexgdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_layer_copy(s : OptconvexgdLayer) -> OptconvexgdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_layer_fill(s : OptconvexgdLayer, v : Double) -> OptconvexgdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_layer_min(s : OptconvexgdLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_layer_max(s : OptconvexgdLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_layer_to_string(s : OptconvexgdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_buffer_make(size : Int) -> OptconvexgdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_buffer_len(s : OptconvexgdBuffer) -> Int { s.size }

pub fn opt_convex_gd_buffer_get(s : OptconvexgdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_buffer_set(s : OptconvexgdBuffer, i : Int, v : Double) -> OptconvexgdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_buffer_sum(s : OptconvexgdBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_buffer_mean(s : OptconvexgdBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_buffer_scale(s : OptconvexgdBuffer, f : Double) -> OptconvexgdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_buffer_add(a : OptconvexgdBuffer, b : OptconvexgdBuffer) -> OptconvexgdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_buffer_copy(s : OptconvexgdBuffer) -> OptconvexgdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_buffer_fill(s : OptconvexgdBuffer, v : Double) -> OptconvexgdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_buffer_min(s : OptconvexgdBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_buffer_max(s : OptconvexgdBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_buffer_to_string(s : OptconvexgdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_cursor_make(size : Int) -> OptconvexgdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_cursor_len(s : OptconvexgdCursor) -> Int { s.size }

pub fn opt_convex_gd_cursor_get(s : OptconvexgdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_cursor_set(s : OptconvexgdCursor, i : Int, v : Double) -> OptconvexgdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cursor_sum(s : OptconvexgdCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_cursor_mean(s : OptconvexgdCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_cursor_scale(s : OptconvexgdCursor, f : Double) -> OptconvexgdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cursor_add(a : OptconvexgdCursor, b : OptconvexgdCursor) -> OptconvexgdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_cursor_copy(s : OptconvexgdCursor) -> OptconvexgdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cursor_fill(s : OptconvexgdCursor, v : Double) -> OptconvexgdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_cursor_min(s : OptconvexgdCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_cursor_max(s : OptconvexgdCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_cursor_to_string(s : OptconvexgdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_view_make(size : Int) -> OptconvexgdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_view_len(s : OptconvexgdView) -> Int { s.size }

pub fn opt_convex_gd_view_get(s : OptconvexgdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_view_set(s : OptconvexgdView, i : Int, v : Double) -> OptconvexgdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_view_sum(s : OptconvexgdView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_view_mean(s : OptconvexgdView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_view_scale(s : OptconvexgdView, f : Double) -> OptconvexgdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_view_add(a : OptconvexgdView, b : OptconvexgdView) -> OptconvexgdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_view_copy(s : OptconvexgdView) -> OptconvexgdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_view_fill(s : OptconvexgdView, v : Double) -> OptconvexgdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_view_min(s : OptconvexgdView) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_view_max(s : OptconvexgdView) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_view_to_string(s : OptconvexgdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_range_make(size : Int) -> OptconvexgdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_range_len(s : OptconvexgdRange) -> Int { s.size }

pub fn opt_convex_gd_range_get(s : OptconvexgdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_range_set(s : OptconvexgdRange, i : Int, v : Double) -> OptconvexgdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_range_sum(s : OptconvexgdRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_range_mean(s : OptconvexgdRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_range_scale(s : OptconvexgdRange, f : Double) -> OptconvexgdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_range_add(a : OptconvexgdRange, b : OptconvexgdRange) -> OptconvexgdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_range_copy(s : OptconvexgdRange) -> OptconvexgdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_range_fill(s : OptconvexgdRange, v : Double) -> OptconvexgdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_range_min(s : OptconvexgdRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_range_max(s : OptconvexgdRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_range_to_string(s : OptconvexgdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexgdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_gd_slice_make(size : Int) -> OptconvexgdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_gd_slice_len(s : OptconvexgdSlice) -> Int { s.size }

pub fn opt_convex_gd_slice_get(s : OptconvexgdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_gd_slice_set(s : OptconvexgdSlice, i : Int, v : Double) -> OptconvexgdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_slice_sum(s : OptconvexgdSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_gd_slice_mean(s : OptconvexgdSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_gd_slice_scale(s : OptconvexgdSlice, f : Double) -> OptconvexgdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_slice_add(a : OptconvexgdSlice, b : OptconvexgdSlice) -> OptconvexgdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_gd_slice_copy(s : OptconvexgdSlice) -> OptconvexgdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_slice_fill(s : OptconvexgdSlice, v : Double) -> OptconvexgdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_gd_slice_min(s : OptconvexgdSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_gd_slice_max(s : OptconvexgdSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_gd_slice_to_string(s : OptconvexgdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

