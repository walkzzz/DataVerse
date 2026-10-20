///===
/// extcore/ml_ensemble_stacking

pub(all) struct MlensemblestackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_stacking_make_point(x : Double, y : Double) -> MlensemblestackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_stacking_make_point3(x : Double, y : Double, z : Double) -> MlensemblestackingPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblestackingPoint::x(self : MlensemblestackingPoint) -> Double { self.x }

pub fn MlensemblestackingPoint::y(self : MlensemblestackingPoint) -> Double { self.y }

pub fn MlensemblestackingPoint::z(self : MlensemblestackingPoint) -> Double { self.z }

pub fn MlensemblestackingPoint::label(self : MlensemblestackingPoint) -> Int { self.label }

pub fn MlensemblestackingPoint::dist(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblestackingPoint::add(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblestackingPoint::sub(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblestackingPoint::scale(self : MlensemblestackingPoint, s : Double) -> MlensemblestackingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblestackingPoint::dot(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblestackingPoint::cross(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblestackingPoint::norm(self : MlensemblestackingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblestackingPoint::normalize(self : MlensemblestackingPoint) -> MlensemblestackingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblestackingPoint::negate(self : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblestackingPoint::mid(self : MlensemblestackingPoint, other : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblestackingPoint::lerp(self : MlensemblestackingPoint, other : MlensemblestackingPoint, t : Double) -> MlensemblestackingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblestackingPoint::to_string(self : MlensemblestackingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblestackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_stacking_make_series(vals : Array[Double], name : String) -> MlensemblestackingSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblestackingSeries::len(self : MlensemblestackingSeries) -> Int { self.vals.length() }

pub fn MlensemblestackingSeries::sum(self : MlensemblestackingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblestackingSeries::mean(self : MlensemblestackingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblestackingSeries::min(self : MlensemblestackingSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblestackingSeries::max(self : MlensemblestackingSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblestackingSeries::range(self : MlensemblestackingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblestackingSeries::variance(self : MlensemblestackingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblestackingSeries::std(self : MlensemblestackingSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblestackingSeries::median(self : MlensemblestackingSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblestackingSeries::scale(self : MlensemblestackingSeries, f : Double) -> MlensemblestackingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblestackingSeries::add(self : MlensemblestackingSeries, other : MlensemblestackingSeries) -> MlensemblestackingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblestackingSeries::sub(self : MlensemblestackingSeries, other : MlensemblestackingSeries) -> MlensemblestackingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblestackingSeries::normalize(self : MlensemblestackingSeries) -> MlensemblestackingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblestackingSeries::cumsum(self : MlensemblestackingSeries) -> MlensemblestackingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblestackingSeries::to_string(self : MlensemblestackingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblestackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblestackingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_stacking_matrix_identity(n : Int) -> MlensemblestackingMatrix {
  let m = ml_ensemble_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblestackingMatrix::get(self : MlensemblestackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblestackingMatrix::transpose(self : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  let result = ml_ensemble_stacking_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblestackingMatrix::add(self : MlensemblestackingMatrix, other : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblestackingMatrix::scale(self : MlensemblestackingMatrix, s : Double) -> MlensemblestackingMatrix {
  let result = ml_ensemble_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblestackingMatrix::multiply(self : MlensemblestackingMatrix, other : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  if self.cols != other.rows { return ml_ensemble_stacking_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_stacking_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblestackingMatrix::trace(self : MlensemblestackingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblestackingMatrix::det(self : MlensemblestackingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblestackingMatrix::norm(self : MlensemblestackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblestackingMatrix::to_string(self : MlensemblestackingMatrix) -> String {
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

pub(all) struct MlensemblestackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_stacking_make_vector(comps : Array[Double]) -> MlensemblestackingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_stacking_vector_zero(dim : Int) -> MlensemblestackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblestackingVector::add(self : MlensemblestackingVector, other : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblestackingVector::sub(self : MlensemblestackingVector, other : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblestackingVector::scale(self : MlensemblestackingVector, s : Double) -> MlensemblestackingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblestackingVector::dot(self : MlensemblestackingVector, other : MlensemblestackingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblestackingVector::norm(self : MlensemblestackingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblestackingVector::normalize(self : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblestackingVector::dist(self : MlensemblestackingVector, other : MlensemblestackingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblestackingVector::to_string(self : MlensemblestackingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_stacking_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_stacking_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_stacking_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_stacking_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_stacking_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_stacking_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_stacking_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_stacking_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_stacking_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_stacking_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_stacking_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_stacking_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_stacking_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_stacking_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_stacking_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_stacking_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_stacking_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_stacking_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_stacking_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_stacking_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_stacking_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_stacking_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_stacking_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_stacking_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_stacking_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_stacking_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_stacking_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_stacking_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_stacking_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblestackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_frame_make(size : Int) -> MlensemblestackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_frame_len(s : MlensemblestackingFrame) -> Int { s.size }

pub fn ml_ensemble_stacking_frame_get(s : MlensemblestackingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_frame_set(s : MlensemblestackingFrame, i : Int, v : Double) -> MlensemblestackingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_frame_sum(s : MlensemblestackingFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_frame_mean(s : MlensemblestackingFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_frame_scale(s : MlensemblestackingFrame, f : Double) -> MlensemblestackingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_frame_add(a : MlensemblestackingFrame, b : MlensemblestackingFrame) -> MlensemblestackingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_frame_copy(s : MlensemblestackingFrame) -> MlensemblestackingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_frame_fill(s : MlensemblestackingFrame, v : Double) -> MlensemblestackingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_frame_min(s : MlensemblestackingFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_frame_max(s : MlensemblestackingFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_frame_to_string(s : MlensemblestackingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_table_make(size : Int) -> MlensemblestackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_table_len(s : MlensemblestackingTable) -> Int { s.size }

pub fn ml_ensemble_stacking_table_get(s : MlensemblestackingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_table_set(s : MlensemblestackingTable, i : Int, v : Double) -> MlensemblestackingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_table_sum(s : MlensemblestackingTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_table_mean(s : MlensemblestackingTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_table_scale(s : MlensemblestackingTable, f : Double) -> MlensemblestackingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_table_add(a : MlensemblestackingTable, b : MlensemblestackingTable) -> MlensemblestackingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_table_copy(s : MlensemblestackingTable) -> MlensemblestackingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_table_fill(s : MlensemblestackingTable, v : Double) -> MlensemblestackingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_table_min(s : MlensemblestackingTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_table_max(s : MlensemblestackingTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_table_to_string(s : MlensemblestackingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_graphn_make(size : Int) -> MlensemblestackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_graphn_len(s : MlensemblestackingGraphN) -> Int { s.size }

pub fn ml_ensemble_stacking_graphn_get(s : MlensemblestackingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_graphn_set(s : MlensemblestackingGraphN, i : Int, v : Double) -> MlensemblestackingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_graphn_sum(s : MlensemblestackingGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_graphn_mean(s : MlensemblestackingGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_graphn_scale(s : MlensemblestackingGraphN, f : Double) -> MlensemblestackingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_graphn_add(a : MlensemblestackingGraphN, b : MlensemblestackingGraphN) -> MlensemblestackingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_graphn_copy(s : MlensemblestackingGraphN) -> MlensemblestackingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_graphn_fill(s : MlensemblestackingGraphN, v : Double) -> MlensemblestackingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_graphn_min(s : MlensemblestackingGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_graphn_max(s : MlensemblestackingGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_graphn_to_string(s : MlensemblestackingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_node_make(size : Int) -> MlensemblestackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_node_len(s : MlensemblestackingNode) -> Int { s.size }

pub fn ml_ensemble_stacking_node_get(s : MlensemblestackingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_node_set(s : MlensemblestackingNode, i : Int, v : Double) -> MlensemblestackingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_node_sum(s : MlensemblestackingNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_node_mean(s : MlensemblestackingNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_node_scale(s : MlensemblestackingNode, f : Double) -> MlensemblestackingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_node_add(a : MlensemblestackingNode, b : MlensemblestackingNode) -> MlensemblestackingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_node_copy(s : MlensemblestackingNode) -> MlensemblestackingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_node_fill(s : MlensemblestackingNode, v : Double) -> MlensemblestackingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_node_min(s : MlensemblestackingNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_node_max(s : MlensemblestackingNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_node_to_string(s : MlensemblestackingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_edge_make(size : Int) -> MlensemblestackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_edge_len(s : MlensemblestackingEdge) -> Int { s.size }

pub fn ml_ensemble_stacking_edge_get(s : MlensemblestackingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_edge_set(s : MlensemblestackingEdge, i : Int, v : Double) -> MlensemblestackingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_edge_sum(s : MlensemblestackingEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_edge_mean(s : MlensemblestackingEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_edge_scale(s : MlensemblestackingEdge, f : Double) -> MlensemblestackingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_edge_add(a : MlensemblestackingEdge, b : MlensemblestackingEdge) -> MlensemblestackingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_edge_copy(s : MlensemblestackingEdge) -> MlensemblestackingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_edge_fill(s : MlensemblestackingEdge, v : Double) -> MlensemblestackingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_edge_min(s : MlensemblestackingEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_edge_max(s : MlensemblestackingEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_edge_to_string(s : MlensemblestackingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_path_make(size : Int) -> MlensemblestackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_path_len(s : MlensemblestackingPath) -> Int { s.size }

pub fn ml_ensemble_stacking_path_get(s : MlensemblestackingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_path_set(s : MlensemblestackingPath, i : Int, v : Double) -> MlensemblestackingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_path_sum(s : MlensemblestackingPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_path_mean(s : MlensemblestackingPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_path_scale(s : MlensemblestackingPath, f : Double) -> MlensemblestackingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_path_add(a : MlensemblestackingPath, b : MlensemblestackingPath) -> MlensemblestackingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_path_copy(s : MlensemblestackingPath) -> MlensemblestackingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_path_fill(s : MlensemblestackingPath, v : Double) -> MlensemblestackingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_path_min(s : MlensemblestackingPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_path_max(s : MlensemblestackingPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_path_to_string(s : MlensemblestackingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_cluster_make(size : Int) -> MlensemblestackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_cluster_len(s : MlensemblestackingCluster) -> Int { s.size }

pub fn ml_ensemble_stacking_cluster_get(s : MlensemblestackingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_cluster_set(s : MlensemblestackingCluster, i : Int, v : Double) -> MlensemblestackingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cluster_sum(s : MlensemblestackingCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_cluster_mean(s : MlensemblestackingCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_cluster_scale(s : MlensemblestackingCluster, f : Double) -> MlensemblestackingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cluster_add(a : MlensemblestackingCluster, b : MlensemblestackingCluster) -> MlensemblestackingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_cluster_copy(s : MlensemblestackingCluster) -> MlensemblestackingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cluster_fill(s : MlensemblestackingCluster, v : Double) -> MlensemblestackingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cluster_min(s : MlensemblestackingCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_cluster_max(s : MlensemblestackingCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_cluster_to_string(s : MlensemblestackingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_model_make(size : Int) -> MlensemblestackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_model_len(s : MlensemblestackingModel) -> Int { s.size }

pub fn ml_ensemble_stacking_model_get(s : MlensemblestackingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_model_set(s : MlensemblestackingModel, i : Int, v : Double) -> MlensemblestackingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_model_sum(s : MlensemblestackingModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_model_mean(s : MlensemblestackingModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_model_scale(s : MlensemblestackingModel, f : Double) -> MlensemblestackingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_model_add(a : MlensemblestackingModel, b : MlensemblestackingModel) -> MlensemblestackingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_model_copy(s : MlensemblestackingModel) -> MlensemblestackingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_model_fill(s : MlensemblestackingModel, v : Double) -> MlensemblestackingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_model_min(s : MlensemblestackingModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_model_max(s : MlensemblestackingModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_model_to_string(s : MlensemblestackingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_layer_make(size : Int) -> MlensemblestackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_layer_len(s : MlensemblestackingLayer) -> Int { s.size }

pub fn ml_ensemble_stacking_layer_get(s : MlensemblestackingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_layer_set(s : MlensemblestackingLayer, i : Int, v : Double) -> MlensemblestackingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_layer_sum(s : MlensemblestackingLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_layer_mean(s : MlensemblestackingLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_layer_scale(s : MlensemblestackingLayer, f : Double) -> MlensemblestackingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_layer_add(a : MlensemblestackingLayer, b : MlensemblestackingLayer) -> MlensemblestackingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_layer_copy(s : MlensemblestackingLayer) -> MlensemblestackingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_layer_fill(s : MlensemblestackingLayer, v : Double) -> MlensemblestackingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_layer_min(s : MlensemblestackingLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_layer_max(s : MlensemblestackingLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_layer_to_string(s : MlensemblestackingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_buffer_make(size : Int) -> MlensemblestackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_buffer_len(s : MlensemblestackingBuffer) -> Int { s.size }

pub fn ml_ensemble_stacking_buffer_get(s : MlensemblestackingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_buffer_set(s : MlensemblestackingBuffer, i : Int, v : Double) -> MlensemblestackingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_buffer_sum(s : MlensemblestackingBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_buffer_mean(s : MlensemblestackingBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_buffer_scale(s : MlensemblestackingBuffer, f : Double) -> MlensemblestackingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_buffer_add(a : MlensemblestackingBuffer, b : MlensemblestackingBuffer) -> MlensemblestackingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_buffer_copy(s : MlensemblestackingBuffer) -> MlensemblestackingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_buffer_fill(s : MlensemblestackingBuffer, v : Double) -> MlensemblestackingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_buffer_min(s : MlensemblestackingBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_buffer_max(s : MlensemblestackingBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_buffer_to_string(s : MlensemblestackingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_cursor_make(size : Int) -> MlensemblestackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_cursor_len(s : MlensemblestackingCursor) -> Int { s.size }

pub fn ml_ensemble_stacking_cursor_get(s : MlensemblestackingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_cursor_set(s : MlensemblestackingCursor, i : Int, v : Double) -> MlensemblestackingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cursor_sum(s : MlensemblestackingCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_cursor_mean(s : MlensemblestackingCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_cursor_scale(s : MlensemblestackingCursor, f : Double) -> MlensemblestackingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cursor_add(a : MlensemblestackingCursor, b : MlensemblestackingCursor) -> MlensemblestackingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_cursor_copy(s : MlensemblestackingCursor) -> MlensemblestackingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cursor_fill(s : MlensemblestackingCursor, v : Double) -> MlensemblestackingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_cursor_min(s : MlensemblestackingCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_cursor_max(s : MlensemblestackingCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_cursor_to_string(s : MlensemblestackingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_view_make(size : Int) -> MlensemblestackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_view_len(s : MlensemblestackingView) -> Int { s.size }

pub fn ml_ensemble_stacking_view_get(s : MlensemblestackingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_view_set(s : MlensemblestackingView, i : Int, v : Double) -> MlensemblestackingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_view_sum(s : MlensemblestackingView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_view_mean(s : MlensemblestackingView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_view_scale(s : MlensemblestackingView, f : Double) -> MlensemblestackingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_view_add(a : MlensemblestackingView, b : MlensemblestackingView) -> MlensemblestackingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_view_copy(s : MlensemblestackingView) -> MlensemblestackingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_view_fill(s : MlensemblestackingView, v : Double) -> MlensemblestackingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_view_min(s : MlensemblestackingView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_view_max(s : MlensemblestackingView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_view_to_string(s : MlensemblestackingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_range_make(size : Int) -> MlensemblestackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_range_len(s : MlensemblestackingRange) -> Int { s.size }

pub fn ml_ensemble_stacking_range_get(s : MlensemblestackingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_range_set(s : MlensemblestackingRange, i : Int, v : Double) -> MlensemblestackingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_range_sum(s : MlensemblestackingRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_range_mean(s : MlensemblestackingRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_range_scale(s : MlensemblestackingRange, f : Double) -> MlensemblestackingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_range_add(a : MlensemblestackingRange, b : MlensemblestackingRange) -> MlensemblestackingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_range_copy(s : MlensemblestackingRange) -> MlensemblestackingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_range_fill(s : MlensemblestackingRange, v : Double) -> MlensemblestackingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_range_min(s : MlensemblestackingRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_range_max(s : MlensemblestackingRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_range_to_string(s : MlensemblestackingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_slice_make(size : Int) -> MlensemblestackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_slice_len(s : MlensemblestackingSlice) -> Int { s.size }

pub fn ml_ensemble_stacking_slice_get(s : MlensemblestackingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_slice_set(s : MlensemblestackingSlice, i : Int, v : Double) -> MlensemblestackingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_slice_sum(s : MlensemblestackingSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_stacking_slice_mean(s : MlensemblestackingSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_stacking_slice_scale(s : MlensemblestackingSlice, f : Double) -> MlensemblestackingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_slice_add(a : MlensemblestackingSlice, b : MlensemblestackingSlice) -> MlensemblestackingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_stacking_slice_copy(s : MlensemblestackingSlice) -> MlensemblestackingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_slice_fill(s : MlensemblestackingSlice, v : Double) -> MlensemblestackingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_stacking_slice_min(s : MlensemblestackingSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_stacking_slice_max(s : MlensemblestackingSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_stacking_slice_to_string(s : MlensemblestackingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

