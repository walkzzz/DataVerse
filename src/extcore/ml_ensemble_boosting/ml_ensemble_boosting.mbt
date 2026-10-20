///===
/// extcore/ml_ensemble_boosting

pub(all) struct MlensembleboostingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_boosting_make_point(x : Double, y : Double) -> MlensembleboostingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_boosting_make_point3(x : Double, y : Double, z : Double) -> MlensembleboostingPoint {
  { x, y, z, label: 0 }
}

pub fn MlensembleboostingPoint::x(self : MlensembleboostingPoint) -> Double { self.x }

pub fn MlensembleboostingPoint::y(self : MlensembleboostingPoint) -> Double { self.y }

pub fn MlensembleboostingPoint::z(self : MlensembleboostingPoint) -> Double { self.z }

pub fn MlensembleboostingPoint::label(self : MlensembleboostingPoint) -> Int { self.label }

pub fn MlensembleboostingPoint::dist(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensembleboostingPoint::add(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensembleboostingPoint::sub(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensembleboostingPoint::scale(self : MlensembleboostingPoint, s : Double) -> MlensembleboostingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensembleboostingPoint::dot(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensembleboostingPoint::cross(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensembleboostingPoint::norm(self : MlensembleboostingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensembleboostingPoint::normalize(self : MlensembleboostingPoint) -> MlensembleboostingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleboostingPoint::negate(self : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensembleboostingPoint::mid(self : MlensembleboostingPoint, other : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensembleboostingPoint::lerp(self : MlensembleboostingPoint, other : MlensembleboostingPoint, t : Double) -> MlensembleboostingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensembleboostingPoint::to_string(self : MlensembleboostingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensembleboostingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_boosting_make_series(vals : Array[Double], name : String) -> MlensembleboostingSeries {
  { vals, name, meta: 0 }
}

pub fn MlensembleboostingSeries::len(self : MlensembleboostingSeries) -> Int { self.vals.length() }

pub fn MlensembleboostingSeries::sum(self : MlensembleboostingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensembleboostingSeries::mean(self : MlensembleboostingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensembleboostingSeries::min(self : MlensembleboostingSeries) -> Double { @_common.min(self.vals) }

pub fn MlensembleboostingSeries::max(self : MlensembleboostingSeries) -> Double { @_common.max(self.vals) }

pub fn MlensembleboostingSeries::range(self : MlensembleboostingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensembleboostingSeries::variance(self : MlensembleboostingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensembleboostingSeries::std(self : MlensembleboostingSeries) -> Double { @_common.std(self.vals) }

pub fn MlensembleboostingSeries::median(self : MlensembleboostingSeries) -> Double { @_common.median(self.vals) }

pub fn MlensembleboostingSeries::scale(self : MlensembleboostingSeries, f : Double) -> MlensembleboostingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensembleboostingSeries::add(self : MlensembleboostingSeries, other : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensembleboostingSeries::sub(self : MlensembleboostingSeries, other : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensembleboostingSeries::normalize(self : MlensembleboostingSeries) -> MlensembleboostingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensembleboostingSeries::cumsum(self : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensembleboostingSeries::to_string(self : MlensembleboostingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleboostingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_boosting_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleboostingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_boosting_matrix_identity(n : Int) -> MlensembleboostingMatrix {
  let m = ml_ensemble_boosting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensembleboostingMatrix::get(self : MlensembleboostingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensembleboostingMatrix::transpose(self : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  let result = ml_ensemble_boosting_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensembleboostingMatrix::add(self : MlensembleboostingMatrix, other : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_boosting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensembleboostingMatrix::scale(self : MlensembleboostingMatrix, s : Double) -> MlensembleboostingMatrix {
  let result = ml_ensemble_boosting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensembleboostingMatrix::multiply(self : MlensembleboostingMatrix, other : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  if self.cols != other.rows { return ml_ensemble_boosting_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_boosting_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensembleboostingMatrix::trace(self : MlensembleboostingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensembleboostingMatrix::det(self : MlensembleboostingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensembleboostingMatrix::norm(self : MlensembleboostingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensembleboostingMatrix::to_string(self : MlensembleboostingMatrix) -> String {
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

pub(all) struct MlensembleboostingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_boosting_make_vector(comps : Array[Double]) -> MlensembleboostingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_boosting_vector_zero(dim : Int) -> MlensembleboostingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensembleboostingVector::add(self : MlensembleboostingVector, other : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleboostingVector::sub(self : MlensembleboostingVector, other : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleboostingVector::scale(self : MlensembleboostingVector, s : Double) -> MlensembleboostingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensembleboostingVector::dot(self : MlensembleboostingVector, other : MlensembleboostingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensembleboostingVector::norm(self : MlensembleboostingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensembleboostingVector::normalize(self : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleboostingVector::dist(self : MlensembleboostingVector, other : MlensembleboostingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensembleboostingVector::to_string(self : MlensembleboostingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_boosting_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_boosting_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_boosting_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_boosting_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_boosting_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_boosting_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_boosting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_boosting_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_boosting_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_boosting_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_boosting_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_boosting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_boosting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_boosting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_boosting_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_boosting_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_boosting_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_boosting_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_boosting_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_boosting_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_boosting_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_boosting_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_boosting_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_boosting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_boosting_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_boosting_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_boosting_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_boosting_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_boosting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensembleboostingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_frame_make(size : Int) -> MlensembleboostingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_frame_len(s : MlensembleboostingFrame) -> Int { s.size }

pub fn ml_ensemble_boosting_frame_get(s : MlensembleboostingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_frame_set(s : MlensembleboostingFrame, i : Int, v : Double) -> MlensembleboostingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_frame_sum(s : MlensembleboostingFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_frame_mean(s : MlensembleboostingFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_frame_scale(s : MlensembleboostingFrame, f : Double) -> MlensembleboostingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_frame_add(a : MlensembleboostingFrame, b : MlensembleboostingFrame) -> MlensembleboostingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_frame_copy(s : MlensembleboostingFrame) -> MlensembleboostingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_frame_fill(s : MlensembleboostingFrame, v : Double) -> MlensembleboostingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_frame_min(s : MlensembleboostingFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_frame_max(s : MlensembleboostingFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_frame_to_string(s : MlensembleboostingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_table_make(size : Int) -> MlensembleboostingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_table_len(s : MlensembleboostingTable) -> Int { s.size }

pub fn ml_ensemble_boosting_table_get(s : MlensembleboostingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_table_set(s : MlensembleboostingTable, i : Int, v : Double) -> MlensembleboostingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_table_sum(s : MlensembleboostingTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_table_mean(s : MlensembleboostingTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_table_scale(s : MlensembleboostingTable, f : Double) -> MlensembleboostingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_table_add(a : MlensembleboostingTable, b : MlensembleboostingTable) -> MlensembleboostingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_table_copy(s : MlensembleboostingTable) -> MlensembleboostingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_table_fill(s : MlensembleboostingTable, v : Double) -> MlensembleboostingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_table_min(s : MlensembleboostingTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_table_max(s : MlensembleboostingTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_table_to_string(s : MlensembleboostingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_graphn_make(size : Int) -> MlensembleboostingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_graphn_len(s : MlensembleboostingGraphN) -> Int { s.size }

pub fn ml_ensemble_boosting_graphn_get(s : MlensembleboostingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_graphn_set(s : MlensembleboostingGraphN, i : Int, v : Double) -> MlensembleboostingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_graphn_sum(s : MlensembleboostingGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_graphn_mean(s : MlensembleboostingGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_graphn_scale(s : MlensembleboostingGraphN, f : Double) -> MlensembleboostingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_graphn_add(a : MlensembleboostingGraphN, b : MlensembleboostingGraphN) -> MlensembleboostingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_graphn_copy(s : MlensembleboostingGraphN) -> MlensembleboostingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_graphn_fill(s : MlensembleboostingGraphN, v : Double) -> MlensembleboostingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_graphn_min(s : MlensembleboostingGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_graphn_max(s : MlensembleboostingGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_graphn_to_string(s : MlensembleboostingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_node_make(size : Int) -> MlensembleboostingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_node_len(s : MlensembleboostingNode) -> Int { s.size }

pub fn ml_ensemble_boosting_node_get(s : MlensembleboostingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_node_set(s : MlensembleboostingNode, i : Int, v : Double) -> MlensembleboostingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_node_sum(s : MlensembleboostingNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_node_mean(s : MlensembleboostingNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_node_scale(s : MlensembleboostingNode, f : Double) -> MlensembleboostingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_node_add(a : MlensembleboostingNode, b : MlensembleboostingNode) -> MlensembleboostingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_node_copy(s : MlensembleboostingNode) -> MlensembleboostingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_node_fill(s : MlensembleboostingNode, v : Double) -> MlensembleboostingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_node_min(s : MlensembleboostingNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_node_max(s : MlensembleboostingNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_node_to_string(s : MlensembleboostingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_edge_make(size : Int) -> MlensembleboostingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_edge_len(s : MlensembleboostingEdge) -> Int { s.size }

pub fn ml_ensemble_boosting_edge_get(s : MlensembleboostingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_edge_set(s : MlensembleboostingEdge, i : Int, v : Double) -> MlensembleboostingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_edge_sum(s : MlensembleboostingEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_edge_mean(s : MlensembleboostingEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_edge_scale(s : MlensembleboostingEdge, f : Double) -> MlensembleboostingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_edge_add(a : MlensembleboostingEdge, b : MlensembleboostingEdge) -> MlensembleboostingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_edge_copy(s : MlensembleboostingEdge) -> MlensembleboostingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_edge_fill(s : MlensembleboostingEdge, v : Double) -> MlensembleboostingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_edge_min(s : MlensembleboostingEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_edge_max(s : MlensembleboostingEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_edge_to_string(s : MlensembleboostingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_path_make(size : Int) -> MlensembleboostingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_path_len(s : MlensembleboostingPath) -> Int { s.size }

pub fn ml_ensemble_boosting_path_get(s : MlensembleboostingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_path_set(s : MlensembleboostingPath, i : Int, v : Double) -> MlensembleboostingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_path_sum(s : MlensembleboostingPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_path_mean(s : MlensembleboostingPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_path_scale(s : MlensembleboostingPath, f : Double) -> MlensembleboostingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_path_add(a : MlensembleboostingPath, b : MlensembleboostingPath) -> MlensembleboostingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_path_copy(s : MlensembleboostingPath) -> MlensembleboostingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_path_fill(s : MlensembleboostingPath, v : Double) -> MlensembleboostingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_path_min(s : MlensembleboostingPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_path_max(s : MlensembleboostingPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_path_to_string(s : MlensembleboostingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_cluster_make(size : Int) -> MlensembleboostingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_cluster_len(s : MlensembleboostingCluster) -> Int { s.size }

pub fn ml_ensemble_boosting_cluster_get(s : MlensembleboostingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_cluster_set(s : MlensembleboostingCluster, i : Int, v : Double) -> MlensembleboostingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cluster_sum(s : MlensembleboostingCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_cluster_mean(s : MlensembleboostingCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_cluster_scale(s : MlensembleboostingCluster, f : Double) -> MlensembleboostingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cluster_add(a : MlensembleboostingCluster, b : MlensembleboostingCluster) -> MlensembleboostingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_cluster_copy(s : MlensembleboostingCluster) -> MlensembleboostingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cluster_fill(s : MlensembleboostingCluster, v : Double) -> MlensembleboostingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cluster_min(s : MlensembleboostingCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_cluster_max(s : MlensembleboostingCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_cluster_to_string(s : MlensembleboostingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_model_make(size : Int) -> MlensembleboostingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_model_len(s : MlensembleboostingModel) -> Int { s.size }

pub fn ml_ensemble_boosting_model_get(s : MlensembleboostingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_model_set(s : MlensembleboostingModel, i : Int, v : Double) -> MlensembleboostingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_model_sum(s : MlensembleboostingModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_model_mean(s : MlensembleboostingModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_model_scale(s : MlensembleboostingModel, f : Double) -> MlensembleboostingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_model_add(a : MlensembleboostingModel, b : MlensembleboostingModel) -> MlensembleboostingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_model_copy(s : MlensembleboostingModel) -> MlensembleboostingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_model_fill(s : MlensembleboostingModel, v : Double) -> MlensembleboostingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_model_min(s : MlensembleboostingModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_model_max(s : MlensembleboostingModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_model_to_string(s : MlensembleboostingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_layer_make(size : Int) -> MlensembleboostingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_layer_len(s : MlensembleboostingLayer) -> Int { s.size }

pub fn ml_ensemble_boosting_layer_get(s : MlensembleboostingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_layer_set(s : MlensembleboostingLayer, i : Int, v : Double) -> MlensembleboostingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_layer_sum(s : MlensembleboostingLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_layer_mean(s : MlensembleboostingLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_layer_scale(s : MlensembleboostingLayer, f : Double) -> MlensembleboostingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_layer_add(a : MlensembleboostingLayer, b : MlensembleboostingLayer) -> MlensembleboostingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_layer_copy(s : MlensembleboostingLayer) -> MlensembleboostingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_layer_fill(s : MlensembleboostingLayer, v : Double) -> MlensembleboostingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_layer_min(s : MlensembleboostingLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_layer_max(s : MlensembleboostingLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_layer_to_string(s : MlensembleboostingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_buffer_make(size : Int) -> MlensembleboostingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_buffer_len(s : MlensembleboostingBuffer) -> Int { s.size }

pub fn ml_ensemble_boosting_buffer_get(s : MlensembleboostingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_buffer_set(s : MlensembleboostingBuffer, i : Int, v : Double) -> MlensembleboostingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_buffer_sum(s : MlensembleboostingBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_buffer_mean(s : MlensembleboostingBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_buffer_scale(s : MlensembleboostingBuffer, f : Double) -> MlensembleboostingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_buffer_add(a : MlensembleboostingBuffer, b : MlensembleboostingBuffer) -> MlensembleboostingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_buffer_copy(s : MlensembleboostingBuffer) -> MlensembleboostingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_buffer_fill(s : MlensembleboostingBuffer, v : Double) -> MlensembleboostingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_buffer_min(s : MlensembleboostingBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_buffer_max(s : MlensembleboostingBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_buffer_to_string(s : MlensembleboostingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_cursor_make(size : Int) -> MlensembleboostingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_cursor_len(s : MlensembleboostingCursor) -> Int { s.size }

pub fn ml_ensemble_boosting_cursor_get(s : MlensembleboostingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_cursor_set(s : MlensembleboostingCursor, i : Int, v : Double) -> MlensembleboostingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cursor_sum(s : MlensembleboostingCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_cursor_mean(s : MlensembleboostingCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_cursor_scale(s : MlensembleboostingCursor, f : Double) -> MlensembleboostingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cursor_add(a : MlensembleboostingCursor, b : MlensembleboostingCursor) -> MlensembleboostingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_cursor_copy(s : MlensembleboostingCursor) -> MlensembleboostingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cursor_fill(s : MlensembleboostingCursor, v : Double) -> MlensembleboostingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_cursor_min(s : MlensembleboostingCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_cursor_max(s : MlensembleboostingCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_cursor_to_string(s : MlensembleboostingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_view_make(size : Int) -> MlensembleboostingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_view_len(s : MlensembleboostingView) -> Int { s.size }

pub fn ml_ensemble_boosting_view_get(s : MlensembleboostingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_view_set(s : MlensembleboostingView, i : Int, v : Double) -> MlensembleboostingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_view_sum(s : MlensembleboostingView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_view_mean(s : MlensembleboostingView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_view_scale(s : MlensembleboostingView, f : Double) -> MlensembleboostingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_view_add(a : MlensembleboostingView, b : MlensembleboostingView) -> MlensembleboostingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_view_copy(s : MlensembleboostingView) -> MlensembleboostingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_view_fill(s : MlensembleboostingView, v : Double) -> MlensembleboostingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_view_min(s : MlensembleboostingView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_view_max(s : MlensembleboostingView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_view_to_string(s : MlensembleboostingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_range_make(size : Int) -> MlensembleboostingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_range_len(s : MlensembleboostingRange) -> Int { s.size }

pub fn ml_ensemble_boosting_range_get(s : MlensembleboostingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_range_set(s : MlensembleboostingRange, i : Int, v : Double) -> MlensembleboostingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_range_sum(s : MlensembleboostingRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_range_mean(s : MlensembleboostingRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_range_scale(s : MlensembleboostingRange, f : Double) -> MlensembleboostingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_range_add(a : MlensembleboostingRange, b : MlensembleboostingRange) -> MlensembleboostingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_range_copy(s : MlensembleboostingRange) -> MlensembleboostingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_range_fill(s : MlensembleboostingRange, v : Double) -> MlensembleboostingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_range_min(s : MlensembleboostingRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_range_max(s : MlensembleboostingRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_range_to_string(s : MlensembleboostingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_slice_make(size : Int) -> MlensembleboostingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_slice_len(s : MlensembleboostingSlice) -> Int { s.size }

pub fn ml_ensemble_boosting_slice_get(s : MlensembleboostingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_slice_set(s : MlensembleboostingSlice, i : Int, v : Double) -> MlensembleboostingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_slice_sum(s : MlensembleboostingSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_boosting_slice_mean(s : MlensembleboostingSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_boosting_slice_scale(s : MlensembleboostingSlice, f : Double) -> MlensembleboostingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_slice_add(a : MlensembleboostingSlice, b : MlensembleboostingSlice) -> MlensembleboostingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_boosting_slice_copy(s : MlensembleboostingSlice) -> MlensembleboostingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_slice_fill(s : MlensembleboostingSlice, v : Double) -> MlensembleboostingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_boosting_slice_min(s : MlensembleboostingSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_boosting_slice_max(s : MlensembleboostingSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_boosting_slice_to_string(s : MlensembleboostingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

