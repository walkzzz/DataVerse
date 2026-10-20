///===
/// extcore/ml_ensemble_xgboost

pub(all) struct MlensemblexgboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_xgboost_make_point(x : Double, y : Double) -> MlensemblexgboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_xgboost_make_point3(x : Double, y : Double, z : Double) -> MlensemblexgboostPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblexgboostPoint::x(self : MlensemblexgboostPoint) -> Double { self.x }

pub fn MlensemblexgboostPoint::y(self : MlensemblexgboostPoint) -> Double { self.y }

pub fn MlensemblexgboostPoint::z(self : MlensemblexgboostPoint) -> Double { self.z }

pub fn MlensemblexgboostPoint::label(self : MlensemblexgboostPoint) -> Int { self.label }

pub fn MlensemblexgboostPoint::dist(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblexgboostPoint::add(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblexgboostPoint::sub(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblexgboostPoint::scale(self : MlensemblexgboostPoint, s : Double) -> MlensemblexgboostPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblexgboostPoint::dot(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblexgboostPoint::cross(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblexgboostPoint::norm(self : MlensemblexgboostPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblexgboostPoint::normalize(self : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblexgboostPoint::negate(self : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblexgboostPoint::mid(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblexgboostPoint::lerp(self : MlensemblexgboostPoint, other : MlensemblexgboostPoint, t : Double) -> MlensemblexgboostPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblexgboostPoint::to_string(self : MlensemblexgboostPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblexgboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_xgboost_make_series(vals : Array[Double], name : String) -> MlensemblexgboostSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblexgboostSeries::len(self : MlensemblexgboostSeries) -> Int { self.vals.length() }

pub fn MlensemblexgboostSeries::sum(self : MlensemblexgboostSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblexgboostSeries::mean(self : MlensemblexgboostSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblexgboostSeries::min(self : MlensemblexgboostSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblexgboostSeries::max(self : MlensemblexgboostSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblexgboostSeries::range(self : MlensemblexgboostSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblexgboostSeries::variance(self : MlensemblexgboostSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblexgboostSeries::std(self : MlensemblexgboostSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblexgboostSeries::median(self : MlensemblexgboostSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblexgboostSeries::scale(self : MlensemblexgboostSeries, f : Double) -> MlensemblexgboostSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblexgboostSeries::add(self : MlensemblexgboostSeries, other : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblexgboostSeries::sub(self : MlensemblexgboostSeries, other : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblexgboostSeries::normalize(self : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblexgboostSeries::cumsum(self : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblexgboostSeries::to_string(self : MlensemblexgboostSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblexgboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_xgboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblexgboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_xgboost_matrix_identity(n : Int) -> MlensemblexgboostMatrix {
  let m = ml_ensemble_xgboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblexgboostMatrix::get(self : MlensemblexgboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblexgboostMatrix::transpose(self : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  let result = ml_ensemble_xgboost_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblexgboostMatrix::add(self : MlensemblexgboostMatrix, other : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_xgboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblexgboostMatrix::scale(self : MlensemblexgboostMatrix, s : Double) -> MlensemblexgboostMatrix {
  let result = ml_ensemble_xgboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblexgboostMatrix::multiply(self : MlensemblexgboostMatrix, other : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  if self.cols != other.rows { return ml_ensemble_xgboost_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_xgboost_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblexgboostMatrix::trace(self : MlensemblexgboostMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblexgboostMatrix::det(self : MlensemblexgboostMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblexgboostMatrix::norm(self : MlensemblexgboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblexgboostMatrix::to_string(self : MlensemblexgboostMatrix) -> String {
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

pub(all) struct MlensemblexgboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_xgboost_make_vector(comps : Array[Double]) -> MlensemblexgboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_xgboost_vector_zero(dim : Int) -> MlensemblexgboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblexgboostVector::add(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblexgboostVector::sub(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblexgboostVector::scale(self : MlensemblexgboostVector, s : Double) -> MlensemblexgboostVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblexgboostVector::dot(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblexgboostVector::norm(self : MlensemblexgboostVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblexgboostVector::normalize(self : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblexgboostVector::dist(self : MlensemblexgboostVector, other : MlensemblexgboostVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblexgboostVector::to_string(self : MlensemblexgboostVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_xgboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_xgboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_xgboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_xgboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_xgboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_xgboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_xgboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_xgboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_xgboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_xgboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_xgboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_xgboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_xgboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_xgboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_xgboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_xgboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_xgboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_xgboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_xgboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_xgboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_xgboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_xgboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_xgboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_xgboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_xgboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_xgboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_xgboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_xgboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_xgboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblexgboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_frame_make(size : Int) -> MlensemblexgboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_frame_len(s : MlensemblexgboostFrame) -> Int { s.size }

pub fn ml_ensemble_xgboost_frame_get(s : MlensemblexgboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_frame_set(s : MlensemblexgboostFrame, i : Int, v : Double) -> MlensemblexgboostFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_frame_sum(s : MlensemblexgboostFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_frame_mean(s : MlensemblexgboostFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_frame_scale(s : MlensemblexgboostFrame, f : Double) -> MlensemblexgboostFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_frame_add(a : MlensemblexgboostFrame, b : MlensemblexgboostFrame) -> MlensemblexgboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_frame_copy(s : MlensemblexgboostFrame) -> MlensemblexgboostFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_frame_fill(s : MlensemblexgboostFrame, v : Double) -> MlensemblexgboostFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_frame_min(s : MlensemblexgboostFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_frame_max(s : MlensemblexgboostFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_frame_to_string(s : MlensemblexgboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_table_make(size : Int) -> MlensemblexgboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_table_len(s : MlensemblexgboostTable) -> Int { s.size }

pub fn ml_ensemble_xgboost_table_get(s : MlensemblexgboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_table_set(s : MlensemblexgboostTable, i : Int, v : Double) -> MlensemblexgboostTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_table_sum(s : MlensemblexgboostTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_table_mean(s : MlensemblexgboostTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_table_scale(s : MlensemblexgboostTable, f : Double) -> MlensemblexgboostTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_table_add(a : MlensemblexgboostTable, b : MlensemblexgboostTable) -> MlensemblexgboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_table_copy(s : MlensemblexgboostTable) -> MlensemblexgboostTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_table_fill(s : MlensemblexgboostTable, v : Double) -> MlensemblexgboostTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_table_min(s : MlensemblexgboostTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_table_max(s : MlensemblexgboostTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_table_to_string(s : MlensemblexgboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_graphn_make(size : Int) -> MlensemblexgboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_graphn_len(s : MlensemblexgboostGraphN) -> Int { s.size }

pub fn ml_ensemble_xgboost_graphn_get(s : MlensemblexgboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_graphn_set(s : MlensemblexgboostGraphN, i : Int, v : Double) -> MlensemblexgboostGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_graphn_sum(s : MlensemblexgboostGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_graphn_mean(s : MlensemblexgboostGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_graphn_scale(s : MlensemblexgboostGraphN, f : Double) -> MlensemblexgboostGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_graphn_add(a : MlensemblexgboostGraphN, b : MlensemblexgboostGraphN) -> MlensemblexgboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_graphn_copy(s : MlensemblexgboostGraphN) -> MlensemblexgboostGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_graphn_fill(s : MlensemblexgboostGraphN, v : Double) -> MlensemblexgboostGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_graphn_min(s : MlensemblexgboostGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_graphn_max(s : MlensemblexgboostGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_graphn_to_string(s : MlensemblexgboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_node_make(size : Int) -> MlensemblexgboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_node_len(s : MlensemblexgboostNode) -> Int { s.size }

pub fn ml_ensemble_xgboost_node_get(s : MlensemblexgboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_node_set(s : MlensemblexgboostNode, i : Int, v : Double) -> MlensemblexgboostNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_node_sum(s : MlensemblexgboostNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_node_mean(s : MlensemblexgboostNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_node_scale(s : MlensemblexgboostNode, f : Double) -> MlensemblexgboostNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_node_add(a : MlensemblexgboostNode, b : MlensemblexgboostNode) -> MlensemblexgboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_node_copy(s : MlensemblexgboostNode) -> MlensemblexgboostNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_node_fill(s : MlensemblexgboostNode, v : Double) -> MlensemblexgboostNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_node_min(s : MlensemblexgboostNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_node_max(s : MlensemblexgboostNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_node_to_string(s : MlensemblexgboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_edge_make(size : Int) -> MlensemblexgboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_edge_len(s : MlensemblexgboostEdge) -> Int { s.size }

pub fn ml_ensemble_xgboost_edge_get(s : MlensemblexgboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_edge_set(s : MlensemblexgboostEdge, i : Int, v : Double) -> MlensemblexgboostEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_edge_sum(s : MlensemblexgboostEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_edge_mean(s : MlensemblexgboostEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_edge_scale(s : MlensemblexgboostEdge, f : Double) -> MlensemblexgboostEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_edge_add(a : MlensemblexgboostEdge, b : MlensemblexgboostEdge) -> MlensemblexgboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_edge_copy(s : MlensemblexgboostEdge) -> MlensemblexgboostEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_edge_fill(s : MlensemblexgboostEdge, v : Double) -> MlensemblexgboostEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_edge_min(s : MlensemblexgboostEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_edge_max(s : MlensemblexgboostEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_edge_to_string(s : MlensemblexgboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_path_make(size : Int) -> MlensemblexgboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_path_len(s : MlensemblexgboostPath) -> Int { s.size }

pub fn ml_ensemble_xgboost_path_get(s : MlensemblexgboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_path_set(s : MlensemblexgboostPath, i : Int, v : Double) -> MlensemblexgboostPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_path_sum(s : MlensemblexgboostPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_path_mean(s : MlensemblexgboostPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_path_scale(s : MlensemblexgboostPath, f : Double) -> MlensemblexgboostPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_path_add(a : MlensemblexgboostPath, b : MlensemblexgboostPath) -> MlensemblexgboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_path_copy(s : MlensemblexgboostPath) -> MlensemblexgboostPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_path_fill(s : MlensemblexgboostPath, v : Double) -> MlensemblexgboostPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_path_min(s : MlensemblexgboostPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_path_max(s : MlensemblexgboostPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_path_to_string(s : MlensemblexgboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_cluster_make(size : Int) -> MlensemblexgboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_cluster_len(s : MlensemblexgboostCluster) -> Int { s.size }

pub fn ml_ensemble_xgboost_cluster_get(s : MlensemblexgboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_cluster_set(s : MlensemblexgboostCluster, i : Int, v : Double) -> MlensemblexgboostCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cluster_sum(s : MlensemblexgboostCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_cluster_mean(s : MlensemblexgboostCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_cluster_scale(s : MlensemblexgboostCluster, f : Double) -> MlensemblexgboostCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cluster_add(a : MlensemblexgboostCluster, b : MlensemblexgboostCluster) -> MlensemblexgboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_cluster_copy(s : MlensemblexgboostCluster) -> MlensemblexgboostCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cluster_fill(s : MlensemblexgboostCluster, v : Double) -> MlensemblexgboostCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cluster_min(s : MlensemblexgboostCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_cluster_max(s : MlensemblexgboostCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_cluster_to_string(s : MlensemblexgboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_model_make(size : Int) -> MlensemblexgboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_model_len(s : MlensemblexgboostModel) -> Int { s.size }

pub fn ml_ensemble_xgboost_model_get(s : MlensemblexgboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_model_set(s : MlensemblexgboostModel, i : Int, v : Double) -> MlensemblexgboostModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_model_sum(s : MlensemblexgboostModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_model_mean(s : MlensemblexgboostModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_model_scale(s : MlensemblexgboostModel, f : Double) -> MlensemblexgboostModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_model_add(a : MlensemblexgboostModel, b : MlensemblexgboostModel) -> MlensemblexgboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_model_copy(s : MlensemblexgboostModel) -> MlensemblexgboostModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_model_fill(s : MlensemblexgboostModel, v : Double) -> MlensemblexgboostModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_model_min(s : MlensemblexgboostModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_model_max(s : MlensemblexgboostModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_model_to_string(s : MlensemblexgboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_layer_make(size : Int) -> MlensemblexgboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_layer_len(s : MlensemblexgboostLayer) -> Int { s.size }

pub fn ml_ensemble_xgboost_layer_get(s : MlensemblexgboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_layer_set(s : MlensemblexgboostLayer, i : Int, v : Double) -> MlensemblexgboostLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_layer_sum(s : MlensemblexgboostLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_layer_mean(s : MlensemblexgboostLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_layer_scale(s : MlensemblexgboostLayer, f : Double) -> MlensemblexgboostLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_layer_add(a : MlensemblexgboostLayer, b : MlensemblexgboostLayer) -> MlensemblexgboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_layer_copy(s : MlensemblexgboostLayer) -> MlensemblexgboostLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_layer_fill(s : MlensemblexgboostLayer, v : Double) -> MlensemblexgboostLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_layer_min(s : MlensemblexgboostLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_layer_max(s : MlensemblexgboostLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_layer_to_string(s : MlensemblexgboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_buffer_make(size : Int) -> MlensemblexgboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_buffer_len(s : MlensemblexgboostBuffer) -> Int { s.size }

pub fn ml_ensemble_xgboost_buffer_get(s : MlensemblexgboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_buffer_set(s : MlensemblexgboostBuffer, i : Int, v : Double) -> MlensemblexgboostBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_buffer_sum(s : MlensemblexgboostBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_buffer_mean(s : MlensemblexgboostBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_buffer_scale(s : MlensemblexgboostBuffer, f : Double) -> MlensemblexgboostBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_buffer_add(a : MlensemblexgboostBuffer, b : MlensemblexgboostBuffer) -> MlensemblexgboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_buffer_copy(s : MlensemblexgboostBuffer) -> MlensemblexgboostBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_buffer_fill(s : MlensemblexgboostBuffer, v : Double) -> MlensemblexgboostBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_buffer_min(s : MlensemblexgboostBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_buffer_max(s : MlensemblexgboostBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_buffer_to_string(s : MlensemblexgboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_cursor_make(size : Int) -> MlensemblexgboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_cursor_len(s : MlensemblexgboostCursor) -> Int { s.size }

pub fn ml_ensemble_xgboost_cursor_get(s : MlensemblexgboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_cursor_set(s : MlensemblexgboostCursor, i : Int, v : Double) -> MlensemblexgboostCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cursor_sum(s : MlensemblexgboostCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_cursor_mean(s : MlensemblexgboostCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_cursor_scale(s : MlensemblexgboostCursor, f : Double) -> MlensemblexgboostCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cursor_add(a : MlensemblexgboostCursor, b : MlensemblexgboostCursor) -> MlensemblexgboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_cursor_copy(s : MlensemblexgboostCursor) -> MlensemblexgboostCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cursor_fill(s : MlensemblexgboostCursor, v : Double) -> MlensemblexgboostCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_cursor_min(s : MlensemblexgboostCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_cursor_max(s : MlensemblexgboostCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_cursor_to_string(s : MlensemblexgboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_view_make(size : Int) -> MlensemblexgboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_view_len(s : MlensemblexgboostView) -> Int { s.size }

pub fn ml_ensemble_xgboost_view_get(s : MlensemblexgboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_view_set(s : MlensemblexgboostView, i : Int, v : Double) -> MlensemblexgboostView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_view_sum(s : MlensemblexgboostView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_view_mean(s : MlensemblexgboostView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_view_scale(s : MlensemblexgboostView, f : Double) -> MlensemblexgboostView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_view_add(a : MlensemblexgboostView, b : MlensemblexgboostView) -> MlensemblexgboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_view_copy(s : MlensemblexgboostView) -> MlensemblexgboostView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_view_fill(s : MlensemblexgboostView, v : Double) -> MlensemblexgboostView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_view_min(s : MlensemblexgboostView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_view_max(s : MlensemblexgboostView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_view_to_string(s : MlensemblexgboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_range_make(size : Int) -> MlensemblexgboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_range_len(s : MlensemblexgboostRange) -> Int { s.size }

pub fn ml_ensemble_xgboost_range_get(s : MlensemblexgboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_range_set(s : MlensemblexgboostRange, i : Int, v : Double) -> MlensemblexgboostRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_range_sum(s : MlensemblexgboostRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_range_mean(s : MlensemblexgboostRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_range_scale(s : MlensemblexgboostRange, f : Double) -> MlensemblexgboostRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_range_add(a : MlensemblexgboostRange, b : MlensemblexgboostRange) -> MlensemblexgboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_range_copy(s : MlensemblexgboostRange) -> MlensemblexgboostRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_range_fill(s : MlensemblexgboostRange, v : Double) -> MlensemblexgboostRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_range_min(s : MlensemblexgboostRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_range_max(s : MlensemblexgboostRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_range_to_string(s : MlensemblexgboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_slice_make(size : Int) -> MlensemblexgboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_slice_len(s : MlensemblexgboostSlice) -> Int { s.size }

pub fn ml_ensemble_xgboost_slice_get(s : MlensemblexgboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_slice_set(s : MlensemblexgboostSlice, i : Int, v : Double) -> MlensemblexgboostSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_slice_sum(s : MlensemblexgboostSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_xgboost_slice_mean(s : MlensemblexgboostSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_xgboost_slice_scale(s : MlensemblexgboostSlice, f : Double) -> MlensemblexgboostSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_slice_add(a : MlensemblexgboostSlice, b : MlensemblexgboostSlice) -> MlensemblexgboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_xgboost_slice_copy(s : MlensemblexgboostSlice) -> MlensemblexgboostSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_slice_fill(s : MlensemblexgboostSlice, v : Double) -> MlensemblexgboostSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_xgboost_slice_min(s : MlensemblexgboostSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_xgboost_slice_max(s : MlensemblexgboostSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_xgboost_slice_to_string(s : MlensemblexgboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

