///===
/// extcore/ml_classify_qda

pub(all) struct MlclassifyqdaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_qda_make_point(x : Double, y : Double) -> MlclassifyqdaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_qda_make_point3(x : Double, y : Double, z : Double) -> MlclassifyqdaPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyqdaPoint::x(self : MlclassifyqdaPoint) -> Double { self.x }

pub fn MlclassifyqdaPoint::y(self : MlclassifyqdaPoint) -> Double { self.y }

pub fn MlclassifyqdaPoint::z(self : MlclassifyqdaPoint) -> Double { self.z }

pub fn MlclassifyqdaPoint::label(self : MlclassifyqdaPoint) -> Int { self.label }

pub fn MlclassifyqdaPoint::dist(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyqdaPoint::add(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyqdaPoint::sub(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyqdaPoint::scale(self : MlclassifyqdaPoint, s : Double) -> MlclassifyqdaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyqdaPoint::dot(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyqdaPoint::cross(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyqdaPoint::norm(self : MlclassifyqdaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyqdaPoint::normalize(self : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyqdaPoint::negate(self : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyqdaPoint::mid(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyqdaPoint::lerp(self : MlclassifyqdaPoint, other : MlclassifyqdaPoint, t : Double) -> MlclassifyqdaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyqdaPoint::to_string(self : MlclassifyqdaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyqdaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_qda_make_series(vals : Array[Double], name : String) -> MlclassifyqdaSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyqdaSeries::len(self : MlclassifyqdaSeries) -> Int { self.vals.length() }

pub fn MlclassifyqdaSeries::sum(self : MlclassifyqdaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyqdaSeries::mean(self : MlclassifyqdaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyqdaSeries::min(self : MlclassifyqdaSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyqdaSeries::max(self : MlclassifyqdaSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyqdaSeries::range(self : MlclassifyqdaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyqdaSeries::variance(self : MlclassifyqdaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyqdaSeries::std(self : MlclassifyqdaSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyqdaSeries::median(self : MlclassifyqdaSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyqdaSeries::scale(self : MlclassifyqdaSeries, f : Double) -> MlclassifyqdaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyqdaSeries::add(self : MlclassifyqdaSeries, other : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyqdaSeries::sub(self : MlclassifyqdaSeries, other : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyqdaSeries::normalize(self : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyqdaSeries::cumsum(self : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyqdaSeries::to_string(self : MlclassifyqdaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyqdaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_qda_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyqdaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_qda_matrix_identity(n : Int) -> MlclassifyqdaMatrix {
  let m = ml_classify_qda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyqdaMatrix::get(self : MlclassifyqdaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyqdaMatrix::transpose(self : MlclassifyqdaMatrix) -> MlclassifyqdaMatrix {
  let result = ml_classify_qda_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyqdaMatrix::add(self : MlclassifyqdaMatrix, other : MlclassifyqdaMatrix) -> MlclassifyqdaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_qda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyqdaMatrix::scale(self : MlclassifyqdaMatrix, s : Double) -> MlclassifyqdaMatrix {
  let result = ml_classify_qda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyqdaMatrix::multiply(self : MlclassifyqdaMatrix, other : MlclassifyqdaMatrix) -> MlclassifyqdaMatrix {
  if self.cols != other.rows { return ml_classify_qda_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_qda_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyqdaMatrix::trace(self : MlclassifyqdaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyqdaMatrix::det(self : MlclassifyqdaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyqdaMatrix::norm(self : MlclassifyqdaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyqdaMatrix::to_string(self : MlclassifyqdaMatrix) -> String {
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

pub(all) struct MlclassifyqdaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_qda_make_vector(comps : Array[Double]) -> MlclassifyqdaVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_qda_vector_zero(dim : Int) -> MlclassifyqdaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyqdaVector::add(self : MlclassifyqdaVector, other : MlclassifyqdaVector) -> MlclassifyqdaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyqdaVector::sub(self : MlclassifyqdaVector, other : MlclassifyqdaVector) -> MlclassifyqdaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyqdaVector::scale(self : MlclassifyqdaVector, s : Double) -> MlclassifyqdaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyqdaVector::dot(self : MlclassifyqdaVector, other : MlclassifyqdaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyqdaVector::norm(self : MlclassifyqdaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyqdaVector::normalize(self : MlclassifyqdaVector) -> MlclassifyqdaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyqdaVector::dist(self : MlclassifyqdaVector, other : MlclassifyqdaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyqdaVector::to_string(self : MlclassifyqdaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_qda_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_qda_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_qda_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_qda_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_qda_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_qda_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_qda_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_qda_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_qda_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_qda_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_qda_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_qda_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_qda_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_qda_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_qda_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_qda_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_qda_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_qda_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_qda_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_qda_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_qda_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_qda_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_qda_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_qda_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_qda_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_qda_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_qda_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_qda_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_qda_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyqdaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_frame_make(size : Int) -> MlclassifyqdaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaFrame::len(self : MlclassifyqdaFrame) -> Int { self.size }

pub fn MlclassifyqdaFrame::get(self : MlclassifyqdaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaFrame::set(self : MlclassifyqdaFrame, i : Int, v : Double) -> MlclassifyqdaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaFrame::sum(self : MlclassifyqdaFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaFrame::mean(self : MlclassifyqdaFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaFrame::scale(self : MlclassifyqdaFrame, f : Double) -> MlclassifyqdaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaFrame::add(self : MlclassifyqdaFrame, other : MlclassifyqdaFrame) -> MlclassifyqdaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaFrame::copy(self : MlclassifyqdaFrame) -> MlclassifyqdaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaFrame::fill(self : MlclassifyqdaFrame, v : Double) -> MlclassifyqdaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaFrame::min(self : MlclassifyqdaFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaFrame::max(self : MlclassifyqdaFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaFrame::to_string(self : MlclassifyqdaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_table_make(size : Int) -> MlclassifyqdaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaTable::len(self : MlclassifyqdaTable) -> Int { self.size }

pub fn MlclassifyqdaTable::get(self : MlclassifyqdaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaTable::set(self : MlclassifyqdaTable, i : Int, v : Double) -> MlclassifyqdaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaTable::sum(self : MlclassifyqdaTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaTable::mean(self : MlclassifyqdaTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaTable::scale(self : MlclassifyqdaTable, f : Double) -> MlclassifyqdaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaTable::add(self : MlclassifyqdaTable, other : MlclassifyqdaTable) -> MlclassifyqdaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaTable::copy(self : MlclassifyqdaTable) -> MlclassifyqdaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaTable::fill(self : MlclassifyqdaTable, v : Double) -> MlclassifyqdaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaTable::min(self : MlclassifyqdaTable) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaTable::max(self : MlclassifyqdaTable) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaTable::to_string(self : MlclassifyqdaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_graphn_make(size : Int) -> MlclassifyqdaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaGraphN::len(self : MlclassifyqdaGraphN) -> Int { self.size }

pub fn MlclassifyqdaGraphN::get(self : MlclassifyqdaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaGraphN::set(self : MlclassifyqdaGraphN, i : Int, v : Double) -> MlclassifyqdaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaGraphN::sum(self : MlclassifyqdaGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaGraphN::mean(self : MlclassifyqdaGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaGraphN::scale(self : MlclassifyqdaGraphN, f : Double) -> MlclassifyqdaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaGraphN::add(self : MlclassifyqdaGraphN, other : MlclassifyqdaGraphN) -> MlclassifyqdaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaGraphN::copy(self : MlclassifyqdaGraphN) -> MlclassifyqdaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaGraphN::fill(self : MlclassifyqdaGraphN, v : Double) -> MlclassifyqdaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaGraphN::min(self : MlclassifyqdaGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaGraphN::max(self : MlclassifyqdaGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaGraphN::to_string(self : MlclassifyqdaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_node_make(size : Int) -> MlclassifyqdaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaNode::len(self : MlclassifyqdaNode) -> Int { self.size }

pub fn MlclassifyqdaNode::get(self : MlclassifyqdaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaNode::set(self : MlclassifyqdaNode, i : Int, v : Double) -> MlclassifyqdaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaNode::sum(self : MlclassifyqdaNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaNode::mean(self : MlclassifyqdaNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaNode::scale(self : MlclassifyqdaNode, f : Double) -> MlclassifyqdaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaNode::add(self : MlclassifyqdaNode, other : MlclassifyqdaNode) -> MlclassifyqdaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaNode::copy(self : MlclassifyqdaNode) -> MlclassifyqdaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaNode::fill(self : MlclassifyqdaNode, v : Double) -> MlclassifyqdaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaNode::min(self : MlclassifyqdaNode) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaNode::max(self : MlclassifyqdaNode) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaNode::to_string(self : MlclassifyqdaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_edge_make(size : Int) -> MlclassifyqdaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaEdge::len(self : MlclassifyqdaEdge) -> Int { self.size }

pub fn MlclassifyqdaEdge::get(self : MlclassifyqdaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaEdge::set(self : MlclassifyqdaEdge, i : Int, v : Double) -> MlclassifyqdaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaEdge::sum(self : MlclassifyqdaEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaEdge::mean(self : MlclassifyqdaEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaEdge::scale(self : MlclassifyqdaEdge, f : Double) -> MlclassifyqdaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaEdge::add(self : MlclassifyqdaEdge, other : MlclassifyqdaEdge) -> MlclassifyqdaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaEdge::copy(self : MlclassifyqdaEdge) -> MlclassifyqdaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaEdge::fill(self : MlclassifyqdaEdge, v : Double) -> MlclassifyqdaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaEdge::min(self : MlclassifyqdaEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaEdge::max(self : MlclassifyqdaEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaEdge::to_string(self : MlclassifyqdaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_path_make(size : Int) -> MlclassifyqdaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaPath::len(self : MlclassifyqdaPath) -> Int { self.size }

pub fn MlclassifyqdaPath::get(self : MlclassifyqdaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaPath::set(self : MlclassifyqdaPath, i : Int, v : Double) -> MlclassifyqdaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaPath::sum(self : MlclassifyqdaPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaPath::mean(self : MlclassifyqdaPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaPath::scale(self : MlclassifyqdaPath, f : Double) -> MlclassifyqdaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaPath::add(self : MlclassifyqdaPath, other : MlclassifyqdaPath) -> MlclassifyqdaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaPath::copy(self : MlclassifyqdaPath) -> MlclassifyqdaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaPath::fill(self : MlclassifyqdaPath, v : Double) -> MlclassifyqdaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaPath::min(self : MlclassifyqdaPath) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaPath::max(self : MlclassifyqdaPath) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaPath::to_string(self : MlclassifyqdaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_cluster_make(size : Int) -> MlclassifyqdaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaCluster::len(self : MlclassifyqdaCluster) -> Int { self.size }

pub fn MlclassifyqdaCluster::get(self : MlclassifyqdaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaCluster::set(self : MlclassifyqdaCluster, i : Int, v : Double) -> MlclassifyqdaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCluster::sum(self : MlclassifyqdaCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaCluster::mean(self : MlclassifyqdaCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaCluster::scale(self : MlclassifyqdaCluster, f : Double) -> MlclassifyqdaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCluster::add(self : MlclassifyqdaCluster, other : MlclassifyqdaCluster) -> MlclassifyqdaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaCluster::copy(self : MlclassifyqdaCluster) -> MlclassifyqdaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCluster::fill(self : MlclassifyqdaCluster, v : Double) -> MlclassifyqdaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCluster::min(self : MlclassifyqdaCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaCluster::max(self : MlclassifyqdaCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaCluster::to_string(self : MlclassifyqdaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_model_make(size : Int) -> MlclassifyqdaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaModel::len(self : MlclassifyqdaModel) -> Int { self.size }

pub fn MlclassifyqdaModel::get(self : MlclassifyqdaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaModel::set(self : MlclassifyqdaModel, i : Int, v : Double) -> MlclassifyqdaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaModel::sum(self : MlclassifyqdaModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaModel::mean(self : MlclassifyqdaModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaModel::scale(self : MlclassifyqdaModel, f : Double) -> MlclassifyqdaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaModel::add(self : MlclassifyqdaModel, other : MlclassifyqdaModel) -> MlclassifyqdaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaModel::copy(self : MlclassifyqdaModel) -> MlclassifyqdaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaModel::fill(self : MlclassifyqdaModel, v : Double) -> MlclassifyqdaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaModel::min(self : MlclassifyqdaModel) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaModel::max(self : MlclassifyqdaModel) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaModel::to_string(self : MlclassifyqdaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_layer_make(size : Int) -> MlclassifyqdaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaLayer::len(self : MlclassifyqdaLayer) -> Int { self.size }

pub fn MlclassifyqdaLayer::get(self : MlclassifyqdaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaLayer::set(self : MlclassifyqdaLayer, i : Int, v : Double) -> MlclassifyqdaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaLayer::sum(self : MlclassifyqdaLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaLayer::mean(self : MlclassifyqdaLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaLayer::scale(self : MlclassifyqdaLayer, f : Double) -> MlclassifyqdaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaLayer::add(self : MlclassifyqdaLayer, other : MlclassifyqdaLayer) -> MlclassifyqdaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaLayer::copy(self : MlclassifyqdaLayer) -> MlclassifyqdaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaLayer::fill(self : MlclassifyqdaLayer, v : Double) -> MlclassifyqdaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaLayer::min(self : MlclassifyqdaLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaLayer::max(self : MlclassifyqdaLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaLayer::to_string(self : MlclassifyqdaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_buffer_make(size : Int) -> MlclassifyqdaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaBuffer::len(self : MlclassifyqdaBuffer) -> Int { self.size }

pub fn MlclassifyqdaBuffer::get(self : MlclassifyqdaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaBuffer::set(self : MlclassifyqdaBuffer, i : Int, v : Double) -> MlclassifyqdaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaBuffer::sum(self : MlclassifyqdaBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaBuffer::mean(self : MlclassifyqdaBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaBuffer::scale(self : MlclassifyqdaBuffer, f : Double) -> MlclassifyqdaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaBuffer::add(self : MlclassifyqdaBuffer, other : MlclassifyqdaBuffer) -> MlclassifyqdaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaBuffer::copy(self : MlclassifyqdaBuffer) -> MlclassifyqdaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaBuffer::fill(self : MlclassifyqdaBuffer, v : Double) -> MlclassifyqdaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaBuffer::min(self : MlclassifyqdaBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaBuffer::max(self : MlclassifyqdaBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaBuffer::to_string(self : MlclassifyqdaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_cursor_make(size : Int) -> MlclassifyqdaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaCursor::len(self : MlclassifyqdaCursor) -> Int { self.size }

pub fn MlclassifyqdaCursor::get(self : MlclassifyqdaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaCursor::set(self : MlclassifyqdaCursor, i : Int, v : Double) -> MlclassifyqdaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCursor::sum(self : MlclassifyqdaCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaCursor::mean(self : MlclassifyqdaCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaCursor::scale(self : MlclassifyqdaCursor, f : Double) -> MlclassifyqdaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCursor::add(self : MlclassifyqdaCursor, other : MlclassifyqdaCursor) -> MlclassifyqdaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaCursor::copy(self : MlclassifyqdaCursor) -> MlclassifyqdaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCursor::fill(self : MlclassifyqdaCursor, v : Double) -> MlclassifyqdaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaCursor::min(self : MlclassifyqdaCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaCursor::max(self : MlclassifyqdaCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaCursor::to_string(self : MlclassifyqdaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_view_make(size : Int) -> MlclassifyqdaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaView::len(self : MlclassifyqdaView) -> Int { self.size }

pub fn MlclassifyqdaView::get(self : MlclassifyqdaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaView::set(self : MlclassifyqdaView, i : Int, v : Double) -> MlclassifyqdaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaView::sum(self : MlclassifyqdaView) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaView::mean(self : MlclassifyqdaView) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaView::scale(self : MlclassifyqdaView, f : Double) -> MlclassifyqdaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaView::add(self : MlclassifyqdaView, other : MlclassifyqdaView) -> MlclassifyqdaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaView::copy(self : MlclassifyqdaView) -> MlclassifyqdaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaView::fill(self : MlclassifyqdaView, v : Double) -> MlclassifyqdaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaView::min(self : MlclassifyqdaView) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaView::max(self : MlclassifyqdaView) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaView::to_string(self : MlclassifyqdaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_range_make(size : Int) -> MlclassifyqdaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaRange::len(self : MlclassifyqdaRange) -> Int { self.size }

pub fn MlclassifyqdaRange::get(self : MlclassifyqdaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaRange::set(self : MlclassifyqdaRange, i : Int, v : Double) -> MlclassifyqdaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaRange::sum(self : MlclassifyqdaRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaRange::mean(self : MlclassifyqdaRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaRange::scale(self : MlclassifyqdaRange, f : Double) -> MlclassifyqdaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaRange::add(self : MlclassifyqdaRange, other : MlclassifyqdaRange) -> MlclassifyqdaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaRange::copy(self : MlclassifyqdaRange) -> MlclassifyqdaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaRange::fill(self : MlclassifyqdaRange, v : Double) -> MlclassifyqdaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaRange::min(self : MlclassifyqdaRange) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaRange::max(self : MlclassifyqdaRange) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaRange::to_string(self : MlclassifyqdaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_slice_make(size : Int) -> MlclassifyqdaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyqdaSlice::len(self : MlclassifyqdaSlice) -> Int { self.size }

pub fn MlclassifyqdaSlice::get(self : MlclassifyqdaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyqdaSlice::set(self : MlclassifyqdaSlice, i : Int, v : Double) -> MlclassifyqdaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaSlice::sum(self : MlclassifyqdaSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifyqdaSlice::mean(self : MlclassifyqdaSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifyqdaSlice::scale(self : MlclassifyqdaSlice, f : Double) -> MlclassifyqdaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaSlice::add(self : MlclassifyqdaSlice, other : MlclassifyqdaSlice) -> MlclassifyqdaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyqdaSlice::copy(self : MlclassifyqdaSlice) -> MlclassifyqdaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaSlice::fill(self : MlclassifyqdaSlice, v : Double) -> MlclassifyqdaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyqdaSlice::min(self : MlclassifyqdaSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifyqdaSlice::max(self : MlclassifyqdaSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifyqdaSlice::to_string(self : MlclassifyqdaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

