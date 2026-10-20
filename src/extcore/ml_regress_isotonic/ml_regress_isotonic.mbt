///===
/// extcore/ml_regress_isotonic

pub(all) struct MlregressisotonicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_isotonic_make_point(x : Double, y : Double) -> MlregressisotonicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_isotonic_make_point3(x : Double, y : Double, z : Double) -> MlregressisotonicPoint {
  { x, y, z, label: 0 }
}

pub fn MlregressisotonicPoint::x(self : MlregressisotonicPoint) -> Double { self.x }

pub fn MlregressisotonicPoint::y(self : MlregressisotonicPoint) -> Double { self.y }

pub fn MlregressisotonicPoint::z(self : MlregressisotonicPoint) -> Double { self.z }

pub fn MlregressisotonicPoint::label(self : MlregressisotonicPoint) -> Int { self.label }

pub fn MlregressisotonicPoint::dist(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregressisotonicPoint::add(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregressisotonicPoint::sub(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregressisotonicPoint::scale(self : MlregressisotonicPoint, s : Double) -> MlregressisotonicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregressisotonicPoint::dot(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregressisotonicPoint::cross(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregressisotonicPoint::norm(self : MlregressisotonicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregressisotonicPoint::normalize(self : MlregressisotonicPoint) -> MlregressisotonicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressisotonicPoint::negate(self : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregressisotonicPoint::mid(self : MlregressisotonicPoint, other : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregressisotonicPoint::lerp(self : MlregressisotonicPoint, other : MlregressisotonicPoint, t : Double) -> MlregressisotonicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregressisotonicPoint::to_string(self : MlregressisotonicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregressisotonicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_isotonic_make_series(vals : Array[Double], name : String) -> MlregressisotonicSeries {
  { vals, name, meta: 0 }
}

pub fn MlregressisotonicSeries::len(self : MlregressisotonicSeries) -> Int { self.vals.length() }

pub fn MlregressisotonicSeries::sum(self : MlregressisotonicSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregressisotonicSeries::mean(self : MlregressisotonicSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregressisotonicSeries::min(self : MlregressisotonicSeries) -> Double { @_common.min(self.vals) }

pub fn MlregressisotonicSeries::max(self : MlregressisotonicSeries) -> Double { @_common.max(self.vals) }

pub fn MlregressisotonicSeries::range(self : MlregressisotonicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregressisotonicSeries::variance(self : MlregressisotonicSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregressisotonicSeries::std(self : MlregressisotonicSeries) -> Double { @_common.std(self.vals) }

pub fn MlregressisotonicSeries::median(self : MlregressisotonicSeries) -> Double { @_common.median(self.vals) }

pub fn MlregressisotonicSeries::scale(self : MlregressisotonicSeries, f : Double) -> MlregressisotonicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregressisotonicSeries::add(self : MlregressisotonicSeries, other : MlregressisotonicSeries) -> MlregressisotonicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregressisotonicSeries::sub(self : MlregressisotonicSeries, other : MlregressisotonicSeries) -> MlregressisotonicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregressisotonicSeries::normalize(self : MlregressisotonicSeries) -> MlregressisotonicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregressisotonicSeries::cumsum(self : MlregressisotonicSeries) -> MlregressisotonicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregressisotonicSeries::to_string(self : MlregressisotonicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressisotonicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_isotonic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressisotonicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_isotonic_matrix_identity(n : Int) -> MlregressisotonicMatrix {
  let m = ml_regress_isotonic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregressisotonicMatrix::get(self : MlregressisotonicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregressisotonicMatrix::transpose(self : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  let result = ml_regress_isotonic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregressisotonicMatrix::add(self : MlregressisotonicMatrix, other : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_isotonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregressisotonicMatrix::scale(self : MlregressisotonicMatrix, s : Double) -> MlregressisotonicMatrix {
  let result = ml_regress_isotonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregressisotonicMatrix::multiply(self : MlregressisotonicMatrix, other : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  if self.cols != other.rows { return ml_regress_isotonic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_isotonic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregressisotonicMatrix::trace(self : MlregressisotonicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregressisotonicMatrix::det(self : MlregressisotonicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregressisotonicMatrix::norm(self : MlregressisotonicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregressisotonicMatrix::to_string(self : MlregressisotonicMatrix) -> String {
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

pub(all) struct MlregressisotonicVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_isotonic_make_vector(comps : Array[Double]) -> MlregressisotonicVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_isotonic_vector_zero(dim : Int) -> MlregressisotonicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregressisotonicVector::add(self : MlregressisotonicVector, other : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressisotonicVector::sub(self : MlregressisotonicVector, other : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressisotonicVector::scale(self : MlregressisotonicVector, s : Double) -> MlregressisotonicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregressisotonicVector::dot(self : MlregressisotonicVector, other : MlregressisotonicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregressisotonicVector::norm(self : MlregressisotonicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregressisotonicVector::normalize(self : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressisotonicVector::dist(self : MlregressisotonicVector, other : MlregressisotonicVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregressisotonicVector::to_string(self : MlregressisotonicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_isotonic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_isotonic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_isotonic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_isotonic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_isotonic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_isotonic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_isotonic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_isotonic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_isotonic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_isotonic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_isotonic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_isotonic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_isotonic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_isotonic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_isotonic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_isotonic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_isotonic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_isotonic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_isotonic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_isotonic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_isotonic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_isotonic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_isotonic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_isotonic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_isotonic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_isotonic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_isotonic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_isotonic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_isotonic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregressisotonicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_frame_make(size : Int) -> MlregressisotonicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_frame_len(s : MlregressisotonicFrame) -> Int { s.size }

pub fn ml_regress_isotonic_frame_get(s : MlregressisotonicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_frame_set(s : MlregressisotonicFrame, i : Int, v : Double) -> MlregressisotonicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_frame_sum(s : MlregressisotonicFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_frame_mean(s : MlregressisotonicFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_frame_scale(s : MlregressisotonicFrame, f : Double) -> MlregressisotonicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_frame_add(a : MlregressisotonicFrame, b : MlregressisotonicFrame) -> MlregressisotonicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_frame_copy(s : MlregressisotonicFrame) -> MlregressisotonicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_frame_fill(s : MlregressisotonicFrame, v : Double) -> MlregressisotonicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_frame_min(s : MlregressisotonicFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_frame_max(s : MlregressisotonicFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_frame_to_string(s : MlregressisotonicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_table_make(size : Int) -> MlregressisotonicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_table_len(s : MlregressisotonicTable) -> Int { s.size }

pub fn ml_regress_isotonic_table_get(s : MlregressisotonicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_table_set(s : MlregressisotonicTable, i : Int, v : Double) -> MlregressisotonicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_table_sum(s : MlregressisotonicTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_table_mean(s : MlregressisotonicTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_table_scale(s : MlregressisotonicTable, f : Double) -> MlregressisotonicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_table_add(a : MlregressisotonicTable, b : MlregressisotonicTable) -> MlregressisotonicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_table_copy(s : MlregressisotonicTable) -> MlregressisotonicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_table_fill(s : MlregressisotonicTable, v : Double) -> MlregressisotonicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_table_min(s : MlregressisotonicTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_table_max(s : MlregressisotonicTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_table_to_string(s : MlregressisotonicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_graphn_make(size : Int) -> MlregressisotonicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_graphn_len(s : MlregressisotonicGraphN) -> Int { s.size }

pub fn ml_regress_isotonic_graphn_get(s : MlregressisotonicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_graphn_set(s : MlregressisotonicGraphN, i : Int, v : Double) -> MlregressisotonicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_graphn_sum(s : MlregressisotonicGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_graphn_mean(s : MlregressisotonicGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_graphn_scale(s : MlregressisotonicGraphN, f : Double) -> MlregressisotonicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_graphn_add(a : MlregressisotonicGraphN, b : MlregressisotonicGraphN) -> MlregressisotonicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_graphn_copy(s : MlregressisotonicGraphN) -> MlregressisotonicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_graphn_fill(s : MlregressisotonicGraphN, v : Double) -> MlregressisotonicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_graphn_min(s : MlregressisotonicGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_graphn_max(s : MlregressisotonicGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_graphn_to_string(s : MlregressisotonicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_node_make(size : Int) -> MlregressisotonicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_node_len(s : MlregressisotonicNode) -> Int { s.size }

pub fn ml_regress_isotonic_node_get(s : MlregressisotonicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_node_set(s : MlregressisotonicNode, i : Int, v : Double) -> MlregressisotonicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_node_sum(s : MlregressisotonicNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_node_mean(s : MlregressisotonicNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_node_scale(s : MlregressisotonicNode, f : Double) -> MlregressisotonicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_node_add(a : MlregressisotonicNode, b : MlregressisotonicNode) -> MlregressisotonicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_node_copy(s : MlregressisotonicNode) -> MlregressisotonicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_node_fill(s : MlregressisotonicNode, v : Double) -> MlregressisotonicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_node_min(s : MlregressisotonicNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_node_max(s : MlregressisotonicNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_node_to_string(s : MlregressisotonicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_edge_make(size : Int) -> MlregressisotonicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_edge_len(s : MlregressisotonicEdge) -> Int { s.size }

pub fn ml_regress_isotonic_edge_get(s : MlregressisotonicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_edge_set(s : MlregressisotonicEdge, i : Int, v : Double) -> MlregressisotonicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_edge_sum(s : MlregressisotonicEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_edge_mean(s : MlregressisotonicEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_edge_scale(s : MlregressisotonicEdge, f : Double) -> MlregressisotonicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_edge_add(a : MlregressisotonicEdge, b : MlregressisotonicEdge) -> MlregressisotonicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_edge_copy(s : MlregressisotonicEdge) -> MlregressisotonicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_edge_fill(s : MlregressisotonicEdge, v : Double) -> MlregressisotonicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_edge_min(s : MlregressisotonicEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_edge_max(s : MlregressisotonicEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_edge_to_string(s : MlregressisotonicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_path_make(size : Int) -> MlregressisotonicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_path_len(s : MlregressisotonicPath) -> Int { s.size }

pub fn ml_regress_isotonic_path_get(s : MlregressisotonicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_path_set(s : MlregressisotonicPath, i : Int, v : Double) -> MlregressisotonicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_path_sum(s : MlregressisotonicPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_path_mean(s : MlregressisotonicPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_path_scale(s : MlregressisotonicPath, f : Double) -> MlregressisotonicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_path_add(a : MlregressisotonicPath, b : MlregressisotonicPath) -> MlregressisotonicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_path_copy(s : MlregressisotonicPath) -> MlregressisotonicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_path_fill(s : MlregressisotonicPath, v : Double) -> MlregressisotonicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_path_min(s : MlregressisotonicPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_path_max(s : MlregressisotonicPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_path_to_string(s : MlregressisotonicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_cluster_make(size : Int) -> MlregressisotonicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_cluster_len(s : MlregressisotonicCluster) -> Int { s.size }

pub fn ml_regress_isotonic_cluster_get(s : MlregressisotonicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_cluster_set(s : MlregressisotonicCluster, i : Int, v : Double) -> MlregressisotonicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cluster_sum(s : MlregressisotonicCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_cluster_mean(s : MlregressisotonicCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_cluster_scale(s : MlregressisotonicCluster, f : Double) -> MlregressisotonicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cluster_add(a : MlregressisotonicCluster, b : MlregressisotonicCluster) -> MlregressisotonicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_cluster_copy(s : MlregressisotonicCluster) -> MlregressisotonicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cluster_fill(s : MlregressisotonicCluster, v : Double) -> MlregressisotonicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cluster_min(s : MlregressisotonicCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_cluster_max(s : MlregressisotonicCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_cluster_to_string(s : MlregressisotonicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_model_make(size : Int) -> MlregressisotonicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_model_len(s : MlregressisotonicModel) -> Int { s.size }

pub fn ml_regress_isotonic_model_get(s : MlregressisotonicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_model_set(s : MlregressisotonicModel, i : Int, v : Double) -> MlregressisotonicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_model_sum(s : MlregressisotonicModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_model_mean(s : MlregressisotonicModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_model_scale(s : MlregressisotonicModel, f : Double) -> MlregressisotonicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_model_add(a : MlregressisotonicModel, b : MlregressisotonicModel) -> MlregressisotonicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_model_copy(s : MlregressisotonicModel) -> MlregressisotonicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_model_fill(s : MlregressisotonicModel, v : Double) -> MlregressisotonicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_model_min(s : MlregressisotonicModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_model_max(s : MlregressisotonicModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_model_to_string(s : MlregressisotonicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_layer_make(size : Int) -> MlregressisotonicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_layer_len(s : MlregressisotonicLayer) -> Int { s.size }

pub fn ml_regress_isotonic_layer_get(s : MlregressisotonicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_layer_set(s : MlregressisotonicLayer, i : Int, v : Double) -> MlregressisotonicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_layer_sum(s : MlregressisotonicLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_layer_mean(s : MlregressisotonicLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_layer_scale(s : MlregressisotonicLayer, f : Double) -> MlregressisotonicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_layer_add(a : MlregressisotonicLayer, b : MlregressisotonicLayer) -> MlregressisotonicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_layer_copy(s : MlregressisotonicLayer) -> MlregressisotonicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_layer_fill(s : MlregressisotonicLayer, v : Double) -> MlregressisotonicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_layer_min(s : MlregressisotonicLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_layer_max(s : MlregressisotonicLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_layer_to_string(s : MlregressisotonicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_buffer_make(size : Int) -> MlregressisotonicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_buffer_len(s : MlregressisotonicBuffer) -> Int { s.size }

pub fn ml_regress_isotonic_buffer_get(s : MlregressisotonicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_buffer_set(s : MlregressisotonicBuffer, i : Int, v : Double) -> MlregressisotonicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_buffer_sum(s : MlregressisotonicBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_buffer_mean(s : MlregressisotonicBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_buffer_scale(s : MlregressisotonicBuffer, f : Double) -> MlregressisotonicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_buffer_add(a : MlregressisotonicBuffer, b : MlregressisotonicBuffer) -> MlregressisotonicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_buffer_copy(s : MlregressisotonicBuffer) -> MlregressisotonicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_buffer_fill(s : MlregressisotonicBuffer, v : Double) -> MlregressisotonicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_buffer_min(s : MlregressisotonicBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_buffer_max(s : MlregressisotonicBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_buffer_to_string(s : MlregressisotonicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_cursor_make(size : Int) -> MlregressisotonicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_cursor_len(s : MlregressisotonicCursor) -> Int { s.size }

pub fn ml_regress_isotonic_cursor_get(s : MlregressisotonicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_cursor_set(s : MlregressisotonicCursor, i : Int, v : Double) -> MlregressisotonicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cursor_sum(s : MlregressisotonicCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_cursor_mean(s : MlregressisotonicCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_cursor_scale(s : MlregressisotonicCursor, f : Double) -> MlregressisotonicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cursor_add(a : MlregressisotonicCursor, b : MlregressisotonicCursor) -> MlregressisotonicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_cursor_copy(s : MlregressisotonicCursor) -> MlregressisotonicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cursor_fill(s : MlregressisotonicCursor, v : Double) -> MlregressisotonicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_cursor_min(s : MlregressisotonicCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_cursor_max(s : MlregressisotonicCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_cursor_to_string(s : MlregressisotonicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_view_make(size : Int) -> MlregressisotonicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_view_len(s : MlregressisotonicView) -> Int { s.size }

pub fn ml_regress_isotonic_view_get(s : MlregressisotonicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_view_set(s : MlregressisotonicView, i : Int, v : Double) -> MlregressisotonicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_view_sum(s : MlregressisotonicView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_view_mean(s : MlregressisotonicView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_view_scale(s : MlregressisotonicView, f : Double) -> MlregressisotonicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_view_add(a : MlregressisotonicView, b : MlregressisotonicView) -> MlregressisotonicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_view_copy(s : MlregressisotonicView) -> MlregressisotonicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_view_fill(s : MlregressisotonicView, v : Double) -> MlregressisotonicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_view_min(s : MlregressisotonicView) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_view_max(s : MlregressisotonicView) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_view_to_string(s : MlregressisotonicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_range_make(size : Int) -> MlregressisotonicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_range_len(s : MlregressisotonicRange) -> Int { s.size }

pub fn ml_regress_isotonic_range_get(s : MlregressisotonicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_range_set(s : MlregressisotonicRange, i : Int, v : Double) -> MlregressisotonicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_range_sum(s : MlregressisotonicRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_range_mean(s : MlregressisotonicRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_range_scale(s : MlregressisotonicRange, f : Double) -> MlregressisotonicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_range_add(a : MlregressisotonicRange, b : MlregressisotonicRange) -> MlregressisotonicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_range_copy(s : MlregressisotonicRange) -> MlregressisotonicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_range_fill(s : MlregressisotonicRange, v : Double) -> MlregressisotonicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_range_min(s : MlregressisotonicRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_range_max(s : MlregressisotonicRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_range_to_string(s : MlregressisotonicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_slice_make(size : Int) -> MlregressisotonicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_slice_len(s : MlregressisotonicSlice) -> Int { s.size }

pub fn ml_regress_isotonic_slice_get(s : MlregressisotonicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_slice_set(s : MlregressisotonicSlice, i : Int, v : Double) -> MlregressisotonicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_slice_sum(s : MlregressisotonicSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_isotonic_slice_mean(s : MlregressisotonicSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_isotonic_slice_scale(s : MlregressisotonicSlice, f : Double) -> MlregressisotonicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_slice_add(a : MlregressisotonicSlice, b : MlregressisotonicSlice) -> MlregressisotonicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_isotonic_slice_copy(s : MlregressisotonicSlice) -> MlregressisotonicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_slice_fill(s : MlregressisotonicSlice, v : Double) -> MlregressisotonicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_isotonic_slice_min(s : MlregressisotonicSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_isotonic_slice_max(s : MlregressisotonicSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_isotonic_slice_to_string(s : MlregressisotonicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

