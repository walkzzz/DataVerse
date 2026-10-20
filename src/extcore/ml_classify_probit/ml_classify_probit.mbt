///===
/// extcore/ml_classify_probit

pub(all) struct MlclassifyprobitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_probit_make_point(x : Double, y : Double) -> MlclassifyprobitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_probit_make_point3(x : Double, y : Double, z : Double) -> MlclassifyprobitPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyprobitPoint::x(self : MlclassifyprobitPoint) -> Double { self.x }

pub fn MlclassifyprobitPoint::y(self : MlclassifyprobitPoint) -> Double { self.y }

pub fn MlclassifyprobitPoint::z(self : MlclassifyprobitPoint) -> Double { self.z }

pub fn MlclassifyprobitPoint::label(self : MlclassifyprobitPoint) -> Int { self.label }

pub fn MlclassifyprobitPoint::dist(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyprobitPoint::add(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyprobitPoint::sub(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyprobitPoint::scale(self : MlclassifyprobitPoint, s : Double) -> MlclassifyprobitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyprobitPoint::dot(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyprobitPoint::cross(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyprobitPoint::norm(self : MlclassifyprobitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyprobitPoint::normalize(self : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyprobitPoint::negate(self : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyprobitPoint::mid(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyprobitPoint::lerp(self : MlclassifyprobitPoint, other : MlclassifyprobitPoint, t : Double) -> MlclassifyprobitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyprobitPoint::to_string(self : MlclassifyprobitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyprobitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_probit_make_series(vals : Array[Double], name : String) -> MlclassifyprobitSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyprobitSeries::len(self : MlclassifyprobitSeries) -> Int { self.vals.length() }

pub fn MlclassifyprobitSeries::sum(self : MlclassifyprobitSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyprobitSeries::mean(self : MlclassifyprobitSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyprobitSeries::min(self : MlclassifyprobitSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyprobitSeries::max(self : MlclassifyprobitSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyprobitSeries::range(self : MlclassifyprobitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyprobitSeries::variance(self : MlclassifyprobitSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyprobitSeries::std(self : MlclassifyprobitSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyprobitSeries::median(self : MlclassifyprobitSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyprobitSeries::scale(self : MlclassifyprobitSeries, f : Double) -> MlclassifyprobitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyprobitSeries::add(self : MlclassifyprobitSeries, other : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyprobitSeries::sub(self : MlclassifyprobitSeries, other : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyprobitSeries::normalize(self : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyprobitSeries::cumsum(self : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyprobitSeries::to_string(self : MlclassifyprobitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyprobitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_probit_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyprobitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_probit_matrix_identity(n : Int) -> MlclassifyprobitMatrix {
  let m = ml_classify_probit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyprobitMatrix::get(self : MlclassifyprobitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyprobitMatrix::transpose(self : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  let result = ml_classify_probit_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyprobitMatrix::add(self : MlclassifyprobitMatrix, other : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_probit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyprobitMatrix::scale(self : MlclassifyprobitMatrix, s : Double) -> MlclassifyprobitMatrix {
  let result = ml_classify_probit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyprobitMatrix::multiply(self : MlclassifyprobitMatrix, other : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  if self.cols != other.rows { return ml_classify_probit_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_probit_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyprobitMatrix::trace(self : MlclassifyprobitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyprobitMatrix::det(self : MlclassifyprobitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyprobitMatrix::norm(self : MlclassifyprobitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyprobitMatrix::to_string(self : MlclassifyprobitMatrix) -> String {
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

pub(all) struct MlclassifyprobitVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_probit_make_vector(comps : Array[Double]) -> MlclassifyprobitVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_probit_vector_zero(dim : Int) -> MlclassifyprobitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyprobitVector::add(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyprobitVector::sub(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyprobitVector::scale(self : MlclassifyprobitVector, s : Double) -> MlclassifyprobitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyprobitVector::dot(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyprobitVector::norm(self : MlclassifyprobitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyprobitVector::normalize(self : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyprobitVector::dist(self : MlclassifyprobitVector, other : MlclassifyprobitVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyprobitVector::to_string(self : MlclassifyprobitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_probit_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_probit_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_probit_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_probit_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_probit_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_probit_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_probit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_probit_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_probit_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_probit_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_probit_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_probit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_probit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_probit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_probit_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_probit_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_probit_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_probit_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_probit_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_probit_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_probit_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_probit_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_probit_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_probit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_probit_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_probit_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_probit_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_probit_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_probit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyprobitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_frame_make(size : Int) -> MlclassifyprobitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_frame_len(s : MlclassifyprobitFrame) -> Int { s.size }

pub fn ml_classify_probit_frame_get(s : MlclassifyprobitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_frame_set(s : MlclassifyprobitFrame, i : Int, v : Double) -> MlclassifyprobitFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_frame_sum(s : MlclassifyprobitFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_frame_mean(s : MlclassifyprobitFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_frame_scale(s : MlclassifyprobitFrame, f : Double) -> MlclassifyprobitFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_frame_add(a : MlclassifyprobitFrame, b : MlclassifyprobitFrame) -> MlclassifyprobitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_frame_copy(s : MlclassifyprobitFrame) -> MlclassifyprobitFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_frame_fill(s : MlclassifyprobitFrame, v : Double) -> MlclassifyprobitFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_frame_min(s : MlclassifyprobitFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_frame_max(s : MlclassifyprobitFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_frame_to_string(s : MlclassifyprobitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_table_make(size : Int) -> MlclassifyprobitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_table_len(s : MlclassifyprobitTable) -> Int { s.size }

pub fn ml_classify_probit_table_get(s : MlclassifyprobitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_table_set(s : MlclassifyprobitTable, i : Int, v : Double) -> MlclassifyprobitTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_table_sum(s : MlclassifyprobitTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_table_mean(s : MlclassifyprobitTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_table_scale(s : MlclassifyprobitTable, f : Double) -> MlclassifyprobitTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_table_add(a : MlclassifyprobitTable, b : MlclassifyprobitTable) -> MlclassifyprobitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_table_copy(s : MlclassifyprobitTable) -> MlclassifyprobitTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_table_fill(s : MlclassifyprobitTable, v : Double) -> MlclassifyprobitTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_table_min(s : MlclassifyprobitTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_table_max(s : MlclassifyprobitTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_table_to_string(s : MlclassifyprobitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_graphn_make(size : Int) -> MlclassifyprobitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_graphn_len(s : MlclassifyprobitGraphN) -> Int { s.size }

pub fn ml_classify_probit_graphn_get(s : MlclassifyprobitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_graphn_set(s : MlclassifyprobitGraphN, i : Int, v : Double) -> MlclassifyprobitGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_graphn_sum(s : MlclassifyprobitGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_graphn_mean(s : MlclassifyprobitGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_graphn_scale(s : MlclassifyprobitGraphN, f : Double) -> MlclassifyprobitGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_graphn_add(a : MlclassifyprobitGraphN, b : MlclassifyprobitGraphN) -> MlclassifyprobitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_graphn_copy(s : MlclassifyprobitGraphN) -> MlclassifyprobitGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_graphn_fill(s : MlclassifyprobitGraphN, v : Double) -> MlclassifyprobitGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_graphn_min(s : MlclassifyprobitGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_graphn_max(s : MlclassifyprobitGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_graphn_to_string(s : MlclassifyprobitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_node_make(size : Int) -> MlclassifyprobitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_node_len(s : MlclassifyprobitNode) -> Int { s.size }

pub fn ml_classify_probit_node_get(s : MlclassifyprobitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_node_set(s : MlclassifyprobitNode, i : Int, v : Double) -> MlclassifyprobitNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_node_sum(s : MlclassifyprobitNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_node_mean(s : MlclassifyprobitNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_node_scale(s : MlclassifyprobitNode, f : Double) -> MlclassifyprobitNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_node_add(a : MlclassifyprobitNode, b : MlclassifyprobitNode) -> MlclassifyprobitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_node_copy(s : MlclassifyprobitNode) -> MlclassifyprobitNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_node_fill(s : MlclassifyprobitNode, v : Double) -> MlclassifyprobitNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_node_min(s : MlclassifyprobitNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_node_max(s : MlclassifyprobitNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_node_to_string(s : MlclassifyprobitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_edge_make(size : Int) -> MlclassifyprobitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_edge_len(s : MlclassifyprobitEdge) -> Int { s.size }

pub fn ml_classify_probit_edge_get(s : MlclassifyprobitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_edge_set(s : MlclassifyprobitEdge, i : Int, v : Double) -> MlclassifyprobitEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_edge_sum(s : MlclassifyprobitEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_edge_mean(s : MlclassifyprobitEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_edge_scale(s : MlclassifyprobitEdge, f : Double) -> MlclassifyprobitEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_edge_add(a : MlclassifyprobitEdge, b : MlclassifyprobitEdge) -> MlclassifyprobitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_edge_copy(s : MlclassifyprobitEdge) -> MlclassifyprobitEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_edge_fill(s : MlclassifyprobitEdge, v : Double) -> MlclassifyprobitEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_edge_min(s : MlclassifyprobitEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_edge_max(s : MlclassifyprobitEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_edge_to_string(s : MlclassifyprobitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_path_make(size : Int) -> MlclassifyprobitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_path_len(s : MlclassifyprobitPath) -> Int { s.size }

pub fn ml_classify_probit_path_get(s : MlclassifyprobitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_path_set(s : MlclassifyprobitPath, i : Int, v : Double) -> MlclassifyprobitPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_path_sum(s : MlclassifyprobitPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_path_mean(s : MlclassifyprobitPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_path_scale(s : MlclassifyprobitPath, f : Double) -> MlclassifyprobitPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_path_add(a : MlclassifyprobitPath, b : MlclassifyprobitPath) -> MlclassifyprobitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_path_copy(s : MlclassifyprobitPath) -> MlclassifyprobitPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_path_fill(s : MlclassifyprobitPath, v : Double) -> MlclassifyprobitPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_path_min(s : MlclassifyprobitPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_path_max(s : MlclassifyprobitPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_path_to_string(s : MlclassifyprobitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_cluster_make(size : Int) -> MlclassifyprobitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_cluster_len(s : MlclassifyprobitCluster) -> Int { s.size }

pub fn ml_classify_probit_cluster_get(s : MlclassifyprobitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_cluster_set(s : MlclassifyprobitCluster, i : Int, v : Double) -> MlclassifyprobitCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cluster_sum(s : MlclassifyprobitCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_cluster_mean(s : MlclassifyprobitCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_cluster_scale(s : MlclassifyprobitCluster, f : Double) -> MlclassifyprobitCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cluster_add(a : MlclassifyprobitCluster, b : MlclassifyprobitCluster) -> MlclassifyprobitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_cluster_copy(s : MlclassifyprobitCluster) -> MlclassifyprobitCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cluster_fill(s : MlclassifyprobitCluster, v : Double) -> MlclassifyprobitCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cluster_min(s : MlclassifyprobitCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_cluster_max(s : MlclassifyprobitCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_cluster_to_string(s : MlclassifyprobitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_model_make(size : Int) -> MlclassifyprobitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_model_len(s : MlclassifyprobitModel) -> Int { s.size }

pub fn ml_classify_probit_model_get(s : MlclassifyprobitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_model_set(s : MlclassifyprobitModel, i : Int, v : Double) -> MlclassifyprobitModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_model_sum(s : MlclassifyprobitModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_model_mean(s : MlclassifyprobitModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_model_scale(s : MlclassifyprobitModel, f : Double) -> MlclassifyprobitModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_model_add(a : MlclassifyprobitModel, b : MlclassifyprobitModel) -> MlclassifyprobitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_model_copy(s : MlclassifyprobitModel) -> MlclassifyprobitModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_model_fill(s : MlclassifyprobitModel, v : Double) -> MlclassifyprobitModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_model_min(s : MlclassifyprobitModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_model_max(s : MlclassifyprobitModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_model_to_string(s : MlclassifyprobitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_layer_make(size : Int) -> MlclassifyprobitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_layer_len(s : MlclassifyprobitLayer) -> Int { s.size }

pub fn ml_classify_probit_layer_get(s : MlclassifyprobitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_layer_set(s : MlclassifyprobitLayer, i : Int, v : Double) -> MlclassifyprobitLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_layer_sum(s : MlclassifyprobitLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_layer_mean(s : MlclassifyprobitLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_layer_scale(s : MlclassifyprobitLayer, f : Double) -> MlclassifyprobitLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_layer_add(a : MlclassifyprobitLayer, b : MlclassifyprobitLayer) -> MlclassifyprobitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_layer_copy(s : MlclassifyprobitLayer) -> MlclassifyprobitLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_layer_fill(s : MlclassifyprobitLayer, v : Double) -> MlclassifyprobitLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_layer_min(s : MlclassifyprobitLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_layer_max(s : MlclassifyprobitLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_layer_to_string(s : MlclassifyprobitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_buffer_make(size : Int) -> MlclassifyprobitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_buffer_len(s : MlclassifyprobitBuffer) -> Int { s.size }

pub fn ml_classify_probit_buffer_get(s : MlclassifyprobitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_buffer_set(s : MlclassifyprobitBuffer, i : Int, v : Double) -> MlclassifyprobitBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_buffer_sum(s : MlclassifyprobitBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_buffer_mean(s : MlclassifyprobitBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_buffer_scale(s : MlclassifyprobitBuffer, f : Double) -> MlclassifyprobitBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_buffer_add(a : MlclassifyprobitBuffer, b : MlclassifyprobitBuffer) -> MlclassifyprobitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_buffer_copy(s : MlclassifyprobitBuffer) -> MlclassifyprobitBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_buffer_fill(s : MlclassifyprobitBuffer, v : Double) -> MlclassifyprobitBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_buffer_min(s : MlclassifyprobitBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_buffer_max(s : MlclassifyprobitBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_buffer_to_string(s : MlclassifyprobitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_cursor_make(size : Int) -> MlclassifyprobitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_cursor_len(s : MlclassifyprobitCursor) -> Int { s.size }

pub fn ml_classify_probit_cursor_get(s : MlclassifyprobitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_cursor_set(s : MlclassifyprobitCursor, i : Int, v : Double) -> MlclassifyprobitCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cursor_sum(s : MlclassifyprobitCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_cursor_mean(s : MlclassifyprobitCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_cursor_scale(s : MlclassifyprobitCursor, f : Double) -> MlclassifyprobitCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cursor_add(a : MlclassifyprobitCursor, b : MlclassifyprobitCursor) -> MlclassifyprobitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_cursor_copy(s : MlclassifyprobitCursor) -> MlclassifyprobitCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cursor_fill(s : MlclassifyprobitCursor, v : Double) -> MlclassifyprobitCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_cursor_min(s : MlclassifyprobitCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_cursor_max(s : MlclassifyprobitCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_cursor_to_string(s : MlclassifyprobitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_view_make(size : Int) -> MlclassifyprobitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_view_len(s : MlclassifyprobitView) -> Int { s.size }

pub fn ml_classify_probit_view_get(s : MlclassifyprobitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_view_set(s : MlclassifyprobitView, i : Int, v : Double) -> MlclassifyprobitView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_view_sum(s : MlclassifyprobitView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_view_mean(s : MlclassifyprobitView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_view_scale(s : MlclassifyprobitView, f : Double) -> MlclassifyprobitView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_view_add(a : MlclassifyprobitView, b : MlclassifyprobitView) -> MlclassifyprobitView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_view_copy(s : MlclassifyprobitView) -> MlclassifyprobitView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_view_fill(s : MlclassifyprobitView, v : Double) -> MlclassifyprobitView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_view_min(s : MlclassifyprobitView) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_view_max(s : MlclassifyprobitView) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_view_to_string(s : MlclassifyprobitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_range_make(size : Int) -> MlclassifyprobitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_range_len(s : MlclassifyprobitRange) -> Int { s.size }

pub fn ml_classify_probit_range_get(s : MlclassifyprobitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_range_set(s : MlclassifyprobitRange, i : Int, v : Double) -> MlclassifyprobitRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_range_sum(s : MlclassifyprobitRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_range_mean(s : MlclassifyprobitRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_range_scale(s : MlclassifyprobitRange, f : Double) -> MlclassifyprobitRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_range_add(a : MlclassifyprobitRange, b : MlclassifyprobitRange) -> MlclassifyprobitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_range_copy(s : MlclassifyprobitRange) -> MlclassifyprobitRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_range_fill(s : MlclassifyprobitRange, v : Double) -> MlclassifyprobitRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_range_min(s : MlclassifyprobitRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_range_max(s : MlclassifyprobitRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_range_to_string(s : MlclassifyprobitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_slice_make(size : Int) -> MlclassifyprobitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_slice_len(s : MlclassifyprobitSlice) -> Int { s.size }

pub fn ml_classify_probit_slice_get(s : MlclassifyprobitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_slice_set(s : MlclassifyprobitSlice, i : Int, v : Double) -> MlclassifyprobitSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_slice_sum(s : MlclassifyprobitSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_probit_slice_mean(s : MlclassifyprobitSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_probit_slice_scale(s : MlclassifyprobitSlice, f : Double) -> MlclassifyprobitSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_slice_add(a : MlclassifyprobitSlice, b : MlclassifyprobitSlice) -> MlclassifyprobitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_probit_slice_copy(s : MlclassifyprobitSlice) -> MlclassifyprobitSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_slice_fill(s : MlclassifyprobitSlice, v : Double) -> MlclassifyprobitSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_probit_slice_min(s : MlclassifyprobitSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_probit_slice_max(s : MlclassifyprobitSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_probit_slice_to_string(s : MlclassifyprobitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

