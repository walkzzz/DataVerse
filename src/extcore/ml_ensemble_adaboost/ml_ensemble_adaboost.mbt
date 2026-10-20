///===
/// extcore/ml_ensemble_adaboost

pub(all) struct MlensembleadaboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_adaboost_make_point(x : Double, y : Double) -> MlensembleadaboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_adaboost_make_point3(x : Double, y : Double, z : Double) -> MlensembleadaboostPoint {
  { x, y, z, label: 0 }
}

pub fn MlensembleadaboostPoint::x(self : MlensembleadaboostPoint) -> Double { self.x }

pub fn MlensembleadaboostPoint::y(self : MlensembleadaboostPoint) -> Double { self.y }

pub fn MlensembleadaboostPoint::z(self : MlensembleadaboostPoint) -> Double { self.z }

pub fn MlensembleadaboostPoint::label(self : MlensembleadaboostPoint) -> Int { self.label }

pub fn MlensembleadaboostPoint::dist(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensembleadaboostPoint::add(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensembleadaboostPoint::sub(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensembleadaboostPoint::scale(self : MlensembleadaboostPoint, s : Double) -> MlensembleadaboostPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensembleadaboostPoint::dot(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensembleadaboostPoint::cross(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensembleadaboostPoint::norm(self : MlensembleadaboostPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensembleadaboostPoint::normalize(self : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleadaboostPoint::negate(self : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensembleadaboostPoint::mid(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensembleadaboostPoint::lerp(self : MlensembleadaboostPoint, other : MlensembleadaboostPoint, t : Double) -> MlensembleadaboostPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensembleadaboostPoint::to_string(self : MlensembleadaboostPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensembleadaboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_adaboost_make_series(vals : Array[Double], name : String) -> MlensembleadaboostSeries {
  { vals, name, meta: 0 }
}

pub fn MlensembleadaboostSeries::len(self : MlensembleadaboostSeries) -> Int { self.vals.length() }

pub fn MlensembleadaboostSeries::sum(self : MlensembleadaboostSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensembleadaboostSeries::mean(self : MlensembleadaboostSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensembleadaboostSeries::min(self : MlensembleadaboostSeries) -> Double { @_common.min(self.vals) }

pub fn MlensembleadaboostSeries::max(self : MlensembleadaboostSeries) -> Double { @_common.max(self.vals) }

pub fn MlensembleadaboostSeries::range(self : MlensembleadaboostSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensembleadaboostSeries::variance(self : MlensembleadaboostSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensembleadaboostSeries::std(self : MlensembleadaboostSeries) -> Double { @_common.std(self.vals) }

pub fn MlensembleadaboostSeries::median(self : MlensembleadaboostSeries) -> Double { @_common.median(self.vals) }

pub fn MlensembleadaboostSeries::scale(self : MlensembleadaboostSeries, f : Double) -> MlensembleadaboostSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensembleadaboostSeries::add(self : MlensembleadaboostSeries, other : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensembleadaboostSeries::sub(self : MlensembleadaboostSeries, other : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensembleadaboostSeries::normalize(self : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensembleadaboostSeries::cumsum(self : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensembleadaboostSeries::to_string(self : MlensembleadaboostSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleadaboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_adaboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleadaboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_adaboost_matrix_identity(n : Int) -> MlensembleadaboostMatrix {
  let m = ml_ensemble_adaboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensembleadaboostMatrix::get(self : MlensembleadaboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensembleadaboostMatrix::transpose(self : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensembleadaboostMatrix::add(self : MlensembleadaboostMatrix, other : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_adaboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensembleadaboostMatrix::scale(self : MlensembleadaboostMatrix, s : Double) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensembleadaboostMatrix::multiply(self : MlensembleadaboostMatrix, other : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if self.cols != other.rows { return ml_ensemble_adaboost_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_adaboost_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensembleadaboostMatrix::trace(self : MlensembleadaboostMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensembleadaboostMatrix::det(self : MlensembleadaboostMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensembleadaboostMatrix::norm(self : MlensembleadaboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensembleadaboostMatrix::to_string(self : MlensembleadaboostMatrix) -> String {
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

pub(all) struct MlensembleadaboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_adaboost_make_vector(comps : Array[Double]) -> MlensembleadaboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_adaboost_vector_zero(dim : Int) -> MlensembleadaboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensembleadaboostVector::add(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleadaboostVector::sub(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensembleadaboostVector::scale(self : MlensembleadaboostVector, s : Double) -> MlensembleadaboostVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensembleadaboostVector::dot(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensembleadaboostVector::norm(self : MlensembleadaboostVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensembleadaboostVector::normalize(self : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensembleadaboostVector::dist(self : MlensembleadaboostVector, other : MlensembleadaboostVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensembleadaboostVector::to_string(self : MlensembleadaboostVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_adaboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_adaboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_adaboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_adaboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_adaboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_adaboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_adaboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_adaboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_adaboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_adaboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_adaboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_adaboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_adaboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_adaboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_adaboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_adaboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_adaboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_adaboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_adaboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_adaboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_adaboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_adaboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_adaboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_adaboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_adaboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_adaboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_adaboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_adaboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_adaboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensembleadaboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_frame_make(size : Int) -> MlensembleadaboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_frame_len(s : MlensembleadaboostFrame) -> Int { s.size }

pub fn ml_ensemble_adaboost_frame_get(s : MlensembleadaboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_frame_set(s : MlensembleadaboostFrame, i : Int, v : Double) -> MlensembleadaboostFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_sum(s : MlensembleadaboostFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_frame_mean(s : MlensembleadaboostFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_frame_scale(s : MlensembleadaboostFrame, f : Double) -> MlensembleadaboostFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_add(a : MlensembleadaboostFrame, b : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_frame_copy(s : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_fill(s : MlensembleadaboostFrame, v : Double) -> MlensembleadaboostFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_frame_min(s : MlensembleadaboostFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_frame_max(s : MlensembleadaboostFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_frame_to_string(s : MlensembleadaboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_table_make(size : Int) -> MlensembleadaboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_table_len(s : MlensembleadaboostTable) -> Int { s.size }

pub fn ml_ensemble_adaboost_table_get(s : MlensembleadaboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_table_set(s : MlensembleadaboostTable, i : Int, v : Double) -> MlensembleadaboostTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_sum(s : MlensembleadaboostTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_table_mean(s : MlensembleadaboostTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_table_scale(s : MlensembleadaboostTable, f : Double) -> MlensembleadaboostTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_add(a : MlensembleadaboostTable, b : MlensembleadaboostTable) -> MlensembleadaboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_table_copy(s : MlensembleadaboostTable) -> MlensembleadaboostTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_fill(s : MlensembleadaboostTable, v : Double) -> MlensembleadaboostTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_table_min(s : MlensembleadaboostTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_table_max(s : MlensembleadaboostTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_table_to_string(s : MlensembleadaboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_graphn_make(size : Int) -> MlensembleadaboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_graphn_len(s : MlensembleadaboostGraphN) -> Int { s.size }

pub fn ml_ensemble_adaboost_graphn_get(s : MlensembleadaboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_graphn_set(s : MlensembleadaboostGraphN, i : Int, v : Double) -> MlensembleadaboostGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_sum(s : MlensembleadaboostGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_graphn_mean(s : MlensembleadaboostGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_graphn_scale(s : MlensembleadaboostGraphN, f : Double) -> MlensembleadaboostGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_add(a : MlensembleadaboostGraphN, b : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_graphn_copy(s : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_fill(s : MlensembleadaboostGraphN, v : Double) -> MlensembleadaboostGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_graphn_min(s : MlensembleadaboostGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_graphn_max(s : MlensembleadaboostGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_graphn_to_string(s : MlensembleadaboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_node_make(size : Int) -> MlensembleadaboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_node_len(s : MlensembleadaboostNode) -> Int { s.size }

pub fn ml_ensemble_adaboost_node_get(s : MlensembleadaboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_node_set(s : MlensembleadaboostNode, i : Int, v : Double) -> MlensembleadaboostNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_sum(s : MlensembleadaboostNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_node_mean(s : MlensembleadaboostNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_node_scale(s : MlensembleadaboostNode, f : Double) -> MlensembleadaboostNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_add(a : MlensembleadaboostNode, b : MlensembleadaboostNode) -> MlensembleadaboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_node_copy(s : MlensembleadaboostNode) -> MlensembleadaboostNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_fill(s : MlensembleadaboostNode, v : Double) -> MlensembleadaboostNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_node_min(s : MlensembleadaboostNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_node_max(s : MlensembleadaboostNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_node_to_string(s : MlensembleadaboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_edge_make(size : Int) -> MlensembleadaboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_edge_len(s : MlensembleadaboostEdge) -> Int { s.size }

pub fn ml_ensemble_adaboost_edge_get(s : MlensembleadaboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_edge_set(s : MlensembleadaboostEdge, i : Int, v : Double) -> MlensembleadaboostEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_sum(s : MlensembleadaboostEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_edge_mean(s : MlensembleadaboostEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_edge_scale(s : MlensembleadaboostEdge, f : Double) -> MlensembleadaboostEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_add(a : MlensembleadaboostEdge, b : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_edge_copy(s : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_fill(s : MlensembleadaboostEdge, v : Double) -> MlensembleadaboostEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_edge_min(s : MlensembleadaboostEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_edge_max(s : MlensembleadaboostEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_edge_to_string(s : MlensembleadaboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_path_make(size : Int) -> MlensembleadaboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_path_len(s : MlensembleadaboostPath) -> Int { s.size }

pub fn ml_ensemble_adaboost_path_get(s : MlensembleadaboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_path_set(s : MlensembleadaboostPath, i : Int, v : Double) -> MlensembleadaboostPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_sum(s : MlensembleadaboostPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_path_mean(s : MlensembleadaboostPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_path_scale(s : MlensembleadaboostPath, f : Double) -> MlensembleadaboostPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_add(a : MlensembleadaboostPath, b : MlensembleadaboostPath) -> MlensembleadaboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_path_copy(s : MlensembleadaboostPath) -> MlensembleadaboostPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_fill(s : MlensembleadaboostPath, v : Double) -> MlensembleadaboostPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_path_min(s : MlensembleadaboostPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_path_max(s : MlensembleadaboostPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_path_to_string(s : MlensembleadaboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cluster_make(size : Int) -> MlensembleadaboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_cluster_len(s : MlensembleadaboostCluster) -> Int { s.size }

pub fn ml_ensemble_adaboost_cluster_get(s : MlensembleadaboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_cluster_set(s : MlensembleadaboostCluster, i : Int, v : Double) -> MlensembleadaboostCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_sum(s : MlensembleadaboostCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_cluster_mean(s : MlensembleadaboostCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_cluster_scale(s : MlensembleadaboostCluster, f : Double) -> MlensembleadaboostCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_add(a : MlensembleadaboostCluster, b : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_cluster_copy(s : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_fill(s : MlensembleadaboostCluster, v : Double) -> MlensembleadaboostCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cluster_min(s : MlensembleadaboostCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_cluster_max(s : MlensembleadaboostCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_cluster_to_string(s : MlensembleadaboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_model_make(size : Int) -> MlensembleadaboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_model_len(s : MlensembleadaboostModel) -> Int { s.size }

pub fn ml_ensemble_adaboost_model_get(s : MlensembleadaboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_model_set(s : MlensembleadaboostModel, i : Int, v : Double) -> MlensembleadaboostModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_sum(s : MlensembleadaboostModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_model_mean(s : MlensembleadaboostModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_model_scale(s : MlensembleadaboostModel, f : Double) -> MlensembleadaboostModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_add(a : MlensembleadaboostModel, b : MlensembleadaboostModel) -> MlensembleadaboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_model_copy(s : MlensembleadaboostModel) -> MlensembleadaboostModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_fill(s : MlensembleadaboostModel, v : Double) -> MlensembleadaboostModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_model_min(s : MlensembleadaboostModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_model_max(s : MlensembleadaboostModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_model_to_string(s : MlensembleadaboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_layer_make(size : Int) -> MlensembleadaboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_layer_len(s : MlensembleadaboostLayer) -> Int { s.size }

pub fn ml_ensemble_adaboost_layer_get(s : MlensembleadaboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_layer_set(s : MlensembleadaboostLayer, i : Int, v : Double) -> MlensembleadaboostLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_sum(s : MlensembleadaboostLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_layer_mean(s : MlensembleadaboostLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_layer_scale(s : MlensembleadaboostLayer, f : Double) -> MlensembleadaboostLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_add(a : MlensembleadaboostLayer, b : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_layer_copy(s : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_fill(s : MlensembleadaboostLayer, v : Double) -> MlensembleadaboostLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_layer_min(s : MlensembleadaboostLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_layer_max(s : MlensembleadaboostLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_layer_to_string(s : MlensembleadaboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_buffer_make(size : Int) -> MlensembleadaboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_buffer_len(s : MlensembleadaboostBuffer) -> Int { s.size }

pub fn ml_ensemble_adaboost_buffer_get(s : MlensembleadaboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_buffer_set(s : MlensembleadaboostBuffer, i : Int, v : Double) -> MlensembleadaboostBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_sum(s : MlensembleadaboostBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_buffer_mean(s : MlensembleadaboostBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_buffer_scale(s : MlensembleadaboostBuffer, f : Double) -> MlensembleadaboostBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_add(a : MlensembleadaboostBuffer, b : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_buffer_copy(s : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_fill(s : MlensembleadaboostBuffer, v : Double) -> MlensembleadaboostBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_buffer_min(s : MlensembleadaboostBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_buffer_max(s : MlensembleadaboostBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_buffer_to_string(s : MlensembleadaboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cursor_make(size : Int) -> MlensembleadaboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_cursor_len(s : MlensembleadaboostCursor) -> Int { s.size }

pub fn ml_ensemble_adaboost_cursor_get(s : MlensembleadaboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_cursor_set(s : MlensembleadaboostCursor, i : Int, v : Double) -> MlensembleadaboostCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_sum(s : MlensembleadaboostCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_cursor_mean(s : MlensembleadaboostCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_cursor_scale(s : MlensembleadaboostCursor, f : Double) -> MlensembleadaboostCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_add(a : MlensembleadaboostCursor, b : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_cursor_copy(s : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_fill(s : MlensembleadaboostCursor, v : Double) -> MlensembleadaboostCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_cursor_min(s : MlensembleadaboostCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_cursor_max(s : MlensembleadaboostCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_cursor_to_string(s : MlensembleadaboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_view_make(size : Int) -> MlensembleadaboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_view_len(s : MlensembleadaboostView) -> Int { s.size }

pub fn ml_ensemble_adaboost_view_get(s : MlensembleadaboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_view_set(s : MlensembleadaboostView, i : Int, v : Double) -> MlensembleadaboostView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_sum(s : MlensembleadaboostView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_view_mean(s : MlensembleadaboostView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_view_scale(s : MlensembleadaboostView, f : Double) -> MlensembleadaboostView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_add(a : MlensembleadaboostView, b : MlensembleadaboostView) -> MlensembleadaboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_view_copy(s : MlensembleadaboostView) -> MlensembleadaboostView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_fill(s : MlensembleadaboostView, v : Double) -> MlensembleadaboostView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_view_min(s : MlensembleadaboostView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_view_max(s : MlensembleadaboostView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_view_to_string(s : MlensembleadaboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_range_make(size : Int) -> MlensembleadaboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_range_len(s : MlensembleadaboostRange) -> Int { s.size }

pub fn ml_ensemble_adaboost_range_get(s : MlensembleadaboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_range_set(s : MlensembleadaboostRange, i : Int, v : Double) -> MlensembleadaboostRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_sum(s : MlensembleadaboostRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_range_mean(s : MlensembleadaboostRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_range_scale(s : MlensembleadaboostRange, f : Double) -> MlensembleadaboostRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_add(a : MlensembleadaboostRange, b : MlensembleadaboostRange) -> MlensembleadaboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_range_copy(s : MlensembleadaboostRange) -> MlensembleadaboostRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_fill(s : MlensembleadaboostRange, v : Double) -> MlensembleadaboostRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_range_min(s : MlensembleadaboostRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_range_max(s : MlensembleadaboostRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_range_to_string(s : MlensembleadaboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_slice_make(size : Int) -> MlensembleadaboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_slice_len(s : MlensembleadaboostSlice) -> Int { s.size }

pub fn ml_ensemble_adaboost_slice_get(s : MlensembleadaboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_slice_set(s : MlensembleadaboostSlice, i : Int, v : Double) -> MlensembleadaboostSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_sum(s : MlensembleadaboostSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_adaboost_slice_mean(s : MlensembleadaboostSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_adaboost_slice_scale(s : MlensembleadaboostSlice, f : Double) -> MlensembleadaboostSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_add(a : MlensembleadaboostSlice, b : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_adaboost_slice_copy(s : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_fill(s : MlensembleadaboostSlice, v : Double) -> MlensembleadaboostSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_adaboost_slice_min(s : MlensembleadaboostSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_adaboost_slice_max(s : MlensembleadaboostSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_adaboost_slice_to_string(s : MlensembleadaboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

