///===
/// extcore/ml_ensemble_gbm

pub(all) struct MlensemblegbmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_gbm_make_point(x : Double, y : Double) -> MlensemblegbmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_gbm_make_point3(x : Double, y : Double, z : Double) -> MlensemblegbmPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblegbmPoint::x(self : MlensemblegbmPoint) -> Double { self.x }

pub fn MlensemblegbmPoint::y(self : MlensemblegbmPoint) -> Double { self.y }

pub fn MlensemblegbmPoint::z(self : MlensemblegbmPoint) -> Double { self.z }

pub fn MlensemblegbmPoint::label(self : MlensemblegbmPoint) -> Int { self.label }

pub fn MlensemblegbmPoint::dist(self : MlensemblegbmPoint, other : MlensemblegbmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblegbmPoint::add(self : MlensemblegbmPoint, other : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblegbmPoint::sub(self : MlensemblegbmPoint, other : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblegbmPoint::scale(self : MlensemblegbmPoint, s : Double) -> MlensemblegbmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblegbmPoint::dot(self : MlensemblegbmPoint, other : MlensemblegbmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblegbmPoint::cross(self : MlensemblegbmPoint, other : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblegbmPoint::norm(self : MlensemblegbmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblegbmPoint::normalize(self : MlensemblegbmPoint) -> MlensemblegbmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblegbmPoint::negate(self : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblegbmPoint::mid(self : MlensemblegbmPoint, other : MlensemblegbmPoint) -> MlensemblegbmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblegbmPoint::lerp(self : MlensemblegbmPoint, other : MlensemblegbmPoint, t : Double) -> MlensemblegbmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblegbmPoint::to_string(self : MlensemblegbmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblegbmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_gbm_make_series(vals : Array[Double], name : String) -> MlensemblegbmSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblegbmSeries::len(self : MlensemblegbmSeries) -> Int { self.vals.length() }

pub fn MlensemblegbmSeries::sum(self : MlensemblegbmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblegbmSeries::mean(self : MlensemblegbmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblegbmSeries::min(self : MlensemblegbmSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblegbmSeries::max(self : MlensemblegbmSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblegbmSeries::range(self : MlensemblegbmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblegbmSeries::variance(self : MlensemblegbmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblegbmSeries::std(self : MlensemblegbmSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblegbmSeries::median(self : MlensemblegbmSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblegbmSeries::scale(self : MlensemblegbmSeries, f : Double) -> MlensemblegbmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblegbmSeries::add(self : MlensemblegbmSeries, other : MlensemblegbmSeries) -> MlensemblegbmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblegbmSeries::sub(self : MlensemblegbmSeries, other : MlensemblegbmSeries) -> MlensemblegbmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblegbmSeries::normalize(self : MlensemblegbmSeries) -> MlensemblegbmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblegbmSeries::cumsum(self : MlensemblegbmSeries) -> MlensemblegbmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblegbmSeries::to_string(self : MlensemblegbmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblegbmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_gbm_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblegbmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_gbm_matrix_identity(n : Int) -> MlensemblegbmMatrix {
  let m = ml_ensemble_gbm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblegbmMatrix::get(self : MlensemblegbmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblegbmMatrix::transpose(self : MlensemblegbmMatrix) -> MlensemblegbmMatrix {
  let result = ml_ensemble_gbm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblegbmMatrix::add(self : MlensemblegbmMatrix, other : MlensemblegbmMatrix) -> MlensemblegbmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_gbm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblegbmMatrix::scale(self : MlensemblegbmMatrix, s : Double) -> MlensemblegbmMatrix {
  let result = ml_ensemble_gbm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblegbmMatrix::multiply(self : MlensemblegbmMatrix, other : MlensemblegbmMatrix) -> MlensemblegbmMatrix {
  if self.cols != other.rows { return ml_ensemble_gbm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_gbm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblegbmMatrix::trace(self : MlensemblegbmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblegbmMatrix::det(self : MlensemblegbmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblegbmMatrix::norm(self : MlensemblegbmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblegbmMatrix::to_string(self : MlensemblegbmMatrix) -> String {
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

pub(all) struct MlensemblegbmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_gbm_make_vector(comps : Array[Double]) -> MlensemblegbmVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_gbm_vector_zero(dim : Int) -> MlensemblegbmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblegbmVector::add(self : MlensemblegbmVector, other : MlensemblegbmVector) -> MlensemblegbmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblegbmVector::sub(self : MlensemblegbmVector, other : MlensemblegbmVector) -> MlensemblegbmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblegbmVector::scale(self : MlensemblegbmVector, s : Double) -> MlensemblegbmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblegbmVector::dot(self : MlensemblegbmVector, other : MlensemblegbmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblegbmVector::norm(self : MlensemblegbmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblegbmVector::normalize(self : MlensemblegbmVector) -> MlensemblegbmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblegbmVector::dist(self : MlensemblegbmVector, other : MlensemblegbmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblegbmVector::to_string(self : MlensemblegbmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_gbm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_gbm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_gbm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_gbm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_gbm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_gbm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_gbm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_gbm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_gbm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_gbm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_gbm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_gbm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_gbm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_gbm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_gbm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_gbm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_gbm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_gbm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_gbm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_gbm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_gbm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_gbm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_gbm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_gbm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_gbm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_gbm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_gbm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_gbm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_gbm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblegbmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_frame_make(size : Int) -> MlensemblegbmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_frame_len(s : MlensemblegbmFrame) -> Int { s.size }

pub fn ml_ensemble_gbm_frame_get(s : MlensemblegbmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_frame_set(s : MlensemblegbmFrame, i : Int, v : Double) -> MlensemblegbmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_frame_sum(s : MlensemblegbmFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_frame_mean(s : MlensemblegbmFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_frame_scale(s : MlensemblegbmFrame, f : Double) -> MlensemblegbmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_frame_add(a : MlensemblegbmFrame, b : MlensemblegbmFrame) -> MlensemblegbmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_frame_copy(s : MlensemblegbmFrame) -> MlensemblegbmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_frame_fill(s : MlensemblegbmFrame, v : Double) -> MlensemblegbmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_frame_min(s : MlensemblegbmFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_frame_max(s : MlensemblegbmFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_frame_to_string(s : MlensemblegbmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_table_make(size : Int) -> MlensemblegbmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_table_len(s : MlensemblegbmTable) -> Int { s.size }

pub fn ml_ensemble_gbm_table_get(s : MlensemblegbmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_table_set(s : MlensemblegbmTable, i : Int, v : Double) -> MlensemblegbmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_table_sum(s : MlensemblegbmTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_table_mean(s : MlensemblegbmTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_table_scale(s : MlensemblegbmTable, f : Double) -> MlensemblegbmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_table_add(a : MlensemblegbmTable, b : MlensemblegbmTable) -> MlensemblegbmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_table_copy(s : MlensemblegbmTable) -> MlensemblegbmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_table_fill(s : MlensemblegbmTable, v : Double) -> MlensemblegbmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_table_min(s : MlensemblegbmTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_table_max(s : MlensemblegbmTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_table_to_string(s : MlensemblegbmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_graphn_make(size : Int) -> MlensemblegbmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_graphn_len(s : MlensemblegbmGraphN) -> Int { s.size }

pub fn ml_ensemble_gbm_graphn_get(s : MlensemblegbmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_graphn_set(s : MlensemblegbmGraphN, i : Int, v : Double) -> MlensemblegbmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_graphn_sum(s : MlensemblegbmGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_graphn_mean(s : MlensemblegbmGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_graphn_scale(s : MlensemblegbmGraphN, f : Double) -> MlensemblegbmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_graphn_add(a : MlensemblegbmGraphN, b : MlensemblegbmGraphN) -> MlensemblegbmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_graphn_copy(s : MlensemblegbmGraphN) -> MlensemblegbmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_graphn_fill(s : MlensemblegbmGraphN, v : Double) -> MlensemblegbmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_graphn_min(s : MlensemblegbmGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_graphn_max(s : MlensemblegbmGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_graphn_to_string(s : MlensemblegbmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_node_make(size : Int) -> MlensemblegbmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_node_len(s : MlensemblegbmNode) -> Int { s.size }

pub fn ml_ensemble_gbm_node_get(s : MlensemblegbmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_node_set(s : MlensemblegbmNode, i : Int, v : Double) -> MlensemblegbmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_node_sum(s : MlensemblegbmNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_node_mean(s : MlensemblegbmNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_node_scale(s : MlensemblegbmNode, f : Double) -> MlensemblegbmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_node_add(a : MlensemblegbmNode, b : MlensemblegbmNode) -> MlensemblegbmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_node_copy(s : MlensemblegbmNode) -> MlensemblegbmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_node_fill(s : MlensemblegbmNode, v : Double) -> MlensemblegbmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_node_min(s : MlensemblegbmNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_node_max(s : MlensemblegbmNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_node_to_string(s : MlensemblegbmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_edge_make(size : Int) -> MlensemblegbmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_edge_len(s : MlensemblegbmEdge) -> Int { s.size }

pub fn ml_ensemble_gbm_edge_get(s : MlensemblegbmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_edge_set(s : MlensemblegbmEdge, i : Int, v : Double) -> MlensemblegbmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_edge_sum(s : MlensemblegbmEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_edge_mean(s : MlensemblegbmEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_edge_scale(s : MlensemblegbmEdge, f : Double) -> MlensemblegbmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_edge_add(a : MlensemblegbmEdge, b : MlensemblegbmEdge) -> MlensemblegbmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_edge_copy(s : MlensemblegbmEdge) -> MlensemblegbmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_edge_fill(s : MlensemblegbmEdge, v : Double) -> MlensemblegbmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_edge_min(s : MlensemblegbmEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_edge_max(s : MlensemblegbmEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_edge_to_string(s : MlensemblegbmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_path_make(size : Int) -> MlensemblegbmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_path_len(s : MlensemblegbmPath) -> Int { s.size }

pub fn ml_ensemble_gbm_path_get(s : MlensemblegbmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_path_set(s : MlensemblegbmPath, i : Int, v : Double) -> MlensemblegbmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_path_sum(s : MlensemblegbmPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_path_mean(s : MlensemblegbmPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_path_scale(s : MlensemblegbmPath, f : Double) -> MlensemblegbmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_path_add(a : MlensemblegbmPath, b : MlensemblegbmPath) -> MlensemblegbmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_path_copy(s : MlensemblegbmPath) -> MlensemblegbmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_path_fill(s : MlensemblegbmPath, v : Double) -> MlensemblegbmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_path_min(s : MlensemblegbmPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_path_max(s : MlensemblegbmPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_path_to_string(s : MlensemblegbmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_cluster_make(size : Int) -> MlensemblegbmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_cluster_len(s : MlensemblegbmCluster) -> Int { s.size }

pub fn ml_ensemble_gbm_cluster_get(s : MlensemblegbmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_cluster_set(s : MlensemblegbmCluster, i : Int, v : Double) -> MlensemblegbmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cluster_sum(s : MlensemblegbmCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_cluster_mean(s : MlensemblegbmCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_cluster_scale(s : MlensemblegbmCluster, f : Double) -> MlensemblegbmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cluster_add(a : MlensemblegbmCluster, b : MlensemblegbmCluster) -> MlensemblegbmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_cluster_copy(s : MlensemblegbmCluster) -> MlensemblegbmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cluster_fill(s : MlensemblegbmCluster, v : Double) -> MlensemblegbmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cluster_min(s : MlensemblegbmCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_cluster_max(s : MlensemblegbmCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_cluster_to_string(s : MlensemblegbmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_model_make(size : Int) -> MlensemblegbmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_model_len(s : MlensemblegbmModel) -> Int { s.size }

pub fn ml_ensemble_gbm_model_get(s : MlensemblegbmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_model_set(s : MlensemblegbmModel, i : Int, v : Double) -> MlensemblegbmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_model_sum(s : MlensemblegbmModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_model_mean(s : MlensemblegbmModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_model_scale(s : MlensemblegbmModel, f : Double) -> MlensemblegbmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_model_add(a : MlensemblegbmModel, b : MlensemblegbmModel) -> MlensemblegbmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_model_copy(s : MlensemblegbmModel) -> MlensemblegbmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_model_fill(s : MlensemblegbmModel, v : Double) -> MlensemblegbmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_model_min(s : MlensemblegbmModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_model_max(s : MlensemblegbmModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_model_to_string(s : MlensemblegbmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_layer_make(size : Int) -> MlensemblegbmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_layer_len(s : MlensemblegbmLayer) -> Int { s.size }

pub fn ml_ensemble_gbm_layer_get(s : MlensemblegbmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_layer_set(s : MlensemblegbmLayer, i : Int, v : Double) -> MlensemblegbmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_layer_sum(s : MlensemblegbmLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_layer_mean(s : MlensemblegbmLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_layer_scale(s : MlensemblegbmLayer, f : Double) -> MlensemblegbmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_layer_add(a : MlensemblegbmLayer, b : MlensemblegbmLayer) -> MlensemblegbmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_layer_copy(s : MlensemblegbmLayer) -> MlensemblegbmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_layer_fill(s : MlensemblegbmLayer, v : Double) -> MlensemblegbmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_layer_min(s : MlensemblegbmLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_layer_max(s : MlensemblegbmLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_layer_to_string(s : MlensemblegbmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_buffer_make(size : Int) -> MlensemblegbmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_buffer_len(s : MlensemblegbmBuffer) -> Int { s.size }

pub fn ml_ensemble_gbm_buffer_get(s : MlensemblegbmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_buffer_set(s : MlensemblegbmBuffer, i : Int, v : Double) -> MlensemblegbmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_buffer_sum(s : MlensemblegbmBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_buffer_mean(s : MlensemblegbmBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_buffer_scale(s : MlensemblegbmBuffer, f : Double) -> MlensemblegbmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_buffer_add(a : MlensemblegbmBuffer, b : MlensemblegbmBuffer) -> MlensemblegbmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_buffer_copy(s : MlensemblegbmBuffer) -> MlensemblegbmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_buffer_fill(s : MlensemblegbmBuffer, v : Double) -> MlensemblegbmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_buffer_min(s : MlensemblegbmBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_buffer_max(s : MlensemblegbmBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_buffer_to_string(s : MlensemblegbmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_cursor_make(size : Int) -> MlensemblegbmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_cursor_len(s : MlensemblegbmCursor) -> Int { s.size }

pub fn ml_ensemble_gbm_cursor_get(s : MlensemblegbmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_cursor_set(s : MlensemblegbmCursor, i : Int, v : Double) -> MlensemblegbmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cursor_sum(s : MlensemblegbmCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_cursor_mean(s : MlensemblegbmCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_cursor_scale(s : MlensemblegbmCursor, f : Double) -> MlensemblegbmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cursor_add(a : MlensemblegbmCursor, b : MlensemblegbmCursor) -> MlensemblegbmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_cursor_copy(s : MlensemblegbmCursor) -> MlensemblegbmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cursor_fill(s : MlensemblegbmCursor, v : Double) -> MlensemblegbmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_cursor_min(s : MlensemblegbmCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_cursor_max(s : MlensemblegbmCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_cursor_to_string(s : MlensemblegbmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_view_make(size : Int) -> MlensemblegbmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_view_len(s : MlensemblegbmView) -> Int { s.size }

pub fn ml_ensemble_gbm_view_get(s : MlensemblegbmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_view_set(s : MlensemblegbmView, i : Int, v : Double) -> MlensemblegbmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_view_sum(s : MlensemblegbmView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_view_mean(s : MlensemblegbmView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_view_scale(s : MlensemblegbmView, f : Double) -> MlensemblegbmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_view_add(a : MlensemblegbmView, b : MlensemblegbmView) -> MlensemblegbmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_view_copy(s : MlensemblegbmView) -> MlensemblegbmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_view_fill(s : MlensemblegbmView, v : Double) -> MlensemblegbmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_view_min(s : MlensemblegbmView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_view_max(s : MlensemblegbmView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_view_to_string(s : MlensemblegbmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_range_make(size : Int) -> MlensemblegbmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_range_len(s : MlensemblegbmRange) -> Int { s.size }

pub fn ml_ensemble_gbm_range_get(s : MlensemblegbmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_range_set(s : MlensemblegbmRange, i : Int, v : Double) -> MlensemblegbmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_range_sum(s : MlensemblegbmRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_range_mean(s : MlensemblegbmRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_range_scale(s : MlensemblegbmRange, f : Double) -> MlensemblegbmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_range_add(a : MlensemblegbmRange, b : MlensemblegbmRange) -> MlensemblegbmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_range_copy(s : MlensemblegbmRange) -> MlensemblegbmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_range_fill(s : MlensemblegbmRange, v : Double) -> MlensemblegbmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_range_min(s : MlensemblegbmRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_range_max(s : MlensemblegbmRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_range_to_string(s : MlensemblegbmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_slice_make(size : Int) -> MlensemblegbmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_gbm_slice_len(s : MlensemblegbmSlice) -> Int { s.size }

pub fn ml_ensemble_gbm_slice_get(s : MlensemblegbmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_gbm_slice_set(s : MlensemblegbmSlice, i : Int, v : Double) -> MlensemblegbmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_slice_sum(s : MlensemblegbmSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_gbm_slice_mean(s : MlensemblegbmSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_gbm_slice_scale(s : MlensemblegbmSlice, f : Double) -> MlensemblegbmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_slice_add(a : MlensemblegbmSlice, b : MlensemblegbmSlice) -> MlensemblegbmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_gbm_slice_copy(s : MlensemblegbmSlice) -> MlensemblegbmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_slice_fill(s : MlensemblegbmSlice, v : Double) -> MlensemblegbmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_gbm_slice_min(s : MlensemblegbmSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_gbm_slice_max(s : MlensemblegbmSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_gbm_slice_to_string(s : MlensemblegbmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

