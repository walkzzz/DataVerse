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

pub fn MlensemblegbmFrame::len(self : MlensemblegbmFrame) -> Int { self.size }

pub fn MlensemblegbmFrame::get(self : MlensemblegbmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmFrame::set(self : MlensemblegbmFrame, i : Int, v : Double) -> MlensemblegbmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmFrame::sum(self : MlensemblegbmFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmFrame::mean(self : MlensemblegbmFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmFrame::scale(self : MlensemblegbmFrame, f : Double) -> MlensemblegbmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmFrame::add(self : MlensemblegbmFrame, other : MlensemblegbmFrame) -> MlensemblegbmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmFrame::copy(self : MlensemblegbmFrame) -> MlensemblegbmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmFrame::fill(self : MlensemblegbmFrame, v : Double) -> MlensemblegbmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmFrame::min(self : MlensemblegbmFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmFrame::max(self : MlensemblegbmFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmFrame::to_string(self : MlensemblegbmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_table_make(size : Int) -> MlensemblegbmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmTable::len(self : MlensemblegbmTable) -> Int { self.size }

pub fn MlensemblegbmTable::get(self : MlensemblegbmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmTable::set(self : MlensemblegbmTable, i : Int, v : Double) -> MlensemblegbmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmTable::sum(self : MlensemblegbmTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmTable::mean(self : MlensemblegbmTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmTable::scale(self : MlensemblegbmTable, f : Double) -> MlensemblegbmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmTable::add(self : MlensemblegbmTable, other : MlensemblegbmTable) -> MlensemblegbmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmTable::copy(self : MlensemblegbmTable) -> MlensemblegbmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmTable::fill(self : MlensemblegbmTable, v : Double) -> MlensemblegbmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmTable::min(self : MlensemblegbmTable) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmTable::max(self : MlensemblegbmTable) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmTable::to_string(self : MlensemblegbmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_graphn_make(size : Int) -> MlensemblegbmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmGraphN::len(self : MlensemblegbmGraphN) -> Int { self.size }

pub fn MlensemblegbmGraphN::get(self : MlensemblegbmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmGraphN::set(self : MlensemblegbmGraphN, i : Int, v : Double) -> MlensemblegbmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmGraphN::sum(self : MlensemblegbmGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmGraphN::mean(self : MlensemblegbmGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmGraphN::scale(self : MlensemblegbmGraphN, f : Double) -> MlensemblegbmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmGraphN::add(self : MlensemblegbmGraphN, other : MlensemblegbmGraphN) -> MlensemblegbmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmGraphN::copy(self : MlensemblegbmGraphN) -> MlensemblegbmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmGraphN::fill(self : MlensemblegbmGraphN, v : Double) -> MlensemblegbmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmGraphN::min(self : MlensemblegbmGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmGraphN::max(self : MlensemblegbmGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmGraphN::to_string(self : MlensemblegbmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_node_make(size : Int) -> MlensemblegbmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmNode::len(self : MlensemblegbmNode) -> Int { self.size }

pub fn MlensemblegbmNode::get(self : MlensemblegbmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmNode::set(self : MlensemblegbmNode, i : Int, v : Double) -> MlensemblegbmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmNode::sum(self : MlensemblegbmNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmNode::mean(self : MlensemblegbmNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmNode::scale(self : MlensemblegbmNode, f : Double) -> MlensemblegbmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmNode::add(self : MlensemblegbmNode, other : MlensemblegbmNode) -> MlensemblegbmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmNode::copy(self : MlensemblegbmNode) -> MlensemblegbmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmNode::fill(self : MlensemblegbmNode, v : Double) -> MlensemblegbmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmNode::min(self : MlensemblegbmNode) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmNode::max(self : MlensemblegbmNode) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmNode::to_string(self : MlensemblegbmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_edge_make(size : Int) -> MlensemblegbmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmEdge::len(self : MlensemblegbmEdge) -> Int { self.size }

pub fn MlensemblegbmEdge::get(self : MlensemblegbmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmEdge::set(self : MlensemblegbmEdge, i : Int, v : Double) -> MlensemblegbmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmEdge::sum(self : MlensemblegbmEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmEdge::mean(self : MlensemblegbmEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmEdge::scale(self : MlensemblegbmEdge, f : Double) -> MlensemblegbmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmEdge::add(self : MlensemblegbmEdge, other : MlensemblegbmEdge) -> MlensemblegbmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmEdge::copy(self : MlensemblegbmEdge) -> MlensemblegbmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmEdge::fill(self : MlensemblegbmEdge, v : Double) -> MlensemblegbmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmEdge::min(self : MlensemblegbmEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmEdge::max(self : MlensemblegbmEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmEdge::to_string(self : MlensemblegbmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_path_make(size : Int) -> MlensemblegbmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmPath::len(self : MlensemblegbmPath) -> Int { self.size }

pub fn MlensemblegbmPath::get(self : MlensemblegbmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmPath::set(self : MlensemblegbmPath, i : Int, v : Double) -> MlensemblegbmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmPath::sum(self : MlensemblegbmPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmPath::mean(self : MlensemblegbmPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmPath::scale(self : MlensemblegbmPath, f : Double) -> MlensemblegbmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmPath::add(self : MlensemblegbmPath, other : MlensemblegbmPath) -> MlensemblegbmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmPath::copy(self : MlensemblegbmPath) -> MlensemblegbmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmPath::fill(self : MlensemblegbmPath, v : Double) -> MlensemblegbmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmPath::min(self : MlensemblegbmPath) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmPath::max(self : MlensemblegbmPath) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmPath::to_string(self : MlensemblegbmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_cluster_make(size : Int) -> MlensemblegbmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmCluster::len(self : MlensemblegbmCluster) -> Int { self.size }

pub fn MlensemblegbmCluster::get(self : MlensemblegbmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmCluster::set(self : MlensemblegbmCluster, i : Int, v : Double) -> MlensemblegbmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCluster::sum(self : MlensemblegbmCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmCluster::mean(self : MlensemblegbmCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmCluster::scale(self : MlensemblegbmCluster, f : Double) -> MlensemblegbmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCluster::add(self : MlensemblegbmCluster, other : MlensemblegbmCluster) -> MlensemblegbmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmCluster::copy(self : MlensemblegbmCluster) -> MlensemblegbmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCluster::fill(self : MlensemblegbmCluster, v : Double) -> MlensemblegbmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCluster::min(self : MlensemblegbmCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmCluster::max(self : MlensemblegbmCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmCluster::to_string(self : MlensemblegbmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_model_make(size : Int) -> MlensemblegbmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmModel::len(self : MlensemblegbmModel) -> Int { self.size }

pub fn MlensemblegbmModel::get(self : MlensemblegbmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmModel::set(self : MlensemblegbmModel, i : Int, v : Double) -> MlensemblegbmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmModel::sum(self : MlensemblegbmModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmModel::mean(self : MlensemblegbmModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmModel::scale(self : MlensemblegbmModel, f : Double) -> MlensemblegbmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmModel::add(self : MlensemblegbmModel, other : MlensemblegbmModel) -> MlensemblegbmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmModel::copy(self : MlensemblegbmModel) -> MlensemblegbmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmModel::fill(self : MlensemblegbmModel, v : Double) -> MlensemblegbmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmModel::min(self : MlensemblegbmModel) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmModel::max(self : MlensemblegbmModel) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmModel::to_string(self : MlensemblegbmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_layer_make(size : Int) -> MlensemblegbmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmLayer::len(self : MlensemblegbmLayer) -> Int { self.size }

pub fn MlensemblegbmLayer::get(self : MlensemblegbmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmLayer::set(self : MlensemblegbmLayer, i : Int, v : Double) -> MlensemblegbmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmLayer::sum(self : MlensemblegbmLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmLayer::mean(self : MlensemblegbmLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmLayer::scale(self : MlensemblegbmLayer, f : Double) -> MlensemblegbmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmLayer::add(self : MlensemblegbmLayer, other : MlensemblegbmLayer) -> MlensemblegbmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmLayer::copy(self : MlensemblegbmLayer) -> MlensemblegbmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmLayer::fill(self : MlensemblegbmLayer, v : Double) -> MlensemblegbmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmLayer::min(self : MlensemblegbmLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmLayer::max(self : MlensemblegbmLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmLayer::to_string(self : MlensemblegbmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_buffer_make(size : Int) -> MlensemblegbmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmBuffer::len(self : MlensemblegbmBuffer) -> Int { self.size }

pub fn MlensemblegbmBuffer::get(self : MlensemblegbmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmBuffer::set(self : MlensemblegbmBuffer, i : Int, v : Double) -> MlensemblegbmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmBuffer::sum(self : MlensemblegbmBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmBuffer::mean(self : MlensemblegbmBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmBuffer::scale(self : MlensemblegbmBuffer, f : Double) -> MlensemblegbmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmBuffer::add(self : MlensemblegbmBuffer, other : MlensemblegbmBuffer) -> MlensemblegbmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmBuffer::copy(self : MlensemblegbmBuffer) -> MlensemblegbmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmBuffer::fill(self : MlensemblegbmBuffer, v : Double) -> MlensemblegbmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmBuffer::min(self : MlensemblegbmBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmBuffer::max(self : MlensemblegbmBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmBuffer::to_string(self : MlensemblegbmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_cursor_make(size : Int) -> MlensemblegbmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmCursor::len(self : MlensemblegbmCursor) -> Int { self.size }

pub fn MlensemblegbmCursor::get(self : MlensemblegbmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmCursor::set(self : MlensemblegbmCursor, i : Int, v : Double) -> MlensemblegbmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCursor::sum(self : MlensemblegbmCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmCursor::mean(self : MlensemblegbmCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmCursor::scale(self : MlensemblegbmCursor, f : Double) -> MlensemblegbmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCursor::add(self : MlensemblegbmCursor, other : MlensemblegbmCursor) -> MlensemblegbmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmCursor::copy(self : MlensemblegbmCursor) -> MlensemblegbmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCursor::fill(self : MlensemblegbmCursor, v : Double) -> MlensemblegbmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmCursor::min(self : MlensemblegbmCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmCursor::max(self : MlensemblegbmCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmCursor::to_string(self : MlensemblegbmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_view_make(size : Int) -> MlensemblegbmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmView::len(self : MlensemblegbmView) -> Int { self.size }

pub fn MlensemblegbmView::get(self : MlensemblegbmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmView::set(self : MlensemblegbmView, i : Int, v : Double) -> MlensemblegbmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmView::sum(self : MlensemblegbmView) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmView::mean(self : MlensemblegbmView) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmView::scale(self : MlensemblegbmView, f : Double) -> MlensemblegbmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmView::add(self : MlensemblegbmView, other : MlensemblegbmView) -> MlensemblegbmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmView::copy(self : MlensemblegbmView) -> MlensemblegbmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmView::fill(self : MlensemblegbmView, v : Double) -> MlensemblegbmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmView::min(self : MlensemblegbmView) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmView::max(self : MlensemblegbmView) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmView::to_string(self : MlensemblegbmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_range_make(size : Int) -> MlensemblegbmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmRange::len(self : MlensemblegbmRange) -> Int { self.size }

pub fn MlensemblegbmRange::get(self : MlensemblegbmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmRange::set(self : MlensemblegbmRange, i : Int, v : Double) -> MlensemblegbmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmRange::sum(self : MlensemblegbmRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmRange::mean(self : MlensemblegbmRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmRange::scale(self : MlensemblegbmRange, f : Double) -> MlensemblegbmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmRange::add(self : MlensemblegbmRange, other : MlensemblegbmRange) -> MlensemblegbmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmRange::copy(self : MlensemblegbmRange) -> MlensemblegbmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmRange::fill(self : MlensemblegbmRange, v : Double) -> MlensemblegbmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmRange::min(self : MlensemblegbmRange) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmRange::max(self : MlensemblegbmRange) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmRange::to_string(self : MlensemblegbmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblegbmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_gbm_slice_make(size : Int) -> MlensemblegbmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblegbmSlice::len(self : MlensemblegbmSlice) -> Int { self.size }

pub fn MlensemblegbmSlice::get(self : MlensemblegbmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblegbmSlice::set(self : MlensemblegbmSlice, i : Int, v : Double) -> MlensemblegbmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblegbmSlice::sum(self : MlensemblegbmSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblegbmSlice::mean(self : MlensemblegbmSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblegbmSlice::scale(self : MlensemblegbmSlice, f : Double) -> MlensemblegbmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmSlice::add(self : MlensemblegbmSlice, other : MlensemblegbmSlice) -> MlensemblegbmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblegbmSlice::copy(self : MlensemblegbmSlice) -> MlensemblegbmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmSlice::fill(self : MlensemblegbmSlice, v : Double) -> MlensemblegbmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblegbmSlice::min(self : MlensemblegbmSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblegbmSlice::max(self : MlensemblegbmSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblegbmSlice::to_string(self : MlensemblegbmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

