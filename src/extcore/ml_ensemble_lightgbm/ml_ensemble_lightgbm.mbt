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

pub fn ml_ensemble_lightgbm_frame_len(s : MlensemblelightgbmFrame) -> Int { s.size }

pub fn ml_ensemble_lightgbm_frame_get(s : MlensemblelightgbmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_frame_set(s : MlensemblelightgbmFrame, i : Int, v : Double) -> MlensemblelightgbmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_frame_sum(s : MlensemblelightgbmFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_frame_mean(s : MlensemblelightgbmFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_frame_scale(s : MlensemblelightgbmFrame, f : Double) -> MlensemblelightgbmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_frame_add(a : MlensemblelightgbmFrame, b : MlensemblelightgbmFrame) -> MlensemblelightgbmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_frame_copy(s : MlensemblelightgbmFrame) -> MlensemblelightgbmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_frame_fill(s : MlensemblelightgbmFrame, v : Double) -> MlensemblelightgbmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_frame_min(s : MlensemblelightgbmFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_frame_max(s : MlensemblelightgbmFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_frame_to_string(s : MlensemblelightgbmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_table_make(size : Int) -> MlensemblelightgbmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_table_len(s : MlensemblelightgbmTable) -> Int { s.size }

pub fn ml_ensemble_lightgbm_table_get(s : MlensemblelightgbmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_table_set(s : MlensemblelightgbmTable, i : Int, v : Double) -> MlensemblelightgbmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_table_sum(s : MlensemblelightgbmTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_table_mean(s : MlensemblelightgbmTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_table_scale(s : MlensemblelightgbmTable, f : Double) -> MlensemblelightgbmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_table_add(a : MlensemblelightgbmTable, b : MlensemblelightgbmTable) -> MlensemblelightgbmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_table_copy(s : MlensemblelightgbmTable) -> MlensemblelightgbmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_table_fill(s : MlensemblelightgbmTable, v : Double) -> MlensemblelightgbmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_table_min(s : MlensemblelightgbmTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_table_max(s : MlensemblelightgbmTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_table_to_string(s : MlensemblelightgbmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_graphn_make(size : Int) -> MlensemblelightgbmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_graphn_len(s : MlensemblelightgbmGraphN) -> Int { s.size }

pub fn ml_ensemble_lightgbm_graphn_get(s : MlensemblelightgbmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_graphn_set(s : MlensemblelightgbmGraphN, i : Int, v : Double) -> MlensemblelightgbmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_graphn_sum(s : MlensemblelightgbmGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_graphn_mean(s : MlensemblelightgbmGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_graphn_scale(s : MlensemblelightgbmGraphN, f : Double) -> MlensemblelightgbmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_graphn_add(a : MlensemblelightgbmGraphN, b : MlensemblelightgbmGraphN) -> MlensemblelightgbmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_graphn_copy(s : MlensemblelightgbmGraphN) -> MlensemblelightgbmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_graphn_fill(s : MlensemblelightgbmGraphN, v : Double) -> MlensemblelightgbmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_graphn_min(s : MlensemblelightgbmGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_graphn_max(s : MlensemblelightgbmGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_graphn_to_string(s : MlensemblelightgbmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_node_make(size : Int) -> MlensemblelightgbmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_node_len(s : MlensemblelightgbmNode) -> Int { s.size }

pub fn ml_ensemble_lightgbm_node_get(s : MlensemblelightgbmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_node_set(s : MlensemblelightgbmNode, i : Int, v : Double) -> MlensemblelightgbmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_node_sum(s : MlensemblelightgbmNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_node_mean(s : MlensemblelightgbmNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_node_scale(s : MlensemblelightgbmNode, f : Double) -> MlensemblelightgbmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_node_add(a : MlensemblelightgbmNode, b : MlensemblelightgbmNode) -> MlensemblelightgbmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_node_copy(s : MlensemblelightgbmNode) -> MlensemblelightgbmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_node_fill(s : MlensemblelightgbmNode, v : Double) -> MlensemblelightgbmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_node_min(s : MlensemblelightgbmNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_node_max(s : MlensemblelightgbmNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_node_to_string(s : MlensemblelightgbmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_edge_make(size : Int) -> MlensemblelightgbmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_edge_len(s : MlensemblelightgbmEdge) -> Int { s.size }

pub fn ml_ensemble_lightgbm_edge_get(s : MlensemblelightgbmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_edge_set(s : MlensemblelightgbmEdge, i : Int, v : Double) -> MlensemblelightgbmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_edge_sum(s : MlensemblelightgbmEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_edge_mean(s : MlensemblelightgbmEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_edge_scale(s : MlensemblelightgbmEdge, f : Double) -> MlensemblelightgbmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_edge_add(a : MlensemblelightgbmEdge, b : MlensemblelightgbmEdge) -> MlensemblelightgbmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_edge_copy(s : MlensemblelightgbmEdge) -> MlensemblelightgbmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_edge_fill(s : MlensemblelightgbmEdge, v : Double) -> MlensemblelightgbmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_edge_min(s : MlensemblelightgbmEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_edge_max(s : MlensemblelightgbmEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_edge_to_string(s : MlensemblelightgbmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_path_make(size : Int) -> MlensemblelightgbmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_path_len(s : MlensemblelightgbmPath) -> Int { s.size }

pub fn ml_ensemble_lightgbm_path_get(s : MlensemblelightgbmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_path_set(s : MlensemblelightgbmPath, i : Int, v : Double) -> MlensemblelightgbmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_path_sum(s : MlensemblelightgbmPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_path_mean(s : MlensemblelightgbmPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_path_scale(s : MlensemblelightgbmPath, f : Double) -> MlensemblelightgbmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_path_add(a : MlensemblelightgbmPath, b : MlensemblelightgbmPath) -> MlensemblelightgbmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_path_copy(s : MlensemblelightgbmPath) -> MlensemblelightgbmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_path_fill(s : MlensemblelightgbmPath, v : Double) -> MlensemblelightgbmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_path_min(s : MlensemblelightgbmPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_path_max(s : MlensemblelightgbmPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_path_to_string(s : MlensemblelightgbmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_cluster_make(size : Int) -> MlensemblelightgbmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_cluster_len(s : MlensemblelightgbmCluster) -> Int { s.size }

pub fn ml_ensemble_lightgbm_cluster_get(s : MlensemblelightgbmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_cluster_set(s : MlensemblelightgbmCluster, i : Int, v : Double) -> MlensemblelightgbmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cluster_sum(s : MlensemblelightgbmCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_cluster_mean(s : MlensemblelightgbmCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_cluster_scale(s : MlensemblelightgbmCluster, f : Double) -> MlensemblelightgbmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cluster_add(a : MlensemblelightgbmCluster, b : MlensemblelightgbmCluster) -> MlensemblelightgbmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_cluster_copy(s : MlensemblelightgbmCluster) -> MlensemblelightgbmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cluster_fill(s : MlensemblelightgbmCluster, v : Double) -> MlensemblelightgbmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cluster_min(s : MlensemblelightgbmCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_cluster_max(s : MlensemblelightgbmCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_cluster_to_string(s : MlensemblelightgbmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_model_make(size : Int) -> MlensemblelightgbmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_model_len(s : MlensemblelightgbmModel) -> Int { s.size }

pub fn ml_ensemble_lightgbm_model_get(s : MlensemblelightgbmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_model_set(s : MlensemblelightgbmModel, i : Int, v : Double) -> MlensemblelightgbmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_model_sum(s : MlensemblelightgbmModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_model_mean(s : MlensemblelightgbmModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_model_scale(s : MlensemblelightgbmModel, f : Double) -> MlensemblelightgbmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_model_add(a : MlensemblelightgbmModel, b : MlensemblelightgbmModel) -> MlensemblelightgbmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_model_copy(s : MlensemblelightgbmModel) -> MlensemblelightgbmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_model_fill(s : MlensemblelightgbmModel, v : Double) -> MlensemblelightgbmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_model_min(s : MlensemblelightgbmModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_model_max(s : MlensemblelightgbmModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_model_to_string(s : MlensemblelightgbmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_layer_make(size : Int) -> MlensemblelightgbmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_layer_len(s : MlensemblelightgbmLayer) -> Int { s.size }

pub fn ml_ensemble_lightgbm_layer_get(s : MlensemblelightgbmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_layer_set(s : MlensemblelightgbmLayer, i : Int, v : Double) -> MlensemblelightgbmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_layer_sum(s : MlensemblelightgbmLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_layer_mean(s : MlensemblelightgbmLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_layer_scale(s : MlensemblelightgbmLayer, f : Double) -> MlensemblelightgbmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_layer_add(a : MlensemblelightgbmLayer, b : MlensemblelightgbmLayer) -> MlensemblelightgbmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_layer_copy(s : MlensemblelightgbmLayer) -> MlensemblelightgbmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_layer_fill(s : MlensemblelightgbmLayer, v : Double) -> MlensemblelightgbmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_layer_min(s : MlensemblelightgbmLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_layer_max(s : MlensemblelightgbmLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_layer_to_string(s : MlensemblelightgbmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_buffer_make(size : Int) -> MlensemblelightgbmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_buffer_len(s : MlensemblelightgbmBuffer) -> Int { s.size }

pub fn ml_ensemble_lightgbm_buffer_get(s : MlensemblelightgbmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_buffer_set(s : MlensemblelightgbmBuffer, i : Int, v : Double) -> MlensemblelightgbmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_buffer_sum(s : MlensemblelightgbmBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_buffer_mean(s : MlensemblelightgbmBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_buffer_scale(s : MlensemblelightgbmBuffer, f : Double) -> MlensemblelightgbmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_buffer_add(a : MlensemblelightgbmBuffer, b : MlensemblelightgbmBuffer) -> MlensemblelightgbmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_buffer_copy(s : MlensemblelightgbmBuffer) -> MlensemblelightgbmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_buffer_fill(s : MlensemblelightgbmBuffer, v : Double) -> MlensemblelightgbmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_buffer_min(s : MlensemblelightgbmBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_buffer_max(s : MlensemblelightgbmBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_buffer_to_string(s : MlensemblelightgbmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_cursor_make(size : Int) -> MlensemblelightgbmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_cursor_len(s : MlensemblelightgbmCursor) -> Int { s.size }

pub fn ml_ensemble_lightgbm_cursor_get(s : MlensemblelightgbmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_cursor_set(s : MlensemblelightgbmCursor, i : Int, v : Double) -> MlensemblelightgbmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cursor_sum(s : MlensemblelightgbmCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_cursor_mean(s : MlensemblelightgbmCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_cursor_scale(s : MlensemblelightgbmCursor, f : Double) -> MlensemblelightgbmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cursor_add(a : MlensemblelightgbmCursor, b : MlensemblelightgbmCursor) -> MlensemblelightgbmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_cursor_copy(s : MlensemblelightgbmCursor) -> MlensemblelightgbmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cursor_fill(s : MlensemblelightgbmCursor, v : Double) -> MlensemblelightgbmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_cursor_min(s : MlensemblelightgbmCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_cursor_max(s : MlensemblelightgbmCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_cursor_to_string(s : MlensemblelightgbmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_view_make(size : Int) -> MlensemblelightgbmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_view_len(s : MlensemblelightgbmView) -> Int { s.size }

pub fn ml_ensemble_lightgbm_view_get(s : MlensemblelightgbmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_view_set(s : MlensemblelightgbmView, i : Int, v : Double) -> MlensemblelightgbmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_view_sum(s : MlensemblelightgbmView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_view_mean(s : MlensemblelightgbmView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_view_scale(s : MlensemblelightgbmView, f : Double) -> MlensemblelightgbmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_view_add(a : MlensemblelightgbmView, b : MlensemblelightgbmView) -> MlensemblelightgbmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_view_copy(s : MlensemblelightgbmView) -> MlensemblelightgbmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_view_fill(s : MlensemblelightgbmView, v : Double) -> MlensemblelightgbmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_view_min(s : MlensemblelightgbmView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_view_max(s : MlensemblelightgbmView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_view_to_string(s : MlensemblelightgbmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_range_make(size : Int) -> MlensemblelightgbmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_range_len(s : MlensemblelightgbmRange) -> Int { s.size }

pub fn ml_ensemble_lightgbm_range_get(s : MlensemblelightgbmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_range_set(s : MlensemblelightgbmRange, i : Int, v : Double) -> MlensemblelightgbmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_range_sum(s : MlensemblelightgbmRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_range_mean(s : MlensemblelightgbmRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_range_scale(s : MlensemblelightgbmRange, f : Double) -> MlensemblelightgbmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_range_add(a : MlensemblelightgbmRange, b : MlensemblelightgbmRange) -> MlensemblelightgbmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_range_copy(s : MlensemblelightgbmRange) -> MlensemblelightgbmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_range_fill(s : MlensemblelightgbmRange, v : Double) -> MlensemblelightgbmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_range_min(s : MlensemblelightgbmRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_range_max(s : MlensemblelightgbmRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_range_to_string(s : MlensemblelightgbmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_slice_make(size : Int) -> MlensemblelightgbmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_slice_len(s : MlensemblelightgbmSlice) -> Int { s.size }

pub fn ml_ensemble_lightgbm_slice_get(s : MlensemblelightgbmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_slice_set(s : MlensemblelightgbmSlice, i : Int, v : Double) -> MlensemblelightgbmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_slice_sum(s : MlensemblelightgbmSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_lightgbm_slice_mean(s : MlensemblelightgbmSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_lightgbm_slice_scale(s : MlensemblelightgbmSlice, f : Double) -> MlensemblelightgbmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_slice_add(a : MlensemblelightgbmSlice, b : MlensemblelightgbmSlice) -> MlensemblelightgbmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_lightgbm_slice_copy(s : MlensemblelightgbmSlice) -> MlensemblelightgbmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_slice_fill(s : MlensemblelightgbmSlice, v : Double) -> MlensemblelightgbmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_lightgbm_slice_min(s : MlensemblelightgbmSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_lightgbm_slice_max(s : MlensemblelightgbmSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_lightgbm_slice_to_string(s : MlensemblelightgbmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

