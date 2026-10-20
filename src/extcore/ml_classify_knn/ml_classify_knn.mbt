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

pub fn ml_classify_knn_frame_len(s : MlclassifyknnFrame) -> Int { s.size }

pub fn ml_classify_knn_frame_get(s : MlclassifyknnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_frame_set(s : MlclassifyknnFrame, i : Int, v : Double) -> MlclassifyknnFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_frame_sum(s : MlclassifyknnFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_frame_mean(s : MlclassifyknnFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_frame_scale(s : MlclassifyknnFrame, f : Double) -> MlclassifyknnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_frame_add(a : MlclassifyknnFrame, b : MlclassifyknnFrame) -> MlclassifyknnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_frame_copy(s : MlclassifyknnFrame) -> MlclassifyknnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_frame_fill(s : MlclassifyknnFrame, v : Double) -> MlclassifyknnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_frame_min(s : MlclassifyknnFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_frame_max(s : MlclassifyknnFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_frame_to_string(s : MlclassifyknnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_table_make(size : Int) -> MlclassifyknnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_table_len(s : MlclassifyknnTable) -> Int { s.size }

pub fn ml_classify_knn_table_get(s : MlclassifyknnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_table_set(s : MlclassifyknnTable, i : Int, v : Double) -> MlclassifyknnTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_table_sum(s : MlclassifyknnTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_table_mean(s : MlclassifyknnTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_table_scale(s : MlclassifyknnTable, f : Double) -> MlclassifyknnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_table_add(a : MlclassifyknnTable, b : MlclassifyknnTable) -> MlclassifyknnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_table_copy(s : MlclassifyknnTable) -> MlclassifyknnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_table_fill(s : MlclassifyknnTable, v : Double) -> MlclassifyknnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_table_min(s : MlclassifyknnTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_table_max(s : MlclassifyknnTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_table_to_string(s : MlclassifyknnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_graphn_make(size : Int) -> MlclassifyknnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_graphn_len(s : MlclassifyknnGraphN) -> Int { s.size }

pub fn ml_classify_knn_graphn_get(s : MlclassifyknnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_graphn_set(s : MlclassifyknnGraphN, i : Int, v : Double) -> MlclassifyknnGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_graphn_sum(s : MlclassifyknnGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_graphn_mean(s : MlclassifyknnGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_graphn_scale(s : MlclassifyknnGraphN, f : Double) -> MlclassifyknnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_graphn_add(a : MlclassifyknnGraphN, b : MlclassifyknnGraphN) -> MlclassifyknnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_graphn_copy(s : MlclassifyknnGraphN) -> MlclassifyknnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_graphn_fill(s : MlclassifyknnGraphN, v : Double) -> MlclassifyknnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_graphn_min(s : MlclassifyknnGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_graphn_max(s : MlclassifyknnGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_graphn_to_string(s : MlclassifyknnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_node_make(size : Int) -> MlclassifyknnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_node_len(s : MlclassifyknnNode) -> Int { s.size }

pub fn ml_classify_knn_node_get(s : MlclassifyknnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_node_set(s : MlclassifyknnNode, i : Int, v : Double) -> MlclassifyknnNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_node_sum(s : MlclassifyknnNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_node_mean(s : MlclassifyknnNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_node_scale(s : MlclassifyknnNode, f : Double) -> MlclassifyknnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_node_add(a : MlclassifyknnNode, b : MlclassifyknnNode) -> MlclassifyknnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_node_copy(s : MlclassifyknnNode) -> MlclassifyknnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_node_fill(s : MlclassifyknnNode, v : Double) -> MlclassifyknnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_node_min(s : MlclassifyknnNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_node_max(s : MlclassifyknnNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_node_to_string(s : MlclassifyknnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_edge_make(size : Int) -> MlclassifyknnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_edge_len(s : MlclassifyknnEdge) -> Int { s.size }

pub fn ml_classify_knn_edge_get(s : MlclassifyknnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_edge_set(s : MlclassifyknnEdge, i : Int, v : Double) -> MlclassifyknnEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_edge_sum(s : MlclassifyknnEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_edge_mean(s : MlclassifyknnEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_edge_scale(s : MlclassifyknnEdge, f : Double) -> MlclassifyknnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_edge_add(a : MlclassifyknnEdge, b : MlclassifyknnEdge) -> MlclassifyknnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_edge_copy(s : MlclassifyknnEdge) -> MlclassifyknnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_edge_fill(s : MlclassifyknnEdge, v : Double) -> MlclassifyknnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_edge_min(s : MlclassifyknnEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_edge_max(s : MlclassifyknnEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_edge_to_string(s : MlclassifyknnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_path_make(size : Int) -> MlclassifyknnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_path_len(s : MlclassifyknnPath) -> Int { s.size }

pub fn ml_classify_knn_path_get(s : MlclassifyknnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_path_set(s : MlclassifyknnPath, i : Int, v : Double) -> MlclassifyknnPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_path_sum(s : MlclassifyknnPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_path_mean(s : MlclassifyknnPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_path_scale(s : MlclassifyknnPath, f : Double) -> MlclassifyknnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_path_add(a : MlclassifyknnPath, b : MlclassifyknnPath) -> MlclassifyknnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_path_copy(s : MlclassifyknnPath) -> MlclassifyknnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_path_fill(s : MlclassifyknnPath, v : Double) -> MlclassifyknnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_path_min(s : MlclassifyknnPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_path_max(s : MlclassifyknnPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_path_to_string(s : MlclassifyknnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_cluster_make(size : Int) -> MlclassifyknnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_cluster_len(s : MlclassifyknnCluster) -> Int { s.size }

pub fn ml_classify_knn_cluster_get(s : MlclassifyknnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_cluster_set(s : MlclassifyknnCluster, i : Int, v : Double) -> MlclassifyknnCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cluster_sum(s : MlclassifyknnCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_cluster_mean(s : MlclassifyknnCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_cluster_scale(s : MlclassifyknnCluster, f : Double) -> MlclassifyknnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cluster_add(a : MlclassifyknnCluster, b : MlclassifyknnCluster) -> MlclassifyknnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_cluster_copy(s : MlclassifyknnCluster) -> MlclassifyknnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cluster_fill(s : MlclassifyknnCluster, v : Double) -> MlclassifyknnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cluster_min(s : MlclassifyknnCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_cluster_max(s : MlclassifyknnCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_cluster_to_string(s : MlclassifyknnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_model_make(size : Int) -> MlclassifyknnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_model_len(s : MlclassifyknnModel) -> Int { s.size }

pub fn ml_classify_knn_model_get(s : MlclassifyknnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_model_set(s : MlclassifyknnModel, i : Int, v : Double) -> MlclassifyknnModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_model_sum(s : MlclassifyknnModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_model_mean(s : MlclassifyknnModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_model_scale(s : MlclassifyknnModel, f : Double) -> MlclassifyknnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_model_add(a : MlclassifyknnModel, b : MlclassifyknnModel) -> MlclassifyknnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_model_copy(s : MlclassifyknnModel) -> MlclassifyknnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_model_fill(s : MlclassifyknnModel, v : Double) -> MlclassifyknnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_model_min(s : MlclassifyknnModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_model_max(s : MlclassifyknnModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_model_to_string(s : MlclassifyknnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_layer_make(size : Int) -> MlclassifyknnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_layer_len(s : MlclassifyknnLayer) -> Int { s.size }

pub fn ml_classify_knn_layer_get(s : MlclassifyknnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_layer_set(s : MlclassifyknnLayer, i : Int, v : Double) -> MlclassifyknnLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_layer_sum(s : MlclassifyknnLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_layer_mean(s : MlclassifyknnLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_layer_scale(s : MlclassifyknnLayer, f : Double) -> MlclassifyknnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_layer_add(a : MlclassifyknnLayer, b : MlclassifyknnLayer) -> MlclassifyknnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_layer_copy(s : MlclassifyknnLayer) -> MlclassifyknnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_layer_fill(s : MlclassifyknnLayer, v : Double) -> MlclassifyknnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_layer_min(s : MlclassifyknnLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_layer_max(s : MlclassifyknnLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_layer_to_string(s : MlclassifyknnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_buffer_make(size : Int) -> MlclassifyknnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_buffer_len(s : MlclassifyknnBuffer) -> Int { s.size }

pub fn ml_classify_knn_buffer_get(s : MlclassifyknnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_buffer_set(s : MlclassifyknnBuffer, i : Int, v : Double) -> MlclassifyknnBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_buffer_sum(s : MlclassifyknnBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_buffer_mean(s : MlclassifyknnBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_buffer_scale(s : MlclassifyknnBuffer, f : Double) -> MlclassifyknnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_buffer_add(a : MlclassifyknnBuffer, b : MlclassifyknnBuffer) -> MlclassifyknnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_buffer_copy(s : MlclassifyknnBuffer) -> MlclassifyknnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_buffer_fill(s : MlclassifyknnBuffer, v : Double) -> MlclassifyknnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_buffer_min(s : MlclassifyknnBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_buffer_max(s : MlclassifyknnBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_buffer_to_string(s : MlclassifyknnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_cursor_make(size : Int) -> MlclassifyknnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_cursor_len(s : MlclassifyknnCursor) -> Int { s.size }

pub fn ml_classify_knn_cursor_get(s : MlclassifyknnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_cursor_set(s : MlclassifyknnCursor, i : Int, v : Double) -> MlclassifyknnCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cursor_sum(s : MlclassifyknnCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_cursor_mean(s : MlclassifyknnCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_cursor_scale(s : MlclassifyknnCursor, f : Double) -> MlclassifyknnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cursor_add(a : MlclassifyknnCursor, b : MlclassifyknnCursor) -> MlclassifyknnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_cursor_copy(s : MlclassifyknnCursor) -> MlclassifyknnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cursor_fill(s : MlclassifyknnCursor, v : Double) -> MlclassifyknnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_cursor_min(s : MlclassifyknnCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_cursor_max(s : MlclassifyknnCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_cursor_to_string(s : MlclassifyknnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_view_make(size : Int) -> MlclassifyknnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_view_len(s : MlclassifyknnView) -> Int { s.size }

pub fn ml_classify_knn_view_get(s : MlclassifyknnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_view_set(s : MlclassifyknnView, i : Int, v : Double) -> MlclassifyknnView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_view_sum(s : MlclassifyknnView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_view_mean(s : MlclassifyknnView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_view_scale(s : MlclassifyknnView, f : Double) -> MlclassifyknnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_view_add(a : MlclassifyknnView, b : MlclassifyknnView) -> MlclassifyknnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_view_copy(s : MlclassifyknnView) -> MlclassifyknnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_view_fill(s : MlclassifyknnView, v : Double) -> MlclassifyknnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_view_min(s : MlclassifyknnView) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_view_max(s : MlclassifyknnView) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_view_to_string(s : MlclassifyknnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_range_make(size : Int) -> MlclassifyknnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_range_len(s : MlclassifyknnRange) -> Int { s.size }

pub fn ml_classify_knn_range_get(s : MlclassifyknnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_range_set(s : MlclassifyknnRange, i : Int, v : Double) -> MlclassifyknnRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_range_sum(s : MlclassifyknnRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_range_mean(s : MlclassifyknnRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_range_scale(s : MlclassifyknnRange, f : Double) -> MlclassifyknnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_range_add(a : MlclassifyknnRange, b : MlclassifyknnRange) -> MlclassifyknnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_range_copy(s : MlclassifyknnRange) -> MlclassifyknnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_range_fill(s : MlclassifyknnRange, v : Double) -> MlclassifyknnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_range_min(s : MlclassifyknnRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_range_max(s : MlclassifyknnRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_range_to_string(s : MlclassifyknnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_slice_make(size : Int) -> MlclassifyknnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_slice_len(s : MlclassifyknnSlice) -> Int { s.size }

pub fn ml_classify_knn_slice_get(s : MlclassifyknnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_slice_set(s : MlclassifyknnSlice, i : Int, v : Double) -> MlclassifyknnSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_slice_sum(s : MlclassifyknnSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_knn_slice_mean(s : MlclassifyknnSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_knn_slice_scale(s : MlclassifyknnSlice, f : Double) -> MlclassifyknnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_slice_add(a : MlclassifyknnSlice, b : MlclassifyknnSlice) -> MlclassifyknnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_knn_slice_copy(s : MlclassifyknnSlice) -> MlclassifyknnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_slice_fill(s : MlclassifyknnSlice, v : Double) -> MlclassifyknnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_knn_slice_min(s : MlclassifyknnSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_knn_slice_max(s : MlclassifyknnSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_knn_slice_to_string(s : MlclassifyknnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

