///===
/// extcore/ml_classify_svm

pub(all) struct MlclassifysvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_svm_make_point(x : Double, y : Double) -> MlclassifysvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_svm_make_point3(x : Double, y : Double, z : Double) -> MlclassifysvmPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifysvmPoint::x(self : MlclassifysvmPoint) -> Double { self.x }

pub fn MlclassifysvmPoint::y(self : MlclassifysvmPoint) -> Double { self.y }

pub fn MlclassifysvmPoint::z(self : MlclassifysvmPoint) -> Double { self.z }

pub fn MlclassifysvmPoint::label(self : MlclassifysvmPoint) -> Int { self.label }

pub fn MlclassifysvmPoint::dist(self : MlclassifysvmPoint, other : MlclassifysvmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifysvmPoint::add(self : MlclassifysvmPoint, other : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifysvmPoint::sub(self : MlclassifysvmPoint, other : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifysvmPoint::scale(self : MlclassifysvmPoint, s : Double) -> MlclassifysvmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifysvmPoint::dot(self : MlclassifysvmPoint, other : MlclassifysvmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifysvmPoint::cross(self : MlclassifysvmPoint, other : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifysvmPoint::norm(self : MlclassifysvmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifysvmPoint::normalize(self : MlclassifysvmPoint) -> MlclassifysvmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifysvmPoint::negate(self : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifysvmPoint::mid(self : MlclassifysvmPoint, other : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifysvmPoint::lerp(self : MlclassifysvmPoint, other : MlclassifysvmPoint, t : Double) -> MlclassifysvmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifysvmPoint::to_string(self : MlclassifysvmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifysvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_svm_make_series(vals : Array[Double], name : String) -> MlclassifysvmSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifysvmSeries::len(self : MlclassifysvmSeries) -> Int { self.vals.length() }

pub fn MlclassifysvmSeries::sum(self : MlclassifysvmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifysvmSeries::mean(self : MlclassifysvmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifysvmSeries::min(self : MlclassifysvmSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifysvmSeries::max(self : MlclassifysvmSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifysvmSeries::range(self : MlclassifysvmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifysvmSeries::variance(self : MlclassifysvmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifysvmSeries::std(self : MlclassifysvmSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifysvmSeries::median(self : MlclassifysvmSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifysvmSeries::scale(self : MlclassifysvmSeries, f : Double) -> MlclassifysvmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifysvmSeries::add(self : MlclassifysvmSeries, other : MlclassifysvmSeries) -> MlclassifysvmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifysvmSeries::sub(self : MlclassifysvmSeries, other : MlclassifysvmSeries) -> MlclassifysvmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifysvmSeries::normalize(self : MlclassifysvmSeries) -> MlclassifysvmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifysvmSeries::cumsum(self : MlclassifysvmSeries) -> MlclassifysvmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifysvmSeries::to_string(self : MlclassifysvmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifysvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_svm_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifysvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_svm_matrix_identity(n : Int) -> MlclassifysvmMatrix {
  let m = ml_classify_svm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifysvmMatrix::get(self : MlclassifysvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifysvmMatrix::transpose(self : MlclassifysvmMatrix) -> MlclassifysvmMatrix {
  let result = ml_classify_svm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifysvmMatrix::add(self : MlclassifysvmMatrix, other : MlclassifysvmMatrix) -> MlclassifysvmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_svm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifysvmMatrix::scale(self : MlclassifysvmMatrix, s : Double) -> MlclassifysvmMatrix {
  let result = ml_classify_svm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifysvmMatrix::multiply(self : MlclassifysvmMatrix, other : MlclassifysvmMatrix) -> MlclassifysvmMatrix {
  if self.cols != other.rows { return ml_classify_svm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_svm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifysvmMatrix::trace(self : MlclassifysvmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifysvmMatrix::det(self : MlclassifysvmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifysvmMatrix::norm(self : MlclassifysvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifysvmMatrix::to_string(self : MlclassifysvmMatrix) -> String {
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

pub(all) struct MlclassifysvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_svm_make_vector(comps : Array[Double]) -> MlclassifysvmVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_svm_vector_zero(dim : Int) -> MlclassifysvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifysvmVector::add(self : MlclassifysvmVector, other : MlclassifysvmVector) -> MlclassifysvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifysvmVector::sub(self : MlclassifysvmVector, other : MlclassifysvmVector) -> MlclassifysvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifysvmVector::scale(self : MlclassifysvmVector, s : Double) -> MlclassifysvmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifysvmVector::dot(self : MlclassifysvmVector, other : MlclassifysvmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifysvmVector::norm(self : MlclassifysvmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifysvmVector::normalize(self : MlclassifysvmVector) -> MlclassifysvmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifysvmVector::dist(self : MlclassifysvmVector, other : MlclassifysvmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifysvmVector::to_string(self : MlclassifysvmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_svm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_svm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_svm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_svm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_svm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_svm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_svm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_svm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_svm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_svm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_svm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_svm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_svm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_svm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_svm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_svm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_svm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_svm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_svm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_svm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_svm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_svm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_svm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_svm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_svm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_svm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_svm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_svm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_svm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifysvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_frame_make(size : Int) -> MlclassifysvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_frame_len(s : MlclassifysvmFrame) -> Int { s.size }

pub fn ml_classify_svm_frame_get(s : MlclassifysvmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_frame_set(s : MlclassifysvmFrame, i : Int, v : Double) -> MlclassifysvmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_frame_sum(s : MlclassifysvmFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_frame_mean(s : MlclassifysvmFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_frame_scale(s : MlclassifysvmFrame, f : Double) -> MlclassifysvmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_frame_add(a : MlclassifysvmFrame, b : MlclassifysvmFrame) -> MlclassifysvmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_frame_copy(s : MlclassifysvmFrame) -> MlclassifysvmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_frame_fill(s : MlclassifysvmFrame, v : Double) -> MlclassifysvmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_frame_min(s : MlclassifysvmFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_frame_max(s : MlclassifysvmFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_frame_to_string(s : MlclassifysvmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_table_make(size : Int) -> MlclassifysvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_table_len(s : MlclassifysvmTable) -> Int { s.size }

pub fn ml_classify_svm_table_get(s : MlclassifysvmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_table_set(s : MlclassifysvmTable, i : Int, v : Double) -> MlclassifysvmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_table_sum(s : MlclassifysvmTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_table_mean(s : MlclassifysvmTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_table_scale(s : MlclassifysvmTable, f : Double) -> MlclassifysvmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_table_add(a : MlclassifysvmTable, b : MlclassifysvmTable) -> MlclassifysvmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_table_copy(s : MlclassifysvmTable) -> MlclassifysvmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_table_fill(s : MlclassifysvmTable, v : Double) -> MlclassifysvmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_table_min(s : MlclassifysvmTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_table_max(s : MlclassifysvmTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_table_to_string(s : MlclassifysvmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_graphn_make(size : Int) -> MlclassifysvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_graphn_len(s : MlclassifysvmGraphN) -> Int { s.size }

pub fn ml_classify_svm_graphn_get(s : MlclassifysvmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_graphn_set(s : MlclassifysvmGraphN, i : Int, v : Double) -> MlclassifysvmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_graphn_sum(s : MlclassifysvmGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_graphn_mean(s : MlclassifysvmGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_graphn_scale(s : MlclassifysvmGraphN, f : Double) -> MlclassifysvmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_graphn_add(a : MlclassifysvmGraphN, b : MlclassifysvmGraphN) -> MlclassifysvmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_graphn_copy(s : MlclassifysvmGraphN) -> MlclassifysvmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_graphn_fill(s : MlclassifysvmGraphN, v : Double) -> MlclassifysvmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_graphn_min(s : MlclassifysvmGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_graphn_max(s : MlclassifysvmGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_graphn_to_string(s : MlclassifysvmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_node_make(size : Int) -> MlclassifysvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_node_len(s : MlclassifysvmNode) -> Int { s.size }

pub fn ml_classify_svm_node_get(s : MlclassifysvmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_node_set(s : MlclassifysvmNode, i : Int, v : Double) -> MlclassifysvmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_node_sum(s : MlclassifysvmNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_node_mean(s : MlclassifysvmNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_node_scale(s : MlclassifysvmNode, f : Double) -> MlclassifysvmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_node_add(a : MlclassifysvmNode, b : MlclassifysvmNode) -> MlclassifysvmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_node_copy(s : MlclassifysvmNode) -> MlclassifysvmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_node_fill(s : MlclassifysvmNode, v : Double) -> MlclassifysvmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_node_min(s : MlclassifysvmNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_node_max(s : MlclassifysvmNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_node_to_string(s : MlclassifysvmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_edge_make(size : Int) -> MlclassifysvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_edge_len(s : MlclassifysvmEdge) -> Int { s.size }

pub fn ml_classify_svm_edge_get(s : MlclassifysvmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_edge_set(s : MlclassifysvmEdge, i : Int, v : Double) -> MlclassifysvmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_edge_sum(s : MlclassifysvmEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_edge_mean(s : MlclassifysvmEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_edge_scale(s : MlclassifysvmEdge, f : Double) -> MlclassifysvmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_edge_add(a : MlclassifysvmEdge, b : MlclassifysvmEdge) -> MlclassifysvmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_edge_copy(s : MlclassifysvmEdge) -> MlclassifysvmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_edge_fill(s : MlclassifysvmEdge, v : Double) -> MlclassifysvmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_edge_min(s : MlclassifysvmEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_edge_max(s : MlclassifysvmEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_edge_to_string(s : MlclassifysvmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_path_make(size : Int) -> MlclassifysvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_path_len(s : MlclassifysvmPath) -> Int { s.size }

pub fn ml_classify_svm_path_get(s : MlclassifysvmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_path_set(s : MlclassifysvmPath, i : Int, v : Double) -> MlclassifysvmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_path_sum(s : MlclassifysvmPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_path_mean(s : MlclassifysvmPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_path_scale(s : MlclassifysvmPath, f : Double) -> MlclassifysvmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_path_add(a : MlclassifysvmPath, b : MlclassifysvmPath) -> MlclassifysvmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_path_copy(s : MlclassifysvmPath) -> MlclassifysvmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_path_fill(s : MlclassifysvmPath, v : Double) -> MlclassifysvmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_path_min(s : MlclassifysvmPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_path_max(s : MlclassifysvmPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_path_to_string(s : MlclassifysvmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_cluster_make(size : Int) -> MlclassifysvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_cluster_len(s : MlclassifysvmCluster) -> Int { s.size }

pub fn ml_classify_svm_cluster_get(s : MlclassifysvmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_cluster_set(s : MlclassifysvmCluster, i : Int, v : Double) -> MlclassifysvmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cluster_sum(s : MlclassifysvmCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_cluster_mean(s : MlclassifysvmCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_cluster_scale(s : MlclassifysvmCluster, f : Double) -> MlclassifysvmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cluster_add(a : MlclassifysvmCluster, b : MlclassifysvmCluster) -> MlclassifysvmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_cluster_copy(s : MlclassifysvmCluster) -> MlclassifysvmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cluster_fill(s : MlclassifysvmCluster, v : Double) -> MlclassifysvmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cluster_min(s : MlclassifysvmCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_cluster_max(s : MlclassifysvmCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_cluster_to_string(s : MlclassifysvmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_model_make(size : Int) -> MlclassifysvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_model_len(s : MlclassifysvmModel) -> Int { s.size }

pub fn ml_classify_svm_model_get(s : MlclassifysvmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_model_set(s : MlclassifysvmModel, i : Int, v : Double) -> MlclassifysvmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_model_sum(s : MlclassifysvmModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_model_mean(s : MlclassifysvmModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_model_scale(s : MlclassifysvmModel, f : Double) -> MlclassifysvmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_model_add(a : MlclassifysvmModel, b : MlclassifysvmModel) -> MlclassifysvmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_model_copy(s : MlclassifysvmModel) -> MlclassifysvmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_model_fill(s : MlclassifysvmModel, v : Double) -> MlclassifysvmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_model_min(s : MlclassifysvmModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_model_max(s : MlclassifysvmModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_model_to_string(s : MlclassifysvmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_layer_make(size : Int) -> MlclassifysvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_layer_len(s : MlclassifysvmLayer) -> Int { s.size }

pub fn ml_classify_svm_layer_get(s : MlclassifysvmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_layer_set(s : MlclassifysvmLayer, i : Int, v : Double) -> MlclassifysvmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_layer_sum(s : MlclassifysvmLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_layer_mean(s : MlclassifysvmLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_layer_scale(s : MlclassifysvmLayer, f : Double) -> MlclassifysvmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_layer_add(a : MlclassifysvmLayer, b : MlclassifysvmLayer) -> MlclassifysvmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_layer_copy(s : MlclassifysvmLayer) -> MlclassifysvmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_layer_fill(s : MlclassifysvmLayer, v : Double) -> MlclassifysvmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_layer_min(s : MlclassifysvmLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_layer_max(s : MlclassifysvmLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_layer_to_string(s : MlclassifysvmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_buffer_make(size : Int) -> MlclassifysvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_buffer_len(s : MlclassifysvmBuffer) -> Int { s.size }

pub fn ml_classify_svm_buffer_get(s : MlclassifysvmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_buffer_set(s : MlclassifysvmBuffer, i : Int, v : Double) -> MlclassifysvmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_buffer_sum(s : MlclassifysvmBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_buffer_mean(s : MlclassifysvmBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_buffer_scale(s : MlclassifysvmBuffer, f : Double) -> MlclassifysvmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_buffer_add(a : MlclassifysvmBuffer, b : MlclassifysvmBuffer) -> MlclassifysvmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_buffer_copy(s : MlclassifysvmBuffer) -> MlclassifysvmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_buffer_fill(s : MlclassifysvmBuffer, v : Double) -> MlclassifysvmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_buffer_min(s : MlclassifysvmBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_buffer_max(s : MlclassifysvmBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_buffer_to_string(s : MlclassifysvmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_cursor_make(size : Int) -> MlclassifysvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_cursor_len(s : MlclassifysvmCursor) -> Int { s.size }

pub fn ml_classify_svm_cursor_get(s : MlclassifysvmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_cursor_set(s : MlclassifysvmCursor, i : Int, v : Double) -> MlclassifysvmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cursor_sum(s : MlclassifysvmCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_cursor_mean(s : MlclassifysvmCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_cursor_scale(s : MlclassifysvmCursor, f : Double) -> MlclassifysvmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cursor_add(a : MlclassifysvmCursor, b : MlclassifysvmCursor) -> MlclassifysvmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_cursor_copy(s : MlclassifysvmCursor) -> MlclassifysvmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cursor_fill(s : MlclassifysvmCursor, v : Double) -> MlclassifysvmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_cursor_min(s : MlclassifysvmCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_cursor_max(s : MlclassifysvmCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_cursor_to_string(s : MlclassifysvmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_view_make(size : Int) -> MlclassifysvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_view_len(s : MlclassifysvmView) -> Int { s.size }

pub fn ml_classify_svm_view_get(s : MlclassifysvmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_view_set(s : MlclassifysvmView, i : Int, v : Double) -> MlclassifysvmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_view_sum(s : MlclassifysvmView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_view_mean(s : MlclassifysvmView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_view_scale(s : MlclassifysvmView, f : Double) -> MlclassifysvmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_view_add(a : MlclassifysvmView, b : MlclassifysvmView) -> MlclassifysvmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_view_copy(s : MlclassifysvmView) -> MlclassifysvmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_view_fill(s : MlclassifysvmView, v : Double) -> MlclassifysvmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_view_min(s : MlclassifysvmView) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_view_max(s : MlclassifysvmView) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_view_to_string(s : MlclassifysvmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_range_make(size : Int) -> MlclassifysvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_range_len(s : MlclassifysvmRange) -> Int { s.size }

pub fn ml_classify_svm_range_get(s : MlclassifysvmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_range_set(s : MlclassifysvmRange, i : Int, v : Double) -> MlclassifysvmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_range_sum(s : MlclassifysvmRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_range_mean(s : MlclassifysvmRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_range_scale(s : MlclassifysvmRange, f : Double) -> MlclassifysvmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_range_add(a : MlclassifysvmRange, b : MlclassifysvmRange) -> MlclassifysvmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_range_copy(s : MlclassifysvmRange) -> MlclassifysvmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_range_fill(s : MlclassifysvmRange, v : Double) -> MlclassifysvmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_range_min(s : MlclassifysvmRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_range_max(s : MlclassifysvmRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_range_to_string(s : MlclassifysvmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_slice_make(size : Int) -> MlclassifysvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_slice_len(s : MlclassifysvmSlice) -> Int { s.size }

pub fn ml_classify_svm_slice_get(s : MlclassifysvmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_slice_set(s : MlclassifysvmSlice, i : Int, v : Double) -> MlclassifysvmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_slice_sum(s : MlclassifysvmSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_svm_slice_mean(s : MlclassifysvmSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_svm_slice_scale(s : MlclassifysvmSlice, f : Double) -> MlclassifysvmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_slice_add(a : MlclassifysvmSlice, b : MlclassifysvmSlice) -> MlclassifysvmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_svm_slice_copy(s : MlclassifysvmSlice) -> MlclassifysvmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_slice_fill(s : MlclassifysvmSlice, v : Double) -> MlclassifysvmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_svm_slice_min(s : MlclassifysvmSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_svm_slice_max(s : MlclassifysvmSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_svm_slice_to_string(s : MlclassifysvmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

