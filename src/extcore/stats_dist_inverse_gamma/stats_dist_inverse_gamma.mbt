///===
/// extcore/stats_dist_inverse_gamma

pub(all) struct StatsdistinversegammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_inverse_gamma_make_point(x : Double, y : Double) -> StatsdistinversegammaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_inverse_gamma_make_point3(x : Double, y : Double, z : Double) -> StatsdistinversegammaPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistinversegammaPoint::x(self : StatsdistinversegammaPoint) -> Double { self.x }

pub fn StatsdistinversegammaPoint::y(self : StatsdistinversegammaPoint) -> Double { self.y }

pub fn StatsdistinversegammaPoint::z(self : StatsdistinversegammaPoint) -> Double { self.z }

pub fn StatsdistinversegammaPoint::label(self : StatsdistinversegammaPoint) -> Int { self.label }

pub fn StatsdistinversegammaPoint::dist(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistinversegammaPoint::add(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistinversegammaPoint::sub(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistinversegammaPoint::scale(self : StatsdistinversegammaPoint, s : Double) -> StatsdistinversegammaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistinversegammaPoint::dot(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistinversegammaPoint::cross(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistinversegammaPoint::norm(self : StatsdistinversegammaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistinversegammaPoint::normalize(self : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistinversegammaPoint::negate(self : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistinversegammaPoint::mid(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistinversegammaPoint::lerp(self : StatsdistinversegammaPoint, other : StatsdistinversegammaPoint, t : Double) -> StatsdistinversegammaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistinversegammaPoint::to_string(self : StatsdistinversegammaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistinversegammaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_inverse_gamma_make_series(vals : Array[Double], name : String) -> StatsdistinversegammaSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistinversegammaSeries::len(self : StatsdistinversegammaSeries) -> Int { self.vals.length() }

pub fn StatsdistinversegammaSeries::sum(self : StatsdistinversegammaSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistinversegammaSeries::mean(self : StatsdistinversegammaSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistinversegammaSeries::min(self : StatsdistinversegammaSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistinversegammaSeries::max(self : StatsdistinversegammaSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistinversegammaSeries::range(self : StatsdistinversegammaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistinversegammaSeries::variance(self : StatsdistinversegammaSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistinversegammaSeries::std(self : StatsdistinversegammaSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistinversegammaSeries::median(self : StatsdistinversegammaSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistinversegammaSeries::scale(self : StatsdistinversegammaSeries, f : Double) -> StatsdistinversegammaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistinversegammaSeries::add(self : StatsdistinversegammaSeries, other : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistinversegammaSeries::sub(self : StatsdistinversegammaSeries, other : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistinversegammaSeries::normalize(self : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistinversegammaSeries::cumsum(self : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistinversegammaSeries::to_string(self : StatsdistinversegammaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistinversegammaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_inverse_gamma_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistinversegammaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_inverse_gamma_matrix_identity(n : Int) -> StatsdistinversegammaMatrix {
  let m = stats_dist_inverse_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistinversegammaMatrix::get(self : StatsdistinversegammaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistinversegammaMatrix::transpose(self : StatsdistinversegammaMatrix) -> StatsdistinversegammaMatrix {
  let result = stats_dist_inverse_gamma_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistinversegammaMatrix::add(self : StatsdistinversegammaMatrix, other : StatsdistinversegammaMatrix) -> StatsdistinversegammaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_inverse_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistinversegammaMatrix::scale(self : StatsdistinversegammaMatrix, s : Double) -> StatsdistinversegammaMatrix {
  let result = stats_dist_inverse_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistinversegammaMatrix::multiply(self : StatsdistinversegammaMatrix, other : StatsdistinversegammaMatrix) -> StatsdistinversegammaMatrix {
  if self.cols != other.rows { return stats_dist_inverse_gamma_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_inverse_gamma_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistinversegammaMatrix::trace(self : StatsdistinversegammaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistinversegammaMatrix::det(self : StatsdistinversegammaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistinversegammaMatrix::norm(self : StatsdistinversegammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistinversegammaMatrix::to_string(self : StatsdistinversegammaMatrix) -> String {
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

pub(all) struct StatsdistinversegammaVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_inverse_gamma_make_vector(comps : Array[Double]) -> StatsdistinversegammaVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_inverse_gamma_vector_zero(dim : Int) -> StatsdistinversegammaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistinversegammaVector::add(self : StatsdistinversegammaVector, other : StatsdistinversegammaVector) -> StatsdistinversegammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistinversegammaVector::sub(self : StatsdistinversegammaVector, other : StatsdistinversegammaVector) -> StatsdistinversegammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistinversegammaVector::scale(self : StatsdistinversegammaVector, s : Double) -> StatsdistinversegammaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistinversegammaVector::dot(self : StatsdistinversegammaVector, other : StatsdistinversegammaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistinversegammaVector::norm(self : StatsdistinversegammaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistinversegammaVector::normalize(self : StatsdistinversegammaVector) -> StatsdistinversegammaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistinversegammaVector::dist(self : StatsdistinversegammaVector, other : StatsdistinversegammaVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistinversegammaVector::to_string(self : StatsdistinversegammaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_inverse_gamma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_inverse_gamma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_inverse_gamma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_inverse_gamma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_inverse_gamma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_inverse_gamma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_inverse_gamma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_inverse_gamma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_inverse_gamma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_inverse_gamma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_inverse_gamma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_inverse_gamma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_inverse_gamma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_inverse_gamma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_inverse_gamma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_inverse_gamma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_inverse_gamma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_inverse_gamma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_inverse_gamma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_inverse_gamma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_inverse_gamma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_inverse_gamma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_inverse_gamma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_inverse_gamma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_inverse_gamma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_inverse_gamma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_inverse_gamma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_inverse_gamma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_inverse_gamma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistinversegammaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_frame_make(size : Int) -> StatsdistinversegammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_frame_len(s : StatsdistinversegammaFrame) -> Int { s.size }

pub fn stats_dist_inverse_gamma_frame_get(s : StatsdistinversegammaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_frame_set(s : StatsdistinversegammaFrame, i : Int, v : Double) -> StatsdistinversegammaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_frame_sum(s : StatsdistinversegammaFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_frame_mean(s : StatsdistinversegammaFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_frame_scale(s : StatsdistinversegammaFrame, f : Double) -> StatsdistinversegammaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_frame_add(a : StatsdistinversegammaFrame, b : StatsdistinversegammaFrame) -> StatsdistinversegammaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_frame_copy(s : StatsdistinversegammaFrame) -> StatsdistinversegammaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_frame_fill(s : StatsdistinversegammaFrame, v : Double) -> StatsdistinversegammaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_frame_min(s : StatsdistinversegammaFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_frame_max(s : StatsdistinversegammaFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_frame_to_string(s : StatsdistinversegammaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_table_make(size : Int) -> StatsdistinversegammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_table_len(s : StatsdistinversegammaTable) -> Int { s.size }

pub fn stats_dist_inverse_gamma_table_get(s : StatsdistinversegammaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_table_set(s : StatsdistinversegammaTable, i : Int, v : Double) -> StatsdistinversegammaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_table_sum(s : StatsdistinversegammaTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_table_mean(s : StatsdistinversegammaTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_table_scale(s : StatsdistinversegammaTable, f : Double) -> StatsdistinversegammaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_table_add(a : StatsdistinversegammaTable, b : StatsdistinversegammaTable) -> StatsdistinversegammaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_table_copy(s : StatsdistinversegammaTable) -> StatsdistinversegammaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_table_fill(s : StatsdistinversegammaTable, v : Double) -> StatsdistinversegammaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_table_min(s : StatsdistinversegammaTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_table_max(s : StatsdistinversegammaTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_table_to_string(s : StatsdistinversegammaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_graphn_make(size : Int) -> StatsdistinversegammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_graphn_len(s : StatsdistinversegammaGraphN) -> Int { s.size }

pub fn stats_dist_inverse_gamma_graphn_get(s : StatsdistinversegammaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_graphn_set(s : StatsdistinversegammaGraphN, i : Int, v : Double) -> StatsdistinversegammaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_graphn_sum(s : StatsdistinversegammaGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_graphn_mean(s : StatsdistinversegammaGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_graphn_scale(s : StatsdistinversegammaGraphN, f : Double) -> StatsdistinversegammaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_graphn_add(a : StatsdistinversegammaGraphN, b : StatsdistinversegammaGraphN) -> StatsdistinversegammaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_graphn_copy(s : StatsdistinversegammaGraphN) -> StatsdistinversegammaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_graphn_fill(s : StatsdistinversegammaGraphN, v : Double) -> StatsdistinversegammaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_graphn_min(s : StatsdistinversegammaGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_graphn_max(s : StatsdistinversegammaGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_graphn_to_string(s : StatsdistinversegammaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_node_make(size : Int) -> StatsdistinversegammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_node_len(s : StatsdistinversegammaNode) -> Int { s.size }

pub fn stats_dist_inverse_gamma_node_get(s : StatsdistinversegammaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_node_set(s : StatsdistinversegammaNode, i : Int, v : Double) -> StatsdistinversegammaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_node_sum(s : StatsdistinversegammaNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_node_mean(s : StatsdistinversegammaNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_node_scale(s : StatsdistinversegammaNode, f : Double) -> StatsdistinversegammaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_node_add(a : StatsdistinversegammaNode, b : StatsdistinversegammaNode) -> StatsdistinversegammaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_node_copy(s : StatsdistinversegammaNode) -> StatsdistinversegammaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_node_fill(s : StatsdistinversegammaNode, v : Double) -> StatsdistinversegammaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_node_min(s : StatsdistinversegammaNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_node_max(s : StatsdistinversegammaNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_node_to_string(s : StatsdistinversegammaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_edge_make(size : Int) -> StatsdistinversegammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_edge_len(s : StatsdistinversegammaEdge) -> Int { s.size }

pub fn stats_dist_inverse_gamma_edge_get(s : StatsdistinversegammaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_edge_set(s : StatsdistinversegammaEdge, i : Int, v : Double) -> StatsdistinversegammaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_edge_sum(s : StatsdistinversegammaEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_edge_mean(s : StatsdistinversegammaEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_edge_scale(s : StatsdistinversegammaEdge, f : Double) -> StatsdistinversegammaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_edge_add(a : StatsdistinversegammaEdge, b : StatsdistinversegammaEdge) -> StatsdistinversegammaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_edge_copy(s : StatsdistinversegammaEdge) -> StatsdistinversegammaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_edge_fill(s : StatsdistinversegammaEdge, v : Double) -> StatsdistinversegammaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_edge_min(s : StatsdistinversegammaEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_edge_max(s : StatsdistinversegammaEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_edge_to_string(s : StatsdistinversegammaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_path_make(size : Int) -> StatsdistinversegammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_path_len(s : StatsdistinversegammaPath) -> Int { s.size }

pub fn stats_dist_inverse_gamma_path_get(s : StatsdistinversegammaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_path_set(s : StatsdistinversegammaPath, i : Int, v : Double) -> StatsdistinversegammaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_path_sum(s : StatsdistinversegammaPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_path_mean(s : StatsdistinversegammaPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_path_scale(s : StatsdistinversegammaPath, f : Double) -> StatsdistinversegammaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_path_add(a : StatsdistinversegammaPath, b : StatsdistinversegammaPath) -> StatsdistinversegammaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_path_copy(s : StatsdistinversegammaPath) -> StatsdistinversegammaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_path_fill(s : StatsdistinversegammaPath, v : Double) -> StatsdistinversegammaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_path_min(s : StatsdistinversegammaPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_path_max(s : StatsdistinversegammaPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_path_to_string(s : StatsdistinversegammaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_cluster_make(size : Int) -> StatsdistinversegammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_cluster_len(s : StatsdistinversegammaCluster) -> Int { s.size }

pub fn stats_dist_inverse_gamma_cluster_get(s : StatsdistinversegammaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_cluster_set(s : StatsdistinversegammaCluster, i : Int, v : Double) -> StatsdistinversegammaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cluster_sum(s : StatsdistinversegammaCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_cluster_mean(s : StatsdistinversegammaCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_cluster_scale(s : StatsdistinversegammaCluster, f : Double) -> StatsdistinversegammaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cluster_add(a : StatsdistinversegammaCluster, b : StatsdistinversegammaCluster) -> StatsdistinversegammaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_cluster_copy(s : StatsdistinversegammaCluster) -> StatsdistinversegammaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cluster_fill(s : StatsdistinversegammaCluster, v : Double) -> StatsdistinversegammaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cluster_min(s : StatsdistinversegammaCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_cluster_max(s : StatsdistinversegammaCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_cluster_to_string(s : StatsdistinversegammaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_model_make(size : Int) -> StatsdistinversegammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_model_len(s : StatsdistinversegammaModel) -> Int { s.size }

pub fn stats_dist_inverse_gamma_model_get(s : StatsdistinversegammaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_model_set(s : StatsdistinversegammaModel, i : Int, v : Double) -> StatsdistinversegammaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_model_sum(s : StatsdistinversegammaModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_model_mean(s : StatsdistinversegammaModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_model_scale(s : StatsdistinversegammaModel, f : Double) -> StatsdistinversegammaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_model_add(a : StatsdistinversegammaModel, b : StatsdistinversegammaModel) -> StatsdistinversegammaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_model_copy(s : StatsdistinversegammaModel) -> StatsdistinversegammaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_model_fill(s : StatsdistinversegammaModel, v : Double) -> StatsdistinversegammaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_model_min(s : StatsdistinversegammaModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_model_max(s : StatsdistinversegammaModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_model_to_string(s : StatsdistinversegammaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_layer_make(size : Int) -> StatsdistinversegammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_layer_len(s : StatsdistinversegammaLayer) -> Int { s.size }

pub fn stats_dist_inverse_gamma_layer_get(s : StatsdistinversegammaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_layer_set(s : StatsdistinversegammaLayer, i : Int, v : Double) -> StatsdistinversegammaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_layer_sum(s : StatsdistinversegammaLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_layer_mean(s : StatsdistinversegammaLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_layer_scale(s : StatsdistinversegammaLayer, f : Double) -> StatsdistinversegammaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_layer_add(a : StatsdistinversegammaLayer, b : StatsdistinversegammaLayer) -> StatsdistinversegammaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_layer_copy(s : StatsdistinversegammaLayer) -> StatsdistinversegammaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_layer_fill(s : StatsdistinversegammaLayer, v : Double) -> StatsdistinversegammaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_layer_min(s : StatsdistinversegammaLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_layer_max(s : StatsdistinversegammaLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_layer_to_string(s : StatsdistinversegammaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_buffer_make(size : Int) -> StatsdistinversegammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_buffer_len(s : StatsdistinversegammaBuffer) -> Int { s.size }

pub fn stats_dist_inverse_gamma_buffer_get(s : StatsdistinversegammaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_buffer_set(s : StatsdistinversegammaBuffer, i : Int, v : Double) -> StatsdistinversegammaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_buffer_sum(s : StatsdistinversegammaBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_buffer_mean(s : StatsdistinversegammaBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_buffer_scale(s : StatsdistinversegammaBuffer, f : Double) -> StatsdistinversegammaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_buffer_add(a : StatsdistinversegammaBuffer, b : StatsdistinversegammaBuffer) -> StatsdistinversegammaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_buffer_copy(s : StatsdistinversegammaBuffer) -> StatsdistinversegammaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_buffer_fill(s : StatsdistinversegammaBuffer, v : Double) -> StatsdistinversegammaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_buffer_min(s : StatsdistinversegammaBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_buffer_max(s : StatsdistinversegammaBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_buffer_to_string(s : StatsdistinversegammaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_cursor_make(size : Int) -> StatsdistinversegammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_cursor_len(s : StatsdistinversegammaCursor) -> Int { s.size }

pub fn stats_dist_inverse_gamma_cursor_get(s : StatsdistinversegammaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_cursor_set(s : StatsdistinversegammaCursor, i : Int, v : Double) -> StatsdistinversegammaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cursor_sum(s : StatsdistinversegammaCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_cursor_mean(s : StatsdistinversegammaCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_cursor_scale(s : StatsdistinversegammaCursor, f : Double) -> StatsdistinversegammaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cursor_add(a : StatsdistinversegammaCursor, b : StatsdistinversegammaCursor) -> StatsdistinversegammaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_cursor_copy(s : StatsdistinversegammaCursor) -> StatsdistinversegammaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cursor_fill(s : StatsdistinversegammaCursor, v : Double) -> StatsdistinversegammaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_cursor_min(s : StatsdistinversegammaCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_cursor_max(s : StatsdistinversegammaCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_cursor_to_string(s : StatsdistinversegammaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_view_make(size : Int) -> StatsdistinversegammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_view_len(s : StatsdistinversegammaView) -> Int { s.size }

pub fn stats_dist_inverse_gamma_view_get(s : StatsdistinversegammaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_view_set(s : StatsdistinversegammaView, i : Int, v : Double) -> StatsdistinversegammaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_view_sum(s : StatsdistinversegammaView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_view_mean(s : StatsdistinversegammaView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_view_scale(s : StatsdistinversegammaView, f : Double) -> StatsdistinversegammaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_view_add(a : StatsdistinversegammaView, b : StatsdistinversegammaView) -> StatsdistinversegammaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_view_copy(s : StatsdistinversegammaView) -> StatsdistinversegammaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_view_fill(s : StatsdistinversegammaView, v : Double) -> StatsdistinversegammaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_view_min(s : StatsdistinversegammaView) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_view_max(s : StatsdistinversegammaView) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_view_to_string(s : StatsdistinversegammaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_range_make(size : Int) -> StatsdistinversegammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_range_len(s : StatsdistinversegammaRange) -> Int { s.size }

pub fn stats_dist_inverse_gamma_range_get(s : StatsdistinversegammaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_range_set(s : StatsdistinversegammaRange, i : Int, v : Double) -> StatsdistinversegammaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_range_sum(s : StatsdistinversegammaRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_range_mean(s : StatsdistinversegammaRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_range_scale(s : StatsdistinversegammaRange, f : Double) -> StatsdistinversegammaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_range_add(a : StatsdistinversegammaRange, b : StatsdistinversegammaRange) -> StatsdistinversegammaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_range_copy(s : StatsdistinversegammaRange) -> StatsdistinversegammaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_range_fill(s : StatsdistinversegammaRange, v : Double) -> StatsdistinversegammaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_range_min(s : StatsdistinversegammaRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_range_max(s : StatsdistinversegammaRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_range_to_string(s : StatsdistinversegammaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_slice_make(size : Int) -> StatsdistinversegammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_slice_len(s : StatsdistinversegammaSlice) -> Int { s.size }

pub fn stats_dist_inverse_gamma_slice_get(s : StatsdistinversegammaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_slice_set(s : StatsdistinversegammaSlice, i : Int, v : Double) -> StatsdistinversegammaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_slice_sum(s : StatsdistinversegammaSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_inverse_gamma_slice_mean(s : StatsdistinversegammaSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_inverse_gamma_slice_scale(s : StatsdistinversegammaSlice, f : Double) -> StatsdistinversegammaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_slice_add(a : StatsdistinversegammaSlice, b : StatsdistinversegammaSlice) -> StatsdistinversegammaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_inverse_gamma_slice_copy(s : StatsdistinversegammaSlice) -> StatsdistinversegammaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_slice_fill(s : StatsdistinversegammaSlice, v : Double) -> StatsdistinversegammaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_inverse_gamma_slice_min(s : StatsdistinversegammaSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_inverse_gamma_slice_max(s : StatsdistinversegammaSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_inverse_gamma_slice_to_string(s : StatsdistinversegammaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

