///===
/// extcore/ml_classify_knn

pub(all) struct MlclassifyknnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_knn_make_point(x : Double, y : Double) -> MlclassifyknnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_knn_make_point3(x : Double, y : Double, z : Double) -> MlclassifyknnPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyknnPoint::x(self : MlclassifyknnPoint) -> Double { self.x }

pub fn MlclassifyknnPoint::y(self : MlclassifyknnPoint) -> Double { self.y }

pub fn MlclassifyknnPoint::z(self : MlclassifyknnPoint) -> Double { self.z }

pub fn MlclassifyknnPoint::label(self : MlclassifyknnPoint) -> Int { self.label }

pub fn MlclassifyknnPoint::dist(self : MlclassifyknnPoint, other : MlclassifyknnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyknnPoint::add(self : MlclassifyknnPoint, other : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyknnPoint::sub(self : MlclassifyknnPoint, other : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyknnPoint::scale(self : MlclassifyknnPoint, s : Double) -> MlclassifyknnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyknnPoint::dot(self : MlclassifyknnPoint, other : MlclassifyknnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyknnPoint::cross(self : MlclassifyknnPoint, other : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyknnPoint::norm(self : MlclassifyknnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyknnPoint::normalize(self : MlclassifyknnPoint) -> MlclassifyknnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyknnPoint::negate(self : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyknnPoint::mid(self : MlclassifyknnPoint, other : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyknnPoint::lerp(self : MlclassifyknnPoint, other : MlclassifyknnPoint, t : Double) -> MlclassifyknnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyknnPoint::to_string(self : MlclassifyknnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyknnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_knn_make_series(vals : Array[Double], name : String) -> MlclassifyknnSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyknnSeries::len(self : MlclassifyknnSeries) -> Int { self.vals.length() }

pub fn MlclassifyknnSeries::sum(self : MlclassifyknnSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyknnSeries::mean(self : MlclassifyknnSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyknnSeries::min(self : MlclassifyknnSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyknnSeries::max(self : MlclassifyknnSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyknnSeries::range(self : MlclassifyknnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyknnSeries::variance(self : MlclassifyknnSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyknnSeries::std(self : MlclassifyknnSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyknnSeries::median(self : MlclassifyknnSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyknnSeries::scale(self : MlclassifyknnSeries, f : Double) -> MlclassifyknnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyknnSeries::add(self : MlclassifyknnSeries, other : MlclassifyknnSeries) -> MlclassifyknnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyknnSeries::sub(self : MlclassifyknnSeries, other : MlclassifyknnSeries) -> MlclassifyknnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyknnSeries::normalize(self : MlclassifyknnSeries) -> MlclassifyknnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyknnSeries::cumsum(self : MlclassifyknnSeries) -> MlclassifyknnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyknnSeries::to_string(self : MlclassifyknnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyknnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_knn_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyknnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_knn_matrix_identity(n : Int) -> MlclassifyknnMatrix {
  let m = ml_classify_knn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyknnMatrix::get(self : MlclassifyknnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyknnMatrix::transpose(self : MlclassifyknnMatrix) -> MlclassifyknnMatrix {
  let result = ml_classify_knn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyknnMatrix::add(self : MlclassifyknnMatrix, other : MlclassifyknnMatrix) -> MlclassifyknnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_knn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyknnMatrix::scale(self : MlclassifyknnMatrix, s : Double) -> MlclassifyknnMatrix {
  let result = ml_classify_knn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyknnMatrix::multiply(self : MlclassifyknnMatrix, other : MlclassifyknnMatrix) -> MlclassifyknnMatrix {
  if self.cols != other.rows { return ml_classify_knn_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_knn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyknnMatrix::trace(self : MlclassifyknnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyknnMatrix::det(self : MlclassifyknnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyknnMatrix::norm(self : MlclassifyknnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyknnMatrix::to_string(self : MlclassifyknnMatrix) -> String {
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

pub(all) struct MlclassifyknnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_knn_make_vector(comps : Array[Double]) -> MlclassifyknnVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_knn_vector_zero(dim : Int) -> MlclassifyknnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyknnVector::add(self : MlclassifyknnVector, other : MlclassifyknnVector) -> MlclassifyknnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyknnVector::sub(self : MlclassifyknnVector, other : MlclassifyknnVector) -> MlclassifyknnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyknnVector::scale(self : MlclassifyknnVector, s : Double) -> MlclassifyknnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyknnVector::dot(self : MlclassifyknnVector, other : MlclassifyknnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyknnVector::norm(self : MlclassifyknnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyknnVector::normalize(self : MlclassifyknnVector) -> MlclassifyknnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyknnVector::dist(self : MlclassifyknnVector, other : MlclassifyknnVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyknnVector::to_string(self : MlclassifyknnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_knn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_knn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_knn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_knn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_knn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_knn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_knn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_knn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_knn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_knn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_knn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_knn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_knn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_knn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_knn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_knn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_knn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_knn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_knn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_knn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_knn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_knn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_knn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_knn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_knn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_knn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_knn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_knn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_knn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyknnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_frame_make(size : Int) -> MlclassifyknnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnFrame::len(self : MlclassifyknnFrame) -> Int { self.size }

pub fn MlclassifyknnFrame::get(self : MlclassifyknnFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnFrame::set(self : MlclassifyknnFrame, i : Int, v : Double) -> MlclassifyknnFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnFrame::sum(self : MlclassifyknnFrame) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnFrame::mean(self : MlclassifyknnFrame) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnFrame::scale(self : MlclassifyknnFrame, f : Double) -> MlclassifyknnFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnFrame::add(self : MlclassifyknnFrame, other : MlclassifyknnFrame) -> MlclassifyknnFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnFrame::copy(self : MlclassifyknnFrame) -> MlclassifyknnFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnFrame::fill(self : MlclassifyknnFrame, v : Double) -> MlclassifyknnFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnFrame::min(self : MlclassifyknnFrame) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnFrame::max(self : MlclassifyknnFrame) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnFrame::to_string(self : MlclassifyknnFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_table_make(size : Int) -> MlclassifyknnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnTable::len(self : MlclassifyknnTable) -> Int { self.size }

pub fn MlclassifyknnTable::get(self : MlclassifyknnTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnTable::set(self : MlclassifyknnTable, i : Int, v : Double) -> MlclassifyknnTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnTable::sum(self : MlclassifyknnTable) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnTable::mean(self : MlclassifyknnTable) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnTable::scale(self : MlclassifyknnTable, f : Double) -> MlclassifyknnTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnTable::add(self : MlclassifyknnTable, other : MlclassifyknnTable) -> MlclassifyknnTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnTable::copy(self : MlclassifyknnTable) -> MlclassifyknnTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnTable::fill(self : MlclassifyknnTable, v : Double) -> MlclassifyknnTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnTable::min(self : MlclassifyknnTable) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnTable::max(self : MlclassifyknnTable) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnTable::to_string(self : MlclassifyknnTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_graphn_make(size : Int) -> MlclassifyknnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnGraphN::len(self : MlclassifyknnGraphN) -> Int { self.size }

pub fn MlclassifyknnGraphN::get(self : MlclassifyknnGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnGraphN::set(self : MlclassifyknnGraphN, i : Int, v : Double) -> MlclassifyknnGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnGraphN::sum(self : MlclassifyknnGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnGraphN::mean(self : MlclassifyknnGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnGraphN::scale(self : MlclassifyknnGraphN, f : Double) -> MlclassifyknnGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnGraphN::add(self : MlclassifyknnGraphN, other : MlclassifyknnGraphN) -> MlclassifyknnGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnGraphN::copy(self : MlclassifyknnGraphN) -> MlclassifyknnGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnGraphN::fill(self : MlclassifyknnGraphN, v : Double) -> MlclassifyknnGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnGraphN::min(self : MlclassifyknnGraphN) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnGraphN::max(self : MlclassifyknnGraphN) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnGraphN::to_string(self : MlclassifyknnGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_node_make(size : Int) -> MlclassifyknnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnNode::len(self : MlclassifyknnNode) -> Int { self.size }

pub fn MlclassifyknnNode::get(self : MlclassifyknnNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnNode::set(self : MlclassifyknnNode, i : Int, v : Double) -> MlclassifyknnNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnNode::sum(self : MlclassifyknnNode) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnNode::mean(self : MlclassifyknnNode) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnNode::scale(self : MlclassifyknnNode, f : Double) -> MlclassifyknnNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnNode::add(self : MlclassifyknnNode, other : MlclassifyknnNode) -> MlclassifyknnNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnNode::copy(self : MlclassifyknnNode) -> MlclassifyknnNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnNode::fill(self : MlclassifyknnNode, v : Double) -> MlclassifyknnNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnNode::min(self : MlclassifyknnNode) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnNode::max(self : MlclassifyknnNode) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnNode::to_string(self : MlclassifyknnNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_edge_make(size : Int) -> MlclassifyknnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnEdge::len(self : MlclassifyknnEdge) -> Int { self.size }

pub fn MlclassifyknnEdge::get(self : MlclassifyknnEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnEdge::set(self : MlclassifyknnEdge, i : Int, v : Double) -> MlclassifyknnEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnEdge::sum(self : MlclassifyknnEdge) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnEdge::mean(self : MlclassifyknnEdge) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnEdge::scale(self : MlclassifyknnEdge, f : Double) -> MlclassifyknnEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnEdge::add(self : MlclassifyknnEdge, other : MlclassifyknnEdge) -> MlclassifyknnEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnEdge::copy(self : MlclassifyknnEdge) -> MlclassifyknnEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnEdge::fill(self : MlclassifyknnEdge, v : Double) -> MlclassifyknnEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnEdge::min(self : MlclassifyknnEdge) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnEdge::max(self : MlclassifyknnEdge) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnEdge::to_string(self : MlclassifyknnEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_path_make(size : Int) -> MlclassifyknnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnPath::len(self : MlclassifyknnPath) -> Int { self.size }

pub fn MlclassifyknnPath::get(self : MlclassifyknnPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnPath::set(self : MlclassifyknnPath, i : Int, v : Double) -> MlclassifyknnPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnPath::sum(self : MlclassifyknnPath) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnPath::mean(self : MlclassifyknnPath) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnPath::scale(self : MlclassifyknnPath, f : Double) -> MlclassifyknnPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnPath::add(self : MlclassifyknnPath, other : MlclassifyknnPath) -> MlclassifyknnPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnPath::copy(self : MlclassifyknnPath) -> MlclassifyknnPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnPath::fill(self : MlclassifyknnPath, v : Double) -> MlclassifyknnPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnPath::min(self : MlclassifyknnPath) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnPath::max(self : MlclassifyknnPath) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnPath::to_string(self : MlclassifyknnPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_cluster_make(size : Int) -> MlclassifyknnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnCluster::len(self : MlclassifyknnCluster) -> Int { self.size }

pub fn MlclassifyknnCluster::get(self : MlclassifyknnCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnCluster::set(self : MlclassifyknnCluster, i : Int, v : Double) -> MlclassifyknnCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCluster::sum(self : MlclassifyknnCluster) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnCluster::mean(self : MlclassifyknnCluster) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnCluster::scale(self : MlclassifyknnCluster, f : Double) -> MlclassifyknnCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCluster::add(self : MlclassifyknnCluster, other : MlclassifyknnCluster) -> MlclassifyknnCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnCluster::copy(self : MlclassifyknnCluster) -> MlclassifyknnCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCluster::fill(self : MlclassifyknnCluster, v : Double) -> MlclassifyknnCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCluster::min(self : MlclassifyknnCluster) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnCluster::max(self : MlclassifyknnCluster) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnCluster::to_string(self : MlclassifyknnCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_model_make(size : Int) -> MlclassifyknnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnModel::len(self : MlclassifyknnModel) -> Int { self.size }

pub fn MlclassifyknnModel::get(self : MlclassifyknnModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnModel::set(self : MlclassifyknnModel, i : Int, v : Double) -> MlclassifyknnModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnModel::sum(self : MlclassifyknnModel) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnModel::mean(self : MlclassifyknnModel) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnModel::scale(self : MlclassifyknnModel, f : Double) -> MlclassifyknnModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnModel::add(self : MlclassifyknnModel, other : MlclassifyknnModel) -> MlclassifyknnModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnModel::copy(self : MlclassifyknnModel) -> MlclassifyknnModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnModel::fill(self : MlclassifyknnModel, v : Double) -> MlclassifyknnModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnModel::min(self : MlclassifyknnModel) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnModel::max(self : MlclassifyknnModel) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnModel::to_string(self : MlclassifyknnModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_layer_make(size : Int) -> MlclassifyknnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnLayer::len(self : MlclassifyknnLayer) -> Int { self.size }

pub fn MlclassifyknnLayer::get(self : MlclassifyknnLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnLayer::set(self : MlclassifyknnLayer, i : Int, v : Double) -> MlclassifyknnLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnLayer::sum(self : MlclassifyknnLayer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnLayer::mean(self : MlclassifyknnLayer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnLayer::scale(self : MlclassifyknnLayer, f : Double) -> MlclassifyknnLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnLayer::add(self : MlclassifyknnLayer, other : MlclassifyknnLayer) -> MlclassifyknnLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnLayer::copy(self : MlclassifyknnLayer) -> MlclassifyknnLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnLayer::fill(self : MlclassifyknnLayer, v : Double) -> MlclassifyknnLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnLayer::min(self : MlclassifyknnLayer) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnLayer::max(self : MlclassifyknnLayer) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnLayer::to_string(self : MlclassifyknnLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_buffer_make(size : Int) -> MlclassifyknnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnBuffer::len(self : MlclassifyknnBuffer) -> Int { self.size }

pub fn MlclassifyknnBuffer::get(self : MlclassifyknnBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnBuffer::set(self : MlclassifyknnBuffer, i : Int, v : Double) -> MlclassifyknnBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnBuffer::sum(self : MlclassifyknnBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnBuffer::mean(self : MlclassifyknnBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnBuffer::scale(self : MlclassifyknnBuffer, f : Double) -> MlclassifyknnBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnBuffer::add(self : MlclassifyknnBuffer, other : MlclassifyknnBuffer) -> MlclassifyknnBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnBuffer::copy(self : MlclassifyknnBuffer) -> MlclassifyknnBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnBuffer::fill(self : MlclassifyknnBuffer, v : Double) -> MlclassifyknnBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnBuffer::min(self : MlclassifyknnBuffer) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnBuffer::max(self : MlclassifyknnBuffer) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnBuffer::to_string(self : MlclassifyknnBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_cursor_make(size : Int) -> MlclassifyknnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnCursor::len(self : MlclassifyknnCursor) -> Int { self.size }

pub fn MlclassifyknnCursor::get(self : MlclassifyknnCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnCursor::set(self : MlclassifyknnCursor, i : Int, v : Double) -> MlclassifyknnCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCursor::sum(self : MlclassifyknnCursor) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnCursor::mean(self : MlclassifyknnCursor) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnCursor::scale(self : MlclassifyknnCursor, f : Double) -> MlclassifyknnCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCursor::add(self : MlclassifyknnCursor, other : MlclassifyknnCursor) -> MlclassifyknnCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnCursor::copy(self : MlclassifyknnCursor) -> MlclassifyknnCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCursor::fill(self : MlclassifyknnCursor, v : Double) -> MlclassifyknnCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnCursor::min(self : MlclassifyknnCursor) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnCursor::max(self : MlclassifyknnCursor) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnCursor::to_string(self : MlclassifyknnCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_view_make(size : Int) -> MlclassifyknnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnView::len(self : MlclassifyknnView) -> Int { self.size }

pub fn MlclassifyknnView::get(self : MlclassifyknnView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnView::set(self : MlclassifyknnView, i : Int, v : Double) -> MlclassifyknnView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnView::sum(self : MlclassifyknnView) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnView::mean(self : MlclassifyknnView) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnView::scale(self : MlclassifyknnView, f : Double) -> MlclassifyknnView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnView::add(self : MlclassifyknnView, other : MlclassifyknnView) -> MlclassifyknnView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnView::copy(self : MlclassifyknnView) -> MlclassifyknnView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnView::fill(self : MlclassifyknnView, v : Double) -> MlclassifyknnView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnView::min(self : MlclassifyknnView) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnView::max(self : MlclassifyknnView) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnView::to_string(self : MlclassifyknnView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_range_make(size : Int) -> MlclassifyknnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnRange::len(self : MlclassifyknnRange) -> Int { self.size }

pub fn MlclassifyknnRange::get(self : MlclassifyknnRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnRange::set(self : MlclassifyknnRange, i : Int, v : Double) -> MlclassifyknnRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnRange::sum(self : MlclassifyknnRange) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnRange::mean(self : MlclassifyknnRange) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnRange::scale(self : MlclassifyknnRange, f : Double) -> MlclassifyknnRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnRange::add(self : MlclassifyknnRange, other : MlclassifyknnRange) -> MlclassifyknnRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnRange::copy(self : MlclassifyknnRange) -> MlclassifyknnRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnRange::fill(self : MlclassifyknnRange, v : Double) -> MlclassifyknnRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnRange::min(self : MlclassifyknnRange) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnRange::max(self : MlclassifyknnRange) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnRange::to_string(self : MlclassifyknnRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_slice_make(size : Int) -> MlclassifyknnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclassifyknnSlice::len(self : MlclassifyknnSlice) -> Int { self.size }

pub fn MlclassifyknnSlice::get(self : MlclassifyknnSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclassifyknnSlice::set(self : MlclassifyknnSlice, i : Int, v : Double) -> MlclassifyknnSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclassifyknnSlice::sum(self : MlclassifyknnSlice) -> Double { @_common.sum(self.data) }

pub fn MlclassifyknnSlice::mean(self : MlclassifyknnSlice) -> Double { @_common.mean(self.data) }

pub fn MlclassifyknnSlice::scale(self : MlclassifyknnSlice, f : Double) -> MlclassifyknnSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnSlice::add(self : MlclassifyknnSlice, other : MlclassifyknnSlice) -> MlclassifyknnSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclassifyknnSlice::copy(self : MlclassifyknnSlice) -> MlclassifyknnSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnSlice::fill(self : MlclassifyknnSlice, v : Double) -> MlclassifyknnSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclassifyknnSlice::min(self : MlclassifyknnSlice) -> Double { @_common.min(self.data) }

pub fn MlclassifyknnSlice::max(self : MlclassifyknnSlice) -> Double { @_common.max(self.data) }

pub fn MlclassifyknnSlice::to_string(self : MlclassifyknnSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

