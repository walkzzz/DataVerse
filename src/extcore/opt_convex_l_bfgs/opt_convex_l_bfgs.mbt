///===
/// extcore/opt_convex_l_bfgs

pub(all) struct OptconvexlbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_l_bfgs_make_point(x : Double, y : Double) -> OptconvexlbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_l_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexlbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexlbfgsPoint::x(self : OptconvexlbfgsPoint) -> Double { self.x }

pub fn OptconvexlbfgsPoint::y(self : OptconvexlbfgsPoint) -> Double { self.y }

pub fn OptconvexlbfgsPoint::z(self : OptconvexlbfgsPoint) -> Double { self.z }

pub fn OptconvexlbfgsPoint::label(self : OptconvexlbfgsPoint) -> Int { self.label }

pub fn OptconvexlbfgsPoint::dist(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexlbfgsPoint::add(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexlbfgsPoint::sub(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexlbfgsPoint::scale(self : OptconvexlbfgsPoint, s : Double) -> OptconvexlbfgsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexlbfgsPoint::dot(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexlbfgsPoint::cross(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexlbfgsPoint::norm(self : OptconvexlbfgsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexlbfgsPoint::normalize(self : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlbfgsPoint::negate(self : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexlbfgsPoint::mid(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexlbfgsPoint::lerp(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint, t : Double) -> OptconvexlbfgsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexlbfgsPoint::to_string(self : OptconvexlbfgsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_l_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexlbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexlbfgsSeries::len(self : OptconvexlbfgsSeries) -> Int { self.vals.length() }

pub fn OptconvexlbfgsSeries::sum(self : OptconvexlbfgsSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexlbfgsSeries::mean(self : OptconvexlbfgsSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexlbfgsSeries::min(self : OptconvexlbfgsSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexlbfgsSeries::max(self : OptconvexlbfgsSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexlbfgsSeries::range(self : OptconvexlbfgsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexlbfgsSeries::variance(self : OptconvexlbfgsSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexlbfgsSeries::std(self : OptconvexlbfgsSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexlbfgsSeries::median(self : OptconvexlbfgsSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexlbfgsSeries::scale(self : OptconvexlbfgsSeries, f : Double) -> OptconvexlbfgsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexlbfgsSeries::add(self : OptconvexlbfgsSeries, other : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexlbfgsSeries::sub(self : OptconvexlbfgsSeries, other : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexlbfgsSeries::normalize(self : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexlbfgsSeries::cumsum(self : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexlbfgsSeries::to_string(self : OptconvexlbfgsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_l_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_l_bfgs_matrix_identity(n : Int) -> OptconvexlbfgsMatrix {
  let m = opt_convex_l_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexlbfgsMatrix::get(self : OptconvexlbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexlbfgsMatrix::transpose(self : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexlbfgsMatrix::add(self : OptconvexlbfgsMatrix, other : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_l_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexlbfgsMatrix::scale(self : OptconvexlbfgsMatrix, s : Double) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexlbfgsMatrix::multiply(self : OptconvexlbfgsMatrix, other : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if self.cols != other.rows { return opt_convex_l_bfgs_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_l_bfgs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexlbfgsMatrix::trace(self : OptconvexlbfgsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexlbfgsMatrix::det(self : OptconvexlbfgsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexlbfgsMatrix::norm(self : OptconvexlbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexlbfgsMatrix::to_string(self : OptconvexlbfgsMatrix) -> String {
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

pub(all) struct OptconvexlbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_l_bfgs_make_vector(comps : Array[Double]) -> OptconvexlbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_l_bfgs_vector_zero(dim : Int) -> OptconvexlbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexlbfgsVector::add(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlbfgsVector::sub(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlbfgsVector::scale(self : OptconvexlbfgsVector, s : Double) -> OptconvexlbfgsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexlbfgsVector::dot(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexlbfgsVector::norm(self : OptconvexlbfgsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexlbfgsVector::normalize(self : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlbfgsVector::dist(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexlbfgsVector::to_string(self : OptconvexlbfgsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_l_bfgs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_l_bfgs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_l_bfgs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_l_bfgs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_l_bfgs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_l_bfgs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_l_bfgs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_l_bfgs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_l_bfgs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_l_bfgs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_l_bfgs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_l_bfgs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_l_bfgs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_l_bfgs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_l_bfgs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_l_bfgs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_l_bfgs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_l_bfgs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_l_bfgs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_l_bfgs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_l_bfgs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_l_bfgs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_l_bfgs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_l_bfgs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_l_bfgs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_l_bfgs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_l_bfgs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_l_bfgs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_l_bfgs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexlbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_frame_make(size : Int) -> OptconvexlbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_frame_len(s : OptconvexlbfgsFrame) -> Int { s.size }

pub fn opt_convex_l_bfgs_frame_get(s : OptconvexlbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_frame_set(s : OptconvexlbfgsFrame, i : Int, v : Double) -> OptconvexlbfgsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_frame_sum(s : OptconvexlbfgsFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_frame_mean(s : OptconvexlbfgsFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_frame_scale(s : OptconvexlbfgsFrame, f : Double) -> OptconvexlbfgsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_frame_add(a : OptconvexlbfgsFrame, b : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_frame_copy(s : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_frame_fill(s : OptconvexlbfgsFrame, v : Double) -> OptconvexlbfgsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_frame_min(s : OptconvexlbfgsFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_frame_max(s : OptconvexlbfgsFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_frame_to_string(s : OptconvexlbfgsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_table_make(size : Int) -> OptconvexlbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_table_len(s : OptconvexlbfgsTable) -> Int { s.size }

pub fn opt_convex_l_bfgs_table_get(s : OptconvexlbfgsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_table_set(s : OptconvexlbfgsTable, i : Int, v : Double) -> OptconvexlbfgsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_table_sum(s : OptconvexlbfgsTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_table_mean(s : OptconvexlbfgsTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_table_scale(s : OptconvexlbfgsTable, f : Double) -> OptconvexlbfgsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_table_add(a : OptconvexlbfgsTable, b : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_table_copy(s : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_table_fill(s : OptconvexlbfgsTable, v : Double) -> OptconvexlbfgsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_table_min(s : OptconvexlbfgsTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_table_max(s : OptconvexlbfgsTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_table_to_string(s : OptconvexlbfgsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_graphn_make(size : Int) -> OptconvexlbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_graphn_len(s : OptconvexlbfgsGraphN) -> Int { s.size }

pub fn opt_convex_l_bfgs_graphn_get(s : OptconvexlbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_graphn_set(s : OptconvexlbfgsGraphN, i : Int, v : Double) -> OptconvexlbfgsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_graphn_sum(s : OptconvexlbfgsGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_graphn_mean(s : OptconvexlbfgsGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_graphn_scale(s : OptconvexlbfgsGraphN, f : Double) -> OptconvexlbfgsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_graphn_add(a : OptconvexlbfgsGraphN, b : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_graphn_copy(s : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_graphn_fill(s : OptconvexlbfgsGraphN, v : Double) -> OptconvexlbfgsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_graphn_min(s : OptconvexlbfgsGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_graphn_max(s : OptconvexlbfgsGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_graphn_to_string(s : OptconvexlbfgsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_node_make(size : Int) -> OptconvexlbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_node_len(s : OptconvexlbfgsNode) -> Int { s.size }

pub fn opt_convex_l_bfgs_node_get(s : OptconvexlbfgsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_node_set(s : OptconvexlbfgsNode, i : Int, v : Double) -> OptconvexlbfgsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_node_sum(s : OptconvexlbfgsNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_node_mean(s : OptconvexlbfgsNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_node_scale(s : OptconvexlbfgsNode, f : Double) -> OptconvexlbfgsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_node_add(a : OptconvexlbfgsNode, b : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_node_copy(s : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_node_fill(s : OptconvexlbfgsNode, v : Double) -> OptconvexlbfgsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_node_min(s : OptconvexlbfgsNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_node_max(s : OptconvexlbfgsNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_node_to_string(s : OptconvexlbfgsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_edge_make(size : Int) -> OptconvexlbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_edge_len(s : OptconvexlbfgsEdge) -> Int { s.size }

pub fn opt_convex_l_bfgs_edge_get(s : OptconvexlbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_edge_set(s : OptconvexlbfgsEdge, i : Int, v : Double) -> OptconvexlbfgsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_edge_sum(s : OptconvexlbfgsEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_edge_mean(s : OptconvexlbfgsEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_edge_scale(s : OptconvexlbfgsEdge, f : Double) -> OptconvexlbfgsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_edge_add(a : OptconvexlbfgsEdge, b : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_edge_copy(s : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_edge_fill(s : OptconvexlbfgsEdge, v : Double) -> OptconvexlbfgsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_edge_min(s : OptconvexlbfgsEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_edge_max(s : OptconvexlbfgsEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_edge_to_string(s : OptconvexlbfgsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_path_make(size : Int) -> OptconvexlbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_path_len(s : OptconvexlbfgsPath) -> Int { s.size }

pub fn opt_convex_l_bfgs_path_get(s : OptconvexlbfgsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_path_set(s : OptconvexlbfgsPath, i : Int, v : Double) -> OptconvexlbfgsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_path_sum(s : OptconvexlbfgsPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_path_mean(s : OptconvexlbfgsPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_path_scale(s : OptconvexlbfgsPath, f : Double) -> OptconvexlbfgsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_path_add(a : OptconvexlbfgsPath, b : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_path_copy(s : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_path_fill(s : OptconvexlbfgsPath, v : Double) -> OptconvexlbfgsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_path_min(s : OptconvexlbfgsPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_path_max(s : OptconvexlbfgsPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_path_to_string(s : OptconvexlbfgsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cluster_make(size : Int) -> OptconvexlbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_cluster_len(s : OptconvexlbfgsCluster) -> Int { s.size }

pub fn opt_convex_l_bfgs_cluster_get(s : OptconvexlbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_cluster_set(s : OptconvexlbfgsCluster, i : Int, v : Double) -> OptconvexlbfgsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cluster_sum(s : OptconvexlbfgsCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_cluster_mean(s : OptconvexlbfgsCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_cluster_scale(s : OptconvexlbfgsCluster, f : Double) -> OptconvexlbfgsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cluster_add(a : OptconvexlbfgsCluster, b : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_cluster_copy(s : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cluster_fill(s : OptconvexlbfgsCluster, v : Double) -> OptconvexlbfgsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cluster_min(s : OptconvexlbfgsCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_cluster_max(s : OptconvexlbfgsCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_cluster_to_string(s : OptconvexlbfgsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_model_make(size : Int) -> OptconvexlbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_model_len(s : OptconvexlbfgsModel) -> Int { s.size }

pub fn opt_convex_l_bfgs_model_get(s : OptconvexlbfgsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_model_set(s : OptconvexlbfgsModel, i : Int, v : Double) -> OptconvexlbfgsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_model_sum(s : OptconvexlbfgsModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_model_mean(s : OptconvexlbfgsModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_model_scale(s : OptconvexlbfgsModel, f : Double) -> OptconvexlbfgsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_model_add(a : OptconvexlbfgsModel, b : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_model_copy(s : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_model_fill(s : OptconvexlbfgsModel, v : Double) -> OptconvexlbfgsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_model_min(s : OptconvexlbfgsModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_model_max(s : OptconvexlbfgsModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_model_to_string(s : OptconvexlbfgsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_layer_make(size : Int) -> OptconvexlbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_layer_len(s : OptconvexlbfgsLayer) -> Int { s.size }

pub fn opt_convex_l_bfgs_layer_get(s : OptconvexlbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_layer_set(s : OptconvexlbfgsLayer, i : Int, v : Double) -> OptconvexlbfgsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_layer_sum(s : OptconvexlbfgsLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_layer_mean(s : OptconvexlbfgsLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_layer_scale(s : OptconvexlbfgsLayer, f : Double) -> OptconvexlbfgsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_layer_add(a : OptconvexlbfgsLayer, b : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_layer_copy(s : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_layer_fill(s : OptconvexlbfgsLayer, v : Double) -> OptconvexlbfgsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_layer_min(s : OptconvexlbfgsLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_layer_max(s : OptconvexlbfgsLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_layer_to_string(s : OptconvexlbfgsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_buffer_make(size : Int) -> OptconvexlbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_buffer_len(s : OptconvexlbfgsBuffer) -> Int { s.size }

pub fn opt_convex_l_bfgs_buffer_get(s : OptconvexlbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_buffer_set(s : OptconvexlbfgsBuffer, i : Int, v : Double) -> OptconvexlbfgsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_buffer_sum(s : OptconvexlbfgsBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_buffer_mean(s : OptconvexlbfgsBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_buffer_scale(s : OptconvexlbfgsBuffer, f : Double) -> OptconvexlbfgsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_buffer_add(a : OptconvexlbfgsBuffer, b : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_buffer_copy(s : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_buffer_fill(s : OptconvexlbfgsBuffer, v : Double) -> OptconvexlbfgsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_buffer_min(s : OptconvexlbfgsBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_buffer_max(s : OptconvexlbfgsBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_buffer_to_string(s : OptconvexlbfgsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cursor_make(size : Int) -> OptconvexlbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_cursor_len(s : OptconvexlbfgsCursor) -> Int { s.size }

pub fn opt_convex_l_bfgs_cursor_get(s : OptconvexlbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_cursor_set(s : OptconvexlbfgsCursor, i : Int, v : Double) -> OptconvexlbfgsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cursor_sum(s : OptconvexlbfgsCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_cursor_mean(s : OptconvexlbfgsCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_cursor_scale(s : OptconvexlbfgsCursor, f : Double) -> OptconvexlbfgsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cursor_add(a : OptconvexlbfgsCursor, b : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_cursor_copy(s : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cursor_fill(s : OptconvexlbfgsCursor, v : Double) -> OptconvexlbfgsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_cursor_min(s : OptconvexlbfgsCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_cursor_max(s : OptconvexlbfgsCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_cursor_to_string(s : OptconvexlbfgsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_view_make(size : Int) -> OptconvexlbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_view_len(s : OptconvexlbfgsView) -> Int { s.size }

pub fn opt_convex_l_bfgs_view_get(s : OptconvexlbfgsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_view_set(s : OptconvexlbfgsView, i : Int, v : Double) -> OptconvexlbfgsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_view_sum(s : OptconvexlbfgsView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_view_mean(s : OptconvexlbfgsView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_view_scale(s : OptconvexlbfgsView, f : Double) -> OptconvexlbfgsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_view_add(a : OptconvexlbfgsView, b : OptconvexlbfgsView) -> OptconvexlbfgsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_view_copy(s : OptconvexlbfgsView) -> OptconvexlbfgsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_view_fill(s : OptconvexlbfgsView, v : Double) -> OptconvexlbfgsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_view_min(s : OptconvexlbfgsView) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_view_max(s : OptconvexlbfgsView) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_view_to_string(s : OptconvexlbfgsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_range_make(size : Int) -> OptconvexlbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_range_len(s : OptconvexlbfgsRange) -> Int { s.size }

pub fn opt_convex_l_bfgs_range_get(s : OptconvexlbfgsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_range_set(s : OptconvexlbfgsRange, i : Int, v : Double) -> OptconvexlbfgsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_range_sum(s : OptconvexlbfgsRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_range_mean(s : OptconvexlbfgsRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_range_scale(s : OptconvexlbfgsRange, f : Double) -> OptconvexlbfgsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_range_add(a : OptconvexlbfgsRange, b : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_range_copy(s : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_range_fill(s : OptconvexlbfgsRange, v : Double) -> OptconvexlbfgsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_range_min(s : OptconvexlbfgsRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_range_max(s : OptconvexlbfgsRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_range_to_string(s : OptconvexlbfgsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_slice_make(size : Int) -> OptconvexlbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_slice_len(s : OptconvexlbfgsSlice) -> Int { s.size }

pub fn opt_convex_l_bfgs_slice_get(s : OptconvexlbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_slice_set(s : OptconvexlbfgsSlice, i : Int, v : Double) -> OptconvexlbfgsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_slice_sum(s : OptconvexlbfgsSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_slice_mean(s : OptconvexlbfgsSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_slice_scale(s : OptconvexlbfgsSlice, f : Double) -> OptconvexlbfgsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_slice_add(a : OptconvexlbfgsSlice, b : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_l_bfgs_slice_copy(s : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_slice_fill(s : OptconvexlbfgsSlice, v : Double) -> OptconvexlbfgsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_l_bfgs_slice_min(s : OptconvexlbfgsSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_slice_max(s : OptconvexlbfgsSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_slice_to_string(s : OptconvexlbfgsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

