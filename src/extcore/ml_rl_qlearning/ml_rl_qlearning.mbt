///===
/// extcore/ml_rl_qlearning

pub(all) struct MlrlqlearningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_qlearning_make_point(x : Double, y : Double) -> MlrlqlearningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_qlearning_make_point3(x : Double, y : Double, z : Double) -> MlrlqlearningPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlqlearningPoint::x(self : MlrlqlearningPoint) -> Double { self.x }

pub fn MlrlqlearningPoint::y(self : MlrlqlearningPoint) -> Double { self.y }

pub fn MlrlqlearningPoint::z(self : MlrlqlearningPoint) -> Double { self.z }

pub fn MlrlqlearningPoint::label(self : MlrlqlearningPoint) -> Int { self.label }

pub fn MlrlqlearningPoint::dist(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlqlearningPoint::add(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlqlearningPoint::sub(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlqlearningPoint::scale(self : MlrlqlearningPoint, s : Double) -> MlrlqlearningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlqlearningPoint::dot(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlqlearningPoint::cross(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlqlearningPoint::norm(self : MlrlqlearningPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlqlearningPoint::normalize(self : MlrlqlearningPoint) -> MlrlqlearningPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlqlearningPoint::negate(self : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlqlearningPoint::mid(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlqlearningPoint::lerp(self : MlrlqlearningPoint, other : MlrlqlearningPoint, t : Double) -> MlrlqlearningPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlqlearningPoint::to_string(self : MlrlqlearningPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlqlearningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_qlearning_make_series(vals : Array[Double], name : String) -> MlrlqlearningSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlqlearningSeries::len(self : MlrlqlearningSeries) -> Int { self.vals.length() }

pub fn MlrlqlearningSeries::sum(self : MlrlqlearningSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlqlearningSeries::mean(self : MlrlqlearningSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlqlearningSeries::min(self : MlrlqlearningSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlqlearningSeries::max(self : MlrlqlearningSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlqlearningSeries::range(self : MlrlqlearningSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlqlearningSeries::variance(self : MlrlqlearningSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlqlearningSeries::std(self : MlrlqlearningSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlqlearningSeries::median(self : MlrlqlearningSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlqlearningSeries::scale(self : MlrlqlearningSeries, f : Double) -> MlrlqlearningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlqlearningSeries::add(self : MlrlqlearningSeries, other : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlqlearningSeries::sub(self : MlrlqlearningSeries, other : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlqlearningSeries::normalize(self : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlqlearningSeries::cumsum(self : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlqlearningSeries::to_string(self : MlrlqlearningSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlqlearningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_qlearning_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlqlearningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_qlearning_matrix_identity(n : Int) -> MlrlqlearningMatrix {
  let m = ml_rl_qlearning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlqlearningMatrix::get(self : MlrlqlearningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlqlearningMatrix::transpose(self : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlqlearningMatrix::add(self : MlrlqlearningMatrix, other : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_qlearning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlqlearningMatrix::scale(self : MlrlqlearningMatrix, s : Double) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlqlearningMatrix::multiply(self : MlrlqlearningMatrix, other : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if self.cols != other.rows { return ml_rl_qlearning_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_qlearning_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlqlearningMatrix::trace(self : MlrlqlearningMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlqlearningMatrix::det(self : MlrlqlearningMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlqlearningMatrix::norm(self : MlrlqlearningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlqlearningMatrix::to_string(self : MlrlqlearningMatrix) -> String {
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

pub(all) struct MlrlqlearningVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_qlearning_make_vector(comps : Array[Double]) -> MlrlqlearningVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_qlearning_vector_zero(dim : Int) -> MlrlqlearningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlqlearningVector::add(self : MlrlqlearningVector, other : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlqlearningVector::sub(self : MlrlqlearningVector, other : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlqlearningVector::scale(self : MlrlqlearningVector, s : Double) -> MlrlqlearningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlqlearningVector::dot(self : MlrlqlearningVector, other : MlrlqlearningVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlqlearningVector::norm(self : MlrlqlearningVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlqlearningVector::normalize(self : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlqlearningVector::dist(self : MlrlqlearningVector, other : MlrlqlearningVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlqlearningVector::to_string(self : MlrlqlearningVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_qlearning_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_qlearning_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_qlearning_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_qlearning_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_qlearning_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_qlearning_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_qlearning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_qlearning_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_qlearning_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_qlearning_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_qlearning_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_qlearning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_qlearning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_qlearning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_qlearning_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_qlearning_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_qlearning_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_qlearning_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_qlearning_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_qlearning_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_qlearning_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_qlearning_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_qlearning_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_qlearning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_qlearning_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_qlearning_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_qlearning_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_qlearning_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_qlearning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlqlearningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_frame_make(size : Int) -> MlrlqlearningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_frame_len(s : MlrlqlearningFrame) -> Int { s.size }

pub fn ml_rl_qlearning_frame_get(s : MlrlqlearningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_frame_set(s : MlrlqlearningFrame, i : Int, v : Double) -> MlrlqlearningFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_frame_sum(s : MlrlqlearningFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_frame_mean(s : MlrlqlearningFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_frame_scale(s : MlrlqlearningFrame, f : Double) -> MlrlqlearningFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_frame_add(a : MlrlqlearningFrame, b : MlrlqlearningFrame) -> MlrlqlearningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_frame_copy(s : MlrlqlearningFrame) -> MlrlqlearningFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_frame_fill(s : MlrlqlearningFrame, v : Double) -> MlrlqlearningFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_frame_min(s : MlrlqlearningFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_frame_max(s : MlrlqlearningFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_frame_to_string(s : MlrlqlearningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_table_make(size : Int) -> MlrlqlearningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_table_len(s : MlrlqlearningTable) -> Int { s.size }

pub fn ml_rl_qlearning_table_get(s : MlrlqlearningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_table_set(s : MlrlqlearningTable, i : Int, v : Double) -> MlrlqlearningTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_table_sum(s : MlrlqlearningTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_table_mean(s : MlrlqlearningTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_table_scale(s : MlrlqlearningTable, f : Double) -> MlrlqlearningTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_table_add(a : MlrlqlearningTable, b : MlrlqlearningTable) -> MlrlqlearningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_table_copy(s : MlrlqlearningTable) -> MlrlqlearningTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_table_fill(s : MlrlqlearningTable, v : Double) -> MlrlqlearningTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_table_min(s : MlrlqlearningTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_table_max(s : MlrlqlearningTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_table_to_string(s : MlrlqlearningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_graphn_make(size : Int) -> MlrlqlearningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_graphn_len(s : MlrlqlearningGraphN) -> Int { s.size }

pub fn ml_rl_qlearning_graphn_get(s : MlrlqlearningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_graphn_set(s : MlrlqlearningGraphN, i : Int, v : Double) -> MlrlqlearningGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_graphn_sum(s : MlrlqlearningGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_graphn_mean(s : MlrlqlearningGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_graphn_scale(s : MlrlqlearningGraphN, f : Double) -> MlrlqlearningGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_graphn_add(a : MlrlqlearningGraphN, b : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_graphn_copy(s : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_graphn_fill(s : MlrlqlearningGraphN, v : Double) -> MlrlqlearningGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_graphn_min(s : MlrlqlearningGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_graphn_max(s : MlrlqlearningGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_graphn_to_string(s : MlrlqlearningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_node_make(size : Int) -> MlrlqlearningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_node_len(s : MlrlqlearningNode) -> Int { s.size }

pub fn ml_rl_qlearning_node_get(s : MlrlqlearningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_node_set(s : MlrlqlearningNode, i : Int, v : Double) -> MlrlqlearningNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_node_sum(s : MlrlqlearningNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_node_mean(s : MlrlqlearningNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_node_scale(s : MlrlqlearningNode, f : Double) -> MlrlqlearningNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_node_add(a : MlrlqlearningNode, b : MlrlqlearningNode) -> MlrlqlearningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_node_copy(s : MlrlqlearningNode) -> MlrlqlearningNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_node_fill(s : MlrlqlearningNode, v : Double) -> MlrlqlearningNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_node_min(s : MlrlqlearningNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_node_max(s : MlrlqlearningNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_node_to_string(s : MlrlqlearningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_edge_make(size : Int) -> MlrlqlearningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_edge_len(s : MlrlqlearningEdge) -> Int { s.size }

pub fn ml_rl_qlearning_edge_get(s : MlrlqlearningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_edge_set(s : MlrlqlearningEdge, i : Int, v : Double) -> MlrlqlearningEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_edge_sum(s : MlrlqlearningEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_edge_mean(s : MlrlqlearningEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_edge_scale(s : MlrlqlearningEdge, f : Double) -> MlrlqlearningEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_edge_add(a : MlrlqlearningEdge, b : MlrlqlearningEdge) -> MlrlqlearningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_edge_copy(s : MlrlqlearningEdge) -> MlrlqlearningEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_edge_fill(s : MlrlqlearningEdge, v : Double) -> MlrlqlearningEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_edge_min(s : MlrlqlearningEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_edge_max(s : MlrlqlearningEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_edge_to_string(s : MlrlqlearningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_path_make(size : Int) -> MlrlqlearningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_path_len(s : MlrlqlearningPath) -> Int { s.size }

pub fn ml_rl_qlearning_path_get(s : MlrlqlearningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_path_set(s : MlrlqlearningPath, i : Int, v : Double) -> MlrlqlearningPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_path_sum(s : MlrlqlearningPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_path_mean(s : MlrlqlearningPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_path_scale(s : MlrlqlearningPath, f : Double) -> MlrlqlearningPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_path_add(a : MlrlqlearningPath, b : MlrlqlearningPath) -> MlrlqlearningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_path_copy(s : MlrlqlearningPath) -> MlrlqlearningPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_path_fill(s : MlrlqlearningPath, v : Double) -> MlrlqlearningPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_path_min(s : MlrlqlearningPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_path_max(s : MlrlqlearningPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_path_to_string(s : MlrlqlearningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cluster_make(size : Int) -> MlrlqlearningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_cluster_len(s : MlrlqlearningCluster) -> Int { s.size }

pub fn ml_rl_qlearning_cluster_get(s : MlrlqlearningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_cluster_set(s : MlrlqlearningCluster, i : Int, v : Double) -> MlrlqlearningCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cluster_sum(s : MlrlqlearningCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_cluster_mean(s : MlrlqlearningCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_cluster_scale(s : MlrlqlearningCluster, f : Double) -> MlrlqlearningCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cluster_add(a : MlrlqlearningCluster, b : MlrlqlearningCluster) -> MlrlqlearningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_cluster_copy(s : MlrlqlearningCluster) -> MlrlqlearningCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cluster_fill(s : MlrlqlearningCluster, v : Double) -> MlrlqlearningCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cluster_min(s : MlrlqlearningCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_cluster_max(s : MlrlqlearningCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_cluster_to_string(s : MlrlqlearningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_model_make(size : Int) -> MlrlqlearningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_model_len(s : MlrlqlearningModel) -> Int { s.size }

pub fn ml_rl_qlearning_model_get(s : MlrlqlearningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_model_set(s : MlrlqlearningModel, i : Int, v : Double) -> MlrlqlearningModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_model_sum(s : MlrlqlearningModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_model_mean(s : MlrlqlearningModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_model_scale(s : MlrlqlearningModel, f : Double) -> MlrlqlearningModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_model_add(a : MlrlqlearningModel, b : MlrlqlearningModel) -> MlrlqlearningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_model_copy(s : MlrlqlearningModel) -> MlrlqlearningModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_model_fill(s : MlrlqlearningModel, v : Double) -> MlrlqlearningModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_model_min(s : MlrlqlearningModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_model_max(s : MlrlqlearningModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_model_to_string(s : MlrlqlearningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_layer_make(size : Int) -> MlrlqlearningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_layer_len(s : MlrlqlearningLayer) -> Int { s.size }

pub fn ml_rl_qlearning_layer_get(s : MlrlqlearningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_layer_set(s : MlrlqlearningLayer, i : Int, v : Double) -> MlrlqlearningLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_layer_sum(s : MlrlqlearningLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_layer_mean(s : MlrlqlearningLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_layer_scale(s : MlrlqlearningLayer, f : Double) -> MlrlqlearningLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_layer_add(a : MlrlqlearningLayer, b : MlrlqlearningLayer) -> MlrlqlearningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_layer_copy(s : MlrlqlearningLayer) -> MlrlqlearningLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_layer_fill(s : MlrlqlearningLayer, v : Double) -> MlrlqlearningLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_layer_min(s : MlrlqlearningLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_layer_max(s : MlrlqlearningLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_layer_to_string(s : MlrlqlearningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_buffer_make(size : Int) -> MlrlqlearningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_buffer_len(s : MlrlqlearningBuffer) -> Int { s.size }

pub fn ml_rl_qlearning_buffer_get(s : MlrlqlearningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_buffer_set(s : MlrlqlearningBuffer, i : Int, v : Double) -> MlrlqlearningBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_buffer_sum(s : MlrlqlearningBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_buffer_mean(s : MlrlqlearningBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_buffer_scale(s : MlrlqlearningBuffer, f : Double) -> MlrlqlearningBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_buffer_add(a : MlrlqlearningBuffer, b : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_buffer_copy(s : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_buffer_fill(s : MlrlqlearningBuffer, v : Double) -> MlrlqlearningBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_buffer_min(s : MlrlqlearningBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_buffer_max(s : MlrlqlearningBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_buffer_to_string(s : MlrlqlearningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cursor_make(size : Int) -> MlrlqlearningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_cursor_len(s : MlrlqlearningCursor) -> Int { s.size }

pub fn ml_rl_qlearning_cursor_get(s : MlrlqlearningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_cursor_set(s : MlrlqlearningCursor, i : Int, v : Double) -> MlrlqlearningCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cursor_sum(s : MlrlqlearningCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_cursor_mean(s : MlrlqlearningCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_cursor_scale(s : MlrlqlearningCursor, f : Double) -> MlrlqlearningCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cursor_add(a : MlrlqlearningCursor, b : MlrlqlearningCursor) -> MlrlqlearningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_cursor_copy(s : MlrlqlearningCursor) -> MlrlqlearningCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cursor_fill(s : MlrlqlearningCursor, v : Double) -> MlrlqlearningCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_cursor_min(s : MlrlqlearningCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_cursor_max(s : MlrlqlearningCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_cursor_to_string(s : MlrlqlearningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_view_make(size : Int) -> MlrlqlearningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_view_len(s : MlrlqlearningView) -> Int { s.size }

pub fn ml_rl_qlearning_view_get(s : MlrlqlearningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_view_set(s : MlrlqlearningView, i : Int, v : Double) -> MlrlqlearningView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_view_sum(s : MlrlqlearningView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_view_mean(s : MlrlqlearningView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_view_scale(s : MlrlqlearningView, f : Double) -> MlrlqlearningView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_view_add(a : MlrlqlearningView, b : MlrlqlearningView) -> MlrlqlearningView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_view_copy(s : MlrlqlearningView) -> MlrlqlearningView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_view_fill(s : MlrlqlearningView, v : Double) -> MlrlqlearningView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_view_min(s : MlrlqlearningView) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_view_max(s : MlrlqlearningView) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_view_to_string(s : MlrlqlearningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_range_make(size : Int) -> MlrlqlearningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_range_len(s : MlrlqlearningRange) -> Int { s.size }

pub fn ml_rl_qlearning_range_get(s : MlrlqlearningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_range_set(s : MlrlqlearningRange, i : Int, v : Double) -> MlrlqlearningRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_range_sum(s : MlrlqlearningRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_range_mean(s : MlrlqlearningRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_range_scale(s : MlrlqlearningRange, f : Double) -> MlrlqlearningRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_range_add(a : MlrlqlearningRange, b : MlrlqlearningRange) -> MlrlqlearningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_range_copy(s : MlrlqlearningRange) -> MlrlqlearningRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_range_fill(s : MlrlqlearningRange, v : Double) -> MlrlqlearningRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_range_min(s : MlrlqlearningRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_range_max(s : MlrlqlearningRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_range_to_string(s : MlrlqlearningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_slice_make(size : Int) -> MlrlqlearningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_slice_len(s : MlrlqlearningSlice) -> Int { s.size }

pub fn ml_rl_qlearning_slice_get(s : MlrlqlearningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_slice_set(s : MlrlqlearningSlice, i : Int, v : Double) -> MlrlqlearningSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_slice_sum(s : MlrlqlearningSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_qlearning_slice_mean(s : MlrlqlearningSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_qlearning_slice_scale(s : MlrlqlearningSlice, f : Double) -> MlrlqlearningSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_slice_add(a : MlrlqlearningSlice, b : MlrlqlearningSlice) -> MlrlqlearningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_qlearning_slice_copy(s : MlrlqlearningSlice) -> MlrlqlearningSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_slice_fill(s : MlrlqlearningSlice, v : Double) -> MlrlqlearningSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_qlearning_slice_min(s : MlrlqlearningSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_qlearning_slice_max(s : MlrlqlearningSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_qlearning_slice_to_string(s : MlrlqlearningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

