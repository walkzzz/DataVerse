///===
/// extcore/ml_ensemble_catboost

pub(all) struct MlensemblecatboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_catboost_make_point(x : Double, y : Double) -> MlensemblecatboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_catboost_make_point3(x : Double, y : Double, z : Double) -> MlensemblecatboostPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblecatboostPoint::x(self : MlensemblecatboostPoint) -> Double { self.x }

pub fn MlensemblecatboostPoint::y(self : MlensemblecatboostPoint) -> Double { self.y }

pub fn MlensemblecatboostPoint::z(self : MlensemblecatboostPoint) -> Double { self.z }

pub fn MlensemblecatboostPoint::label(self : MlensemblecatboostPoint) -> Int { self.label }

pub fn MlensemblecatboostPoint::dist(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblecatboostPoint::add(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblecatboostPoint::sub(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblecatboostPoint::scale(self : MlensemblecatboostPoint, s : Double) -> MlensemblecatboostPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblecatboostPoint::dot(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblecatboostPoint::cross(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblecatboostPoint::norm(self : MlensemblecatboostPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblecatboostPoint::normalize(self : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblecatboostPoint::negate(self : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblecatboostPoint::mid(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblecatboostPoint::lerp(self : MlensemblecatboostPoint, other : MlensemblecatboostPoint, t : Double) -> MlensemblecatboostPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblecatboostPoint::to_string(self : MlensemblecatboostPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblecatboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_catboost_make_series(vals : Array[Double], name : String) -> MlensemblecatboostSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblecatboostSeries::len(self : MlensemblecatboostSeries) -> Int { self.vals.length() }

pub fn MlensemblecatboostSeries::sum(self : MlensemblecatboostSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblecatboostSeries::mean(self : MlensemblecatboostSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblecatboostSeries::min(self : MlensemblecatboostSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblecatboostSeries::max(self : MlensemblecatboostSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblecatboostSeries::range(self : MlensemblecatboostSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblecatboostSeries::variance(self : MlensemblecatboostSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblecatboostSeries::std(self : MlensemblecatboostSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblecatboostSeries::median(self : MlensemblecatboostSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblecatboostSeries::scale(self : MlensemblecatboostSeries, f : Double) -> MlensemblecatboostSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblecatboostSeries::add(self : MlensemblecatboostSeries, other : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblecatboostSeries::sub(self : MlensemblecatboostSeries, other : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblecatboostSeries::normalize(self : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblecatboostSeries::cumsum(self : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblecatboostSeries::to_string(self : MlensemblecatboostSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblecatboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_catboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblecatboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_catboost_matrix_identity(n : Int) -> MlensemblecatboostMatrix {
  let m = ml_ensemble_catboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblecatboostMatrix::get(self : MlensemblecatboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblecatboostMatrix::transpose(self : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  let result = ml_ensemble_catboost_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblecatboostMatrix::add(self : MlensemblecatboostMatrix, other : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_catboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblecatboostMatrix::scale(self : MlensemblecatboostMatrix, s : Double) -> MlensemblecatboostMatrix {
  let result = ml_ensemble_catboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblecatboostMatrix::multiply(self : MlensemblecatboostMatrix, other : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  if self.cols != other.rows { return ml_ensemble_catboost_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_catboost_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblecatboostMatrix::trace(self : MlensemblecatboostMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblecatboostMatrix::det(self : MlensemblecatboostMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblecatboostMatrix::norm(self : MlensemblecatboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblecatboostMatrix::to_string(self : MlensemblecatboostMatrix) -> String {
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

pub(all) struct MlensemblecatboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_catboost_make_vector(comps : Array[Double]) -> MlensemblecatboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_catboost_vector_zero(dim : Int) -> MlensemblecatboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblecatboostVector::add(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblecatboostVector::sub(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblecatboostVector::scale(self : MlensemblecatboostVector, s : Double) -> MlensemblecatboostVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblecatboostVector::dot(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblecatboostVector::norm(self : MlensemblecatboostVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblecatboostVector::normalize(self : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblecatboostVector::dist(self : MlensemblecatboostVector, other : MlensemblecatboostVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblecatboostVector::to_string(self : MlensemblecatboostVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_catboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_catboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_catboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_catboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_catboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_catboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_catboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_catboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_catboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_catboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_catboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_catboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_catboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_catboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_catboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_catboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_catboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_catboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_catboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_catboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_catboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_catboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_catboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_catboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_catboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_catboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_catboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_catboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_catboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblecatboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_frame_make(size : Int) -> MlensemblecatboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_frame_len(s : MlensemblecatboostFrame) -> Int { s.size }

pub fn ml_ensemble_catboost_frame_get(s : MlensemblecatboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_frame_set(s : MlensemblecatboostFrame, i : Int, v : Double) -> MlensemblecatboostFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_frame_sum(s : MlensemblecatboostFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_frame_mean(s : MlensemblecatboostFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_frame_scale(s : MlensemblecatboostFrame, f : Double) -> MlensemblecatboostFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_frame_add(a : MlensemblecatboostFrame, b : MlensemblecatboostFrame) -> MlensemblecatboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_frame_copy(s : MlensemblecatboostFrame) -> MlensemblecatboostFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_frame_fill(s : MlensemblecatboostFrame, v : Double) -> MlensemblecatboostFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_frame_min(s : MlensemblecatboostFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_frame_max(s : MlensemblecatboostFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_frame_to_string(s : MlensemblecatboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_table_make(size : Int) -> MlensemblecatboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_table_len(s : MlensemblecatboostTable) -> Int { s.size }

pub fn ml_ensemble_catboost_table_get(s : MlensemblecatboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_table_set(s : MlensemblecatboostTable, i : Int, v : Double) -> MlensemblecatboostTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_table_sum(s : MlensemblecatboostTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_table_mean(s : MlensemblecatboostTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_table_scale(s : MlensemblecatboostTable, f : Double) -> MlensemblecatboostTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_table_add(a : MlensemblecatboostTable, b : MlensemblecatboostTable) -> MlensemblecatboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_table_copy(s : MlensemblecatboostTable) -> MlensemblecatboostTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_table_fill(s : MlensemblecatboostTable, v : Double) -> MlensemblecatboostTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_table_min(s : MlensemblecatboostTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_table_max(s : MlensemblecatboostTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_table_to_string(s : MlensemblecatboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_graphn_make(size : Int) -> MlensemblecatboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_graphn_len(s : MlensemblecatboostGraphN) -> Int { s.size }

pub fn ml_ensemble_catboost_graphn_get(s : MlensemblecatboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_graphn_set(s : MlensemblecatboostGraphN, i : Int, v : Double) -> MlensemblecatboostGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_graphn_sum(s : MlensemblecatboostGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_graphn_mean(s : MlensemblecatboostGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_graphn_scale(s : MlensemblecatboostGraphN, f : Double) -> MlensemblecatboostGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_graphn_add(a : MlensemblecatboostGraphN, b : MlensemblecatboostGraphN) -> MlensemblecatboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_graphn_copy(s : MlensemblecatboostGraphN) -> MlensemblecatboostGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_graphn_fill(s : MlensemblecatboostGraphN, v : Double) -> MlensemblecatboostGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_graphn_min(s : MlensemblecatboostGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_graphn_max(s : MlensemblecatboostGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_graphn_to_string(s : MlensemblecatboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_node_make(size : Int) -> MlensemblecatboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_node_len(s : MlensemblecatboostNode) -> Int { s.size }

pub fn ml_ensemble_catboost_node_get(s : MlensemblecatboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_node_set(s : MlensemblecatboostNode, i : Int, v : Double) -> MlensemblecatboostNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_node_sum(s : MlensemblecatboostNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_node_mean(s : MlensemblecatboostNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_node_scale(s : MlensemblecatboostNode, f : Double) -> MlensemblecatboostNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_node_add(a : MlensemblecatboostNode, b : MlensemblecatboostNode) -> MlensemblecatboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_node_copy(s : MlensemblecatboostNode) -> MlensemblecatboostNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_node_fill(s : MlensemblecatboostNode, v : Double) -> MlensemblecatboostNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_node_min(s : MlensemblecatboostNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_node_max(s : MlensemblecatboostNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_node_to_string(s : MlensemblecatboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_edge_make(size : Int) -> MlensemblecatboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_edge_len(s : MlensemblecatboostEdge) -> Int { s.size }

pub fn ml_ensemble_catboost_edge_get(s : MlensemblecatboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_edge_set(s : MlensemblecatboostEdge, i : Int, v : Double) -> MlensemblecatboostEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_edge_sum(s : MlensemblecatboostEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_edge_mean(s : MlensemblecatboostEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_edge_scale(s : MlensemblecatboostEdge, f : Double) -> MlensemblecatboostEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_edge_add(a : MlensemblecatboostEdge, b : MlensemblecatboostEdge) -> MlensemblecatboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_edge_copy(s : MlensemblecatboostEdge) -> MlensemblecatboostEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_edge_fill(s : MlensemblecatboostEdge, v : Double) -> MlensemblecatboostEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_edge_min(s : MlensemblecatboostEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_edge_max(s : MlensemblecatboostEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_edge_to_string(s : MlensemblecatboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_path_make(size : Int) -> MlensemblecatboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_path_len(s : MlensemblecatboostPath) -> Int { s.size }

pub fn ml_ensemble_catboost_path_get(s : MlensemblecatboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_path_set(s : MlensemblecatboostPath, i : Int, v : Double) -> MlensemblecatboostPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_path_sum(s : MlensemblecatboostPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_path_mean(s : MlensemblecatboostPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_path_scale(s : MlensemblecatboostPath, f : Double) -> MlensemblecatboostPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_path_add(a : MlensemblecatboostPath, b : MlensemblecatboostPath) -> MlensemblecatboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_path_copy(s : MlensemblecatboostPath) -> MlensemblecatboostPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_path_fill(s : MlensemblecatboostPath, v : Double) -> MlensemblecatboostPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_path_min(s : MlensemblecatboostPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_path_max(s : MlensemblecatboostPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_path_to_string(s : MlensemblecatboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_cluster_make(size : Int) -> MlensemblecatboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_cluster_len(s : MlensemblecatboostCluster) -> Int { s.size }

pub fn ml_ensemble_catboost_cluster_get(s : MlensemblecatboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_cluster_set(s : MlensemblecatboostCluster, i : Int, v : Double) -> MlensemblecatboostCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cluster_sum(s : MlensemblecatboostCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_cluster_mean(s : MlensemblecatboostCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_cluster_scale(s : MlensemblecatboostCluster, f : Double) -> MlensemblecatboostCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cluster_add(a : MlensemblecatboostCluster, b : MlensemblecatboostCluster) -> MlensemblecatboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_cluster_copy(s : MlensemblecatboostCluster) -> MlensemblecatboostCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cluster_fill(s : MlensemblecatboostCluster, v : Double) -> MlensemblecatboostCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cluster_min(s : MlensemblecatboostCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_cluster_max(s : MlensemblecatboostCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_cluster_to_string(s : MlensemblecatboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_model_make(size : Int) -> MlensemblecatboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_model_len(s : MlensemblecatboostModel) -> Int { s.size }

pub fn ml_ensemble_catboost_model_get(s : MlensemblecatboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_model_set(s : MlensemblecatboostModel, i : Int, v : Double) -> MlensemblecatboostModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_model_sum(s : MlensemblecatboostModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_model_mean(s : MlensemblecatboostModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_model_scale(s : MlensemblecatboostModel, f : Double) -> MlensemblecatboostModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_model_add(a : MlensemblecatboostModel, b : MlensemblecatboostModel) -> MlensemblecatboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_model_copy(s : MlensemblecatboostModel) -> MlensemblecatboostModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_model_fill(s : MlensemblecatboostModel, v : Double) -> MlensemblecatboostModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_model_min(s : MlensemblecatboostModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_model_max(s : MlensemblecatboostModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_model_to_string(s : MlensemblecatboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_layer_make(size : Int) -> MlensemblecatboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_layer_len(s : MlensemblecatboostLayer) -> Int { s.size }

pub fn ml_ensemble_catboost_layer_get(s : MlensemblecatboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_layer_set(s : MlensemblecatboostLayer, i : Int, v : Double) -> MlensemblecatboostLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_layer_sum(s : MlensemblecatboostLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_layer_mean(s : MlensemblecatboostLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_layer_scale(s : MlensemblecatboostLayer, f : Double) -> MlensemblecatboostLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_layer_add(a : MlensemblecatboostLayer, b : MlensemblecatboostLayer) -> MlensemblecatboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_layer_copy(s : MlensemblecatboostLayer) -> MlensemblecatboostLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_layer_fill(s : MlensemblecatboostLayer, v : Double) -> MlensemblecatboostLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_layer_min(s : MlensemblecatboostLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_layer_max(s : MlensemblecatboostLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_layer_to_string(s : MlensemblecatboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_buffer_make(size : Int) -> MlensemblecatboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_buffer_len(s : MlensemblecatboostBuffer) -> Int { s.size }

pub fn ml_ensemble_catboost_buffer_get(s : MlensemblecatboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_buffer_set(s : MlensemblecatboostBuffer, i : Int, v : Double) -> MlensemblecatboostBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_buffer_sum(s : MlensemblecatboostBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_buffer_mean(s : MlensemblecatboostBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_buffer_scale(s : MlensemblecatboostBuffer, f : Double) -> MlensemblecatboostBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_buffer_add(a : MlensemblecatboostBuffer, b : MlensemblecatboostBuffer) -> MlensemblecatboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_buffer_copy(s : MlensemblecatboostBuffer) -> MlensemblecatboostBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_buffer_fill(s : MlensemblecatboostBuffer, v : Double) -> MlensemblecatboostBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_buffer_min(s : MlensemblecatboostBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_buffer_max(s : MlensemblecatboostBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_buffer_to_string(s : MlensemblecatboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_cursor_make(size : Int) -> MlensemblecatboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_cursor_len(s : MlensemblecatboostCursor) -> Int { s.size }

pub fn ml_ensemble_catboost_cursor_get(s : MlensemblecatboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_cursor_set(s : MlensemblecatboostCursor, i : Int, v : Double) -> MlensemblecatboostCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cursor_sum(s : MlensemblecatboostCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_cursor_mean(s : MlensemblecatboostCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_cursor_scale(s : MlensemblecatboostCursor, f : Double) -> MlensemblecatboostCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cursor_add(a : MlensemblecatboostCursor, b : MlensemblecatboostCursor) -> MlensemblecatboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_cursor_copy(s : MlensemblecatboostCursor) -> MlensemblecatboostCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cursor_fill(s : MlensemblecatboostCursor, v : Double) -> MlensemblecatboostCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_cursor_min(s : MlensemblecatboostCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_cursor_max(s : MlensemblecatboostCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_cursor_to_string(s : MlensemblecatboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_view_make(size : Int) -> MlensemblecatboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_view_len(s : MlensemblecatboostView) -> Int { s.size }

pub fn ml_ensemble_catboost_view_get(s : MlensemblecatboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_view_set(s : MlensemblecatboostView, i : Int, v : Double) -> MlensemblecatboostView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_view_sum(s : MlensemblecatboostView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_view_mean(s : MlensemblecatboostView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_view_scale(s : MlensemblecatboostView, f : Double) -> MlensemblecatboostView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_view_add(a : MlensemblecatboostView, b : MlensemblecatboostView) -> MlensemblecatboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_view_copy(s : MlensemblecatboostView) -> MlensemblecatboostView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_view_fill(s : MlensemblecatboostView, v : Double) -> MlensemblecatboostView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_view_min(s : MlensemblecatboostView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_view_max(s : MlensemblecatboostView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_view_to_string(s : MlensemblecatboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_range_make(size : Int) -> MlensemblecatboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_range_len(s : MlensemblecatboostRange) -> Int { s.size }

pub fn ml_ensemble_catboost_range_get(s : MlensemblecatboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_range_set(s : MlensemblecatboostRange, i : Int, v : Double) -> MlensemblecatboostRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_range_sum(s : MlensemblecatboostRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_range_mean(s : MlensemblecatboostRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_range_scale(s : MlensemblecatboostRange, f : Double) -> MlensemblecatboostRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_range_add(a : MlensemblecatboostRange, b : MlensemblecatboostRange) -> MlensemblecatboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_range_copy(s : MlensemblecatboostRange) -> MlensemblecatboostRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_range_fill(s : MlensemblecatboostRange, v : Double) -> MlensemblecatboostRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_range_min(s : MlensemblecatboostRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_range_max(s : MlensemblecatboostRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_range_to_string(s : MlensemblecatboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_slice_make(size : Int) -> MlensemblecatboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_slice_len(s : MlensemblecatboostSlice) -> Int { s.size }

pub fn ml_ensemble_catboost_slice_get(s : MlensemblecatboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_slice_set(s : MlensemblecatboostSlice, i : Int, v : Double) -> MlensemblecatboostSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_slice_sum(s : MlensemblecatboostSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_catboost_slice_mean(s : MlensemblecatboostSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_catboost_slice_scale(s : MlensemblecatboostSlice, f : Double) -> MlensemblecatboostSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_slice_add(a : MlensemblecatboostSlice, b : MlensemblecatboostSlice) -> MlensemblecatboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_catboost_slice_copy(s : MlensemblecatboostSlice) -> MlensemblecatboostSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_slice_fill(s : MlensemblecatboostSlice, v : Double) -> MlensemblecatboostSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_catboost_slice_min(s : MlensemblecatboostSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_catboost_slice_max(s : MlensemblecatboostSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_catboost_slice_to_string(s : MlensemblecatboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

