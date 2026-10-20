///===
/// extcore/bio_phylo_bayesian

pub(all) struct BiophylobayesianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_bayesian_make_point(x : Double, y : Double) -> BiophylobayesianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_bayesian_make_point3(x : Double, y : Double, z : Double) -> BiophylobayesianPoint {
  { x, y, z, label: 0 }
}

pub fn BiophylobayesianPoint::x(self : BiophylobayesianPoint) -> Double { self.x }

pub fn BiophylobayesianPoint::y(self : BiophylobayesianPoint) -> Double { self.y }

pub fn BiophylobayesianPoint::z(self : BiophylobayesianPoint) -> Double { self.z }

pub fn BiophylobayesianPoint::label(self : BiophylobayesianPoint) -> Int { self.label }

pub fn BiophylobayesianPoint::dist(self : BiophylobayesianPoint, other : BiophylobayesianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylobayesianPoint::add(self : BiophylobayesianPoint, other : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylobayesianPoint::sub(self : BiophylobayesianPoint, other : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylobayesianPoint::scale(self : BiophylobayesianPoint, s : Double) -> BiophylobayesianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylobayesianPoint::dot(self : BiophylobayesianPoint, other : BiophylobayesianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylobayesianPoint::cross(self : BiophylobayesianPoint, other : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylobayesianPoint::norm(self : BiophylobayesianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylobayesianPoint::normalize(self : BiophylobayesianPoint) -> BiophylobayesianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylobayesianPoint::negate(self : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylobayesianPoint::mid(self : BiophylobayesianPoint, other : BiophylobayesianPoint) -> BiophylobayesianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylobayesianPoint::lerp(self : BiophylobayesianPoint, other : BiophylobayesianPoint, t : Double) -> BiophylobayesianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylobayesianPoint::to_string(self : BiophylobayesianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylobayesianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_bayesian_make_series(vals : Array[Double], name : String) -> BiophylobayesianSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylobayesianSeries::len(self : BiophylobayesianSeries) -> Int { self.vals.length() }

pub fn BiophylobayesianSeries::sum(self : BiophylobayesianSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylobayesianSeries::mean(self : BiophylobayesianSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylobayesianSeries::min(self : BiophylobayesianSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylobayesianSeries::max(self : BiophylobayesianSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylobayesianSeries::range(self : BiophylobayesianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylobayesianSeries::variance(self : BiophylobayesianSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylobayesianSeries::std(self : BiophylobayesianSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylobayesianSeries::median(self : BiophylobayesianSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylobayesianSeries::scale(self : BiophylobayesianSeries, f : Double) -> BiophylobayesianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylobayesianSeries::add(self : BiophylobayesianSeries, other : BiophylobayesianSeries) -> BiophylobayesianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylobayesianSeries::sub(self : BiophylobayesianSeries, other : BiophylobayesianSeries) -> BiophylobayesianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylobayesianSeries::normalize(self : BiophylobayesianSeries) -> BiophylobayesianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylobayesianSeries::cumsum(self : BiophylobayesianSeries) -> BiophylobayesianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylobayesianSeries::to_string(self : BiophylobayesianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylobayesianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_bayesian_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylobayesianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_bayesian_matrix_identity(n : Int) -> BiophylobayesianMatrix {
  let m = bio_phylo_bayesian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylobayesianMatrix::get(self : BiophylobayesianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylobayesianMatrix::transpose(self : BiophylobayesianMatrix) -> BiophylobayesianMatrix {
  let result = bio_phylo_bayesian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylobayesianMatrix::add(self : BiophylobayesianMatrix, other : BiophylobayesianMatrix) -> BiophylobayesianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_bayesian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylobayesianMatrix::scale(self : BiophylobayesianMatrix, s : Double) -> BiophylobayesianMatrix {
  let result = bio_phylo_bayesian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylobayesianMatrix::multiply(self : BiophylobayesianMatrix, other : BiophylobayesianMatrix) -> BiophylobayesianMatrix {
  if self.cols != other.rows { return bio_phylo_bayesian_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_bayesian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophylobayesianMatrix::trace(self : BiophylobayesianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylobayesianMatrix::det(self : BiophylobayesianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylobayesianMatrix::norm(self : BiophylobayesianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylobayesianMatrix::to_string(self : BiophylobayesianMatrix) -> String {
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

pub(all) struct BiophylobayesianVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_bayesian_make_vector(comps : Array[Double]) -> BiophylobayesianVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_bayesian_vector_zero(dim : Int) -> BiophylobayesianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylobayesianVector::add(self : BiophylobayesianVector, other : BiophylobayesianVector) -> BiophylobayesianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylobayesianVector::sub(self : BiophylobayesianVector, other : BiophylobayesianVector) -> BiophylobayesianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylobayesianVector::scale(self : BiophylobayesianVector, s : Double) -> BiophylobayesianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylobayesianVector::dot(self : BiophylobayesianVector, other : BiophylobayesianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylobayesianVector::norm(self : BiophylobayesianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylobayesianVector::normalize(self : BiophylobayesianVector) -> BiophylobayesianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylobayesianVector::dist(self : BiophylobayesianVector, other : BiophylobayesianVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylobayesianVector::to_string(self : BiophylobayesianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_bayesian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_bayesian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_bayesian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_bayesian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_bayesian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_bayesian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_bayesian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_bayesian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_bayesian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_bayesian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_bayesian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_bayesian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_bayesian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_bayesian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_bayesian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_bayesian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_bayesian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_bayesian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_bayesian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_bayesian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_bayesian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_bayesian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_bayesian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_bayesian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_bayesian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_bayesian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_bayesian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_bayesian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_bayesian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylobayesianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_frame_make(size : Int) -> BiophylobayesianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_frame_len(s : BiophylobayesianFrame) -> Int { s.size }

pub fn bio_phylo_bayesian_frame_get(s : BiophylobayesianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_frame_set(s : BiophylobayesianFrame, i : Int, v : Double) -> BiophylobayesianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_sum(s : BiophylobayesianFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_frame_mean(s : BiophylobayesianFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_frame_scale(s : BiophylobayesianFrame, f : Double) -> BiophylobayesianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_add(a : BiophylobayesianFrame, b : BiophylobayesianFrame) -> BiophylobayesianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_frame_copy(s : BiophylobayesianFrame) -> BiophylobayesianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_fill(s : BiophylobayesianFrame, v : Double) -> BiophylobayesianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_frame_min(s : BiophylobayesianFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_frame_max(s : BiophylobayesianFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_frame_to_string(s : BiophylobayesianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_table_make(size : Int) -> BiophylobayesianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_table_len(s : BiophylobayesianTable) -> Int { s.size }

pub fn bio_phylo_bayesian_table_get(s : BiophylobayesianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_table_set(s : BiophylobayesianTable, i : Int, v : Double) -> BiophylobayesianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_sum(s : BiophylobayesianTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_table_mean(s : BiophylobayesianTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_table_scale(s : BiophylobayesianTable, f : Double) -> BiophylobayesianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_add(a : BiophylobayesianTable, b : BiophylobayesianTable) -> BiophylobayesianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_table_copy(s : BiophylobayesianTable) -> BiophylobayesianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_fill(s : BiophylobayesianTable, v : Double) -> BiophylobayesianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_table_min(s : BiophylobayesianTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_table_max(s : BiophylobayesianTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_table_to_string(s : BiophylobayesianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_graphn_make(size : Int) -> BiophylobayesianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_graphn_len(s : BiophylobayesianGraphN) -> Int { s.size }

pub fn bio_phylo_bayesian_graphn_get(s : BiophylobayesianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_graphn_set(s : BiophylobayesianGraphN, i : Int, v : Double) -> BiophylobayesianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_sum(s : BiophylobayesianGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_graphn_mean(s : BiophylobayesianGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_graphn_scale(s : BiophylobayesianGraphN, f : Double) -> BiophylobayesianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_add(a : BiophylobayesianGraphN, b : BiophylobayesianGraphN) -> BiophylobayesianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_graphn_copy(s : BiophylobayesianGraphN) -> BiophylobayesianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_fill(s : BiophylobayesianGraphN, v : Double) -> BiophylobayesianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_graphn_min(s : BiophylobayesianGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_graphn_max(s : BiophylobayesianGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_graphn_to_string(s : BiophylobayesianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_node_make(size : Int) -> BiophylobayesianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_node_len(s : BiophylobayesianNode) -> Int { s.size }

pub fn bio_phylo_bayesian_node_get(s : BiophylobayesianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_node_set(s : BiophylobayesianNode, i : Int, v : Double) -> BiophylobayesianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_sum(s : BiophylobayesianNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_node_mean(s : BiophylobayesianNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_node_scale(s : BiophylobayesianNode, f : Double) -> BiophylobayesianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_add(a : BiophylobayesianNode, b : BiophylobayesianNode) -> BiophylobayesianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_node_copy(s : BiophylobayesianNode) -> BiophylobayesianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_fill(s : BiophylobayesianNode, v : Double) -> BiophylobayesianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_node_min(s : BiophylobayesianNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_node_max(s : BiophylobayesianNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_node_to_string(s : BiophylobayesianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_edge_make(size : Int) -> BiophylobayesianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_edge_len(s : BiophylobayesianEdge) -> Int { s.size }

pub fn bio_phylo_bayesian_edge_get(s : BiophylobayesianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_edge_set(s : BiophylobayesianEdge, i : Int, v : Double) -> BiophylobayesianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_sum(s : BiophylobayesianEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_edge_mean(s : BiophylobayesianEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_edge_scale(s : BiophylobayesianEdge, f : Double) -> BiophylobayesianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_add(a : BiophylobayesianEdge, b : BiophylobayesianEdge) -> BiophylobayesianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_edge_copy(s : BiophylobayesianEdge) -> BiophylobayesianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_fill(s : BiophylobayesianEdge, v : Double) -> BiophylobayesianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_edge_min(s : BiophylobayesianEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_edge_max(s : BiophylobayesianEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_edge_to_string(s : BiophylobayesianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_path_make(size : Int) -> BiophylobayesianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_path_len(s : BiophylobayesianPath) -> Int { s.size }

pub fn bio_phylo_bayesian_path_get(s : BiophylobayesianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_path_set(s : BiophylobayesianPath, i : Int, v : Double) -> BiophylobayesianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_sum(s : BiophylobayesianPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_path_mean(s : BiophylobayesianPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_path_scale(s : BiophylobayesianPath, f : Double) -> BiophylobayesianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_add(a : BiophylobayesianPath, b : BiophylobayesianPath) -> BiophylobayesianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_path_copy(s : BiophylobayesianPath) -> BiophylobayesianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_fill(s : BiophylobayesianPath, v : Double) -> BiophylobayesianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_path_min(s : BiophylobayesianPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_path_max(s : BiophylobayesianPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_path_to_string(s : BiophylobayesianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_cluster_make(size : Int) -> BiophylobayesianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_cluster_len(s : BiophylobayesianCluster) -> Int { s.size }

pub fn bio_phylo_bayesian_cluster_get(s : BiophylobayesianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_cluster_set(s : BiophylobayesianCluster, i : Int, v : Double) -> BiophylobayesianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_sum(s : BiophylobayesianCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_cluster_mean(s : BiophylobayesianCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_cluster_scale(s : BiophylobayesianCluster, f : Double) -> BiophylobayesianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_add(a : BiophylobayesianCluster, b : BiophylobayesianCluster) -> BiophylobayesianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_cluster_copy(s : BiophylobayesianCluster) -> BiophylobayesianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_fill(s : BiophylobayesianCluster, v : Double) -> BiophylobayesianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cluster_min(s : BiophylobayesianCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_cluster_max(s : BiophylobayesianCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_cluster_to_string(s : BiophylobayesianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_model_make(size : Int) -> BiophylobayesianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_model_len(s : BiophylobayesianModel) -> Int { s.size }

pub fn bio_phylo_bayesian_model_get(s : BiophylobayesianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_model_set(s : BiophylobayesianModel, i : Int, v : Double) -> BiophylobayesianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_sum(s : BiophylobayesianModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_model_mean(s : BiophylobayesianModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_model_scale(s : BiophylobayesianModel, f : Double) -> BiophylobayesianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_add(a : BiophylobayesianModel, b : BiophylobayesianModel) -> BiophylobayesianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_model_copy(s : BiophylobayesianModel) -> BiophylobayesianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_fill(s : BiophylobayesianModel, v : Double) -> BiophylobayesianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_model_min(s : BiophylobayesianModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_model_max(s : BiophylobayesianModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_model_to_string(s : BiophylobayesianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_layer_make(size : Int) -> BiophylobayesianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_layer_len(s : BiophylobayesianLayer) -> Int { s.size }

pub fn bio_phylo_bayesian_layer_get(s : BiophylobayesianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_layer_set(s : BiophylobayesianLayer, i : Int, v : Double) -> BiophylobayesianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_sum(s : BiophylobayesianLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_layer_mean(s : BiophylobayesianLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_layer_scale(s : BiophylobayesianLayer, f : Double) -> BiophylobayesianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_add(a : BiophylobayesianLayer, b : BiophylobayesianLayer) -> BiophylobayesianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_layer_copy(s : BiophylobayesianLayer) -> BiophylobayesianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_fill(s : BiophylobayesianLayer, v : Double) -> BiophylobayesianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_layer_min(s : BiophylobayesianLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_layer_max(s : BiophylobayesianLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_layer_to_string(s : BiophylobayesianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_buffer_make(size : Int) -> BiophylobayesianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_buffer_len(s : BiophylobayesianBuffer) -> Int { s.size }

pub fn bio_phylo_bayesian_buffer_get(s : BiophylobayesianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_buffer_set(s : BiophylobayesianBuffer, i : Int, v : Double) -> BiophylobayesianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_sum(s : BiophylobayesianBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_buffer_mean(s : BiophylobayesianBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_buffer_scale(s : BiophylobayesianBuffer, f : Double) -> BiophylobayesianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_add(a : BiophylobayesianBuffer, b : BiophylobayesianBuffer) -> BiophylobayesianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_buffer_copy(s : BiophylobayesianBuffer) -> BiophylobayesianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_fill(s : BiophylobayesianBuffer, v : Double) -> BiophylobayesianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_buffer_min(s : BiophylobayesianBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_buffer_max(s : BiophylobayesianBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_buffer_to_string(s : BiophylobayesianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_cursor_make(size : Int) -> BiophylobayesianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_cursor_len(s : BiophylobayesianCursor) -> Int { s.size }

pub fn bio_phylo_bayesian_cursor_get(s : BiophylobayesianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_cursor_set(s : BiophylobayesianCursor, i : Int, v : Double) -> BiophylobayesianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_sum(s : BiophylobayesianCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_cursor_mean(s : BiophylobayesianCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_cursor_scale(s : BiophylobayesianCursor, f : Double) -> BiophylobayesianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_add(a : BiophylobayesianCursor, b : BiophylobayesianCursor) -> BiophylobayesianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_cursor_copy(s : BiophylobayesianCursor) -> BiophylobayesianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_fill(s : BiophylobayesianCursor, v : Double) -> BiophylobayesianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_cursor_min(s : BiophylobayesianCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_cursor_max(s : BiophylobayesianCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_cursor_to_string(s : BiophylobayesianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_view_make(size : Int) -> BiophylobayesianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_view_len(s : BiophylobayesianView) -> Int { s.size }

pub fn bio_phylo_bayesian_view_get(s : BiophylobayesianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_view_set(s : BiophylobayesianView, i : Int, v : Double) -> BiophylobayesianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_sum(s : BiophylobayesianView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_view_mean(s : BiophylobayesianView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_view_scale(s : BiophylobayesianView, f : Double) -> BiophylobayesianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_add(a : BiophylobayesianView, b : BiophylobayesianView) -> BiophylobayesianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_view_copy(s : BiophylobayesianView) -> BiophylobayesianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_fill(s : BiophylobayesianView, v : Double) -> BiophylobayesianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_view_min(s : BiophylobayesianView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_view_max(s : BiophylobayesianView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_view_to_string(s : BiophylobayesianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_range_make(size : Int) -> BiophylobayesianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_range_len(s : BiophylobayesianRange) -> Int { s.size }

pub fn bio_phylo_bayesian_range_get(s : BiophylobayesianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_range_set(s : BiophylobayesianRange, i : Int, v : Double) -> BiophylobayesianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_sum(s : BiophylobayesianRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_range_mean(s : BiophylobayesianRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_range_scale(s : BiophylobayesianRange, f : Double) -> BiophylobayesianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_add(a : BiophylobayesianRange, b : BiophylobayesianRange) -> BiophylobayesianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_range_copy(s : BiophylobayesianRange) -> BiophylobayesianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_fill(s : BiophylobayesianRange, v : Double) -> BiophylobayesianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_range_min(s : BiophylobayesianRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_range_max(s : BiophylobayesianRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_range_to_string(s : BiophylobayesianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_slice_make(size : Int) -> BiophylobayesianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bayesian_slice_len(s : BiophylobayesianSlice) -> Int { s.size }

pub fn bio_phylo_bayesian_slice_get(s : BiophylobayesianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bayesian_slice_set(s : BiophylobayesianSlice, i : Int, v : Double) -> BiophylobayesianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_sum(s : BiophylobayesianSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bayesian_slice_mean(s : BiophylobayesianSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bayesian_slice_scale(s : BiophylobayesianSlice, f : Double) -> BiophylobayesianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_add(a : BiophylobayesianSlice, b : BiophylobayesianSlice) -> BiophylobayesianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bayesian_slice_copy(s : BiophylobayesianSlice) -> BiophylobayesianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_fill(s : BiophylobayesianSlice, v : Double) -> BiophylobayesianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bayesian_slice_min(s : BiophylobayesianSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bayesian_slice_max(s : BiophylobayesianSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bayesian_slice_to_string(s : BiophylobayesianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

