///===
/// extcore/ml_ensemble_voting

pub(all) struct MlensemblevotingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_voting_make_point(x : Double, y : Double) -> MlensemblevotingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_voting_make_point3(x : Double, y : Double, z : Double) -> MlensemblevotingPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblevotingPoint::x(self : MlensemblevotingPoint) -> Double { self.x }

pub fn MlensemblevotingPoint::y(self : MlensemblevotingPoint) -> Double { self.y }

pub fn MlensemblevotingPoint::z(self : MlensemblevotingPoint) -> Double { self.z }

pub fn MlensemblevotingPoint::label(self : MlensemblevotingPoint) -> Int { self.label }

pub fn MlensemblevotingPoint::dist(self : MlensemblevotingPoint, other : MlensemblevotingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblevotingPoint::add(self : MlensemblevotingPoint, other : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblevotingPoint::sub(self : MlensemblevotingPoint, other : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblevotingPoint::scale(self : MlensemblevotingPoint, s : Double) -> MlensemblevotingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblevotingPoint::dot(self : MlensemblevotingPoint, other : MlensemblevotingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblevotingPoint::cross(self : MlensemblevotingPoint, other : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblevotingPoint::norm(self : MlensemblevotingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblevotingPoint::normalize(self : MlensemblevotingPoint) -> MlensemblevotingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblevotingPoint::negate(self : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblevotingPoint::mid(self : MlensemblevotingPoint, other : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblevotingPoint::lerp(self : MlensemblevotingPoint, other : MlensemblevotingPoint, t : Double) -> MlensemblevotingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblevotingPoint::to_string(self : MlensemblevotingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblevotingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_voting_make_series(vals : Array[Double], name : String) -> MlensemblevotingSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblevotingSeries::len(self : MlensemblevotingSeries) -> Int { self.vals.length() }

pub fn MlensemblevotingSeries::sum(self : MlensemblevotingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblevotingSeries::mean(self : MlensemblevotingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblevotingSeries::min(self : MlensemblevotingSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblevotingSeries::max(self : MlensemblevotingSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblevotingSeries::range(self : MlensemblevotingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblevotingSeries::variance(self : MlensemblevotingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblevotingSeries::std(self : MlensemblevotingSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblevotingSeries::median(self : MlensemblevotingSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblevotingSeries::scale(self : MlensemblevotingSeries, f : Double) -> MlensemblevotingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblevotingSeries::add(self : MlensemblevotingSeries, other : MlensemblevotingSeries) -> MlensemblevotingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblevotingSeries::sub(self : MlensemblevotingSeries, other : MlensemblevotingSeries) -> MlensemblevotingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblevotingSeries::normalize(self : MlensemblevotingSeries) -> MlensemblevotingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblevotingSeries::cumsum(self : MlensemblevotingSeries) -> MlensemblevotingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblevotingSeries::to_string(self : MlensemblevotingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblevotingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_voting_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblevotingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_voting_matrix_identity(n : Int) -> MlensemblevotingMatrix {
  let m = ml_ensemble_voting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblevotingMatrix::get(self : MlensemblevotingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblevotingMatrix::transpose(self : MlensemblevotingMatrix) -> MlensemblevotingMatrix {
  let result = ml_ensemble_voting_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblevotingMatrix::add(self : MlensemblevotingMatrix, other : MlensemblevotingMatrix) -> MlensemblevotingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_voting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblevotingMatrix::scale(self : MlensemblevotingMatrix, s : Double) -> MlensemblevotingMatrix {
  let result = ml_ensemble_voting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblevotingMatrix::multiply(self : MlensemblevotingMatrix, other : MlensemblevotingMatrix) -> MlensemblevotingMatrix {
  if self.cols != other.rows { return ml_ensemble_voting_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_voting_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblevotingMatrix::trace(self : MlensemblevotingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblevotingMatrix::det(self : MlensemblevotingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblevotingMatrix::norm(self : MlensemblevotingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblevotingMatrix::to_string(self : MlensemblevotingMatrix) -> String {
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

pub(all) struct MlensemblevotingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_voting_make_vector(comps : Array[Double]) -> MlensemblevotingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_voting_vector_zero(dim : Int) -> MlensemblevotingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblevotingVector::add(self : MlensemblevotingVector, other : MlensemblevotingVector) -> MlensemblevotingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblevotingVector::sub(self : MlensemblevotingVector, other : MlensemblevotingVector) -> MlensemblevotingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblevotingVector::scale(self : MlensemblevotingVector, s : Double) -> MlensemblevotingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblevotingVector::dot(self : MlensemblevotingVector, other : MlensemblevotingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblevotingVector::norm(self : MlensemblevotingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblevotingVector::normalize(self : MlensemblevotingVector) -> MlensemblevotingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblevotingVector::dist(self : MlensemblevotingVector, other : MlensemblevotingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblevotingVector::to_string(self : MlensemblevotingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_voting_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_voting_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_voting_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_voting_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_voting_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_voting_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_voting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_voting_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_voting_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_voting_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_voting_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_voting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_voting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_voting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_voting_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_voting_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_voting_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_voting_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_voting_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_voting_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_voting_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_voting_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_voting_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_voting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_voting_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_voting_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_voting_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_voting_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_voting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblevotingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_frame_make(size : Int) -> MlensemblevotingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_frame_len(s : MlensemblevotingFrame) -> Int { s.size }

pub fn ml_ensemble_voting_frame_get(s : MlensemblevotingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_frame_set(s : MlensemblevotingFrame, i : Int, v : Double) -> MlensemblevotingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_frame_sum(s : MlensemblevotingFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_frame_mean(s : MlensemblevotingFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_frame_scale(s : MlensemblevotingFrame, f : Double) -> MlensemblevotingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_frame_add(a : MlensemblevotingFrame, b : MlensemblevotingFrame) -> MlensemblevotingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_frame_copy(s : MlensemblevotingFrame) -> MlensemblevotingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_frame_fill(s : MlensemblevotingFrame, v : Double) -> MlensemblevotingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_frame_min(s : MlensemblevotingFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_frame_max(s : MlensemblevotingFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_frame_to_string(s : MlensemblevotingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_table_make(size : Int) -> MlensemblevotingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_table_len(s : MlensemblevotingTable) -> Int { s.size }

pub fn ml_ensemble_voting_table_get(s : MlensemblevotingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_table_set(s : MlensemblevotingTable, i : Int, v : Double) -> MlensemblevotingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_table_sum(s : MlensemblevotingTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_table_mean(s : MlensemblevotingTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_table_scale(s : MlensemblevotingTable, f : Double) -> MlensemblevotingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_table_add(a : MlensemblevotingTable, b : MlensemblevotingTable) -> MlensemblevotingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_table_copy(s : MlensemblevotingTable) -> MlensemblevotingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_table_fill(s : MlensemblevotingTable, v : Double) -> MlensemblevotingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_table_min(s : MlensemblevotingTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_table_max(s : MlensemblevotingTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_table_to_string(s : MlensemblevotingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_graphn_make(size : Int) -> MlensemblevotingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_graphn_len(s : MlensemblevotingGraphN) -> Int { s.size }

pub fn ml_ensemble_voting_graphn_get(s : MlensemblevotingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_graphn_set(s : MlensemblevotingGraphN, i : Int, v : Double) -> MlensemblevotingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_graphn_sum(s : MlensemblevotingGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_graphn_mean(s : MlensemblevotingGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_graphn_scale(s : MlensemblevotingGraphN, f : Double) -> MlensemblevotingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_graphn_add(a : MlensemblevotingGraphN, b : MlensemblevotingGraphN) -> MlensemblevotingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_graphn_copy(s : MlensemblevotingGraphN) -> MlensemblevotingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_graphn_fill(s : MlensemblevotingGraphN, v : Double) -> MlensemblevotingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_graphn_min(s : MlensemblevotingGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_graphn_max(s : MlensemblevotingGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_graphn_to_string(s : MlensemblevotingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_node_make(size : Int) -> MlensemblevotingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_node_len(s : MlensemblevotingNode) -> Int { s.size }

pub fn ml_ensemble_voting_node_get(s : MlensemblevotingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_node_set(s : MlensemblevotingNode, i : Int, v : Double) -> MlensemblevotingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_node_sum(s : MlensemblevotingNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_node_mean(s : MlensemblevotingNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_node_scale(s : MlensemblevotingNode, f : Double) -> MlensemblevotingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_node_add(a : MlensemblevotingNode, b : MlensemblevotingNode) -> MlensemblevotingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_node_copy(s : MlensemblevotingNode) -> MlensemblevotingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_node_fill(s : MlensemblevotingNode, v : Double) -> MlensemblevotingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_node_min(s : MlensemblevotingNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_node_max(s : MlensemblevotingNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_node_to_string(s : MlensemblevotingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_edge_make(size : Int) -> MlensemblevotingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_edge_len(s : MlensemblevotingEdge) -> Int { s.size }

pub fn ml_ensemble_voting_edge_get(s : MlensemblevotingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_edge_set(s : MlensemblevotingEdge, i : Int, v : Double) -> MlensemblevotingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_edge_sum(s : MlensemblevotingEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_edge_mean(s : MlensemblevotingEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_edge_scale(s : MlensemblevotingEdge, f : Double) -> MlensemblevotingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_edge_add(a : MlensemblevotingEdge, b : MlensemblevotingEdge) -> MlensemblevotingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_edge_copy(s : MlensemblevotingEdge) -> MlensemblevotingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_edge_fill(s : MlensemblevotingEdge, v : Double) -> MlensemblevotingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_edge_min(s : MlensemblevotingEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_edge_max(s : MlensemblevotingEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_edge_to_string(s : MlensemblevotingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_path_make(size : Int) -> MlensemblevotingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_path_len(s : MlensemblevotingPath) -> Int { s.size }

pub fn ml_ensemble_voting_path_get(s : MlensemblevotingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_path_set(s : MlensemblevotingPath, i : Int, v : Double) -> MlensemblevotingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_path_sum(s : MlensemblevotingPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_path_mean(s : MlensemblevotingPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_path_scale(s : MlensemblevotingPath, f : Double) -> MlensemblevotingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_path_add(a : MlensemblevotingPath, b : MlensemblevotingPath) -> MlensemblevotingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_path_copy(s : MlensemblevotingPath) -> MlensemblevotingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_path_fill(s : MlensemblevotingPath, v : Double) -> MlensemblevotingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_path_min(s : MlensemblevotingPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_path_max(s : MlensemblevotingPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_path_to_string(s : MlensemblevotingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_cluster_make(size : Int) -> MlensemblevotingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_cluster_len(s : MlensemblevotingCluster) -> Int { s.size }

pub fn ml_ensemble_voting_cluster_get(s : MlensemblevotingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_cluster_set(s : MlensemblevotingCluster, i : Int, v : Double) -> MlensemblevotingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cluster_sum(s : MlensemblevotingCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_cluster_mean(s : MlensemblevotingCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_cluster_scale(s : MlensemblevotingCluster, f : Double) -> MlensemblevotingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cluster_add(a : MlensemblevotingCluster, b : MlensemblevotingCluster) -> MlensemblevotingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_cluster_copy(s : MlensemblevotingCluster) -> MlensemblevotingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cluster_fill(s : MlensemblevotingCluster, v : Double) -> MlensemblevotingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cluster_min(s : MlensemblevotingCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_cluster_max(s : MlensemblevotingCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_cluster_to_string(s : MlensemblevotingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_model_make(size : Int) -> MlensemblevotingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_model_len(s : MlensemblevotingModel) -> Int { s.size }

pub fn ml_ensemble_voting_model_get(s : MlensemblevotingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_model_set(s : MlensemblevotingModel, i : Int, v : Double) -> MlensemblevotingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_model_sum(s : MlensemblevotingModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_model_mean(s : MlensemblevotingModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_model_scale(s : MlensemblevotingModel, f : Double) -> MlensemblevotingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_model_add(a : MlensemblevotingModel, b : MlensemblevotingModel) -> MlensemblevotingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_model_copy(s : MlensemblevotingModel) -> MlensemblevotingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_model_fill(s : MlensemblevotingModel, v : Double) -> MlensemblevotingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_model_min(s : MlensemblevotingModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_model_max(s : MlensemblevotingModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_model_to_string(s : MlensemblevotingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_layer_make(size : Int) -> MlensemblevotingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_layer_len(s : MlensemblevotingLayer) -> Int { s.size }

pub fn ml_ensemble_voting_layer_get(s : MlensemblevotingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_layer_set(s : MlensemblevotingLayer, i : Int, v : Double) -> MlensemblevotingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_layer_sum(s : MlensemblevotingLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_layer_mean(s : MlensemblevotingLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_layer_scale(s : MlensemblevotingLayer, f : Double) -> MlensemblevotingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_layer_add(a : MlensemblevotingLayer, b : MlensemblevotingLayer) -> MlensemblevotingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_layer_copy(s : MlensemblevotingLayer) -> MlensemblevotingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_layer_fill(s : MlensemblevotingLayer, v : Double) -> MlensemblevotingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_layer_min(s : MlensemblevotingLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_layer_max(s : MlensemblevotingLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_layer_to_string(s : MlensemblevotingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_buffer_make(size : Int) -> MlensemblevotingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_buffer_len(s : MlensemblevotingBuffer) -> Int { s.size }

pub fn ml_ensemble_voting_buffer_get(s : MlensemblevotingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_buffer_set(s : MlensemblevotingBuffer, i : Int, v : Double) -> MlensemblevotingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_buffer_sum(s : MlensemblevotingBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_buffer_mean(s : MlensemblevotingBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_buffer_scale(s : MlensemblevotingBuffer, f : Double) -> MlensemblevotingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_buffer_add(a : MlensemblevotingBuffer, b : MlensemblevotingBuffer) -> MlensemblevotingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_buffer_copy(s : MlensemblevotingBuffer) -> MlensemblevotingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_buffer_fill(s : MlensemblevotingBuffer, v : Double) -> MlensemblevotingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_buffer_min(s : MlensemblevotingBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_buffer_max(s : MlensemblevotingBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_buffer_to_string(s : MlensemblevotingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_cursor_make(size : Int) -> MlensemblevotingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_cursor_len(s : MlensemblevotingCursor) -> Int { s.size }

pub fn ml_ensemble_voting_cursor_get(s : MlensemblevotingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_cursor_set(s : MlensemblevotingCursor, i : Int, v : Double) -> MlensemblevotingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cursor_sum(s : MlensemblevotingCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_cursor_mean(s : MlensemblevotingCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_cursor_scale(s : MlensemblevotingCursor, f : Double) -> MlensemblevotingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cursor_add(a : MlensemblevotingCursor, b : MlensemblevotingCursor) -> MlensemblevotingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_cursor_copy(s : MlensemblevotingCursor) -> MlensemblevotingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cursor_fill(s : MlensemblevotingCursor, v : Double) -> MlensemblevotingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_cursor_min(s : MlensemblevotingCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_cursor_max(s : MlensemblevotingCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_cursor_to_string(s : MlensemblevotingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_view_make(size : Int) -> MlensemblevotingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_view_len(s : MlensemblevotingView) -> Int { s.size }

pub fn ml_ensemble_voting_view_get(s : MlensemblevotingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_view_set(s : MlensemblevotingView, i : Int, v : Double) -> MlensemblevotingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_view_sum(s : MlensemblevotingView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_view_mean(s : MlensemblevotingView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_view_scale(s : MlensemblevotingView, f : Double) -> MlensemblevotingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_view_add(a : MlensemblevotingView, b : MlensemblevotingView) -> MlensemblevotingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_view_copy(s : MlensemblevotingView) -> MlensemblevotingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_view_fill(s : MlensemblevotingView, v : Double) -> MlensemblevotingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_view_min(s : MlensemblevotingView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_view_max(s : MlensemblevotingView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_view_to_string(s : MlensemblevotingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_range_make(size : Int) -> MlensemblevotingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_range_len(s : MlensemblevotingRange) -> Int { s.size }

pub fn ml_ensemble_voting_range_get(s : MlensemblevotingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_range_set(s : MlensemblevotingRange, i : Int, v : Double) -> MlensemblevotingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_range_sum(s : MlensemblevotingRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_range_mean(s : MlensemblevotingRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_range_scale(s : MlensemblevotingRange, f : Double) -> MlensemblevotingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_range_add(a : MlensemblevotingRange, b : MlensemblevotingRange) -> MlensemblevotingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_range_copy(s : MlensemblevotingRange) -> MlensemblevotingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_range_fill(s : MlensemblevotingRange, v : Double) -> MlensemblevotingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_range_min(s : MlensemblevotingRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_range_max(s : MlensemblevotingRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_range_to_string(s : MlensemblevotingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_slice_make(size : Int) -> MlensemblevotingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_slice_len(s : MlensemblevotingSlice) -> Int { s.size }

pub fn ml_ensemble_voting_slice_get(s : MlensemblevotingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_slice_set(s : MlensemblevotingSlice, i : Int, v : Double) -> MlensemblevotingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_slice_sum(s : MlensemblevotingSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_voting_slice_mean(s : MlensemblevotingSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_voting_slice_scale(s : MlensemblevotingSlice, f : Double) -> MlensemblevotingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_slice_add(a : MlensemblevotingSlice, b : MlensemblevotingSlice) -> MlensemblevotingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_voting_slice_copy(s : MlensemblevotingSlice) -> MlensemblevotingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_slice_fill(s : MlensemblevotingSlice, v : Double) -> MlensemblevotingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_voting_slice_min(s : MlensemblevotingSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_voting_slice_max(s : MlensemblevotingSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_voting_slice_to_string(s : MlensemblevotingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

