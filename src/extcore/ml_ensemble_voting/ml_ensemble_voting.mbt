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

pub fn MlensemblevotingFrame::len(self : MlensemblevotingFrame) -> Int { self.size }

pub fn MlensemblevotingFrame::get(self : MlensemblevotingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingFrame::set(self : MlensemblevotingFrame, i : Int, v : Double) -> MlensemblevotingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingFrame::sum(self : MlensemblevotingFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingFrame::mean(self : MlensemblevotingFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingFrame::scale(self : MlensemblevotingFrame, f : Double) -> MlensemblevotingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingFrame::add(self : MlensemblevotingFrame, other : MlensemblevotingFrame) -> MlensemblevotingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingFrame::copy(self : MlensemblevotingFrame) -> MlensemblevotingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingFrame::fill(self : MlensemblevotingFrame, v : Double) -> MlensemblevotingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingFrame::min(self : MlensemblevotingFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingFrame::max(self : MlensemblevotingFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingFrame::to_string(self : MlensemblevotingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_table_make(size : Int) -> MlensemblevotingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingTable::len(self : MlensemblevotingTable) -> Int { self.size }

pub fn MlensemblevotingTable::get(self : MlensemblevotingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingTable::set(self : MlensemblevotingTable, i : Int, v : Double) -> MlensemblevotingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingTable::sum(self : MlensemblevotingTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingTable::mean(self : MlensemblevotingTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingTable::scale(self : MlensemblevotingTable, f : Double) -> MlensemblevotingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingTable::add(self : MlensemblevotingTable, other : MlensemblevotingTable) -> MlensemblevotingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingTable::copy(self : MlensemblevotingTable) -> MlensemblevotingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingTable::fill(self : MlensemblevotingTable, v : Double) -> MlensemblevotingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingTable::min(self : MlensemblevotingTable) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingTable::max(self : MlensemblevotingTable) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingTable::to_string(self : MlensemblevotingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_graphn_make(size : Int) -> MlensemblevotingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingGraphN::len(self : MlensemblevotingGraphN) -> Int { self.size }

pub fn MlensemblevotingGraphN::get(self : MlensemblevotingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingGraphN::set(self : MlensemblevotingGraphN, i : Int, v : Double) -> MlensemblevotingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingGraphN::sum(self : MlensemblevotingGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingGraphN::mean(self : MlensemblevotingGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingGraphN::scale(self : MlensemblevotingGraphN, f : Double) -> MlensemblevotingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingGraphN::add(self : MlensemblevotingGraphN, other : MlensemblevotingGraphN) -> MlensemblevotingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingGraphN::copy(self : MlensemblevotingGraphN) -> MlensemblevotingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingGraphN::fill(self : MlensemblevotingGraphN, v : Double) -> MlensemblevotingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingGraphN::min(self : MlensemblevotingGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingGraphN::max(self : MlensemblevotingGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingGraphN::to_string(self : MlensemblevotingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_node_make(size : Int) -> MlensemblevotingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingNode::len(self : MlensemblevotingNode) -> Int { self.size }

pub fn MlensemblevotingNode::get(self : MlensemblevotingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingNode::set(self : MlensemblevotingNode, i : Int, v : Double) -> MlensemblevotingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingNode::sum(self : MlensemblevotingNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingNode::mean(self : MlensemblevotingNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingNode::scale(self : MlensemblevotingNode, f : Double) -> MlensemblevotingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingNode::add(self : MlensemblevotingNode, other : MlensemblevotingNode) -> MlensemblevotingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingNode::copy(self : MlensemblevotingNode) -> MlensemblevotingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingNode::fill(self : MlensemblevotingNode, v : Double) -> MlensemblevotingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingNode::min(self : MlensemblevotingNode) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingNode::max(self : MlensemblevotingNode) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingNode::to_string(self : MlensemblevotingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_edge_make(size : Int) -> MlensemblevotingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingEdge::len(self : MlensemblevotingEdge) -> Int { self.size }

pub fn MlensemblevotingEdge::get(self : MlensemblevotingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingEdge::set(self : MlensemblevotingEdge, i : Int, v : Double) -> MlensemblevotingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingEdge::sum(self : MlensemblevotingEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingEdge::mean(self : MlensemblevotingEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingEdge::scale(self : MlensemblevotingEdge, f : Double) -> MlensemblevotingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingEdge::add(self : MlensemblevotingEdge, other : MlensemblevotingEdge) -> MlensemblevotingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingEdge::copy(self : MlensemblevotingEdge) -> MlensemblevotingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingEdge::fill(self : MlensemblevotingEdge, v : Double) -> MlensemblevotingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingEdge::min(self : MlensemblevotingEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingEdge::max(self : MlensemblevotingEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingEdge::to_string(self : MlensemblevotingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_path_make(size : Int) -> MlensemblevotingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingPath::len(self : MlensemblevotingPath) -> Int { self.size }

pub fn MlensemblevotingPath::get(self : MlensemblevotingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingPath::set(self : MlensemblevotingPath, i : Int, v : Double) -> MlensemblevotingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingPath::sum(self : MlensemblevotingPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingPath::mean(self : MlensemblevotingPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingPath::scale(self : MlensemblevotingPath, f : Double) -> MlensemblevotingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingPath::add(self : MlensemblevotingPath, other : MlensemblevotingPath) -> MlensemblevotingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingPath::copy(self : MlensemblevotingPath) -> MlensemblevotingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingPath::fill(self : MlensemblevotingPath, v : Double) -> MlensemblevotingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingPath::min(self : MlensemblevotingPath) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingPath::max(self : MlensemblevotingPath) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingPath::to_string(self : MlensemblevotingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_cluster_make(size : Int) -> MlensemblevotingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingCluster::len(self : MlensemblevotingCluster) -> Int { self.size }

pub fn MlensemblevotingCluster::get(self : MlensemblevotingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingCluster::set(self : MlensemblevotingCluster, i : Int, v : Double) -> MlensemblevotingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCluster::sum(self : MlensemblevotingCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingCluster::mean(self : MlensemblevotingCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingCluster::scale(self : MlensemblevotingCluster, f : Double) -> MlensemblevotingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCluster::add(self : MlensemblevotingCluster, other : MlensemblevotingCluster) -> MlensemblevotingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingCluster::copy(self : MlensemblevotingCluster) -> MlensemblevotingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCluster::fill(self : MlensemblevotingCluster, v : Double) -> MlensemblevotingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCluster::min(self : MlensemblevotingCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingCluster::max(self : MlensemblevotingCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingCluster::to_string(self : MlensemblevotingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_model_make(size : Int) -> MlensemblevotingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingModel::len(self : MlensemblevotingModel) -> Int { self.size }

pub fn MlensemblevotingModel::get(self : MlensemblevotingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingModel::set(self : MlensemblevotingModel, i : Int, v : Double) -> MlensemblevotingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingModel::sum(self : MlensemblevotingModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingModel::mean(self : MlensemblevotingModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingModel::scale(self : MlensemblevotingModel, f : Double) -> MlensemblevotingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingModel::add(self : MlensemblevotingModel, other : MlensemblevotingModel) -> MlensemblevotingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingModel::copy(self : MlensemblevotingModel) -> MlensemblevotingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingModel::fill(self : MlensemblevotingModel, v : Double) -> MlensemblevotingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingModel::min(self : MlensemblevotingModel) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingModel::max(self : MlensemblevotingModel) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingModel::to_string(self : MlensemblevotingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_layer_make(size : Int) -> MlensemblevotingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingLayer::len(self : MlensemblevotingLayer) -> Int { self.size }

pub fn MlensemblevotingLayer::get(self : MlensemblevotingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingLayer::set(self : MlensemblevotingLayer, i : Int, v : Double) -> MlensemblevotingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingLayer::sum(self : MlensemblevotingLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingLayer::mean(self : MlensemblevotingLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingLayer::scale(self : MlensemblevotingLayer, f : Double) -> MlensemblevotingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingLayer::add(self : MlensemblevotingLayer, other : MlensemblevotingLayer) -> MlensemblevotingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingLayer::copy(self : MlensemblevotingLayer) -> MlensemblevotingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingLayer::fill(self : MlensemblevotingLayer, v : Double) -> MlensemblevotingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingLayer::min(self : MlensemblevotingLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingLayer::max(self : MlensemblevotingLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingLayer::to_string(self : MlensemblevotingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_buffer_make(size : Int) -> MlensemblevotingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingBuffer::len(self : MlensemblevotingBuffer) -> Int { self.size }

pub fn MlensemblevotingBuffer::get(self : MlensemblevotingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingBuffer::set(self : MlensemblevotingBuffer, i : Int, v : Double) -> MlensemblevotingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingBuffer::sum(self : MlensemblevotingBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingBuffer::mean(self : MlensemblevotingBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingBuffer::scale(self : MlensemblevotingBuffer, f : Double) -> MlensemblevotingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingBuffer::add(self : MlensemblevotingBuffer, other : MlensemblevotingBuffer) -> MlensemblevotingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingBuffer::copy(self : MlensemblevotingBuffer) -> MlensemblevotingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingBuffer::fill(self : MlensemblevotingBuffer, v : Double) -> MlensemblevotingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingBuffer::min(self : MlensemblevotingBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingBuffer::max(self : MlensemblevotingBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingBuffer::to_string(self : MlensemblevotingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_cursor_make(size : Int) -> MlensemblevotingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingCursor::len(self : MlensemblevotingCursor) -> Int { self.size }

pub fn MlensemblevotingCursor::get(self : MlensemblevotingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingCursor::set(self : MlensemblevotingCursor, i : Int, v : Double) -> MlensemblevotingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCursor::sum(self : MlensemblevotingCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingCursor::mean(self : MlensemblevotingCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingCursor::scale(self : MlensemblevotingCursor, f : Double) -> MlensemblevotingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCursor::add(self : MlensemblevotingCursor, other : MlensemblevotingCursor) -> MlensemblevotingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingCursor::copy(self : MlensemblevotingCursor) -> MlensemblevotingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCursor::fill(self : MlensemblevotingCursor, v : Double) -> MlensemblevotingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingCursor::min(self : MlensemblevotingCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingCursor::max(self : MlensemblevotingCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingCursor::to_string(self : MlensemblevotingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_view_make(size : Int) -> MlensemblevotingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingView::len(self : MlensemblevotingView) -> Int { self.size }

pub fn MlensemblevotingView::get(self : MlensemblevotingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingView::set(self : MlensemblevotingView, i : Int, v : Double) -> MlensemblevotingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingView::sum(self : MlensemblevotingView) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingView::mean(self : MlensemblevotingView) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingView::scale(self : MlensemblevotingView, f : Double) -> MlensemblevotingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingView::add(self : MlensemblevotingView, other : MlensemblevotingView) -> MlensemblevotingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingView::copy(self : MlensemblevotingView) -> MlensemblevotingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingView::fill(self : MlensemblevotingView, v : Double) -> MlensemblevotingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingView::min(self : MlensemblevotingView) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingView::max(self : MlensemblevotingView) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingView::to_string(self : MlensemblevotingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_range_make(size : Int) -> MlensemblevotingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingRange::len(self : MlensemblevotingRange) -> Int { self.size }

pub fn MlensemblevotingRange::get(self : MlensemblevotingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingRange::set(self : MlensemblevotingRange, i : Int, v : Double) -> MlensemblevotingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingRange::sum(self : MlensemblevotingRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingRange::mean(self : MlensemblevotingRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingRange::scale(self : MlensemblevotingRange, f : Double) -> MlensemblevotingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingRange::add(self : MlensemblevotingRange, other : MlensemblevotingRange) -> MlensemblevotingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingRange::copy(self : MlensemblevotingRange) -> MlensemblevotingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingRange::fill(self : MlensemblevotingRange, v : Double) -> MlensemblevotingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingRange::min(self : MlensemblevotingRange) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingRange::max(self : MlensemblevotingRange) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingRange::to_string(self : MlensemblevotingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_slice_make(size : Int) -> MlensemblevotingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblevotingSlice::len(self : MlensemblevotingSlice) -> Int { self.size }

pub fn MlensemblevotingSlice::get(self : MlensemblevotingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblevotingSlice::set(self : MlensemblevotingSlice, i : Int, v : Double) -> MlensemblevotingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblevotingSlice::sum(self : MlensemblevotingSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblevotingSlice::mean(self : MlensemblevotingSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblevotingSlice::scale(self : MlensemblevotingSlice, f : Double) -> MlensemblevotingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingSlice::add(self : MlensemblevotingSlice, other : MlensemblevotingSlice) -> MlensemblevotingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblevotingSlice::copy(self : MlensemblevotingSlice) -> MlensemblevotingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingSlice::fill(self : MlensemblevotingSlice, v : Double) -> MlensemblevotingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblevotingSlice::min(self : MlensemblevotingSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblevotingSlice::max(self : MlensemblevotingSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblevotingSlice::to_string(self : MlensemblevotingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

