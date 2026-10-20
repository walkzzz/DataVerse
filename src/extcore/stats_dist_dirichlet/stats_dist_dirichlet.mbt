///===
/// extcore/stats_dist_dirichlet

pub(all) struct StatsdistdirichletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_dirichlet_make_point(x : Double, y : Double) -> StatsdistdirichletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_dirichlet_make_point3(x : Double, y : Double, z : Double) -> StatsdistdirichletPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistdirichletPoint::x(self : StatsdistdirichletPoint) -> Double { self.x }

pub fn StatsdistdirichletPoint::y(self : StatsdistdirichletPoint) -> Double { self.y }

pub fn StatsdistdirichletPoint::z(self : StatsdistdirichletPoint) -> Double { self.z }

pub fn StatsdistdirichletPoint::label(self : StatsdistdirichletPoint) -> Int { self.label }

pub fn StatsdistdirichletPoint::dist(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistdirichletPoint::add(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistdirichletPoint::sub(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistdirichletPoint::scale(self : StatsdistdirichletPoint, s : Double) -> StatsdistdirichletPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistdirichletPoint::dot(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistdirichletPoint::cross(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistdirichletPoint::norm(self : StatsdistdirichletPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistdirichletPoint::normalize(self : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistdirichletPoint::negate(self : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistdirichletPoint::mid(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint) -> StatsdistdirichletPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistdirichletPoint::lerp(self : StatsdistdirichletPoint, other : StatsdistdirichletPoint, t : Double) -> StatsdistdirichletPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistdirichletPoint::to_string(self : StatsdistdirichletPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistdirichletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_dirichlet_make_series(vals : Array[Double], name : String) -> StatsdistdirichletSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistdirichletSeries::len(self : StatsdistdirichletSeries) -> Int { self.vals.length() }

pub fn StatsdistdirichletSeries::sum(self : StatsdistdirichletSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistdirichletSeries::mean(self : StatsdistdirichletSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistdirichletSeries::min(self : StatsdistdirichletSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistdirichletSeries::max(self : StatsdistdirichletSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistdirichletSeries::range(self : StatsdistdirichletSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistdirichletSeries::variance(self : StatsdistdirichletSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistdirichletSeries::std(self : StatsdistdirichletSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistdirichletSeries::median(self : StatsdistdirichletSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistdirichletSeries::scale(self : StatsdistdirichletSeries, f : Double) -> StatsdistdirichletSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistdirichletSeries::add(self : StatsdistdirichletSeries, other : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistdirichletSeries::sub(self : StatsdistdirichletSeries, other : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistdirichletSeries::normalize(self : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistdirichletSeries::cumsum(self : StatsdistdirichletSeries) -> StatsdistdirichletSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistdirichletSeries::to_string(self : StatsdistdirichletSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistdirichletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_dirichlet_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistdirichletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_dirichlet_matrix_identity(n : Int) -> StatsdistdirichletMatrix {
  let m = stats_dist_dirichlet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistdirichletMatrix::get(self : StatsdistdirichletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistdirichletMatrix::transpose(self : StatsdistdirichletMatrix) -> StatsdistdirichletMatrix {
  let result = stats_dist_dirichlet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistdirichletMatrix::add(self : StatsdistdirichletMatrix, other : StatsdistdirichletMatrix) -> StatsdistdirichletMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_dirichlet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistdirichletMatrix::scale(self : StatsdistdirichletMatrix, s : Double) -> StatsdistdirichletMatrix {
  let result = stats_dist_dirichlet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistdirichletMatrix::multiply(self : StatsdistdirichletMatrix, other : StatsdistdirichletMatrix) -> StatsdistdirichletMatrix {
  if self.cols != other.rows { return stats_dist_dirichlet_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_dirichlet_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistdirichletMatrix::trace(self : StatsdistdirichletMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistdirichletMatrix::det(self : StatsdistdirichletMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistdirichletMatrix::norm(self : StatsdistdirichletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistdirichletMatrix::to_string(self : StatsdistdirichletMatrix) -> String {
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

pub(all) struct StatsdistdirichletVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_dirichlet_make_vector(comps : Array[Double]) -> StatsdistdirichletVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_dirichlet_vector_zero(dim : Int) -> StatsdistdirichletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistdirichletVector::add(self : StatsdistdirichletVector, other : StatsdistdirichletVector) -> StatsdistdirichletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistdirichletVector::sub(self : StatsdistdirichletVector, other : StatsdistdirichletVector) -> StatsdistdirichletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistdirichletVector::scale(self : StatsdistdirichletVector, s : Double) -> StatsdistdirichletVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistdirichletVector::dot(self : StatsdistdirichletVector, other : StatsdistdirichletVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistdirichletVector::norm(self : StatsdistdirichletVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistdirichletVector::normalize(self : StatsdistdirichletVector) -> StatsdistdirichletVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistdirichletVector::dist(self : StatsdistdirichletVector, other : StatsdistdirichletVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistdirichletVector::to_string(self : StatsdistdirichletVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_dirichlet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_dirichlet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_dirichlet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_dirichlet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_dirichlet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_dirichlet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_dirichlet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_dirichlet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_dirichlet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_dirichlet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_dirichlet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_dirichlet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_dirichlet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_dirichlet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_dirichlet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_dirichlet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_dirichlet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_dirichlet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_dirichlet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_dirichlet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_dirichlet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_dirichlet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_dirichlet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_dirichlet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_dirichlet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_dirichlet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_dirichlet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_dirichlet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_dirichlet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistdirichletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_frame_make(size : Int) -> StatsdistdirichletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_frame_len(s : StatsdistdirichletFrame) -> Int { s.size }

pub fn stats_dist_dirichlet_frame_get(s : StatsdistdirichletFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_frame_set(s : StatsdistdirichletFrame, i : Int, v : Double) -> StatsdistdirichletFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_sum(s : StatsdistdirichletFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_frame_mean(s : StatsdistdirichletFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_frame_scale(s : StatsdistdirichletFrame, f : Double) -> StatsdistdirichletFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_add(a : StatsdistdirichletFrame, b : StatsdistdirichletFrame) -> StatsdistdirichletFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_frame_copy(s : StatsdistdirichletFrame) -> StatsdistdirichletFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_fill(s : StatsdistdirichletFrame, v : Double) -> StatsdistdirichletFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_frame_min(s : StatsdistdirichletFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_frame_max(s : StatsdistdirichletFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_frame_to_string(s : StatsdistdirichletFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_table_make(size : Int) -> StatsdistdirichletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_table_len(s : StatsdistdirichletTable) -> Int { s.size }

pub fn stats_dist_dirichlet_table_get(s : StatsdistdirichletTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_table_set(s : StatsdistdirichletTable, i : Int, v : Double) -> StatsdistdirichletTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_sum(s : StatsdistdirichletTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_table_mean(s : StatsdistdirichletTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_table_scale(s : StatsdistdirichletTable, f : Double) -> StatsdistdirichletTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_add(a : StatsdistdirichletTable, b : StatsdistdirichletTable) -> StatsdistdirichletTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_table_copy(s : StatsdistdirichletTable) -> StatsdistdirichletTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_fill(s : StatsdistdirichletTable, v : Double) -> StatsdistdirichletTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_table_min(s : StatsdistdirichletTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_table_max(s : StatsdistdirichletTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_table_to_string(s : StatsdistdirichletTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_graphn_make(size : Int) -> StatsdistdirichletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_graphn_len(s : StatsdistdirichletGraphN) -> Int { s.size }

pub fn stats_dist_dirichlet_graphn_get(s : StatsdistdirichletGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_graphn_set(s : StatsdistdirichletGraphN, i : Int, v : Double) -> StatsdistdirichletGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_sum(s : StatsdistdirichletGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_graphn_mean(s : StatsdistdirichletGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_graphn_scale(s : StatsdistdirichletGraphN, f : Double) -> StatsdistdirichletGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_add(a : StatsdistdirichletGraphN, b : StatsdistdirichletGraphN) -> StatsdistdirichletGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_graphn_copy(s : StatsdistdirichletGraphN) -> StatsdistdirichletGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_fill(s : StatsdistdirichletGraphN, v : Double) -> StatsdistdirichletGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_graphn_min(s : StatsdistdirichletGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_graphn_max(s : StatsdistdirichletGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_graphn_to_string(s : StatsdistdirichletGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_node_make(size : Int) -> StatsdistdirichletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_node_len(s : StatsdistdirichletNode) -> Int { s.size }

pub fn stats_dist_dirichlet_node_get(s : StatsdistdirichletNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_node_set(s : StatsdistdirichletNode, i : Int, v : Double) -> StatsdistdirichletNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_sum(s : StatsdistdirichletNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_node_mean(s : StatsdistdirichletNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_node_scale(s : StatsdistdirichletNode, f : Double) -> StatsdistdirichletNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_add(a : StatsdistdirichletNode, b : StatsdistdirichletNode) -> StatsdistdirichletNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_node_copy(s : StatsdistdirichletNode) -> StatsdistdirichletNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_fill(s : StatsdistdirichletNode, v : Double) -> StatsdistdirichletNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_node_min(s : StatsdistdirichletNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_node_max(s : StatsdistdirichletNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_node_to_string(s : StatsdistdirichletNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_edge_make(size : Int) -> StatsdistdirichletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_edge_len(s : StatsdistdirichletEdge) -> Int { s.size }

pub fn stats_dist_dirichlet_edge_get(s : StatsdistdirichletEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_edge_set(s : StatsdistdirichletEdge, i : Int, v : Double) -> StatsdistdirichletEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_sum(s : StatsdistdirichletEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_edge_mean(s : StatsdistdirichletEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_edge_scale(s : StatsdistdirichletEdge, f : Double) -> StatsdistdirichletEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_add(a : StatsdistdirichletEdge, b : StatsdistdirichletEdge) -> StatsdistdirichletEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_edge_copy(s : StatsdistdirichletEdge) -> StatsdistdirichletEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_fill(s : StatsdistdirichletEdge, v : Double) -> StatsdistdirichletEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_edge_min(s : StatsdistdirichletEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_edge_max(s : StatsdistdirichletEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_edge_to_string(s : StatsdistdirichletEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_path_make(size : Int) -> StatsdistdirichletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_path_len(s : StatsdistdirichletPath) -> Int { s.size }

pub fn stats_dist_dirichlet_path_get(s : StatsdistdirichletPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_path_set(s : StatsdistdirichletPath, i : Int, v : Double) -> StatsdistdirichletPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_sum(s : StatsdistdirichletPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_path_mean(s : StatsdistdirichletPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_path_scale(s : StatsdistdirichletPath, f : Double) -> StatsdistdirichletPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_add(a : StatsdistdirichletPath, b : StatsdistdirichletPath) -> StatsdistdirichletPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_path_copy(s : StatsdistdirichletPath) -> StatsdistdirichletPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_fill(s : StatsdistdirichletPath, v : Double) -> StatsdistdirichletPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_path_min(s : StatsdistdirichletPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_path_max(s : StatsdistdirichletPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_path_to_string(s : StatsdistdirichletPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_cluster_make(size : Int) -> StatsdistdirichletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_cluster_len(s : StatsdistdirichletCluster) -> Int { s.size }

pub fn stats_dist_dirichlet_cluster_get(s : StatsdistdirichletCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_cluster_set(s : StatsdistdirichletCluster, i : Int, v : Double) -> StatsdistdirichletCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_sum(s : StatsdistdirichletCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_cluster_mean(s : StatsdistdirichletCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_cluster_scale(s : StatsdistdirichletCluster, f : Double) -> StatsdistdirichletCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_add(a : StatsdistdirichletCluster, b : StatsdistdirichletCluster) -> StatsdistdirichletCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_cluster_copy(s : StatsdistdirichletCluster) -> StatsdistdirichletCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_fill(s : StatsdistdirichletCluster, v : Double) -> StatsdistdirichletCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cluster_min(s : StatsdistdirichletCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_cluster_max(s : StatsdistdirichletCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_cluster_to_string(s : StatsdistdirichletCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_model_make(size : Int) -> StatsdistdirichletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_model_len(s : StatsdistdirichletModel) -> Int { s.size }

pub fn stats_dist_dirichlet_model_get(s : StatsdistdirichletModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_model_set(s : StatsdistdirichletModel, i : Int, v : Double) -> StatsdistdirichletModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_sum(s : StatsdistdirichletModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_model_mean(s : StatsdistdirichletModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_model_scale(s : StatsdistdirichletModel, f : Double) -> StatsdistdirichletModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_add(a : StatsdistdirichletModel, b : StatsdistdirichletModel) -> StatsdistdirichletModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_model_copy(s : StatsdistdirichletModel) -> StatsdistdirichletModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_fill(s : StatsdistdirichletModel, v : Double) -> StatsdistdirichletModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_model_min(s : StatsdistdirichletModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_model_max(s : StatsdistdirichletModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_model_to_string(s : StatsdistdirichletModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_layer_make(size : Int) -> StatsdistdirichletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_layer_len(s : StatsdistdirichletLayer) -> Int { s.size }

pub fn stats_dist_dirichlet_layer_get(s : StatsdistdirichletLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_layer_set(s : StatsdistdirichletLayer, i : Int, v : Double) -> StatsdistdirichletLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_sum(s : StatsdistdirichletLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_layer_mean(s : StatsdistdirichletLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_layer_scale(s : StatsdistdirichletLayer, f : Double) -> StatsdistdirichletLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_add(a : StatsdistdirichletLayer, b : StatsdistdirichletLayer) -> StatsdistdirichletLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_layer_copy(s : StatsdistdirichletLayer) -> StatsdistdirichletLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_fill(s : StatsdistdirichletLayer, v : Double) -> StatsdistdirichletLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_layer_min(s : StatsdistdirichletLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_layer_max(s : StatsdistdirichletLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_layer_to_string(s : StatsdistdirichletLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_buffer_make(size : Int) -> StatsdistdirichletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_buffer_len(s : StatsdistdirichletBuffer) -> Int { s.size }

pub fn stats_dist_dirichlet_buffer_get(s : StatsdistdirichletBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_buffer_set(s : StatsdistdirichletBuffer, i : Int, v : Double) -> StatsdistdirichletBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_sum(s : StatsdistdirichletBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_buffer_mean(s : StatsdistdirichletBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_buffer_scale(s : StatsdistdirichletBuffer, f : Double) -> StatsdistdirichletBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_add(a : StatsdistdirichletBuffer, b : StatsdistdirichletBuffer) -> StatsdistdirichletBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_buffer_copy(s : StatsdistdirichletBuffer) -> StatsdistdirichletBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_fill(s : StatsdistdirichletBuffer, v : Double) -> StatsdistdirichletBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_buffer_min(s : StatsdistdirichletBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_buffer_max(s : StatsdistdirichletBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_buffer_to_string(s : StatsdistdirichletBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_cursor_make(size : Int) -> StatsdistdirichletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_cursor_len(s : StatsdistdirichletCursor) -> Int { s.size }

pub fn stats_dist_dirichlet_cursor_get(s : StatsdistdirichletCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_cursor_set(s : StatsdistdirichletCursor, i : Int, v : Double) -> StatsdistdirichletCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_sum(s : StatsdistdirichletCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_cursor_mean(s : StatsdistdirichletCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_cursor_scale(s : StatsdistdirichletCursor, f : Double) -> StatsdistdirichletCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_add(a : StatsdistdirichletCursor, b : StatsdistdirichletCursor) -> StatsdistdirichletCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_cursor_copy(s : StatsdistdirichletCursor) -> StatsdistdirichletCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_fill(s : StatsdistdirichletCursor, v : Double) -> StatsdistdirichletCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_cursor_min(s : StatsdistdirichletCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_cursor_max(s : StatsdistdirichletCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_cursor_to_string(s : StatsdistdirichletCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_view_make(size : Int) -> StatsdistdirichletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_view_len(s : StatsdistdirichletView) -> Int { s.size }

pub fn stats_dist_dirichlet_view_get(s : StatsdistdirichletView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_view_set(s : StatsdistdirichletView, i : Int, v : Double) -> StatsdistdirichletView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_sum(s : StatsdistdirichletView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_view_mean(s : StatsdistdirichletView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_view_scale(s : StatsdistdirichletView, f : Double) -> StatsdistdirichletView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_add(a : StatsdistdirichletView, b : StatsdistdirichletView) -> StatsdistdirichletView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_view_copy(s : StatsdistdirichletView) -> StatsdistdirichletView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_fill(s : StatsdistdirichletView, v : Double) -> StatsdistdirichletView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_view_min(s : StatsdistdirichletView) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_view_max(s : StatsdistdirichletView) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_view_to_string(s : StatsdistdirichletView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_range_make(size : Int) -> StatsdistdirichletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_range_len(s : StatsdistdirichletRange) -> Int { s.size }

pub fn stats_dist_dirichlet_range_get(s : StatsdistdirichletRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_range_set(s : StatsdistdirichletRange, i : Int, v : Double) -> StatsdistdirichletRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_sum(s : StatsdistdirichletRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_range_mean(s : StatsdistdirichletRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_range_scale(s : StatsdistdirichletRange, f : Double) -> StatsdistdirichletRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_add(a : StatsdistdirichletRange, b : StatsdistdirichletRange) -> StatsdistdirichletRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_range_copy(s : StatsdistdirichletRange) -> StatsdistdirichletRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_fill(s : StatsdistdirichletRange, v : Double) -> StatsdistdirichletRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_range_min(s : StatsdistdirichletRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_range_max(s : StatsdistdirichletRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_range_to_string(s : StatsdistdirichletRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_slice_make(size : Int) -> StatsdistdirichletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_dirichlet_slice_len(s : StatsdistdirichletSlice) -> Int { s.size }

pub fn stats_dist_dirichlet_slice_get(s : StatsdistdirichletSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_dirichlet_slice_set(s : StatsdistdirichletSlice, i : Int, v : Double) -> StatsdistdirichletSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_sum(s : StatsdistdirichletSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_dirichlet_slice_mean(s : StatsdistdirichletSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_dirichlet_slice_scale(s : StatsdistdirichletSlice, f : Double) -> StatsdistdirichletSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_add(a : StatsdistdirichletSlice, b : StatsdistdirichletSlice) -> StatsdistdirichletSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_dirichlet_slice_copy(s : StatsdistdirichletSlice) -> StatsdistdirichletSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_fill(s : StatsdistdirichletSlice, v : Double) -> StatsdistdirichletSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_dirichlet_slice_min(s : StatsdistdirichletSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_dirichlet_slice_max(s : StatsdistdirichletSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_dirichlet_slice_to_string(s : StatsdistdirichletSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

