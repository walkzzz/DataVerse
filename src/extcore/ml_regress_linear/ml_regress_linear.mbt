///===
/// extcore/ml_regress_linear

pub(all) struct MlregresslinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_linear_make_point(x : Double, y : Double) -> MlregresslinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_linear_make_point3(x : Double, y : Double, z : Double) -> MlregresslinearPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresslinearPoint::x(self : MlregresslinearPoint) -> Double { self.x }

pub fn MlregresslinearPoint::y(self : MlregresslinearPoint) -> Double { self.y }

pub fn MlregresslinearPoint::z(self : MlregresslinearPoint) -> Double { self.z }

pub fn MlregresslinearPoint::label(self : MlregresslinearPoint) -> Int { self.label }

pub fn MlregresslinearPoint::dist(self : MlregresslinearPoint, other : MlregresslinearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresslinearPoint::add(self : MlregresslinearPoint, other : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresslinearPoint::sub(self : MlregresslinearPoint, other : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresslinearPoint::scale(self : MlregresslinearPoint, s : Double) -> MlregresslinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresslinearPoint::dot(self : MlregresslinearPoint, other : MlregresslinearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresslinearPoint::cross(self : MlregresslinearPoint, other : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresslinearPoint::norm(self : MlregresslinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresslinearPoint::normalize(self : MlregresslinearPoint) -> MlregresslinearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslinearPoint::negate(self : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresslinearPoint::mid(self : MlregresslinearPoint, other : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresslinearPoint::lerp(self : MlregresslinearPoint, other : MlregresslinearPoint, t : Double) -> MlregresslinearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresslinearPoint::to_string(self : MlregresslinearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresslinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_linear_make_series(vals : Array[Double], name : String) -> MlregresslinearSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresslinearSeries::len(self : MlregresslinearSeries) -> Int { self.vals.length() }

pub fn MlregresslinearSeries::sum(self : MlregresslinearSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresslinearSeries::mean(self : MlregresslinearSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresslinearSeries::min(self : MlregresslinearSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresslinearSeries::max(self : MlregresslinearSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresslinearSeries::range(self : MlregresslinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresslinearSeries::variance(self : MlregresslinearSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresslinearSeries::std(self : MlregresslinearSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresslinearSeries::median(self : MlregresslinearSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresslinearSeries::scale(self : MlregresslinearSeries, f : Double) -> MlregresslinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresslinearSeries::add(self : MlregresslinearSeries, other : MlregresslinearSeries) -> MlregresslinearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresslinearSeries::sub(self : MlregresslinearSeries, other : MlregresslinearSeries) -> MlregresslinearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresslinearSeries::normalize(self : MlregresslinearSeries) -> MlregresslinearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresslinearSeries::cumsum(self : MlregresslinearSeries) -> MlregresslinearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresslinearSeries::to_string(self : MlregresslinearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_linear_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_linear_matrix_identity(n : Int) -> MlregresslinearMatrix {
  let m = ml_regress_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresslinearMatrix::get(self : MlregresslinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresslinearMatrix::transpose(self : MlregresslinearMatrix) -> MlregresslinearMatrix {
  let result = ml_regress_linear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresslinearMatrix::add(self : MlregresslinearMatrix, other : MlregresslinearMatrix) -> MlregresslinearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresslinearMatrix::scale(self : MlregresslinearMatrix, s : Double) -> MlregresslinearMatrix {
  let result = ml_regress_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresslinearMatrix::multiply(self : MlregresslinearMatrix, other : MlregresslinearMatrix) -> MlregresslinearMatrix {
  if self.cols != other.rows { return ml_regress_linear_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_linear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresslinearMatrix::trace(self : MlregresslinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresslinearMatrix::det(self : MlregresslinearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresslinearMatrix::norm(self : MlregresslinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresslinearMatrix::to_string(self : MlregresslinearMatrix) -> String {
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

pub(all) struct MlregresslinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_linear_make_vector(comps : Array[Double]) -> MlregresslinearVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_linear_vector_zero(dim : Int) -> MlregresslinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresslinearVector::add(self : MlregresslinearVector, other : MlregresslinearVector) -> MlregresslinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslinearVector::sub(self : MlregresslinearVector, other : MlregresslinearVector) -> MlregresslinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslinearVector::scale(self : MlregresslinearVector, s : Double) -> MlregresslinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresslinearVector::dot(self : MlregresslinearVector, other : MlregresslinearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresslinearVector::norm(self : MlregresslinearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresslinearVector::normalize(self : MlregresslinearVector) -> MlregresslinearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslinearVector::dist(self : MlregresslinearVector, other : MlregresslinearVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresslinearVector::to_string(self : MlregresslinearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_linear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_linear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_linear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_linear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_linear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_linear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_linear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_linear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_linear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_linear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_linear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_linear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_linear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_linear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_linear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_linear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_linear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_linear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_linear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresslinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_frame_make(size : Int) -> MlregresslinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_frame_len(s : MlregresslinearFrame) -> Int { s.size }

pub fn ml_regress_linear_frame_get(s : MlregresslinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_frame_set(s : MlregresslinearFrame, i : Int, v : Double) -> MlregresslinearFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_frame_sum(s : MlregresslinearFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_frame_mean(s : MlregresslinearFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_frame_scale(s : MlregresslinearFrame, f : Double) -> MlregresslinearFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_frame_add(a : MlregresslinearFrame, b : MlregresslinearFrame) -> MlregresslinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_frame_copy(s : MlregresslinearFrame) -> MlregresslinearFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_frame_fill(s : MlregresslinearFrame, v : Double) -> MlregresslinearFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_frame_min(s : MlregresslinearFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_frame_max(s : MlregresslinearFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_frame_to_string(s : MlregresslinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_table_make(size : Int) -> MlregresslinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_table_len(s : MlregresslinearTable) -> Int { s.size }

pub fn ml_regress_linear_table_get(s : MlregresslinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_table_set(s : MlregresslinearTable, i : Int, v : Double) -> MlregresslinearTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_table_sum(s : MlregresslinearTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_table_mean(s : MlregresslinearTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_table_scale(s : MlregresslinearTable, f : Double) -> MlregresslinearTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_table_add(a : MlregresslinearTable, b : MlregresslinearTable) -> MlregresslinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_table_copy(s : MlregresslinearTable) -> MlregresslinearTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_table_fill(s : MlregresslinearTable, v : Double) -> MlregresslinearTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_table_min(s : MlregresslinearTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_table_max(s : MlregresslinearTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_table_to_string(s : MlregresslinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_graphn_make(size : Int) -> MlregresslinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_graphn_len(s : MlregresslinearGraphN) -> Int { s.size }

pub fn ml_regress_linear_graphn_get(s : MlregresslinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_graphn_set(s : MlregresslinearGraphN, i : Int, v : Double) -> MlregresslinearGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_graphn_sum(s : MlregresslinearGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_graphn_mean(s : MlregresslinearGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_graphn_scale(s : MlregresslinearGraphN, f : Double) -> MlregresslinearGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_graphn_add(a : MlregresslinearGraphN, b : MlregresslinearGraphN) -> MlregresslinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_graphn_copy(s : MlregresslinearGraphN) -> MlregresslinearGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_graphn_fill(s : MlregresslinearGraphN, v : Double) -> MlregresslinearGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_graphn_min(s : MlregresslinearGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_graphn_max(s : MlregresslinearGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_graphn_to_string(s : MlregresslinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_node_make(size : Int) -> MlregresslinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_node_len(s : MlregresslinearNode) -> Int { s.size }

pub fn ml_regress_linear_node_get(s : MlregresslinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_node_set(s : MlregresslinearNode, i : Int, v : Double) -> MlregresslinearNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_node_sum(s : MlregresslinearNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_node_mean(s : MlregresslinearNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_node_scale(s : MlregresslinearNode, f : Double) -> MlregresslinearNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_node_add(a : MlregresslinearNode, b : MlregresslinearNode) -> MlregresslinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_node_copy(s : MlregresslinearNode) -> MlregresslinearNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_node_fill(s : MlregresslinearNode, v : Double) -> MlregresslinearNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_node_min(s : MlregresslinearNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_node_max(s : MlregresslinearNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_node_to_string(s : MlregresslinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_edge_make(size : Int) -> MlregresslinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_edge_len(s : MlregresslinearEdge) -> Int { s.size }

pub fn ml_regress_linear_edge_get(s : MlregresslinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_edge_set(s : MlregresslinearEdge, i : Int, v : Double) -> MlregresslinearEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_edge_sum(s : MlregresslinearEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_edge_mean(s : MlregresslinearEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_edge_scale(s : MlregresslinearEdge, f : Double) -> MlregresslinearEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_edge_add(a : MlregresslinearEdge, b : MlregresslinearEdge) -> MlregresslinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_edge_copy(s : MlregresslinearEdge) -> MlregresslinearEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_edge_fill(s : MlregresslinearEdge, v : Double) -> MlregresslinearEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_edge_min(s : MlregresslinearEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_edge_max(s : MlregresslinearEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_edge_to_string(s : MlregresslinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_path_make(size : Int) -> MlregresslinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_path_len(s : MlregresslinearPath) -> Int { s.size }

pub fn ml_regress_linear_path_get(s : MlregresslinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_path_set(s : MlregresslinearPath, i : Int, v : Double) -> MlregresslinearPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_path_sum(s : MlregresslinearPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_path_mean(s : MlregresslinearPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_path_scale(s : MlregresslinearPath, f : Double) -> MlregresslinearPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_path_add(a : MlregresslinearPath, b : MlregresslinearPath) -> MlregresslinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_path_copy(s : MlregresslinearPath) -> MlregresslinearPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_path_fill(s : MlregresslinearPath, v : Double) -> MlregresslinearPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_path_min(s : MlregresslinearPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_path_max(s : MlregresslinearPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_path_to_string(s : MlregresslinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_cluster_make(size : Int) -> MlregresslinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_cluster_len(s : MlregresslinearCluster) -> Int { s.size }

pub fn ml_regress_linear_cluster_get(s : MlregresslinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_cluster_set(s : MlregresslinearCluster, i : Int, v : Double) -> MlregresslinearCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cluster_sum(s : MlregresslinearCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_cluster_mean(s : MlregresslinearCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_cluster_scale(s : MlregresslinearCluster, f : Double) -> MlregresslinearCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cluster_add(a : MlregresslinearCluster, b : MlregresslinearCluster) -> MlregresslinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_cluster_copy(s : MlregresslinearCluster) -> MlregresslinearCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cluster_fill(s : MlregresslinearCluster, v : Double) -> MlregresslinearCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cluster_min(s : MlregresslinearCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_cluster_max(s : MlregresslinearCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_cluster_to_string(s : MlregresslinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_model_make(size : Int) -> MlregresslinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_model_len(s : MlregresslinearModel) -> Int { s.size }

pub fn ml_regress_linear_model_get(s : MlregresslinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_model_set(s : MlregresslinearModel, i : Int, v : Double) -> MlregresslinearModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_model_sum(s : MlregresslinearModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_model_mean(s : MlregresslinearModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_model_scale(s : MlregresslinearModel, f : Double) -> MlregresslinearModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_model_add(a : MlregresslinearModel, b : MlregresslinearModel) -> MlregresslinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_model_copy(s : MlregresslinearModel) -> MlregresslinearModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_model_fill(s : MlregresslinearModel, v : Double) -> MlregresslinearModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_model_min(s : MlregresslinearModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_model_max(s : MlregresslinearModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_model_to_string(s : MlregresslinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_layer_make(size : Int) -> MlregresslinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_layer_len(s : MlregresslinearLayer) -> Int { s.size }

pub fn ml_regress_linear_layer_get(s : MlregresslinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_layer_set(s : MlregresslinearLayer, i : Int, v : Double) -> MlregresslinearLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_layer_sum(s : MlregresslinearLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_layer_mean(s : MlregresslinearLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_layer_scale(s : MlregresslinearLayer, f : Double) -> MlregresslinearLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_layer_add(a : MlregresslinearLayer, b : MlregresslinearLayer) -> MlregresslinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_layer_copy(s : MlregresslinearLayer) -> MlregresslinearLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_layer_fill(s : MlregresslinearLayer, v : Double) -> MlregresslinearLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_layer_min(s : MlregresslinearLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_layer_max(s : MlregresslinearLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_layer_to_string(s : MlregresslinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_buffer_make(size : Int) -> MlregresslinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_buffer_len(s : MlregresslinearBuffer) -> Int { s.size }

pub fn ml_regress_linear_buffer_get(s : MlregresslinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_buffer_set(s : MlregresslinearBuffer, i : Int, v : Double) -> MlregresslinearBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_buffer_sum(s : MlregresslinearBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_buffer_mean(s : MlregresslinearBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_buffer_scale(s : MlregresslinearBuffer, f : Double) -> MlregresslinearBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_buffer_add(a : MlregresslinearBuffer, b : MlregresslinearBuffer) -> MlregresslinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_buffer_copy(s : MlregresslinearBuffer) -> MlregresslinearBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_buffer_fill(s : MlregresslinearBuffer, v : Double) -> MlregresslinearBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_buffer_min(s : MlregresslinearBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_buffer_max(s : MlregresslinearBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_buffer_to_string(s : MlregresslinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_cursor_make(size : Int) -> MlregresslinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_cursor_len(s : MlregresslinearCursor) -> Int { s.size }

pub fn ml_regress_linear_cursor_get(s : MlregresslinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_cursor_set(s : MlregresslinearCursor, i : Int, v : Double) -> MlregresslinearCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cursor_sum(s : MlregresslinearCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_cursor_mean(s : MlregresslinearCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_cursor_scale(s : MlregresslinearCursor, f : Double) -> MlregresslinearCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cursor_add(a : MlregresslinearCursor, b : MlregresslinearCursor) -> MlregresslinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_cursor_copy(s : MlregresslinearCursor) -> MlregresslinearCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cursor_fill(s : MlregresslinearCursor, v : Double) -> MlregresslinearCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_cursor_min(s : MlregresslinearCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_cursor_max(s : MlregresslinearCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_cursor_to_string(s : MlregresslinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_view_make(size : Int) -> MlregresslinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_view_len(s : MlregresslinearView) -> Int { s.size }

pub fn ml_regress_linear_view_get(s : MlregresslinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_view_set(s : MlregresslinearView, i : Int, v : Double) -> MlregresslinearView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_view_sum(s : MlregresslinearView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_view_mean(s : MlregresslinearView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_view_scale(s : MlregresslinearView, f : Double) -> MlregresslinearView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_view_add(a : MlregresslinearView, b : MlregresslinearView) -> MlregresslinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_view_copy(s : MlregresslinearView) -> MlregresslinearView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_view_fill(s : MlregresslinearView, v : Double) -> MlregresslinearView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_view_min(s : MlregresslinearView) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_view_max(s : MlregresslinearView) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_view_to_string(s : MlregresslinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_range_make(size : Int) -> MlregresslinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_range_len(s : MlregresslinearRange) -> Int { s.size }

pub fn ml_regress_linear_range_get(s : MlregresslinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_range_set(s : MlregresslinearRange, i : Int, v : Double) -> MlregresslinearRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_range_sum(s : MlregresslinearRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_range_mean(s : MlregresslinearRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_range_scale(s : MlregresslinearRange, f : Double) -> MlregresslinearRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_range_add(a : MlregresslinearRange, b : MlregresslinearRange) -> MlregresslinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_range_copy(s : MlregresslinearRange) -> MlregresslinearRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_range_fill(s : MlregresslinearRange, v : Double) -> MlregresslinearRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_range_min(s : MlregresslinearRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_range_max(s : MlregresslinearRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_range_to_string(s : MlregresslinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_slice_make(size : Int) -> MlregresslinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_slice_len(s : MlregresslinearSlice) -> Int { s.size }

pub fn ml_regress_linear_slice_get(s : MlregresslinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_slice_set(s : MlregresslinearSlice, i : Int, v : Double) -> MlregresslinearSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_slice_sum(s : MlregresslinearSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_slice_mean(s : MlregresslinearSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_slice_scale(s : MlregresslinearSlice, f : Double) -> MlregresslinearSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_slice_add(a : MlregresslinearSlice, b : MlregresslinearSlice) -> MlregresslinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_linear_slice_copy(s : MlregresslinearSlice) -> MlregresslinearSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_slice_fill(s : MlregresslinearSlice, v : Double) -> MlregresslinearSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_linear_slice_min(s : MlregresslinearSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_slice_max(s : MlregresslinearSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_slice_to_string(s : MlregresslinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

