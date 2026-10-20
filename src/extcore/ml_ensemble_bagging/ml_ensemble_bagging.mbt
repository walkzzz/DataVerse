///===
/// extcore/ml_ensemble_bagging

pub(all) struct MlensemblebaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_bagging_make_point(x : Double, y : Double) -> MlensemblebaggingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_bagging_make_point3(x : Double, y : Double, z : Double) -> MlensemblebaggingPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblebaggingPoint::x(self : MlensemblebaggingPoint) -> Double { self.x }

pub fn MlensemblebaggingPoint::y(self : MlensemblebaggingPoint) -> Double { self.y }

pub fn MlensemblebaggingPoint::z(self : MlensemblebaggingPoint) -> Double { self.z }

pub fn MlensemblebaggingPoint::label(self : MlensemblebaggingPoint) -> Int { self.label }

pub fn MlensemblebaggingPoint::dist(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblebaggingPoint::add(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblebaggingPoint::sub(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblebaggingPoint::scale(self : MlensemblebaggingPoint, s : Double) -> MlensemblebaggingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblebaggingPoint::dot(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblebaggingPoint::cross(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblebaggingPoint::norm(self : MlensemblebaggingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblebaggingPoint::normalize(self : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblebaggingPoint::negate(self : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblebaggingPoint::mid(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblebaggingPoint::lerp(self : MlensemblebaggingPoint, other : MlensemblebaggingPoint, t : Double) -> MlensemblebaggingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblebaggingPoint::to_string(self : MlensemblebaggingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblebaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_bagging_make_series(vals : Array[Double], name : String) -> MlensemblebaggingSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblebaggingSeries::len(self : MlensemblebaggingSeries) -> Int { self.vals.length() }

pub fn MlensemblebaggingSeries::sum(self : MlensemblebaggingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblebaggingSeries::mean(self : MlensemblebaggingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblebaggingSeries::min(self : MlensemblebaggingSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblebaggingSeries::max(self : MlensemblebaggingSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblebaggingSeries::range(self : MlensemblebaggingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblebaggingSeries::variance(self : MlensemblebaggingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblebaggingSeries::std(self : MlensemblebaggingSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblebaggingSeries::median(self : MlensemblebaggingSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblebaggingSeries::scale(self : MlensemblebaggingSeries, f : Double) -> MlensemblebaggingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblebaggingSeries::add(self : MlensemblebaggingSeries, other : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblebaggingSeries::sub(self : MlensemblebaggingSeries, other : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblebaggingSeries::normalize(self : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblebaggingSeries::cumsum(self : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblebaggingSeries::to_string(self : MlensemblebaggingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblebaggingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_bagging_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblebaggingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_bagging_matrix_identity(n : Int) -> MlensemblebaggingMatrix {
  let m = ml_ensemble_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblebaggingMatrix::get(self : MlensemblebaggingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblebaggingMatrix::transpose(self : MlensemblebaggingMatrix) -> MlensemblebaggingMatrix {
  let result = ml_ensemble_bagging_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblebaggingMatrix::add(self : MlensemblebaggingMatrix, other : MlensemblebaggingMatrix) -> MlensemblebaggingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblebaggingMatrix::scale(self : MlensemblebaggingMatrix, s : Double) -> MlensemblebaggingMatrix {
  let result = ml_ensemble_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblebaggingMatrix::multiply(self : MlensemblebaggingMatrix, other : MlensemblebaggingMatrix) -> MlensemblebaggingMatrix {
  if self.cols != other.rows { return ml_ensemble_bagging_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_bagging_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblebaggingMatrix::trace(self : MlensemblebaggingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblebaggingMatrix::det(self : MlensemblebaggingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblebaggingMatrix::norm(self : MlensemblebaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblebaggingMatrix::to_string(self : MlensemblebaggingMatrix) -> String {
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

pub(all) struct MlensemblebaggingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_bagging_make_vector(comps : Array[Double]) -> MlensemblebaggingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_bagging_vector_zero(dim : Int) -> MlensemblebaggingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblebaggingVector::add(self : MlensemblebaggingVector, other : MlensemblebaggingVector) -> MlensemblebaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblebaggingVector::sub(self : MlensemblebaggingVector, other : MlensemblebaggingVector) -> MlensemblebaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblebaggingVector::scale(self : MlensemblebaggingVector, s : Double) -> MlensemblebaggingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblebaggingVector::dot(self : MlensemblebaggingVector, other : MlensemblebaggingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblebaggingVector::norm(self : MlensemblebaggingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblebaggingVector::normalize(self : MlensemblebaggingVector) -> MlensemblebaggingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblebaggingVector::dist(self : MlensemblebaggingVector, other : MlensemblebaggingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblebaggingVector::to_string(self : MlensemblebaggingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_bagging_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_bagging_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_bagging_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_bagging_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_bagging_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_bagging_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_bagging_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_bagging_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_bagging_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_bagging_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_bagging_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_bagging_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_bagging_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_bagging_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_bagging_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_bagging_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_bagging_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_bagging_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_bagging_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_bagging_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_bagging_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_bagging_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_bagging_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_bagging_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_bagging_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_bagging_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_bagging_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_bagging_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_bagging_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblebaggingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_frame_make(size : Int) -> MlensemblebaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_frame_len(s : MlensemblebaggingFrame) -> Int { s.size }

pub fn ml_ensemble_bagging_frame_get(s : MlensemblebaggingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_frame_set(s : MlensemblebaggingFrame, i : Int, v : Double) -> MlensemblebaggingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_frame_sum(s : MlensemblebaggingFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_frame_mean(s : MlensemblebaggingFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_frame_scale(s : MlensemblebaggingFrame, f : Double) -> MlensemblebaggingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_frame_add(a : MlensemblebaggingFrame, b : MlensemblebaggingFrame) -> MlensemblebaggingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_frame_copy(s : MlensemblebaggingFrame) -> MlensemblebaggingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_frame_fill(s : MlensemblebaggingFrame, v : Double) -> MlensemblebaggingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_frame_min(s : MlensemblebaggingFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_frame_max(s : MlensemblebaggingFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_frame_to_string(s : MlensemblebaggingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_table_make(size : Int) -> MlensemblebaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_table_len(s : MlensemblebaggingTable) -> Int { s.size }

pub fn ml_ensemble_bagging_table_get(s : MlensemblebaggingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_table_set(s : MlensemblebaggingTable, i : Int, v : Double) -> MlensemblebaggingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_table_sum(s : MlensemblebaggingTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_table_mean(s : MlensemblebaggingTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_table_scale(s : MlensemblebaggingTable, f : Double) -> MlensemblebaggingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_table_add(a : MlensemblebaggingTable, b : MlensemblebaggingTable) -> MlensemblebaggingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_table_copy(s : MlensemblebaggingTable) -> MlensemblebaggingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_table_fill(s : MlensemblebaggingTable, v : Double) -> MlensemblebaggingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_table_min(s : MlensemblebaggingTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_table_max(s : MlensemblebaggingTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_table_to_string(s : MlensemblebaggingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_graphn_make(size : Int) -> MlensemblebaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_graphn_len(s : MlensemblebaggingGraphN) -> Int { s.size }

pub fn ml_ensemble_bagging_graphn_get(s : MlensemblebaggingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_graphn_set(s : MlensemblebaggingGraphN, i : Int, v : Double) -> MlensemblebaggingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_graphn_sum(s : MlensemblebaggingGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_graphn_mean(s : MlensemblebaggingGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_graphn_scale(s : MlensemblebaggingGraphN, f : Double) -> MlensemblebaggingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_graphn_add(a : MlensemblebaggingGraphN, b : MlensemblebaggingGraphN) -> MlensemblebaggingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_graphn_copy(s : MlensemblebaggingGraphN) -> MlensemblebaggingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_graphn_fill(s : MlensemblebaggingGraphN, v : Double) -> MlensemblebaggingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_graphn_min(s : MlensemblebaggingGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_graphn_max(s : MlensemblebaggingGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_graphn_to_string(s : MlensemblebaggingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_node_make(size : Int) -> MlensemblebaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_node_len(s : MlensemblebaggingNode) -> Int { s.size }

pub fn ml_ensemble_bagging_node_get(s : MlensemblebaggingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_node_set(s : MlensemblebaggingNode, i : Int, v : Double) -> MlensemblebaggingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_node_sum(s : MlensemblebaggingNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_node_mean(s : MlensemblebaggingNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_node_scale(s : MlensemblebaggingNode, f : Double) -> MlensemblebaggingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_node_add(a : MlensemblebaggingNode, b : MlensemblebaggingNode) -> MlensemblebaggingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_node_copy(s : MlensemblebaggingNode) -> MlensemblebaggingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_node_fill(s : MlensemblebaggingNode, v : Double) -> MlensemblebaggingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_node_min(s : MlensemblebaggingNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_node_max(s : MlensemblebaggingNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_node_to_string(s : MlensemblebaggingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_edge_make(size : Int) -> MlensemblebaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_edge_len(s : MlensemblebaggingEdge) -> Int { s.size }

pub fn ml_ensemble_bagging_edge_get(s : MlensemblebaggingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_edge_set(s : MlensemblebaggingEdge, i : Int, v : Double) -> MlensemblebaggingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_edge_sum(s : MlensemblebaggingEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_edge_mean(s : MlensemblebaggingEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_edge_scale(s : MlensemblebaggingEdge, f : Double) -> MlensemblebaggingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_edge_add(a : MlensemblebaggingEdge, b : MlensemblebaggingEdge) -> MlensemblebaggingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_edge_copy(s : MlensemblebaggingEdge) -> MlensemblebaggingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_edge_fill(s : MlensemblebaggingEdge, v : Double) -> MlensemblebaggingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_edge_min(s : MlensemblebaggingEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_edge_max(s : MlensemblebaggingEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_edge_to_string(s : MlensemblebaggingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_path_make(size : Int) -> MlensemblebaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_path_len(s : MlensemblebaggingPath) -> Int { s.size }

pub fn ml_ensemble_bagging_path_get(s : MlensemblebaggingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_path_set(s : MlensemblebaggingPath, i : Int, v : Double) -> MlensemblebaggingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_path_sum(s : MlensemblebaggingPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_path_mean(s : MlensemblebaggingPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_path_scale(s : MlensemblebaggingPath, f : Double) -> MlensemblebaggingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_path_add(a : MlensemblebaggingPath, b : MlensemblebaggingPath) -> MlensemblebaggingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_path_copy(s : MlensemblebaggingPath) -> MlensemblebaggingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_path_fill(s : MlensemblebaggingPath, v : Double) -> MlensemblebaggingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_path_min(s : MlensemblebaggingPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_path_max(s : MlensemblebaggingPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_path_to_string(s : MlensemblebaggingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_cluster_make(size : Int) -> MlensemblebaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_cluster_len(s : MlensemblebaggingCluster) -> Int { s.size }

pub fn ml_ensemble_bagging_cluster_get(s : MlensemblebaggingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_cluster_set(s : MlensemblebaggingCluster, i : Int, v : Double) -> MlensemblebaggingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cluster_sum(s : MlensemblebaggingCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_cluster_mean(s : MlensemblebaggingCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_cluster_scale(s : MlensemblebaggingCluster, f : Double) -> MlensemblebaggingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cluster_add(a : MlensemblebaggingCluster, b : MlensemblebaggingCluster) -> MlensemblebaggingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_cluster_copy(s : MlensemblebaggingCluster) -> MlensemblebaggingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cluster_fill(s : MlensemblebaggingCluster, v : Double) -> MlensemblebaggingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cluster_min(s : MlensemblebaggingCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_cluster_max(s : MlensemblebaggingCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_cluster_to_string(s : MlensemblebaggingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_model_make(size : Int) -> MlensemblebaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_model_len(s : MlensemblebaggingModel) -> Int { s.size }

pub fn ml_ensemble_bagging_model_get(s : MlensemblebaggingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_model_set(s : MlensemblebaggingModel, i : Int, v : Double) -> MlensemblebaggingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_model_sum(s : MlensemblebaggingModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_model_mean(s : MlensemblebaggingModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_model_scale(s : MlensemblebaggingModel, f : Double) -> MlensemblebaggingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_model_add(a : MlensemblebaggingModel, b : MlensemblebaggingModel) -> MlensemblebaggingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_model_copy(s : MlensemblebaggingModel) -> MlensemblebaggingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_model_fill(s : MlensemblebaggingModel, v : Double) -> MlensemblebaggingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_model_min(s : MlensemblebaggingModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_model_max(s : MlensemblebaggingModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_model_to_string(s : MlensemblebaggingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_layer_make(size : Int) -> MlensemblebaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_layer_len(s : MlensemblebaggingLayer) -> Int { s.size }

pub fn ml_ensemble_bagging_layer_get(s : MlensemblebaggingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_layer_set(s : MlensemblebaggingLayer, i : Int, v : Double) -> MlensemblebaggingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_layer_sum(s : MlensemblebaggingLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_layer_mean(s : MlensemblebaggingLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_layer_scale(s : MlensemblebaggingLayer, f : Double) -> MlensemblebaggingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_layer_add(a : MlensemblebaggingLayer, b : MlensemblebaggingLayer) -> MlensemblebaggingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_layer_copy(s : MlensemblebaggingLayer) -> MlensemblebaggingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_layer_fill(s : MlensemblebaggingLayer, v : Double) -> MlensemblebaggingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_layer_min(s : MlensemblebaggingLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_layer_max(s : MlensemblebaggingLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_layer_to_string(s : MlensemblebaggingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_buffer_make(size : Int) -> MlensemblebaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_buffer_len(s : MlensemblebaggingBuffer) -> Int { s.size }

pub fn ml_ensemble_bagging_buffer_get(s : MlensemblebaggingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_buffer_set(s : MlensemblebaggingBuffer, i : Int, v : Double) -> MlensemblebaggingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_buffer_sum(s : MlensemblebaggingBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_buffer_mean(s : MlensemblebaggingBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_buffer_scale(s : MlensemblebaggingBuffer, f : Double) -> MlensemblebaggingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_buffer_add(a : MlensemblebaggingBuffer, b : MlensemblebaggingBuffer) -> MlensemblebaggingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_buffer_copy(s : MlensemblebaggingBuffer) -> MlensemblebaggingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_buffer_fill(s : MlensemblebaggingBuffer, v : Double) -> MlensemblebaggingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_buffer_min(s : MlensemblebaggingBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_buffer_max(s : MlensemblebaggingBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_buffer_to_string(s : MlensemblebaggingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_cursor_make(size : Int) -> MlensemblebaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_cursor_len(s : MlensemblebaggingCursor) -> Int { s.size }

pub fn ml_ensemble_bagging_cursor_get(s : MlensemblebaggingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_cursor_set(s : MlensemblebaggingCursor, i : Int, v : Double) -> MlensemblebaggingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cursor_sum(s : MlensemblebaggingCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_cursor_mean(s : MlensemblebaggingCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_cursor_scale(s : MlensemblebaggingCursor, f : Double) -> MlensemblebaggingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cursor_add(a : MlensemblebaggingCursor, b : MlensemblebaggingCursor) -> MlensemblebaggingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_cursor_copy(s : MlensemblebaggingCursor) -> MlensemblebaggingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cursor_fill(s : MlensemblebaggingCursor, v : Double) -> MlensemblebaggingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_cursor_min(s : MlensemblebaggingCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_cursor_max(s : MlensemblebaggingCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_cursor_to_string(s : MlensemblebaggingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_view_make(size : Int) -> MlensemblebaggingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_view_len(s : MlensemblebaggingView) -> Int { s.size }

pub fn ml_ensemble_bagging_view_get(s : MlensemblebaggingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_view_set(s : MlensemblebaggingView, i : Int, v : Double) -> MlensemblebaggingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_view_sum(s : MlensemblebaggingView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_view_mean(s : MlensemblebaggingView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_view_scale(s : MlensemblebaggingView, f : Double) -> MlensemblebaggingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_view_add(a : MlensemblebaggingView, b : MlensemblebaggingView) -> MlensemblebaggingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_view_copy(s : MlensemblebaggingView) -> MlensemblebaggingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_view_fill(s : MlensemblebaggingView, v : Double) -> MlensemblebaggingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_view_min(s : MlensemblebaggingView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_view_max(s : MlensemblebaggingView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_view_to_string(s : MlensemblebaggingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_range_make(size : Int) -> MlensemblebaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_range_len(s : MlensemblebaggingRange) -> Int { s.size }

pub fn ml_ensemble_bagging_range_get(s : MlensemblebaggingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_range_set(s : MlensemblebaggingRange, i : Int, v : Double) -> MlensemblebaggingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_range_sum(s : MlensemblebaggingRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_range_mean(s : MlensemblebaggingRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_range_scale(s : MlensemblebaggingRange, f : Double) -> MlensemblebaggingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_range_add(a : MlensemblebaggingRange, b : MlensemblebaggingRange) -> MlensemblebaggingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_range_copy(s : MlensemblebaggingRange) -> MlensemblebaggingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_range_fill(s : MlensemblebaggingRange, v : Double) -> MlensemblebaggingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_range_min(s : MlensemblebaggingRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_range_max(s : MlensemblebaggingRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_range_to_string(s : MlensemblebaggingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_slice_make(size : Int) -> MlensemblebaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_slice_len(s : MlensemblebaggingSlice) -> Int { s.size }

pub fn ml_ensemble_bagging_slice_get(s : MlensemblebaggingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_slice_set(s : MlensemblebaggingSlice, i : Int, v : Double) -> MlensemblebaggingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_slice_sum(s : MlensemblebaggingSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_bagging_slice_mean(s : MlensemblebaggingSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_bagging_slice_scale(s : MlensemblebaggingSlice, f : Double) -> MlensemblebaggingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_slice_add(a : MlensemblebaggingSlice, b : MlensemblebaggingSlice) -> MlensemblebaggingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_bagging_slice_copy(s : MlensemblebaggingSlice) -> MlensemblebaggingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_slice_fill(s : MlensemblebaggingSlice, v : Double) -> MlensemblebaggingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_bagging_slice_min(s : MlensemblebaggingSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_bagging_slice_max(s : MlensemblebaggingSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_bagging_slice_to_string(s : MlensemblebaggingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

