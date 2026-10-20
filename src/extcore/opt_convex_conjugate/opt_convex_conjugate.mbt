///===
/// extcore/opt_convex_conjugate

pub(all) struct OptconvexconjugatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_conjugate_make_point(x : Double, y : Double) -> OptconvexconjugatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_conjugate_make_point3(x : Double, y : Double, z : Double) -> OptconvexconjugatePoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexconjugatePoint::x(self : OptconvexconjugatePoint) -> Double { self.x }

pub fn OptconvexconjugatePoint::y(self : OptconvexconjugatePoint) -> Double { self.y }

pub fn OptconvexconjugatePoint::z(self : OptconvexconjugatePoint) -> Double { self.z }

pub fn OptconvexconjugatePoint::label(self : OptconvexconjugatePoint) -> Int { self.label }

pub fn OptconvexconjugatePoint::dist(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexconjugatePoint::add(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexconjugatePoint::sub(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexconjugatePoint::scale(self : OptconvexconjugatePoint, s : Double) -> OptconvexconjugatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexconjugatePoint::dot(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexconjugatePoint::cross(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexconjugatePoint::norm(self : OptconvexconjugatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexconjugatePoint::normalize(self : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexconjugatePoint::negate(self : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexconjugatePoint::mid(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexconjugatePoint::lerp(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint, t : Double) -> OptconvexconjugatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexconjugatePoint::to_string(self : OptconvexconjugatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexconjugateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_conjugate_make_series(vals : Array[Double], name : String) -> OptconvexconjugateSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexconjugateSeries::len(self : OptconvexconjugateSeries) -> Int { self.vals.length() }

pub fn OptconvexconjugateSeries::sum(self : OptconvexconjugateSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexconjugateSeries::mean(self : OptconvexconjugateSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexconjugateSeries::min(self : OptconvexconjugateSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexconjugateSeries::max(self : OptconvexconjugateSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexconjugateSeries::range(self : OptconvexconjugateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexconjugateSeries::variance(self : OptconvexconjugateSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexconjugateSeries::std(self : OptconvexconjugateSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexconjugateSeries::median(self : OptconvexconjugateSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexconjugateSeries::scale(self : OptconvexconjugateSeries, f : Double) -> OptconvexconjugateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexconjugateSeries::add(self : OptconvexconjugateSeries, other : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexconjugateSeries::sub(self : OptconvexconjugateSeries, other : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexconjugateSeries::normalize(self : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexconjugateSeries::cumsum(self : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexconjugateSeries::to_string(self : OptconvexconjugateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexconjugateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_conjugate_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexconjugateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_conjugate_matrix_identity(n : Int) -> OptconvexconjugateMatrix {
  let m = opt_convex_conjugate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexconjugateMatrix::get(self : OptconvexconjugateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexconjugateMatrix::transpose(self : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  let result = opt_convex_conjugate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexconjugateMatrix::add(self : OptconvexconjugateMatrix, other : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_conjugate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexconjugateMatrix::scale(self : OptconvexconjugateMatrix, s : Double) -> OptconvexconjugateMatrix {
  let result = opt_convex_conjugate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexconjugateMatrix::multiply(self : OptconvexconjugateMatrix, other : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  if self.cols != other.rows { return opt_convex_conjugate_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_conjugate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexconjugateMatrix::trace(self : OptconvexconjugateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexconjugateMatrix::det(self : OptconvexconjugateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexconjugateMatrix::norm(self : OptconvexconjugateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexconjugateMatrix::to_string(self : OptconvexconjugateMatrix) -> String {
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

pub(all) struct OptconvexconjugateVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_conjugate_make_vector(comps : Array[Double]) -> OptconvexconjugateVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_conjugate_vector_zero(dim : Int) -> OptconvexconjugateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexconjugateVector::add(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexconjugateVector::sub(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexconjugateVector::scale(self : OptconvexconjugateVector, s : Double) -> OptconvexconjugateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexconjugateVector::dot(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexconjugateVector::norm(self : OptconvexconjugateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexconjugateVector::normalize(self : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexconjugateVector::dist(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexconjugateVector::to_string(self : OptconvexconjugateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_conjugate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_conjugate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_conjugate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_conjugate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_conjugate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_conjugate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_conjugate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_conjugate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_conjugate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_conjugate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_conjugate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_conjugate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_conjugate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_conjugate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_conjugate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_conjugate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_conjugate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_conjugate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_conjugate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_conjugate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_conjugate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_conjugate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_conjugate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_conjugate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_conjugate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_conjugate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_conjugate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_conjugate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_conjugate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexconjugateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_frame_make(size : Int) -> OptconvexconjugateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_frame_len(s : OptconvexconjugateFrame) -> Int { s.size }

pub fn opt_convex_conjugate_frame_get(s : OptconvexconjugateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_frame_set(s : OptconvexconjugateFrame, i : Int, v : Double) -> OptconvexconjugateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_frame_sum(s : OptconvexconjugateFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_frame_mean(s : OptconvexconjugateFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_frame_scale(s : OptconvexconjugateFrame, f : Double) -> OptconvexconjugateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_frame_add(a : OptconvexconjugateFrame, b : OptconvexconjugateFrame) -> OptconvexconjugateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_frame_copy(s : OptconvexconjugateFrame) -> OptconvexconjugateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_frame_fill(s : OptconvexconjugateFrame, v : Double) -> OptconvexconjugateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_frame_min(s : OptconvexconjugateFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_frame_max(s : OptconvexconjugateFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_frame_to_string(s : OptconvexconjugateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_table_make(size : Int) -> OptconvexconjugateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_table_len(s : OptconvexconjugateTable) -> Int { s.size }

pub fn opt_convex_conjugate_table_get(s : OptconvexconjugateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_table_set(s : OptconvexconjugateTable, i : Int, v : Double) -> OptconvexconjugateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_table_sum(s : OptconvexconjugateTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_table_mean(s : OptconvexconjugateTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_table_scale(s : OptconvexconjugateTable, f : Double) -> OptconvexconjugateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_table_add(a : OptconvexconjugateTable, b : OptconvexconjugateTable) -> OptconvexconjugateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_table_copy(s : OptconvexconjugateTable) -> OptconvexconjugateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_table_fill(s : OptconvexconjugateTable, v : Double) -> OptconvexconjugateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_table_min(s : OptconvexconjugateTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_table_max(s : OptconvexconjugateTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_table_to_string(s : OptconvexconjugateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_graphn_make(size : Int) -> OptconvexconjugateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_graphn_len(s : OptconvexconjugateGraphN) -> Int { s.size }

pub fn opt_convex_conjugate_graphn_get(s : OptconvexconjugateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_graphn_set(s : OptconvexconjugateGraphN, i : Int, v : Double) -> OptconvexconjugateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_graphn_sum(s : OptconvexconjugateGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_graphn_mean(s : OptconvexconjugateGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_graphn_scale(s : OptconvexconjugateGraphN, f : Double) -> OptconvexconjugateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_graphn_add(a : OptconvexconjugateGraphN, b : OptconvexconjugateGraphN) -> OptconvexconjugateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_graphn_copy(s : OptconvexconjugateGraphN) -> OptconvexconjugateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_graphn_fill(s : OptconvexconjugateGraphN, v : Double) -> OptconvexconjugateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_graphn_min(s : OptconvexconjugateGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_graphn_max(s : OptconvexconjugateGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_graphn_to_string(s : OptconvexconjugateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_node_make(size : Int) -> OptconvexconjugateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_node_len(s : OptconvexconjugateNode) -> Int { s.size }

pub fn opt_convex_conjugate_node_get(s : OptconvexconjugateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_node_set(s : OptconvexconjugateNode, i : Int, v : Double) -> OptconvexconjugateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_node_sum(s : OptconvexconjugateNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_node_mean(s : OptconvexconjugateNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_node_scale(s : OptconvexconjugateNode, f : Double) -> OptconvexconjugateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_node_add(a : OptconvexconjugateNode, b : OptconvexconjugateNode) -> OptconvexconjugateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_node_copy(s : OptconvexconjugateNode) -> OptconvexconjugateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_node_fill(s : OptconvexconjugateNode, v : Double) -> OptconvexconjugateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_node_min(s : OptconvexconjugateNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_node_max(s : OptconvexconjugateNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_node_to_string(s : OptconvexconjugateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_edge_make(size : Int) -> OptconvexconjugateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_edge_len(s : OptconvexconjugateEdge) -> Int { s.size }

pub fn opt_convex_conjugate_edge_get(s : OptconvexconjugateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_edge_set(s : OptconvexconjugateEdge, i : Int, v : Double) -> OptconvexconjugateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_edge_sum(s : OptconvexconjugateEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_edge_mean(s : OptconvexconjugateEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_edge_scale(s : OptconvexconjugateEdge, f : Double) -> OptconvexconjugateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_edge_add(a : OptconvexconjugateEdge, b : OptconvexconjugateEdge) -> OptconvexconjugateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_edge_copy(s : OptconvexconjugateEdge) -> OptconvexconjugateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_edge_fill(s : OptconvexconjugateEdge, v : Double) -> OptconvexconjugateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_edge_min(s : OptconvexconjugateEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_edge_max(s : OptconvexconjugateEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_edge_to_string(s : OptconvexconjugateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_path_make(size : Int) -> OptconvexconjugatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_path_len(s : OptconvexconjugatePath) -> Int { s.size }

pub fn opt_convex_conjugate_path_get(s : OptconvexconjugatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_path_set(s : OptconvexconjugatePath, i : Int, v : Double) -> OptconvexconjugatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_path_sum(s : OptconvexconjugatePath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_path_mean(s : OptconvexconjugatePath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_path_scale(s : OptconvexconjugatePath, f : Double) -> OptconvexconjugatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_path_add(a : OptconvexconjugatePath, b : OptconvexconjugatePath) -> OptconvexconjugatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_path_copy(s : OptconvexconjugatePath) -> OptconvexconjugatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_path_fill(s : OptconvexconjugatePath, v : Double) -> OptconvexconjugatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_path_min(s : OptconvexconjugatePath) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_path_max(s : OptconvexconjugatePath) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_path_to_string(s : OptconvexconjugatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_cluster_make(size : Int) -> OptconvexconjugateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_cluster_len(s : OptconvexconjugateCluster) -> Int { s.size }

pub fn opt_convex_conjugate_cluster_get(s : OptconvexconjugateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_cluster_set(s : OptconvexconjugateCluster, i : Int, v : Double) -> OptconvexconjugateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cluster_sum(s : OptconvexconjugateCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_cluster_mean(s : OptconvexconjugateCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_cluster_scale(s : OptconvexconjugateCluster, f : Double) -> OptconvexconjugateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cluster_add(a : OptconvexconjugateCluster, b : OptconvexconjugateCluster) -> OptconvexconjugateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_cluster_copy(s : OptconvexconjugateCluster) -> OptconvexconjugateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cluster_fill(s : OptconvexconjugateCluster, v : Double) -> OptconvexconjugateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cluster_min(s : OptconvexconjugateCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_cluster_max(s : OptconvexconjugateCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_cluster_to_string(s : OptconvexconjugateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_model_make(size : Int) -> OptconvexconjugateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_model_len(s : OptconvexconjugateModel) -> Int { s.size }

pub fn opt_convex_conjugate_model_get(s : OptconvexconjugateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_model_set(s : OptconvexconjugateModel, i : Int, v : Double) -> OptconvexconjugateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_model_sum(s : OptconvexconjugateModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_model_mean(s : OptconvexconjugateModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_model_scale(s : OptconvexconjugateModel, f : Double) -> OptconvexconjugateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_model_add(a : OptconvexconjugateModel, b : OptconvexconjugateModel) -> OptconvexconjugateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_model_copy(s : OptconvexconjugateModel) -> OptconvexconjugateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_model_fill(s : OptconvexconjugateModel, v : Double) -> OptconvexconjugateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_model_min(s : OptconvexconjugateModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_model_max(s : OptconvexconjugateModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_model_to_string(s : OptconvexconjugateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_layer_make(size : Int) -> OptconvexconjugateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_layer_len(s : OptconvexconjugateLayer) -> Int { s.size }

pub fn opt_convex_conjugate_layer_get(s : OptconvexconjugateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_layer_set(s : OptconvexconjugateLayer, i : Int, v : Double) -> OptconvexconjugateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_layer_sum(s : OptconvexconjugateLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_layer_mean(s : OptconvexconjugateLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_layer_scale(s : OptconvexconjugateLayer, f : Double) -> OptconvexconjugateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_layer_add(a : OptconvexconjugateLayer, b : OptconvexconjugateLayer) -> OptconvexconjugateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_layer_copy(s : OptconvexconjugateLayer) -> OptconvexconjugateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_layer_fill(s : OptconvexconjugateLayer, v : Double) -> OptconvexconjugateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_layer_min(s : OptconvexconjugateLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_layer_max(s : OptconvexconjugateLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_layer_to_string(s : OptconvexconjugateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_buffer_make(size : Int) -> OptconvexconjugateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_buffer_len(s : OptconvexconjugateBuffer) -> Int { s.size }

pub fn opt_convex_conjugate_buffer_get(s : OptconvexconjugateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_buffer_set(s : OptconvexconjugateBuffer, i : Int, v : Double) -> OptconvexconjugateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_buffer_sum(s : OptconvexconjugateBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_buffer_mean(s : OptconvexconjugateBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_buffer_scale(s : OptconvexconjugateBuffer, f : Double) -> OptconvexconjugateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_buffer_add(a : OptconvexconjugateBuffer, b : OptconvexconjugateBuffer) -> OptconvexconjugateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_buffer_copy(s : OptconvexconjugateBuffer) -> OptconvexconjugateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_buffer_fill(s : OptconvexconjugateBuffer, v : Double) -> OptconvexconjugateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_buffer_min(s : OptconvexconjugateBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_buffer_max(s : OptconvexconjugateBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_buffer_to_string(s : OptconvexconjugateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_cursor_make(size : Int) -> OptconvexconjugateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_cursor_len(s : OptconvexconjugateCursor) -> Int { s.size }

pub fn opt_convex_conjugate_cursor_get(s : OptconvexconjugateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_cursor_set(s : OptconvexconjugateCursor, i : Int, v : Double) -> OptconvexconjugateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cursor_sum(s : OptconvexconjugateCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_cursor_mean(s : OptconvexconjugateCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_cursor_scale(s : OptconvexconjugateCursor, f : Double) -> OptconvexconjugateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cursor_add(a : OptconvexconjugateCursor, b : OptconvexconjugateCursor) -> OptconvexconjugateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_cursor_copy(s : OptconvexconjugateCursor) -> OptconvexconjugateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cursor_fill(s : OptconvexconjugateCursor, v : Double) -> OptconvexconjugateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_cursor_min(s : OptconvexconjugateCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_cursor_max(s : OptconvexconjugateCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_cursor_to_string(s : OptconvexconjugateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_view_make(size : Int) -> OptconvexconjugateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_view_len(s : OptconvexconjugateView) -> Int { s.size }

pub fn opt_convex_conjugate_view_get(s : OptconvexconjugateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_view_set(s : OptconvexconjugateView, i : Int, v : Double) -> OptconvexconjugateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_view_sum(s : OptconvexconjugateView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_view_mean(s : OptconvexconjugateView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_view_scale(s : OptconvexconjugateView, f : Double) -> OptconvexconjugateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_view_add(a : OptconvexconjugateView, b : OptconvexconjugateView) -> OptconvexconjugateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_view_copy(s : OptconvexconjugateView) -> OptconvexconjugateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_view_fill(s : OptconvexconjugateView, v : Double) -> OptconvexconjugateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_view_min(s : OptconvexconjugateView) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_view_max(s : OptconvexconjugateView) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_view_to_string(s : OptconvexconjugateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_range_make(size : Int) -> OptconvexconjugateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_range_len(s : OptconvexconjugateRange) -> Int { s.size }

pub fn opt_convex_conjugate_range_get(s : OptconvexconjugateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_range_set(s : OptconvexconjugateRange, i : Int, v : Double) -> OptconvexconjugateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_range_sum(s : OptconvexconjugateRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_range_mean(s : OptconvexconjugateRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_range_scale(s : OptconvexconjugateRange, f : Double) -> OptconvexconjugateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_range_add(a : OptconvexconjugateRange, b : OptconvexconjugateRange) -> OptconvexconjugateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_range_copy(s : OptconvexconjugateRange) -> OptconvexconjugateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_range_fill(s : OptconvexconjugateRange, v : Double) -> OptconvexconjugateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_range_min(s : OptconvexconjugateRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_range_max(s : OptconvexconjugateRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_range_to_string(s : OptconvexconjugateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_slice_make(size : Int) -> OptconvexconjugateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_slice_len(s : OptconvexconjugateSlice) -> Int { s.size }

pub fn opt_convex_conjugate_slice_get(s : OptconvexconjugateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_slice_set(s : OptconvexconjugateSlice, i : Int, v : Double) -> OptconvexconjugateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_slice_sum(s : OptconvexconjugateSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_conjugate_slice_mean(s : OptconvexconjugateSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_conjugate_slice_scale(s : OptconvexconjugateSlice, f : Double) -> OptconvexconjugateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_slice_add(a : OptconvexconjugateSlice, b : OptconvexconjugateSlice) -> OptconvexconjugateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_conjugate_slice_copy(s : OptconvexconjugateSlice) -> OptconvexconjugateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_slice_fill(s : OptconvexconjugateSlice, v : Double) -> OptconvexconjugateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_conjugate_slice_min(s : OptconvexconjugateSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_conjugate_slice_max(s : OptconvexconjugateSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_conjugate_slice_to_string(s : OptconvexconjugateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

