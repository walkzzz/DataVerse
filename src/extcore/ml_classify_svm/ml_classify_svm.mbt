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

pub fn MlclassifysvmFrame::len(self : MlclassifysvmFrame) -> Int { self.size }

pub fn MlclassifysvmFrame::get(self : MlclassifysvmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmFrame::set(self : MlclassifysvmFrame, i : Int, v : Double) -> MlclassifysvmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmFrame::sum(self : MlclassifysvmFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmFrame::mean(self : MlclassifysvmFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmFrame::scale(self : MlclassifysvmFrame, f : Double) -> MlclassifysvmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmFrame::add(self : MlclassifysvmFrame, other : MlclassifysvmFrame) -> MlclassifysvmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmFrame::copy(self : MlclassifysvmFrame) -> MlclassifysvmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmFrame::fill(self : MlclassifysvmFrame, v : Double) -> MlclassifysvmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmFrame::min(self : MlclassifysvmFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmFrame::max(self : MlclassifysvmFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmFrame::to_string(self : MlclassifysvmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_table_make(size : Int) -> MlclassifysvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmTable::len(self : MlclassifysvmTable) -> Int { self.size }

pub fn MlclassifysvmTable::get(self : MlclassifysvmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmTable::set(self : MlclassifysvmTable, i : Int, v : Double) -> MlclassifysvmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmTable::sum(self : MlclassifysvmTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmTable::mean(self : MlclassifysvmTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmTable::scale(self : MlclassifysvmTable, f : Double) -> MlclassifysvmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmTable::add(self : MlclassifysvmTable, other : MlclassifysvmTable) -> MlclassifysvmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmTable::copy(self : MlclassifysvmTable) -> MlclassifysvmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmTable::fill(self : MlclassifysvmTable, v : Double) -> MlclassifysvmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmTable::min(self : MlclassifysvmTable) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmTable::max(self : MlclassifysvmTable) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmTable::to_string(self : MlclassifysvmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_graphn_make(size : Int) -> MlclassifysvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmGraphN::len(self : MlclassifysvmGraphN) -> Int { self.size }

pub fn MlclassifysvmGraphN::get(self : MlclassifysvmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmGraphN::set(self : MlclassifysvmGraphN, i : Int, v : Double) -> MlclassifysvmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmGraphN::sum(self : MlclassifysvmGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmGraphN::mean(self : MlclassifysvmGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmGraphN::scale(self : MlclassifysvmGraphN, f : Double) -> MlclassifysvmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmGraphN::add(self : MlclassifysvmGraphN, other : MlclassifysvmGraphN) -> MlclassifysvmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmGraphN::copy(self : MlclassifysvmGraphN) -> MlclassifysvmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmGraphN::fill(self : MlclassifysvmGraphN, v : Double) -> MlclassifysvmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmGraphN::min(self : MlclassifysvmGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmGraphN::max(self : MlclassifysvmGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmGraphN::to_string(self : MlclassifysvmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_node_make(size : Int) -> MlclassifysvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmNode::len(self : MlclassifysvmNode) -> Int { self.size }

pub fn MlclassifysvmNode::get(self : MlclassifysvmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmNode::set(self : MlclassifysvmNode, i : Int, v : Double) -> MlclassifysvmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmNode::sum(self : MlclassifysvmNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmNode::mean(self : MlclassifysvmNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmNode::scale(self : MlclassifysvmNode, f : Double) -> MlclassifysvmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmNode::add(self : MlclassifysvmNode, other : MlclassifysvmNode) -> MlclassifysvmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmNode::copy(self : MlclassifysvmNode) -> MlclassifysvmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmNode::fill(self : MlclassifysvmNode, v : Double) -> MlclassifysvmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmNode::min(self : MlclassifysvmNode) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmNode::max(self : MlclassifysvmNode) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmNode::to_string(self : MlclassifysvmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_edge_make(size : Int) -> MlclassifysvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmEdge::len(self : MlclassifysvmEdge) -> Int { self.size }

pub fn MlclassifysvmEdge::get(self : MlclassifysvmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmEdge::set(self : MlclassifysvmEdge, i : Int, v : Double) -> MlclassifysvmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmEdge::sum(self : MlclassifysvmEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmEdge::mean(self : MlclassifysvmEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmEdge::scale(self : MlclassifysvmEdge, f : Double) -> MlclassifysvmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmEdge::add(self : MlclassifysvmEdge, other : MlclassifysvmEdge) -> MlclassifysvmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmEdge::copy(self : MlclassifysvmEdge) -> MlclassifysvmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmEdge::fill(self : MlclassifysvmEdge, v : Double) -> MlclassifysvmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmEdge::min(self : MlclassifysvmEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmEdge::max(self : MlclassifysvmEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmEdge::to_string(self : MlclassifysvmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_path_make(size : Int) -> MlclassifysvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmPath::len(self : MlclassifysvmPath) -> Int { self.size }

pub fn MlclassifysvmPath::get(self : MlclassifysvmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmPath::set(self : MlclassifysvmPath, i : Int, v : Double) -> MlclassifysvmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmPath::sum(self : MlclassifysvmPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmPath::mean(self : MlclassifysvmPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmPath::scale(self : MlclassifysvmPath, f : Double) -> MlclassifysvmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmPath::add(self : MlclassifysvmPath, other : MlclassifysvmPath) -> MlclassifysvmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmPath::copy(self : MlclassifysvmPath) -> MlclassifysvmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmPath::fill(self : MlclassifysvmPath, v : Double) -> MlclassifysvmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmPath::min(self : MlclassifysvmPath) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmPath::max(self : MlclassifysvmPath) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmPath::to_string(self : MlclassifysvmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_cluster_make(size : Int) -> MlclassifysvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmCluster::len(self : MlclassifysvmCluster) -> Int { self.size }

pub fn MlclassifysvmCluster::get(self : MlclassifysvmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmCluster::set(self : MlclassifysvmCluster, i : Int, v : Double) -> MlclassifysvmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCluster::sum(self : MlclassifysvmCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmCluster::mean(self : MlclassifysvmCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmCluster::scale(self : MlclassifysvmCluster, f : Double) -> MlclassifysvmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCluster::add(self : MlclassifysvmCluster, other : MlclassifysvmCluster) -> MlclassifysvmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmCluster::copy(self : MlclassifysvmCluster) -> MlclassifysvmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCluster::fill(self : MlclassifysvmCluster, v : Double) -> MlclassifysvmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCluster::min(self : MlclassifysvmCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmCluster::max(self : MlclassifysvmCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmCluster::to_string(self : MlclassifysvmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_model_make(size : Int) -> MlclassifysvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmModel::len(self : MlclassifysvmModel) -> Int { self.size }

pub fn MlclassifysvmModel::get(self : MlclassifysvmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmModel::set(self : MlclassifysvmModel, i : Int, v : Double) -> MlclassifysvmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmModel::sum(self : MlclassifysvmModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmModel::mean(self : MlclassifysvmModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmModel::scale(self : MlclassifysvmModel, f : Double) -> MlclassifysvmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmModel::add(self : MlclassifysvmModel, other : MlclassifysvmModel) -> MlclassifysvmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmModel::copy(self : MlclassifysvmModel) -> MlclassifysvmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmModel::fill(self : MlclassifysvmModel, v : Double) -> MlclassifysvmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmModel::min(self : MlclassifysvmModel) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmModel::max(self : MlclassifysvmModel) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmModel::to_string(self : MlclassifysvmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_layer_make(size : Int) -> MlclassifysvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmLayer::len(self : MlclassifysvmLayer) -> Int { self.size }

pub fn MlclassifysvmLayer::get(self : MlclassifysvmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmLayer::set(self : MlclassifysvmLayer, i : Int, v : Double) -> MlclassifysvmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmLayer::sum(self : MlclassifysvmLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmLayer::mean(self : MlclassifysvmLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmLayer::scale(self : MlclassifysvmLayer, f : Double) -> MlclassifysvmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmLayer::add(self : MlclassifysvmLayer, other : MlclassifysvmLayer) -> MlclassifysvmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmLayer::copy(self : MlclassifysvmLayer) -> MlclassifysvmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmLayer::fill(self : MlclassifysvmLayer, v : Double) -> MlclassifysvmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmLayer::min(self : MlclassifysvmLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmLayer::max(self : MlclassifysvmLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmLayer::to_string(self : MlclassifysvmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_buffer_make(size : Int) -> MlclassifysvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmBuffer::len(self : MlclassifysvmBuffer) -> Int { self.size }

pub fn MlclassifysvmBuffer::get(self : MlclassifysvmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmBuffer::set(self : MlclassifysvmBuffer, i : Int, v : Double) -> MlclassifysvmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmBuffer::sum(self : MlclassifysvmBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmBuffer::mean(self : MlclassifysvmBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmBuffer::scale(self : MlclassifysvmBuffer, f : Double) -> MlclassifysvmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmBuffer::add(self : MlclassifysvmBuffer, other : MlclassifysvmBuffer) -> MlclassifysvmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmBuffer::copy(self : MlclassifysvmBuffer) -> MlclassifysvmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmBuffer::fill(self : MlclassifysvmBuffer, v : Double) -> MlclassifysvmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmBuffer::min(self : MlclassifysvmBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmBuffer::max(self : MlclassifysvmBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmBuffer::to_string(self : MlclassifysvmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_cursor_make(size : Int) -> MlclassifysvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmCursor::len(self : MlclassifysvmCursor) -> Int { self.size }

pub fn MlclassifysvmCursor::get(self : MlclassifysvmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmCursor::set(self : MlclassifysvmCursor, i : Int, v : Double) -> MlclassifysvmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCursor::sum(self : MlclassifysvmCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmCursor::mean(self : MlclassifysvmCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmCursor::scale(self : MlclassifysvmCursor, f : Double) -> MlclassifysvmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCursor::add(self : MlclassifysvmCursor, other : MlclassifysvmCursor) -> MlclassifysvmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmCursor::copy(self : MlclassifysvmCursor) -> MlclassifysvmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCursor::fill(self : MlclassifysvmCursor, v : Double) -> MlclassifysvmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmCursor::min(self : MlclassifysvmCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmCursor::max(self : MlclassifysvmCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmCursor::to_string(self : MlclassifysvmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_view_make(size : Int) -> MlclassifysvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmView::len(self : MlclassifysvmView) -> Int { self.size }

pub fn MlclassifysvmView::get(self : MlclassifysvmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmView::set(self : MlclassifysvmView, i : Int, v : Double) -> MlclassifysvmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmView::sum(self : MlclassifysvmView) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmView::mean(self : MlclassifysvmView) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmView::scale(self : MlclassifysvmView, f : Double) -> MlclassifysvmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmView::add(self : MlclassifysvmView, other : MlclassifysvmView) -> MlclassifysvmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmView::copy(self : MlclassifysvmView) -> MlclassifysvmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmView::fill(self : MlclassifysvmView, v : Double) -> MlclassifysvmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmView::min(self : MlclassifysvmView) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmView::max(self : MlclassifysvmView) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmView::to_string(self : MlclassifysvmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_range_make(size : Int) -> MlclassifysvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmRange::len(self : MlclassifysvmRange) -> Int { self.size }

pub fn MlclassifysvmRange::get(self : MlclassifysvmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmRange::set(self : MlclassifysvmRange, i : Int, v : Double) -> MlclassifysvmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmRange::sum(self : MlclassifysvmRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmRange::mean(self : MlclassifysvmRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmRange::scale(self : MlclassifysvmRange, f : Double) -> MlclassifysvmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmRange::add(self : MlclassifysvmRange, other : MlclassifysvmRange) -> MlclassifysvmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmRange::copy(self : MlclassifysvmRange) -> MlclassifysvmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmRange::fill(self : MlclassifysvmRange, v : Double) -> MlclassifysvmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmRange::min(self : MlclassifysvmRange) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmRange::max(self : MlclassifysvmRange) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmRange::to_string(self : MlclassifysvmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_slice_make(size : Int) -> MlclassifysvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifysvmSlice::len(self : MlclassifysvmSlice) -> Int { self.size }

pub fn MlclassifysvmSlice::get(self : MlclassifysvmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifysvmSlice::set(self : MlclassifysvmSlice, i : Int, v : Double) -> MlclassifysvmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifysvmSlice::sum(self : MlclassifysvmSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifysvmSlice::mean(self : MlclassifysvmSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifysvmSlice::scale(self : MlclassifysvmSlice, f : Double) -> MlclassifysvmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmSlice::add(self : MlclassifysvmSlice, other : MlclassifysvmSlice) -> MlclassifysvmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifysvmSlice::copy(self : MlclassifysvmSlice) -> MlclassifysvmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmSlice::fill(self : MlclassifysvmSlice, v : Double) -> MlclassifysvmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifysvmSlice::min(self : MlclassifysvmSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifysvmSlice::max(self : MlclassifysvmSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifysvmSlice::to_string(self : MlclassifysvmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

