///===
/// extcore/opt_convex_quasi_newton

pub(all) struct OptconvexquasinewtonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_quasi_newton_make_point(x : Double, y : Double) -> OptconvexquasinewtonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_quasi_newton_make_point3(x : Double, y : Double, z : Double) -> OptconvexquasinewtonPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexquasinewtonPoint::x(self : OptconvexquasinewtonPoint) -> Double { self.x }

pub fn OptconvexquasinewtonPoint::y(self : OptconvexquasinewtonPoint) -> Double { self.y }

pub fn OptconvexquasinewtonPoint::z(self : OptconvexquasinewtonPoint) -> Double { self.z }

pub fn OptconvexquasinewtonPoint::label(self : OptconvexquasinewtonPoint) -> Int { self.label }

pub fn OptconvexquasinewtonPoint::dist(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexquasinewtonPoint::add(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexquasinewtonPoint::sub(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexquasinewtonPoint::scale(self : OptconvexquasinewtonPoint, s : Double) -> OptconvexquasinewtonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexquasinewtonPoint::dot(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexquasinewtonPoint::cross(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexquasinewtonPoint::norm(self : OptconvexquasinewtonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexquasinewtonPoint::normalize(self : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexquasinewtonPoint::negate(self : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexquasinewtonPoint::mid(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexquasinewtonPoint::lerp(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint, t : Double) -> OptconvexquasinewtonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexquasinewtonPoint::to_string(self : OptconvexquasinewtonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_quasi_newton_make_series(vals : Array[Double], name : String) -> OptconvexquasinewtonSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexquasinewtonSeries::len(self : OptconvexquasinewtonSeries) -> Int { self.vals.length() }

pub fn OptconvexquasinewtonSeries::sum(self : OptconvexquasinewtonSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexquasinewtonSeries::mean(self : OptconvexquasinewtonSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexquasinewtonSeries::min(self : OptconvexquasinewtonSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexquasinewtonSeries::max(self : OptconvexquasinewtonSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexquasinewtonSeries::range(self : OptconvexquasinewtonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexquasinewtonSeries::variance(self : OptconvexquasinewtonSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexquasinewtonSeries::std(self : OptconvexquasinewtonSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexquasinewtonSeries::median(self : OptconvexquasinewtonSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexquasinewtonSeries::scale(self : OptconvexquasinewtonSeries, f : Double) -> OptconvexquasinewtonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::add(self : OptconvexquasinewtonSeries, other : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::sub(self : OptconvexquasinewtonSeries, other : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::normalize(self : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexquasinewtonSeries::cumsum(self : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::to_string(self : OptconvexquasinewtonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexquasinewtonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_quasi_newton_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexquasinewtonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_quasi_newton_matrix_identity(n : Int) -> OptconvexquasinewtonMatrix {
  let m = opt_convex_quasi_newton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexquasinewtonMatrix::get(self : OptconvexquasinewtonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexquasinewtonMatrix::transpose(self : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  let result = opt_convex_quasi_newton_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexquasinewtonMatrix::add(self : OptconvexquasinewtonMatrix, other : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_quasi_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexquasinewtonMatrix::scale(self : OptconvexquasinewtonMatrix, s : Double) -> OptconvexquasinewtonMatrix {
  let result = opt_convex_quasi_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexquasinewtonMatrix::multiply(self : OptconvexquasinewtonMatrix, other : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  if self.cols != other.rows { return opt_convex_quasi_newton_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_quasi_newton_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexquasinewtonMatrix::trace(self : OptconvexquasinewtonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexquasinewtonMatrix::det(self : OptconvexquasinewtonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexquasinewtonMatrix::norm(self : OptconvexquasinewtonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexquasinewtonMatrix::to_string(self : OptconvexquasinewtonMatrix) -> String {
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

pub(all) struct OptconvexquasinewtonVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_quasi_newton_make_vector(comps : Array[Double]) -> OptconvexquasinewtonVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_quasi_newton_vector_zero(dim : Int) -> OptconvexquasinewtonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexquasinewtonVector::add(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexquasinewtonVector::sub(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexquasinewtonVector::scale(self : OptconvexquasinewtonVector, s : Double) -> OptconvexquasinewtonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexquasinewtonVector::dot(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexquasinewtonVector::norm(self : OptconvexquasinewtonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexquasinewtonVector::normalize(self : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexquasinewtonVector::dist(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexquasinewtonVector::to_string(self : OptconvexquasinewtonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_quasi_newton_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_quasi_newton_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_quasi_newton_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_quasi_newton_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_quasi_newton_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_quasi_newton_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_quasi_newton_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_quasi_newton_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_quasi_newton_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_quasi_newton_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_quasi_newton_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_quasi_newton_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_quasi_newton_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_quasi_newton_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_quasi_newton_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_quasi_newton_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_quasi_newton_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_quasi_newton_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_quasi_newton_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_quasi_newton_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_quasi_newton_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_quasi_newton_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_quasi_newton_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_quasi_newton_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_quasi_newton_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_quasi_newton_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_quasi_newton_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_quasi_newton_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_quasi_newton_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexquasinewtonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_frame_make(size : Int) -> OptconvexquasinewtonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_frame_len(s : OptconvexquasinewtonFrame) -> Int { s.size }

pub fn opt_convex_quasi_newton_frame_get(s : OptconvexquasinewtonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_frame_set(s : OptconvexquasinewtonFrame, i : Int, v : Double) -> OptconvexquasinewtonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_frame_sum(s : OptconvexquasinewtonFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_frame_mean(s : OptconvexquasinewtonFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_frame_scale(s : OptconvexquasinewtonFrame, f : Double) -> OptconvexquasinewtonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_frame_add(a : OptconvexquasinewtonFrame, b : OptconvexquasinewtonFrame) -> OptconvexquasinewtonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_frame_copy(s : OptconvexquasinewtonFrame) -> OptconvexquasinewtonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_frame_fill(s : OptconvexquasinewtonFrame, v : Double) -> OptconvexquasinewtonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_frame_min(s : OptconvexquasinewtonFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_frame_max(s : OptconvexquasinewtonFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_frame_to_string(s : OptconvexquasinewtonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_table_make(size : Int) -> OptconvexquasinewtonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_table_len(s : OptconvexquasinewtonTable) -> Int { s.size }

pub fn opt_convex_quasi_newton_table_get(s : OptconvexquasinewtonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_table_set(s : OptconvexquasinewtonTable, i : Int, v : Double) -> OptconvexquasinewtonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_table_sum(s : OptconvexquasinewtonTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_table_mean(s : OptconvexquasinewtonTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_table_scale(s : OptconvexquasinewtonTable, f : Double) -> OptconvexquasinewtonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_table_add(a : OptconvexquasinewtonTable, b : OptconvexquasinewtonTable) -> OptconvexquasinewtonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_table_copy(s : OptconvexquasinewtonTable) -> OptconvexquasinewtonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_table_fill(s : OptconvexquasinewtonTable, v : Double) -> OptconvexquasinewtonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_table_min(s : OptconvexquasinewtonTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_table_max(s : OptconvexquasinewtonTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_table_to_string(s : OptconvexquasinewtonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_graphn_make(size : Int) -> OptconvexquasinewtonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_graphn_len(s : OptconvexquasinewtonGraphN) -> Int { s.size }

pub fn opt_convex_quasi_newton_graphn_get(s : OptconvexquasinewtonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_graphn_set(s : OptconvexquasinewtonGraphN, i : Int, v : Double) -> OptconvexquasinewtonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_graphn_sum(s : OptconvexquasinewtonGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_graphn_mean(s : OptconvexquasinewtonGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_graphn_scale(s : OptconvexquasinewtonGraphN, f : Double) -> OptconvexquasinewtonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_graphn_add(a : OptconvexquasinewtonGraphN, b : OptconvexquasinewtonGraphN) -> OptconvexquasinewtonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_graphn_copy(s : OptconvexquasinewtonGraphN) -> OptconvexquasinewtonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_graphn_fill(s : OptconvexquasinewtonGraphN, v : Double) -> OptconvexquasinewtonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_graphn_min(s : OptconvexquasinewtonGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_graphn_max(s : OptconvexquasinewtonGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_graphn_to_string(s : OptconvexquasinewtonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_node_make(size : Int) -> OptconvexquasinewtonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_node_len(s : OptconvexquasinewtonNode) -> Int { s.size }

pub fn opt_convex_quasi_newton_node_get(s : OptconvexquasinewtonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_node_set(s : OptconvexquasinewtonNode, i : Int, v : Double) -> OptconvexquasinewtonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_node_sum(s : OptconvexquasinewtonNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_node_mean(s : OptconvexquasinewtonNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_node_scale(s : OptconvexquasinewtonNode, f : Double) -> OptconvexquasinewtonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_node_add(a : OptconvexquasinewtonNode, b : OptconvexquasinewtonNode) -> OptconvexquasinewtonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_node_copy(s : OptconvexquasinewtonNode) -> OptconvexquasinewtonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_node_fill(s : OptconvexquasinewtonNode, v : Double) -> OptconvexquasinewtonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_node_min(s : OptconvexquasinewtonNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_node_max(s : OptconvexquasinewtonNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_node_to_string(s : OptconvexquasinewtonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_edge_make(size : Int) -> OptconvexquasinewtonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_edge_len(s : OptconvexquasinewtonEdge) -> Int { s.size }

pub fn opt_convex_quasi_newton_edge_get(s : OptconvexquasinewtonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_edge_set(s : OptconvexquasinewtonEdge, i : Int, v : Double) -> OptconvexquasinewtonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_edge_sum(s : OptconvexquasinewtonEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_edge_mean(s : OptconvexquasinewtonEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_edge_scale(s : OptconvexquasinewtonEdge, f : Double) -> OptconvexquasinewtonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_edge_add(a : OptconvexquasinewtonEdge, b : OptconvexquasinewtonEdge) -> OptconvexquasinewtonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_edge_copy(s : OptconvexquasinewtonEdge) -> OptconvexquasinewtonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_edge_fill(s : OptconvexquasinewtonEdge, v : Double) -> OptconvexquasinewtonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_edge_min(s : OptconvexquasinewtonEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_edge_max(s : OptconvexquasinewtonEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_edge_to_string(s : OptconvexquasinewtonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_path_make(size : Int) -> OptconvexquasinewtonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_path_len(s : OptconvexquasinewtonPath) -> Int { s.size }

pub fn opt_convex_quasi_newton_path_get(s : OptconvexquasinewtonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_path_set(s : OptconvexquasinewtonPath, i : Int, v : Double) -> OptconvexquasinewtonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_path_sum(s : OptconvexquasinewtonPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_path_mean(s : OptconvexquasinewtonPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_path_scale(s : OptconvexquasinewtonPath, f : Double) -> OptconvexquasinewtonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_path_add(a : OptconvexquasinewtonPath, b : OptconvexquasinewtonPath) -> OptconvexquasinewtonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_path_copy(s : OptconvexquasinewtonPath) -> OptconvexquasinewtonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_path_fill(s : OptconvexquasinewtonPath, v : Double) -> OptconvexquasinewtonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_path_min(s : OptconvexquasinewtonPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_path_max(s : OptconvexquasinewtonPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_path_to_string(s : OptconvexquasinewtonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_cluster_make(size : Int) -> OptconvexquasinewtonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_cluster_len(s : OptconvexquasinewtonCluster) -> Int { s.size }

pub fn opt_convex_quasi_newton_cluster_get(s : OptconvexquasinewtonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_cluster_set(s : OptconvexquasinewtonCluster, i : Int, v : Double) -> OptconvexquasinewtonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cluster_sum(s : OptconvexquasinewtonCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_cluster_mean(s : OptconvexquasinewtonCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_cluster_scale(s : OptconvexquasinewtonCluster, f : Double) -> OptconvexquasinewtonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cluster_add(a : OptconvexquasinewtonCluster, b : OptconvexquasinewtonCluster) -> OptconvexquasinewtonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_cluster_copy(s : OptconvexquasinewtonCluster) -> OptconvexquasinewtonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cluster_fill(s : OptconvexquasinewtonCluster, v : Double) -> OptconvexquasinewtonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cluster_min(s : OptconvexquasinewtonCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_cluster_max(s : OptconvexquasinewtonCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_cluster_to_string(s : OptconvexquasinewtonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_model_make(size : Int) -> OptconvexquasinewtonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_model_len(s : OptconvexquasinewtonModel) -> Int { s.size }

pub fn opt_convex_quasi_newton_model_get(s : OptconvexquasinewtonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_model_set(s : OptconvexquasinewtonModel, i : Int, v : Double) -> OptconvexquasinewtonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_model_sum(s : OptconvexquasinewtonModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_model_mean(s : OptconvexquasinewtonModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_model_scale(s : OptconvexquasinewtonModel, f : Double) -> OptconvexquasinewtonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_model_add(a : OptconvexquasinewtonModel, b : OptconvexquasinewtonModel) -> OptconvexquasinewtonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_model_copy(s : OptconvexquasinewtonModel) -> OptconvexquasinewtonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_model_fill(s : OptconvexquasinewtonModel, v : Double) -> OptconvexquasinewtonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_model_min(s : OptconvexquasinewtonModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_model_max(s : OptconvexquasinewtonModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_model_to_string(s : OptconvexquasinewtonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_layer_make(size : Int) -> OptconvexquasinewtonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_layer_len(s : OptconvexquasinewtonLayer) -> Int { s.size }

pub fn opt_convex_quasi_newton_layer_get(s : OptconvexquasinewtonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_layer_set(s : OptconvexquasinewtonLayer, i : Int, v : Double) -> OptconvexquasinewtonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_layer_sum(s : OptconvexquasinewtonLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_layer_mean(s : OptconvexquasinewtonLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_layer_scale(s : OptconvexquasinewtonLayer, f : Double) -> OptconvexquasinewtonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_layer_add(a : OptconvexquasinewtonLayer, b : OptconvexquasinewtonLayer) -> OptconvexquasinewtonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_layer_copy(s : OptconvexquasinewtonLayer) -> OptconvexquasinewtonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_layer_fill(s : OptconvexquasinewtonLayer, v : Double) -> OptconvexquasinewtonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_layer_min(s : OptconvexquasinewtonLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_layer_max(s : OptconvexquasinewtonLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_layer_to_string(s : OptconvexquasinewtonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_buffer_make(size : Int) -> OptconvexquasinewtonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_buffer_len(s : OptconvexquasinewtonBuffer) -> Int { s.size }

pub fn opt_convex_quasi_newton_buffer_get(s : OptconvexquasinewtonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_buffer_set(s : OptconvexquasinewtonBuffer, i : Int, v : Double) -> OptconvexquasinewtonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_buffer_sum(s : OptconvexquasinewtonBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_buffer_mean(s : OptconvexquasinewtonBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_buffer_scale(s : OptconvexquasinewtonBuffer, f : Double) -> OptconvexquasinewtonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_buffer_add(a : OptconvexquasinewtonBuffer, b : OptconvexquasinewtonBuffer) -> OptconvexquasinewtonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_buffer_copy(s : OptconvexquasinewtonBuffer) -> OptconvexquasinewtonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_buffer_fill(s : OptconvexquasinewtonBuffer, v : Double) -> OptconvexquasinewtonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_buffer_min(s : OptconvexquasinewtonBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_buffer_max(s : OptconvexquasinewtonBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_buffer_to_string(s : OptconvexquasinewtonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_cursor_make(size : Int) -> OptconvexquasinewtonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_cursor_len(s : OptconvexquasinewtonCursor) -> Int { s.size }

pub fn opt_convex_quasi_newton_cursor_get(s : OptconvexquasinewtonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_cursor_set(s : OptconvexquasinewtonCursor, i : Int, v : Double) -> OptconvexquasinewtonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cursor_sum(s : OptconvexquasinewtonCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_cursor_mean(s : OptconvexquasinewtonCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_cursor_scale(s : OptconvexquasinewtonCursor, f : Double) -> OptconvexquasinewtonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cursor_add(a : OptconvexquasinewtonCursor, b : OptconvexquasinewtonCursor) -> OptconvexquasinewtonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_cursor_copy(s : OptconvexquasinewtonCursor) -> OptconvexquasinewtonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cursor_fill(s : OptconvexquasinewtonCursor, v : Double) -> OptconvexquasinewtonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_cursor_min(s : OptconvexquasinewtonCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_cursor_max(s : OptconvexquasinewtonCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_cursor_to_string(s : OptconvexquasinewtonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_view_make(size : Int) -> OptconvexquasinewtonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_view_len(s : OptconvexquasinewtonView) -> Int { s.size }

pub fn opt_convex_quasi_newton_view_get(s : OptconvexquasinewtonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_view_set(s : OptconvexquasinewtonView, i : Int, v : Double) -> OptconvexquasinewtonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_view_sum(s : OptconvexquasinewtonView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_view_mean(s : OptconvexquasinewtonView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_view_scale(s : OptconvexquasinewtonView, f : Double) -> OptconvexquasinewtonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_view_add(a : OptconvexquasinewtonView, b : OptconvexquasinewtonView) -> OptconvexquasinewtonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_view_copy(s : OptconvexquasinewtonView) -> OptconvexquasinewtonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_view_fill(s : OptconvexquasinewtonView, v : Double) -> OptconvexquasinewtonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_view_min(s : OptconvexquasinewtonView) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_view_max(s : OptconvexquasinewtonView) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_view_to_string(s : OptconvexquasinewtonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_range_make(size : Int) -> OptconvexquasinewtonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_range_len(s : OptconvexquasinewtonRange) -> Int { s.size }

pub fn opt_convex_quasi_newton_range_get(s : OptconvexquasinewtonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_range_set(s : OptconvexquasinewtonRange, i : Int, v : Double) -> OptconvexquasinewtonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_range_sum(s : OptconvexquasinewtonRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_range_mean(s : OptconvexquasinewtonRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_range_scale(s : OptconvexquasinewtonRange, f : Double) -> OptconvexquasinewtonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_range_add(a : OptconvexquasinewtonRange, b : OptconvexquasinewtonRange) -> OptconvexquasinewtonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_range_copy(s : OptconvexquasinewtonRange) -> OptconvexquasinewtonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_range_fill(s : OptconvexquasinewtonRange, v : Double) -> OptconvexquasinewtonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_range_min(s : OptconvexquasinewtonRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_range_max(s : OptconvexquasinewtonRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_range_to_string(s : OptconvexquasinewtonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_slice_make(size : Int) -> OptconvexquasinewtonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_slice_len(s : OptconvexquasinewtonSlice) -> Int { s.size }

pub fn opt_convex_quasi_newton_slice_get(s : OptconvexquasinewtonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_slice_set(s : OptconvexquasinewtonSlice, i : Int, v : Double) -> OptconvexquasinewtonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_slice_sum(s : OptconvexquasinewtonSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_quasi_newton_slice_mean(s : OptconvexquasinewtonSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_quasi_newton_slice_scale(s : OptconvexquasinewtonSlice, f : Double) -> OptconvexquasinewtonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_slice_add(a : OptconvexquasinewtonSlice, b : OptconvexquasinewtonSlice) -> OptconvexquasinewtonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_quasi_newton_slice_copy(s : OptconvexquasinewtonSlice) -> OptconvexquasinewtonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_slice_fill(s : OptconvexquasinewtonSlice, v : Double) -> OptconvexquasinewtonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_quasi_newton_slice_min(s : OptconvexquasinewtonSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_quasi_newton_slice_max(s : OptconvexquasinewtonSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_quasi_newton_slice_to_string(s : OptconvexquasinewtonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

