///===
/// extcore/ml_ensemble_lightgbm

pub(all) struct MlensemblelightgbmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_lightgbm_make_point(x : Double, y : Double) -> MlensemblelightgbmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_lightgbm_make_point3(x : Double, y : Double, z : Double) -> MlensemblelightgbmPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblelightgbmPoint::x(self : MlensemblelightgbmPoint) -> Double { self.x }

pub fn MlensemblelightgbmPoint::y(self : MlensemblelightgbmPoint) -> Double { self.y }

pub fn MlensemblelightgbmPoint::z(self : MlensemblelightgbmPoint) -> Double { self.z }

pub fn MlensemblelightgbmPoint::label(self : MlensemblelightgbmPoint) -> Int { self.label }

pub fn MlensemblelightgbmPoint::dist(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblelightgbmPoint::add(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblelightgbmPoint::sub(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblelightgbmPoint::scale(self : MlensemblelightgbmPoint, s : Double) -> MlensemblelightgbmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblelightgbmPoint::dot(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblelightgbmPoint::cross(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblelightgbmPoint::norm(self : MlensemblelightgbmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblelightgbmPoint::normalize(self : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblelightgbmPoint::negate(self : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblelightgbmPoint::mid(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblelightgbmPoint::lerp(self : MlensemblelightgbmPoint, other : MlensemblelightgbmPoint, t : Double) -> MlensemblelightgbmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblelightgbmPoint::to_string(self : MlensemblelightgbmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblelightgbmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_lightgbm_make_series(vals : Array[Double], name : String) -> MlensemblelightgbmSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblelightgbmSeries::len(self : MlensemblelightgbmSeries) -> Int { self.vals.length() }

pub fn MlensemblelightgbmSeries::sum(self : MlensemblelightgbmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblelightgbmSeries::mean(self : MlensemblelightgbmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblelightgbmSeries::min(self : MlensemblelightgbmSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblelightgbmSeries::max(self : MlensemblelightgbmSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblelightgbmSeries::range(self : MlensemblelightgbmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblelightgbmSeries::variance(self : MlensemblelightgbmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblelightgbmSeries::std(self : MlensemblelightgbmSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblelightgbmSeries::median(self : MlensemblelightgbmSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblelightgbmSeries::scale(self : MlensemblelightgbmSeries, f : Double) -> MlensemblelightgbmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblelightgbmSeries::add(self : MlensemblelightgbmSeries, other : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblelightgbmSeries::sub(self : MlensemblelightgbmSeries, other : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblelightgbmSeries::normalize(self : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblelightgbmSeries::cumsum(self : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblelightgbmSeries::to_string(self : MlensemblelightgbmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblelightgbmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_lightgbm_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblelightgbmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_lightgbm_matrix_identity(n : Int) -> MlensemblelightgbmMatrix {
  let m = ml_ensemble_lightgbm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblelightgbmMatrix::get(self : MlensemblelightgbmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblelightgbmMatrix::transpose(self : MlensemblelightgbmMatrix) -> MlensemblelightgbmMatrix {
  let result = ml_ensemble_lightgbm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblelightgbmMatrix::add(self : MlensemblelightgbmMatrix, other : MlensemblelightgbmMatrix) -> MlensemblelightgbmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_lightgbm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblelightgbmMatrix::scale(self : MlensemblelightgbmMatrix, s : Double) -> MlensemblelightgbmMatrix {
  let result = ml_ensemble_lightgbm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblelightgbmMatrix::multiply(self : MlensemblelightgbmMatrix, other : MlensemblelightgbmMatrix) -> MlensemblelightgbmMatrix {
  if self.cols != other.rows { return ml_ensemble_lightgbm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_lightgbm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblelightgbmMatrix::trace(self : MlensemblelightgbmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblelightgbmMatrix::det(self : MlensemblelightgbmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblelightgbmMatrix::norm(self : MlensemblelightgbmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblelightgbmMatrix::to_string(self : MlensemblelightgbmMatrix) -> String {
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

pub(all) struct MlensemblelightgbmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_lightgbm_make_vector(comps : Array[Double]) -> MlensemblelightgbmVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_lightgbm_vector_zero(dim : Int) -> MlensemblelightgbmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblelightgbmVector::add(self : MlensemblelightgbmVector, other : MlensemblelightgbmVector) -> MlensemblelightgbmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblelightgbmVector::sub(self : MlensemblelightgbmVector, other : MlensemblelightgbmVector) -> MlensemblelightgbmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblelightgbmVector::scale(self : MlensemblelightgbmVector, s : Double) -> MlensemblelightgbmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblelightgbmVector::dot(self : MlensemblelightgbmVector, other : MlensemblelightgbmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblelightgbmVector::norm(self : MlensemblelightgbmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblelightgbmVector::normalize(self : MlensemblelightgbmVector) -> MlensemblelightgbmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblelightgbmVector::dist(self : MlensemblelightgbmVector, other : MlensemblelightgbmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblelightgbmVector::to_string(self : MlensemblelightgbmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_lightgbm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_lightgbm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_lightgbm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_lightgbm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_lightgbm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_lightgbm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_lightgbm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_lightgbm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_lightgbm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_lightgbm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_lightgbm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_lightgbm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_lightgbm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_lightgbm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_lightgbm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_lightgbm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_lightgbm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_lightgbm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_lightgbm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_lightgbm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_lightgbm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_lightgbm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_lightgbm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_lightgbm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_lightgbm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_lightgbm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_lightgbm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_lightgbm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_lightgbm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblelightgbmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_frame_make(size : Int) -> MlensemblelightgbmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmFrame::len(self : MlensemblelightgbmFrame) -> Int { self.size }

pub fn MlensemblelightgbmFrame::get(self : MlensemblelightgbmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmFrame::set(self : MlensemblelightgbmFrame, i : Int, v : Double) -> MlensemblelightgbmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmFrame::sum(self : MlensemblelightgbmFrame) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmFrame::mean(self : MlensemblelightgbmFrame) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmFrame::scale(self : MlensemblelightgbmFrame, f : Double) -> MlensemblelightgbmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmFrame::add(self : MlensemblelightgbmFrame, other : MlensemblelightgbmFrame) -> MlensemblelightgbmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmFrame::copy(self : MlensemblelightgbmFrame) -> MlensemblelightgbmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmFrame::fill(self : MlensemblelightgbmFrame, v : Double) -> MlensemblelightgbmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmFrame::min(self : MlensemblelightgbmFrame) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmFrame::max(self : MlensemblelightgbmFrame) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmFrame::to_string(self : MlensemblelightgbmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_table_make(size : Int) -> MlensemblelightgbmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmTable::len(self : MlensemblelightgbmTable) -> Int { self.size }

pub fn MlensemblelightgbmTable::get(self : MlensemblelightgbmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmTable::set(self : MlensemblelightgbmTable, i : Int, v : Double) -> MlensemblelightgbmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmTable::sum(self : MlensemblelightgbmTable) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmTable::mean(self : MlensemblelightgbmTable) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmTable::scale(self : MlensemblelightgbmTable, f : Double) -> MlensemblelightgbmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmTable::add(self : MlensemblelightgbmTable, other : MlensemblelightgbmTable) -> MlensemblelightgbmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmTable::copy(self : MlensemblelightgbmTable) -> MlensemblelightgbmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmTable::fill(self : MlensemblelightgbmTable, v : Double) -> MlensemblelightgbmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmTable::min(self : MlensemblelightgbmTable) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmTable::max(self : MlensemblelightgbmTable) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmTable::to_string(self : MlensemblelightgbmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_graphn_make(size : Int) -> MlensemblelightgbmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmGraphN::len(self : MlensemblelightgbmGraphN) -> Int { self.size }

pub fn MlensemblelightgbmGraphN::get(self : MlensemblelightgbmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmGraphN::set(self : MlensemblelightgbmGraphN, i : Int, v : Double) -> MlensemblelightgbmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmGraphN::sum(self : MlensemblelightgbmGraphN) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmGraphN::mean(self : MlensemblelightgbmGraphN) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmGraphN::scale(self : MlensemblelightgbmGraphN, f : Double) -> MlensemblelightgbmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmGraphN::add(self : MlensemblelightgbmGraphN, other : MlensemblelightgbmGraphN) -> MlensemblelightgbmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmGraphN::copy(self : MlensemblelightgbmGraphN) -> MlensemblelightgbmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmGraphN::fill(self : MlensemblelightgbmGraphN, v : Double) -> MlensemblelightgbmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmGraphN::min(self : MlensemblelightgbmGraphN) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmGraphN::max(self : MlensemblelightgbmGraphN) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmGraphN::to_string(self : MlensemblelightgbmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_node_make(size : Int) -> MlensemblelightgbmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmNode::len(self : MlensemblelightgbmNode) -> Int { self.size }

pub fn MlensemblelightgbmNode::get(self : MlensemblelightgbmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmNode::set(self : MlensemblelightgbmNode, i : Int, v : Double) -> MlensemblelightgbmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmNode::sum(self : MlensemblelightgbmNode) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmNode::mean(self : MlensemblelightgbmNode) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmNode::scale(self : MlensemblelightgbmNode, f : Double) -> MlensemblelightgbmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmNode::add(self : MlensemblelightgbmNode, other : MlensemblelightgbmNode) -> MlensemblelightgbmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmNode::copy(self : MlensemblelightgbmNode) -> MlensemblelightgbmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmNode::fill(self : MlensemblelightgbmNode, v : Double) -> MlensemblelightgbmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmNode::min(self : MlensemblelightgbmNode) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmNode::max(self : MlensemblelightgbmNode) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmNode::to_string(self : MlensemblelightgbmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_edge_make(size : Int) -> MlensemblelightgbmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmEdge::len(self : MlensemblelightgbmEdge) -> Int { self.size }

pub fn MlensemblelightgbmEdge::get(self : MlensemblelightgbmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmEdge::set(self : MlensemblelightgbmEdge, i : Int, v : Double) -> MlensemblelightgbmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmEdge::sum(self : MlensemblelightgbmEdge) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmEdge::mean(self : MlensemblelightgbmEdge) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmEdge::scale(self : MlensemblelightgbmEdge, f : Double) -> MlensemblelightgbmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmEdge::add(self : MlensemblelightgbmEdge, other : MlensemblelightgbmEdge) -> MlensemblelightgbmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmEdge::copy(self : MlensemblelightgbmEdge) -> MlensemblelightgbmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmEdge::fill(self : MlensemblelightgbmEdge, v : Double) -> MlensemblelightgbmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmEdge::min(self : MlensemblelightgbmEdge) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmEdge::max(self : MlensemblelightgbmEdge) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmEdge::to_string(self : MlensemblelightgbmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_path_make(size : Int) -> MlensemblelightgbmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmPath::len(self : MlensemblelightgbmPath) -> Int { self.size }

pub fn MlensemblelightgbmPath::get(self : MlensemblelightgbmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmPath::set(self : MlensemblelightgbmPath, i : Int, v : Double) -> MlensemblelightgbmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmPath::sum(self : MlensemblelightgbmPath) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmPath::mean(self : MlensemblelightgbmPath) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmPath::scale(self : MlensemblelightgbmPath, f : Double) -> MlensemblelightgbmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmPath::add(self : MlensemblelightgbmPath, other : MlensemblelightgbmPath) -> MlensemblelightgbmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmPath::copy(self : MlensemblelightgbmPath) -> MlensemblelightgbmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmPath::fill(self : MlensemblelightgbmPath, v : Double) -> MlensemblelightgbmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmPath::min(self : MlensemblelightgbmPath) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmPath::max(self : MlensemblelightgbmPath) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmPath::to_string(self : MlensemblelightgbmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_cluster_make(size : Int) -> MlensemblelightgbmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmCluster::len(self : MlensemblelightgbmCluster) -> Int { self.size }

pub fn MlensemblelightgbmCluster::get(self : MlensemblelightgbmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmCluster::set(self : MlensemblelightgbmCluster, i : Int, v : Double) -> MlensemblelightgbmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCluster::sum(self : MlensemblelightgbmCluster) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmCluster::mean(self : MlensemblelightgbmCluster) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmCluster::scale(self : MlensemblelightgbmCluster, f : Double) -> MlensemblelightgbmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCluster::add(self : MlensemblelightgbmCluster, other : MlensemblelightgbmCluster) -> MlensemblelightgbmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmCluster::copy(self : MlensemblelightgbmCluster) -> MlensemblelightgbmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCluster::fill(self : MlensemblelightgbmCluster, v : Double) -> MlensemblelightgbmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCluster::min(self : MlensemblelightgbmCluster) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmCluster::max(self : MlensemblelightgbmCluster) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmCluster::to_string(self : MlensemblelightgbmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_model_make(size : Int) -> MlensemblelightgbmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmModel::len(self : MlensemblelightgbmModel) -> Int { self.size }

pub fn MlensemblelightgbmModel::get(self : MlensemblelightgbmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmModel::set(self : MlensemblelightgbmModel, i : Int, v : Double) -> MlensemblelightgbmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmModel::sum(self : MlensemblelightgbmModel) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmModel::mean(self : MlensemblelightgbmModel) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmModel::scale(self : MlensemblelightgbmModel, f : Double) -> MlensemblelightgbmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmModel::add(self : MlensemblelightgbmModel, other : MlensemblelightgbmModel) -> MlensemblelightgbmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmModel::copy(self : MlensemblelightgbmModel) -> MlensemblelightgbmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmModel::fill(self : MlensemblelightgbmModel, v : Double) -> MlensemblelightgbmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmModel::min(self : MlensemblelightgbmModel) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmModel::max(self : MlensemblelightgbmModel) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmModel::to_string(self : MlensemblelightgbmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_layer_make(size : Int) -> MlensemblelightgbmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmLayer::len(self : MlensemblelightgbmLayer) -> Int { self.size }

pub fn MlensemblelightgbmLayer::get(self : MlensemblelightgbmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmLayer::set(self : MlensemblelightgbmLayer, i : Int, v : Double) -> MlensemblelightgbmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmLayer::sum(self : MlensemblelightgbmLayer) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmLayer::mean(self : MlensemblelightgbmLayer) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmLayer::scale(self : MlensemblelightgbmLayer, f : Double) -> MlensemblelightgbmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmLayer::add(self : MlensemblelightgbmLayer, other : MlensemblelightgbmLayer) -> MlensemblelightgbmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmLayer::copy(self : MlensemblelightgbmLayer) -> MlensemblelightgbmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmLayer::fill(self : MlensemblelightgbmLayer, v : Double) -> MlensemblelightgbmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmLayer::min(self : MlensemblelightgbmLayer) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmLayer::max(self : MlensemblelightgbmLayer) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmLayer::to_string(self : MlensemblelightgbmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_buffer_make(size : Int) -> MlensemblelightgbmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmBuffer::len(self : MlensemblelightgbmBuffer) -> Int { self.size }

pub fn MlensemblelightgbmBuffer::get(self : MlensemblelightgbmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmBuffer::set(self : MlensemblelightgbmBuffer, i : Int, v : Double) -> MlensemblelightgbmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmBuffer::sum(self : MlensemblelightgbmBuffer) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmBuffer::mean(self : MlensemblelightgbmBuffer) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmBuffer::scale(self : MlensemblelightgbmBuffer, f : Double) -> MlensemblelightgbmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmBuffer::add(self : MlensemblelightgbmBuffer, other : MlensemblelightgbmBuffer) -> MlensemblelightgbmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmBuffer::copy(self : MlensemblelightgbmBuffer) -> MlensemblelightgbmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmBuffer::fill(self : MlensemblelightgbmBuffer, v : Double) -> MlensemblelightgbmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmBuffer::min(self : MlensemblelightgbmBuffer) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmBuffer::max(self : MlensemblelightgbmBuffer) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmBuffer::to_string(self : MlensemblelightgbmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_cursor_make(size : Int) -> MlensemblelightgbmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmCursor::len(self : MlensemblelightgbmCursor) -> Int { self.size }

pub fn MlensemblelightgbmCursor::get(self : MlensemblelightgbmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmCursor::set(self : MlensemblelightgbmCursor, i : Int, v : Double) -> MlensemblelightgbmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCursor::sum(self : MlensemblelightgbmCursor) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmCursor::mean(self : MlensemblelightgbmCursor) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmCursor::scale(self : MlensemblelightgbmCursor, f : Double) -> MlensemblelightgbmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCursor::add(self : MlensemblelightgbmCursor, other : MlensemblelightgbmCursor) -> MlensemblelightgbmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmCursor::copy(self : MlensemblelightgbmCursor) -> MlensemblelightgbmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCursor::fill(self : MlensemblelightgbmCursor, v : Double) -> MlensemblelightgbmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmCursor::min(self : MlensemblelightgbmCursor) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmCursor::max(self : MlensemblelightgbmCursor) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmCursor::to_string(self : MlensemblelightgbmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_view_make(size : Int) -> MlensemblelightgbmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmView::len(self : MlensemblelightgbmView) -> Int { self.size }

pub fn MlensemblelightgbmView::get(self : MlensemblelightgbmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmView::set(self : MlensemblelightgbmView, i : Int, v : Double) -> MlensemblelightgbmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmView::sum(self : MlensemblelightgbmView) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmView::mean(self : MlensemblelightgbmView) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmView::scale(self : MlensemblelightgbmView, f : Double) -> MlensemblelightgbmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmView::add(self : MlensemblelightgbmView, other : MlensemblelightgbmView) -> MlensemblelightgbmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmView::copy(self : MlensemblelightgbmView) -> MlensemblelightgbmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmView::fill(self : MlensemblelightgbmView, v : Double) -> MlensemblelightgbmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmView::min(self : MlensemblelightgbmView) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmView::max(self : MlensemblelightgbmView) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmView::to_string(self : MlensemblelightgbmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_range_make(size : Int) -> MlensemblelightgbmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmRange::len(self : MlensemblelightgbmRange) -> Int { self.size }

pub fn MlensemblelightgbmRange::get(self : MlensemblelightgbmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmRange::set(self : MlensemblelightgbmRange, i : Int, v : Double) -> MlensemblelightgbmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmRange::sum(self : MlensemblelightgbmRange) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmRange::mean(self : MlensemblelightgbmRange) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmRange::scale(self : MlensemblelightgbmRange, f : Double) -> MlensemblelightgbmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmRange::add(self : MlensemblelightgbmRange, other : MlensemblelightgbmRange) -> MlensemblelightgbmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmRange::copy(self : MlensemblelightgbmRange) -> MlensemblelightgbmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmRange::fill(self : MlensemblelightgbmRange, v : Double) -> MlensemblelightgbmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmRange::min(self : MlensemblelightgbmRange) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmRange::max(self : MlensemblelightgbmRange) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmRange::to_string(self : MlensemblelightgbmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_slice_make(size : Int) -> MlensemblelightgbmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlensemblelightgbmSlice::len(self : MlensemblelightgbmSlice) -> Int { self.size }

pub fn MlensemblelightgbmSlice::get(self : MlensemblelightgbmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlensemblelightgbmSlice::set(self : MlensemblelightgbmSlice, i : Int, v : Double) -> MlensemblelightgbmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmSlice::sum(self : MlensemblelightgbmSlice) -> Double { @_common.sum(self.data) }

pub fn MlensemblelightgbmSlice::mean(self : MlensemblelightgbmSlice) -> Double { @_common.mean(self.data) }

pub fn MlensemblelightgbmSlice::scale(self : MlensemblelightgbmSlice, f : Double) -> MlensemblelightgbmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmSlice::add(self : MlensemblelightgbmSlice, other : MlensemblelightgbmSlice) -> MlensemblelightgbmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlensemblelightgbmSlice::copy(self : MlensemblelightgbmSlice) -> MlensemblelightgbmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmSlice::fill(self : MlensemblelightgbmSlice, v : Double) -> MlensemblelightgbmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlensemblelightgbmSlice::min(self : MlensemblelightgbmSlice) -> Double { @_common.min(self.data) }

pub fn MlensemblelightgbmSlice::max(self : MlensemblelightgbmSlice) -> Double { @_common.max(self.data) }

pub fn MlensemblelightgbmSlice::to_string(self : MlensemblelightgbmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

