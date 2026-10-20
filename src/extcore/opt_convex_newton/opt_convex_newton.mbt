///===
/// extcore/opt_convex_newton

pub(all) struct OptconvexnewtonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_newton_make_point(x : Double, y : Double) -> OptconvexnewtonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_newton_make_point3(x : Double, y : Double, z : Double) -> OptconvexnewtonPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexnewtonPoint::x(self : OptconvexnewtonPoint) -> Double { self.x }

pub fn OptconvexnewtonPoint::y(self : OptconvexnewtonPoint) -> Double { self.y }

pub fn OptconvexnewtonPoint::z(self : OptconvexnewtonPoint) -> Double { self.z }

pub fn OptconvexnewtonPoint::label(self : OptconvexnewtonPoint) -> Int { self.label }

pub fn OptconvexnewtonPoint::dist(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexnewtonPoint::add(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexnewtonPoint::sub(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexnewtonPoint::scale(self : OptconvexnewtonPoint, s : Double) -> OptconvexnewtonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexnewtonPoint::dot(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexnewtonPoint::cross(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexnewtonPoint::norm(self : OptconvexnewtonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexnewtonPoint::normalize(self : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexnewtonPoint::negate(self : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexnewtonPoint::mid(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexnewtonPoint::lerp(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint, t : Double) -> OptconvexnewtonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexnewtonPoint::to_string(self : OptconvexnewtonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexnewtonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_newton_make_series(vals : Array[Double], name : String) -> OptconvexnewtonSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexnewtonSeries::len(self : OptconvexnewtonSeries) -> Int { self.vals.length() }

pub fn OptconvexnewtonSeries::sum(self : OptconvexnewtonSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexnewtonSeries::mean(self : OptconvexnewtonSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexnewtonSeries::min(self : OptconvexnewtonSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexnewtonSeries::max(self : OptconvexnewtonSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexnewtonSeries::range(self : OptconvexnewtonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexnewtonSeries::variance(self : OptconvexnewtonSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexnewtonSeries::std(self : OptconvexnewtonSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexnewtonSeries::median(self : OptconvexnewtonSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexnewtonSeries::scale(self : OptconvexnewtonSeries, f : Double) -> OptconvexnewtonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexnewtonSeries::add(self : OptconvexnewtonSeries, other : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexnewtonSeries::sub(self : OptconvexnewtonSeries, other : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexnewtonSeries::normalize(self : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexnewtonSeries::cumsum(self : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexnewtonSeries::to_string(self : OptconvexnewtonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexnewtonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_newton_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexnewtonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_newton_matrix_identity(n : Int) -> OptconvexnewtonMatrix {
  let m = opt_convex_newton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexnewtonMatrix::get(self : OptconvexnewtonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexnewtonMatrix::transpose(self : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  let result = opt_convex_newton_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexnewtonMatrix::add(self : OptconvexnewtonMatrix, other : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexnewtonMatrix::scale(self : OptconvexnewtonMatrix, s : Double) -> OptconvexnewtonMatrix {
  let result = opt_convex_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexnewtonMatrix::multiply(self : OptconvexnewtonMatrix, other : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  if self.cols != other.rows { return opt_convex_newton_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_newton_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexnewtonMatrix::trace(self : OptconvexnewtonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexnewtonMatrix::det(self : OptconvexnewtonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexnewtonMatrix::norm(self : OptconvexnewtonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexnewtonMatrix::to_string(self : OptconvexnewtonMatrix) -> String {
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

pub(all) struct OptconvexnewtonVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_newton_make_vector(comps : Array[Double]) -> OptconvexnewtonVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_newton_vector_zero(dim : Int) -> OptconvexnewtonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexnewtonVector::add(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexnewtonVector::sub(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexnewtonVector::scale(self : OptconvexnewtonVector, s : Double) -> OptconvexnewtonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexnewtonVector::dot(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexnewtonVector::norm(self : OptconvexnewtonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexnewtonVector::normalize(self : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexnewtonVector::dist(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexnewtonVector::to_string(self : OptconvexnewtonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_newton_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_newton_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_newton_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_newton_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_newton_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_newton_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_newton_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_newton_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_newton_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_newton_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_newton_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_newton_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_newton_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_newton_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_newton_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_newton_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_newton_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_newton_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_newton_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_newton_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_newton_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_newton_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_newton_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_newton_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_newton_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_newton_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_newton_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_newton_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_newton_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexnewtonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_frame_make(size : Int) -> OptconvexnewtonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_frame_len(s : OptconvexnewtonFrame) -> Int { s.size }

pub fn opt_convex_newton_frame_get(s : OptconvexnewtonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_frame_set(s : OptconvexnewtonFrame, i : Int, v : Double) -> OptconvexnewtonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_frame_sum(s : OptconvexnewtonFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_frame_mean(s : OptconvexnewtonFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_frame_scale(s : OptconvexnewtonFrame, f : Double) -> OptconvexnewtonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_frame_add(a : OptconvexnewtonFrame, b : OptconvexnewtonFrame) -> OptconvexnewtonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_frame_copy(s : OptconvexnewtonFrame) -> OptconvexnewtonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_frame_fill(s : OptconvexnewtonFrame, v : Double) -> OptconvexnewtonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_frame_min(s : OptconvexnewtonFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_frame_max(s : OptconvexnewtonFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_frame_to_string(s : OptconvexnewtonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_table_make(size : Int) -> OptconvexnewtonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_table_len(s : OptconvexnewtonTable) -> Int { s.size }

pub fn opt_convex_newton_table_get(s : OptconvexnewtonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_table_set(s : OptconvexnewtonTable, i : Int, v : Double) -> OptconvexnewtonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_table_sum(s : OptconvexnewtonTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_table_mean(s : OptconvexnewtonTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_table_scale(s : OptconvexnewtonTable, f : Double) -> OptconvexnewtonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_table_add(a : OptconvexnewtonTable, b : OptconvexnewtonTable) -> OptconvexnewtonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_table_copy(s : OptconvexnewtonTable) -> OptconvexnewtonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_table_fill(s : OptconvexnewtonTable, v : Double) -> OptconvexnewtonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_table_min(s : OptconvexnewtonTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_table_max(s : OptconvexnewtonTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_table_to_string(s : OptconvexnewtonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_graphn_make(size : Int) -> OptconvexnewtonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_graphn_len(s : OptconvexnewtonGraphN) -> Int { s.size }

pub fn opt_convex_newton_graphn_get(s : OptconvexnewtonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_graphn_set(s : OptconvexnewtonGraphN, i : Int, v : Double) -> OptconvexnewtonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_graphn_sum(s : OptconvexnewtonGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_graphn_mean(s : OptconvexnewtonGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_graphn_scale(s : OptconvexnewtonGraphN, f : Double) -> OptconvexnewtonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_graphn_add(a : OptconvexnewtonGraphN, b : OptconvexnewtonGraphN) -> OptconvexnewtonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_graphn_copy(s : OptconvexnewtonGraphN) -> OptconvexnewtonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_graphn_fill(s : OptconvexnewtonGraphN, v : Double) -> OptconvexnewtonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_graphn_min(s : OptconvexnewtonGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_graphn_max(s : OptconvexnewtonGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_graphn_to_string(s : OptconvexnewtonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_node_make(size : Int) -> OptconvexnewtonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_node_len(s : OptconvexnewtonNode) -> Int { s.size }

pub fn opt_convex_newton_node_get(s : OptconvexnewtonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_node_set(s : OptconvexnewtonNode, i : Int, v : Double) -> OptconvexnewtonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_node_sum(s : OptconvexnewtonNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_node_mean(s : OptconvexnewtonNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_node_scale(s : OptconvexnewtonNode, f : Double) -> OptconvexnewtonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_node_add(a : OptconvexnewtonNode, b : OptconvexnewtonNode) -> OptconvexnewtonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_node_copy(s : OptconvexnewtonNode) -> OptconvexnewtonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_node_fill(s : OptconvexnewtonNode, v : Double) -> OptconvexnewtonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_node_min(s : OptconvexnewtonNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_node_max(s : OptconvexnewtonNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_node_to_string(s : OptconvexnewtonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_edge_make(size : Int) -> OptconvexnewtonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_edge_len(s : OptconvexnewtonEdge) -> Int { s.size }

pub fn opt_convex_newton_edge_get(s : OptconvexnewtonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_edge_set(s : OptconvexnewtonEdge, i : Int, v : Double) -> OptconvexnewtonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_edge_sum(s : OptconvexnewtonEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_edge_mean(s : OptconvexnewtonEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_edge_scale(s : OptconvexnewtonEdge, f : Double) -> OptconvexnewtonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_edge_add(a : OptconvexnewtonEdge, b : OptconvexnewtonEdge) -> OptconvexnewtonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_edge_copy(s : OptconvexnewtonEdge) -> OptconvexnewtonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_edge_fill(s : OptconvexnewtonEdge, v : Double) -> OptconvexnewtonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_edge_min(s : OptconvexnewtonEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_edge_max(s : OptconvexnewtonEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_edge_to_string(s : OptconvexnewtonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_path_make(size : Int) -> OptconvexnewtonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_path_len(s : OptconvexnewtonPath) -> Int { s.size }

pub fn opt_convex_newton_path_get(s : OptconvexnewtonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_path_set(s : OptconvexnewtonPath, i : Int, v : Double) -> OptconvexnewtonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_path_sum(s : OptconvexnewtonPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_path_mean(s : OptconvexnewtonPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_path_scale(s : OptconvexnewtonPath, f : Double) -> OptconvexnewtonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_path_add(a : OptconvexnewtonPath, b : OptconvexnewtonPath) -> OptconvexnewtonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_path_copy(s : OptconvexnewtonPath) -> OptconvexnewtonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_path_fill(s : OptconvexnewtonPath, v : Double) -> OptconvexnewtonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_path_min(s : OptconvexnewtonPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_path_max(s : OptconvexnewtonPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_path_to_string(s : OptconvexnewtonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_cluster_make(size : Int) -> OptconvexnewtonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_cluster_len(s : OptconvexnewtonCluster) -> Int { s.size }

pub fn opt_convex_newton_cluster_get(s : OptconvexnewtonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_cluster_set(s : OptconvexnewtonCluster, i : Int, v : Double) -> OptconvexnewtonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cluster_sum(s : OptconvexnewtonCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_cluster_mean(s : OptconvexnewtonCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_cluster_scale(s : OptconvexnewtonCluster, f : Double) -> OptconvexnewtonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cluster_add(a : OptconvexnewtonCluster, b : OptconvexnewtonCluster) -> OptconvexnewtonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_cluster_copy(s : OptconvexnewtonCluster) -> OptconvexnewtonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cluster_fill(s : OptconvexnewtonCluster, v : Double) -> OptconvexnewtonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cluster_min(s : OptconvexnewtonCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_cluster_max(s : OptconvexnewtonCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_cluster_to_string(s : OptconvexnewtonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_model_make(size : Int) -> OptconvexnewtonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_model_len(s : OptconvexnewtonModel) -> Int { s.size }

pub fn opt_convex_newton_model_get(s : OptconvexnewtonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_model_set(s : OptconvexnewtonModel, i : Int, v : Double) -> OptconvexnewtonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_model_sum(s : OptconvexnewtonModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_model_mean(s : OptconvexnewtonModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_model_scale(s : OptconvexnewtonModel, f : Double) -> OptconvexnewtonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_model_add(a : OptconvexnewtonModel, b : OptconvexnewtonModel) -> OptconvexnewtonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_model_copy(s : OptconvexnewtonModel) -> OptconvexnewtonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_model_fill(s : OptconvexnewtonModel, v : Double) -> OptconvexnewtonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_model_min(s : OptconvexnewtonModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_model_max(s : OptconvexnewtonModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_model_to_string(s : OptconvexnewtonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_layer_make(size : Int) -> OptconvexnewtonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_layer_len(s : OptconvexnewtonLayer) -> Int { s.size }

pub fn opt_convex_newton_layer_get(s : OptconvexnewtonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_layer_set(s : OptconvexnewtonLayer, i : Int, v : Double) -> OptconvexnewtonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_layer_sum(s : OptconvexnewtonLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_layer_mean(s : OptconvexnewtonLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_layer_scale(s : OptconvexnewtonLayer, f : Double) -> OptconvexnewtonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_layer_add(a : OptconvexnewtonLayer, b : OptconvexnewtonLayer) -> OptconvexnewtonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_layer_copy(s : OptconvexnewtonLayer) -> OptconvexnewtonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_layer_fill(s : OptconvexnewtonLayer, v : Double) -> OptconvexnewtonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_layer_min(s : OptconvexnewtonLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_layer_max(s : OptconvexnewtonLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_layer_to_string(s : OptconvexnewtonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_buffer_make(size : Int) -> OptconvexnewtonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_buffer_len(s : OptconvexnewtonBuffer) -> Int { s.size }

pub fn opt_convex_newton_buffer_get(s : OptconvexnewtonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_buffer_set(s : OptconvexnewtonBuffer, i : Int, v : Double) -> OptconvexnewtonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_buffer_sum(s : OptconvexnewtonBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_buffer_mean(s : OptconvexnewtonBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_buffer_scale(s : OptconvexnewtonBuffer, f : Double) -> OptconvexnewtonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_buffer_add(a : OptconvexnewtonBuffer, b : OptconvexnewtonBuffer) -> OptconvexnewtonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_buffer_copy(s : OptconvexnewtonBuffer) -> OptconvexnewtonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_buffer_fill(s : OptconvexnewtonBuffer, v : Double) -> OptconvexnewtonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_buffer_min(s : OptconvexnewtonBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_buffer_max(s : OptconvexnewtonBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_buffer_to_string(s : OptconvexnewtonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_cursor_make(size : Int) -> OptconvexnewtonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_cursor_len(s : OptconvexnewtonCursor) -> Int { s.size }

pub fn opt_convex_newton_cursor_get(s : OptconvexnewtonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_cursor_set(s : OptconvexnewtonCursor, i : Int, v : Double) -> OptconvexnewtonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cursor_sum(s : OptconvexnewtonCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_cursor_mean(s : OptconvexnewtonCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_cursor_scale(s : OptconvexnewtonCursor, f : Double) -> OptconvexnewtonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cursor_add(a : OptconvexnewtonCursor, b : OptconvexnewtonCursor) -> OptconvexnewtonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_cursor_copy(s : OptconvexnewtonCursor) -> OptconvexnewtonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cursor_fill(s : OptconvexnewtonCursor, v : Double) -> OptconvexnewtonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_cursor_min(s : OptconvexnewtonCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_cursor_max(s : OptconvexnewtonCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_cursor_to_string(s : OptconvexnewtonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_view_make(size : Int) -> OptconvexnewtonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_view_len(s : OptconvexnewtonView) -> Int { s.size }

pub fn opt_convex_newton_view_get(s : OptconvexnewtonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_view_set(s : OptconvexnewtonView, i : Int, v : Double) -> OptconvexnewtonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_view_sum(s : OptconvexnewtonView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_view_mean(s : OptconvexnewtonView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_view_scale(s : OptconvexnewtonView, f : Double) -> OptconvexnewtonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_view_add(a : OptconvexnewtonView, b : OptconvexnewtonView) -> OptconvexnewtonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_view_copy(s : OptconvexnewtonView) -> OptconvexnewtonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_view_fill(s : OptconvexnewtonView, v : Double) -> OptconvexnewtonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_view_min(s : OptconvexnewtonView) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_view_max(s : OptconvexnewtonView) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_view_to_string(s : OptconvexnewtonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_range_make(size : Int) -> OptconvexnewtonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_range_len(s : OptconvexnewtonRange) -> Int { s.size }

pub fn opt_convex_newton_range_get(s : OptconvexnewtonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_range_set(s : OptconvexnewtonRange, i : Int, v : Double) -> OptconvexnewtonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_range_sum(s : OptconvexnewtonRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_range_mean(s : OptconvexnewtonRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_range_scale(s : OptconvexnewtonRange, f : Double) -> OptconvexnewtonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_range_add(a : OptconvexnewtonRange, b : OptconvexnewtonRange) -> OptconvexnewtonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_range_copy(s : OptconvexnewtonRange) -> OptconvexnewtonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_range_fill(s : OptconvexnewtonRange, v : Double) -> OptconvexnewtonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_range_min(s : OptconvexnewtonRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_range_max(s : OptconvexnewtonRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_range_to_string(s : OptconvexnewtonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_slice_make(size : Int) -> OptconvexnewtonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_slice_len(s : OptconvexnewtonSlice) -> Int { s.size }

pub fn opt_convex_newton_slice_get(s : OptconvexnewtonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_slice_set(s : OptconvexnewtonSlice, i : Int, v : Double) -> OptconvexnewtonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_slice_sum(s : OptconvexnewtonSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_newton_slice_mean(s : OptconvexnewtonSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_newton_slice_scale(s : OptconvexnewtonSlice, f : Double) -> OptconvexnewtonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_slice_add(a : OptconvexnewtonSlice, b : OptconvexnewtonSlice) -> OptconvexnewtonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_newton_slice_copy(s : OptconvexnewtonSlice) -> OptconvexnewtonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_slice_fill(s : OptconvexnewtonSlice, v : Double) -> OptconvexnewtonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_newton_slice_min(s : OptconvexnewtonSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_newton_slice_max(s : OptconvexnewtonSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_newton_slice_to_string(s : OptconvexnewtonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

