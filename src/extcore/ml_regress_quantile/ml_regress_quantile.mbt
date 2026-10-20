///===
/// extcore/ml_regress_quantile

pub(all) struct MlregressquantilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_quantile_make_point(x : Double, y : Double) -> MlregressquantilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_quantile_make_point3(x : Double, y : Double, z : Double) -> MlregressquantilePoint {
  { x, y, z, label: 0 }
}

pub fn MlregressquantilePoint::x(self : MlregressquantilePoint) -> Double { self.x }

pub fn MlregressquantilePoint::y(self : MlregressquantilePoint) -> Double { self.y }

pub fn MlregressquantilePoint::z(self : MlregressquantilePoint) -> Double { self.z }

pub fn MlregressquantilePoint::label(self : MlregressquantilePoint) -> Int { self.label }

pub fn MlregressquantilePoint::dist(self : MlregressquantilePoint, other : MlregressquantilePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregressquantilePoint::add(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregressquantilePoint::sub(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregressquantilePoint::scale(self : MlregressquantilePoint, s : Double) -> MlregressquantilePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregressquantilePoint::dot(self : MlregressquantilePoint, other : MlregressquantilePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregressquantilePoint::cross(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregressquantilePoint::norm(self : MlregressquantilePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregressquantilePoint::normalize(self : MlregressquantilePoint) -> MlregressquantilePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressquantilePoint::negate(self : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregressquantilePoint::mid(self : MlregressquantilePoint, other : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregressquantilePoint::lerp(self : MlregressquantilePoint, other : MlregressquantilePoint, t : Double) -> MlregressquantilePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregressquantilePoint::to_string(self : MlregressquantilePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregressquantileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_quantile_make_series(vals : Array[Double], name : String) -> MlregressquantileSeries {
  { vals, name, meta: 0 }
}

pub fn MlregressquantileSeries::len(self : MlregressquantileSeries) -> Int { self.vals.length() }

pub fn MlregressquantileSeries::sum(self : MlregressquantileSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregressquantileSeries::mean(self : MlregressquantileSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregressquantileSeries::min(self : MlregressquantileSeries) -> Double { @_common.min(self.vals) }

pub fn MlregressquantileSeries::max(self : MlregressquantileSeries) -> Double { @_common.max(self.vals) }

pub fn MlregressquantileSeries::range(self : MlregressquantileSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregressquantileSeries::variance(self : MlregressquantileSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregressquantileSeries::std(self : MlregressquantileSeries) -> Double { @_common.std(self.vals) }

pub fn MlregressquantileSeries::median(self : MlregressquantileSeries) -> Double { @_common.median(self.vals) }

pub fn MlregressquantileSeries::scale(self : MlregressquantileSeries, f : Double) -> MlregressquantileSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregressquantileSeries::add(self : MlregressquantileSeries, other : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregressquantileSeries::sub(self : MlregressquantileSeries, other : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregressquantileSeries::normalize(self : MlregressquantileSeries) -> MlregressquantileSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregressquantileSeries::cumsum(self : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregressquantileSeries::to_string(self : MlregressquantileSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressquantileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_quantile_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressquantileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_quantile_matrix_identity(n : Int) -> MlregressquantileMatrix {
  let m = ml_regress_quantile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregressquantileMatrix::get(self : MlregressquantileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregressquantileMatrix::transpose(self : MlregressquantileMatrix) -> MlregressquantileMatrix {
  let result = ml_regress_quantile_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregressquantileMatrix::add(self : MlregressquantileMatrix, other : MlregressquantileMatrix) -> MlregressquantileMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_quantile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregressquantileMatrix::scale(self : MlregressquantileMatrix, s : Double) -> MlregressquantileMatrix {
  let result = ml_regress_quantile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregressquantileMatrix::multiply(self : MlregressquantileMatrix, other : MlregressquantileMatrix) -> MlregressquantileMatrix {
  if self.cols != other.rows { return ml_regress_quantile_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_quantile_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregressquantileMatrix::trace(self : MlregressquantileMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregressquantileMatrix::det(self : MlregressquantileMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregressquantileMatrix::norm(self : MlregressquantileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregressquantileMatrix::to_string(self : MlregressquantileMatrix) -> String {
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

pub(all) struct MlregressquantileVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_quantile_make_vector(comps : Array[Double]) -> MlregressquantileVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_quantile_vector_zero(dim : Int) -> MlregressquantileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregressquantileVector::add(self : MlregressquantileVector, other : MlregressquantileVector) -> MlregressquantileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressquantileVector::sub(self : MlregressquantileVector, other : MlregressquantileVector) -> MlregressquantileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressquantileVector::scale(self : MlregressquantileVector, s : Double) -> MlregressquantileVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregressquantileVector::dot(self : MlregressquantileVector, other : MlregressquantileVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregressquantileVector::norm(self : MlregressquantileVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregressquantileVector::normalize(self : MlregressquantileVector) -> MlregressquantileVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressquantileVector::dist(self : MlregressquantileVector, other : MlregressquantileVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregressquantileVector::to_string(self : MlregressquantileVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_quantile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_quantile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_quantile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_quantile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_quantile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_quantile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_quantile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_quantile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_quantile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_quantile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_quantile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_quantile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_quantile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_quantile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_quantile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_quantile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_quantile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_quantile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_quantile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_quantile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_quantile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_quantile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_quantile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_quantile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_quantile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_quantile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_quantile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_quantile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_quantile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregressquantileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_frame_make(size : Int) -> MlregressquantileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_frame_len(s : MlregressquantileFrame) -> Int { s.size }

pub fn ml_regress_quantile_frame_get(s : MlregressquantileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_frame_set(s : MlregressquantileFrame, i : Int, v : Double) -> MlregressquantileFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_sum(s : MlregressquantileFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_frame_mean(s : MlregressquantileFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_frame_scale(s : MlregressquantileFrame, f : Double) -> MlregressquantileFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_add(a : MlregressquantileFrame, b : MlregressquantileFrame) -> MlregressquantileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_frame_copy(s : MlregressquantileFrame) -> MlregressquantileFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_fill(s : MlregressquantileFrame, v : Double) -> MlregressquantileFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_min(s : MlregressquantileFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_frame_max(s : MlregressquantileFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_frame_to_string(s : MlregressquantileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_table_make(size : Int) -> MlregressquantileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_table_len(s : MlregressquantileTable) -> Int { s.size }

pub fn ml_regress_quantile_table_get(s : MlregressquantileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_table_set(s : MlregressquantileTable, i : Int, v : Double) -> MlregressquantileTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_sum(s : MlregressquantileTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_table_mean(s : MlregressquantileTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_table_scale(s : MlregressquantileTable, f : Double) -> MlregressquantileTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_add(a : MlregressquantileTable, b : MlregressquantileTable) -> MlregressquantileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_table_copy(s : MlregressquantileTable) -> MlregressquantileTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_fill(s : MlregressquantileTable, v : Double) -> MlregressquantileTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_min(s : MlregressquantileTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_table_max(s : MlregressquantileTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_table_to_string(s : MlregressquantileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_graphn_make(size : Int) -> MlregressquantileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_graphn_len(s : MlregressquantileGraphN) -> Int { s.size }

pub fn ml_regress_quantile_graphn_get(s : MlregressquantileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_graphn_set(s : MlregressquantileGraphN, i : Int, v : Double) -> MlregressquantileGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_sum(s : MlregressquantileGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_graphn_mean(s : MlregressquantileGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_graphn_scale(s : MlregressquantileGraphN, f : Double) -> MlregressquantileGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_add(a : MlregressquantileGraphN, b : MlregressquantileGraphN) -> MlregressquantileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_graphn_copy(s : MlregressquantileGraphN) -> MlregressquantileGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_fill(s : MlregressquantileGraphN, v : Double) -> MlregressquantileGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_min(s : MlregressquantileGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_graphn_max(s : MlregressquantileGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_graphn_to_string(s : MlregressquantileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_node_make(size : Int) -> MlregressquantileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_node_len(s : MlregressquantileNode) -> Int { s.size }

pub fn ml_regress_quantile_node_get(s : MlregressquantileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_node_set(s : MlregressquantileNode, i : Int, v : Double) -> MlregressquantileNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_sum(s : MlregressquantileNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_node_mean(s : MlregressquantileNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_node_scale(s : MlregressquantileNode, f : Double) -> MlregressquantileNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_add(a : MlregressquantileNode, b : MlregressquantileNode) -> MlregressquantileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_node_copy(s : MlregressquantileNode) -> MlregressquantileNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_fill(s : MlregressquantileNode, v : Double) -> MlregressquantileNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_min(s : MlregressquantileNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_node_max(s : MlregressquantileNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_node_to_string(s : MlregressquantileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_edge_make(size : Int) -> MlregressquantileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_edge_len(s : MlregressquantileEdge) -> Int { s.size }

pub fn ml_regress_quantile_edge_get(s : MlregressquantileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_edge_set(s : MlregressquantileEdge, i : Int, v : Double) -> MlregressquantileEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_sum(s : MlregressquantileEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_edge_mean(s : MlregressquantileEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_edge_scale(s : MlregressquantileEdge, f : Double) -> MlregressquantileEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_add(a : MlregressquantileEdge, b : MlregressquantileEdge) -> MlregressquantileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_edge_copy(s : MlregressquantileEdge) -> MlregressquantileEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_fill(s : MlregressquantileEdge, v : Double) -> MlregressquantileEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_min(s : MlregressquantileEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_edge_max(s : MlregressquantileEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_edge_to_string(s : MlregressquantileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_path_make(size : Int) -> MlregressquantilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_path_len(s : MlregressquantilePath) -> Int { s.size }

pub fn ml_regress_quantile_path_get(s : MlregressquantilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_path_set(s : MlregressquantilePath, i : Int, v : Double) -> MlregressquantilePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_sum(s : MlregressquantilePath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_path_mean(s : MlregressquantilePath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_path_scale(s : MlregressquantilePath, f : Double) -> MlregressquantilePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_add(a : MlregressquantilePath, b : MlregressquantilePath) -> MlregressquantilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_path_copy(s : MlregressquantilePath) -> MlregressquantilePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_fill(s : MlregressquantilePath, v : Double) -> MlregressquantilePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_min(s : MlregressquantilePath) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_path_max(s : MlregressquantilePath) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_path_to_string(s : MlregressquantilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_cluster_make(size : Int) -> MlregressquantileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_cluster_len(s : MlregressquantileCluster) -> Int { s.size }

pub fn ml_regress_quantile_cluster_get(s : MlregressquantileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_cluster_set(s : MlregressquantileCluster, i : Int, v : Double) -> MlregressquantileCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_sum(s : MlregressquantileCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_cluster_mean(s : MlregressquantileCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_cluster_scale(s : MlregressquantileCluster, f : Double) -> MlregressquantileCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_add(a : MlregressquantileCluster, b : MlregressquantileCluster) -> MlregressquantileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_cluster_copy(s : MlregressquantileCluster) -> MlregressquantileCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_fill(s : MlregressquantileCluster, v : Double) -> MlregressquantileCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_min(s : MlregressquantileCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_cluster_max(s : MlregressquantileCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_cluster_to_string(s : MlregressquantileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_model_make(size : Int) -> MlregressquantileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_model_len(s : MlregressquantileModel) -> Int { s.size }

pub fn ml_regress_quantile_model_get(s : MlregressquantileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_model_set(s : MlregressquantileModel, i : Int, v : Double) -> MlregressquantileModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_sum(s : MlregressquantileModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_model_mean(s : MlregressquantileModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_model_scale(s : MlregressquantileModel, f : Double) -> MlregressquantileModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_add(a : MlregressquantileModel, b : MlregressquantileModel) -> MlregressquantileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_model_copy(s : MlregressquantileModel) -> MlregressquantileModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_fill(s : MlregressquantileModel, v : Double) -> MlregressquantileModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_min(s : MlregressquantileModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_model_max(s : MlregressquantileModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_model_to_string(s : MlregressquantileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_layer_make(size : Int) -> MlregressquantileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_layer_len(s : MlregressquantileLayer) -> Int { s.size }

pub fn ml_regress_quantile_layer_get(s : MlregressquantileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_layer_set(s : MlregressquantileLayer, i : Int, v : Double) -> MlregressquantileLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_sum(s : MlregressquantileLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_layer_mean(s : MlregressquantileLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_layer_scale(s : MlregressquantileLayer, f : Double) -> MlregressquantileLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_add(a : MlregressquantileLayer, b : MlregressquantileLayer) -> MlregressquantileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_layer_copy(s : MlregressquantileLayer) -> MlregressquantileLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_fill(s : MlregressquantileLayer, v : Double) -> MlregressquantileLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_min(s : MlregressquantileLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_layer_max(s : MlregressquantileLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_layer_to_string(s : MlregressquantileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_buffer_make(size : Int) -> MlregressquantileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_buffer_len(s : MlregressquantileBuffer) -> Int { s.size }

pub fn ml_regress_quantile_buffer_get(s : MlregressquantileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_buffer_set(s : MlregressquantileBuffer, i : Int, v : Double) -> MlregressquantileBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_sum(s : MlregressquantileBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_buffer_mean(s : MlregressquantileBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_buffer_scale(s : MlregressquantileBuffer, f : Double) -> MlregressquantileBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_add(a : MlregressquantileBuffer, b : MlregressquantileBuffer) -> MlregressquantileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_buffer_copy(s : MlregressquantileBuffer) -> MlregressquantileBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_fill(s : MlregressquantileBuffer, v : Double) -> MlregressquantileBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_min(s : MlregressquantileBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_buffer_max(s : MlregressquantileBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_buffer_to_string(s : MlregressquantileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_cursor_make(size : Int) -> MlregressquantileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_cursor_len(s : MlregressquantileCursor) -> Int { s.size }

pub fn ml_regress_quantile_cursor_get(s : MlregressquantileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_cursor_set(s : MlregressquantileCursor, i : Int, v : Double) -> MlregressquantileCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_sum(s : MlregressquantileCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_cursor_mean(s : MlregressquantileCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_cursor_scale(s : MlregressquantileCursor, f : Double) -> MlregressquantileCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_add(a : MlregressquantileCursor, b : MlregressquantileCursor) -> MlregressquantileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_cursor_copy(s : MlregressquantileCursor) -> MlregressquantileCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_fill(s : MlregressquantileCursor, v : Double) -> MlregressquantileCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_min(s : MlregressquantileCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_cursor_max(s : MlregressquantileCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_cursor_to_string(s : MlregressquantileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_view_make(size : Int) -> MlregressquantileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_view_len(s : MlregressquantileView) -> Int { s.size }

pub fn ml_regress_quantile_view_get(s : MlregressquantileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_view_set(s : MlregressquantileView, i : Int, v : Double) -> MlregressquantileView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_sum(s : MlregressquantileView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_view_mean(s : MlregressquantileView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_view_scale(s : MlregressquantileView, f : Double) -> MlregressquantileView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_add(a : MlregressquantileView, b : MlregressquantileView) -> MlregressquantileView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_view_copy(s : MlregressquantileView) -> MlregressquantileView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_fill(s : MlregressquantileView, v : Double) -> MlregressquantileView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_min(s : MlregressquantileView) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_view_max(s : MlregressquantileView) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_view_to_string(s : MlregressquantileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_range_make(size : Int) -> MlregressquantileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_range_len(s : MlregressquantileRange) -> Int { s.size }

pub fn ml_regress_quantile_range_get(s : MlregressquantileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_range_set(s : MlregressquantileRange, i : Int, v : Double) -> MlregressquantileRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_sum(s : MlregressquantileRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_range_mean(s : MlregressquantileRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_range_scale(s : MlregressquantileRange, f : Double) -> MlregressquantileRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_add(a : MlregressquantileRange, b : MlregressquantileRange) -> MlregressquantileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_range_copy(s : MlregressquantileRange) -> MlregressquantileRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_fill(s : MlregressquantileRange, v : Double) -> MlregressquantileRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_min(s : MlregressquantileRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_range_max(s : MlregressquantileRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_range_to_string(s : MlregressquantileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_slice_make(size : Int) -> MlregressquantileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_slice_len(s : MlregressquantileSlice) -> Int { s.size }

pub fn ml_regress_quantile_slice_get(s : MlregressquantileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_slice_set(s : MlregressquantileSlice, i : Int, v : Double) -> MlregressquantileSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_sum(s : MlregressquantileSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_slice_mean(s : MlregressquantileSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_slice_scale(s : MlregressquantileSlice, f : Double) -> MlregressquantileSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_add(a : MlregressquantileSlice, b : MlregressquantileSlice) -> MlregressquantileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_slice_copy(s : MlregressquantileSlice) -> MlregressquantileSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_fill(s : MlregressquantileSlice, v : Double) -> MlregressquantileSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_min(s : MlregressquantileSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_slice_max(s : MlregressquantileSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_slice_to_string(s : MlregressquantileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

