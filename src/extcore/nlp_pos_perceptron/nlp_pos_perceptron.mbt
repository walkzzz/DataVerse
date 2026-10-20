///===
/// extcore/nlp_pos_perceptron

pub(all) struct NlpposperceptronPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_perceptron_make_point(x : Double, y : Double) -> NlpposperceptronPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_perceptron_make_point3(x : Double, y : Double, z : Double) -> NlpposperceptronPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposperceptronPoint::x(self : NlpposperceptronPoint) -> Double { self.x }

pub fn NlpposperceptronPoint::y(self : NlpposperceptronPoint) -> Double { self.y }

pub fn NlpposperceptronPoint::z(self : NlpposperceptronPoint) -> Double { self.z }

pub fn NlpposperceptronPoint::label(self : NlpposperceptronPoint) -> Int { self.label }

pub fn NlpposperceptronPoint::dist(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposperceptronPoint::add(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposperceptronPoint::sub(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposperceptronPoint::scale(self : NlpposperceptronPoint, s : Double) -> NlpposperceptronPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposperceptronPoint::dot(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposperceptronPoint::cross(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposperceptronPoint::norm(self : NlpposperceptronPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposperceptronPoint::normalize(self : NlpposperceptronPoint) -> NlpposperceptronPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposperceptronPoint::negate(self : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposperceptronPoint::mid(self : NlpposperceptronPoint, other : NlpposperceptronPoint) -> NlpposperceptronPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposperceptronPoint::lerp(self : NlpposperceptronPoint, other : NlpposperceptronPoint, t : Double) -> NlpposperceptronPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposperceptronPoint::to_string(self : NlpposperceptronPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposperceptronSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_perceptron_make_series(vals : Array[Double], name : String) -> NlpposperceptronSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposperceptronSeries::len(self : NlpposperceptronSeries) -> Int { self.vals.length() }

pub fn NlpposperceptronSeries::sum(self : NlpposperceptronSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposperceptronSeries::mean(self : NlpposperceptronSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposperceptronSeries::min(self : NlpposperceptronSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposperceptronSeries::max(self : NlpposperceptronSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposperceptronSeries::range(self : NlpposperceptronSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposperceptronSeries::variance(self : NlpposperceptronSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposperceptronSeries::std(self : NlpposperceptronSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposperceptronSeries::median(self : NlpposperceptronSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposperceptronSeries::scale(self : NlpposperceptronSeries, f : Double) -> NlpposperceptronSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposperceptronSeries::add(self : NlpposperceptronSeries, other : NlpposperceptronSeries) -> NlpposperceptronSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposperceptronSeries::sub(self : NlpposperceptronSeries, other : NlpposperceptronSeries) -> NlpposperceptronSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposperceptronSeries::normalize(self : NlpposperceptronSeries) -> NlpposperceptronSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposperceptronSeries::cumsum(self : NlpposperceptronSeries) -> NlpposperceptronSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposperceptronSeries::to_string(self : NlpposperceptronSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposperceptronMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_perceptron_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposperceptronMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_perceptron_matrix_identity(n : Int) -> NlpposperceptronMatrix {
  let m = nlp_pos_perceptron_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposperceptronMatrix::get(self : NlpposperceptronMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposperceptronMatrix::transpose(self : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  let result = nlp_pos_perceptron_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposperceptronMatrix::add(self : NlpposperceptronMatrix, other : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposperceptronMatrix::scale(self : NlpposperceptronMatrix, s : Double) -> NlpposperceptronMatrix {
  let result = nlp_pos_perceptron_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposperceptronMatrix::multiply(self : NlpposperceptronMatrix, other : NlpposperceptronMatrix) -> NlpposperceptronMatrix {
  if self.cols != other.rows { return nlp_pos_perceptron_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_perceptron_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposperceptronMatrix::trace(self : NlpposperceptronMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposperceptronMatrix::det(self : NlpposperceptronMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposperceptronMatrix::norm(self : NlpposperceptronMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposperceptronMatrix::to_string(self : NlpposperceptronMatrix) -> String {
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

pub(all) struct NlpposperceptronVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_perceptron_make_vector(comps : Array[Double]) -> NlpposperceptronVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_perceptron_vector_zero(dim : Int) -> NlpposperceptronVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposperceptronVector::add(self : NlpposperceptronVector, other : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposperceptronVector::sub(self : NlpposperceptronVector, other : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposperceptronVector::scale(self : NlpposperceptronVector, s : Double) -> NlpposperceptronVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposperceptronVector::dot(self : NlpposperceptronVector, other : NlpposperceptronVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposperceptronVector::norm(self : NlpposperceptronVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposperceptronVector::normalize(self : NlpposperceptronVector) -> NlpposperceptronVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposperceptronVector::dist(self : NlpposperceptronVector, other : NlpposperceptronVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposperceptronVector::to_string(self : NlpposperceptronVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_perceptron_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_perceptron_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_perceptron_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_perceptron_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_perceptron_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_perceptron_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_perceptron_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_perceptron_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_perceptron_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_perceptron_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_perceptron_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_perceptron_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_perceptron_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_perceptron_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_perceptron_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_perceptron_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_perceptron_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_perceptron_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_perceptron_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_perceptron_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_perceptron_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_perceptron_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_perceptron_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_perceptron_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_perceptron_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_perceptron_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_perceptron_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_perceptron_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_perceptron_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposperceptronFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_frame_make(size : Int) -> NlpposperceptronFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_frame_len(s : NlpposperceptronFrame) -> Int { s.size }

pub fn nlp_pos_perceptron_frame_get(s : NlpposperceptronFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_frame_set(s : NlpposperceptronFrame, i : Int, v : Double) -> NlpposperceptronFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_frame_sum(s : NlpposperceptronFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_frame_mean(s : NlpposperceptronFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_frame_scale(s : NlpposperceptronFrame, f : Double) -> NlpposperceptronFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_frame_add(a : NlpposperceptronFrame, b : NlpposperceptronFrame) -> NlpposperceptronFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_frame_copy(s : NlpposperceptronFrame) -> NlpposperceptronFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_frame_fill(s : NlpposperceptronFrame, v : Double) -> NlpposperceptronFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_frame_min(s : NlpposperceptronFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_frame_max(s : NlpposperceptronFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_frame_to_string(s : NlpposperceptronFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_table_make(size : Int) -> NlpposperceptronTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_table_len(s : NlpposperceptronTable) -> Int { s.size }

pub fn nlp_pos_perceptron_table_get(s : NlpposperceptronTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_table_set(s : NlpposperceptronTable, i : Int, v : Double) -> NlpposperceptronTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_table_sum(s : NlpposperceptronTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_table_mean(s : NlpposperceptronTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_table_scale(s : NlpposperceptronTable, f : Double) -> NlpposperceptronTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_table_add(a : NlpposperceptronTable, b : NlpposperceptronTable) -> NlpposperceptronTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_table_copy(s : NlpposperceptronTable) -> NlpposperceptronTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_table_fill(s : NlpposperceptronTable, v : Double) -> NlpposperceptronTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_table_min(s : NlpposperceptronTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_table_max(s : NlpposperceptronTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_table_to_string(s : NlpposperceptronTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_graphn_make(size : Int) -> NlpposperceptronGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_graphn_len(s : NlpposperceptronGraphN) -> Int { s.size }

pub fn nlp_pos_perceptron_graphn_get(s : NlpposperceptronGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_graphn_set(s : NlpposperceptronGraphN, i : Int, v : Double) -> NlpposperceptronGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_graphn_sum(s : NlpposperceptronGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_graphn_mean(s : NlpposperceptronGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_graphn_scale(s : NlpposperceptronGraphN, f : Double) -> NlpposperceptronGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_graphn_add(a : NlpposperceptronGraphN, b : NlpposperceptronGraphN) -> NlpposperceptronGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_graphn_copy(s : NlpposperceptronGraphN) -> NlpposperceptronGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_graphn_fill(s : NlpposperceptronGraphN, v : Double) -> NlpposperceptronGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_graphn_min(s : NlpposperceptronGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_graphn_max(s : NlpposperceptronGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_graphn_to_string(s : NlpposperceptronGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_node_make(size : Int) -> NlpposperceptronNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_node_len(s : NlpposperceptronNode) -> Int { s.size }

pub fn nlp_pos_perceptron_node_get(s : NlpposperceptronNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_node_set(s : NlpposperceptronNode, i : Int, v : Double) -> NlpposperceptronNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_node_sum(s : NlpposperceptronNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_node_mean(s : NlpposperceptronNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_node_scale(s : NlpposperceptronNode, f : Double) -> NlpposperceptronNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_node_add(a : NlpposperceptronNode, b : NlpposperceptronNode) -> NlpposperceptronNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_node_copy(s : NlpposperceptronNode) -> NlpposperceptronNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_node_fill(s : NlpposperceptronNode, v : Double) -> NlpposperceptronNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_node_min(s : NlpposperceptronNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_node_max(s : NlpposperceptronNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_node_to_string(s : NlpposperceptronNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_edge_make(size : Int) -> NlpposperceptronEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_edge_len(s : NlpposperceptronEdge) -> Int { s.size }

pub fn nlp_pos_perceptron_edge_get(s : NlpposperceptronEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_edge_set(s : NlpposperceptronEdge, i : Int, v : Double) -> NlpposperceptronEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_edge_sum(s : NlpposperceptronEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_edge_mean(s : NlpposperceptronEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_edge_scale(s : NlpposperceptronEdge, f : Double) -> NlpposperceptronEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_edge_add(a : NlpposperceptronEdge, b : NlpposperceptronEdge) -> NlpposperceptronEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_edge_copy(s : NlpposperceptronEdge) -> NlpposperceptronEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_edge_fill(s : NlpposperceptronEdge, v : Double) -> NlpposperceptronEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_edge_min(s : NlpposperceptronEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_edge_max(s : NlpposperceptronEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_edge_to_string(s : NlpposperceptronEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_path_make(size : Int) -> NlpposperceptronPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_path_len(s : NlpposperceptronPath) -> Int { s.size }

pub fn nlp_pos_perceptron_path_get(s : NlpposperceptronPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_path_set(s : NlpposperceptronPath, i : Int, v : Double) -> NlpposperceptronPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_path_sum(s : NlpposperceptronPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_path_mean(s : NlpposperceptronPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_path_scale(s : NlpposperceptronPath, f : Double) -> NlpposperceptronPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_path_add(a : NlpposperceptronPath, b : NlpposperceptronPath) -> NlpposperceptronPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_path_copy(s : NlpposperceptronPath) -> NlpposperceptronPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_path_fill(s : NlpposperceptronPath, v : Double) -> NlpposperceptronPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_path_min(s : NlpposperceptronPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_path_max(s : NlpposperceptronPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_path_to_string(s : NlpposperceptronPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_cluster_make(size : Int) -> NlpposperceptronCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_cluster_len(s : NlpposperceptronCluster) -> Int { s.size }

pub fn nlp_pos_perceptron_cluster_get(s : NlpposperceptronCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_cluster_set(s : NlpposperceptronCluster, i : Int, v : Double) -> NlpposperceptronCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cluster_sum(s : NlpposperceptronCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_cluster_mean(s : NlpposperceptronCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_cluster_scale(s : NlpposperceptronCluster, f : Double) -> NlpposperceptronCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cluster_add(a : NlpposperceptronCluster, b : NlpposperceptronCluster) -> NlpposperceptronCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_cluster_copy(s : NlpposperceptronCluster) -> NlpposperceptronCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cluster_fill(s : NlpposperceptronCluster, v : Double) -> NlpposperceptronCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cluster_min(s : NlpposperceptronCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_cluster_max(s : NlpposperceptronCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_cluster_to_string(s : NlpposperceptronCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_model_make(size : Int) -> NlpposperceptronModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_model_len(s : NlpposperceptronModel) -> Int { s.size }

pub fn nlp_pos_perceptron_model_get(s : NlpposperceptronModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_model_set(s : NlpposperceptronModel, i : Int, v : Double) -> NlpposperceptronModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_model_sum(s : NlpposperceptronModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_model_mean(s : NlpposperceptronModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_model_scale(s : NlpposperceptronModel, f : Double) -> NlpposperceptronModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_model_add(a : NlpposperceptronModel, b : NlpposperceptronModel) -> NlpposperceptronModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_model_copy(s : NlpposperceptronModel) -> NlpposperceptronModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_model_fill(s : NlpposperceptronModel, v : Double) -> NlpposperceptronModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_model_min(s : NlpposperceptronModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_model_max(s : NlpposperceptronModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_model_to_string(s : NlpposperceptronModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_layer_make(size : Int) -> NlpposperceptronLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_layer_len(s : NlpposperceptronLayer) -> Int { s.size }

pub fn nlp_pos_perceptron_layer_get(s : NlpposperceptronLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_layer_set(s : NlpposperceptronLayer, i : Int, v : Double) -> NlpposperceptronLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_layer_sum(s : NlpposperceptronLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_layer_mean(s : NlpposperceptronLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_layer_scale(s : NlpposperceptronLayer, f : Double) -> NlpposperceptronLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_layer_add(a : NlpposperceptronLayer, b : NlpposperceptronLayer) -> NlpposperceptronLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_layer_copy(s : NlpposperceptronLayer) -> NlpposperceptronLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_layer_fill(s : NlpposperceptronLayer, v : Double) -> NlpposperceptronLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_layer_min(s : NlpposperceptronLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_layer_max(s : NlpposperceptronLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_layer_to_string(s : NlpposperceptronLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_buffer_make(size : Int) -> NlpposperceptronBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_buffer_len(s : NlpposperceptronBuffer) -> Int { s.size }

pub fn nlp_pos_perceptron_buffer_get(s : NlpposperceptronBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_buffer_set(s : NlpposperceptronBuffer, i : Int, v : Double) -> NlpposperceptronBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_buffer_sum(s : NlpposperceptronBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_buffer_mean(s : NlpposperceptronBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_buffer_scale(s : NlpposperceptronBuffer, f : Double) -> NlpposperceptronBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_buffer_add(a : NlpposperceptronBuffer, b : NlpposperceptronBuffer) -> NlpposperceptronBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_buffer_copy(s : NlpposperceptronBuffer) -> NlpposperceptronBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_buffer_fill(s : NlpposperceptronBuffer, v : Double) -> NlpposperceptronBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_buffer_min(s : NlpposperceptronBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_buffer_max(s : NlpposperceptronBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_buffer_to_string(s : NlpposperceptronBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_cursor_make(size : Int) -> NlpposperceptronCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_cursor_len(s : NlpposperceptronCursor) -> Int { s.size }

pub fn nlp_pos_perceptron_cursor_get(s : NlpposperceptronCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_cursor_set(s : NlpposperceptronCursor, i : Int, v : Double) -> NlpposperceptronCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cursor_sum(s : NlpposperceptronCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_cursor_mean(s : NlpposperceptronCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_cursor_scale(s : NlpposperceptronCursor, f : Double) -> NlpposperceptronCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cursor_add(a : NlpposperceptronCursor, b : NlpposperceptronCursor) -> NlpposperceptronCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_cursor_copy(s : NlpposperceptronCursor) -> NlpposperceptronCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cursor_fill(s : NlpposperceptronCursor, v : Double) -> NlpposperceptronCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_cursor_min(s : NlpposperceptronCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_cursor_max(s : NlpposperceptronCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_cursor_to_string(s : NlpposperceptronCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_view_make(size : Int) -> NlpposperceptronView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_view_len(s : NlpposperceptronView) -> Int { s.size }

pub fn nlp_pos_perceptron_view_get(s : NlpposperceptronView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_view_set(s : NlpposperceptronView, i : Int, v : Double) -> NlpposperceptronView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_view_sum(s : NlpposperceptronView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_view_mean(s : NlpposperceptronView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_view_scale(s : NlpposperceptronView, f : Double) -> NlpposperceptronView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_view_add(a : NlpposperceptronView, b : NlpposperceptronView) -> NlpposperceptronView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_view_copy(s : NlpposperceptronView) -> NlpposperceptronView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_view_fill(s : NlpposperceptronView, v : Double) -> NlpposperceptronView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_view_min(s : NlpposperceptronView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_view_max(s : NlpposperceptronView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_view_to_string(s : NlpposperceptronView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_range_make(size : Int) -> NlpposperceptronRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_range_len(s : NlpposperceptronRange) -> Int { s.size }

pub fn nlp_pos_perceptron_range_get(s : NlpposperceptronRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_range_set(s : NlpposperceptronRange, i : Int, v : Double) -> NlpposperceptronRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_range_sum(s : NlpposperceptronRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_range_mean(s : NlpposperceptronRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_range_scale(s : NlpposperceptronRange, f : Double) -> NlpposperceptronRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_range_add(a : NlpposperceptronRange, b : NlpposperceptronRange) -> NlpposperceptronRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_range_copy(s : NlpposperceptronRange) -> NlpposperceptronRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_range_fill(s : NlpposperceptronRange, v : Double) -> NlpposperceptronRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_range_min(s : NlpposperceptronRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_range_max(s : NlpposperceptronRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_range_to_string(s : NlpposperceptronRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposperceptronSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_perceptron_slice_make(size : Int) -> NlpposperceptronSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_perceptron_slice_len(s : NlpposperceptronSlice) -> Int { s.size }

pub fn nlp_pos_perceptron_slice_get(s : NlpposperceptronSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_perceptron_slice_set(s : NlpposperceptronSlice, i : Int, v : Double) -> NlpposperceptronSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_slice_sum(s : NlpposperceptronSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_perceptron_slice_mean(s : NlpposperceptronSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_perceptron_slice_scale(s : NlpposperceptronSlice, f : Double) -> NlpposperceptronSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_slice_add(a : NlpposperceptronSlice, b : NlpposperceptronSlice) -> NlpposperceptronSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_perceptron_slice_copy(s : NlpposperceptronSlice) -> NlpposperceptronSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_slice_fill(s : NlpposperceptronSlice, v : Double) -> NlpposperceptronSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_perceptron_slice_min(s : NlpposperceptronSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_perceptron_slice_max(s : NlpposperceptronSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_perceptron_slice_to_string(s : NlpposperceptronSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

