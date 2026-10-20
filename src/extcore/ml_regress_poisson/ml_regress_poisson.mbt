///===
/// extcore/ml_regress_poisson

pub(all) struct MlregresspoissonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_poisson_make_point(x : Double, y : Double) -> MlregresspoissonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_poisson_make_point3(x : Double, y : Double, z : Double) -> MlregresspoissonPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresspoissonPoint::x(self : MlregresspoissonPoint) -> Double { self.x }

pub fn MlregresspoissonPoint::y(self : MlregresspoissonPoint) -> Double { self.y }

pub fn MlregresspoissonPoint::z(self : MlregresspoissonPoint) -> Double { self.z }

pub fn MlregresspoissonPoint::label(self : MlregresspoissonPoint) -> Int { self.label }

pub fn MlregresspoissonPoint::dist(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresspoissonPoint::add(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresspoissonPoint::sub(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresspoissonPoint::scale(self : MlregresspoissonPoint, s : Double) -> MlregresspoissonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresspoissonPoint::dot(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresspoissonPoint::cross(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresspoissonPoint::norm(self : MlregresspoissonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresspoissonPoint::normalize(self : MlregresspoissonPoint) -> MlregresspoissonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspoissonPoint::negate(self : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresspoissonPoint::mid(self : MlregresspoissonPoint, other : MlregresspoissonPoint) -> MlregresspoissonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresspoissonPoint::lerp(self : MlregresspoissonPoint, other : MlregresspoissonPoint, t : Double) -> MlregresspoissonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresspoissonPoint::to_string(self : MlregresspoissonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresspoissonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_poisson_make_series(vals : Array[Double], name : String) -> MlregresspoissonSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresspoissonSeries::len(self : MlregresspoissonSeries) -> Int { self.vals.length() }

pub fn MlregresspoissonSeries::sum(self : MlregresspoissonSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresspoissonSeries::mean(self : MlregresspoissonSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresspoissonSeries::min(self : MlregresspoissonSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresspoissonSeries::max(self : MlregresspoissonSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresspoissonSeries::range(self : MlregresspoissonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresspoissonSeries::variance(self : MlregresspoissonSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresspoissonSeries::std(self : MlregresspoissonSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresspoissonSeries::median(self : MlregresspoissonSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresspoissonSeries::scale(self : MlregresspoissonSeries, f : Double) -> MlregresspoissonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresspoissonSeries::add(self : MlregresspoissonSeries, other : MlregresspoissonSeries) -> MlregresspoissonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresspoissonSeries::sub(self : MlregresspoissonSeries, other : MlregresspoissonSeries) -> MlregresspoissonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresspoissonSeries::normalize(self : MlregresspoissonSeries) -> MlregresspoissonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresspoissonSeries::cumsum(self : MlregresspoissonSeries) -> MlregresspoissonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresspoissonSeries::to_string(self : MlregresspoissonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspoissonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_poisson_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresspoissonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_poisson_matrix_identity(n : Int) -> MlregresspoissonMatrix {
  let m = ml_regress_poisson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresspoissonMatrix::get(self : MlregresspoissonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresspoissonMatrix::transpose(self : MlregresspoissonMatrix) -> MlregresspoissonMatrix {
  let result = ml_regress_poisson_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresspoissonMatrix::add(self : MlregresspoissonMatrix, other : MlregresspoissonMatrix) -> MlregresspoissonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_poisson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresspoissonMatrix::scale(self : MlregresspoissonMatrix, s : Double) -> MlregresspoissonMatrix {
  let result = ml_regress_poisson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresspoissonMatrix::multiply(self : MlregresspoissonMatrix, other : MlregresspoissonMatrix) -> MlregresspoissonMatrix {
  if self.cols != other.rows { return ml_regress_poisson_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_poisson_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresspoissonMatrix::trace(self : MlregresspoissonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresspoissonMatrix::det(self : MlregresspoissonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresspoissonMatrix::norm(self : MlregresspoissonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresspoissonMatrix::to_string(self : MlregresspoissonMatrix) -> String {
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

pub(all) struct MlregresspoissonVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_poisson_make_vector(comps : Array[Double]) -> MlregresspoissonVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_poisson_vector_zero(dim : Int) -> MlregresspoissonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresspoissonVector::add(self : MlregresspoissonVector, other : MlregresspoissonVector) -> MlregresspoissonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspoissonVector::sub(self : MlregresspoissonVector, other : MlregresspoissonVector) -> MlregresspoissonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspoissonVector::scale(self : MlregresspoissonVector, s : Double) -> MlregresspoissonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresspoissonVector::dot(self : MlregresspoissonVector, other : MlregresspoissonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresspoissonVector::norm(self : MlregresspoissonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresspoissonVector::normalize(self : MlregresspoissonVector) -> MlregresspoissonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspoissonVector::dist(self : MlregresspoissonVector, other : MlregresspoissonVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresspoissonVector::to_string(self : MlregresspoissonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_poisson_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_poisson_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_poisson_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_poisson_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_poisson_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_poisson_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_poisson_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_poisson_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_poisson_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_poisson_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_poisson_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_poisson_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_poisson_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_poisson_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_poisson_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_poisson_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_poisson_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_poisson_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_poisson_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_poisson_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_poisson_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_poisson_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_poisson_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_poisson_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_poisson_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_poisson_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_poisson_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_poisson_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_poisson_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresspoissonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_frame_make(size : Int) -> MlregresspoissonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_frame_len(s : MlregresspoissonFrame) -> Int { s.size }

pub fn ml_regress_poisson_frame_get(s : MlregresspoissonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_frame_set(s : MlregresspoissonFrame, i : Int, v : Double) -> MlregresspoissonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_frame_sum(s : MlregresspoissonFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_frame_mean(s : MlregresspoissonFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_frame_scale(s : MlregresspoissonFrame, f : Double) -> MlregresspoissonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_frame_add(a : MlregresspoissonFrame, b : MlregresspoissonFrame) -> MlregresspoissonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_frame_copy(s : MlregresspoissonFrame) -> MlregresspoissonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_frame_fill(s : MlregresspoissonFrame, v : Double) -> MlregresspoissonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_frame_min(s : MlregresspoissonFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_frame_max(s : MlregresspoissonFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_frame_to_string(s : MlregresspoissonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_table_make(size : Int) -> MlregresspoissonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_table_len(s : MlregresspoissonTable) -> Int { s.size }

pub fn ml_regress_poisson_table_get(s : MlregresspoissonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_table_set(s : MlregresspoissonTable, i : Int, v : Double) -> MlregresspoissonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_table_sum(s : MlregresspoissonTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_table_mean(s : MlregresspoissonTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_table_scale(s : MlregresspoissonTable, f : Double) -> MlregresspoissonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_table_add(a : MlregresspoissonTable, b : MlregresspoissonTable) -> MlregresspoissonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_table_copy(s : MlregresspoissonTable) -> MlregresspoissonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_table_fill(s : MlregresspoissonTable, v : Double) -> MlregresspoissonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_table_min(s : MlregresspoissonTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_table_max(s : MlregresspoissonTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_table_to_string(s : MlregresspoissonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_graphn_make(size : Int) -> MlregresspoissonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_graphn_len(s : MlregresspoissonGraphN) -> Int { s.size }

pub fn ml_regress_poisson_graphn_get(s : MlregresspoissonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_graphn_set(s : MlregresspoissonGraphN, i : Int, v : Double) -> MlregresspoissonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_graphn_sum(s : MlregresspoissonGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_graphn_mean(s : MlregresspoissonGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_graphn_scale(s : MlregresspoissonGraphN, f : Double) -> MlregresspoissonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_graphn_add(a : MlregresspoissonGraphN, b : MlregresspoissonGraphN) -> MlregresspoissonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_graphn_copy(s : MlregresspoissonGraphN) -> MlregresspoissonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_graphn_fill(s : MlregresspoissonGraphN, v : Double) -> MlregresspoissonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_graphn_min(s : MlregresspoissonGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_graphn_max(s : MlregresspoissonGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_graphn_to_string(s : MlregresspoissonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_node_make(size : Int) -> MlregresspoissonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_node_len(s : MlregresspoissonNode) -> Int { s.size }

pub fn ml_regress_poisson_node_get(s : MlregresspoissonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_node_set(s : MlregresspoissonNode, i : Int, v : Double) -> MlregresspoissonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_node_sum(s : MlregresspoissonNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_node_mean(s : MlregresspoissonNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_node_scale(s : MlregresspoissonNode, f : Double) -> MlregresspoissonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_node_add(a : MlregresspoissonNode, b : MlregresspoissonNode) -> MlregresspoissonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_node_copy(s : MlregresspoissonNode) -> MlregresspoissonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_node_fill(s : MlregresspoissonNode, v : Double) -> MlregresspoissonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_node_min(s : MlregresspoissonNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_node_max(s : MlregresspoissonNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_node_to_string(s : MlregresspoissonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_edge_make(size : Int) -> MlregresspoissonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_edge_len(s : MlregresspoissonEdge) -> Int { s.size }

pub fn ml_regress_poisson_edge_get(s : MlregresspoissonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_edge_set(s : MlregresspoissonEdge, i : Int, v : Double) -> MlregresspoissonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_edge_sum(s : MlregresspoissonEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_edge_mean(s : MlregresspoissonEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_edge_scale(s : MlregresspoissonEdge, f : Double) -> MlregresspoissonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_edge_add(a : MlregresspoissonEdge, b : MlregresspoissonEdge) -> MlregresspoissonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_edge_copy(s : MlregresspoissonEdge) -> MlregresspoissonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_edge_fill(s : MlregresspoissonEdge, v : Double) -> MlregresspoissonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_edge_min(s : MlregresspoissonEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_edge_max(s : MlregresspoissonEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_edge_to_string(s : MlregresspoissonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_path_make(size : Int) -> MlregresspoissonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_path_len(s : MlregresspoissonPath) -> Int { s.size }

pub fn ml_regress_poisson_path_get(s : MlregresspoissonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_path_set(s : MlregresspoissonPath, i : Int, v : Double) -> MlregresspoissonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_path_sum(s : MlregresspoissonPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_path_mean(s : MlregresspoissonPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_path_scale(s : MlregresspoissonPath, f : Double) -> MlregresspoissonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_path_add(a : MlregresspoissonPath, b : MlregresspoissonPath) -> MlregresspoissonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_path_copy(s : MlregresspoissonPath) -> MlregresspoissonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_path_fill(s : MlregresspoissonPath, v : Double) -> MlregresspoissonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_path_min(s : MlregresspoissonPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_path_max(s : MlregresspoissonPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_path_to_string(s : MlregresspoissonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_cluster_make(size : Int) -> MlregresspoissonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_cluster_len(s : MlregresspoissonCluster) -> Int { s.size }

pub fn ml_regress_poisson_cluster_get(s : MlregresspoissonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_cluster_set(s : MlregresspoissonCluster, i : Int, v : Double) -> MlregresspoissonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cluster_sum(s : MlregresspoissonCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_cluster_mean(s : MlregresspoissonCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_cluster_scale(s : MlregresspoissonCluster, f : Double) -> MlregresspoissonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cluster_add(a : MlregresspoissonCluster, b : MlregresspoissonCluster) -> MlregresspoissonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_cluster_copy(s : MlregresspoissonCluster) -> MlregresspoissonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cluster_fill(s : MlregresspoissonCluster, v : Double) -> MlregresspoissonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cluster_min(s : MlregresspoissonCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_cluster_max(s : MlregresspoissonCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_cluster_to_string(s : MlregresspoissonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_model_make(size : Int) -> MlregresspoissonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_model_len(s : MlregresspoissonModel) -> Int { s.size }

pub fn ml_regress_poisson_model_get(s : MlregresspoissonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_model_set(s : MlregresspoissonModel, i : Int, v : Double) -> MlregresspoissonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_model_sum(s : MlregresspoissonModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_model_mean(s : MlregresspoissonModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_model_scale(s : MlregresspoissonModel, f : Double) -> MlregresspoissonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_model_add(a : MlregresspoissonModel, b : MlregresspoissonModel) -> MlregresspoissonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_model_copy(s : MlregresspoissonModel) -> MlregresspoissonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_model_fill(s : MlregresspoissonModel, v : Double) -> MlregresspoissonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_model_min(s : MlregresspoissonModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_model_max(s : MlregresspoissonModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_model_to_string(s : MlregresspoissonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_layer_make(size : Int) -> MlregresspoissonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_layer_len(s : MlregresspoissonLayer) -> Int { s.size }

pub fn ml_regress_poisson_layer_get(s : MlregresspoissonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_layer_set(s : MlregresspoissonLayer, i : Int, v : Double) -> MlregresspoissonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_layer_sum(s : MlregresspoissonLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_layer_mean(s : MlregresspoissonLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_layer_scale(s : MlregresspoissonLayer, f : Double) -> MlregresspoissonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_layer_add(a : MlregresspoissonLayer, b : MlregresspoissonLayer) -> MlregresspoissonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_layer_copy(s : MlregresspoissonLayer) -> MlregresspoissonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_layer_fill(s : MlregresspoissonLayer, v : Double) -> MlregresspoissonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_layer_min(s : MlregresspoissonLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_layer_max(s : MlregresspoissonLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_layer_to_string(s : MlregresspoissonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_buffer_make(size : Int) -> MlregresspoissonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_buffer_len(s : MlregresspoissonBuffer) -> Int { s.size }

pub fn ml_regress_poisson_buffer_get(s : MlregresspoissonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_buffer_set(s : MlregresspoissonBuffer, i : Int, v : Double) -> MlregresspoissonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_buffer_sum(s : MlregresspoissonBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_buffer_mean(s : MlregresspoissonBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_buffer_scale(s : MlregresspoissonBuffer, f : Double) -> MlregresspoissonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_buffer_add(a : MlregresspoissonBuffer, b : MlregresspoissonBuffer) -> MlregresspoissonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_buffer_copy(s : MlregresspoissonBuffer) -> MlregresspoissonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_buffer_fill(s : MlregresspoissonBuffer, v : Double) -> MlregresspoissonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_buffer_min(s : MlregresspoissonBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_buffer_max(s : MlregresspoissonBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_buffer_to_string(s : MlregresspoissonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_cursor_make(size : Int) -> MlregresspoissonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_cursor_len(s : MlregresspoissonCursor) -> Int { s.size }

pub fn ml_regress_poisson_cursor_get(s : MlregresspoissonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_cursor_set(s : MlregresspoissonCursor, i : Int, v : Double) -> MlregresspoissonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cursor_sum(s : MlregresspoissonCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_cursor_mean(s : MlregresspoissonCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_cursor_scale(s : MlregresspoissonCursor, f : Double) -> MlregresspoissonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cursor_add(a : MlregresspoissonCursor, b : MlregresspoissonCursor) -> MlregresspoissonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_cursor_copy(s : MlregresspoissonCursor) -> MlregresspoissonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cursor_fill(s : MlregresspoissonCursor, v : Double) -> MlregresspoissonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_cursor_min(s : MlregresspoissonCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_cursor_max(s : MlregresspoissonCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_cursor_to_string(s : MlregresspoissonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_view_make(size : Int) -> MlregresspoissonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_view_len(s : MlregresspoissonView) -> Int { s.size }

pub fn ml_regress_poisson_view_get(s : MlregresspoissonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_view_set(s : MlregresspoissonView, i : Int, v : Double) -> MlregresspoissonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_view_sum(s : MlregresspoissonView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_view_mean(s : MlregresspoissonView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_view_scale(s : MlregresspoissonView, f : Double) -> MlregresspoissonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_view_add(a : MlregresspoissonView, b : MlregresspoissonView) -> MlregresspoissonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_view_copy(s : MlregresspoissonView) -> MlregresspoissonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_view_fill(s : MlregresspoissonView, v : Double) -> MlregresspoissonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_view_min(s : MlregresspoissonView) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_view_max(s : MlregresspoissonView) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_view_to_string(s : MlregresspoissonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_range_make(size : Int) -> MlregresspoissonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_range_len(s : MlregresspoissonRange) -> Int { s.size }

pub fn ml_regress_poisson_range_get(s : MlregresspoissonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_range_set(s : MlregresspoissonRange, i : Int, v : Double) -> MlregresspoissonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_range_sum(s : MlregresspoissonRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_range_mean(s : MlregresspoissonRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_range_scale(s : MlregresspoissonRange, f : Double) -> MlregresspoissonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_range_add(a : MlregresspoissonRange, b : MlregresspoissonRange) -> MlregresspoissonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_range_copy(s : MlregresspoissonRange) -> MlregresspoissonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_range_fill(s : MlregresspoissonRange, v : Double) -> MlregresspoissonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_range_min(s : MlregresspoissonRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_range_max(s : MlregresspoissonRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_range_to_string(s : MlregresspoissonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspoissonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poisson_slice_make(size : Int) -> MlregresspoissonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poisson_slice_len(s : MlregresspoissonSlice) -> Int { s.size }

pub fn ml_regress_poisson_slice_get(s : MlregresspoissonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poisson_slice_set(s : MlregresspoissonSlice, i : Int, v : Double) -> MlregresspoissonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_slice_sum(s : MlregresspoissonSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poisson_slice_mean(s : MlregresspoissonSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poisson_slice_scale(s : MlregresspoissonSlice, f : Double) -> MlregresspoissonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_slice_add(a : MlregresspoissonSlice, b : MlregresspoissonSlice) -> MlregresspoissonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poisson_slice_copy(s : MlregresspoissonSlice) -> MlregresspoissonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_slice_fill(s : MlregresspoissonSlice, v : Double) -> MlregresspoissonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poisson_slice_min(s : MlregresspoissonSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_poisson_slice_max(s : MlregresspoissonSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_poisson_slice_to_string(s : MlregresspoissonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

