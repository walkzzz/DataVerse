///===
/// extcore/ml_classify_logistic

pub(all) struct MlclassifylogisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_logistic_make_point(x : Double, y : Double) -> MlclassifylogisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_logistic_make_point3(x : Double, y : Double, z : Double) -> MlclassifylogisticPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifylogisticPoint::x(self : MlclassifylogisticPoint) -> Double { self.x }

pub fn MlclassifylogisticPoint::y(self : MlclassifylogisticPoint) -> Double { self.y }

pub fn MlclassifylogisticPoint::z(self : MlclassifylogisticPoint) -> Double { self.z }

pub fn MlclassifylogisticPoint::label(self : MlclassifylogisticPoint) -> Int { self.label }

pub fn MlclassifylogisticPoint::dist(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifylogisticPoint::add(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint) -> MlclassifylogisticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifylogisticPoint::sub(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint) -> MlclassifylogisticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifylogisticPoint::scale(self : MlclassifylogisticPoint, s : Double) -> MlclassifylogisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifylogisticPoint::dot(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifylogisticPoint::cross(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint) -> MlclassifylogisticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifylogisticPoint::norm(self : MlclassifylogisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifylogisticPoint::normalize(self : MlclassifylogisticPoint) -> MlclassifylogisticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifylogisticPoint::negate(self : MlclassifylogisticPoint) -> MlclassifylogisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifylogisticPoint::mid(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint) -> MlclassifylogisticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifylogisticPoint::lerp(self : MlclassifylogisticPoint, other : MlclassifylogisticPoint, t : Double) -> MlclassifylogisticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifylogisticPoint::to_string(self : MlclassifylogisticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifylogisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_logistic_make_series(vals : Array[Double], name : String) -> MlclassifylogisticSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifylogisticSeries::len(self : MlclassifylogisticSeries) -> Int { self.vals.length() }

pub fn MlclassifylogisticSeries::sum(self : MlclassifylogisticSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifylogisticSeries::mean(self : MlclassifylogisticSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifylogisticSeries::min(self : MlclassifylogisticSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifylogisticSeries::max(self : MlclassifylogisticSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifylogisticSeries::range(self : MlclassifylogisticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifylogisticSeries::variance(self : MlclassifylogisticSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifylogisticSeries::std(self : MlclassifylogisticSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifylogisticSeries::median(self : MlclassifylogisticSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifylogisticSeries::scale(self : MlclassifylogisticSeries, f : Double) -> MlclassifylogisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifylogisticSeries::add(self : MlclassifylogisticSeries, other : MlclassifylogisticSeries) -> MlclassifylogisticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifylogisticSeries::sub(self : MlclassifylogisticSeries, other : MlclassifylogisticSeries) -> MlclassifylogisticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifylogisticSeries::normalize(self : MlclassifylogisticSeries) -> MlclassifylogisticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifylogisticSeries::cumsum(self : MlclassifylogisticSeries) -> MlclassifylogisticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifylogisticSeries::to_string(self : MlclassifylogisticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifylogisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_logistic_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifylogisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_logistic_matrix_identity(n : Int) -> MlclassifylogisticMatrix {
  let m = ml_classify_logistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifylogisticMatrix::get(self : MlclassifylogisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifylogisticMatrix::transpose(self : MlclassifylogisticMatrix) -> MlclassifylogisticMatrix {
  let result = ml_classify_logistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifylogisticMatrix::add(self : MlclassifylogisticMatrix, other : MlclassifylogisticMatrix) -> MlclassifylogisticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifylogisticMatrix::scale(self : MlclassifylogisticMatrix, s : Double) -> MlclassifylogisticMatrix {
  let result = ml_classify_logistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifylogisticMatrix::multiply(self : MlclassifylogisticMatrix, other : MlclassifylogisticMatrix) -> MlclassifylogisticMatrix {
  if self.cols != other.rows { return ml_classify_logistic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_logistic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifylogisticMatrix::trace(self : MlclassifylogisticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifylogisticMatrix::det(self : MlclassifylogisticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifylogisticMatrix::norm(self : MlclassifylogisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifylogisticMatrix::to_string(self : MlclassifylogisticMatrix) -> String {
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

pub(all) struct MlclassifylogisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_logistic_make_vector(comps : Array[Double]) -> MlclassifylogisticVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_logistic_vector_zero(dim : Int) -> MlclassifylogisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifylogisticVector::add(self : MlclassifylogisticVector, other : MlclassifylogisticVector) -> MlclassifylogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifylogisticVector::sub(self : MlclassifylogisticVector, other : MlclassifylogisticVector) -> MlclassifylogisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifylogisticVector::scale(self : MlclassifylogisticVector, s : Double) -> MlclassifylogisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifylogisticVector::dot(self : MlclassifylogisticVector, other : MlclassifylogisticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifylogisticVector::norm(self : MlclassifylogisticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifylogisticVector::normalize(self : MlclassifylogisticVector) -> MlclassifylogisticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifylogisticVector::dist(self : MlclassifylogisticVector, other : MlclassifylogisticVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifylogisticVector::to_string(self : MlclassifylogisticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_logistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_logistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_logistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_logistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_logistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_logistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_logistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_logistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_logistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_logistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_logistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_logistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_logistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_logistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_logistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_logistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_logistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_logistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_logistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_logistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_logistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_logistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_logistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_logistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_logistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_logistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_logistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_logistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_logistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifylogisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_frame_make(size : Int) -> MlclassifylogisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_frame_len(s : MlclassifylogisticFrame) -> Int { s.size }

pub fn ml_classify_logistic_frame_get(s : MlclassifylogisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_frame_set(s : MlclassifylogisticFrame, i : Int, v : Double) -> MlclassifylogisticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_frame_sum(s : MlclassifylogisticFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_frame_mean(s : MlclassifylogisticFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_frame_scale(s : MlclassifylogisticFrame, f : Double) -> MlclassifylogisticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_frame_add(a : MlclassifylogisticFrame, b : MlclassifylogisticFrame) -> MlclassifylogisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_frame_copy(s : MlclassifylogisticFrame) -> MlclassifylogisticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_frame_fill(s : MlclassifylogisticFrame, v : Double) -> MlclassifylogisticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_frame_min(s : MlclassifylogisticFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_frame_max(s : MlclassifylogisticFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_frame_to_string(s : MlclassifylogisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_table_make(size : Int) -> MlclassifylogisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_table_len(s : MlclassifylogisticTable) -> Int { s.size }

pub fn ml_classify_logistic_table_get(s : MlclassifylogisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_table_set(s : MlclassifylogisticTable, i : Int, v : Double) -> MlclassifylogisticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_table_sum(s : MlclassifylogisticTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_table_mean(s : MlclassifylogisticTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_table_scale(s : MlclassifylogisticTable, f : Double) -> MlclassifylogisticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_table_add(a : MlclassifylogisticTable, b : MlclassifylogisticTable) -> MlclassifylogisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_table_copy(s : MlclassifylogisticTable) -> MlclassifylogisticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_table_fill(s : MlclassifylogisticTable, v : Double) -> MlclassifylogisticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_table_min(s : MlclassifylogisticTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_table_max(s : MlclassifylogisticTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_table_to_string(s : MlclassifylogisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_graphn_make(size : Int) -> MlclassifylogisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_graphn_len(s : MlclassifylogisticGraphN) -> Int { s.size }

pub fn ml_classify_logistic_graphn_get(s : MlclassifylogisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_graphn_set(s : MlclassifylogisticGraphN, i : Int, v : Double) -> MlclassifylogisticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_graphn_sum(s : MlclassifylogisticGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_graphn_mean(s : MlclassifylogisticGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_graphn_scale(s : MlclassifylogisticGraphN, f : Double) -> MlclassifylogisticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_graphn_add(a : MlclassifylogisticGraphN, b : MlclassifylogisticGraphN) -> MlclassifylogisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_graphn_copy(s : MlclassifylogisticGraphN) -> MlclassifylogisticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_graphn_fill(s : MlclassifylogisticGraphN, v : Double) -> MlclassifylogisticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_graphn_min(s : MlclassifylogisticGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_graphn_max(s : MlclassifylogisticGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_graphn_to_string(s : MlclassifylogisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_node_make(size : Int) -> MlclassifylogisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_node_len(s : MlclassifylogisticNode) -> Int { s.size }

pub fn ml_classify_logistic_node_get(s : MlclassifylogisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_node_set(s : MlclassifylogisticNode, i : Int, v : Double) -> MlclassifylogisticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_node_sum(s : MlclassifylogisticNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_node_mean(s : MlclassifylogisticNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_node_scale(s : MlclassifylogisticNode, f : Double) -> MlclassifylogisticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_node_add(a : MlclassifylogisticNode, b : MlclassifylogisticNode) -> MlclassifylogisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_node_copy(s : MlclassifylogisticNode) -> MlclassifylogisticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_node_fill(s : MlclassifylogisticNode, v : Double) -> MlclassifylogisticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_node_min(s : MlclassifylogisticNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_node_max(s : MlclassifylogisticNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_node_to_string(s : MlclassifylogisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_edge_make(size : Int) -> MlclassifylogisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_edge_len(s : MlclassifylogisticEdge) -> Int { s.size }

pub fn ml_classify_logistic_edge_get(s : MlclassifylogisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_edge_set(s : MlclassifylogisticEdge, i : Int, v : Double) -> MlclassifylogisticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_edge_sum(s : MlclassifylogisticEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_edge_mean(s : MlclassifylogisticEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_edge_scale(s : MlclassifylogisticEdge, f : Double) -> MlclassifylogisticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_edge_add(a : MlclassifylogisticEdge, b : MlclassifylogisticEdge) -> MlclassifylogisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_edge_copy(s : MlclassifylogisticEdge) -> MlclassifylogisticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_edge_fill(s : MlclassifylogisticEdge, v : Double) -> MlclassifylogisticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_edge_min(s : MlclassifylogisticEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_edge_max(s : MlclassifylogisticEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_edge_to_string(s : MlclassifylogisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_path_make(size : Int) -> MlclassifylogisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_path_len(s : MlclassifylogisticPath) -> Int { s.size }

pub fn ml_classify_logistic_path_get(s : MlclassifylogisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_path_set(s : MlclassifylogisticPath, i : Int, v : Double) -> MlclassifylogisticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_path_sum(s : MlclassifylogisticPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_path_mean(s : MlclassifylogisticPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_path_scale(s : MlclassifylogisticPath, f : Double) -> MlclassifylogisticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_path_add(a : MlclassifylogisticPath, b : MlclassifylogisticPath) -> MlclassifylogisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_path_copy(s : MlclassifylogisticPath) -> MlclassifylogisticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_path_fill(s : MlclassifylogisticPath, v : Double) -> MlclassifylogisticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_path_min(s : MlclassifylogisticPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_path_max(s : MlclassifylogisticPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_path_to_string(s : MlclassifylogisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_cluster_make(size : Int) -> MlclassifylogisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_cluster_len(s : MlclassifylogisticCluster) -> Int { s.size }

pub fn ml_classify_logistic_cluster_get(s : MlclassifylogisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_cluster_set(s : MlclassifylogisticCluster, i : Int, v : Double) -> MlclassifylogisticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cluster_sum(s : MlclassifylogisticCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_cluster_mean(s : MlclassifylogisticCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_cluster_scale(s : MlclassifylogisticCluster, f : Double) -> MlclassifylogisticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cluster_add(a : MlclassifylogisticCluster, b : MlclassifylogisticCluster) -> MlclassifylogisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_cluster_copy(s : MlclassifylogisticCluster) -> MlclassifylogisticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cluster_fill(s : MlclassifylogisticCluster, v : Double) -> MlclassifylogisticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cluster_min(s : MlclassifylogisticCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_cluster_max(s : MlclassifylogisticCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_cluster_to_string(s : MlclassifylogisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_model_make(size : Int) -> MlclassifylogisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_model_len(s : MlclassifylogisticModel) -> Int { s.size }

pub fn ml_classify_logistic_model_get(s : MlclassifylogisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_model_set(s : MlclassifylogisticModel, i : Int, v : Double) -> MlclassifylogisticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_model_sum(s : MlclassifylogisticModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_model_mean(s : MlclassifylogisticModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_model_scale(s : MlclassifylogisticModel, f : Double) -> MlclassifylogisticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_model_add(a : MlclassifylogisticModel, b : MlclassifylogisticModel) -> MlclassifylogisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_model_copy(s : MlclassifylogisticModel) -> MlclassifylogisticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_model_fill(s : MlclassifylogisticModel, v : Double) -> MlclassifylogisticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_model_min(s : MlclassifylogisticModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_model_max(s : MlclassifylogisticModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_model_to_string(s : MlclassifylogisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_layer_make(size : Int) -> MlclassifylogisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_layer_len(s : MlclassifylogisticLayer) -> Int { s.size }

pub fn ml_classify_logistic_layer_get(s : MlclassifylogisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_layer_set(s : MlclassifylogisticLayer, i : Int, v : Double) -> MlclassifylogisticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_layer_sum(s : MlclassifylogisticLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_layer_mean(s : MlclassifylogisticLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_layer_scale(s : MlclassifylogisticLayer, f : Double) -> MlclassifylogisticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_layer_add(a : MlclassifylogisticLayer, b : MlclassifylogisticLayer) -> MlclassifylogisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_layer_copy(s : MlclassifylogisticLayer) -> MlclassifylogisticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_layer_fill(s : MlclassifylogisticLayer, v : Double) -> MlclassifylogisticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_layer_min(s : MlclassifylogisticLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_layer_max(s : MlclassifylogisticLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_layer_to_string(s : MlclassifylogisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_buffer_make(size : Int) -> MlclassifylogisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_buffer_len(s : MlclassifylogisticBuffer) -> Int { s.size }

pub fn ml_classify_logistic_buffer_get(s : MlclassifylogisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_buffer_set(s : MlclassifylogisticBuffer, i : Int, v : Double) -> MlclassifylogisticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_buffer_sum(s : MlclassifylogisticBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_buffer_mean(s : MlclassifylogisticBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_buffer_scale(s : MlclassifylogisticBuffer, f : Double) -> MlclassifylogisticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_buffer_add(a : MlclassifylogisticBuffer, b : MlclassifylogisticBuffer) -> MlclassifylogisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_buffer_copy(s : MlclassifylogisticBuffer) -> MlclassifylogisticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_buffer_fill(s : MlclassifylogisticBuffer, v : Double) -> MlclassifylogisticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_buffer_min(s : MlclassifylogisticBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_buffer_max(s : MlclassifylogisticBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_buffer_to_string(s : MlclassifylogisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_cursor_make(size : Int) -> MlclassifylogisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_cursor_len(s : MlclassifylogisticCursor) -> Int { s.size }

pub fn ml_classify_logistic_cursor_get(s : MlclassifylogisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_cursor_set(s : MlclassifylogisticCursor, i : Int, v : Double) -> MlclassifylogisticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cursor_sum(s : MlclassifylogisticCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_cursor_mean(s : MlclassifylogisticCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_cursor_scale(s : MlclassifylogisticCursor, f : Double) -> MlclassifylogisticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cursor_add(a : MlclassifylogisticCursor, b : MlclassifylogisticCursor) -> MlclassifylogisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_cursor_copy(s : MlclassifylogisticCursor) -> MlclassifylogisticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cursor_fill(s : MlclassifylogisticCursor, v : Double) -> MlclassifylogisticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_cursor_min(s : MlclassifylogisticCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_cursor_max(s : MlclassifylogisticCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_cursor_to_string(s : MlclassifylogisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_view_make(size : Int) -> MlclassifylogisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_view_len(s : MlclassifylogisticView) -> Int { s.size }

pub fn ml_classify_logistic_view_get(s : MlclassifylogisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_view_set(s : MlclassifylogisticView, i : Int, v : Double) -> MlclassifylogisticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_view_sum(s : MlclassifylogisticView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_view_mean(s : MlclassifylogisticView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_view_scale(s : MlclassifylogisticView, f : Double) -> MlclassifylogisticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_view_add(a : MlclassifylogisticView, b : MlclassifylogisticView) -> MlclassifylogisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_view_copy(s : MlclassifylogisticView) -> MlclassifylogisticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_view_fill(s : MlclassifylogisticView, v : Double) -> MlclassifylogisticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_view_min(s : MlclassifylogisticView) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_view_max(s : MlclassifylogisticView) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_view_to_string(s : MlclassifylogisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_range_make(size : Int) -> MlclassifylogisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_range_len(s : MlclassifylogisticRange) -> Int { s.size }

pub fn ml_classify_logistic_range_get(s : MlclassifylogisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_range_set(s : MlclassifylogisticRange, i : Int, v : Double) -> MlclassifylogisticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_range_sum(s : MlclassifylogisticRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_range_mean(s : MlclassifylogisticRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_range_scale(s : MlclassifylogisticRange, f : Double) -> MlclassifylogisticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_range_add(a : MlclassifylogisticRange, b : MlclassifylogisticRange) -> MlclassifylogisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_range_copy(s : MlclassifylogisticRange) -> MlclassifylogisticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_range_fill(s : MlclassifylogisticRange, v : Double) -> MlclassifylogisticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_range_min(s : MlclassifylogisticRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_range_max(s : MlclassifylogisticRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_range_to_string(s : MlclassifylogisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifylogisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_logistic_slice_make(size : Int) -> MlclassifylogisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_logistic_slice_len(s : MlclassifylogisticSlice) -> Int { s.size }

pub fn ml_classify_logistic_slice_get(s : MlclassifylogisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_logistic_slice_set(s : MlclassifylogisticSlice, i : Int, v : Double) -> MlclassifylogisticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_slice_sum(s : MlclassifylogisticSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_logistic_slice_mean(s : MlclassifylogisticSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_logistic_slice_scale(s : MlclassifylogisticSlice, f : Double) -> MlclassifylogisticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_slice_add(a : MlclassifylogisticSlice, b : MlclassifylogisticSlice) -> MlclassifylogisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_logistic_slice_copy(s : MlclassifylogisticSlice) -> MlclassifylogisticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_slice_fill(s : MlclassifylogisticSlice, v : Double) -> MlclassifylogisticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_logistic_slice_min(s : MlclassifylogisticSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_logistic_slice_max(s : MlclassifylogisticSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_logistic_slice_to_string(s : MlclassifylogisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

