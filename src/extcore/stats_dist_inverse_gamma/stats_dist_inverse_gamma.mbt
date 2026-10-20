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

pub fn StatsdistinversegammaFrame::len(self : StatsdistinversegammaFrame) -> Int { self.size }

pub fn StatsdistinversegammaFrame::get(self : StatsdistinversegammaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaFrame::set(self : StatsdistinversegammaFrame, i : Int, v : Double) -> StatsdistinversegammaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaFrame::sum(self : StatsdistinversegammaFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaFrame::mean(self : StatsdistinversegammaFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaFrame::scale(self : StatsdistinversegammaFrame, f : Double) -> StatsdistinversegammaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaFrame::add(self : StatsdistinversegammaFrame, other : StatsdistinversegammaFrame) -> StatsdistinversegammaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaFrame::copy(self : StatsdistinversegammaFrame) -> StatsdistinversegammaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaFrame::fill(self : StatsdistinversegammaFrame, v : Double) -> StatsdistinversegammaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaFrame::min(self : StatsdistinversegammaFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaFrame::max(self : StatsdistinversegammaFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaFrame::to_string(self : StatsdistinversegammaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_table_make(size : Int) -> StatsdistinversegammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaTable::len(self : StatsdistinversegammaTable) -> Int { self.size }

pub fn StatsdistinversegammaTable::get(self : StatsdistinversegammaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaTable::set(self : StatsdistinversegammaTable, i : Int, v : Double) -> StatsdistinversegammaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaTable::sum(self : StatsdistinversegammaTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaTable::mean(self : StatsdistinversegammaTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaTable::scale(self : StatsdistinversegammaTable, f : Double) -> StatsdistinversegammaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaTable::add(self : StatsdistinversegammaTable, other : StatsdistinversegammaTable) -> StatsdistinversegammaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaTable::copy(self : StatsdistinversegammaTable) -> StatsdistinversegammaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaTable::fill(self : StatsdistinversegammaTable, v : Double) -> StatsdistinversegammaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaTable::min(self : StatsdistinversegammaTable) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaTable::max(self : StatsdistinversegammaTable) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaTable::to_string(self : StatsdistinversegammaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_graphn_make(size : Int) -> StatsdistinversegammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaGraphN::len(self : StatsdistinversegammaGraphN) -> Int { self.size }

pub fn StatsdistinversegammaGraphN::get(self : StatsdistinversegammaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaGraphN::set(self : StatsdistinversegammaGraphN, i : Int, v : Double) -> StatsdistinversegammaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaGraphN::sum(self : StatsdistinversegammaGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaGraphN::mean(self : StatsdistinversegammaGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaGraphN::scale(self : StatsdistinversegammaGraphN, f : Double) -> StatsdistinversegammaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaGraphN::add(self : StatsdistinversegammaGraphN, other : StatsdistinversegammaGraphN) -> StatsdistinversegammaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaGraphN::copy(self : StatsdistinversegammaGraphN) -> StatsdistinversegammaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaGraphN::fill(self : StatsdistinversegammaGraphN, v : Double) -> StatsdistinversegammaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaGraphN::min(self : StatsdistinversegammaGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaGraphN::max(self : StatsdistinversegammaGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaGraphN::to_string(self : StatsdistinversegammaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_node_make(size : Int) -> StatsdistinversegammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaNode::len(self : StatsdistinversegammaNode) -> Int { self.size }

pub fn StatsdistinversegammaNode::get(self : StatsdistinversegammaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaNode::set(self : StatsdistinversegammaNode, i : Int, v : Double) -> StatsdistinversegammaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaNode::sum(self : StatsdistinversegammaNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaNode::mean(self : StatsdistinversegammaNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaNode::scale(self : StatsdistinversegammaNode, f : Double) -> StatsdistinversegammaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaNode::add(self : StatsdistinversegammaNode, other : StatsdistinversegammaNode) -> StatsdistinversegammaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaNode::copy(self : StatsdistinversegammaNode) -> StatsdistinversegammaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaNode::fill(self : StatsdistinversegammaNode, v : Double) -> StatsdistinversegammaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaNode::min(self : StatsdistinversegammaNode) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaNode::max(self : StatsdistinversegammaNode) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaNode::to_string(self : StatsdistinversegammaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_edge_make(size : Int) -> StatsdistinversegammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaEdge::len(self : StatsdistinversegammaEdge) -> Int { self.size }

pub fn StatsdistinversegammaEdge::get(self : StatsdistinversegammaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaEdge::set(self : StatsdistinversegammaEdge, i : Int, v : Double) -> StatsdistinversegammaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaEdge::sum(self : StatsdistinversegammaEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaEdge::mean(self : StatsdistinversegammaEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaEdge::scale(self : StatsdistinversegammaEdge, f : Double) -> StatsdistinversegammaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaEdge::add(self : StatsdistinversegammaEdge, other : StatsdistinversegammaEdge) -> StatsdistinversegammaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaEdge::copy(self : StatsdistinversegammaEdge) -> StatsdistinversegammaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaEdge::fill(self : StatsdistinversegammaEdge, v : Double) -> StatsdistinversegammaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaEdge::min(self : StatsdistinversegammaEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaEdge::max(self : StatsdistinversegammaEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaEdge::to_string(self : StatsdistinversegammaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_path_make(size : Int) -> StatsdistinversegammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaPath::len(self : StatsdistinversegammaPath) -> Int { self.size }

pub fn StatsdistinversegammaPath::get(self : StatsdistinversegammaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaPath::set(self : StatsdistinversegammaPath, i : Int, v : Double) -> StatsdistinversegammaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaPath::sum(self : StatsdistinversegammaPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaPath::mean(self : StatsdistinversegammaPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaPath::scale(self : StatsdistinversegammaPath, f : Double) -> StatsdistinversegammaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaPath::add(self : StatsdistinversegammaPath, other : StatsdistinversegammaPath) -> StatsdistinversegammaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaPath::copy(self : StatsdistinversegammaPath) -> StatsdistinversegammaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaPath::fill(self : StatsdistinversegammaPath, v : Double) -> StatsdistinversegammaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaPath::min(self : StatsdistinversegammaPath) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaPath::max(self : StatsdistinversegammaPath) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaPath::to_string(self : StatsdistinversegammaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_cluster_make(size : Int) -> StatsdistinversegammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaCluster::len(self : StatsdistinversegammaCluster) -> Int { self.size }

pub fn StatsdistinversegammaCluster::get(self : StatsdistinversegammaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaCluster::set(self : StatsdistinversegammaCluster, i : Int, v : Double) -> StatsdistinversegammaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCluster::sum(self : StatsdistinversegammaCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaCluster::mean(self : StatsdistinversegammaCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaCluster::scale(self : StatsdistinversegammaCluster, f : Double) -> StatsdistinversegammaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCluster::add(self : StatsdistinversegammaCluster, other : StatsdistinversegammaCluster) -> StatsdistinversegammaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaCluster::copy(self : StatsdistinversegammaCluster) -> StatsdistinversegammaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCluster::fill(self : StatsdistinversegammaCluster, v : Double) -> StatsdistinversegammaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCluster::min(self : StatsdistinversegammaCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaCluster::max(self : StatsdistinversegammaCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaCluster::to_string(self : StatsdistinversegammaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_model_make(size : Int) -> StatsdistinversegammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaModel::len(self : StatsdistinversegammaModel) -> Int { self.size }

pub fn StatsdistinversegammaModel::get(self : StatsdistinversegammaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaModel::set(self : StatsdistinversegammaModel, i : Int, v : Double) -> StatsdistinversegammaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaModel::sum(self : StatsdistinversegammaModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaModel::mean(self : StatsdistinversegammaModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaModel::scale(self : StatsdistinversegammaModel, f : Double) -> StatsdistinversegammaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaModel::add(self : StatsdistinversegammaModel, other : StatsdistinversegammaModel) -> StatsdistinversegammaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaModel::copy(self : StatsdistinversegammaModel) -> StatsdistinversegammaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaModel::fill(self : StatsdistinversegammaModel, v : Double) -> StatsdistinversegammaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaModel::min(self : StatsdistinversegammaModel) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaModel::max(self : StatsdistinversegammaModel) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaModel::to_string(self : StatsdistinversegammaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_layer_make(size : Int) -> StatsdistinversegammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaLayer::len(self : StatsdistinversegammaLayer) -> Int { self.size }

pub fn StatsdistinversegammaLayer::get(self : StatsdistinversegammaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaLayer::set(self : StatsdistinversegammaLayer, i : Int, v : Double) -> StatsdistinversegammaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaLayer::sum(self : StatsdistinversegammaLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaLayer::mean(self : StatsdistinversegammaLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaLayer::scale(self : StatsdistinversegammaLayer, f : Double) -> StatsdistinversegammaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaLayer::add(self : StatsdistinversegammaLayer, other : StatsdistinversegammaLayer) -> StatsdistinversegammaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaLayer::copy(self : StatsdistinversegammaLayer) -> StatsdistinversegammaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaLayer::fill(self : StatsdistinversegammaLayer, v : Double) -> StatsdistinversegammaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaLayer::min(self : StatsdistinversegammaLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaLayer::max(self : StatsdistinversegammaLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaLayer::to_string(self : StatsdistinversegammaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_buffer_make(size : Int) -> StatsdistinversegammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaBuffer::len(self : StatsdistinversegammaBuffer) -> Int { self.size }

pub fn StatsdistinversegammaBuffer::get(self : StatsdistinversegammaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaBuffer::set(self : StatsdistinversegammaBuffer, i : Int, v : Double) -> StatsdistinversegammaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaBuffer::sum(self : StatsdistinversegammaBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaBuffer::mean(self : StatsdistinversegammaBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaBuffer::scale(self : StatsdistinversegammaBuffer, f : Double) -> StatsdistinversegammaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaBuffer::add(self : StatsdistinversegammaBuffer, other : StatsdistinversegammaBuffer) -> StatsdistinversegammaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaBuffer::copy(self : StatsdistinversegammaBuffer) -> StatsdistinversegammaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaBuffer::fill(self : StatsdistinversegammaBuffer, v : Double) -> StatsdistinversegammaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaBuffer::min(self : StatsdistinversegammaBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaBuffer::max(self : StatsdistinversegammaBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaBuffer::to_string(self : StatsdistinversegammaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_cursor_make(size : Int) -> StatsdistinversegammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaCursor::len(self : StatsdistinversegammaCursor) -> Int { self.size }

pub fn StatsdistinversegammaCursor::get(self : StatsdistinversegammaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaCursor::set(self : StatsdistinversegammaCursor, i : Int, v : Double) -> StatsdistinversegammaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCursor::sum(self : StatsdistinversegammaCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaCursor::mean(self : StatsdistinversegammaCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaCursor::scale(self : StatsdistinversegammaCursor, f : Double) -> StatsdistinversegammaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCursor::add(self : StatsdistinversegammaCursor, other : StatsdistinversegammaCursor) -> StatsdistinversegammaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaCursor::copy(self : StatsdistinversegammaCursor) -> StatsdistinversegammaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCursor::fill(self : StatsdistinversegammaCursor, v : Double) -> StatsdistinversegammaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaCursor::min(self : StatsdistinversegammaCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaCursor::max(self : StatsdistinversegammaCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaCursor::to_string(self : StatsdistinversegammaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_view_make(size : Int) -> StatsdistinversegammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaView::len(self : StatsdistinversegammaView) -> Int { self.size }

pub fn StatsdistinversegammaView::get(self : StatsdistinversegammaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaView::set(self : StatsdistinversegammaView, i : Int, v : Double) -> StatsdistinversegammaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaView::sum(self : StatsdistinversegammaView) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaView::mean(self : StatsdistinversegammaView) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaView::scale(self : StatsdistinversegammaView, f : Double) -> StatsdistinversegammaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaView::add(self : StatsdistinversegammaView, other : StatsdistinversegammaView) -> StatsdistinversegammaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaView::copy(self : StatsdistinversegammaView) -> StatsdistinversegammaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaView::fill(self : StatsdistinversegammaView, v : Double) -> StatsdistinversegammaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaView::min(self : StatsdistinversegammaView) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaView::max(self : StatsdistinversegammaView) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaView::to_string(self : StatsdistinversegammaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_range_make(size : Int) -> StatsdistinversegammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaRange::len(self : StatsdistinversegammaRange) -> Int { self.size }

pub fn StatsdistinversegammaRange::get(self : StatsdistinversegammaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaRange::set(self : StatsdistinversegammaRange, i : Int, v : Double) -> StatsdistinversegammaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaRange::sum(self : StatsdistinversegammaRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaRange::mean(self : StatsdistinversegammaRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaRange::scale(self : StatsdistinversegammaRange, f : Double) -> StatsdistinversegammaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaRange::add(self : StatsdistinversegammaRange, other : StatsdistinversegammaRange) -> StatsdistinversegammaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaRange::copy(self : StatsdistinversegammaRange) -> StatsdistinversegammaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaRange::fill(self : StatsdistinversegammaRange, v : Double) -> StatsdistinversegammaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaRange::min(self : StatsdistinversegammaRange) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaRange::max(self : StatsdistinversegammaRange) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaRange::to_string(self : StatsdistinversegammaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_slice_make(size : Int) -> StatsdistinversegammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistinversegammaSlice::len(self : StatsdistinversegammaSlice) -> Int { self.size }

pub fn StatsdistinversegammaSlice::get(self : StatsdistinversegammaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistinversegammaSlice::set(self : StatsdistinversegammaSlice, i : Int, v : Double) -> StatsdistinversegammaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaSlice::sum(self : StatsdistinversegammaSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistinversegammaSlice::mean(self : StatsdistinversegammaSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistinversegammaSlice::scale(self : StatsdistinversegammaSlice, f : Double) -> StatsdistinversegammaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaSlice::add(self : StatsdistinversegammaSlice, other : StatsdistinversegammaSlice) -> StatsdistinversegammaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistinversegammaSlice::copy(self : StatsdistinversegammaSlice) -> StatsdistinversegammaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaSlice::fill(self : StatsdistinversegammaSlice, v : Double) -> StatsdistinversegammaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistinversegammaSlice::min(self : StatsdistinversegammaSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistinversegammaSlice::max(self : StatsdistinversegammaSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistinversegammaSlice::to_string(self : StatsdistinversegammaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

