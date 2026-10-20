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

pub fn StatsdistdirichletFrame::len(self : StatsdistdirichletFrame) -> Int { self.size }

pub fn StatsdistdirichletFrame::get(self : StatsdistdirichletFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletFrame::set(self : StatsdistdirichletFrame, i : Int, v : Double) -> StatsdistdirichletFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletFrame::sum(self : StatsdistdirichletFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletFrame::mean(self : StatsdistdirichletFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletFrame::scale(self : StatsdistdirichletFrame, f : Double) -> StatsdistdirichletFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletFrame::add(self : StatsdistdirichletFrame, other : StatsdistdirichletFrame) -> StatsdistdirichletFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletFrame::copy(self : StatsdistdirichletFrame) -> StatsdistdirichletFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletFrame::fill(self : StatsdistdirichletFrame, v : Double) -> StatsdistdirichletFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletFrame::min(self : StatsdistdirichletFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletFrame::max(self : StatsdistdirichletFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletFrame::to_string(self : StatsdistdirichletFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_table_make(size : Int) -> StatsdistdirichletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletTable::len(self : StatsdistdirichletTable) -> Int { self.size }

pub fn StatsdistdirichletTable::get(self : StatsdistdirichletTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletTable::set(self : StatsdistdirichletTable, i : Int, v : Double) -> StatsdistdirichletTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletTable::sum(self : StatsdistdirichletTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletTable::mean(self : StatsdistdirichletTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletTable::scale(self : StatsdistdirichletTable, f : Double) -> StatsdistdirichletTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletTable::add(self : StatsdistdirichletTable, other : StatsdistdirichletTable) -> StatsdistdirichletTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletTable::copy(self : StatsdistdirichletTable) -> StatsdistdirichletTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletTable::fill(self : StatsdistdirichletTable, v : Double) -> StatsdistdirichletTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletTable::min(self : StatsdistdirichletTable) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletTable::max(self : StatsdistdirichletTable) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletTable::to_string(self : StatsdistdirichletTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_graphn_make(size : Int) -> StatsdistdirichletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletGraphN::len(self : StatsdistdirichletGraphN) -> Int { self.size }

pub fn StatsdistdirichletGraphN::get(self : StatsdistdirichletGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletGraphN::set(self : StatsdistdirichletGraphN, i : Int, v : Double) -> StatsdistdirichletGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletGraphN::sum(self : StatsdistdirichletGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletGraphN::mean(self : StatsdistdirichletGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletGraphN::scale(self : StatsdistdirichletGraphN, f : Double) -> StatsdistdirichletGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletGraphN::add(self : StatsdistdirichletGraphN, other : StatsdistdirichletGraphN) -> StatsdistdirichletGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletGraphN::copy(self : StatsdistdirichletGraphN) -> StatsdistdirichletGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletGraphN::fill(self : StatsdistdirichletGraphN, v : Double) -> StatsdistdirichletGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletGraphN::min(self : StatsdistdirichletGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletGraphN::max(self : StatsdistdirichletGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletGraphN::to_string(self : StatsdistdirichletGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_node_make(size : Int) -> StatsdistdirichletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletNode::len(self : StatsdistdirichletNode) -> Int { self.size }

pub fn StatsdistdirichletNode::get(self : StatsdistdirichletNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletNode::set(self : StatsdistdirichletNode, i : Int, v : Double) -> StatsdistdirichletNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletNode::sum(self : StatsdistdirichletNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletNode::mean(self : StatsdistdirichletNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletNode::scale(self : StatsdistdirichletNode, f : Double) -> StatsdistdirichletNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletNode::add(self : StatsdistdirichletNode, other : StatsdistdirichletNode) -> StatsdistdirichletNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletNode::copy(self : StatsdistdirichletNode) -> StatsdistdirichletNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletNode::fill(self : StatsdistdirichletNode, v : Double) -> StatsdistdirichletNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletNode::min(self : StatsdistdirichletNode) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletNode::max(self : StatsdistdirichletNode) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletNode::to_string(self : StatsdistdirichletNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_edge_make(size : Int) -> StatsdistdirichletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletEdge::len(self : StatsdistdirichletEdge) -> Int { self.size }

pub fn StatsdistdirichletEdge::get(self : StatsdistdirichletEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletEdge::set(self : StatsdistdirichletEdge, i : Int, v : Double) -> StatsdistdirichletEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletEdge::sum(self : StatsdistdirichletEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletEdge::mean(self : StatsdistdirichletEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletEdge::scale(self : StatsdistdirichletEdge, f : Double) -> StatsdistdirichletEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletEdge::add(self : StatsdistdirichletEdge, other : StatsdistdirichletEdge) -> StatsdistdirichletEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletEdge::copy(self : StatsdistdirichletEdge) -> StatsdistdirichletEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletEdge::fill(self : StatsdistdirichletEdge, v : Double) -> StatsdistdirichletEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletEdge::min(self : StatsdistdirichletEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletEdge::max(self : StatsdistdirichletEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletEdge::to_string(self : StatsdistdirichletEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_path_make(size : Int) -> StatsdistdirichletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletPath::len(self : StatsdistdirichletPath) -> Int { self.size }

pub fn StatsdistdirichletPath::get(self : StatsdistdirichletPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletPath::set(self : StatsdistdirichletPath, i : Int, v : Double) -> StatsdistdirichletPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletPath::sum(self : StatsdistdirichletPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletPath::mean(self : StatsdistdirichletPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletPath::scale(self : StatsdistdirichletPath, f : Double) -> StatsdistdirichletPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletPath::add(self : StatsdistdirichletPath, other : StatsdistdirichletPath) -> StatsdistdirichletPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletPath::copy(self : StatsdistdirichletPath) -> StatsdistdirichletPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletPath::fill(self : StatsdistdirichletPath, v : Double) -> StatsdistdirichletPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletPath::min(self : StatsdistdirichletPath) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletPath::max(self : StatsdistdirichletPath) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletPath::to_string(self : StatsdistdirichletPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_cluster_make(size : Int) -> StatsdistdirichletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletCluster::len(self : StatsdistdirichletCluster) -> Int { self.size }

pub fn StatsdistdirichletCluster::get(self : StatsdistdirichletCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletCluster::set(self : StatsdistdirichletCluster, i : Int, v : Double) -> StatsdistdirichletCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCluster::sum(self : StatsdistdirichletCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletCluster::mean(self : StatsdistdirichletCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletCluster::scale(self : StatsdistdirichletCluster, f : Double) -> StatsdistdirichletCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCluster::add(self : StatsdistdirichletCluster, other : StatsdistdirichletCluster) -> StatsdistdirichletCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletCluster::copy(self : StatsdistdirichletCluster) -> StatsdistdirichletCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCluster::fill(self : StatsdistdirichletCluster, v : Double) -> StatsdistdirichletCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCluster::min(self : StatsdistdirichletCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletCluster::max(self : StatsdistdirichletCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletCluster::to_string(self : StatsdistdirichletCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_model_make(size : Int) -> StatsdistdirichletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletModel::len(self : StatsdistdirichletModel) -> Int { self.size }

pub fn StatsdistdirichletModel::get(self : StatsdistdirichletModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletModel::set(self : StatsdistdirichletModel, i : Int, v : Double) -> StatsdistdirichletModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletModel::sum(self : StatsdistdirichletModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletModel::mean(self : StatsdistdirichletModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletModel::scale(self : StatsdistdirichletModel, f : Double) -> StatsdistdirichletModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletModel::add(self : StatsdistdirichletModel, other : StatsdistdirichletModel) -> StatsdistdirichletModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletModel::copy(self : StatsdistdirichletModel) -> StatsdistdirichletModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletModel::fill(self : StatsdistdirichletModel, v : Double) -> StatsdistdirichletModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletModel::min(self : StatsdistdirichletModel) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletModel::max(self : StatsdistdirichletModel) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletModel::to_string(self : StatsdistdirichletModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_layer_make(size : Int) -> StatsdistdirichletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletLayer::len(self : StatsdistdirichletLayer) -> Int { self.size }

pub fn StatsdistdirichletLayer::get(self : StatsdistdirichletLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletLayer::set(self : StatsdistdirichletLayer, i : Int, v : Double) -> StatsdistdirichletLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletLayer::sum(self : StatsdistdirichletLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletLayer::mean(self : StatsdistdirichletLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletLayer::scale(self : StatsdistdirichletLayer, f : Double) -> StatsdistdirichletLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletLayer::add(self : StatsdistdirichletLayer, other : StatsdistdirichletLayer) -> StatsdistdirichletLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletLayer::copy(self : StatsdistdirichletLayer) -> StatsdistdirichletLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletLayer::fill(self : StatsdistdirichletLayer, v : Double) -> StatsdistdirichletLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletLayer::min(self : StatsdistdirichletLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletLayer::max(self : StatsdistdirichletLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletLayer::to_string(self : StatsdistdirichletLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_buffer_make(size : Int) -> StatsdistdirichletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletBuffer::len(self : StatsdistdirichletBuffer) -> Int { self.size }

pub fn StatsdistdirichletBuffer::get(self : StatsdistdirichletBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletBuffer::set(self : StatsdistdirichletBuffer, i : Int, v : Double) -> StatsdistdirichletBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletBuffer::sum(self : StatsdistdirichletBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletBuffer::mean(self : StatsdistdirichletBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletBuffer::scale(self : StatsdistdirichletBuffer, f : Double) -> StatsdistdirichletBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletBuffer::add(self : StatsdistdirichletBuffer, other : StatsdistdirichletBuffer) -> StatsdistdirichletBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletBuffer::copy(self : StatsdistdirichletBuffer) -> StatsdistdirichletBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletBuffer::fill(self : StatsdistdirichletBuffer, v : Double) -> StatsdistdirichletBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletBuffer::min(self : StatsdistdirichletBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletBuffer::max(self : StatsdistdirichletBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletBuffer::to_string(self : StatsdistdirichletBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_cursor_make(size : Int) -> StatsdistdirichletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletCursor::len(self : StatsdistdirichletCursor) -> Int { self.size }

pub fn StatsdistdirichletCursor::get(self : StatsdistdirichletCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletCursor::set(self : StatsdistdirichletCursor, i : Int, v : Double) -> StatsdistdirichletCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCursor::sum(self : StatsdistdirichletCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletCursor::mean(self : StatsdistdirichletCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletCursor::scale(self : StatsdistdirichletCursor, f : Double) -> StatsdistdirichletCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCursor::add(self : StatsdistdirichletCursor, other : StatsdistdirichletCursor) -> StatsdistdirichletCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletCursor::copy(self : StatsdistdirichletCursor) -> StatsdistdirichletCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCursor::fill(self : StatsdistdirichletCursor, v : Double) -> StatsdistdirichletCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletCursor::min(self : StatsdistdirichletCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletCursor::max(self : StatsdistdirichletCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletCursor::to_string(self : StatsdistdirichletCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_view_make(size : Int) -> StatsdistdirichletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletView::len(self : StatsdistdirichletView) -> Int { self.size }

pub fn StatsdistdirichletView::get(self : StatsdistdirichletView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletView::set(self : StatsdistdirichletView, i : Int, v : Double) -> StatsdistdirichletView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletView::sum(self : StatsdistdirichletView) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletView::mean(self : StatsdistdirichletView) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletView::scale(self : StatsdistdirichletView, f : Double) -> StatsdistdirichletView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletView::add(self : StatsdistdirichletView, other : StatsdistdirichletView) -> StatsdistdirichletView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletView::copy(self : StatsdistdirichletView) -> StatsdistdirichletView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletView::fill(self : StatsdistdirichletView, v : Double) -> StatsdistdirichletView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletView::min(self : StatsdistdirichletView) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletView::max(self : StatsdistdirichletView) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletView::to_string(self : StatsdistdirichletView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_range_make(size : Int) -> StatsdistdirichletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletRange::len(self : StatsdistdirichletRange) -> Int { self.size }

pub fn StatsdistdirichletRange::get(self : StatsdistdirichletRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletRange::set(self : StatsdistdirichletRange, i : Int, v : Double) -> StatsdistdirichletRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletRange::sum(self : StatsdistdirichletRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletRange::mean(self : StatsdistdirichletRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletRange::scale(self : StatsdistdirichletRange, f : Double) -> StatsdistdirichletRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletRange::add(self : StatsdistdirichletRange, other : StatsdistdirichletRange) -> StatsdistdirichletRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletRange::copy(self : StatsdistdirichletRange) -> StatsdistdirichletRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletRange::fill(self : StatsdistdirichletRange, v : Double) -> StatsdistdirichletRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletRange::min(self : StatsdistdirichletRange) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletRange::max(self : StatsdistdirichletRange) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletRange::to_string(self : StatsdistdirichletRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistdirichletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_dirichlet_slice_make(size : Int) -> StatsdistdirichletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistdirichletSlice::len(self : StatsdistdirichletSlice) -> Int { self.size }

pub fn StatsdistdirichletSlice::get(self : StatsdistdirichletSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistdirichletSlice::set(self : StatsdistdirichletSlice, i : Int, v : Double) -> StatsdistdirichletSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletSlice::sum(self : StatsdistdirichletSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistdirichletSlice::mean(self : StatsdistdirichletSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistdirichletSlice::scale(self : StatsdistdirichletSlice, f : Double) -> StatsdistdirichletSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletSlice::add(self : StatsdistdirichletSlice, other : StatsdistdirichletSlice) -> StatsdistdirichletSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistdirichletSlice::copy(self : StatsdistdirichletSlice) -> StatsdistdirichletSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletSlice::fill(self : StatsdistdirichletSlice, v : Double) -> StatsdistdirichletSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistdirichletSlice::min(self : StatsdistdirichletSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistdirichletSlice::max(self : StatsdistdirichletSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistdirichletSlice::to_string(self : StatsdistdirichletSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

