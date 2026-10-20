///===
/// extcore/ml_classify_perceptron

pub(all) struct MlclassifyperceptronPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_perceptron_make_point(x : Double, y : Double) -> MlclassifyperceptronPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_perceptron_make_point3(x : Double, y : Double, z : Double) -> MlclassifyperceptronPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyperceptronPoint::x(self : MlclassifyperceptronPoint) -> Double { self.x }

pub fn MlclassifyperceptronPoint::y(self : MlclassifyperceptronPoint) -> Double { self.y }

pub fn MlclassifyperceptronPoint::z(self : MlclassifyperceptronPoint) -> Double { self.z }

pub fn MlclassifyperceptronPoint::label(self : MlclassifyperceptronPoint) -> Int { self.label }

pub fn MlclassifyperceptronPoint::dist(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyperceptronPoint::add(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyperceptronPoint::sub(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyperceptronPoint::scale(self : MlclassifyperceptronPoint, s : Double) -> MlclassifyperceptronPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyperceptronPoint::dot(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyperceptronPoint::cross(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyperceptronPoint::norm(self : MlclassifyperceptronPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyperceptronPoint::normalize(self : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyperceptronPoint::negate(self : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyperceptronPoint::mid(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyperceptronPoint::lerp(self : MlclassifyperceptronPoint, other : MlclassifyperceptronPoint, t : Double) -> MlclassifyperceptronPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyperceptronPoint::to_string(self : MlclassifyperceptronPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyperceptronSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_perceptron_make_series(vals : Array[Double], name : String) -> MlclassifyperceptronSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyperceptronSeries::len(self : MlclassifyperceptronSeries) -> Int { self.vals.length() }

pub fn MlclassifyperceptronSeries::sum(self : MlclassifyperceptronSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyperceptronSeries::mean(self : MlclassifyperceptronSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyperceptronSeries::min(self : MlclassifyperceptronSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyperceptronSeries::max(self : MlclassifyperceptronSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyperceptronSeries::range(self : MlclassifyperceptronSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyperceptronSeries::variance(self : MlclassifyperceptronSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyperceptronSeries::std(self : MlclassifyperceptronSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyperceptronSeries::median(self : MlclassifyperceptronSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyperceptronSeries::scale(self : MlclassifyperceptronSeries, f : Double) -> MlclassifyperceptronSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyperceptronSeries::add(self : MlclassifyperceptronSeries, other : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyperceptronSeries::sub(self : MlclassifyperceptronSeries, other : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyperceptronSeries::normalize(self : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyperceptronSeries::cumsum(self : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyperceptronSeries::to_string(self : MlclassifyperceptronSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyperceptronMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_perceptron_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyperceptronMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_perceptron_matrix_identity(n : Int) -> MlclassifyperceptronMatrix {
  let m = ml_classify_perceptron_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyperceptronMatrix::get(self : MlclassifyperceptronMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyperceptronMatrix::transpose(self : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  let result = ml_classify_perceptron_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyperceptronMatrix::add(self : MlclassifyperceptronMatrix, other : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyperceptronMatrix::scale(self : MlclassifyperceptronMatrix, s : Double) -> MlclassifyperceptronMatrix {
  let result = ml_classify_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyperceptronMatrix::multiply(self : MlclassifyperceptronMatrix, other : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  if self.cols != other.rows { return ml_classify_perceptron_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_perceptron_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyperceptronMatrix::trace(self : MlclassifyperceptronMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyperceptronMatrix::det(self : MlclassifyperceptronMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyperceptronMatrix::norm(self : MlclassifyperceptronMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyperceptronMatrix::to_string(self : MlclassifyperceptronMatrix) -> String {
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

pub(all) struct MlclassifyperceptronVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_perceptron_make_vector(comps : Array[Double]) -> MlclassifyperceptronVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_perceptron_vector_zero(dim : Int) -> MlclassifyperceptronVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyperceptronVector::add(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyperceptronVector::sub(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyperceptronVector::scale(self : MlclassifyperceptronVector, s : Double) -> MlclassifyperceptronVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyperceptronVector::dot(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyperceptronVector::norm(self : MlclassifyperceptronVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyperceptronVector::normalize(self : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyperceptronVector::dist(self : MlclassifyperceptronVector, other : MlclassifyperceptronVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyperceptronVector::to_string(self : MlclassifyperceptronVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_perceptron_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_perceptron_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_perceptron_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_perceptron_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_perceptron_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_perceptron_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_perceptron_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_perceptron_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_perceptron_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_perceptron_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_perceptron_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_perceptron_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_perceptron_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_perceptron_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_perceptron_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_perceptron_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_perceptron_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_perceptron_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_perceptron_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_perceptron_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_perceptron_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_perceptron_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_perceptron_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_perceptron_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_perceptron_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_perceptron_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_perceptron_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_perceptron_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_perceptron_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyperceptronFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_frame_make(size : Int) -> MlclassifyperceptronFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_frame_len(s : MlclassifyperceptronFrame) -> Int { s.size }

pub fn ml_classify_perceptron_frame_get(s : MlclassifyperceptronFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_frame_set(s : MlclassifyperceptronFrame, i : Int, v : Double) -> MlclassifyperceptronFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_frame_sum(s : MlclassifyperceptronFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_frame_mean(s : MlclassifyperceptronFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_frame_scale(s : MlclassifyperceptronFrame, f : Double) -> MlclassifyperceptronFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_frame_add(a : MlclassifyperceptronFrame, b : MlclassifyperceptronFrame) -> MlclassifyperceptronFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_frame_copy(s : MlclassifyperceptronFrame) -> MlclassifyperceptronFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_frame_fill(s : MlclassifyperceptronFrame, v : Double) -> MlclassifyperceptronFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_frame_min(s : MlclassifyperceptronFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_frame_max(s : MlclassifyperceptronFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_frame_to_string(s : MlclassifyperceptronFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_table_make(size : Int) -> MlclassifyperceptronTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_table_len(s : MlclassifyperceptronTable) -> Int { s.size }

pub fn ml_classify_perceptron_table_get(s : MlclassifyperceptronTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_table_set(s : MlclassifyperceptronTable, i : Int, v : Double) -> MlclassifyperceptronTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_table_sum(s : MlclassifyperceptronTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_table_mean(s : MlclassifyperceptronTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_table_scale(s : MlclassifyperceptronTable, f : Double) -> MlclassifyperceptronTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_table_add(a : MlclassifyperceptronTable, b : MlclassifyperceptronTable) -> MlclassifyperceptronTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_table_copy(s : MlclassifyperceptronTable) -> MlclassifyperceptronTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_table_fill(s : MlclassifyperceptronTable, v : Double) -> MlclassifyperceptronTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_table_min(s : MlclassifyperceptronTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_table_max(s : MlclassifyperceptronTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_table_to_string(s : MlclassifyperceptronTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_graphn_make(size : Int) -> MlclassifyperceptronGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_graphn_len(s : MlclassifyperceptronGraphN) -> Int { s.size }

pub fn ml_classify_perceptron_graphn_get(s : MlclassifyperceptronGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_graphn_set(s : MlclassifyperceptronGraphN, i : Int, v : Double) -> MlclassifyperceptronGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_graphn_sum(s : MlclassifyperceptronGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_graphn_mean(s : MlclassifyperceptronGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_graphn_scale(s : MlclassifyperceptronGraphN, f : Double) -> MlclassifyperceptronGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_graphn_add(a : MlclassifyperceptronGraphN, b : MlclassifyperceptronGraphN) -> MlclassifyperceptronGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_graphn_copy(s : MlclassifyperceptronGraphN) -> MlclassifyperceptronGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_graphn_fill(s : MlclassifyperceptronGraphN, v : Double) -> MlclassifyperceptronGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_graphn_min(s : MlclassifyperceptronGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_graphn_max(s : MlclassifyperceptronGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_graphn_to_string(s : MlclassifyperceptronGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_node_make(size : Int) -> MlclassifyperceptronNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_node_len(s : MlclassifyperceptronNode) -> Int { s.size }

pub fn ml_classify_perceptron_node_get(s : MlclassifyperceptronNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_node_set(s : MlclassifyperceptronNode, i : Int, v : Double) -> MlclassifyperceptronNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_node_sum(s : MlclassifyperceptronNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_node_mean(s : MlclassifyperceptronNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_node_scale(s : MlclassifyperceptronNode, f : Double) -> MlclassifyperceptronNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_node_add(a : MlclassifyperceptronNode, b : MlclassifyperceptronNode) -> MlclassifyperceptronNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_node_copy(s : MlclassifyperceptronNode) -> MlclassifyperceptronNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_node_fill(s : MlclassifyperceptronNode, v : Double) -> MlclassifyperceptronNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_node_min(s : MlclassifyperceptronNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_node_max(s : MlclassifyperceptronNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_node_to_string(s : MlclassifyperceptronNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_edge_make(size : Int) -> MlclassifyperceptronEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_edge_len(s : MlclassifyperceptronEdge) -> Int { s.size }

pub fn ml_classify_perceptron_edge_get(s : MlclassifyperceptronEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_edge_set(s : MlclassifyperceptronEdge, i : Int, v : Double) -> MlclassifyperceptronEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_edge_sum(s : MlclassifyperceptronEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_edge_mean(s : MlclassifyperceptronEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_edge_scale(s : MlclassifyperceptronEdge, f : Double) -> MlclassifyperceptronEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_edge_add(a : MlclassifyperceptronEdge, b : MlclassifyperceptronEdge) -> MlclassifyperceptronEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_edge_copy(s : MlclassifyperceptronEdge) -> MlclassifyperceptronEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_edge_fill(s : MlclassifyperceptronEdge, v : Double) -> MlclassifyperceptronEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_edge_min(s : MlclassifyperceptronEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_edge_max(s : MlclassifyperceptronEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_edge_to_string(s : MlclassifyperceptronEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_path_make(size : Int) -> MlclassifyperceptronPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_path_len(s : MlclassifyperceptronPath) -> Int { s.size }

pub fn ml_classify_perceptron_path_get(s : MlclassifyperceptronPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_path_set(s : MlclassifyperceptronPath, i : Int, v : Double) -> MlclassifyperceptronPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_path_sum(s : MlclassifyperceptronPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_path_mean(s : MlclassifyperceptronPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_path_scale(s : MlclassifyperceptronPath, f : Double) -> MlclassifyperceptronPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_path_add(a : MlclassifyperceptronPath, b : MlclassifyperceptronPath) -> MlclassifyperceptronPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_path_copy(s : MlclassifyperceptronPath) -> MlclassifyperceptronPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_path_fill(s : MlclassifyperceptronPath, v : Double) -> MlclassifyperceptronPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_path_min(s : MlclassifyperceptronPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_path_max(s : MlclassifyperceptronPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_path_to_string(s : MlclassifyperceptronPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_cluster_make(size : Int) -> MlclassifyperceptronCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_cluster_len(s : MlclassifyperceptronCluster) -> Int { s.size }

pub fn ml_classify_perceptron_cluster_get(s : MlclassifyperceptronCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_cluster_set(s : MlclassifyperceptronCluster, i : Int, v : Double) -> MlclassifyperceptronCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cluster_sum(s : MlclassifyperceptronCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_cluster_mean(s : MlclassifyperceptronCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_cluster_scale(s : MlclassifyperceptronCluster, f : Double) -> MlclassifyperceptronCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cluster_add(a : MlclassifyperceptronCluster, b : MlclassifyperceptronCluster) -> MlclassifyperceptronCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_cluster_copy(s : MlclassifyperceptronCluster) -> MlclassifyperceptronCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cluster_fill(s : MlclassifyperceptronCluster, v : Double) -> MlclassifyperceptronCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cluster_min(s : MlclassifyperceptronCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_cluster_max(s : MlclassifyperceptronCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_cluster_to_string(s : MlclassifyperceptronCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_model_make(size : Int) -> MlclassifyperceptronModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_model_len(s : MlclassifyperceptronModel) -> Int { s.size }

pub fn ml_classify_perceptron_model_get(s : MlclassifyperceptronModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_model_set(s : MlclassifyperceptronModel, i : Int, v : Double) -> MlclassifyperceptronModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_model_sum(s : MlclassifyperceptronModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_model_mean(s : MlclassifyperceptronModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_model_scale(s : MlclassifyperceptronModel, f : Double) -> MlclassifyperceptronModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_model_add(a : MlclassifyperceptronModel, b : MlclassifyperceptronModel) -> MlclassifyperceptronModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_model_copy(s : MlclassifyperceptronModel) -> MlclassifyperceptronModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_model_fill(s : MlclassifyperceptronModel, v : Double) -> MlclassifyperceptronModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_model_min(s : MlclassifyperceptronModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_model_max(s : MlclassifyperceptronModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_model_to_string(s : MlclassifyperceptronModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_layer_make(size : Int) -> MlclassifyperceptronLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_layer_len(s : MlclassifyperceptronLayer) -> Int { s.size }

pub fn ml_classify_perceptron_layer_get(s : MlclassifyperceptronLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_layer_set(s : MlclassifyperceptronLayer, i : Int, v : Double) -> MlclassifyperceptronLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_layer_sum(s : MlclassifyperceptronLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_layer_mean(s : MlclassifyperceptronLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_layer_scale(s : MlclassifyperceptronLayer, f : Double) -> MlclassifyperceptronLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_layer_add(a : MlclassifyperceptronLayer, b : MlclassifyperceptronLayer) -> MlclassifyperceptronLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_layer_copy(s : MlclassifyperceptronLayer) -> MlclassifyperceptronLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_layer_fill(s : MlclassifyperceptronLayer, v : Double) -> MlclassifyperceptronLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_layer_min(s : MlclassifyperceptronLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_layer_max(s : MlclassifyperceptronLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_layer_to_string(s : MlclassifyperceptronLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_buffer_make(size : Int) -> MlclassifyperceptronBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_buffer_len(s : MlclassifyperceptronBuffer) -> Int { s.size }

pub fn ml_classify_perceptron_buffer_get(s : MlclassifyperceptronBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_buffer_set(s : MlclassifyperceptronBuffer, i : Int, v : Double) -> MlclassifyperceptronBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_buffer_sum(s : MlclassifyperceptronBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_buffer_mean(s : MlclassifyperceptronBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_buffer_scale(s : MlclassifyperceptronBuffer, f : Double) -> MlclassifyperceptronBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_buffer_add(a : MlclassifyperceptronBuffer, b : MlclassifyperceptronBuffer) -> MlclassifyperceptronBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_buffer_copy(s : MlclassifyperceptronBuffer) -> MlclassifyperceptronBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_buffer_fill(s : MlclassifyperceptronBuffer, v : Double) -> MlclassifyperceptronBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_buffer_min(s : MlclassifyperceptronBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_buffer_max(s : MlclassifyperceptronBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_buffer_to_string(s : MlclassifyperceptronBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_cursor_make(size : Int) -> MlclassifyperceptronCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_cursor_len(s : MlclassifyperceptronCursor) -> Int { s.size }

pub fn ml_classify_perceptron_cursor_get(s : MlclassifyperceptronCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_cursor_set(s : MlclassifyperceptronCursor, i : Int, v : Double) -> MlclassifyperceptronCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cursor_sum(s : MlclassifyperceptronCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_cursor_mean(s : MlclassifyperceptronCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_cursor_scale(s : MlclassifyperceptronCursor, f : Double) -> MlclassifyperceptronCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cursor_add(a : MlclassifyperceptronCursor, b : MlclassifyperceptronCursor) -> MlclassifyperceptronCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_cursor_copy(s : MlclassifyperceptronCursor) -> MlclassifyperceptronCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cursor_fill(s : MlclassifyperceptronCursor, v : Double) -> MlclassifyperceptronCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_cursor_min(s : MlclassifyperceptronCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_cursor_max(s : MlclassifyperceptronCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_cursor_to_string(s : MlclassifyperceptronCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_view_make(size : Int) -> MlclassifyperceptronView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_view_len(s : MlclassifyperceptronView) -> Int { s.size }

pub fn ml_classify_perceptron_view_get(s : MlclassifyperceptronView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_view_set(s : MlclassifyperceptronView, i : Int, v : Double) -> MlclassifyperceptronView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_view_sum(s : MlclassifyperceptronView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_view_mean(s : MlclassifyperceptronView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_view_scale(s : MlclassifyperceptronView, f : Double) -> MlclassifyperceptronView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_view_add(a : MlclassifyperceptronView, b : MlclassifyperceptronView) -> MlclassifyperceptronView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_view_copy(s : MlclassifyperceptronView) -> MlclassifyperceptronView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_view_fill(s : MlclassifyperceptronView, v : Double) -> MlclassifyperceptronView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_view_min(s : MlclassifyperceptronView) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_view_max(s : MlclassifyperceptronView) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_view_to_string(s : MlclassifyperceptronView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_range_make(size : Int) -> MlclassifyperceptronRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_range_len(s : MlclassifyperceptronRange) -> Int { s.size }

pub fn ml_classify_perceptron_range_get(s : MlclassifyperceptronRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_range_set(s : MlclassifyperceptronRange, i : Int, v : Double) -> MlclassifyperceptronRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_range_sum(s : MlclassifyperceptronRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_range_mean(s : MlclassifyperceptronRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_range_scale(s : MlclassifyperceptronRange, f : Double) -> MlclassifyperceptronRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_range_add(a : MlclassifyperceptronRange, b : MlclassifyperceptronRange) -> MlclassifyperceptronRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_range_copy(s : MlclassifyperceptronRange) -> MlclassifyperceptronRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_range_fill(s : MlclassifyperceptronRange, v : Double) -> MlclassifyperceptronRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_range_min(s : MlclassifyperceptronRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_range_max(s : MlclassifyperceptronRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_range_to_string(s : MlclassifyperceptronRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_slice_make(size : Int) -> MlclassifyperceptronSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_slice_len(s : MlclassifyperceptronSlice) -> Int { s.size }

pub fn ml_classify_perceptron_slice_get(s : MlclassifyperceptronSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_slice_set(s : MlclassifyperceptronSlice, i : Int, v : Double) -> MlclassifyperceptronSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_slice_sum(s : MlclassifyperceptronSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_perceptron_slice_mean(s : MlclassifyperceptronSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_perceptron_slice_scale(s : MlclassifyperceptronSlice, f : Double) -> MlclassifyperceptronSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_slice_add(a : MlclassifyperceptronSlice, b : MlclassifyperceptronSlice) -> MlclassifyperceptronSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_perceptron_slice_copy(s : MlclassifyperceptronSlice) -> MlclassifyperceptronSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_slice_fill(s : MlclassifyperceptronSlice, v : Double) -> MlclassifyperceptronSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_perceptron_slice_min(s : MlclassifyperceptronSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_perceptron_slice_max(s : MlclassifyperceptronSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_perceptron_slice_to_string(s : MlclassifyperceptronSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

