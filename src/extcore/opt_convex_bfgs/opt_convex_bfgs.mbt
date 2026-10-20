///===
/// extcore/opt_convex_bfgs

pub(all) struct OptconvexbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_bfgs_make_point(x : Double, y : Double) -> OptconvexbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexbfgsPoint::x(self : OptconvexbfgsPoint) -> Double { self.x }

pub fn OptconvexbfgsPoint::y(self : OptconvexbfgsPoint) -> Double { self.y }

pub fn OptconvexbfgsPoint::z(self : OptconvexbfgsPoint) -> Double { self.z }

pub fn OptconvexbfgsPoint::label(self : OptconvexbfgsPoint) -> Int { self.label }

pub fn OptconvexbfgsPoint::dist(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexbfgsPoint::add(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexbfgsPoint::sub(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexbfgsPoint::scale(self : OptconvexbfgsPoint, s : Double) -> OptconvexbfgsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexbfgsPoint::dot(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexbfgsPoint::cross(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexbfgsPoint::norm(self : OptconvexbfgsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexbfgsPoint::normalize(self : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexbfgsPoint::negate(self : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexbfgsPoint::mid(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexbfgsPoint::lerp(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint, t : Double) -> OptconvexbfgsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexbfgsPoint::to_string(self : OptconvexbfgsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexbfgsSeries::len(self : OptconvexbfgsSeries) -> Int { self.vals.length() }

pub fn OptconvexbfgsSeries::sum(self : OptconvexbfgsSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexbfgsSeries::mean(self : OptconvexbfgsSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexbfgsSeries::min(self : OptconvexbfgsSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexbfgsSeries::max(self : OptconvexbfgsSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexbfgsSeries::range(self : OptconvexbfgsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexbfgsSeries::variance(self : OptconvexbfgsSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexbfgsSeries::std(self : OptconvexbfgsSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexbfgsSeries::median(self : OptconvexbfgsSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexbfgsSeries::scale(self : OptconvexbfgsSeries, f : Double) -> OptconvexbfgsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexbfgsSeries::add(self : OptconvexbfgsSeries, other : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexbfgsSeries::sub(self : OptconvexbfgsSeries, other : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexbfgsSeries::normalize(self : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexbfgsSeries::cumsum(self : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexbfgsSeries::to_string(self : OptconvexbfgsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_bfgs_matrix_identity(n : Int) -> OptconvexbfgsMatrix {
  let m = opt_convex_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexbfgsMatrix::get(self : OptconvexbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexbfgsMatrix::transpose(self : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  let result = opt_convex_bfgs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexbfgsMatrix::add(self : OptconvexbfgsMatrix, other : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexbfgsMatrix::scale(self : OptconvexbfgsMatrix, s : Double) -> OptconvexbfgsMatrix {
  let result = opt_convex_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexbfgsMatrix::multiply(self : OptconvexbfgsMatrix, other : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  if self.cols != other.rows { return opt_convex_bfgs_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_bfgs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexbfgsMatrix::trace(self : OptconvexbfgsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexbfgsMatrix::det(self : OptconvexbfgsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexbfgsMatrix::norm(self : OptconvexbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexbfgsMatrix::to_string(self : OptconvexbfgsMatrix) -> String {
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

pub(all) struct OptconvexbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_bfgs_make_vector(comps : Array[Double]) -> OptconvexbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_bfgs_vector_zero(dim : Int) -> OptconvexbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexbfgsVector::add(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexbfgsVector::sub(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexbfgsVector::scale(self : OptconvexbfgsVector, s : Double) -> OptconvexbfgsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexbfgsVector::dot(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexbfgsVector::norm(self : OptconvexbfgsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexbfgsVector::normalize(self : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexbfgsVector::dist(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexbfgsVector::to_string(self : OptconvexbfgsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_bfgs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_bfgs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_bfgs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_bfgs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_bfgs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_bfgs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_bfgs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_bfgs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_bfgs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_bfgs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_bfgs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_bfgs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_bfgs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_bfgs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_bfgs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_bfgs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_bfgs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_bfgs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_bfgs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_bfgs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_bfgs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_bfgs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_bfgs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_bfgs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_bfgs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_bfgs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_bfgs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_bfgs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_bfgs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_frame_make(size : Int) -> OptconvexbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_frame_len(s : OptconvexbfgsFrame) -> Int { s.size }

pub fn opt_convex_bfgs_frame_get(s : OptconvexbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_frame_set(s : OptconvexbfgsFrame, i : Int, v : Double) -> OptconvexbfgsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_frame_sum(s : OptconvexbfgsFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_frame_mean(s : OptconvexbfgsFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_frame_scale(s : OptconvexbfgsFrame, f : Double) -> OptconvexbfgsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_frame_add(a : OptconvexbfgsFrame, b : OptconvexbfgsFrame) -> OptconvexbfgsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_frame_copy(s : OptconvexbfgsFrame) -> OptconvexbfgsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_frame_fill(s : OptconvexbfgsFrame, v : Double) -> OptconvexbfgsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_frame_min(s : OptconvexbfgsFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_frame_max(s : OptconvexbfgsFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_frame_to_string(s : OptconvexbfgsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_table_make(size : Int) -> OptconvexbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_table_len(s : OptconvexbfgsTable) -> Int { s.size }

pub fn opt_convex_bfgs_table_get(s : OptconvexbfgsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_table_set(s : OptconvexbfgsTable, i : Int, v : Double) -> OptconvexbfgsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_table_sum(s : OptconvexbfgsTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_table_mean(s : OptconvexbfgsTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_table_scale(s : OptconvexbfgsTable, f : Double) -> OptconvexbfgsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_table_add(a : OptconvexbfgsTable, b : OptconvexbfgsTable) -> OptconvexbfgsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_table_copy(s : OptconvexbfgsTable) -> OptconvexbfgsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_table_fill(s : OptconvexbfgsTable, v : Double) -> OptconvexbfgsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_table_min(s : OptconvexbfgsTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_table_max(s : OptconvexbfgsTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_table_to_string(s : OptconvexbfgsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_graphn_make(size : Int) -> OptconvexbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_graphn_len(s : OptconvexbfgsGraphN) -> Int { s.size }

pub fn opt_convex_bfgs_graphn_get(s : OptconvexbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_graphn_set(s : OptconvexbfgsGraphN, i : Int, v : Double) -> OptconvexbfgsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_graphn_sum(s : OptconvexbfgsGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_graphn_mean(s : OptconvexbfgsGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_graphn_scale(s : OptconvexbfgsGraphN, f : Double) -> OptconvexbfgsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_graphn_add(a : OptconvexbfgsGraphN, b : OptconvexbfgsGraphN) -> OptconvexbfgsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_graphn_copy(s : OptconvexbfgsGraphN) -> OptconvexbfgsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_graphn_fill(s : OptconvexbfgsGraphN, v : Double) -> OptconvexbfgsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_graphn_min(s : OptconvexbfgsGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_graphn_max(s : OptconvexbfgsGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_graphn_to_string(s : OptconvexbfgsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_node_make(size : Int) -> OptconvexbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_node_len(s : OptconvexbfgsNode) -> Int { s.size }

pub fn opt_convex_bfgs_node_get(s : OptconvexbfgsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_node_set(s : OptconvexbfgsNode, i : Int, v : Double) -> OptconvexbfgsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_node_sum(s : OptconvexbfgsNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_node_mean(s : OptconvexbfgsNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_node_scale(s : OptconvexbfgsNode, f : Double) -> OptconvexbfgsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_node_add(a : OptconvexbfgsNode, b : OptconvexbfgsNode) -> OptconvexbfgsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_node_copy(s : OptconvexbfgsNode) -> OptconvexbfgsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_node_fill(s : OptconvexbfgsNode, v : Double) -> OptconvexbfgsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_node_min(s : OptconvexbfgsNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_node_max(s : OptconvexbfgsNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_node_to_string(s : OptconvexbfgsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_edge_make(size : Int) -> OptconvexbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_edge_len(s : OptconvexbfgsEdge) -> Int { s.size }

pub fn opt_convex_bfgs_edge_get(s : OptconvexbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_edge_set(s : OptconvexbfgsEdge, i : Int, v : Double) -> OptconvexbfgsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_edge_sum(s : OptconvexbfgsEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_edge_mean(s : OptconvexbfgsEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_edge_scale(s : OptconvexbfgsEdge, f : Double) -> OptconvexbfgsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_edge_add(a : OptconvexbfgsEdge, b : OptconvexbfgsEdge) -> OptconvexbfgsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_edge_copy(s : OptconvexbfgsEdge) -> OptconvexbfgsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_edge_fill(s : OptconvexbfgsEdge, v : Double) -> OptconvexbfgsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_edge_min(s : OptconvexbfgsEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_edge_max(s : OptconvexbfgsEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_edge_to_string(s : OptconvexbfgsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_path_make(size : Int) -> OptconvexbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_path_len(s : OptconvexbfgsPath) -> Int { s.size }

pub fn opt_convex_bfgs_path_get(s : OptconvexbfgsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_path_set(s : OptconvexbfgsPath, i : Int, v : Double) -> OptconvexbfgsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_path_sum(s : OptconvexbfgsPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_path_mean(s : OptconvexbfgsPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_path_scale(s : OptconvexbfgsPath, f : Double) -> OptconvexbfgsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_path_add(a : OptconvexbfgsPath, b : OptconvexbfgsPath) -> OptconvexbfgsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_path_copy(s : OptconvexbfgsPath) -> OptconvexbfgsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_path_fill(s : OptconvexbfgsPath, v : Double) -> OptconvexbfgsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_path_min(s : OptconvexbfgsPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_path_max(s : OptconvexbfgsPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_path_to_string(s : OptconvexbfgsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_cluster_make(size : Int) -> OptconvexbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_cluster_len(s : OptconvexbfgsCluster) -> Int { s.size }

pub fn opt_convex_bfgs_cluster_get(s : OptconvexbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_cluster_set(s : OptconvexbfgsCluster, i : Int, v : Double) -> OptconvexbfgsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cluster_sum(s : OptconvexbfgsCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_cluster_mean(s : OptconvexbfgsCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_cluster_scale(s : OptconvexbfgsCluster, f : Double) -> OptconvexbfgsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cluster_add(a : OptconvexbfgsCluster, b : OptconvexbfgsCluster) -> OptconvexbfgsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_cluster_copy(s : OptconvexbfgsCluster) -> OptconvexbfgsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cluster_fill(s : OptconvexbfgsCluster, v : Double) -> OptconvexbfgsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cluster_min(s : OptconvexbfgsCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_cluster_max(s : OptconvexbfgsCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_cluster_to_string(s : OptconvexbfgsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_model_make(size : Int) -> OptconvexbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_model_len(s : OptconvexbfgsModel) -> Int { s.size }

pub fn opt_convex_bfgs_model_get(s : OptconvexbfgsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_model_set(s : OptconvexbfgsModel, i : Int, v : Double) -> OptconvexbfgsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_model_sum(s : OptconvexbfgsModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_model_mean(s : OptconvexbfgsModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_model_scale(s : OptconvexbfgsModel, f : Double) -> OptconvexbfgsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_model_add(a : OptconvexbfgsModel, b : OptconvexbfgsModel) -> OptconvexbfgsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_model_copy(s : OptconvexbfgsModel) -> OptconvexbfgsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_model_fill(s : OptconvexbfgsModel, v : Double) -> OptconvexbfgsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_model_min(s : OptconvexbfgsModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_model_max(s : OptconvexbfgsModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_model_to_string(s : OptconvexbfgsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_layer_make(size : Int) -> OptconvexbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_layer_len(s : OptconvexbfgsLayer) -> Int { s.size }

pub fn opt_convex_bfgs_layer_get(s : OptconvexbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_layer_set(s : OptconvexbfgsLayer, i : Int, v : Double) -> OptconvexbfgsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_layer_sum(s : OptconvexbfgsLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_layer_mean(s : OptconvexbfgsLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_layer_scale(s : OptconvexbfgsLayer, f : Double) -> OptconvexbfgsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_layer_add(a : OptconvexbfgsLayer, b : OptconvexbfgsLayer) -> OptconvexbfgsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_layer_copy(s : OptconvexbfgsLayer) -> OptconvexbfgsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_layer_fill(s : OptconvexbfgsLayer, v : Double) -> OptconvexbfgsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_layer_min(s : OptconvexbfgsLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_layer_max(s : OptconvexbfgsLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_layer_to_string(s : OptconvexbfgsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_buffer_make(size : Int) -> OptconvexbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_buffer_len(s : OptconvexbfgsBuffer) -> Int { s.size }

pub fn opt_convex_bfgs_buffer_get(s : OptconvexbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_buffer_set(s : OptconvexbfgsBuffer, i : Int, v : Double) -> OptconvexbfgsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_buffer_sum(s : OptconvexbfgsBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_buffer_mean(s : OptconvexbfgsBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_buffer_scale(s : OptconvexbfgsBuffer, f : Double) -> OptconvexbfgsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_buffer_add(a : OptconvexbfgsBuffer, b : OptconvexbfgsBuffer) -> OptconvexbfgsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_buffer_copy(s : OptconvexbfgsBuffer) -> OptconvexbfgsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_buffer_fill(s : OptconvexbfgsBuffer, v : Double) -> OptconvexbfgsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_buffer_min(s : OptconvexbfgsBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_buffer_max(s : OptconvexbfgsBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_buffer_to_string(s : OptconvexbfgsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_cursor_make(size : Int) -> OptconvexbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_cursor_len(s : OptconvexbfgsCursor) -> Int { s.size }

pub fn opt_convex_bfgs_cursor_get(s : OptconvexbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_cursor_set(s : OptconvexbfgsCursor, i : Int, v : Double) -> OptconvexbfgsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cursor_sum(s : OptconvexbfgsCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_cursor_mean(s : OptconvexbfgsCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_cursor_scale(s : OptconvexbfgsCursor, f : Double) -> OptconvexbfgsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cursor_add(a : OptconvexbfgsCursor, b : OptconvexbfgsCursor) -> OptconvexbfgsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_cursor_copy(s : OptconvexbfgsCursor) -> OptconvexbfgsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cursor_fill(s : OptconvexbfgsCursor, v : Double) -> OptconvexbfgsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_cursor_min(s : OptconvexbfgsCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_cursor_max(s : OptconvexbfgsCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_cursor_to_string(s : OptconvexbfgsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_view_make(size : Int) -> OptconvexbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_view_len(s : OptconvexbfgsView) -> Int { s.size }

pub fn opt_convex_bfgs_view_get(s : OptconvexbfgsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_view_set(s : OptconvexbfgsView, i : Int, v : Double) -> OptconvexbfgsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_view_sum(s : OptconvexbfgsView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_view_mean(s : OptconvexbfgsView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_view_scale(s : OptconvexbfgsView, f : Double) -> OptconvexbfgsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_view_add(a : OptconvexbfgsView, b : OptconvexbfgsView) -> OptconvexbfgsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_view_copy(s : OptconvexbfgsView) -> OptconvexbfgsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_view_fill(s : OptconvexbfgsView, v : Double) -> OptconvexbfgsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_view_min(s : OptconvexbfgsView) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_view_max(s : OptconvexbfgsView) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_view_to_string(s : OptconvexbfgsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_range_make(size : Int) -> OptconvexbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_range_len(s : OptconvexbfgsRange) -> Int { s.size }

pub fn opt_convex_bfgs_range_get(s : OptconvexbfgsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_range_set(s : OptconvexbfgsRange, i : Int, v : Double) -> OptconvexbfgsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_range_sum(s : OptconvexbfgsRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_range_mean(s : OptconvexbfgsRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_range_scale(s : OptconvexbfgsRange, f : Double) -> OptconvexbfgsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_range_add(a : OptconvexbfgsRange, b : OptconvexbfgsRange) -> OptconvexbfgsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_range_copy(s : OptconvexbfgsRange) -> OptconvexbfgsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_range_fill(s : OptconvexbfgsRange, v : Double) -> OptconvexbfgsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_range_min(s : OptconvexbfgsRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_range_max(s : OptconvexbfgsRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_range_to_string(s : OptconvexbfgsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_slice_make(size : Int) -> OptconvexbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_slice_len(s : OptconvexbfgsSlice) -> Int { s.size }

pub fn opt_convex_bfgs_slice_get(s : OptconvexbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_slice_set(s : OptconvexbfgsSlice, i : Int, v : Double) -> OptconvexbfgsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_slice_sum(s : OptconvexbfgsSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_bfgs_slice_mean(s : OptconvexbfgsSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_bfgs_slice_scale(s : OptconvexbfgsSlice, f : Double) -> OptconvexbfgsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_slice_add(a : OptconvexbfgsSlice, b : OptconvexbfgsSlice) -> OptconvexbfgsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_bfgs_slice_copy(s : OptconvexbfgsSlice) -> OptconvexbfgsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_slice_fill(s : OptconvexbfgsSlice, v : Double) -> OptconvexbfgsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_bfgs_slice_min(s : OptconvexbfgsSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_bfgs_slice_max(s : OptconvexbfgsSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_bfgs_slice_to_string(s : OptconvexbfgsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

