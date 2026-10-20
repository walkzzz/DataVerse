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

pub fn BiophylobayesianFrame::len(self : BiophylobayesianFrame) -> Int { self.size }

pub fn BiophylobayesianFrame::get(self : BiophylobayesianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianFrame::set(self : BiophylobayesianFrame, i : Int, v : Double) -> BiophylobayesianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianFrame::sum(self : BiophylobayesianFrame) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianFrame::mean(self : BiophylobayesianFrame) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianFrame::scale(self : BiophylobayesianFrame, f : Double) -> BiophylobayesianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianFrame::add(self : BiophylobayesianFrame, other : BiophylobayesianFrame) -> BiophylobayesianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianFrame::copy(self : BiophylobayesianFrame) -> BiophylobayesianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianFrame::fill(self : BiophylobayesianFrame, v : Double) -> BiophylobayesianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianFrame::min(self : BiophylobayesianFrame) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianFrame::max(self : BiophylobayesianFrame) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianFrame::to_string(self : BiophylobayesianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_table_make(size : Int) -> BiophylobayesianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianTable::len(self : BiophylobayesianTable) -> Int { self.size }

pub fn BiophylobayesianTable::get(self : BiophylobayesianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianTable::set(self : BiophylobayesianTable, i : Int, v : Double) -> BiophylobayesianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianTable::sum(self : BiophylobayesianTable) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianTable::mean(self : BiophylobayesianTable) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianTable::scale(self : BiophylobayesianTable, f : Double) -> BiophylobayesianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianTable::add(self : BiophylobayesianTable, other : BiophylobayesianTable) -> BiophylobayesianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianTable::copy(self : BiophylobayesianTable) -> BiophylobayesianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianTable::fill(self : BiophylobayesianTable, v : Double) -> BiophylobayesianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianTable::min(self : BiophylobayesianTable) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianTable::max(self : BiophylobayesianTable) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianTable::to_string(self : BiophylobayesianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_graphn_make(size : Int) -> BiophylobayesianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianGraphN::len(self : BiophylobayesianGraphN) -> Int { self.size }

pub fn BiophylobayesianGraphN::get(self : BiophylobayesianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianGraphN::set(self : BiophylobayesianGraphN, i : Int, v : Double) -> BiophylobayesianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianGraphN::sum(self : BiophylobayesianGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianGraphN::mean(self : BiophylobayesianGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianGraphN::scale(self : BiophylobayesianGraphN, f : Double) -> BiophylobayesianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianGraphN::add(self : BiophylobayesianGraphN, other : BiophylobayesianGraphN) -> BiophylobayesianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianGraphN::copy(self : BiophylobayesianGraphN) -> BiophylobayesianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianGraphN::fill(self : BiophylobayesianGraphN, v : Double) -> BiophylobayesianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianGraphN::min(self : BiophylobayesianGraphN) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianGraphN::max(self : BiophylobayesianGraphN) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianGraphN::to_string(self : BiophylobayesianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_node_make(size : Int) -> BiophylobayesianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianNode::len(self : BiophylobayesianNode) -> Int { self.size }

pub fn BiophylobayesianNode::get(self : BiophylobayesianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianNode::set(self : BiophylobayesianNode, i : Int, v : Double) -> BiophylobayesianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianNode::sum(self : BiophylobayesianNode) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianNode::mean(self : BiophylobayesianNode) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianNode::scale(self : BiophylobayesianNode, f : Double) -> BiophylobayesianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianNode::add(self : BiophylobayesianNode, other : BiophylobayesianNode) -> BiophylobayesianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianNode::copy(self : BiophylobayesianNode) -> BiophylobayesianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianNode::fill(self : BiophylobayesianNode, v : Double) -> BiophylobayesianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianNode::min(self : BiophylobayesianNode) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianNode::max(self : BiophylobayesianNode) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianNode::to_string(self : BiophylobayesianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_edge_make(size : Int) -> BiophylobayesianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianEdge::len(self : BiophylobayesianEdge) -> Int { self.size }

pub fn BiophylobayesianEdge::get(self : BiophylobayesianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianEdge::set(self : BiophylobayesianEdge, i : Int, v : Double) -> BiophylobayesianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianEdge::sum(self : BiophylobayesianEdge) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianEdge::mean(self : BiophylobayesianEdge) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianEdge::scale(self : BiophylobayesianEdge, f : Double) -> BiophylobayesianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianEdge::add(self : BiophylobayesianEdge, other : BiophylobayesianEdge) -> BiophylobayesianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianEdge::copy(self : BiophylobayesianEdge) -> BiophylobayesianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianEdge::fill(self : BiophylobayesianEdge, v : Double) -> BiophylobayesianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianEdge::min(self : BiophylobayesianEdge) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianEdge::max(self : BiophylobayesianEdge) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianEdge::to_string(self : BiophylobayesianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_path_make(size : Int) -> BiophylobayesianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianPath::len(self : BiophylobayesianPath) -> Int { self.size }

pub fn BiophylobayesianPath::get(self : BiophylobayesianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianPath::set(self : BiophylobayesianPath, i : Int, v : Double) -> BiophylobayesianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianPath::sum(self : BiophylobayesianPath) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianPath::mean(self : BiophylobayesianPath) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianPath::scale(self : BiophylobayesianPath, f : Double) -> BiophylobayesianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianPath::add(self : BiophylobayesianPath, other : BiophylobayesianPath) -> BiophylobayesianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianPath::copy(self : BiophylobayesianPath) -> BiophylobayesianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianPath::fill(self : BiophylobayesianPath, v : Double) -> BiophylobayesianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianPath::min(self : BiophylobayesianPath) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianPath::max(self : BiophylobayesianPath) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianPath::to_string(self : BiophylobayesianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_cluster_make(size : Int) -> BiophylobayesianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianCluster::len(self : BiophylobayesianCluster) -> Int { self.size }

pub fn BiophylobayesianCluster::get(self : BiophylobayesianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianCluster::set(self : BiophylobayesianCluster, i : Int, v : Double) -> BiophylobayesianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCluster::sum(self : BiophylobayesianCluster) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianCluster::mean(self : BiophylobayesianCluster) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianCluster::scale(self : BiophylobayesianCluster, f : Double) -> BiophylobayesianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCluster::add(self : BiophylobayesianCluster, other : BiophylobayesianCluster) -> BiophylobayesianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianCluster::copy(self : BiophylobayesianCluster) -> BiophylobayesianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCluster::fill(self : BiophylobayesianCluster, v : Double) -> BiophylobayesianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCluster::min(self : BiophylobayesianCluster) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianCluster::max(self : BiophylobayesianCluster) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianCluster::to_string(self : BiophylobayesianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_model_make(size : Int) -> BiophylobayesianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianModel::len(self : BiophylobayesianModel) -> Int { self.size }

pub fn BiophylobayesianModel::get(self : BiophylobayesianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianModel::set(self : BiophylobayesianModel, i : Int, v : Double) -> BiophylobayesianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianModel::sum(self : BiophylobayesianModel) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianModel::mean(self : BiophylobayesianModel) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianModel::scale(self : BiophylobayesianModel, f : Double) -> BiophylobayesianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianModel::add(self : BiophylobayesianModel, other : BiophylobayesianModel) -> BiophylobayesianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianModel::copy(self : BiophylobayesianModel) -> BiophylobayesianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianModel::fill(self : BiophylobayesianModel, v : Double) -> BiophylobayesianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianModel::min(self : BiophylobayesianModel) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianModel::max(self : BiophylobayesianModel) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianModel::to_string(self : BiophylobayesianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_layer_make(size : Int) -> BiophylobayesianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianLayer::len(self : BiophylobayesianLayer) -> Int { self.size }

pub fn BiophylobayesianLayer::get(self : BiophylobayesianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianLayer::set(self : BiophylobayesianLayer, i : Int, v : Double) -> BiophylobayesianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianLayer::sum(self : BiophylobayesianLayer) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianLayer::mean(self : BiophylobayesianLayer) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianLayer::scale(self : BiophylobayesianLayer, f : Double) -> BiophylobayesianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianLayer::add(self : BiophylobayesianLayer, other : BiophylobayesianLayer) -> BiophylobayesianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianLayer::copy(self : BiophylobayesianLayer) -> BiophylobayesianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianLayer::fill(self : BiophylobayesianLayer, v : Double) -> BiophylobayesianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianLayer::min(self : BiophylobayesianLayer) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianLayer::max(self : BiophylobayesianLayer) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianLayer::to_string(self : BiophylobayesianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_buffer_make(size : Int) -> BiophylobayesianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianBuffer::len(self : BiophylobayesianBuffer) -> Int { self.size }

pub fn BiophylobayesianBuffer::get(self : BiophylobayesianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianBuffer::set(self : BiophylobayesianBuffer, i : Int, v : Double) -> BiophylobayesianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianBuffer::sum(self : BiophylobayesianBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianBuffer::mean(self : BiophylobayesianBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianBuffer::scale(self : BiophylobayesianBuffer, f : Double) -> BiophylobayesianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianBuffer::add(self : BiophylobayesianBuffer, other : BiophylobayesianBuffer) -> BiophylobayesianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianBuffer::copy(self : BiophylobayesianBuffer) -> BiophylobayesianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianBuffer::fill(self : BiophylobayesianBuffer, v : Double) -> BiophylobayesianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianBuffer::min(self : BiophylobayesianBuffer) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianBuffer::max(self : BiophylobayesianBuffer) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianBuffer::to_string(self : BiophylobayesianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_cursor_make(size : Int) -> BiophylobayesianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianCursor::len(self : BiophylobayesianCursor) -> Int { self.size }

pub fn BiophylobayesianCursor::get(self : BiophylobayesianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianCursor::set(self : BiophylobayesianCursor, i : Int, v : Double) -> BiophylobayesianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCursor::sum(self : BiophylobayesianCursor) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianCursor::mean(self : BiophylobayesianCursor) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianCursor::scale(self : BiophylobayesianCursor, f : Double) -> BiophylobayesianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCursor::add(self : BiophylobayesianCursor, other : BiophylobayesianCursor) -> BiophylobayesianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianCursor::copy(self : BiophylobayesianCursor) -> BiophylobayesianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCursor::fill(self : BiophylobayesianCursor, v : Double) -> BiophylobayesianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianCursor::min(self : BiophylobayesianCursor) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianCursor::max(self : BiophylobayesianCursor) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianCursor::to_string(self : BiophylobayesianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_view_make(size : Int) -> BiophylobayesianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianView::len(self : BiophylobayesianView) -> Int { self.size }

pub fn BiophylobayesianView::get(self : BiophylobayesianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianView::set(self : BiophylobayesianView, i : Int, v : Double) -> BiophylobayesianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianView::sum(self : BiophylobayesianView) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianView::mean(self : BiophylobayesianView) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianView::scale(self : BiophylobayesianView, f : Double) -> BiophylobayesianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianView::add(self : BiophylobayesianView, other : BiophylobayesianView) -> BiophylobayesianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianView::copy(self : BiophylobayesianView) -> BiophylobayesianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianView::fill(self : BiophylobayesianView, v : Double) -> BiophylobayesianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianView::min(self : BiophylobayesianView) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianView::max(self : BiophylobayesianView) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianView::to_string(self : BiophylobayesianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_range_make(size : Int) -> BiophylobayesianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianRange::len(self : BiophylobayesianRange) -> Int { self.size }

pub fn BiophylobayesianRange::get(self : BiophylobayesianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianRange::set(self : BiophylobayesianRange, i : Int, v : Double) -> BiophylobayesianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianRange::sum(self : BiophylobayesianRange) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianRange::mean(self : BiophylobayesianRange) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianRange::scale(self : BiophylobayesianRange, f : Double) -> BiophylobayesianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianRange::add(self : BiophylobayesianRange, other : BiophylobayesianRange) -> BiophylobayesianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianRange::copy(self : BiophylobayesianRange) -> BiophylobayesianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianRange::fill(self : BiophylobayesianRange, v : Double) -> BiophylobayesianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianRange::min(self : BiophylobayesianRange) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianRange::max(self : BiophylobayesianRange) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianRange::to_string(self : BiophylobayesianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylobayesianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bayesian_slice_make(size : Int) -> BiophylobayesianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylobayesianSlice::len(self : BiophylobayesianSlice) -> Int { self.size }

pub fn BiophylobayesianSlice::get(self : BiophylobayesianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylobayesianSlice::set(self : BiophylobayesianSlice, i : Int, v : Double) -> BiophylobayesianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylobayesianSlice::sum(self : BiophylobayesianSlice) -> Double { @_common.sum(self.data) }

pub fn BiophylobayesianSlice::mean(self : BiophylobayesianSlice) -> Double { @_common.mean(self.data) }

pub fn BiophylobayesianSlice::scale(self : BiophylobayesianSlice, f : Double) -> BiophylobayesianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianSlice::add(self : BiophylobayesianSlice, other : BiophylobayesianSlice) -> BiophylobayesianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylobayesianSlice::copy(self : BiophylobayesianSlice) -> BiophylobayesianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianSlice::fill(self : BiophylobayesianSlice, v : Double) -> BiophylobayesianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylobayesianSlice::min(self : BiophylobayesianSlice) -> Double { @_common.min(self.data) }

pub fn BiophylobayesianSlice::max(self : BiophylobayesianSlice) -> Double { @_common.max(self.data) }

pub fn BiophylobayesianSlice::to_string(self : BiophylobayesianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

