///===
/// extcore/ml_regress_logistic

pub(all) struct MlregresslogisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_logistic_make_point(x : Double, y : Double) -> MlregresslogisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_logistic_make_point3(x : Double, y : Double, z : Double) -> MlregresslogisticPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresslogisticPoint::x(self : MlregresslogisticPoint) -> Double { self.x }

pub fn MlregresslogisticPoint::y(self : MlregresslogisticPoint) -> Double { self.y }

pub fn MlregresslogisticPoint::z(self : MlregresslogisticPoint) -> Double { self.z }

pub fn MlregresslogisticPoint::label(self : MlregresslogisticPoint) -> Int { self.label }

pub fn MlregresslogisticPoint::dist(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresslogisticPoint::add(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresslogisticPoint::sub(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresslogisticPoint::scale(self : MlregresslogisticPoint, s : Double) -> MlregresslogisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresslogisticPoint::dot(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresslogisticPoint::cross(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresslogisticPoint::norm(self : MlregresslogisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresslogisticPoint::normalize(self : MlregresslogisticPoint) -> MlregresslogisticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslogisticPoint::negate(self : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresslogisticPoint::mid(self : MlregresslogisticPoint, other : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresslogisticPoint::lerp(self : MlregresslogisticPoint, other : MlregresslogisticPoint, t : Double) -> MlregresslogisticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresslogisticPoint::to_string(self : MlregresslogisticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresslogisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_logistic_make_series(vals : Array[Double], name : String) -> MlregresslogisticSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresslogisticSeries::len(self : MlregresslogisticSeries) -> Int { self.vals.length() }

pub fn MlregresslogisticSeries::sum(self : MlregresslogisticSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresslogisticSeries::mean(self : MlregresslogisticSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresslogisticSeries::min(self : MlregresslogisticSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresslogisticSeries::max(self : MlregresslogisticSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresslogisticSeries::range(self : MlregresslogisticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresslogisticSeries::variance(self : MlregresslogisticSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresslogisticSeries::std(self : MlregresslogisticSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresslogisticSeries::median(self : MlregresslogisticSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresslogisticSeries::scale(self : MlregresslogisticSeries, f : Double) -> MlregresslogisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresslogisticSeries::add(self : MlregresslogisticSeries, other : MlregresslogisticSeries) -> MlregresslogisticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresslogisticSeries::sub(self : MlregresslogisticSeries, other : MlregresslogisticSeries) -> MlregresslogisticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresslogisticSeries::normalize(self : MlregresslogisticSeries) -> MlregresslogisticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresslogisticSeries::cumsum(self : MlregresslogisticSeries) -> MlregresslogisticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresslogisticSeries::to_string(self : MlregresslogisticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslogisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_logistic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslogisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_logistic_matrix_identity(n : Int) -> MlregresslogisticMatrix {
  let m = ml_regress_logistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresslogisticMatrix::get(self : MlregresslogisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresslogisticMatrix::transpose(self : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  let result = ml_regress_logistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresslogisticMatrix::add(self : MlregresslogisticMatrix, other : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresslogisticMatrix::scale(self : MlregresslogisticMatrix, s : Double) -> MlregresslogisticMatrix {
  let result = ml_regress_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresslogisticMatrix::multiply(self : MlregresslogisticMatrix, other : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  if self.cols != other.rows { return ml_regress_logistic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_logistic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresslogisticMatrix::trace(self : MlregresslogisticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresslogisticMatrix::det(self : MlregresslogisticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresslogisticMatrix::norm(self : MlregresslogisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresslogisticMatrix::to_string(self : MlregresslogisticMatrix) -> String {
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

pub(all) struct MlregresslogisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_logistic_make_vector(comps : Array[Double]) -> MlregresslogisticVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_logistic_vector_zero(dim : Int) -> MlregresslogisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresslogisticVector::add(self : MlregresslogisticVector, other : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslogisticVector::sub(self : MlregresslogisticVector, other : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslogisticVector::scale(self : MlregresslogisticVector, s : Double) -> MlregresslogisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresslogisticVector::dot(self : MlregresslogisticVector, other : MlregresslogisticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresslogisticVector::norm(self : MlregresslogisticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresslogisticVector::normalize(self : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslogisticVector::dist(self : MlregresslogisticVector, other : MlregresslogisticVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresslogisticVector::to_string(self : MlregresslogisticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_logistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_logistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_logistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_logistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_logistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_logistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_logistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_logistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_logistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_logistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_logistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_logistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_logistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_logistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_logistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_logistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_logistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_logistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_logistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_logistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_logistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_logistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_logistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_logistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_logistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_logistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_logistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_logistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_logistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresslogisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_frame_make(size : Int) -> MlregresslogisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_frame_len(s : MlregresslogisticFrame) -> Int { s.size }

pub fn ml_regress_logistic_frame_get(s : MlregresslogisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_frame_set(s : MlregresslogisticFrame, i : Int, v : Double) -> MlregresslogisticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_frame_sum(s : MlregresslogisticFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_frame_mean(s : MlregresslogisticFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_frame_scale(s : MlregresslogisticFrame, f : Double) -> MlregresslogisticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_frame_add(a : MlregresslogisticFrame, b : MlregresslogisticFrame) -> MlregresslogisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_frame_copy(s : MlregresslogisticFrame) -> MlregresslogisticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_frame_fill(s : MlregresslogisticFrame, v : Double) -> MlregresslogisticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_frame_min(s : MlregresslogisticFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_frame_max(s : MlregresslogisticFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_frame_to_string(s : MlregresslogisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_table_make(size : Int) -> MlregresslogisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_table_len(s : MlregresslogisticTable) -> Int { s.size }

pub fn ml_regress_logistic_table_get(s : MlregresslogisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_table_set(s : MlregresslogisticTable, i : Int, v : Double) -> MlregresslogisticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_table_sum(s : MlregresslogisticTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_table_mean(s : MlregresslogisticTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_table_scale(s : MlregresslogisticTable, f : Double) -> MlregresslogisticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_table_add(a : MlregresslogisticTable, b : MlregresslogisticTable) -> MlregresslogisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_table_copy(s : MlregresslogisticTable) -> MlregresslogisticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_table_fill(s : MlregresslogisticTable, v : Double) -> MlregresslogisticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_table_min(s : MlregresslogisticTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_table_max(s : MlregresslogisticTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_table_to_string(s : MlregresslogisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_graphn_make(size : Int) -> MlregresslogisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_graphn_len(s : MlregresslogisticGraphN) -> Int { s.size }

pub fn ml_regress_logistic_graphn_get(s : MlregresslogisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_graphn_set(s : MlregresslogisticGraphN, i : Int, v : Double) -> MlregresslogisticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_graphn_sum(s : MlregresslogisticGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_graphn_mean(s : MlregresslogisticGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_graphn_scale(s : MlregresslogisticGraphN, f : Double) -> MlregresslogisticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_graphn_add(a : MlregresslogisticGraphN, b : MlregresslogisticGraphN) -> MlregresslogisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_graphn_copy(s : MlregresslogisticGraphN) -> MlregresslogisticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_graphn_fill(s : MlregresslogisticGraphN, v : Double) -> MlregresslogisticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_graphn_min(s : MlregresslogisticGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_graphn_max(s : MlregresslogisticGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_graphn_to_string(s : MlregresslogisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_node_make(size : Int) -> MlregresslogisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_node_len(s : MlregresslogisticNode) -> Int { s.size }

pub fn ml_regress_logistic_node_get(s : MlregresslogisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_node_set(s : MlregresslogisticNode, i : Int, v : Double) -> MlregresslogisticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_node_sum(s : MlregresslogisticNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_node_mean(s : MlregresslogisticNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_node_scale(s : MlregresslogisticNode, f : Double) -> MlregresslogisticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_node_add(a : MlregresslogisticNode, b : MlregresslogisticNode) -> MlregresslogisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_node_copy(s : MlregresslogisticNode) -> MlregresslogisticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_node_fill(s : MlregresslogisticNode, v : Double) -> MlregresslogisticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_node_min(s : MlregresslogisticNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_node_max(s : MlregresslogisticNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_node_to_string(s : MlregresslogisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_edge_make(size : Int) -> MlregresslogisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_edge_len(s : MlregresslogisticEdge) -> Int { s.size }

pub fn ml_regress_logistic_edge_get(s : MlregresslogisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_edge_set(s : MlregresslogisticEdge, i : Int, v : Double) -> MlregresslogisticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_edge_sum(s : MlregresslogisticEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_edge_mean(s : MlregresslogisticEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_edge_scale(s : MlregresslogisticEdge, f : Double) -> MlregresslogisticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_edge_add(a : MlregresslogisticEdge, b : MlregresslogisticEdge) -> MlregresslogisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_edge_copy(s : MlregresslogisticEdge) -> MlregresslogisticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_edge_fill(s : MlregresslogisticEdge, v : Double) -> MlregresslogisticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_edge_min(s : MlregresslogisticEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_edge_max(s : MlregresslogisticEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_edge_to_string(s : MlregresslogisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_path_make(size : Int) -> MlregresslogisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_path_len(s : MlregresslogisticPath) -> Int { s.size }

pub fn ml_regress_logistic_path_get(s : MlregresslogisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_path_set(s : MlregresslogisticPath, i : Int, v : Double) -> MlregresslogisticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_path_sum(s : MlregresslogisticPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_path_mean(s : MlregresslogisticPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_path_scale(s : MlregresslogisticPath, f : Double) -> MlregresslogisticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_path_add(a : MlregresslogisticPath, b : MlregresslogisticPath) -> MlregresslogisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_path_copy(s : MlregresslogisticPath) -> MlregresslogisticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_path_fill(s : MlregresslogisticPath, v : Double) -> MlregresslogisticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_path_min(s : MlregresslogisticPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_path_max(s : MlregresslogisticPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_path_to_string(s : MlregresslogisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_cluster_make(size : Int) -> MlregresslogisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_cluster_len(s : MlregresslogisticCluster) -> Int { s.size }

pub fn ml_regress_logistic_cluster_get(s : MlregresslogisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_cluster_set(s : MlregresslogisticCluster, i : Int, v : Double) -> MlregresslogisticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cluster_sum(s : MlregresslogisticCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_cluster_mean(s : MlregresslogisticCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_cluster_scale(s : MlregresslogisticCluster, f : Double) -> MlregresslogisticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cluster_add(a : MlregresslogisticCluster, b : MlregresslogisticCluster) -> MlregresslogisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_cluster_copy(s : MlregresslogisticCluster) -> MlregresslogisticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cluster_fill(s : MlregresslogisticCluster, v : Double) -> MlregresslogisticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cluster_min(s : MlregresslogisticCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_cluster_max(s : MlregresslogisticCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_cluster_to_string(s : MlregresslogisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_model_make(size : Int) -> MlregresslogisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_model_len(s : MlregresslogisticModel) -> Int { s.size }

pub fn ml_regress_logistic_model_get(s : MlregresslogisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_model_set(s : MlregresslogisticModel, i : Int, v : Double) -> MlregresslogisticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_model_sum(s : MlregresslogisticModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_model_mean(s : MlregresslogisticModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_model_scale(s : MlregresslogisticModel, f : Double) -> MlregresslogisticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_model_add(a : MlregresslogisticModel, b : MlregresslogisticModel) -> MlregresslogisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_model_copy(s : MlregresslogisticModel) -> MlregresslogisticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_model_fill(s : MlregresslogisticModel, v : Double) -> MlregresslogisticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_model_min(s : MlregresslogisticModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_model_max(s : MlregresslogisticModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_model_to_string(s : MlregresslogisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_layer_make(size : Int) -> MlregresslogisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_layer_len(s : MlregresslogisticLayer) -> Int { s.size }

pub fn ml_regress_logistic_layer_get(s : MlregresslogisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_layer_set(s : MlregresslogisticLayer, i : Int, v : Double) -> MlregresslogisticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_layer_sum(s : MlregresslogisticLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_layer_mean(s : MlregresslogisticLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_layer_scale(s : MlregresslogisticLayer, f : Double) -> MlregresslogisticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_layer_add(a : MlregresslogisticLayer, b : MlregresslogisticLayer) -> MlregresslogisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_layer_copy(s : MlregresslogisticLayer) -> MlregresslogisticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_layer_fill(s : MlregresslogisticLayer, v : Double) -> MlregresslogisticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_layer_min(s : MlregresslogisticLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_layer_max(s : MlregresslogisticLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_layer_to_string(s : MlregresslogisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_buffer_make(size : Int) -> MlregresslogisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_buffer_len(s : MlregresslogisticBuffer) -> Int { s.size }

pub fn ml_regress_logistic_buffer_get(s : MlregresslogisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_buffer_set(s : MlregresslogisticBuffer, i : Int, v : Double) -> MlregresslogisticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_buffer_sum(s : MlregresslogisticBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_buffer_mean(s : MlregresslogisticBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_buffer_scale(s : MlregresslogisticBuffer, f : Double) -> MlregresslogisticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_buffer_add(a : MlregresslogisticBuffer, b : MlregresslogisticBuffer) -> MlregresslogisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_buffer_copy(s : MlregresslogisticBuffer) -> MlregresslogisticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_buffer_fill(s : MlregresslogisticBuffer, v : Double) -> MlregresslogisticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_buffer_min(s : MlregresslogisticBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_buffer_max(s : MlregresslogisticBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_buffer_to_string(s : MlregresslogisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_cursor_make(size : Int) -> MlregresslogisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_cursor_len(s : MlregresslogisticCursor) -> Int { s.size }

pub fn ml_regress_logistic_cursor_get(s : MlregresslogisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_cursor_set(s : MlregresslogisticCursor, i : Int, v : Double) -> MlregresslogisticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cursor_sum(s : MlregresslogisticCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_cursor_mean(s : MlregresslogisticCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_cursor_scale(s : MlregresslogisticCursor, f : Double) -> MlregresslogisticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cursor_add(a : MlregresslogisticCursor, b : MlregresslogisticCursor) -> MlregresslogisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_cursor_copy(s : MlregresslogisticCursor) -> MlregresslogisticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cursor_fill(s : MlregresslogisticCursor, v : Double) -> MlregresslogisticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_cursor_min(s : MlregresslogisticCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_cursor_max(s : MlregresslogisticCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_cursor_to_string(s : MlregresslogisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_view_make(size : Int) -> MlregresslogisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_view_len(s : MlregresslogisticView) -> Int { s.size }

pub fn ml_regress_logistic_view_get(s : MlregresslogisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_view_set(s : MlregresslogisticView, i : Int, v : Double) -> MlregresslogisticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_view_sum(s : MlregresslogisticView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_view_mean(s : MlregresslogisticView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_view_scale(s : MlregresslogisticView, f : Double) -> MlregresslogisticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_view_add(a : MlregresslogisticView, b : MlregresslogisticView) -> MlregresslogisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_view_copy(s : MlregresslogisticView) -> MlregresslogisticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_view_fill(s : MlregresslogisticView, v : Double) -> MlregresslogisticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_view_min(s : MlregresslogisticView) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_view_max(s : MlregresslogisticView) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_view_to_string(s : MlregresslogisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_range_make(size : Int) -> MlregresslogisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_range_len(s : MlregresslogisticRange) -> Int { s.size }

pub fn ml_regress_logistic_range_get(s : MlregresslogisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_range_set(s : MlregresslogisticRange, i : Int, v : Double) -> MlregresslogisticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_range_sum(s : MlregresslogisticRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_range_mean(s : MlregresslogisticRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_range_scale(s : MlregresslogisticRange, f : Double) -> MlregresslogisticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_range_add(a : MlregresslogisticRange, b : MlregresslogisticRange) -> MlregresslogisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_range_copy(s : MlregresslogisticRange) -> MlregresslogisticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_range_fill(s : MlregresslogisticRange, v : Double) -> MlregresslogisticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_range_min(s : MlregresslogisticRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_range_max(s : MlregresslogisticRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_range_to_string(s : MlregresslogisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_slice_make(size : Int) -> MlregresslogisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_slice_len(s : MlregresslogisticSlice) -> Int { s.size }

pub fn ml_regress_logistic_slice_get(s : MlregresslogisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_slice_set(s : MlregresslogisticSlice, i : Int, v : Double) -> MlregresslogisticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_slice_sum(s : MlregresslogisticSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_logistic_slice_mean(s : MlregresslogisticSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_logistic_slice_scale(s : MlregresslogisticSlice, f : Double) -> MlregresslogisticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_slice_add(a : MlregresslogisticSlice, b : MlregresslogisticSlice) -> MlregresslogisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_logistic_slice_copy(s : MlregresslogisticSlice) -> MlregresslogisticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_slice_fill(s : MlregresslogisticSlice, v : Double) -> MlregresslogisticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_logistic_slice_min(s : MlregresslogisticSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_logistic_slice_max(s : MlregresslogisticSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_logistic_slice_to_string(s : MlregresslogisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

